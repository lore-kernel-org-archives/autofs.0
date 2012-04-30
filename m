From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: autofs: make the autofsv5 packet file descriptor use a packetized
 pipe
Date: Mon, 30 Apr 2012 10:27:11 +0400
Message-ID: <4F9E30BF.4030704@msgid.tls.msk.ru>
References: <20120429205429.63CCD7C0064@ra.kernel.org> <4F9DD994.70202@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090904060603030509080403"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4F9DD994.70202@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Ian Kent <raven@themaw.net>, Thomas Meyer <thomas@m3y3r.de>, autofs@vger.kernel.org

This is a multi-part message in MIME format.
--------------090904060603030509080403
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> On 04/29/2012 01:54 PM, Linux Kernel Mailing List wrote:
>>     However, a prettier solution exists now thanks to the packetized pipe
>>     mode.  By marking the communication pipe as being packetized (by simply
>>     setting the O_DIRECT flag), we can always just write the bigger packet
>>     size, and if user-space does a smaller read, it will just get that
>>     partial end result and the extra alignment padding will simply be thrown
>>     away.

> +static inline int autofs_prepare_pipe(struct file *pipe)
> +{
> +	if (!pipe->f_op || !pipe->f_op->write)
> +		return -EINVAL;
> +	if (!S_ISFIFO(pipe->f_dentry->d_inode->i_mode))
> +		return -EINVAL;
> +	/* We want a packet pipe */
> +	pipe->f_flags |= O_DIRECT;
> +	return 0;
> +}
> +

@@ -376,7 +376,7 @@ static int autofs_dev_ioctl_setpipefd(st
 			err = -EBADF;
 			goto out;
 		}
-		if (!pipe->f_op || !pipe->f_op->write) {
+		if (autofs_prepare_pipe(pipe) < 0) {
 			err = -EPIPE;
 			fput(pipe);
 			goto out;

I've one more concern.  I'm not sure but I think there's some
risk still.  This packetizing gets applied to all VERSIONS of
the autofs PROTOCOL.  Which means it will be applied to the
lowest supported version (3) TOO, but did that version read
whole packets too?

Maybe something like the attached should be applied?

Thanks,

/mjt

--------------090904060603030509080403
Content-Type: text/x-patch;
 name="autofs-enable-workaround-for-v5-only.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="autofs-enable-workaround-for-v5-only.diff"

Enable packetized mode for autofs v5+ only

In commit 64f371bc3107e69efce563a3d0f0e6880de0d537 "autofs: make the
autofsv5 packet file descriptor use a packetized pipe", we enable
the packetized mode of the pipe unconditionally for all versions
of autofs protocol, but we actually only tested v5 version, and
it is unknown how it worked for previous versions of the protocol
and older binaries, who may actually read the packed piece by piece.
Enable the packetized mode only if client protocol is >= 5.

Note: the current function autofs_prepare_pipe() is called from 2
places which does the same thing with other fields of sbi structure,
so all this work may be put into a common function.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>


diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index 908e184..72e315a 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -269,14 +269,17 @@ int autofs4_fill_super(struct super_block *, void *, int);
 struct autofs_info *autofs4_new_ino(struct autofs_sb_info *);
 void autofs4_clean_ino(struct autofs_info *);
 
-static inline int autofs_prepare_pipe(struct file *pipe)
+static inline int autofs_prepare_pipe(struct autofs_sb_info *sbi,
+				       struct file *pipe)
 {
 	if (!pipe->f_op || !pipe->f_op->write)
 		return -EINVAL;
 	if (!S_ISFIFO(pipe->f_dentry->d_inode->i_mode))
 		return -EINVAL;
-	/* We want a packet pipe */
-	pipe->f_flags |= O_DIRECT;
+	if (sbi->version >= 5)
+		/* We want a packet pipe */
+		pipe->f_flags |= O_DIRECT;
+	sbi->pipe = pipe;
 	return 0;
 }
 
diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index aa9103f..cdf9dbc 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -376,14 +376,13 @@ static int autofs_dev_ioctl_setpipefd(struct file *fp,
 			err = -EBADF;
 			goto out;
 		}
-		if (autofs_prepare_pipe(pipe) < 0) {
+		if (autofs_prepare_pipe(sbi, pipe) < 0) {
 			err = -EPIPE;
 			fput(pipe);
 			goto out;
 		}
 		sbi->oz_pgrp = task_pgrp_nr(current);
 		sbi->pipefd = pipefd;
-		sbi->pipe = pipe;
 		sbi->catatonic = 0;
 	}
 out:
diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index 6e488eb..3b1eb5c 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -290,9 +290,8 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 		printk("autofs: could not open pipe file descriptor\n");
 		goto fail_dput;
 	}
-	if (autofs_prepare_pipe(pipe) < 0)
+	if (autofs_prepare_pipe(sbi, pipe) < 0)
 		goto fail_fput;
-	sbi->pipe = pipe;
 	sbi->pipefd = pipefd;
 	sbi->catatonic = 0;
 

--------------090904060603030509080403--
