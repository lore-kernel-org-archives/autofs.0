From: Jeff Moyer <jmoyer@redhat.com>
Subject: [autofs4 patch] implement included map support
Date: Wed, 08 Nov 2006 22:37:11 -0500
Message-ID: <x491wodnvdk.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: Ian Kent <raven@themaw.net>, autofs mailing list <autofs@linux.kernel.org>

Hi, Ian, list,  (again, sorry if this is a dup)

Here is an implementation of included map support for autofs v4.  This
supports included maps in both the master map, and regular direct or
indirect file maps.

Because I dread writing bash code, I implemented the included map
checking for the master map in C.  We basically just call into the
daemon with a bogus mount point, asking for it to dump out all of the
maps.  This works well for 2 reasons: 1) it's not bash, and 2) it
re-uses the code that the daemon will use to read the included maps
anyway.

Review would be greatly appreciated.  I tested this in my environment
by creating a number of included maps, and modifying
/etc/nsswitch.conf to ensure that it works as expected for file and
NIS maps.

-Jeff

diff --git a/daemon/Makefile b/daemon/Makefile
index 4cf1907..7789c79 100644
--- a/daemon/Makefile
+++ b/daemon/Makefile
@@ -13,7 +13,7 @@ version := $(shell cat ../.version)
 
 CFLAGS += -rdynamic $(DAEMON_CFLAGS) -DAUTOFS_LIB_DIR=\"$(autofslibdir)\" -DVERSION_STRING=\"$(version)\" -I../include
 LDFLAGS += -rdynamic
-LIBS = -ldl
+LIBS = -ldl -lldap
 
 all: automount
 
diff --git a/daemon/automount.c b/daemon/automount.c
index eb0cdd3..3c42c8a 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -82,6 +82,7 @@ struct daemon_status_msg {
 
 int kproto_version;		/* Kernel protocol version used */
 int kproto_sub_version = 0;	/* Kernel protocol version used */
+int dumpmap = 0;		/* cmdline arg to dump map contents */
 
 static int submount = 0;
 
@@ -99,6 +100,10 @@ #define AUTOFS_SYSLOG_CONTEXT {-1, 0, 0,
 
 volatile struct pending_mount *junk_mounts = NULL;
 
+/* this has to go in the automounter proper, so that each shared library
+ * doesn't get its own copy */
+struct mapent_cache *mapent_hash[HASHSIZE];
+
 #define CHECK_RATIO     4	/* exp_runfreq = exp_timeout/CHECK_RATIO */
 #define DEFAULT_GHOST_MODE	0
 
@@ -1848,6 +1853,7 @@ int main(int argc, char *argv[])
 		{"version", 0, 0, 'V'},
 		{"ghost", 0, 0, 'g'},
 		{"submount", 0, &submount, 1},
+		{"dumpmap", 0, 0, 'D'},
 		{0, 0, 0, 0}
 	};
 
@@ -1860,7 +1866,7 @@ int main(int argc, char *argv[])
 	ap.dir_created = 0; /* We haven't created the main directory yet */
 
 	opterr = 0;
