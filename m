From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/7] autofs - make struct path const in autofs4_dir_open()
Date: Mon, 28 Nov 2016 10:11:54 +0800
Message-ID: <148029911386.27779.14131036159082881283.stgit@pluto.themaw.net>
References: <148029910861.27779.4517883721395202453.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=94Ogt+LkiVNgCMc
        /yc+KNocUitc=; b=UseRqgeNLKd8T6Iay46TIBvSxD32ibCv1mnUiDo9Tkr3oUB
        zeCuHUcO+1GKRvRuUeWGk9ACw9ysWTMGPcr//V8dDlv/ZUGpNjwn7u8XFpeSk7zG
        Q1Ge/HRMZrlYGApI8JJskxMjn/gnSfS8KvLXkxYnxPQpJHf6YcuIKvqfLl3Y=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        smtpout; bh=94Ogt+LkiVNgCMc/yc+KNocUitc=; b=fuzDXpdcIgzoaBdxm9hs
        rzCZQVfgAdM9Hsg0T6WJzlcjhNcvS5n8Qwj0lMTE9ZNpsdUnI018ONjPtGZefPeP
        1j3xndFIeG0DHkPNpHAtHeaQiGhWP/cEv35NrflA/HfJ+LSr4pHa47hQol94vXAh
        RRK2zYu/obQKubL5vmrHiKA=
In-Reply-To: <148029910861.27779.4517883721395202453.stgit@pluto.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Al Viro <viro@ZenIV.linux.org.uk>

From: Ian Kent <ikent@redhat.com>

There's no reason to copy the file->f_path in autofs4_dir_open() and
f_path is not modified so change it to a "const struct path *".

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Omar Sandoval <osandov@osandov.com>
---
 fs/autofs4/root.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index dd2ea5d..3e33f00 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -107,14 +107,14 @@ static int autofs4_dir_open(struct inode *inode, struct file *file)
 {
 	struct dentry *dentry = file->f_path.dentry;
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
-	struct path path;
+	const struct path *path;
 
 	pr_debug("file=%p dentry=%p %pd\n", file, dentry, dentry);
 
 	if (autofs4_oz_mode(sbi))
 		goto out;
 
-	path = file->f_path;
+	path = &file->f_path;
 
 	/*
 	 * An empty directory in an autofs file system is always a
@@ -126,7 +126,7 @@ static int autofs4_dir_open(struct inode *inode, struct file *file)
 	 * it.
 	 */
 	spin_lock(&sbi->lookup_lock);
-	if (!path_is_mountpoint(&path) && simple_empty(dentry)) {
+	if (!path_is_mountpoint(path) && simple_empty(dentry)) {
 		spin_unlock(&sbi->lookup_lock);
 		return -ENOENT;
 	}

