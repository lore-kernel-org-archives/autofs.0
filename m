From: Jeffrey Layton <jtlayton@poochiereds.net>
Subject: Re: replicated mounts patch
Date: Tue, 19 Apr 2005 16:08:58 -0400
Message-ID: <1113941338.1274.79.camel@barsoom.rdu.redhat.com>
References: <1113875877.4581.15.camel@tleilax.poochiereds.net>
	<1113912312.1274.26.camel@barsoom.rdu.redhat.com>
	<Pine.LNX.4.62.0504200053250.8587@donald.themaw.net>
	<1113933871.1274.56.camel@barsoom.rdu.redhat.com>
	<16997.22261.125769.972792@segfault.boston.redhat.com>
	<1113940219.1274.70.camel@barsoom.rdu.redhat.com>
	<16997.25295.980046.503116@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16997.25295.980046.503116@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: jmoyer@redhat.com
Cc: autofs@linux.kernel.org, raven@themaw.net

> If the documentation for the Linux automounter conflicts with that of Sun,
> I would say it is a bug.  Let's fix it.
> 
> -Jeff
> 

Ahh, I didn't check the Solaris docs. Yes, README.replicated_mounts is
definitely incorrect then. If/when this patch goes in, I'll plan to
rewrite that as well to explain the new code.

In any case, here's an updated patch (for real this time) that changes
the default weight to zero (I goofed on posting the last patch and it
wasn't changed correctly there):

---------------[snip]--------------

--- modules/mount_nfs.c.orig	2005-04-18 14:06:06.000000000 -0400
+++ modules/mount_nfs.c	2005-04-19 15:59:34.000000000 -0400
@@ -6,6 +6,7 @@
  *
  *   Copyright 1997 Transmeta Corporation - All Rights Reserved
  *   Copyright 1999-2000 Jeremy Fitzhardinge <jeremy@goop.org>
+ *   Copyright 2005 Jeff Layton/Red Hat <jlayton@redhat.com>
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -24,19 +25,61 @@
 #include <stdlib.h>
 #include <syslog.h>
 #include <string.h>
+#include <stdlib.h>
+#include <netinet/in.h>
 #include <sys/param.h>
+#include <sys/queue.h>
 #include <sys/socket.h>
-#include <sys/types.h>
 #include <sys/stat.h>
-#include <netinet/in.h>
+#include <sys/types.h>
 #include <linux/nfs.h>
 #include <linux/nfs2.h>
+#include <linux/nfs3.h>
 
 #define MODULE_MOUNT
 #include "automount.h"
 
 #define MODPREFIX "mount(nfs): "
 
+/*
+ * FIXME: this should really be determined dynamically, though this should be
+ * large enough for any sane use of autofs.
+*/
+#define MAX_REPL_MOUNTS 128
+
+/* Short timeout for RPC pings */
+#define SHORT_SEC  0
+#define SHORT_USEC 100000
+
+/* Long timeout for RPC pings */
+#define LONG_SEC  10
+#define LONG_USEC 0
+
+/* ping status enum */
+enum pingstat
+{
+	NOTPINGED = 0,
+	SHORT_TIMEO = 1,
+	LONG_TIMEO = 2,
+	SUCCESS = 3
+};
+
+/* define a structure for encapsulating an nfs mount */
+struct nfs_mount
+{
+	char *host;
+	char *path;
+	int weight;
+	int local;
+	int bind;
+	int pingstat;
+	double pingtime;
+	LIST_ENTRY(nfs_mount) entries;
+};
+
+/* list head struct definition for nfs_mount linked list */
+LIST_HEAD(listhead, nfs_mount);
+
 int mount_version = AUTOFS_MOUNT_VERSION;	/* Required by protocol */
 
 static int udpproto;
@@ -57,16 +100,18 @@
 	if (port_dis)
 		port_discard = port_dis->s_port;
 	else
-		port_discard = htons(9);	/* 9 is the standard discard port */
+		port_discard = htons(9);	/* 9 is the standard discard
+						   port */
 
-	/* Make sure we have the local mount method available */
+	/* Make sure we have the bind mount method available */
 	if (!mount_bind)
 		mount_bind = open_mount("bind", MODPREFIX);
 
 	return !mount_bind;
 }
 
