From: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
Subject: [PATCH] autofs: only declare function when CONFIG_COMPAT is defined
Date: Mon, 13 Sep 2010 23:21:20 +0200
Message-ID: <4C8E95D0.9040502@freemail.hu>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: "H. Peter Anvin" <hpa@zytor.com>, autofs@linux.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>

=46rom: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>

The patch solves tohe following warnings message when CONFIG_COMPAT is =
not defined:
fs/autofs/root.c:30: warning: =E2=80=98autofs_root_compat_ioctl=E2=80=99=
 declared =E2=80=98static=E2=80=99 but never defined

Signed-off-by: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>
---
--- linux-2.6.36-rc4/fs/autofs/root.c.orig	2010-09-13 20:18:15.00000000=
0 +0200
+++ linux-2.6.36-rc4/fs/autofs/root.c	2010-09-13 21:02:11.000000000 +02=
00
@@ -27,7 +27,9 @@ static int autofs_root_unlink(struct ino
 static int autofs_root_rmdir(struct inode *,struct dentry *);
 static int autofs_root_mkdir(struct inode *,struct dentry *,int);
 static long autofs_root_ioctl(struct file *,unsigned int,unsigned long=
);
+#ifdef CONFIG_COMPAT
 static long autofs_root_compat_ioctl(struct file *,unsigned int,unsign=
ed long);
+#endif

 const struct file_operations autofs_root_operations =3D {
 	.llseek		=3D generic_file_llseek,
