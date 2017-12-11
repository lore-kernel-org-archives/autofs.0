From: Ian Kent <raven@themaw.net>
Subject: [PATCH 05/27] autofs-5.1.3 - update configure to check for pipe2(2)
Date: Mon, 11 Dec 2017 16:58:02 +0800
Message-ID: <151298268293.19722.11358304834026204377.stgit@pluto.themaw.net>
References: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

In a bug report by John Salmon it appears that the use of __have_pipe2
isn't doing what's needed when checking for pipe2(2).

Hopefully updating configure to explicity check for pipe2(2), lifted
from John's patch, will be more reliable.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |    1 +
 configure           |   18 ++++++++++++++++++
 configure.in        |    2 ++
 include/automount.h |    2 +-
 include/config.h.in |    3 +++
 5 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index 34b596a6..bd9feb2a 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -38,6 +38,7 @@ xx/xx/2017 autofs-5.1.4
 - handle additional nfs versions in mount_nfs.c.
 - fix symlink option passthrough in mount_nfs.c.
 - fix ordering of seteuid/setegid in do_spawn().
+- update configure to check for pipe2(2).
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/configure b/configure
index c8b8da3c..d237abf6 100755
--- a/configure
+++ b/configure
@@ -2184,6 +2184,12 @@ ac_compiler_gnu=$ac_cv_c_compiler_gnu
 
 
 # for pkg-config macros
+# pkg.m4 - Macros to locate and utilise pkg-config.   -*- Autoconf -*-
+# serial 11 (pkg-config-0.29.1)
+
+
+
+
 
 
 
@@ -4161,6 +4167,18 @@ fi
 
 
 
+for ac_func in pipe2
+do :
+  ac_fn_c_check_func "$LINENO" "pipe2" "ac_cv_func_pipe2"
+if test "x$ac_cv_func_pipe2" = xyes; then :
+  cat >>confdefs.h <<_ACEOF
+#define HAVE_PIPE2 1
+_ACEOF
+
+fi
+done
+
+
 #
 # Newer mounts have the -s (sloppy) option to ignore unknown options,
 # good for portability
diff --git a/configure.in b/configure.in
index 085b34d5..261bff9f 100644
--- a/configure.in
+++ b/configure.in
@@ -165,6 +165,8 @@ AF_CHECK_SSS_LIB(SSS_AUTOFS, libsss_autofs.so)
 AC_SUBST(HAVE_SSS_AUTOFS)
 AC_SUBST(sssldir)
 
+AC_CHECK_FUNCS(pipe2)
+
 #
 # Newer mounts have the -s (sloppy) option to ignore unknown options,
 # good for portability
diff --git a/include/automount.h b/include/automount.h
index 39e685d1..8d3a3d72 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -685,7 +685,7 @@ static inline int open_pipe(int pipefd[2])
 {
 	int ret;
 
-#if defined(O_CLOEXEC) && defined(SOCK_CLOEXEC) && defined(__have_pipe2)
+#if defined(O_CLOEXEC) && defined(SOCK_CLOEXEC) && defined(HAVE_PIPE2)
 	if (cloexec_works != -1) {
 		ret = pipe2(pipefd, O_CLOEXEC);
 		if (ret != -1)
diff --git a/include/config.h.in b/include/config.h.in
index 6ed0d832..04873e8f 100644
--- a/include/config.h.in
+++ b/include/config.h.in
@@ -60,6 +60,9 @@
 /* define if the umount command supports the -c option */
 #undef HAVE_NO_CANON_UMOUNT
 
+/* Define to 1 if you have the `pipe2' function. */
+#undef HAVE_PIPE2
+
 /* define if the mount command supports the -s option */
 #undef HAVE_SLOPPY_MOUNT
 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
