From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Subject: [PATCH] fix hesiod check error, use correct $(LIBS)
Date: Tue, 23 Jul 2013 23:59:37 +0800
Message-ID: <1374595177-24485-1-git-send-email-dennis.yxun@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=vf4uHUBtlWVo2McovPaZZcEp1M+WtBi/vl5GjWjLdl8=;
        b=R24bhzn26AXR2F4ZOCMTSA3hYe77VEQ+Kz+z11vA9LByPjXv+uYKeokgBwklEusRqJ
         Vopr4/m6XN0n9vk8UwvOv2MtrMbzV0r8NoCd9btdm7imY/Gct7/jOGA56VIAjDRTArB5
         9uheytIgsTpAE3swWx9e2uTMtxgZJsicYdJJHt/g/oegC9U5FdZ7wnNtDklhWGIoOXpT
         WB2FrGBUNIfai30oCX/aYEExjK0A6QymJ96Kh9+2/VqELTgJbsxzbwLCYU7ABJU8fDlx
         BeZ1D8gJrghImdJcWulZKPE79ztw4uvs6drKzf1rORocm7fOF589892sNBkQOHssN8qI
         +KCA==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: autofs@vger.kernel.org
Cc: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

=46rom: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

the problem here is that hesiod checking always fail due to wrong $(LDF=
LAGS),
no matter hesiod library is installed or not. moving "-lhesiod" into
$(LIBS) solve this problem.

1) convert "char *" -> "void *" to fix the compile warning
2) put "-lhesiod -lresolv" into $(LIBS), not into $(LDFLAGS), otherwise=
 we got link error

---
tst_hesiod.c: In function =E2=80=98main=E2=80=99:
tst_hesiod.c:38:3: warning: passing argument 1 of =E2=80=98hesiod_init=E2=
=80=99 from incompatible pointer type
[enabled by default]
   char *c; hesiod_init(&c);
   ^
In file included from tst_hesiod.c:34:0:
/usr/include/hesiod.h:36:5: note: expected =E2=80=98void **=E2=80=99 bu=
t argument is of type =E2=80=98char **=E2=80=99
 int hesiod_init(void **context);



$ x86_64-pc-linux-gnu-gcc -o conftest -O2 -pipe -march=3Dcore2  -I/usr/=
include
 -Wl,-O1 -Wl,--as-needed -g -lhesiod -lresolv tst_hesiod.c -L/usr/lib64
 -lkrb5 -lhx509 -lcom_err -lhcrypto -lasn1 -lwind -lheimbase -lroken
-lcrypt -ldl -lresolv

/tmp/ccN6GW0r.o: In function `main':
/root/tst_hesiod.c:38: undefined reference to `hesiod_init'
collect2: error: ld returned 1 exit status

Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
---
 aclocal.m4 | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/aclocal.m4 b/aclocal.m4
index 7a8b03c..637a775 100644
--- a/aclocal.m4
+++ b/aclocal.m4
@@ -316,20 +316,20 @@ dnl ---------------------------------------------=
-----------------------------
 AC_DEFUN([AF_CHECK_LIBHESIOD],
 [AC_MSG_CHECKING(for libhesiod)
=20
-# save current ldflags
-af_check_hesiod_save_ldflags=3D"$LDFLAGS"
-LDFLAGS=3D"$LDFLAGS -lhesiod -lresolv"
+# save current libs
+af_check_hesiod_save_libs=3D"$LIBS"
+LIBS=3D"$LIBS -lhesiod -lresolv"
=20
 AC_TRY_LINK(
   [ #include <hesiod.h> ],
-  [ char *c; hesiod_init(&c); ],
+  [ void *c; hesiod_init(&c); ],
   [ HAVE_HESIOD=3D1
     LIBHESIOD=3D"$LIBHESIOD -lhesiod -lresolv"
     AC_MSG_RESULT(yes) ],
   [ AC_MSG_RESULT(no) ])
=20
-# restore ldflags
-LDFLAGS=3D"$af_check_hesiod_save_ldflags"
+# restore libs
+LIBS=3D"$af_check_hesiod_save_libs"
 ])
=20
 dnl ------------------------------------------------------------------=
--------
--=20
1.8.2.1

