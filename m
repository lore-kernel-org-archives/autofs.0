From: Ian Kent <raven@themaw.net>
Subject: [PATCH 03/19] autofs-5.1.3 - Add -c option when calling /bin/umount
 - if supported.
Date: Wed, 02 Aug 2017 10:17:20 +0800
Message-ID: <150164024079.6106.18279163605649166175.stgit@pluto.themaw.net>
References: <150164013844.6106.10264212633586462386.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150164013844.6106.10264212633586462386.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

From: NeilBrown <neilb@suse.com>

The "-c" option has been supported by umount since util-linux 2.17.

It tells umount that the path name is "canonical", meaning no symlinks
or ".." etc.

This is appropriate for autofs to use as it always uses canonical path
names. The advantage of "-c" is that it means umount doesn't need to
'lstat()' the path so much.

From util-linux 2.30, umount doesn't lstat the path at all when "-c"
is passed. This is particularly beneficial when unmounting an NFS
filesystem for which the server is no reachable. In that case an
'lstat()' will hang, but the umount(2) can succeed.

So check if "-c" is supported, and if so, use it.
Prior to 2.30 this doesn't help much, but doesn't hurt.
After 2.30 (and a similar small change to nfs-utils), "-c" will mean
that unmounting NFS filesystems will not hang.

Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |    1 +
 aclocal.m4          |   18 ++++++++++++++++++
 configure           |   33 +++++++++++++++++++++++++++++++++
 configure.in        |   14 ++++++++++++++
 daemon/spawn.c      |   23 +++++++++++++++--------
 include/config.h.in |    3 +++
 6 files changed, 84 insertions(+), 8 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 8d79bd60..91225cf0 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -1,6 +1,7 @@
 xx/xx/2017 autofs-5.1.4
 - fix spec file url.
 - fix unset tsd group name handling.
+- Add -c option when calling /bin/umount - if supported.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/aclocal.m4 b/aclocal.m4
index 00811e08..40e1ee97 100644
--- a/aclocal.m4
+++ b/aclocal.m4
@@ -73,6 +73,24 @@ AC_DEFUN(AF_SLOPPY_MOUNT,
   fi
 fi])
 
+dnl --------------------------------------------------------------------------
+dnl AF_NO_CANON_UMOUNT
+dnl
+dnl Check to see if umount(8) supports the no-canonicalize (-c) option, and define
+dnl the cpp variable HAVE_NO_CANON_UMOUNT if so.  This requires that UMOUNT is
+dnl already defined by a call to AF_PATH_INCLUDE or AC_PATH_PROGS.
+dnl --------------------------------------------------------------------------
+AC_DEFUN(AF_NO_CANON_UMOUNT,
+[if test -n "$UMOUNT" ; then
+  AC_MSG_CHECKING([if umount accepts the -c option])
+  if "$UMOUNT" -h 2>&1 | grep -e '-c.*--no-canonicalize' > /dev/null 2>&1 ; then
+    enable_no_canon_umount=yes
+    AC_MSG_RESULT(yes)
+  else
+    AC_MSG_RESULT(no)
+  fi
+fi])
+
 
 dnl --------------------------------------------------------------------------
 dnl AF_LINUX_PROCFS
diff --git a/configure b/configure
index 10f907e3..9ba26707 100755
--- a/configure
+++ b/configure
@@ -737,6 +737,7 @@ with_flagdir
 with_libtirpc
 with_dmalloc
 enable_sloppy_mount
+enable_no_canon_umount
 with_hesiod
 with_openldap
 with_sasl
@@ -1363,6 +1364,7 @@ Optional Features:
   --disable-FEATURE       do not include FEATURE (same as --enable-FEATURE=no)
   --enable-FEATURE[=ARG]  include FEATURE [ARG=yes]
   --enable-sloppy-mount         enable the use of the -s option to mount
+  --enable-no-canon-umount         enable the use of the -c option to umount
   --disable-ext-env	        disable search in environment for substitution variable
   --disable-mount-locking       disable use of locking when spawning mount command
   --enable-force-shutdown       enable USR1 signal to force unlink umount of any
@@ -3993,6 +3995,37 @@ $as_echo "#define HAVE_SLOPPY_MOUNT 1" >>confdefs.h
 
 fi
 