-	while ((opt = getopt_long(argc, argv, "+hp:t:vdVg", long_options, NULL)) != EOF) {
+	while ((opt = getopt_long(argc, argv, "+hp:t:vdVgD", long_options, NULL)) != EOF) {
 		switch (opt) {
 		case 'h':
 			usage();
@@ -1890,6 +1896,9 @@ int main(int argc, char *argv[])
 			ap.ghost = LKP_GHOST;
 			break;
 
+		case 'D':
+			dumpmap = 1;
+			break;
 		case '?':
 		case ':':
 			printf("%s: Ambiguous or unknown options\n", program);
@@ -1911,7 +1920,8 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	become_daemon();
+	if (!dumpmap)
+		become_daemon();
 
 	path = argv[0];
 	map = argv[1];
@@ -1942,6 +1952,16 @@ #endif
 		cleanup_exit(path, 1);
 	}
 
+	if (dumpmap) {
+		int ret;
+		openlog("automount", LOG_PID, LOG_DAEMON);
+		ret = ap.lookup->lookup_ghost(ap.path, ap.ghost,
+					      0, ap.lookup->context);
+		if (ret & LKP_FAIL)
+			exit(ret);
+		exit(0);
+	}
+
 	if (!strncmp(path, "/-", 2)) {
 		supervisor(path);
 	} else {
diff --git a/include/automount.h b/include/automount.h
index d256b3e..14ec07b 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -161,6 +161,9 @@ typedef int (*lookup_init_t) (const char
 typedef int (*lookup_ghost_t) (const char *, int, time_t, void *);
 typedef int (*lookup_mount_t) (const char *, const char *, int, void *);
 typedef int (*lookup_done_t) (void *);
+/* the following two are used by the included map (+mapname) code */
+typedef int (*lookup_one_t) (const char *, const char *, const char *, int);
+typedef int (*lookup_readmap_t) (const char *, const char *, time_t);
 
 struct lookup_mod {
 	lookup_init_t lookup_init;
@@ -241,6 +244,8 @@ struct mapent_cache {
 	char *mapent;
 	time_t age;
 };
+#define HASHSIZE      27
+extern struct mapent_cache *mapent_hash[];
 
 void cache_init(void);
 struct mapent_cache *cache_lookup(const char *key);
@@ -294,17 +299,15 @@ int has_fstab_option(const char *path, c
 int allow_owner_mount(const char *);
 
 /* nsswitch parsing */
-#define MAPTYPE_FILE 1
-#define MAPTYPE_PROGRAM 2
-
-char *get_nsswitch_map(const char *);
-int isfilemap(const char *);
-int isypmap(const char *);
+char *get_nsswitch_map(const char *, char *);
 
 /* log notification */
 extern int do_verbose;
 extern int do_debug;
 
+/* command line option to print out included map contents */
+extern int dumpmap;
+
 #define info(msg, args...) 		\
 if (do_verbose || do_debug) 		\
 	syslog(LOG_INFO, msg, ##args);
diff --git a/lib/Makefile b/lib/Makefile
index 92931b0..a35b208 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -16,12 +16,13 @@ OBJS = cache.o mount_clnt.o mount_xdr.o 
 	cat_path.o rpc_subs.o mounts.o lock.o syslog.o vsprintf.o nsswitch.o
 
 LIB = autofs.a
+NSSWITCH = nsswitch
 
 CFLAGS += -I../include -fPIC -D_GNU_SOURCE -DHAVE_TCP_WRAPPER -DNFS3_SUPPORTED
 
 .PHONY: all install clean
 
-all: autofs.a
+all: autofs.a nsswitch
 
 autofs.a: $(OBJS)
 	rm -f $(LIB)
@@ -49,8 +50,12 @@ listmount.o: listmount.c
 	$(CC) $(CFLAGS) -o listmount.o -c listmount.c
 	$(STRIP) listmount.o
 
+nsswitch: nsswitch.c
+	$(CC) $(CFLAGS) -DSTANDALONE -o nsswitch nsswitch.c -lnsl -lldap
+
 install: all
+	install -c nsswitch -m 755 $(INSTALLROOT)$(autofslibdir)
 
 clean:
-	rm -f $(LIB) $(RPCS) $(OBJS) *~
+	rm -f $(LIB) $(RPCS) $(OBJS) $(NSSWITCH) *~
 
diff --git a/lib/cache.c b/lib/cache.c
index e49edf0..0f71fe2 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -33,8 +33,6 @@ #include "automount.h"
 extern int kproto_version;	/* Kernel protocol major version */
 extern int kproto_sub_version;	/* Kernel protocol minor version */
 
-#define HASHSIZE      27
-
 struct ghost_context {
 	const char *root;
 	char *mapname;
@@ -43,8 +41,6 @@ struct ghost_context {
 	char mapent[MAPENT_MAX_LEN + 1];
 };
 
-static struct mapent_cache *mapent_hash[HASHSIZE];
-
 static unsigned long ent_check(struct ghost_context *gc, char **key, int ghost);
 
 static char *cache_fullpath(const char *root, const char *key)
@@ -169,6 +165,11 @@ int cache_add(const char *root, const ch
 	char *pkey, *pent;
 	unsigned int hashval = hash(key);
 
+	if (dumpmap) {
+		fprintf(stdout, "%s %s\n", key, mapent);
+		return CHE_OK;
+	}
+
 	me = (struct mapent_cache *) malloc(sizeof(struct mapent_cache));
 	if (!me)
 		return CHE_FAIL;
@@ -221,6 +222,11 @@ int cache_update(const char *root, const
 	char *pent;
 	int ret = CHE_OK;
 
+	if (dumpmap) {
+		fprintf(stdout, "%s %s\n", key, mapent);
+		return CHE_OK;
+	}
+
 	for (s = mapent_hash[hash(key)]; s != NULL; s = s->next)
 		if (strcmp(key, s->key) == 0)
 			me = s;
diff --git a/lib/nsswitch.c b/lib/nsswitch.c
index 277b8d4..6ff097f 100644
--- a/lib/nsswitch.c
+++ b/lib/nsswitch.c
@@ -1,23 +1,69 @@
+/*
+ * Copyright 2005,2006 Red Hat, Inc.
+ *
+ * Author: Chris Feist <cfeist@redhat.com>
+ *
+ */
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <syslog.h>
 #include <ctype.h>
+#include <unistd.h>
+#include <netdb.h>
+#include <errno.h>
+#include <ldap.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <unistd.h>
 #include <rpcsvc/ypclnt.h>
-#include <netdb.h>
 #include "automount.h"
 
 #define MODPREFIX "nsswitch: "
 
+#define MAPTYPE_FILE 1
+#define MAPTYPE_PROGRAM 2
+
+#ifndef FALSE
+#define FALSE 0
+#endif
+
+int underscore_to_dot = 0;
+
+static int isfilemap(const char *);
+static int isypmap(const char *);
+static int isldapmap(const char *);
+
+char *make_mapname(const char *loc, const char *type)
+{
+	int retsize, needs_etc = 0;
+	char *retval;
+
+	retsize = strlen(loc) + strlen(type) + 2;
+	if (*loc != '/') {
+		retsize += 5; /* "/etc/" */
+		needs_etc = 1;
+	}
+
+	retval = malloc(retsize);
+	if (!retval)
+		return NULL;
+
+	snprintf(retval, retsize, "%s:%s%s", type,
+		 needs_etc ? "/etc/" : "", loc);
+
+	return retval;
+}
+
 /*
  * Function which takes in a partial map name (ie. auto.misc), parses the
  * nsswitch.conf file and returns a valid map name (ie. yp:auto.misc or
- * file:/etc/auto.misc
+ * file:/etc/auto.misc).  "cur" is the current map we are reading.  This
+ * is used when determining the source of an included map.  For example.
+ * if we are parsing /etc/auto.master, and it has the line "+auto.master",
+ * we need to grab the auto.master from nis, if nis is specified in
+ * nsswitch.conf.
  */
-char *get_nsswitch_map(const char *loc)
+char *get_nsswitch_map(const char *loc, char *cur)
 {
 	char buf[1024];
 	char *ordering;
@@ -27,8 +73,9 @@ char *get_nsswitch_map(const char *loc)
 	int found_automount = 0;
 	char *retval = NULL;
 	int retsize = 0;
+	char *ypmapname = (char *)loc;
 
-	debug(MODPREFIX "called nsswitch with: '%s'", loc);
+	debug(MODPREFIX "called nsswitch with: '%s' '%s'", loc, cur);
 	nsswitch = fopen(_PATH_NSSWITCH_CONF, "r");
 	if (!nsswitch) {
 		error(MODPREFIX "Unable to open %s", _PATH_NSSWITCH_CONF);
@@ -51,41 +98,62 @@ char *get_nsswitch_map(const char *loc)
 	if (!found_automount)
 		return NULL;
 
+	/*
+	 *  We support an option to convert underscores to dots when looking
+	 *  up yp maps.
+	 */
+	if (underscore_to_dot) {
+		char *u;
+
+		ypmapname = strdup(loc);
+		if (!ypmapname)
+			return NULL;
+		while ((u = strchr(ypmapname, '_')))
+			*u = '.';
+	}
+
 	while (*ordering != '\0') {
-		while (isspace(*ordering)) ordering++;
+		while (isspace(*ordering) && (*ordering != '\0')) ordering++;
 		if (!strncmp(ordering, "files", 5)) {
 			switch (isfilemap(loc)) {
-				case MAPTYPE_FILE:
-					retsize = strlen(loc) + 11;
-					retval = malloc(retsize);
-					if (!retval)
-						return NULL;
-					snprintf(retval, retsize,
-							"file:/etc/%s", loc);
-					return retval;
-				case MAPTYPE_PROGRAM:
-					retsize = strlen(loc) + 14;
-					retval = malloc(retsize);
-					if (!retval)
-						return NULL;
-					snprintf(retval, retsize,
-							"program:/etc/%s", loc);
-					return retval;
-				default: // filemap doesn't exist
+			case MAPTYPE_FILE:
+				retval = make_mapname(loc, "file");
+				debug("comparing %s to %s\n", retval+5,cur);
+				if (cur && !strcmp(cur, retval+5)) {
+					free(retval);
+					retval = NULL;
+					break;
+				}
+				return retval;
+			case MAPTYPE_PROGRAM:
+				retval = make_mapname(loc, "program");
+				debug("comparing %s to %s\n", retval+5,cur);
+				if (cur && !strcmp(cur, retval+5)) {
+					free(retval);
+					retval = NULL;
 					break;
+				}
+				return retval;
+			default: // filemap doesn't exist
+				break;
 			}
 
 		} else if ((!strncmp(ordering, "yp", 2) ||
-					!strncmp(ordering,"nis", 3)) &&
-				isypmap(loc)) {
-			retsize = strlen(loc) + 4;
+			    !strncmp(ordering,"nis", 3)) &&
+			   isypmap(ypmapname)) {
+			retsize = strlen(ypmapname) + 4;
 			retval = malloc(retsize);
-			snprintf(retval, retsize, "yp:%s", loc);
+			snprintf(retval, retsize, "yp:%s", ypmapname);
+			return retval;
+		} else if (!strncmp(ordering, "ldap", 4) && isldapmap(loc)) {
+			retsize = strlen(loc) + 6;
+			retval = malloc(retsize);
+			snprintf(retval, retsize, "ldap:%s", loc);
 			return retval;
 		}
 		while (!isspace(*ordering) && (*ordering != '\0')) ordering++;
 	}
-	error(MODPREFIX "couldn't find map");
+	error(MODPREFIX "couldn't find map %s", loc);
 	return retval;
 }
 
@@ -95,22 +163,23 @@ char *get_nsswitch_map(const char *loc)
  * is executable and 0 if it doesn't exists or has incorrect permissions.
  */
 
-int isfilemap(const char *loc)
+static int isfilemap(const char *loc)
 {
 	struct stat st;
 	int ret = 0;	
 	char *realfilemap;
 
-	realfilemap = malloc(strlen(loc) + 6); /* '/etc/' + '\0' */
-	if (!realfilemap) {
-		crit(MODPREFIX "malloc failed.");
-		return 0;
-	}
-
-	snprintf(realfilemap, strlen(loc) + 6, "/etc/%s", loc);
-
-	ret = stat(realfilemap, &st);
-	free (realfilemap);
+	if (*loc != '/') {
+		realfilemap = malloc(strlen(loc) + 6); /* '/etc/' + '\0' */
+		if (!realfilemap) {
+			crit(MODPREFIX "malloc failed.");
+			return 0;
+		}
+		snprintf(realfilemap, strlen(loc) + 6, "/etc/%s", loc);
+		ret = stat(realfilemap, &st);
+		free(realfilemap);
+	} else
+		ret = stat(loc, &st);
 
 	if (!ret) {
 		if (st.st_uid != 0) {
@@ -124,6 +193,7 @@ int isfilemap(const char *loc)
 				return MAPTYPE_FILE;
 		}
 	}
+	debug(MODPREFIX "stat(%s) returned errno %d\n", loc, errno);
 	return 0;
 }
 
@@ -141,14 +211,164 @@ int isypmap(const char *loc)
 	unsigned int order;
 
 	if ((err = yp_get_default_domain(&domainname)) != YPERR_SUCCESS) {
-		error (MODPREFIX "unable to get default yp domain");
+		error(MODPREFIX "unable to get default yp domain");
 		return 0;
 	}
 	if ((err = yp_order(domainname, loc, &order)) != YPERR_SUCCESS) {
-		error (MODPREFIX "unable to find map, %s in domain, %s",
-				loc, domainname);
+		debug(MODPREFIX "unable to find map, %s in domain, %s",
+		      loc, domainname);
 		return 0;
 	}
 
 	return 1;
 }
+
+/*
+ *  boolean function: it returns 1 if 'mapname' exists in the ldap sever, and
+ *  0 if it can't be found.
+ */
+static int ldap_map_exists(const char *mapname,
+			   const char *class, const char *attr)
+{
+	LDAP *ld = NULL;
+	LDAPControl *server = NULL, *client = NULL;
+	LDAPMessage *messages = NULL, *entry = NULL;
+	char *attrs[2];
+	char filter[LINE_MAX] = "";
+	int result, ret = 0;
+	int c;
+
+	/* Initialize the LDAP library, pointing it at the default server. */
+	ld = ldap_init(NULL, LDAP_PORT);
+	if (ld == NULL) {
+		crit(MODPREFIX "error initializing LDAP\n");
+		return 0;
+	}
+
+	/* Try to switch to protocol 3. */
+	c = 3;
+	if (ldap_set_option(ld, LDAP_OPT_PROTOCOL_VERSION, &c)
+	    != LDAP_SUCCESS) {
+		/* Just retry with the default protocol version. */
+		ldap_unbind(ld);
+		ld = ldap_init(NULL, LDAP_PORT);
+		if (ld == NULL) {
+			crit(MODPREFIX "error initializing LDAP\n");
+			return 0;
+		}
+	}
+
+	/* Connect to the server anonymously. */
+	result = ldap_simple_bind_s(ld, NULL, NULL);
+	if (result != LDAP_SUCCESS) {
+		crit(MODPREFIX "error binding to ldap server: %s\n",
+		     ldap_err2string(result));
+		goto out;
+	}
+
+	/* We only want the key and value attributes from entries which
+	 * match the query we'll perform. */
+	attrs[0] = LDAP_NO_ATTRS;
+	attrs[1] = NULL;
+
+	/* Set the filter to only find the map we're looking at. */
+	snprintf(filter, sizeof(filter), "(&(objectclass=%s)(%s=%s))",
+		 class, attr, mapname);
+
+	debug(MODPREFIX "searching for map %s with filter %s\n",
+	      mapname, filter);
+	/* Perform a synchronous query to find the DN of the map. */
+	result = ldap_search_ext_s(ld, NULL,
+				   LDAP_SCOPE_SUBTREE,
+				   filter,
+				   attrs, FALSE,
+				   &server, &client,
+				   NULL,
+				   LDAP_NO_LIMIT,
+				   &messages);
+	if (result != LDAP_SUCCESS)
+		goto out;
+
+	/* We expected only one match.  Pull it from the results list. */
+	entry = ldap_first_entry(ld, messages);
+	if (entry != NULL)
+		ret = 1; /* success */
+
+out:
+	ldap_unbind(ld);
+	if (server)
+		ldap_control_free(server);
+	if (client)
+		ldap_control_free(client);
+	if (messages)
+		ldap_msgfree(messages);
+
+	return ret;
+
+}
+
+static int isldapmap(const char *loc)
+{
+	/*
+	 * search for the three schemas:
+	 *   (&(objectclass=nisMap)(nisMapName=%s))
+	 *   (&(objectclass=automountMap)(ou=%s))
+	 *   (&(objectclass=automountMap)(automountMapName=%s))
+	 */
+	if (ldap_map_exists(loc, "nisMap", "nisMapName")) {
+		debug(MODPREFIX "map %s found on the ldap server\n", loc);
+		return 1;
+	}
+	if (ldap_map_exists(loc, "automountMap", "ou")) {
+		debug(MODPREFIX "map %s found on the ldap server\n", loc);
+		return 1;
+	}
+	if (ldap_map_exists(loc, "automountMap", "automountMapName")) {
+		debug(MODPREFIX "map %s found on the ldap server\n", loc);
+		return 1;
+	}
+
+	debug(MODPREFIX "map %s not found on the ldap server\n", loc);
+	return 0;
+}
+
+#ifdef STANDALONE
+int do_debug = 0;
+
+void print_usage(const char *prog)
+{
+	fprintf(stderr, "Usage %s [-u] <mapname>\n", basename(prog));
+}
+
+int main(int argc, char **argv)
+{
+	char *map;
+	int  opt;
+
+	if (argc < 2) {
+		print_usage(argv[0]);
+		exit(1);
+	}
+
+	while ((opt = getopt(argc, argv, "u")) != -1) {
+		switch (opt) {
+		case 'u':
+			underscore_to_dot = 1;
+			break;
+		case '?':
+		default:
+			print_usage(argv[0]);
+			exit(1);
+
+		}
+	}
+
+	map = get_nsswitch_map(argv[optind], (char *)"auto.master");
+	if (!map)
+		exit(2);
+
+	fprintf(stdout, "%s\n", map);
+	free(map);
+	exit(0);
+}
+#endif
diff --git a/modules/Makefile b/modules/Makefile
index 1e5bece..f87721a 100644
--- a/modules/Makefile
+++ b/modules/Makefile
@@ -68,6 +68,10 @@ endif
 #
 # Ad hoc compilation rules for modules which need auxilliary libraries
 #
+lookup_file.so: lookup_file.c
+	$(CC) $(SOLDFLAGS) $(CFLAGS) -o lookup_file.so lookup_file.c $(AUTOFS_LIB) $(LIBNSL)
+	$(STRIP) lookup_file.so
+
 lookup_yp.so: lookup_yp.c
 	$(CC) $(SOLDFLAGS) $(CFLAGS) -o lookup_yp.so lookup_yp.c $(AUTOFS_LIB) $(LIBNSL)
 	$(STRIP) lookup_yp.so
diff --git a/modules/lookup_file.c b/modules/lookup_file.c
index 49d1155..b3881f6 100644
--- a/modules/lookup_file.c
+++ b/modules/lookup_file.c
@@ -24,15 +24,21 @@ #include <time.h>
 #include <ctype.h>
 #include <syslog.h>
 #include <signal.h>
+#include <dlfcn.h>
 #include <sys/param.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <rpcsvc/ypclnt.h>
 
 #define MODULE_LOOKUP
 #include "automount.h"
 
 #define MAPFMT_DEFAULT "sun"
 
+#define MAPTYPE_FILE	1
+#define MAPTYPE_YP	2
+#define MAPTYPE_LDAP	3
+
 #define MODPREFIX "lookup(file): "
 
 typedef enum {
@@ -42,13 +48,71 @@ typedef enum {
 typedef enum { got_nothing, got_star, got_real } FOUND_STATE;
 typedef enum { esc_none, esc_char, esc_val } ESCAPES;
 
+/*
+ *  This is the basic data structure used to store information about a map.
+ *
+ *  next:  linked list pointer pointing at the next map in the list.  There
+ *         will only be multiple entries in this list if there are included
+ *         maps (map entries of the form "+mapname").
+ *  name:  This is the expanded name of the map.  For example, given a map
+ *         entry "+auto.foo", this would be either "auto.foo" if it is resolved
+ *         to a yp map, or "/etc/auto.foo" if it is a file map.  The type of
+ *         map is determined by consulting the nsswitch.conf file.  The
+ *         expanded map name is stored so that we don't have to lookup the
+ *         file system path name more than once.  For an example of where
+ *         this is useful, see the map_modified function.
+ *  mapentry: If this is an included map, then this field represents the
+ *         name specified in the "+auto.xyz" entry.  It can be the same as
+ *         the "name" entry (annotated above) if the included map is a yp
+ *         map or specifies an absolute path.
+ *  type:  Either MAPTYPE_FILE (which includes both file maps and program
+ *         maps), MAPTYPE_YP, or MAPTYPE_LDAP.
+ *  u:     This union contains the maptype specific modification time.  For
+ *         file maps, this is simply the mtime.  For yp maps, we use the yp
+ *         order, or version number.  LDAP does not provide an easy way to
+ *         determine modification time, so we always assume the map has
+ *         changed.
+ *
+ *  When adding a map to the list, the name, type, and mapentry must be
+ *  specified.
+ */
+struct map {
+	struct map *next;
+	char *name;
+	char *mapentry;
+	int type;
+	union {
+		time_t mtime;
+		unsigned int order;
+	} u;
+};
 
 struct lookup_context {
 	const char *mapname;
-	time_t mtime;
 	struct parse_mod *parse;
+	struct map *maps; /* linked list of maps associated with ctxt */
+
+	/* The following are used for included yp maps */
+	void *yplib_dh; /* handle returned from dlopen */
+	lookup_one_t yp_lookup_one_included;
+	lookup_readmap_t yp_lookup_readmap_included;
+
+	void *ldaplib_dh;
+	lookup_one_t ldap_lookup_one_included;
+	lookup_readmap_t ldap_lookup_readmap_included;
 };
 
+static int read_map(const char *root, time_t now, struct lookup_context *ctxt);
+static int __read_map(char *, const char *,
+		      time_t, struct lookup_context *);
+static int __lookup_one(const char *map, const char *root, const char *key,
+			int key_len, struct lookup_context *ctxt);
+static int lookup_one(const char *root, const char *key, int key_len,
+		      struct lookup_context *ctxt);
+static int add_map(struct lookup_context *ctxt, int type, const char *mapname,
+		   const char *mapentry);
+unsigned int map_order(const char *mapname);
+
 int lookup_version = AUTOFS_LOOKUP_VERSION;	/* Required by protocol */
 
 int lookup_init(const char *mapfmt, int argc, const char *const *argv, void **context)
@@ -60,6 +124,7 @@ int lookup_init(const char *mapfmt, int 
 		crit(MODPREFIX "malloc: %m");
 		return 1;
 	}
+	memset(ctxt, 0, sizeof(*ctxt));
 
 	if (argc < 1) {
 		crit(MODPREFIX "No map name");
@@ -67,7 +132,6 @@ int lookup_init(const char *mapfmt, int 
 	}
 
 	ctxt->mapname = argv[0];
-
 	if (ctxt->mapname[0] != '/') {
 		crit(MODPREFIX "file map %s is not an absolute pathname",
 		       ctxt->mapname);
@@ -81,12 +145,9 @@ int lookup_init(const char *mapfmt, int 
 	}
 
 	if (stat(ctxt->mapname, &st)) {
-		crit(MODPREFIX "file map %s, could not stat",
-		       ctxt->mapname);
+		crit(MODPREFIX "could not stat file map: %s",  ctxt->mapname);
 		return 1;
 	}
-		
-	ctxt->mtime = st.st_mtime;
 
 	if (!mapfmt)
 		mapfmt = MAPFMT_DEFAULT;
@@ -96,10 +157,341 @@ int lookup_init(const char *mapfmt, int 
 	return !(ctxt->parse = open_parse(mapfmt, MODPREFIX, argc - 1, argv + 1));
 }
 
+static void recursion_detected(struct lookup_context *ctxt, const char *mapname)
+{
+	struct map *cur = ctxt->maps;
+
+	crit(MODPREFIX "Recursion in included maps detected.\n");
+	for (cur = ctxt->maps; cur; cur = cur->next)
+		crit(MODPREFIX "%s", cur->name);
+	crit(MODPREFIX "%s\n", mapname);
+}
+
+static void map_list_init(struct lookup_context *ctxt)
+{
+	struct map *cur, *next;
+
+	cur = ctxt->maps;
+	ctxt->maps = NULL;
+
+	while (cur) {
+		next = cur->next;
+		free(cur->name);
+		free(cur->mapentry);
+		free(cur);
+		cur = next;
+	}
+}
+
+/*
+ *  Add this map to the list of maps associated with this context.  Check
+ *  for recursion in included maps, here.
+ *
+ *  Returns 1 on success, 0 on failure.
+ */
+static int add_map(struct lookup_context *ctxt, int type, const char *mapname,
+	const char *mapentry)
+{
+	struct map *map, *cur, *tail;
+
+	debug(MODPREFIX "Adding map %s,%s\n", mapname, mapentry);
+	if (type < MAPTYPE_FILE || type > MAPTYPE_LDAP)
+		return 0;
+
+	map = malloc(sizeof(*map));
+	if (!map) {
+		crit("malloc of size %d failed while trying to read map %s."
+		     " Continuing, but map contents may not be complete.\n",
+		     sizeof(*map), mapname);
+		return 0;
+	}
+	memset(map, 0, sizeof(*map));
+
+	map->type = type;
+	map->name = strdup(mapname);
+	map->mapentry = strdup(mapentry);
+	if (!map->name || !map->mapentry) {
+		crit("memory allocation failed while trying read map %s."
+		     "  Continuing, but map contents may not be complete.\n",
+		     mapname);
+		free(map->name);
+		free(map->mapentry);
+		free(map);
+		return 0;
+	}
+
+	/* check for recursive includes */
+	for (cur = tail = ctxt->maps; cur; cur = cur->next) {
+		if (!strcmp(cur->name, mapname)) {
+			recursion_detected(ctxt, mapname);
+			free(map->name);
+			free(map);
+			return 0;
+		}
+		tail = cur;
+	}
+	if (tail)
+		tail->next = map;
+	else
+		ctxt->maps = map;
+
+	debug("added map name=\"%s\", entry=\"%s\" to context\n", map->name,
+	      map->mapentry);
+	return 1;
+}
+
+/*
+ *  Remove this map from the list of maps associated with this context.
+ *
+ *  Returns 1 on success, 0 on failure.
+ */
+static int del_map(struct lookup_context *ctxt, const char *mapname)
+{
+	struct map *cur, *prev = ctxt->maps;
+
+	for (cur = ctxt->maps; cur; cur = cur->next) {
+		if (strcmp(cur->name, mapname)) {
+			prev->next = cur->next;
+			free(cur->name);
+			free(cur);
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+static struct map *find_map_byname(struct lookup_context *ctxt, char *mapname)
+{
+	struct map *cur;
+
+	for (cur = ctxt->maps; cur; cur = cur->next) {
+		if (!strcmp(cur->name, mapname))
+			return cur;
+	}
+
+	return NULL;
+}
+
+static struct map *find_map_byentry(struct lookup_context *ctxt, char *entry)
+{
+	struct map *cur;
+
+	for (cur = ctxt->maps; cur; cur = cur->next) {
+		if (!strcmp(cur->mapentry, entry))
+			return cur;
+	}
+
+	return NULL;
+}
+
+static int init_yplib(struct lookup_context *ctxt)
+{
+	void *dh = NULL;
+ 	int yplib_len;
+	char *yplib_path;
+	char *error_string;
+	const char *yplib_name = "lookup_yp.so";
+
+
+	yplib_len = strlen(AUTOFS_LIB_DIR) + strlen(yplib_name);
+	yplib_path = alloca(yplib_len + 2);
+	if (!yplib_path) {
+		crit(MODPREFIX "unable to alloca memory");
+		return 0;
+	}
+	snprintf(yplib_path, yplib_len + 2, "%s/%s",AUTOFS_LIB_DIR,
+		 yplib_name);
+	if (!(dh = dlopen(yplib_path, RTLD_NOW))) {  
+		crit(MODPREFIX "cannot open yp lookup module (%s)",
+		     dlerror());
+		return 0;
+	}
+
+	dlerror(); /* clear any existing error */
+	ctxt->yp_lookup_one_included =
+		(lookup_one_t)dlsym(dh, "lookup_one_included");
+	error_string = dlerror();
+	if (error_string) {
+		crit(MODPREFIX "dlsym failed for symbol %s, error %s",
+		     "lookup_one_included", error_string);
+		dlclose(dh);
+		return 0;
+	}
+
+	ctxt->yp_lookup_readmap_included =
+		(lookup_readmap_t)dlsym(dh, "lookup_readmap_included");
+	error_string = dlerror();
+	if (error_string != NULL) {
+		crit(MODPREFIX "dlsym failed for symbol %s, error %s",
+		     "lookup_map_included", error_string);
+		dlclose(dh);
+		ctxt->yp_lookup_one_included = NULL;
+		return 0;
+	}	
+
+	ctxt->yplib_dh = dh;
+	return 1;
+}
+
+static int init_ldaplib(struct lookup_context *ctxt)
+{
+	void *dh = NULL;
+ 	int ldaplib_len;
+	char *ldaplib_path;
+	char *error_string;
+	const char *ldaplib_name = "lookup_ldap.so";
+
+
+	ldaplib_len = strlen(AUTOFS_LIB_DIR) + strlen(ldaplib_name);
+	ldaplib_path = alloca(ldaplib_len + 2);
+	if (!ldaplib_path) {
+		crit(MODPREFIX "unable to alloca memory");
+		return 0;
+	}
+	snprintf(ldaplib_path, ldaplib_len + 2, "%s/%s",AUTOFS_LIB_DIR,
+		 ldaplib_name);
+	if (!(dh = dlopen(ldaplib_path, RTLD_NOW))) {  
+		crit(MODPREFIX "cannot open ldap lookup module (%s)",
+		     dlerror());
+		return 0;
+	}
+
+	dlerror(); /* clear any existing error */
+	ctxt->ldap_lookup_one_included =
+		(lookup_one_t)dlsym(dh, "lookup_one_included");
+	error_string = dlerror();
+	if (error_string) {
+		crit(MODPREFIX "dlsym failed for symbol %s, error %s",
+		     "lookup_one_included", error_string);
+		dlclose(dh);
+		return 0;
+	}
+
+	ctxt->ldap_lookup_readmap_included =
+		(lookup_readmap_t)dlsym(dh, "lookup_readmap_included");
+	error_string = dlerror();
+	if (error_string != NULL) {
+		crit(MODPREFIX "dlsym failed for symbol %s, error %s",
+		     "lookup_map_included", error_string);
+		dlclose(dh);
+		ctxt->ldap_lookup_one_included = NULL;
+		return 0;
+	}	
+
+	ctxt->ldaplib_dh = dh;
+	return 1;
+}
+
+/*
+ *  Takes a string of the form "maptype:mapname" and returns an integer
+ *  maptype of either MAPTYPE_YP or MAPTYPE_FILE.  Returns -1 on error.
+ */
+static int maptype(const char *mapname)
+{
+	if (!strncmp(mapname, "yp:", 3))
+		return MAPTYPE_YP;
+	if (!strncmp(mapname, "file:", 5))
+		return MAPTYPE_FILE;
+	if (!strncmp(mapname, "ldap:", 5))
+		return MAPTYPE_LDAP;
+	return -1;
+}
+
+/*
+ *  Return Values:
+ *    CHE_OK      -  Success
+ *    CHE_FAIL    -  malloc or yp_get_default_domain failed, or there is no
+ *                   record of the mapname in the context->maps list, or the
+ *                   specified map type is invalid.
+ *    CHE_MISSING -  key does not exist in the map
+ *    CHE_UPDATED -  either the key was newly added to the cache, or the
+ *                   value associated with key changed.
+ *
+ */
+static int lookup_one_included(struct lookup_context *ctxt, char *map,
+			       const char *root, const char *key, int key_len)
+{
+	struct map *mt;
+
+	debug(MODPREFIX "lookup_one_included: looking for map %s, key %s\n",
+	      map, key);
+	mt = find_map_byentry(ctxt, map);
+	if (!mt) {
+		debug("find_map_byentry failed\n");
+		return CHE_FAIL;
+	}
+
+	switch (mt->type) {
+	case MAPTYPE_FILE:
+		return __lookup_one(mt->name, root, key, key_len, ctxt);
+
+	case MAPTYPE_YP:
+		if (!ctxt->yp_lookup_one_included && !init_yplib(ctxt))
+			return CHE_FAIL;
+		return ctxt->yp_lookup_one_included(map, root, key, key_len);
+	case MAPTYPE_LDAP:
+		if (!ctxt->ldap_lookup_one_included && !init_ldaplib(ctxt))
+			return CHE_FAIL;
+		return ctxt->ldap_lookup_one_included(map, root, key, key_len);
+	default:
+		break;
+	}
+
+	return CHE_FAIL;
+}
+
+/*
+ *  This function calls the maptype-specific read_map function.  For file
+ *  maps, that simply entails calling __read_map.  For yp maps, we have to
+ *  call into the yp module's lookup_map_included function.
+ *
+ *  Return values:
+ *
+ *    1 - Success
+ *    0 - Failure
+ */
+static int read_included_map(struct lookup_context *ctxt, char *map,
+			     int type, const char *root, time_t age)
+{
+	struct map *mt;
+
+	debug("read_included_map: %s\n", map);
+
+	if (map == NULL)
+		return 0;
+
+	mt = find_map_byname(ctxt, map);
+	if (!mt)
+		return 0;
+
+	switch (type) {
+	case MAPTYPE_FILE:
+		return __read_map(map, root, age, ctxt);
+	case MAPTYPE_YP:
+		if (!ctxt->yp_lookup_readmap_included && !init_yplib(ctxt))
+			return 0;
+
+		mt->u.order = map_order(map);
+		return ctxt->yp_lookup_readmap_included(map, root, age);
+	case MAPTYPE_LDAP:
+		if (!ctxt->ldap_lookup_readmap_included && !init_ldaplib(ctxt))
+			return 0;
+
+		return ctxt->ldap_lookup_readmap_included(map, root, age);
+	default:
+		error(MODPREFIX "maptype not recognized in map %s.\n", map);
+		error(MODPREFIX "valid map types include \"file:\" and \"yp:\"");
+		break;
+	}
+	return 0;
+}
+
 static int read_one(FILE *f, char *key, char *mapent)
 {
 	char *kptr, *p;
 	int mapent_len, key_len;
+	int is_plus_map = 0;
 	int ch, nch;
 	LOOKUP_STATE state;
 	FOUND_STATE getting, gotten;
@@ -141,6 +533,8 @@ static int read_one(FILE *f, char *key, 
 		switch (state) {
 		case st_begin:
 			if (!escape) {
+				if (ch == '+')
+					is_plus_map = 1;
 				if (isspace(ch));
 				else if (ch == '#')
 					state = st_badent;
@@ -159,9 +553,12 @@ static int read_one(FILE *f, char *key, 
 			break;
 
 		case st_compare:
-			if (ch == '\n')
-				state = st_begin;
-			else if (isspace(ch) && !escape) {
+			if (ch == '\n') {
+				if (is_plus_map)
+					goto got_it;
+				else
+					state = st_begin;
+			} else if (isspace(ch) && !escape) {
 				getting = got_real;
 				state = st_entspc;
 			} else if (escape == esc_char);
@@ -231,6 +628,8 @@ static int read_one(FILE *f, char *key, 
 		continue;
 
 	      got_it:
+		if (is_plus_map)
+			return 1;
 		if (gotten == got_nothing)
 			goto next;
 
@@ -249,7 +648,14 @@ static int read_one(FILE *f, char *key, 
 	return 0;
 }
 
-static int read_map(const char *root, time_t now, struct lookup_context *ctxt)
+/*
+ *  Return values:
+ *
+ *  1 - Success
+ *  0 - Failure
+ */
+static int __read_map(char *map, const char *root,
+		      time_t now, struct lookup_context *ctxt)
 {
 	char key[KEY_MAX_LEN + 1];
 	char mapent[MAPENT_MAX_LEN + 1];
@@ -257,25 +663,62 @@ static int read_map(const char *root, ti
 	FILE *f;
 	int  entry;
 	time_t age = now ? now : time(NULL);
+	struct stat st;
+	struct map *mt;
 
-	mapname = alloca(strlen(ctxt->mapname) + 6);
-	sprintf(mapname, "file:%s", ctxt->mapname);
+	mt = find_map_byname(ctxt, map);
+	if (!mt) {
+		crit(MODPREFIX "__read_map: requested map %s not found in"
+		     " lookup_context.\n", map);
+		return 0;
+	}
+	
+	if (stat(map, &st) < 0) {
+		error(MODPREFIX "stat failed on map %s with error %d\n",
+		      map, errno);
+		return 0;
+	}
+	mt->u.mtime = st.st_mtime;
 
-	f = fopen(ctxt->mapname, "r");
+	f = fopen(map, "r");
 	if (!f) {
-		error(MODPREFIX "could not open map file %s", ctxt->mapname);
+		error(MODPREFIX "could not open map file %s", map);
 		return 0;
 	}
 
 	while(1) {
 		entry = read_one(f, key, mapent);
-		if (entry)
+		if (entry && *key == '+') {
+			int type;
+			char *pathname;
+
+			debug("Looking for plus map: %s, root: %s", key, root);
+			mapname = get_nsswitch_map(key+1, mt->name);
+			if (!mapname)
+				continue;
+			type = maptype(mapname);
+
+			pathname = strchr(mapname, ':');
+			pathname++;
+
+			if (!add_map(ctxt, type, pathname, key+1)) {
+				free(mapname);
+				continue;
+			}
+
+			if (!read_included_map(ctxt, pathname, type, root, age)) {
+				debug("Unable to read included map: %s\n",
+				      key+1);
+				del_map(ctxt, key+1);
+			}
+			free(mapname);
+
+		} else if (entry)
 			cache_add(root, key, mapent, age);
 
 		if (feof(f))
 			break;
 	}
-
 	fclose(f);
 
 	/* Clean stale entries from the cache */
@@ -284,24 +727,39 @@ static int read_map(const char *root, ti
 	return 1;
 }
 
+/*
+ *  This is called for the top-level map.  That is to say, the one
+ *  specified on the command line.  Included maps go through the __read_map
+ *  function.  So, here we can make a valid assumption that the map type
+ *  is file.
+ */
+static int read_map(const char *root, time_t now, struct lookup_context *ctxt)
+{
+	if (!add_map(ctxt, MAPTYPE_FILE, ctxt->mapname, ctxt->mapname))
+		return 0;
+
+	if (!__read_map((char *)ctxt->mapname, root, now, ctxt)) {
+		del_map(ctxt, ctxt->mapname);
+		return 0;
+	}
+
+	return 1;
+}
+
 int lookup_ghost(const char *root, int ghost, time_t now, void *context)
 {
 	struct lookup_context *ctxt = (struct lookup_context *) context;
 	struct mapent_cache *me;
-	struct stat st;
 	int status = 1;
 
+	/* Clear out the map list.  This is necessary, as otherwise
+	 * subsequent calls to lookup_ghost (when re-reading maps, for
+	 * example) would result in a failure.
+	 */
+	map_list_init(ctxt);
 	if (!read_map(root, now, ctxt))
 		return LKP_FAIL;
 
-	if (stat(ctxt->mapname, &st)) {
-		crit(MODPREFIX "file map %s, could not stat",
-		       ctxt->mapname);
-		return 1;
-	}
-		
-	ctxt->mtime = st.st_mtime;
-
 	status = cache_ghost(root, ghost, ctxt->mapname, "file", ctxt->parse);
 
 	me = cache_lookup_first();
@@ -322,29 +780,36 @@ int lookup_ghost(const char *root, int g
 	return status;
 }
 
-static int lookup_one(const char *root,
-		      const char *key, int key_len,
-		      struct lookup_context *ctxt)
+static int __lookup_one(const char *map, const char *root, const char *key,
+			int key_len, struct lookup_context *ctxt)
 {
 	char mkey[KEY_MAX_LEN + 1];
 	char mapent[MAPENT_MAX_LEN + 1];
-	char *mapname;
 	FILE *f;
 	int entry;
+	int result = 0;
 	time_t age = time(NULL);
 
-	mapname = alloca(strlen(ctxt->mapname) + 6);
-	sprintf(mapname, "file:%s", ctxt->mapname);
-
-	f = fopen(ctxt->mapname, "r");
+	debug("__lookup_one: called with map \"%s\".", map);
+	f = fopen(map, "r");
 	if (!f) {
-		error(MODPREFIX "could not open map file %s", ctxt->mapname);
+		error(MODPREFIX "could not open map file %s", map);
 		return 0;
 	}
 
 	while(1) {
 		entry = read_one(f, mkey, mapent);
-		if (entry)
+
+		if (entry && *mkey == '+') {
+			debug("Looking for included map: %s", mkey);
+			result = lookup_one_included(ctxt, mkey+1,
+						     root, key, key_len);
+			if (result == CHE_OK || result == CHE_UPDATED) {
+				fclose(f);
+				return result;
+			}
+			debug("Unable to find %s in included map", mkey+1);
+		} else if (entry)
 			if (strlen(mkey) == key_len &&
 			    strncmp(mkey, key, key_len) == 0) {
 				fclose(f);
@@ -360,18 +825,21 @@ static int lookup_one(const char *root,
 	return CHE_MISSING;
 }
 
+static int lookup_one(const char *root,
+		      const char *key, int key_len,
+		      struct lookup_context *ctxt)
+{
+	return __lookup_one(ctxt->mapname, root, key, key_len, ctxt);
+}
+
 static int lookup_wild(const char *root, struct lookup_context *ctxt)
 {
 	char mkey[KEY_MAX_LEN + 1];
 	char mapent[MAPENT_MAX_LEN + 1];
-	char *mapname;
 	FILE *f;
 	int entry;
 	time_t age = time(NULL);
 
-	mapname = alloca(strlen(ctxt->mapname) + 6);
-	sprintf(mapname, "file:%s", ctxt->mapname);
-
 	f = fopen(ctxt->mapname, "r");
 	if (!f) {
 		error(MODPREFIX "could not open map file %s", ctxt->mapname);
@@ -395,10 +863,88 @@ static int lookup_wild(const char *root,
 	return CHE_MISSING;
 }
 
+/*
+ *  Routine which looks up the yp order (or version number) of the specified
+ *  map name.
+ *
+ *  Returns 0 on failure, or the map order on success.
+ */
+unsigned int map_order(const char *mapname)
+{
+	int err;
+	char *domainname;
+	unsigned int order;
+
+	if ((err = yp_get_default_domain(&domainname)) != YPERR_SUCCESS) {
+		error (MODPREFIX "unable to get default yp domain");
+		return 0;
+	}
+	if ((err = yp_order(domainname, mapname, &order)) != YPERR_SUCCESS) {
+		error (MODPREFIX "unable to find map, %s in domain, %s",
+				mapname, domainname);
+		return 0;
+	}
+
+	return order;
+}
+
+/*
+ *  Boolean function which tells whether the map, or any of the included
+ *  maps, has changed.
+ */
+int map_modified(struct lookup_context *ctxt)
+{
+	struct stat st;
+	struct map *mt;
+	unsigned int order;
+
+	/* walk through the list of maps to see if they've changed */
+	for (mt = ctxt->maps; mt; mt = mt->next) {
+		debug("checking for modifications to map %s\n", mt->name);
+		switch (mt->type) {
+		case MAPTYPE_YP:
+			/* test for != instead of >, because an error is
+			 * returned as 0 from map_order. */
+			order = map_order(mt->name);
+			debug("nis map %s order %u, last order %u\n",
+			      mt->name, order, mt->u.order);
+			if (order != mt->u.order)
+				return 1;
+			break;
+
+		case MAPTYPE_FILE:
+			if (stat(mt->name, &st)) {
+				crit(MODPREFIX
+				     "file map %s, stat returned %d.",
+				     mt->name, errno);
+				return 1;
+			}
+			debug("file map %s mtime %ld, last %ld\n", mt->name,
+			      st.st_mtime, mt->u.mtime);
+			if (st.st_mtime > mt->u.mtime)
+				return 1;
+			break;
+
+		case MAPTYPE_LDAP:
+			/* There is no easy way to tell if an ldap map was
+			 * modified.  So, we trigger a real lookup every
+			 * time. */
+			return 1;
+		default:
+			crit(MODPREFIX "Unrecognized map type %d\n", mt->type);
+		}
+	}
+
+	debug("map_modified: no changes\n");
+	return 0;
+}
+
+/*
+ *  Returns 0 on success, non-zero on failure.
+ */
 int lookup_mount(const char *root, const char *name, int name_len, void *context)
 {
 	struct lookup_context *ctxt = (struct lookup_context *) context;
-	struct stat st;
 	char key[KEY_MAX_LEN + 1];
 	int key_len;
 	char mapent[MAPENT_MAX_LEN + 1];
@@ -406,12 +952,7 @@ int lookup_mount(const char *root, const
 	time_t now = time(NULL);
 	time_t t_last_read;
 	int need_hup = 0;
-	int ret = 1;
-
-	if (stat(ctxt->mapname, &st)) {
-		crit(MODPREFIX "file map %s, could not stat", ctxt->mapname);
-		return 1;
-	}
+	int ret = 0;
 
 	if (ap.type == LKP_DIRECT)
 		key_len = snprintf(key, KEY_MAX_LEN, "%s/%s", root, name);
@@ -424,14 +965,12 @@ int lookup_mount(const char *root, const
 	me = cache_lookup_first();
 	t_last_read = me ? now - me->age : ap.exp_runfreq + 1;
 
-	/* only if it has been modified */
-	if (st.st_mtime > ctxt->mtime) {
+	/* only perform a real lookup if the map was modified */
+	if (map_modified(ctxt)) {
 		ret = lookup_one(root, key, key_len, ctxt);
 		if (!ret)
 			return 1;
 
-		debug("ret = %d", ret);
-
 		if (t_last_read > ap.exp_runfreq)
 			if (ret & (CHE_UPDATED | CHE_MISSING))
 				need_hup = 1;
@@ -478,6 +1017,9 @@ int lookup_done(void *context)
 {
 	struct lookup_context *ctxt = (struct lookup_context *) context;
 	int rv = close_parse(ctxt->parse);
+
+	if (ctxt->yplib_dh)
+		dlclose(ctxt->yplib_dh);
 	free(ctxt);
 	cache_release();
 	return rv;
diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
index 36fd8e2..3d0cba0 100644
--- a/modules/lookup_ldap.c
+++ b/modules/lookup_ldap.c
@@ -99,48 +99,34 @@ static LDAP *do_connect(struct lookup_co
 	return ldap;
 }
 
-/*
- * This initializes a context (persistent non-global data) for queries to
- * this module.  Return zero if we succeed.
- */
-int lookup_init(const char *mapfmt, int argc, const char *const *argv, void **context)
+struct lookup_context *context_init(const char *mapname)
 {
 	struct lookup_context *ctxt = NULL;
-	int l, rv;
-	LDAP *ldap;
+	int l;
 	char *ptr = NULL;
 
-	/* If we can't build a context, bail. */
-	ctxt = (struct lookup_context *) malloc(sizeof(struct lookup_context));
-	*context = ctxt;
+	ctxt = (struct lookup_context *)malloc(sizeof(struct lookup_context));
 	if (ctxt == NULL) {
 		crit(MODPREFIX "malloc: %m");
-		return 1;
+		return NULL;
 	}
 	memset(ctxt, 0, sizeof(struct lookup_context));
 
-	/* If a map type isn't explicitly given, parse it like sun entries. */
-	if (mapfmt == NULL) {
-		mapfmt = MAPFMT_DEFAULT;
-	}
-
-	/* Now we sanity-check by binding to the server temporarily. We have
-	 * to be a little strange in here, because we want to provide for
-	 * use of the "default" server, which is set in an ldap.conf file
-	 * somewhere. */
-
+	/* Now we sanity-check by binding to the server temporarily. Be
+	 * sure to allow for use of the "default" server, which is set in
+	 * an ldap.conf file somewhere. */
 	ctxt->server = NULL;
 	ctxt->port = LDAP_PORT;
 	ctxt->base = NULL;
 
-	ptr = (char *) argv[0];
-
+	ptr = (char *)mapname;
 	if (!strncmp(ptr, "//", 2)) {
 		char *s = ptr + 2;
 		char *p = NULL, *q = NULL;
 
-		/* Isolate the server's name and possibly port. But the : breaks
-		   the SUN parser for submounts so we can't actually use it.
+		/* Isolate the server's name and possibly port. But the :
+		   breaks the SUN parser for submounts so we can't actually
+		   use it.
 		 */
 		if ((q = strchr(s, '/'))) {
 			if ((p = strchr(s, ':'))) {
@@ -162,7 +148,7 @@ int lookup_init(const char *mapfmt, int 
 		/* Isolate the server's name. */
 		ctxt->server = malloc(l + 1);
 		memset(ctxt->server, 0, l + 1);
-		memcpy(ctxt->server, argv[0], l);
+		memcpy(ctxt->server, mapname, l);
 		ptr += l+1;
 	}
 
@@ -176,8 +162,30 @@ int lookup_init(const char *mapfmt, int 
 		  ctxt->server ? ctxt->server : "(default)",
 		  ctxt->port, ctxt->base);
 
+	return ctxt;
+}
+
+/*
+ * This initializes a context (persistent non-global data) for queries to
+ * this module.  Return zero if we succeed.
+ */
+int lookup_init(const char *mapfmt, int argc, const char *const *argv, void **context)
+{
+	struct lookup_context *ctxt = NULL;
+	LDAP *ldap;
+
+	/* If we can't build a context, bail. */
+	ctxt = context_init(argv[0]);
+	*context = ctxt;
+	if (ctxt == NULL)
+		return 1;
+
+	/* If a map type isn't explicitly given, parse it like sun entries. */
+	if (mapfmt == NULL)
+		mapfmt = MAPFMT_DEFAULT;
+
 	/* Initialize the LDAP context. */
-	ldap = do_connect(ctxt, &rv);
+	ldap = do_connect(ctxt, NULL);
 	if (!ldap)
 		return 1;
 
@@ -185,7 +193,7 @@ int lookup_init(const char *mapfmt, int 
 	ldap_unbind(ldap);
 
 	/* Open the parser, if we can. */
-	return !(ctxt->parse = open_parse(mapfmt, MODPREFIX, argc - 1, argv + 1));
+	return !(ctxt->parse = open_parse(mapfmt, MODPREFIX, argc-1, argv+1));
 }
 
 static int read_one_map(const char *root,
@@ -722,3 +730,71 @@ int lookup_done(void *context)
 	free(ctxt);
 	return rv;
 }
+
+/*
+ *  Check for an entry in an included ldap map.  Named lookup_one_included,
+ *  as it is the included map counterpart to lookup_one.
+ *
+ *  Return Values:
+ *    CHE_OK      -  Success
+ *    CHE_FAIL    -  malloc or yp_get_default_domain failed
+ *    CHE_MISSING -  key does not exist in the map
+ *    CHE_UPDATED -  either the key was newly added to the cache, or the
+ *                   value associated with key changed.
+ */
+int lookup_one_included(char *map, char *root, char *key, int key_len)
+{
+	struct lookup_context *ctxt;
+	int ret = 0;
+
+	ctxt = context_init(map);
+	if (!ctxt)
+		return CHE_FAIL;
+	ctxt->base = NULL;
+
+	ret = lookup_one(root, key, "nisObject", "cn", "nisMapEntry", ctxt);
+	if (ret & (CHE_UPDATED | CHE_OK))
+		goto done;
+
+	ret = lookup_one(root, key, "automount",
+			 "cn", "automountInformation", ctxt);
+	if (ret & (CHE_UPDATED | CHE_OK))
+		goto done;
+
+	ret = lookup_one(root, key, "automount", "automountKey",
+			 "automountInformation", ctxt);
+done:
+	free(ctxt->server);
+	free(ctxt->base);
+	free(ctxt);
+	return ret;
+}
+
+/*
+ *  Check for the existence of "map", and read in its contents if it
+ *  exists.  This is named lookup_map_included as it is the included map
+ *  counterpart to read_map.
+ *
+ *  Return Values:
+ *    1 - Success
+ *    0 - Failure: malloc, yp_get_default_domain, or the yp lookup failed.
+ */
+int lookup_readmap_included(char *map, char *root, time_t age)
+{
+	struct lookup_context *ctxt;
+	int rv = 0;
+
+	ctxt = context_init(map);
+	if (!ctxt)
+		return 0;
+	ctxt->base = NULL;
+
+	/* read_map returns 0 for failure, 1 for success */
+	rv = read_map(root, ctxt, NULL, 0, age, &rv);
+
+	free(ctxt->server);
+	free(ctxt->base);
+	free(ctxt);
+
+	return rv;
+}
diff --git a/modules/lookup_yp.c b/modules/lookup_yp.c
index b55d04a..d4cc4a0 100644
--- a/modules/lookup_yp.c
+++ b/modules/lookup_yp.c
@@ -50,30 +50,55 @@ struct callback_data {
 
 int lookup_version = AUTOFS_LOOKUP_VERSION;	/* Required by protocol */
 
-int lookup_init(const char *mapfmt, int argc, const char *const *argv, void **context)
+/*
+ *  Create a lookup context for the given map.
+ */
+struct lookup_context *context_init(const char *map)
 {
 	struct lookup_context *ctxt;
 	int err;
 
-	if (!(*context = ctxt = malloc(sizeof(struct lookup_context)))) {
-		crit(MODPREFIX "%m");
-		return 1;
+	if (map == NULL) {
+		crit(MODPREFIX "No map name");
+		return NULL;
 	}
 
-	if (argc < 1) {
-		crit(MODPREFIX "No map name");
-		return 1;
+	if (!(ctxt = malloc(sizeof(struct lookup_context)))) {
+		crit(MODPREFIX "%m");
+		return NULL;
 	}
-	ctxt->mapname = argv[0];
+	memset(ctxt, 0, sizeof(*ctxt));
+
+	ctxt->mapname = map;
 
 	/* This should, but doesn't, take a const char ** */
 	err = yp_get_default_domain((char **) &ctxt->domainname);
 	if (err) {
 		crit(MODPREFIX "map %s: %s\n", ctxt->mapname,
-		       yperr_string(err));
+				yperr_string(err));
+		free(ctxt);
+		return NULL;
+	}
+
+	return ctxt;
+}
+
+int lookup_init(const char *mapfmt, int argc, const char *const *argv, void **context)
+{
+	struct lookup_context *ctxt;
+
+	if (argc < 1) {
+		crit(MODPREFIX "No map name");
 		return 1;
 	}
 
+	ctxt = context_init(argv[0]);
+	if (!ctxt) {
+		crit(MODPREFIX "%m");
+		return 1;
+	}
+	*context = ctxt;
+
 	if (!mapfmt)
 		mapfmt = MAPFMT_DEFAULT;
 
@@ -123,7 +148,7 @@ static int read_map(const char *root, ti
 	err = yp_all((char *) ctxt->domainname, (char *) ctxt->mapname, &ypcb);
 
 	if (err != YPERR_SUCCESS) {
-		warn(MODPREFIX "lookup_ghost for %s failed: %s",
+		warn(MODPREFIX "read_map for %s failed: %s",
 		       root, yperr_string(err));
 		return 0;
 	}
@@ -161,6 +186,15 @@ int lookup_ghost(const char *root, int g
 	return status;
 }
 
+/*
+ *  Return Values:
+ *    CHE_OK      -  Success
+ *    CHE_FAIL    -  malloc or yp_get_default_domain failed
+ *    CHE_UPDATED -  either the key was newly added to the cache, or the
+ *                   value associated with key changed.
+ *    CHE_MISSING -  the key does not exist in the nis map
+ *    yp error code - negated error returned from yp_match.
+ */
 static int lookup_one(const char *root,
 		      const char *key, int key_len,
 		      struct lookup_context *ctxt)
@@ -238,11 +272,10 @@ int lookup_mount(const char *root, const
 
 	/* check map and if change is detected re-read map */
 	ret = lookup_one(root, key, key_len, ctxt);
-	if (!ret)
+	if (ret == CHE_FAIL)
 		return 1;
 
-	debug("ret = %d", ret);
-
+	/* was there a yp error? */
 	if (ret < 0) {
 		warn(MODPREFIX 
 		     "lookup for %s failed: %s", name, yperr_string(-ret));
@@ -308,3 +341,51 @@ int lookup_done(void *context)
 	cache_release();
 	return rv;
 }
+
+/*
+ *  Check for an entry in an included yp map.  Named lookup_one_included,
+ *  as it is the included map counterpart to lookup_one.
+ *
+ *  Return Values:
+ *    CHE_OK      -  Success
+ *    CHE_FAIL    -  malloc or yp_get_default_domain failed
+ *    CHE_MISSING -  key does not exist in the map
+ *    CHE_UPDATED -  either the key was newly added to the cache, or the
+ *                   value associated with key changed.
+ */
+int lookup_one_included(char *map, char *root, char *key, int key_len)
+{
+	struct lookup_context *ctxt;
+	int rv = 0;
+
+	ctxt = context_init(map);
+	if (!ctxt)
+		return CHE_FAIL;
+
+	rv = lookup_one(root, key, key_len, ctxt);
+	free(ctxt);
+	return rv;
+}
+
+/*
+ *  Check for the existence of "map", and read in its contents if it
+ *  exists.  This is named lookup_map_included as it is the included map
+ *  counterpart to read_map.
+ *
+ *  Return Values:
+ *    1 - Success
+ *    0 - Failure: malloc, yp_get_default_domain, or the yp lookup failed.
+ */
+int lookup_readmap_included(char *map, char *root, time_t age)
+{
+	struct lookup_context *ctxt;
+	int rv = 0;
+
+	ctxt = context_init(map);
+	if (!ctxt)
+		return 0;
+
+	rv = read_map(root, age, ctxt);
+	free(ctxt);
+	return rv;
+}
diff --git a/modules/parse_sun.c b/modules/parse_sun.c
index 2e95a45..9c8bca2 100644
--- a/modules/parse_sun.c
+++ b/modules/parse_sun.c
@@ -661,7 +661,7 @@ static int sun_mount(const char *root, c
 	 * to detect what type of map it is.
 	 */
 	if (!strcmp(fstype, "autofs") && strchr(loc, ':') == NULL) {
-		nsswitch_map = get_nsswitch_map(loc);
+		nsswitch_map = get_nsswitch_map(loc, NULL);
 		if (!nsswitch_map) {
 			error(MODPREFIX "unable to find map %s",loc);
 			return 1;
diff --git a/samples/rc.autofs.in b/samples/rc.autofs.in
index d00f2ab..27ef6bb 100644
--- a/samples/rc.autofs.in
+++ b/samples/rc.autofs.in
@@ -143,10 +143,11 @@ function getfilemounts()
             if [ "`echo $auto_master_in | grep '^+'`" = "" ]; then
                 echo $auto_master_in
             else
-                for nismap in `cat /etc/auto.master | grep '^\+' |
-                        sed -e '/^#/d' -e '/^$/d'`; do
-                    catnismap `echo "$nismap" | sed -e 's/^\+//'`
-                done
+		mapname=`echo $auto_master_in | sed -e 's/\+//g'`
+		expanded_mapname=`@@autofslibdir@@/nsswitch $mapname 2>/dev/null`
+		expanded_mapname=`echo $expanded_mapname | sed -e 's/:/ /g'`
+		: $DAEMON -D /bogus $expanded_mapname
+		$DAEMON -D /bogus $expanded_mapname
             fi
         done
         )
@@ -177,7 +178,7 @@ function getrawmounts()
             files)
                 if [ -z "$filescheme" ] ; then
                     FILEMOUNTS=`getfilemounts`
-                    if [ -n "$FILEMOUNTS" ] && [ "$ONE_AUTO_MASTER" -eq 1 ];
+                    if [ -n "$FILEMOUNTS" -o -f /etc/auto.master ] && [ "$ONE_AUTO_MASTER" -eq 1 ];
                     then
                         getfilemounts
                         return
@@ -333,24 +334,18 @@ function getmounts()
 		    elif [ "$map" = "multi" ] ; then
 			maptype=$map
 			map=
-#		    elif echo "$map" | grep -q '^!'; then
-#		        map=`echo "$map"| sed -e 's/^!//g'`
-		    elif `echo $map | grep -q "^/"` && [ -x "$map" ]; then
-			maptype=program
-		    elif [ -x "/etc/$map" ]; then
-			maptype=program
-			map=`echo /etc/$map | sed 's^//^/^g'`
-		    elif `echo $map | grep -q "^/"` && [ -f "$map" ]; then
-			maptype=file
-		    elif [ -f "/etc/$map" ]; then
-			maptype=file
-			map=`echo /etc/$map | sed 's^//^/^g'`
 		    else
-			maptype=yp
 			if [ "$UNDERSCORETODOT" = "1" ] ; then
-			    map=`basename $map | sed -e s/^auto_/auto./`
+			    nsswitch_opts="-u"
 			else
-			    map=`basename $map | sed 's^//^/^g'`
+			    nsswitch_opts=""
+			fi
+			nsswitch_output=`@@autofslibdir@@/nsswitch $nsswitch_opts $map 2>/dev/null`
+			if [ $? -eq 0 ]; then
+			    maptype=`echo $nsswitch_output | cut -d: -f 1`
+			    map=`echo $nsswitch_output | cut -d: -f 2`
+			else
+			    continue;
 			fi
 		    fi
 		fi