-int is_local_addr(const char *host, const char *host_addr, int addr_len)
+/* check to see if the server's address is an address on the client itself */
+int is_bind_addr(const char *host, const char *host_addr, int addr_len)
 {
 	struct sockaddr_in src_addr, local_addr;
 	int src_len = sizeof(src_addr);
@@ -84,7 +129,7 @@
 	src_addr.sin_port = port_discard;
 
 	ret = connect(sock, (struct sockaddr *) &src_addr, src_len);
-	if (ret < 0 ) {
+	if (ret < 0) {
 		error(MODPREFIX "connect failed for %s: %m", host);
 		close(sock);
 		return 0;
@@ -102,247 +147,390 @@
 	ret = memcmp(&src_addr.sin_addr, &local_addr.sin_addr, addr_len);
 	if (ret)
 		return 0;
-	
+
 	return 1;
 }
+
+/* create an nfs_mount list entry */
+struct nfs_mount *create_nfs_mount_entry(char *host, char *path, int bind)
+{
+	struct nfs_mount *entry;
+	entry = calloc(1, sizeof(struct nfs_mount));
+	if (!entry) {
+		error(MODPREFIX "calloc: %m");
+		return NULL;
+	}
+	entry->host = host;
+	entry->path = path;
+	entry->bind = bind;
+	entry->weight = 0;
+	entry->pingstat = NOTPINGED;
+	entry->pingtime = 0;
+	entry->entries.le_next=NULL;
+	entry->entries.le_prev=NULL;
+	return entry;
+}
+
 /*
- * Given a mount string, return (in the same string) the
- * best mount to use based on weight/locality/rpctime
- * - return -1 and what = '\0' on error,
- *           1 and what = local mount path if local bind,
- *     else  0 and what = remote mount path
+ * Given a copy of the mount string (p) and a pointer to a nfs_mount struct
+ * (listhead), parse the mount string and populate a linked list with
+ * nfs_mount structs. Return 1 on error and 0 on success. 
  */
-int get_best_mount(char *what, const char *original, int longtimeout, int skiplocal)
+int parse_mount_string(char *p, struct listhead *nfs_mount_head)
 {
-	char *p = what;
-	char *winner = NULL;
-	int winner_weight = INT_MAX, local = 0;
-	double winner_time = 0;
 	char *delim;
-	int sec = (longtimeout) ? 10 : 0;
-	int micros = (longtimeout) ? 0 : 100000;
-
-	if (!p) {
-		*what = '\0';
-		return -1;
-	}
+	char *entity[MAX_REPL_MOUNTS];
+	char *currentpath = "";
+	int i, numwords = 0;	/* number of whitespace separated words */
+	struct nfs_mount *currentmount = NULL;
 
+	/* break up mountstring into whitespace separated pieces */
 	while (p && *p) {
-		char *next;
-		unsigned int ping_stat = 0;
-
-		p += strspn(p, " \t,");
-		delim = strpbrk(p, "(, \t:");
-		if (!delim)
+		p += strspn(p, " \t");
+		delim = strpbrk(p, " \t");
+		if (delim) {
+			*delim = '\0';
+			entity[numwords] = p;
+			p = ++delim;
+		} else {
+			entity[numwords] = p;
 			break;
+		}
+		++numwords;
+	}
 
-		/* Find lowest weight whose server is alive */
-		if (*delim == '(') {
-			char *weight = delim + 1;
-			unsigned int alive;
-
+	/* now, deal with each whitespace separated chunk in turn */
+	for (i = 0; i <= numwords; ++i) {
+		p = entity[i];
+		debug(MODPREFIX "Working on %s", p);
+
+		/* get the path section out first -- everything to right of the 
+		   ':' */
+		delim = strpbrk(p, ":");
+		if (delim) {
 			*delim = '\0';
+			currentpath = ++delim;
+			/* if there is no ':', then treat this as a bind mount
+			   and move on to the next whitespace chunk */
+		} else {
+			currentmount =
+				create_nfs_mount_entry(NULL, p, 1);
 
-			delim = strchr(weight, ')');
-			if (delim) {
-				int w;
+			if (!currentmount)
+				return 1;
 
-				*delim = '\0';
-				w = atoi(weight);
+			LIST_INSERT_HEAD(nfs_mount_head,currentmount,entries);
 
-				alive = rpc_ping(p, sec, micros);
-				if (w < winner_weight && alive) {
-					winner_weight = w;
-					winner = p;
-				}
-			}
-			delim++;
+			break;
 		}
 
-		if (*delim == ':') {
-			*delim = '\0';
-			next = strpbrk(delim + 1, " \t");
-		} else if (*delim != '\0') {
-			*delim = '\0';
-			next = delim + 1;
-		} else
-			break;
 
-		/* p points to a server, "next is our next parse point */
-		if (!skiplocal) {
-			/* Check if it's localhost */
-			struct hostent *he;
-			char **haddr;
-
-			he = gethostbyname(p);
-			if (!he) {
-				error(MODPREFIX "host %s: lookup failure", p);
-				p = next;
-				continue;
-			}
+		/* now lets break up the host/weight section */
+		p = entity[i];
+		while (p && *p) {
+			currentmount =
+				create_nfs_mount_entry(p, currentpath, 0);
 
-			/* Check each host in round robin list */
-			for (haddr = he->h_addr_list; *haddr; haddr++) {
-				local = is_local_addr(p, *haddr, he->h_length);
-
-				if (local < 0)
-					continue;
-
-				if (local) {
-					winner = p;
-					break;
-				}
-			}
-			
-			if (local < 0) {
-				local = 0;
-				p = next;
-				continue;
-			}
+			if (!currentmount)
+				return 1;
 
-			if (local)
-				break;
-		}
+			LIST_INSERT_HEAD(nfs_mount_head,currentmount,entries);
 
-		/* ping each (or the) entry to see if it's alive. */
-		ping_stat = rpc_ping(p, sec, micros);
-		if (!ping_stat) {
-			p = next;
-			continue;
-		}
+			delim = strpbrk(p, ",(");
 
-		/* First unweighted or only host is alive so set winner */
-		if (!winner) {
-			winner = p;
-			/* No more to check, return it */
-			if (!next || !*next)
+			if (delim && *delim == ',') {
+				*delim = '\0';
+				p = ++delim;
+
+				/* if it's a ( then what follows is a weight */
+			} else if (delim && *delim == '(') {
+				*delim = '\0';
+				p = ++delim;
+				delim = strpbrk(p, ")");
+				if (!delim)
+					return 1;
+				*delim = '\0';
+				currentmount->weight = atoi(p);
+				p = ++delim;
+				p += strspn(p, ",");
+
+				/* no more delimiters, so end the inner loop
+				 * and move on to the next whitespace separated
+				 * chunk */
+			} else {
 				break;
+			}
 		}
+	}
 
-		/* Multiple entries and no weighted hosts so compare times */
-		if (winner_weight == INT_MAX) {
-			int status;
-			double resp_time;
-			unsigned int vers = NFS2_VERSION;
-			unsigned int proto = RPC_PING_UDP;
-
-			if (ping_stat) {
-				vers = ping_stat & 0x00ff;
-				proto = ping_stat & 0xff00;
-			}
+	return 0;
+}
 
-			status = rpc_time(p, vers, proto, sec, micros, &resp_time);
-			/* did we time the first winner? */
-			if (winner_time == 0) {
-				if (status) {
-					winner = p;
-					winner_time = resp_time;
-				} else
-					winner_time = 501;
-			} else {
-				if ((status) && (resp_time < winner_time)) {
-					winner = p;
-					winner_time = resp_time;
-				}
+/*
+ * compare linked list entry and it's following entry by "bindness" and swap
+ * them if necessary. Return true if there is a difference and set changed
+ * flag if we swapped them.
+ */
+int compare_bind (struct nfs_mount *n1,int *changed)
+{
+	struct nfs_mount *n2;
+	int difference = 0;
+
+	if (n1->entries.le_next) {
+		n2 = n1->entries.le_next;
+		if (n1->bind != n2->bind) {
+			difference = 1;
+			if (n2->bind > n1->bind) {
+				debug(MODPREFIX "bind swap: %s(%d) - %s(%d)",
+					n1->host,n1->bind,
+					n2->host,n2->bind);
+				LIST_REMOVE(n1, entries);
+				LIST_INSERT_AFTER(n2, n1, entries);
+				*changed = 1;
 			}
 		}
-		p = next;
 	}
+	return difference;
+}
 
-	debug(MODPREFIX "winner = %s local = %d", winner, local);
-
-	/*
-	 * We didn't find a weighted winner or local
-	 */
-	if (!local && winner_weight == INT_MAX) {
-		/* We had more than one contender and none responded in time */
-		if (winner_time != 0 && winner_time > 500) {
-			/* We've already tried a longer timeout */
-			if (!longtimeout) {
-				/* Reset string and try again */
-				strcpy(what, original);
-
-				debug(MODPREFIX 
-				      "all hosts timed out for '%s', "
-				      "retrying with longer timeout",
-				      original);
+/*
+ * compare linked list entry and it's following entry by weight and swap
+ * them if necessary. Return true if there is a difference and set changed
+ * flag if we swapped them.
+ */
+int compare_weight (struct nfs_mount *n1,int *changed)
+{
+	struct nfs_mount *n2;
+	int difference = 0;
 
-				return get_best_mount(what, original, 1, 1);
+	if (n1->entries.le_next) {
+		n2 = n1->entries.le_next;
+		if (n1->weight != n2->weight) {
+			difference = 1;
+			if (n2->weight < n1->weight) {
+				debug(MODPREFIX "weight swap: %s(%d) - %s(%d)",
+					n1->host,n1->weight,
+					n2->host,n2->weight);
+				LIST_REMOVE(n1, entries);
+				LIST_INSERT_AFTER(n2, n1, entries);
+				*changed = 1;
 			}
 		}
 	}
+	return difference;
+}
 
-	/* No winner found so bail */
-	if (!winner) {
-		*what = '\0';
-		return 0;
+/* do an RPC ping against a host */
+int ping_host(struct nfs_mount *mount,int longtimeout,unsigned int vers,
+		unsigned int proto)
+{
+	if (longtimeout) {
+		if ( rpc_time(mount->host, vers, proto, LONG_SEC,
+				  LONG_USEC, &mount->pingtime) )
+			return SUCCESS;
+		else
+			return LONG_TIMEO;
+	} else {
+		if ( rpc_time(mount->host, vers, proto, SHORT_SEC,
+				  SHORT_USEC, &mount->pingtime) )
+			return SUCCESS;
+		else
+			return SHORT_TIMEO;
 	}
+}
 
-	/*
-	 * We now have our winner, copy it to the front of the string,
-	 * followed by the next :string<delim>
-	 */
-	
-	/* if it's local */
-	if (!local)
-		strcpy(what, winner);
-	else
-		what[0] = '\0';
+/* compare linked list entry and its following entry by RPC ping time
+ * start with a short ping timeout and fall back to a longer ping iff
+ * both hosts fail to respond to the short timeout ping.
+ */
+int compare_ping(struct nfs_mount *n1,int *changed,unsigned int vers,
+		 unsigned int proto)
+{
+	struct nfs_mount *n2;
 
-	/* We know we're only reading from p, so discard const */
-	p = (char *) original + (winner - what);
-	delim = what + strlen(what);
+	if(! n1->entries.le_next)
+		return 1;
 
-	/* Find the colon (in the original string) */
-	while (*p && *p != ':')
-		p++;
+	n2 = n1->entries.le_next;
 
-	/* skip : for local paths */
-	if (local)
-		p++;
+	/* ping the hosts with short timeout if they're not pinged */
+	if (n1->pingstat == NOTPINGED)
+		n1->pingstat = ping_host(n1,0,vers,proto);
+
+	if (n2->pingstat == NOTPINGED)
+		n2->pingstat = ping_host(n2,0,vers,proto);
+
+	/* if neither has successful ping, then fall back to long timeout */
+	if ( n1->pingstat != SUCCESS && n2->pingstat != SUCCESS ) {
+		if ( n1->pingstat == SHORT_TIMEO )
+			n1->pingstat = ping_host(n1,1,vers,proto);
+
+		if ( n2->pingstat == SHORT_TIMEO )
+			n2->pingstat = ping_host(n1,1,vers,proto);
+	}
+
+	/* compare ping times if possible */
+	if ( n1->pingstat == SUCCESS && n2->pingstat == SUCCESS ) {
+		if ( n1->pingtime > n2->pingtime ) {
+			LIST_REMOVE(n1,entries);
+			LIST_INSERT_AFTER(n2,n1,entries);
+			*changed = 1;
+			debug(MODPREFIX "pingtime swap: %s(%f) - %s(%f)",
+				n1->host,n1->pingtime,
+				n2->host,n2->pingtime);
+		}
+	/* otherwise swap if n2 had successful ping and n1 didn't */
+	} else if ( n2->pingstat == SUCCESS ) {
+		LIST_REMOVE(n1,entries);
+		LIST_INSERT_AFTER(n2,n1,entries);
+		*changed = 1;
+	}
+
+	return 1;
+}
 
-	/* copy to next space or end of string */
-	while (*p && *p != ' ' && *p != '\t')
-		*delim++ = *p++;
+/*
+ * sort a linked list of mounts, based on "bindness", weight, and RPC ping
+ */
+void
+sort_mounts(struct listhead *nfs_mount_head, unsigned int vers,
+	    unsigned int proto)
+{
+	struct hostent *he;
+	char **haddr;
+	int bind;
+	int changed = 1;
+	int currentchanged = 0;
+	struct nfs_mount *currentmount;
+	struct nfs_mount *nextmount;
 
-	*delim = '\0';
 
-	return local;
+	/* check for bind mount first */
+	currentmount = nfs_mount_head->lh_first;
+	while (currentmount) {
+		if (currentmount->bind)
+			continue;
+
+		he = gethostbyname(currentmount->host);
+
+		/* if host isn't resolvable remove it from list */
+		if (!he) {
+			error(MODPREFIX
+			      "host %s: lookup failure, removing from list",
+			      currentmount->host);
+			nextmount = currentmount->entries.le_next;
+			LIST_REMOVE(currentmount,entries);
+			free(currentmount);
+			currentmount = nextmount;
+			continue;
+		}
+
+		/* Check each host in round robin list */
+		for (haddr = he->h_addr_list; *haddr; haddr++) {
+			bind = is_bind_addr(currentmount->host, *haddr,
+					    he->h_length);
+			if (bind < 0)
+				continue;
+
+			if (bind) {
+				currentmount->bind = 1;
+				break;
+			}
+		}
+		currentmount = currentmount->entries.le_next;
+	}
+
+	/* bubblesort time! */
+	debug(MODPREFIX "Starting bubblesort");
+	while (changed) {
+		changed = 0;
+		currentmount = nfs_mount_head->lh_first;
+		while (currentmount->entries.le_next) {
+			debug(MODPREFIX
+			      "currentmount = %s:%s",
+			      currentmount->host, currentmount->path);
+			currentchanged = 0;
+			compare_bind(currentmount,&currentchanged) ||
+			compare_weight(currentmount,&currentchanged) ||
+			compare_ping(currentmount,&currentchanged,vers,proto);
+
+			if (currentchanged)
+				changed = 1;
+			else
+				currentmount = currentmount->entries.le_next;
+		}
+	}
+	debug(MODPREFIX "Ending bubblesort");
 }
 
-int mount_mount(const char *root, const char *name, int name_len,
-		const char *what, const char *fstype, const char *options,
-		void *context)
+/* the main routine -- from the info given, pick a filesystem and mount it */
+int
+mount_mount(const char *root, const char *name, int name_len,
+	    const char *what, const char *fstype, const char *options,
+	    void *context)
 {
-	char *colon, *fullpath;
-	char *whatstr;
+	char *fullpath = NULL;
+	char *whatstr = NULL;
+	char *mntstrcopy = NULL;
 	char *nfsoptions = NULL;
-	int local, err;
 	int nosymlink = 0;
-	int ro = 0;            /* Set if mount bind should be read-only */
+	int error = 0;
+	int ro = 0;
+	int status = 0;
+	int dir_created = 0;
+	int mounted = 0;
+	int i = 0;
+	const char *comma;
+	char *nfsp;
+	int len = 0;
+	struct nfs_mount *currentmount = NULL;
+	struct listhead nfs_mount_head;
+	unsigned int vers = NFS2_VERSION;
+	unsigned int proto = RPC_PING_UDP;
 
-	debug(MODPREFIX "root=%s name=%s what=%s, fstype=%s, options=%s",
+	debug(MODPREFIX " root=%s name=%s what=%s, fstype=%s, options=%s",
 	      root, name, what, fstype, options);
 
-	whatstr = alloca(strlen(what) + 1);
+	/* Initialize head of linked list */
+	LIST_INIT(&nfs_mount_head);
+
+	/* whatstr -- this is what we pass to spawnl or mount_bind later */
+	whatstr = calloc(strlen(what) + 1, sizeof(char));
 	if (!whatstr) {
-		error(MODPREFIX "alloca: %m");
-		return 1;
+		error(MODPREFIX "calloc: %m");
+		error = 1;
+		goto cleanup;
+	}
+
+	/* mount string for parsing, we chop this up in the parse routine */
+	mntstrcopy = calloc(strlen(what) + 1, sizeof(char));
+	if (!mntstrcopy) {
+		error(MODPREFIX "calloc: %m");
+		error = 1;
+		goto cleanup;
 	}
-	strcpy(whatstr, what);
+	strncpy(mntstrcopy, what, strlen(what) + 1);
 
-	/* Extract "nosymlink" pseudo-option which stops local filesystems
-	   from being symlinked */
+	/* full path of mount point */
+	fullpath = calloc(strlen(root) + name_len + 2, sizeof(char));
+	if (!fullpath) {
+		error(MODPREFIX "calloc: %m");
+		error = 1;
+		goto cleanup;
+	}
+
+	/* Extract "nosymlink" pseudo-option which stops local filesystems from 
+	   being symlinked, and check for tcp and nfsvers= options */
 	if (options) {
-		const char *comma;
-		char *nfsp;
-		int len = strlen(options) + 1;
-
-		nfsp = nfsoptions = alloca(len + 1);
-		if (!nfsoptions)
-			return 1;
+		len = strlen(options) + 1;
 
-		memset(nfsoptions, '\0', len + 1);
+		/* an nfsoptions string that we'll use later */
+		nfsp = nfsoptions = calloc(len + 1, sizeof(char));
+		if (!nfsoptions) {
+			error(MODPREFIX "calloc: %m");
+			error = 1;
+			goto cleanup;
+		}
 
 		for (comma = options; *comma != '\0';) {
 			const char *cp;
@@ -364,115 +552,173 @@
 			while (*comma == ' ' || *comma == '\t')
 				end--;
 
-#if 0
-			debug(MODPREFIX "*comma=%x %c  comma=%p %s cp=%p %s "
-			      "nfsoptions=%p nfsp=%p end=%p used=%d len=%d\n",
-			      *comma, *comma, comma, comma, cp, cp,
-			      nfsoptions, nfsp, nfsoptions + len,
-			      nfsp - nfsoptions, len);
-#endif
-			if (strncmp("nosymlink", cp, end - cp + 1) == 0)
+			/* if it's nosymlink, set flag and skip copying it to
+			   nfsoptions if the flag declares tcp or an nfs
+			   version set ping proto and version appropriately.
+			   Also look for 'ro' option so we can pass this to
+			   mount_bind if need be. */
+			if (strncmp("nosymlink", cp, end - cp + 1) == 0) {
 				nosymlink = 1;
-			else {
-				/* Check for options that also make sense
-				   with bind mounts */
-				if (strncmp("ro", cp, end - cp + 1) == 0)
-					ro = 1;
-				/* and jump over trailing white space */
-				memcpy(nfsp, cp, comma - cp + 1);
-				nfsp += comma - cp + 1;
+				continue;
+			} else if (strncmp("tcp", cp, end - cp + 1) == 0) {
+				proto = RPC_PING_TCP;
+			} else if (strncmp("nfsvers=3", cp, end - cp + 1)
+				   == 0) {
+				vers = NFS3_VERSION;
+			} else if (strncmp("ro", cp, end - cp + 1) == 0) {
+				ro = 1;
 			}
-		}
-
-		debug(MODPREFIX "nfs options=\"%s\", nosymlink=%d, ro=%d",
-		      nfsoptions, nosymlink, ro);
-	}
 
-	local = 0;
-
-	colon = strchr(whatstr, ':');
-	if (!colon) {
-		/* No colon, take this as a bind (local) entry */
-		local = 1;
-	} else if (!nosymlink) {
-		local = get_best_mount(whatstr, what, 0, 0);
-		if (!*whatstr) {
-			warn(MODPREFIX "no host elected");
-			return 1;
+			/* and jump over trailing white space */
+			memcpy(nfsp, cp, comma - cp + 1);
+			nfsp += comma - cp + 1;
 		}
-		debug(MODPREFIX "from %s elected %s", what, whatstr);
-	}
 
-	fullpath = alloca(strlen(root) + name_len + 2);
-	if (!fullpath) {
-		error(MODPREFIX "alloca: %m");
-		return 1;
+		debug(MODPREFIX
+		      "nfs options=\"%s\", nosymlink=%d, nfsvers=%d, proto=%d",
+		      nfsoptions, nosymlink, vers, proto);
 	}
 
+	/* get full path of mountpoint */
 	if (name_len)
 		sprintf(fullpath, "%s/%s", root, name);
 	else
 		sprintf(fullpath, "%s", root);
 
-	if (local) {
-		/* Local host -- do a "bind" */
-
-		const char *bind_options = ro ? "ro" : "";
-
-		debug(MODPREFIX "%s is local, doing bind", name);
-
-		return mount_bind->mount_mount(root, name, name_len,
-					       whatstr, "bind", bind_options,
-					       mount_bind->context);
-	} else {
-		/* Not a local host - do an NFS mount */
-		int status, existed = 1;
+	/* parse the mount string and get the nfs_mount struct linked list */
+	error = parse_mount_string(mntstrcopy, &nfs_mount_head);
+	if (error)
+		goto cleanup;
+
+	/* sort the linked list */
+	sort_mounts(&nfs_mount_head, vers, proto);
+
+	/* now try to mount them in turn */
+	currentmount = nfs_mount_head.lh_first;
+	mounted = is_mounted(_PATH_MOUNTED, fullpath);
+
+	/* log final sorted list for debugging */
+	if (do_debug) {
+		i = 0;
+		while (currentmount) {
+			debug(MODPREFIX "%d: host=%s, path=%s, weight=%d",
+			      i, currentmount->host, currentmount->path,
+			      currentmount->weight);
+			currentmount = currentmount->entries.le_next;
+			++i;
+		}
+		currentmount = nfs_mount_head.lh_first;
+	}
+
+	/* error out with a debug message if it's already mounted */
+	if (mounted)
+		debug(MODPREFIX "BUG: %s is already mounted!",
+		      fullpath) error = 1;
+
+	while (currentmount && !mounted) {
+		error = 0;
+		debug(MODPREFIX
+		      "attempting mount: host=%s path=%s weight=%d",
+		      currentmount->host, currentmount->path,
+		      currentmount->weight);
+
+		/* see if this qualifies for a bind mount -- currentmount->bind
+		   is set or currentmount->host is NULL */
+		if ((currentmount->bind && !nosymlink)
+		    || !currentmount->host) {
+			debug(MODPREFIX "%s is local, doing bind", name);
+
+			/* pass the ro flag if it was specified */
+			const char *bind_options = ro ? "ro" : "";
+
+			error = mount_bind->mount_mount(root, name,
+							name_len,
+							currentmount->
+							path, "bind",
+							bind_options,
+							mount_bind->context);
 
-		debug(MODPREFIX "calling mkdir_path %s", fullpath);
+		} else {
+			/* otherwise this is an NFS mount */
+			status = mkdir_path(fullpath, 0555);
+			if (status && errno != EEXIST) {
+				error(MODPREFIX
+				      "mkdir_path %s failed: %m", fullpath);
+				error = 2;
+			} else if (status) {
+				error = 0;
+			} else {
+				dir_created = 1;
+			}
 
-		status = mkdir_path(fullpath, 0555);
-		if (status && errno != EEXIST) {
-			error(MODPREFIX "mkdir_path %s failed: %m", fullpath);
-			return 1;
+			/* attempt to mount if there's no error */
+			if (!error) {
+				sprintf(whatstr, "%s:%s",
+					currentmount->host, currentmount->path);
+				if (nfsoptions && *nfsoptions) {
+					debug(MODPREFIX
+					      "calling mount -t nfs "
+					      SLOPPY " -o %s %s %s",
+					      nfsoptions, whatstr, fullpath);
+
+					error = spawnll(LOG_NOTICE,
+							PATH_MOUNT,
+							PATH_MOUNT,
+							"-t", "nfs",
+							SLOPPYOPT
+							"-o",
+							nfsoptions,
+							whatstr,
+							fullpath, NULL);
+				} else {
+					debug(MODPREFIX
+					      "calling mount -t nfs %s %s",
+					      whatstr, fullpath);
+					error = spawnll(LOG_NOTICE,
+							PATH_MOUNT,
+							PATH_MOUNT,
+							"-t", "nfs",
+							whatstr,
+							fullpath, NULL);
+				}
+			}
 		}
 
-		if (!status)
-			existed = 0;
-
-		if (is_mounted(_PATH_MOUNTED, fullpath)) {
-			error(MODPREFIX 
-			  "warning: %s is already mounted", fullpath);
-			return 0;
+		if (error == 2) {
+			debug(MODPREFIX
+			      "unable to create mountpoint %s. "
+			      "Not attempting any further mounts!",
+			      fullpath);
+			error = 1;
+			break;
 		}
 
-		if (nfsoptions && *nfsoptions) {
-			debug(MODPREFIX "calling mount -t nfs " SLOPPY 
-			      " -o %s %s %s", nfsoptions, whatstr, fullpath);
+		currentmount = currentmount->entries.le_next;
+		mounted = is_mounted(_PATH_MOUNTED, fullpath);
+	}
 
-			err = spawnll(LOG_NOTICE,
-				     PATH_MOUNT, PATH_MOUNT, "-t",
-				     "nfs", SLOPPYOPT "-o", nfsoptions,
-				     whatstr, fullpath, NULL);
-		} else {
-			debug(MODPREFIX "calling mount -t nfs %s %s",
-			      whatstr, fullpath);
-			err = spawnll(LOG_NOTICE,
-				     PATH_MOUNT, PATH_MOUNT, "-t",
-				     "nfs", whatstr, fullpath, NULL);
-		}
+	/* cleanup time -- remove directory if there was an error and we
+	   created it */
+	if (error) {
+		debug(MODPREFIX "mount of %s on %s failed!", whatstr, fullpath);
+		if (dir_created || (!ap.ghost && name_len))
+			rmdir_path(name);
 
-		if (err) {
-			if ((!ap.ghost && name_len) || !existed)
-				rmdir_path(name);
-
-			error(MODPREFIX "nfs: mount failure %s on %s",
-			      whatstr, fullpath);
-			return 1;
-		} else {
-			debug(MODPREFIX "mounted %s on %s", whatstr, fullpath);
-			return 0;
-		}
+	} else {
+		debug(MODPREFIX "mounted %s on %s", whatstr, fullpath);
 	}
+
+	/* clean up any memory we allocated */
+      cleanup:
+	free(whatstr);
+	free(mntstrcopy);
+	free(fullpath);
+	free(nfsoptions);
+	while (nfs_mount_head.lh_first != NULL)
+		LIST_REMOVE(nfs_mount_head.lh_first, entries);
+
+	return error;
+
 }
 
 int mount_done(void *context)
