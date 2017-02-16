From: Timo Aaltonen <tjaalton@ubuntu.com>
Subject: [PATCH] Don't skip sssd autofs search if preseeded.
Date: Fri, 17 Feb 2017 00:19:40 +0200
Message-ID: <1487283580-7170-1-git-send-email-tjaalton@ubuntu.com>
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org

From: Adam Conrad <adconrad@ubuntu.com>

---
 aclocal.m4 | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/aclocal.m4 b/aclocal.m4
index 00811e0..c0e04d9 100644
--- a/aclocal.m4
+++ b/aclocal.m4
@@ -46,13 +46,13 @@ AC_DEFUN(AF_CHECK_SSS_LIB,
       fi
     fi
   done
-  if test -n "$sssldir"; then
-    HAVE_$1=1
-    AC_MSG_RESULT(yes)
-  else
-    HAVE_$1=0
-    AC_MSG_RESULT(no)
-  fi
+fi
+if test -n "$sssldir"; then
+  HAVE_$1=1
+  AC_MSG_RESULT(yes)
+else
+  HAVE_$1=0
+  AC_MSG_RESULT(no)
 fi])
 
 dnl --------------------------------------------------------------------------
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
