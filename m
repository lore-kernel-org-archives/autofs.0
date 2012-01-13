From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch -next] autofs4: double lock typo in autofs4_write()
Date: Fri, 13 Jan 2012 17:41:13 +0300
Message-ID: <20120113144113.GA25667@elgon.mountain>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ian Kent <raven@themaw.net>, autofs@linux.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

The second mutex_lock() should be an unlock.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index 9ef5b29..da8876d 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -76,7 +76,7 @@ static int autofs4_write(struct autofs_sb_info *sbi,
 		data += wr;
 		bytes -= wr;
 	}
-	mutex_lock(&sbi->pipe_mutex);
+	mutex_unlock(&sbi->pipe_mutex);
 
 	set_fs(fs);
 
