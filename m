From: Joe MacDonald <joe@deserted.net>
Subject: [PATCH] systemd: allow --with-systemd to take a path arg
Date: Fri,  1 Nov 2013 14:08:38 -0400
Message-ID: <1383329318-23791-1-git-send-email-joe@deserted.net>
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org

If building for a cross-compile environment with systemd it is convenient
to be able to specify a systemd path for the target that may not be the
same as that on the host.

Signed-off-by: Joe MacDonald <joe@deserted.net>
---

I encountered a problem while working with autofs in a cross-compile
environment where the host and target have either differing systemd paths
or where one may not have systemd support at all.  The common solution
I've seen in other projects is to have a --with-systemddir=[path] option,
but I thought it'd be simpler to add an optional path argument to the
extant '--with-systemd' configure parameter and leave the default =y+probe
for path logic in place.

 aclocal.m4 |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/aclocal.m4 b/aclocal.m4
index 3e6f223..105e3e9 100644
--- a/aclocal.m4
+++ b/aclocal.m4
@@ -229,8 +229,10 @@ dnl Check the location of the systemd unit files directory
 dnl --------------------------------------------------------------------------
 AC_DEFUN([AF_WITH_SYSTEMD],
 [AC_ARG_WITH(systemd,
-[  --with-systemd         install systemd unit file if systemd unit directory
-			  is found on system],
+[  --with-systemd@<:@=systemddir@:>@  install systemd unit file.  If 'yes'
+			  probe the system for unit directory.
+			  If a path is specified, assume that
+			  is a valid install path.],
 [if test "$withval" = yes; then
   if test -z "$systemddir"; then
     AC_MSG_CHECKING([location of the systemd unit files directory])
@@ -247,6 +249,10 @@ AC_DEFUN([AF_WITH_SYSTEMD],
   else
     AC_MSG_RESULT(not found)
   fi
+else
+ if test "$withval" != no; then
+  systemddir=$withval
+ fi
 fi])
 ])
 
-- 
1.7.10.4

