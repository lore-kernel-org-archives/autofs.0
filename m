From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] autofs4: fix compilation warning
Date: Sun, 12 Sep 2010 14:10:28 +0300
Message-ID: <1284289829-25425-2-git-send-email-felipe.contreras@gmail.com>
References: <1284289829-25425-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=tpaVFQodcwIWMVYuLuZ18V0tkjYQIEXI46Mf3+N3teA=;
        b=ooJPB0oYmqIIq1mhaB8DDr5yc2BWe0459CL+wuQwNtZcUSkRAhPMsxtF+9oH42thq3
         Gl76AmUgxS+NuZ1kkAtsafhfbtVTywLFGCNA72WLnM2A28cXZyhJ/22NL6pDFRjanWBr
         zqbnUGUoLJDjcUCwgeDOIsDai9BRecKHj4Ixs=
In-Reply-To: <1284289829-25425-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: linux-kernel@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Felipe Contreras <felipe.contreras@gmail.com>, Ian Kent <raven@themaw.net>, Andrew Morton <akpm@linux-foundation.org>, Frederic Weisbecker <fweisbec@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>, autofs@linux.kernel.org

fs/autofs4/root.c:31: warning: =E2=80=98autofs4_root_compat_ioctl=E2=80=
=99 declared =E2=80=98static=E2=80=99 but never defined

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 fs/autofs4/root.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index cb1bd38..87f22ae 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -28,7 +28,9 @@ static int autofs4_dir_unlink(struct inode *,struct d=
entry *);
 static int autofs4_dir_rmdir(struct inode *,struct dentry *);
 static int autofs4_dir_mkdir(struct inode *,struct dentry *,int);
 static long autofs4_root_ioctl(struct file *,unsigned int,unsigned lon=
g);
+#ifdef CONFIG_COMPAT
 static long autofs4_root_compat_ioctl(struct file *,unsigned int,unsig=
ned long);
+#endif
 static int autofs4_dir_open(struct inode *inode, struct file *file);
 static struct dentry *autofs4_lookup(struct inode *,struct dentry *, s=
truct nameidata *);
 static void *autofs4_follow_link(struct dentry *, struct nameidata *);
--=20
1.7.2.3
