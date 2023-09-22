From: Ian Kent <raven@themaw.net>
Subject: [PATCH 1/8] autofs: refactor autofs_prepare_pipe()
Date: Fri, 22 Sep 2023 12:12:08 +0800
Message-ID: <20230922041215.13675-2-raven@themaw.net>
References: <20230922041215.13675-1-raven@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1695355956; x=
        1695442356; bh=Orfn+zsuM68FHIsSvumK/hPQ+xdBHw1ePrGBE2OK2hE=; b=N
        KYYXYpo+MooxRerSaDOtajao5gkfFD5+zVqKlWdG3i+MqOgNeleLoTf1ioTDWBt4
        cLK1j77m9Kdl7lANkCB3XjzMkkHgs09hQO/JcgM90sLFjwyU7mtDsKZLH57y5Biw
        S6M6OJNKHwveFhh96Ldm3jtawickWqkZGzyb25UMboFLQyvKGmy9qFXNw7y8G8xQ
        pZc9iH5X8mFKGedwMfqVULjHjP7YgQ0MLLViGAlNvs5lhTLbQcE+zYA3F/J8s0xC
        L0aZz9Is7EoVd3l1bVMU8XAn5m317X6B3IDcWz7hvR+K3ERjrZ4y8pBXJTMqrvak
        SSbHhFScEWBauYveVkzEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1695355956; x=
        1695442356; bh=Orfn+zsuM68FHIsSvumK/hPQ+xdBHw1ePrGBE2OK2hE=; b=j
        GrLgkJVgl2gjOoYSv+olMjthDTifVDgMhEIPQfQkiLjFFb8IxesvOpYBcxAZVMiM
        GB42oY5qR29b72Y2Dd0sCXznDYB/HZhR5iHa4jbm2miBpHAd47H9L13hm+2zJK79
        zRdeZepjDLFBErFzI41QiDO1eM7Qw5QVZDiI7koHTQgV4Mgdavz65OzIm6+IakC6
        NeTeJcC0p5qJHfMjvDvJVpDk6zlSaKWGY0ISbetiIepW4GBWFRmYkslVDdU0qcXC
        Z0y1LhPPO5h9pIEp0b/O28CAXW5qJ0GMToFK4u6vy1jenpuuoLNQLCQMXnHFkyY4
        vQWUoXvdMry/wUy5IP/nQ==
In-Reply-To: <20230922041215.13675-1-raven@themaw.net>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Al Viro <viro@ZenIV.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Bill O'Donnell <billodo@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, David Howells <dhowells@redhat.com>, Ian Kent <raven@themaw.net>

Refactor autofs_prepare_pipe() by seperating out a check function
to be used later.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/autofs_i.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index d5a44fa88acf..c24d32be7937 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -209,12 +209,20 @@ int autofs_fill_super(struct super_block *, void *, int);
 struct autofs_info *autofs_new_ino(struct autofs_sb_info *);
 void autofs_clean_ino(struct autofs_info *);
 
-static inline int autofs_prepare_pipe(struct file *pipe)
+static inline int autofs_check_pipe(struct file *pipe)
 {
 	if (!(pipe->f_mode & FMODE_CAN_WRITE))
 		return -EINVAL;
 	if (!S_ISFIFO(file_inode(pipe)->i_mode))
 		return -EINVAL;
+	return 0;
+}
+
+static inline int autofs_prepare_pipe(struct file *pipe)
+{
+	int ret = autofs_check_pipe(pipe);
+	if (ret < 0)
+		return ret;
 	/* We want a packet pipe */
 	pipe->f_flags |= O_DIRECT;
 	/* We don't expect -EAGAIN */
-- 
2.41.0

