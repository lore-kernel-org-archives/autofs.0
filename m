From: Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH] autofs4: fix compilation without CONFIG_COMPAT
Date: Sat, 25 Feb 2012 23:10:35 +0100
Message-ID: <m2vcmuh8dg.fsf_-_@igel.home>
References: <CA+55aFzhS69QSoN1j+Z2md116u+3OfniAoE0QMo6xyBjDyjbEw@mail.gmail.com>
	<20120221.221609.218135609185671883.davem@davemloft.net>
	<CA+55aFwvmZGDzO_8wwYfH8HsLE=qCmLkJfeMyCe4PVvOYbDMHQ@mail.gmail.com>
	<CA+55aFzv3X3yW8WZGMZO+aKa=qWi2w8=zn2DP-Q3jRry8Ermyw@mail.gmail.com>
	<CA+55aFyh1NmBt0LwR3+iD6B-Xa8wAs-nGJ0MBouPhTzWUi8W5g@mail.gmail.com>
	<1329889428.2193.45.camel@perseus.themaw.net>
	<1329890027.2193.48.camel@perseus.themaw.net>
	<1329890251.2193.50.camel@perseus.themaw.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1329890251.2193.50.camel@perseus.themaw.net> (Ian Kent's message
	of "Wed, 22 Feb 2012 13:57:31 +0800")
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, autofs@vger.kernel.org, Thomas Meyer <thomas@m3y3r.de>, Al Viro <viro@zeniv.linux.org.uk>

The compat_daemon stuff is only needed on x86-64, and is_compat_task is
only defined with CONFIG_COMPAT, so disable it for all other
configurations.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 fs/autofs4/autofs_i.h  |    2 ++
 fs/autofs4/dev-ioctl.c |    2 ++
 fs/autofs4/inode.c     |    2 ++
 3 files changed, 6 insertions(+)

diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index eb1cc92..60439c2 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -110,7 +110,9 @@ struct autofs_sb_info {
 	int sub_version;
 	int min_proto;
 	int max_proto;
+#if defined(CONFIG_X86_64) && defined(CONFIG_COMPAT)
 	int compat_daemon;
+#endif
 	unsigned long exp_timeout;
 	unsigned int type;
 	int reghost_enabled;
diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index 85f1fcd..3ffff72 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -385,7 +385,9 @@ static int autofs_dev_ioctl_setpipefd(struct file *fp,
 		sbi->pipefd = pipefd;
 		sbi->pipe = pipe;
 		sbi->catatonic = 0;
+#if defined(CONFIG_X86_64) && defined(CONFIG_COMPAT)
 		sbi->compat_daemon = is_compat_task();
+#endif
 	}
 out:
 	mutex_unlock(&sbi->wq_mutex);
diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index 06858d9..5f3fb68 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -225,7 +225,9 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 	set_autofs_type_indirect(&sbi->type);
 	sbi->min_proto = 0;
 	sbi->max_proto = 0;
+#if defined(CONFIG_X86_64) && defined(CONFIG_COMPAT)
 	sbi->compat_daemon = is_compat_task();
+#endif
 	mutex_init(&sbi->wq_mutex);
 	mutex_init(&sbi->pipe_mutex);
 	spin_lock_init(&sbi->fs_lock);
-- 
1.7.9.2


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
