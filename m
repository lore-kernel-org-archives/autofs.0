From: Ian Kent <raven@themaw.net>
Subject: [PATCH 1/8] autofs: refactor autofs_prepare_pipe()
Date: Thu, 21 Sep 2023 15:03:33 +0800
Message-ID: <169527981274.27328.17552761781465494402.stgit@donald.themaw.net>
References: <169527971702.27328.16272807830250040704.stgit@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <169527971702.27328.16272807830250040704.stgit@donald.themaw.net>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Al Viro <viro@ZenIV.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Bill O'Donnell <billodo@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, David Howells <dhowells@redhat.com>

Refactor autofs_prepare_pipe() by seperating out a check function
to be used later.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/autofs_i.h |   10 +++++++++-
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