+#
+# Newer umounts have the -c (--no-canonicalize) option to avoid
+# stating the path and possible blocking.  Good for NFS.
+#
+# Check whether --enable-no-canon-umount was given.
+if test "${enable_no_canon_umount+set}" = set; then :
+  enableval=$enable_no_canon_umount;
+else
+  enable_no_canon_umount=auto
+fi
+
+if test x$enable_no_canon_umount = xauto; then
+	if test -n "$UMOUNT" ; then
+  { $as_echo "$as_me:${as_lineno-$LINENO}: checking if umount accepts the -c option" >&5
+$as_echo_n "checking if umount accepts the -c option... " >&6; }
+  if "$UMOUNT" -h 2>&1 | grep -e '-c.*--no-canonicalize' > /dev/null 2>&1 ; then
+    enable_no_canon_umount=yes
+    { $as_echo "$as_me:${as_lineno-$LINENO}: result: yes" >&5
+$as_echo "yes" >&6; }
+  else
+    { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
+$as_echo "no" >&6; }
+  fi
+fi
+fi
+if test x$enable_no_canon_umount = xyes; then
+
+$as_echo "#define HAVE_NO_CANON_UMOUNT 1" >>confdefs.h
+
+fi
+
 # LDAP SASL auth needs libxml and Kerberos
 for ac_prog in xml2-config
 do
diff --git a/configure.in b/configure.in
index 05212521..d408b209 100644
--- a/configure.in
+++ b/configure.in
@@ -167,6 +167,20 @@ if test x$enable_sloppy_mount = xyes; then
 	AC_DEFINE(HAVE_SLOPPY_MOUNT, 1, [define if the mount command supports the -s option])
 fi
 
+#
+# Newer umounts have the -c (--no-canonicalize) option to avoid
+# stating the path and possible blocking.  Good for NFS.
+#
+AC_ARG_ENABLE(no-canon-umount,
+[  --enable-no-canon-umount         enable the use of the -c option to umount],,
+	enable_no_canon_umount=auto)
+if test x$enable_no_canon_umount = xauto; then
+	AF_NO_CANON_UMOUNT()
+fi
+if test x$enable_no_canon_umount = xyes; then
+	AC_DEFINE(HAVE_NO_CANON_UMOUNT, 1, [define if the umount command supports the -c option])
+fi
+
 # LDAP SASL auth needs libxml and Kerberos
 AF_CHECK_LIBXML()
 AF_CHECK_KRB5()
diff --git a/daemon/spawn.c b/daemon/spawn.c
index c640d976..4515607b 100644
--- a/daemon/spawn.c
+++ b/daemon/spawn.c
@@ -592,6 +592,11 @@ int spawn_umount(unsigned logopt, ...)
 	char **argv, **p;
 	char prog[] = PATH_UMOUNT;
 	char arg0[] = PATH_UMOUNT;
+#ifdef HAVE_NO_CANON_UMOUNT
+	char * const arg_c = "-c";
+#else
+	char * const arg_c = NULL;
+#endif
 	char argn[] = "-n";
 	unsigned int options;
 	unsigned int retries = MTAB_LOCK_RETRIES;
@@ -620,19 +625,21 @@ int spawn_umount(unsigned logopt, ...)
 			update_mtab = 0;
 		}
 	}
+	if (arg_c)
+		argc++;;
 
-	if (!(argv = alloca(sizeof(char *) * argc + 1)))
+	if (!(argv = alloca(sizeof(char *) * (argc + 1))))
 		return -1;
 
-	argv[0] = arg0;
+	p = argv;
+	*p++ = arg0;
+	if (arg_c)
+		*p++ = arg_c;
+
+	if (!update_mtab)
+		*p++ = argn;
 
 	va_start(arg, logopt);
-	if (update_mtab)
-		p = argv + 1;
-	else {
-		argv[1] = argn;
-		p = argv + 2;
-	}
 	while ((*p++ = va_arg(arg, char *)));
 	va_end(arg);
 
diff --git a/include/config.h.in b/include/config.h.in
index e8885092..6ed0d832 100644
--- a/include/config.h.in
+++ b/include/config.h.in
@@ -57,6 +57,9 @@
 /* define if you have MOUNT_NFS */
 #undef HAVE_MOUNT_NFS
 
+/* define if the umount command supports the -c option */
+#undef HAVE_NO_CANON_UMOUNT
+
 /* define if the mount command supports the -s option */
 #undef HAVE_SLOPPY_MOUNT
 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
