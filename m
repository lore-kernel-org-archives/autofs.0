From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.4 15/16] autofs: set ctime as well when mtime changes on a dir
Date: Sun,  2 Jul 2023 15:38:14 -0400
Message-ID: <20230702193815.1775684-15-sashal@kernel.org>
References: <20230702193815.1775684-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326733;
        bh=Av03rwNzvIUGcDE3jFO/D0wlmqH+PZSBkTKuwNYnWDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dRUNNUE8zDOPrlUefVk0H+NBq1s/FQ5yGG0/+0sposdW0nvsq101pmid/E752siIO
         WBep7H9zMzdlPPUOCSAL1y459yLI2KcFv3u8J0gvkvZ00P1TdHbcLQZtTZ4YQqZM8G
         n5UDJ76J1k9fm2WHD97j5vdukaTpG82GSGobCvkAj6vGAMXAXURLpVZn5JPwC0tmhQ
         wap/tuQiurWl2j3J+G+NG2UNg/Fi0rSyWLZnSjuhsYzprdGrIpGi+xx0wyf1NVWvdK
         in2WN9Z6+M1E+Gs9MdUSh2ybDC61nIE/4h6X/HBy146Zaosdk3IDsI9yNh+3Y0YJhi
         jl6zK/44xN4vQ==
In-Reply-To: <20230702193815.1775684-1-sashal@kernel.org>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, Ian Kent <raven@themaw.net>, Christian Brauner <brauner@kernel.org>, Sasha Levin <sashal@kernel.org>, autofs@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 797a1d894d7b7586f422cabf8d7807cd39d0b5aa ]

When adding entries to a directory, POSIX generally requires that the
ctime also be updated alongside the mtime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Ian Kent <raven@themaw.net>
Message-Id: <20230612104524.17058-4-jlayton@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/autofs/root.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index 6baf90b08e0ef..93046c9dc4610 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -600,7 +600,7 @@ static int autofs_dir_symlink(struct mnt_idmap *idmap,
 	p_ino = autofs_dentry_ino(dentry->d_parent);
 	p_ino->count++;
 
-	dir->i_mtime = current_time(dir);
+	dir->i_mtime = dir->i_ctime = current_time(dir);
 
 	return 0;
 }
@@ -633,7 +633,7 @@ static int autofs_dir_unlink(struct inode *dir, struct dentry *dentry)
 	d_inode(dentry)->i_size = 0;
 	clear_nlink(d_inode(dentry));
 
-	dir->i_mtime = current_time(dir);
+	dir->i_mtime = dir->i_ctime = current_time(dir);
 
 	spin_lock(&sbi->lookup_lock);
 	__autofs_add_expiring(dentry);
@@ -749,7 +749,7 @@ static int autofs_dir_mkdir(struct mnt_idmap *idmap,
 	p_ino = autofs_dentry_ino(dentry->d_parent);
 	p_ino->count++;
 	inc_nlink(dir);
-	dir->i_mtime = current_time(dir);
+	dir->i_mtime = dir->i_ctime = current_time(dir);
 
 	return 0;
 }
-- 
2.39.2

