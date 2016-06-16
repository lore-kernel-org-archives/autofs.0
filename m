From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs: don't stuck in a loop if vfs_write returns an error
Date: Thu, 16 Jun 2016 16:31:08 +0800
Message-ID: <20160616083108.6278.65815.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=7lZ
	d8zd94c9eHGfex7SozqQkXz4=; b=bKuWzCKg9Hdg+3d1Qb2o/TJGDY3DgLJKz38
	7uD7FwZDamq3v7fnf4NUddZz2YkfTzn5VvqlkiNAtERom190Iu5u3O5qiPw1jfM5
	RmssK2dKIVVkC9bVlgNcuHrAfXSTmmuVXad4JNnN6Eoa5I419hohKpHODczPoPT9
	RrG8fHhw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=7lZd8zd94c9eHGfex7SozqQkXz4=; b=EHO71
	1nxVxlxrg9gqzNJZYTZ+kW+xb4WuhpU/TYjjynwjrPRwUyrIzpKAzWONh/H9KFb2
	dJnN82TiQkkRPkZ3yex+WxlrDk5CHLGw7RqeJq2Wchvvj+jepdZUANkLjlibzgN7
	tdqNcD3S+DqF+WBbrz5xBXPi8P0g+j0lfSljEQ=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Andrey Vagin <avagin@openvz.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Andrey Vagin <avagin@openvz.org>

__vfs_write() returns a negative value in a error case.

Signed-off-by: Andrey Vagin <avagin@openvz.org>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/waitq.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index 0146d91..631f155 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -66,11 +66,12 @@ static int autofs4_write(struct autofs_sb_info *sbi,
 	set_fs(KERNEL_DS);
 
 	mutex_lock(&sbi->pipe_mutex);
-	wr = __vfs_write(file, data, bytes, &file->f_pos);
-	while (bytes && wr) {
+	while (bytes) {
+		wr = __vfs_write(file, data, bytes, &file->f_pos);
+		if (wr <= 0)
+			break;
 		data += wr;
 		bytes -= wr;
-		wr = __vfs_write(file, data, bytes, &file->f_pos);
 	}
 	mutex_unlock(&sbi->pipe_mutex);
 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
