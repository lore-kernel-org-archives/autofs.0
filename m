From: Chris Feist <cfeist@redhat.com>
Subject: [PATCH] check nsswitch.conf for submounts
Date: Wed, 23 Feb 2005 16:37:51 -0600
Message-ID: <421D05BF.5000206@redhat.com>
Reply-To: cfeist@redhat.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040007000204030605030207"
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
To: autofs@linux.kernel.org

This is a multi-part message in MIME format.
--------------040007000204030605030207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch addresses the problem if a user has the following in one of their 
automount maps:
# auto.misc
test 	-fstype=autofs    auto.m2

Before it would automatically assume that auto.m2 was a yp/nis map.  The patch 
now checks if the file exists in /etc/ (and if it's a file or program map) or 
if it exists in yp (according to the order in nsswitch.conf).

In the future we may want to include functionality in the lookup_xxx.so 
modules so we can more easily detect if a certain map exists.

Thanks,
Chris

--------------040007000204030605030207
Content-Type: text/x-patch; name="autofs-4.1.4-beta2-submount-nsswitch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="autofs-4.1.4-beta2-submount-nsswitch.patch"

diff -uNrp autofs-4.1.4-beta2.orig/include/automount.h autofs-4.1.4-beta2/include/automount.h
--- autofs-4.1.4-beta2.orig/include/automount.h	2005-02-23 16:32:05.607695789 -0600
+++ autofs-4.1.4-beta2/include/automount.h	2005-02-23 16:32:18.657490748 -0600
@@ -282,6 +282,14 @@ int is_mounted(const char *table, const 
 int has_fstab_option(const char *path, const char *opt);
 int allow_owner_mount(const char *);
 
+/* nsswitch parsing */
+#define MAPTYPE_FILE 1
+#define MAPTYPE_PROGRAM 2
+
+char *get_nsswitch_map(const char *);
+int isfilemap(const char *);
+int isypmap(const char *);
+
 /* log notification */
 extern int do_verbose;
 extern int do_debug;
diff -uNrp autofs-4.1.4-beta2.orig/lib/Makefile autofs-4.1.4-beta2/lib/Makefile
--- autofs-4.1.4-beta2.orig/lib/Makefile	2005-02-23 16:32:05.565696448 -0600
+++ autofs-4.1.4-beta2/lib/Makefile	2005-02-23 16:32:48.610020411 -0600
@@ -9,10 +9,10 @@ include ../Makefile.rules
 RPCGEN = /usr/bin/rpcgen
 RANLIB = /usr/bin/ranlib
 
-SRCS = cache.c listmount.c cat_path.c rpc_subs.c mounts.c lock.c
+SRCS = cache.c listmount.c cat_path.c rpc_subs.c mounts.c lock.c nsswitch.c
 RPCS = mount.h mount_clnt.c mount_xdr.c
 OBJS = cache.o mount_clnt.o mount_xdr.o listmount.o \
-	cat_path.o rpc_subs.o mounts.o lock.o
+	cat_path.o rpc_subs.o mounts.o lock.o nsswitch.o
 
 LIB = autofs.a
 
diff -uNrp autofs-4.1.4-beta2.orig/lib/Makefile.rej autofs-4.1.4-beta2/lib/Makefile.rej
--- autofs-4.1.4-beta2.orig/lib/Makefile.rej	2005-02-23 16:32:05.554696621 -0600
+++ autofs-4.1.4-beta2/lib/Makefile.rej	1969-12-31 18:00:00.000000000 -0600
@@ -1,22 +0,0 @@
-***************
-*** 9,17 ****
-  RPCGEN = /usr/bin/rpcgen
-  RANLIB = /usr/bin/ranlib
-  
-- SRCS = cache.c listmount.c cat_path.c rpc_subs.c
-  RPCS = mount.h mount_clnt.c mount_xdr.c
-- OBJS = cache.o mount_clnt.o mount_xdr.o listmount.o cat_path.o rpc_subs.o
-  
-  LIB = autofs.a
-  
---- 9,18 ----
-  RPCGEN = /usr/bin/rpcgen
-  RANLIB = /usr/bin/ranlib
-  
-+ SRCS = cache.c listmount.c cat_path.c rpc_subs.c nsswitch.c
-  RPCS = mount.h mount_clnt.c mount_xdr.c
-+ OBJS = cache.o mount_clnt.o mount_xdr.o listmount.o cat_path.o rpc_subs.o \
-+        nsswitch.o
-  
-  LIB = autofs.a
-  
diff -uNrp autofs-4.1.4-beta2.orig/lib/nsswitch.c autofs-4.1.4-beta2/lib/nsswitch.c
--- autofs-4.1.4-beta2.orig/lib/nsswitch.c	1969-12-31 18:00:00.000000000 -0600
+++ autofs-4.1.4-beta2/lib/nsswitch.c	2005-02-23 16:32:18.659490717 -0600
@@ -0,0 +1,154 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syslog.h>
+#include <ctype.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <rpcsvc/ypclnt.h>
+#include <netdb.h>
+#include "automount.h"
+
+#define MODPREFIX "nsswitch: "
+
+/*
+ * Function which takes in a partial map name (ie. auto.misc), parses the
+ * nsswitch.conf file and returns a valid map name (ie. yp:auto.misc or
+ * file:/etc/auto.misc
+ */
+char *get_nsswitch_map(const char *loc)
+{
+	char buf[1024];
+	char *ordering;
+	const char *automount_str = "automount:";
+	char *comment = NULL;
+	FILE *nsswitch;
+	int found_automount = 0;
+	char *retval = NULL;
+	int retsize = 0;
+
+	debug(MODPREFIX "called nsswitch with: '%s'", loc);
+	nsswitch = fopen(_PATH_NSSWITCH_CONF, "r");
+	if (!nsswitch) {
+		error(MODPREFIX "Unable to open %s", _PATH_NSSWITCH_CONF);
+		return NULL;
+	}
+
+	while ((ordering = fgets((char *)buf, sizeof(buf), nsswitch))) {
+		if ((comment = strchr(ordering,'#')))
+			*comment = '\0';
+		while (isspace(*ordering)) ordering++;
+		if (!strncmp(ordering, automount_str, sizeof(automount_str))) {
+			ordering += strlen(automount_str);
+			found_automount = 1;
+			break;
+		}
+	}
+
+	fclose(nsswitch);
+
+	if (!found_automount)
+		return NULL;
+
+	while (*ordering != '\0') {
+		while (isspace(*ordering)) ordering++;
+		if (!strncmp(ordering, "files", 5)) {
+			switch (isfilemap(loc)) {
+				case MAPTYPE_FILE:
+					retsize = strlen(loc) + 11;
+					retval = malloc(retsize);
+					if (!retval)
+						return NULL;
+					snprintf(retval, retsize,
+							"file:/etc/%s", loc);
+					return retval;
+				case MAPTYPE_PROGRAM:
+					retsize = strlen(loc) + 14;
+					retval = malloc(retsize);
+					if (!retval)
+						return NULL;
+					snprintf(retval, retsize,
+							"program:/etc/%s", loc);
+					return retval;
+				default: // filemap doesn't exist
+					break;
+			}
+
+		} else if ((!strncmp(ordering, "yp", 2) ||
+					!strncmp(ordering,"nis", 3)) &&
+				isypmap(loc)) {
+			retsize = strlen(loc) + 4;
+			retval = malloc(retsize);
+			snprintf(retval, retsize, "yp:%s", loc);
+			return retval;
+		}
+		while (!isspace(*ordering) && (*ordering != '\0')) ordering++;
+	}
+	error(MODPREFIX "couldn't find map");
+	return retval;
+}
+
+/*
+ * Function takes in a filename and tests if it exists in "/etc/"
+ * Returns: MAPTYPE_FILE if it is not executable, MAPTYPE_PROGRAM if it
+ * is executable and 0 if it doesn't exists or has incorrect permissions.
+ */
+
+int isfilemap(const char *loc)
+{
+	struct stat st;
+	int ret = 0;	
+	char *realfilemap;
+
+	realfilemap = malloc(strlen(loc) + 6); /* '/etc/' + '\0' */
+	if (!realfilemap) {
+		crit(MODPREFIX "malloc failed.");
+		return 0;
+	}
+
+	snprintf(realfilemap, strlen(loc) + 6, "/etc/%s", loc);
+
+	ret = stat(realfilemap, &st);
+	free (realfilemap);
+
+	if (!ret) {
+		if (st.st_uid != 0) {
+			error(MODPREFIX "file /etc/%s exists but is not"
+					" owned by root.", loc);
+			return 0;
+		} else if (st.st_mode & S_IRUSR) {
+			if (st.st_mode & S_IXUSR) 
+				return MAPTYPE_PROGRAM;
+			else
+				return MAPTYPE_FILE;
+		}
+	}
+	return 0;
+}
+
+/*
+ * Function takes in a yp map name and returns
+ * 1 if it exists or 0 if it doesn't.
+ *
+ * Some of this code borrowed from ypcat
+ */
+
+int isypmap(const char *loc)
+{
+	int err;
+	char *domainname;
+	int order;
+
+	if ((err = yp_get_default_domain(&domainname)) != YPERR_SUCCESS) {
+		error (MODPREFIX "unable to get default yp domain");
+		return 0;
+	}
+	if ((err = yp_order(domainname, loc, &order)) != YPERR_SUCCESS) {
+		error (MODPREFIX "unable to find map, %s in domain, %s",
+				loc, domainname);
+		return 0;
+	}
+
+	return 1;
+}
diff -uNrp autofs-4.1.4-beta2.orig/modules/Makefile autofs-4.1.4-beta2/modules/Makefile
--- autofs-4.1.4-beta2.orig/modules/Makefile	2005-02-23 16:32:05.545696763 -0600
+++ autofs-4.1.4-beta2/modules/Makefile	2005-02-23 16:32:18.659490717 -0600
@@ -86,3 +86,7 @@ lookup_ldap.so: lookup_ldap.c
 	$(CC) $(SOLDFLAGS) $(CFLAGS) $(LDAP_FLAGS) -o lookup_ldap.so \
 		lookup_ldap.c $(AUTOFS_LIB) $(LIBLDAP)
 	$(STRIP) lookup_ldap.so
+
+parse_sun.so: parse_sun.c
+	$(CC) $(SOLDFLAGS) $(CFLAGS) -o parse_sun.so parse_sun.c $(AUTOFS_LIB) $(LIBNSL)
+	$(STRIP) parse_sun.so
diff -uNrp autofs-4.1.4-beta2.orig/modules/parse_sun.c autofs-4.1.4-beta2/modules/parse_sun.c
--- autofs-4.1.4-beta2.orig/modules/parse_sun.c	2005-02-23 16:32:05.540696841 -0600
+++ autofs-4.1.4-beta2/modules/parse_sun.c	2005-02-23 16:32:18.661490685 -0600
@@ -566,6 +566,8 @@ static int sun_mount(const char *root, c
 	int rv;
 	char *mountpoint;
 	char *what;
+	char *nsswitch_map;
+	int newmaplen = 0;
 
 	if (*options == '\0')
 		options = NULL;
@@ -646,11 +648,17 @@ static int sun_mount(const char *root, c
 	memcpy(what, loc, loclen);
 	what[loclen] = '\0';
 
-	if (! strcmp(fstype, "autofs") && strchr(loc, ':') == NULL) {
-		what = alloca(loclen + 3 + 1); /* 1 for '0', 3 for yp: */
-		memcpy(what, "yp:", 3);
-		memcpy(what + 3, loc, loclen);
-		what[loclen + 3] = '\0';
+	/*
+	 * If we have an autofs map that doesn't contain a ':' then we need
+	 * to detect what type of map it is.
+	 */
+	if (! strcmp(fstype, "autofs") && strchr(loc, ':') == NULL &&
+			((nsswitch_map = get_nsswitch_map(loc)) != NULL)) {
+		newmaplen = strlen(nsswitch_map);
+		what = alloca(newmaplen + 1);
+		memcpy(what, nsswitch_map, newmaplen);
+		what[newmaplen] = '\0';
+		free (nsswitch_map);
 	} else {
 		what = alloca(loclen + 1);
 		memcpy(what, loc, loclen);

--------------040007000204030605030207
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------040007000204030605030207--

