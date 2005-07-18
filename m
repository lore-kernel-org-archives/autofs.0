From: Jeff Layton <jtlayton@poochiereds.net>
Subject: [PATCH] mount_nfs replicated mounts patch (now sorts by
	subnet locality too)
Date: Mon, 18 Jul 2005 17:28:12 -0400
Message-ID: <1121722092.6710.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-M2aUAKRSR3pNpT4NEHD5"
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org


--=-M2aUAKRSR3pNpT4NEHD5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all,

I sent this earlier from a different account but it never showed up, so
apologies if it's a duplicate...

Here's the latest patch for my mount_nfs overhaul. This version adds
a new sorting criteria that should bring the replicated mount behavior
pretty closely into line with Solaris. I've done some basic testing of
it and it seems to work, but will need some more extensive testing (like
the rest of the patch).

The new version now checks to see whether any address for a replicated
mount is on a subnet that is local to the client (by comparing the
address to the routing table in /proc/net/route). We then sort by this
criteria after "bindness" (if the mount is a bind mount) and before the
weight.

There's only one catch -- the mount program simply selects the first
address given by a gethostbyname() call. So if the host is multi-homed,
we may end up mounting across a router anyway, even if another address
is closer.

We could simply use the address instead of the hostname for the mount,
but then we lose the hostname information for the mount. This could
look very messy, especially with a lot of NFS mounts. So, what I'm
thinking is this:

Currently the 'addr=' mount option for nfs mounts is ignored. I'd like
to roll a patch for mount such that this option is instead treated as an
address hint. If the address provided by the 'addr=' option matches one
of the addresses returned by gethostbyname(), then the mount program
would use that address for the mount. Otherwise, the existing behavior
(use first address in list) would prevail.

Does this sound like a good plan, or does anyone else have another
suggestion on how to deal with this?

In any case, here is the current revision of the autofs patch. I'll plan
to add the code soon that will add the "addr=" option for mounts that
are on the local subnet, unless there are major objections to the above
approach.

As always, comments and suggestions are appreciated...

-- Jeff


--=-M2aUAKRSR3pNpT4NEHD5
Content-Disposition: attachment; filename=autofs-4.1.4-replicated-mounts.patch
Content-Type: text/x-patch; name=autofs-4.1.4-replicated-mounts.patch;
	charset=UTF-8
Content-Transfer-Encoding: 7bit

--- autofs/modules/mount_nfs.c.orig	2005-07-17 08:00:53.000000000 -0400
+++ autofs/modules/mount_nfs.c	2005-07-18 14:55:36.000000000 -0400
@@ -6,6 +6,7 @@
  *
  *   Copyright 1997 Transmeta Corporation - All Rights Reserved
  *   Copyright 1999-2000 Jeremy Fitzhardinge <jeremy@goop.org>
+ *   Copyright 2005 Jeff Layton/Red Hat <jlayton@redhat.com>
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -24,20 +25,64 @@
 #include <stdlib.h>
 #include <syslog.h>
 #include <string.h>
+#include <stdlib.h>
+#include <arpa/inet.h>
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
-#include <ctype.h>
+#include <linux/nfs3.h>
+#include <linux/route.h>
 
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
+	char localaddr[16];
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
@@ -58,16 +103,18 @@
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
@@ -85,7 +132,7 @@
 	src_addr.sin_port = port_discard;
 
 	ret = connect(sock, (struct sockaddr *) &src_addr, src_len);
