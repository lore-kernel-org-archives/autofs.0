From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Subject: [PATCH 1/2] seperate option of --with-systemd from install systemd unit file
Date: Mon, 19 Aug 2013 14:23:17 +0800
Message-ID: <1376893398-11765-2-git-send-email-dennis.yxun@gmail.com>
References: <1376893398-11765-1-git-send-email-dennis.yxun@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hJJYNBJ7hp2ZMj4lzwNLrShnL9pxMARSPyIyuvL+8Is=;
        b=KVKnbSZ/jBwIDIzcESJvXwVReuNCBt7WTic3pHXIO3uv0WGejDiqhkE488JGKYWiBh
         9Ix0ffAVAFvmbhOxgReuu5I95hRl2dN3AyRQMGtqpHlBgJl8hmAWezE4kWCghQEe1D/U
         UdvPPHdDkaCCCmQgAfnHYcfb5PFOnZw3Sq0QwtgbHJNsUA/iXqdFvDvgNZlBca1dSumo
         atc9s176lgP0tmI1y6jrrqBj+NpGYHyqYzAc3EQr1x+2yP8+1OKG7b8laGNZUAsvG6yr
         TIhvpeazlAd0JGPEXEApVjdyL4rUxs4rAaG7fh0pzNwtKJnivnBry5tyuEoWYp2mPmEn
         8yVw==
In-Reply-To: <1376893398-11765-1-git-send-email-dennis.yxun@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org
Cc: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

---
another patch will be instroduced "introduce new --with-systemdsystemunitdir"
I kept option --with-systemd here in case we may use it in the future,
but can be deleted if you think it not necessary, cause it's not useless now.

the default use case is "--with-systemd", so systemd enabled by default.

Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
---
 aclocal.m4          | 35 +++++++++++++++--------------------
 include/config.h.in |  3 +++
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/aclocal.m4 b/aclocal.m4
index c5de159..5cdc7e4 100644
--- a/aclocal.m4
+++ b/aclocal.m4
@@ -225,29 +225,24 @@ fi], [AC_MSG_RESULT(no)])
 dnl --------------------------------------------------------------------------
 dnl AF_WITH_SYSTEMD
 dnl
-dnl Check the location of the systemd unit files directory
+dnl Check if systemd support is wanted
 dnl --------------------------------------------------------------------------
 AC_DEFUN([AF_WITH_SYSTEMD],
-[AC_ARG_WITH(systemd,
-[  --with-systemd         install systemd unit file if systemd unit directory
-			  is found on system],
+[AC_MSG_CHECKING([if systemd support is wanted])
+AC_ARG_WITH(systemd,
+[  --with-systemd          enable systemd support, defaut is yes],
 [if test "$withval" = yes; then
-  if test -z "$systemddir"; then
-    AC_MSG_CHECKING([location of the systemd unit files directory])
-    for systemd_d in /usr/lib/systemd/system /usr/lib64/systemd/system /lib/systemd/system /lib64/systemd/system; do
-      if test -z "$systemddir"; then
-        if test -d "$systemd_d"; then
-          systemddir="$systemd_d"
-        fi
-      fi
-    done
-  fi
-  if test -n "$systemddir"; then
-    AC_MSG_RESULT($systemddir)
-  else
-    AC_MSG_RESULT(not found)
-  fi
-fi])
+  AC_MSG_RESULT(yes)
+  AC_DEFINE(WITH_SYSTMED,1,
+    [Define if systemd support is enabled])
+else
+  AC_MSG_RESULT(no)
+fi],
+[
+ AC_MSG_RESULT(yes)
+  AC_DEFINE(WITH_SYSTMED,1,
+    [Define if systemd support is enabled])
+])
 ])
 
 dnl --------------------------------------------------------------------------
diff --git a/include/config.h.in b/include/config.h.in
index a2a05a8..a03902f 100644
--- a/include/config.h.in
+++ b/include/config.h.in
@@ -152,3 +152,6 @@
 
 /* Define if using SASL authentication with the LDAP module */
 #undef WITH_SASL
+
+/* Define if systemd support is enabled */
+#undef WITH_SYSTMED
-- 
1.8.3.2