-	if (ret < 0 ) {
+	if (ret < 0) {
 		error(MODPREFIX "connect failed for %s: %m", host);
 		close(sock);
 		return 0;
@@ -103,315 +150,581 @@
 	ret = memcmp(&src_addr.sin_addr, &local_addr.sin_addr, addr_len);
 	if (ret)
 		return 0;
-	
+
 	return 1;
 }
 
-/*
- * If the entry doesn't contain a ',' or doesn't contain more than
- * one ':' then @what is not a replicated server entry.
+/* find whether each host has an address on a subnet local to us. Return
+ * non-zero on error. If the host has a local address, place it in
+ * mount->localaddr in dotted-quad notation.
  */
-static int inline is_replicated_entry(char *what)
+int set_local_addr(struct listhead *nfs_mount_head) {
+	struct nfs_mount *currentmount;
+	struct hostent *host = NULL;
+	struct in_addr addr;
+	unsigned long  dest, mask = 0;
+	unsigned short flags = 0;
+	char *buf, *dest_s, *flags_s, *mask_s = NULL;
+	int i, local, retcode = 0;
+	FILE *fd = NULL;
+
+	fd = fopen("/proc/net/route","r");
+	if (fd == NULL) {
+		error(MODPREFIX "unable to open /proc/net/route: %m");
+		retcode = 1;
+		goto ila_cleanup;
+	}
+
+	/* skip header */
+	while ( (i = fgetc(fd)) != EOF && (char) i != '\n' );
+	
+	while (fscanf(fd,"%*s %as %*s %as %*s %*s %*s %as %*s %*s %*s",
+			&dest_s,&flags_s,&mask_s) != -1) {
+
+		flags = (unsigned short int) strtoul(flags_s,&buf,8);
+		if (*buf != '\0') {
+			error(MODPREFIX "flags conversion error: %s", flags_s);
+			retcode = 1;
+			goto ila_cleanup;
+		}
+		free(flags_s);
+		flags_s = NULL;
+
+
+		/* if this route involves a gateway, skip it */
+		if (flags & RTF_GATEWAY)
+			continue;
+
+		mask = strtoul(mask_s,&buf,16);
+		if (*buf != '\0') {
+			error(MODPREFIX "mask conversion error: %s", mask_s);
+			retcode = 1;
+			goto ila_cleanup;
+		}
+		free(mask_s);
+		mask_s = NULL;
+
+		dest = strtoul(dest_s,&buf,16);
+		if (*buf != '\0') {
+			error(MODPREFIX "dest conversion error: %s", dest_s);
+			retcode = 1;
+			goto ila_cleanup;
+		}
+		free(dest_s);
+		dest_s = NULL;
+
+		/* now roll through each host in list and check against
+		 * this entry */
+		currentmount = nfs_mount_head->lh_first;
+		while(currentmount) {
+
+			/* don't bother if it's a bind mount */
+			if ( currentmount->bind ) {
+				currentmount = currentmount->entries.le_next;
+				continue;
+			}
+
+			host = gethostbyname( currentmount->host );
+			i = 0;
+			local = 0;
+			while ( host && (host->h_addr_list)[i] ) {
+				addr.s_addr = *(ulong *)(host->h_addr_list)[i];
+				if ((addr.s_addr & mask) == dest) {
+			    		local = 1;
+			    		break;
+				}
+				++i;
+			}
+
+			/* we found a local address, convert to dotted-quad
+			 * and stuff it in localaddr.
+		 	*/
+			if (local) {
+				debug("%s is on local subnet",
+					currentmount->host);
+				currentmount->local = 1;
+				strncpy(&(currentmount->localaddr[0]),
+						inet_ntoa(addr),16);
+			}
+			currentmount = currentmount->entries.le_next;
+		}
+	}
+
+
+ila_cleanup:
+	if (fd)
+		fclose(fd);
+	free(flags_s);
+	free(mask_s);
+	free(dest_s);
+	return retcode;
+}
+
+/* create an nfs_mount list entry */
+struct nfs_mount *create_nfs_mount_entry(char *host, char *path, int bind)
 {
-	return strchr(what, ',') ||
-		(strchr(what, ':') != strrchr(what, ':'));
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
+	entry->local = 0;
+	entry->pingstat = NOTPINGED;
+	entry->pingtime = 0;
+	entry->entries.le_next=NULL;
+	entry->entries.le_prev=NULL;
+	return entry;
 }
 
 /*
- *  Check to see if the 'host:path' or 'host' is on the local machine
- *  Returns < 0 if there is a host lookup problem, otherwise returns 0
- *  if it's not a local mount, and returns > 0 if it is a local mount.
+ * Given a copy of the mount string (p) and a pointer to a nfs_mount struct
+ * (listhead), parse the mount string and populate a linked list with
+ * nfs_mount structs. Return 1 on error and 0 on success. 
  */
-int is_local_mount(const char *hostpath)
+int parse_mount_string(char *phead, struct listhead *nfs_mount_head)
 {
-	struct hostent *he;
-	char **haddr;
-	char *delim;
-	char *hostname;
-	int hostnamelen;
-	int local = 0;
-
-	debug(MODPREFIX "is_local_mount: %s", hostpath);
-	delim = strpbrk(hostpath,":");
-
-	if (delim) 
-		hostnamelen = delim - hostpath; 
-	else 
-		hostnamelen = strlen(hostpath);
-
-	hostname = malloc(hostnamelen+1);
-	strncpy(hostname, hostpath, hostnamelen);
-	hostname[hostnamelen] = '\0';
-	he = gethostbyname(hostname);
-	if (!he) {
-		error(MODPREFIX "host %s: lookup failure", hostname);
-		return -1;
+	char *delim,*wbuf,*p,*whead;
+	char *entity[MAX_REPL_MOUNTS];
+	char *currentpath = "";
+	int commaseen, i, numwords = 0;
+	struct nfs_mount *currentmount = NULL;
+
+	whead = calloc(strlen(phead + 1), sizeof(char));
+	if (!whead) {
+		error(MODPREFIX "calloc: %m");
+		return 1;
 	}
 
-	for (haddr = he->h_addr_list; *haddr; haddr++) {
-		local = is_local_addr(hostname, *haddr, he->h_length);
-		if (local < 0) 
-			return local;
- 		if (local) {
-			debug(MODPREFIX "host %s: is localhost",
-					hostname);
-			return local;
+	p = phead;
+	wbuf = whead;
+
+	/* remove any whitespace that follows commas */
+	commaseen = 0;
+	while (p && *p) {
+		if ( *p == ',' ) {
+			commaseen = 1;
+			*wbuf = ',';
+			++wbuf;
+		} else if ( (*p == ' ' || *p == '\t') && commaseen ) {
+			;
+		} else {
+			commaseen = 0;
+			*wbuf = *p;
+			++wbuf;
+		}
+		++p;
+	}
+	*wbuf = '\0';
+
+	debug(MODPREFIX "first strip: %s",whead);
+
+	/* remove any whitespace preceding commas */
+	--wbuf;
+	--p;
+	commaseen = 0;
+	while (wbuf != whead) {
+		if (*wbuf == ',') {
+			commaseen = 1;
+			*p = ',';
+			--p;
+		} else if ( (*wbuf == ' ' || *wbuf == '\t') && commaseen) {
+			;
+		} else {
+			commaseen = 0;
+			*p = *wbuf;
+			--p;
 		}
+		--wbuf;
 	}
-	return 0;
-}
+	*p = *wbuf;
 
-/*
- * Given a mount string, return (in the same string) the
- * best mount to use based on locality/weight/rpctime.
- *
- * If longtimeout is set to 0 then we only do 100 ms pings to hosts.  In
- * the event that this fails, we call ourself recursively with the
- * longtimeout option set to 1.  In this case we ping for up to 10s and
- * skip logic for detecting if a localhost has been passed. (if a local
- * host had been passed, we would have returned that mount as the best
- * mount.  The skipping of local maps in this case is an optimization).
- *
- * - return -1 and what = '\0' on error,
- *           1 and what = local mount path if local bind,
- *     else  0 and what = remote mount path
- */
-int get_best_mount(char *what, const char *original, int longtimeout)
-{
-	char *p = what;
-	char *winner = NULL;
-	int winner_weight = INT_MAX, local = 0;
-	double winner_time = 0;
-	char *delim, *pstrip;
-	int sec = (longtimeout) ? 10 : 0;
-	int micros = (longtimeout) ? 0 : 100000;
-	int skiplocal = longtimeout; /* clearly local is not available */
+	free(whead);
 
-	if (!p) {
-		*what = '\0';
-		return -1;
-	}
+	debug(MODPREFIX "second strip: %s",p);
 
-	/*
-	 *  If only one mountpoint has been passed in, we don't need to
-	 *  do anything except strip whitespace from the end of the string.
-	 */
-	if (!is_replicated_entry(p)) {
-		for (pstrip = p+strlen(p) - 1; pstrip >= p; pstrip--) 
-			if (isspace(*pstrip))
-				*pstrip = '\0';
-
-		/* Check if the host is the localhost */
-		if (is_local_mount(p) > 0) {
-			debug(MODPREFIX "host %s: is localhost", p);
-
-			/* Strip off hostname and ':' */
-			delim = strchr(p,':');
-			while (delim && *delim != '\0') {
-				delim++;
-				*what = *delim;
-				what++;
-			}
-			return 1;
+	/* break up mountstring into whitespace separated pieces */
+	while (p && *p) {
+		p += strspn(p, " \t");
+		delim = strpbrk(p, " \t");
+		if (delim) {
+			*delim = '\0';
+			entity[numwords] = p;
+			p = ++delim;
+		} else {
+			entity[numwords] = p;
+			break;
 		}
-		return 0;
+		++numwords;
 	}
 
-	while (p && *p) {
-		char *next;
-		unsigned int ping_stat = 0;
+	/* now, deal with each whitespace separated chunk in turn */
+	for (i = 0; i <= numwords; ++i) {
+		p = entity[i];
+		debug(MODPREFIX "Working on %s", p);
+
+		/* get the path section out first -- everything to right of the 
+		   ':' */
+		delim = strpbrk(p, ":");
+		if (delim) {
+			*delim = '\0';
+			currentpath = ++delim;
+			/* if there is no ':', then treat this as a bind mount
+			   and move on to the next whitespace chunk */
+		} else {
+			currentmount =
+				create_nfs_mount_entry(NULL, p, 1);
+
+			if (!currentmount)
+				return 1;
+
+			LIST_INSERT_HEAD(nfs_mount_head,currentmount,entries);
 
-		p += strspn(p, " \t,");
-		delim = strpbrk(p, "(, \t:");
-		if (!delim)
 			break;
+		}
 
-		/* Find lowest weight whose server is alive */
-		if (*delim == '(') {
-			char *weight = delim + 1;
-			unsigned int alive;
 
-			*delim = '\0';
+		/* now lets break up the host/weight section */
+		p = entity[i];
+		while (p && *p) {
+			currentmount =
+				create_nfs_mount_entry(p, currentpath, 0);
 
-			delim = strchr(weight, ')');
-			if (delim) {
-				int w;
+			if (!currentmount)
+				return 1;
 
+			LIST_INSERT_HEAD(nfs_mount_head,currentmount,entries);
+
+			delim = strpbrk(p, ",(");
+
+			if (delim && *delim == ',') {
 				*delim = '\0';
-				w = atoi(weight);
+				p = ++delim;
 
-				alive = rpc_ping(p, sec, micros);
-				if (w < winner_weight && alive) {
-					winner_weight = w;
-					winner = p;
-				}
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
+				break;
 			}
-			delim++;
 		}
+	}
 
-		if (*delim == ':') {
-			*delim = '\0';
-			next = strpbrk(delim + 1, " \t");
-		} else if (*delim != '\0') {
-			*delim = '\0';
-			next = delim + 1;
-		} else
-			break;
+	return 0;
+}
 
-		/* p points to a server, "next is our next parse point */
-		if (!skiplocal) {
-			/* Check if it's localhost */
-			local = is_local_mount(p);
-			if (local < 0) {
-				local = 0;
-				p = next;
-				continue;
-			}
+/*
+ * compare linked list entry and it's following entry by "bindness" and swap
+ * them if necessary. Return true if there is a difference and set changed
+ * flag if we swapped them.
+ */
+int compare_bind (struct nfs_mount *n1,int *changed)
+{
+	struct nfs_mount *n2;
+	int difference = 0;
 
-			if (local) {
-				winner = p;
-				break;
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
+	}
+	return difference;
+}
 
-		/* ping each (or the) entry to see if it's alive. */
-		ping_stat = rpc_ping(p, sec, micros);
-		if (!ping_stat) {
-			p = next;
-			continue;
-		}
+/*
+ * compare linked list entry and it's following entry by "locality" and swap
+ * them if necessary. Return true if there is a difference and set changed
+ * flag if we swapped them.
+ */
+int compare_local (struct nfs_mount *n1,int *changed)
+{
+	struct nfs_mount *n2;
+	int difference = 0;
 
-		/* First unweighted or only host is alive so set winner */
-		if (!winner) {
-			winner = p;
-			winner_time = 1;
-			/* No more to check, return it */
-			if (!next || !*next)
-				break;
+	if (n1->entries.le_next) {
+		n2 = n1->entries.le_next;
+		if (n1->local != n2->local) {
+			difference = 1;
+			if (n2->local > n1->local) {
+				debug(MODPREFIX "local swap: %s(%d) - %s(%d)",
+					n1->host,n1->local,
+					n2->host,n2->local);
+				LIST_REMOVE(n1, entries);
+				LIST_INSERT_AFTER(n2, n1, entries);
+				*changed = 1;
+			}
 		}
+	}
+	return difference;
+}
 
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
-
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
+ * compare linked list entry and it's following entry by weight and swap
+ * them if necessary. Return true if there is a difference and set changed
+ * flag if we swapped them.
+ */
+int compare_weight (struct nfs_mount *n1,int *changed)
+{
+	struct nfs_mount *n2;
+	int difference = 0;
+
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
-		p = next;
 	}
+	return difference;
+}
 
-	debug(MODPREFIX "winner = %s local = %d", winner, local);
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
+	}
+}
 
-	/*
-	 * We didn't find a weighted winner or local
-	 */
-	if (!local && winner_weight == INT_MAX) {
-		/* We had more than one contender and none responded in time */
-		if (winner_time == 0 || winner_time > 500) {
-			/* We've already tried a longer timeout */
-			if (!longtimeout) {
-				/* Reset string and try again */
-				strcpy(what, original);
+/* compare linked list entry and its following entry by RPC ping time
+ * start with a short ping timeout and fall back to a longer ping iff
+ * both hosts fail to respond to the short timeout ping.
+ */
+int compare_ping(struct nfs_mount *n1,int *changed,unsigned int vers,
+		 unsigned int proto)
+{
+	struct nfs_mount *n2;
 
-				debug(MODPREFIX 
-				      "all hosts timed out for '%s', "
-				      "retrying with longer timeout",
-				      original);
+	if(! n1->entries.le_next)
+		return 1;
 
-				return get_best_mount(what, original, 1);
-			}
-		}
+	n2 = n1->entries.le_next;
+
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
 	}
 
-	/* No winner found so return first */
-	if (!winner)
-		winner = what;
+	return 1;
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
+
+
+	/* check for bind mount first then local subnet */
+	currentmount = nfs_mount_head->lh_first;
+	while (currentmount) {
+		if (currentmount->bind)
+			continue;
+
+		he = gethostbyname(currentmount->host);
 
-	/* We know we're only reading from p, so discard const */
-	p = (char *) original + (winner - what);
-	delim = what + strlen(what);
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
 
-	/* Find the colon (in the original string) */
-	while (*p && *p != ':')
-		p++;
+		/* Check each host in round robin list */
+		for (haddr = he->h_addr_list; *haddr; haddr++) {
+			bind = is_bind_addr(currentmount->host, *haddr,
+					    he->h_length);
+			if (bind < 0)
+				continue;
 
-	/* skip : for local paths */
-	if (local)
-		p++;
+			if (bind) {
+				currentmount->bind = 1;
+				break;
+			}
+		}
 
-	/* copy to next space or end of string */
-	while (*p && *p != ' ' && *p != '\t')
-		*delim++ = *p++;
+		currentmount = currentmount->entries.le_next;
+	}
 
-	*delim = '\0';
+	set_local_addr(nfs_mount_head);
 
-	return local;
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
+			compare_local(currentmount,&currentchanged) ||
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
@@ -433,115 +746,174 @@
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
 
-		debug(MODPREFIX "nfs options=\"%s\", nosymlink=%d, ro=%d",
-		      nfsoptions, nosymlink, ro);
-	}
-
-	local = 0;
-
-	colon = strchr(whatstr, ':');
-	if (!colon) {
-		/* No colon, take this as a bind (local) entry */
-		local = 1;
-	} else if (!nosymlink) {
-		local = get_best_mount(whatstr, what, 0);
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
+	if (mounted) {
+		debug(MODPREFIX "BUG: %s is already mounted!", fullpath);
+		error = 1;
+	}
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
 
-		return mount_bind->mount_mount(root, name, name_len,
-					       whatstr, "bind", bind_options,
-					       mount_bind->context);
-	} else {
-		/* Not a local host - do an NFS mount */
-		int status, existed = 1;
-
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

--=-M2aUAKRSR3pNpT4NEHD5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--=-M2aUAKRSR3pNpT4NEHD5--

