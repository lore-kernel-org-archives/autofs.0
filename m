From: Ian Kent <raven@themaw.net>
Subject: [PATCH 06/18] autofs - remove ino free in autofs4_dir_symlink()
Date: Fri, 12 Aug 2016 10:48:00 +0800
Message-ID: <20160812024759.12352.10653.stgit@pluto.themaw.net>
References: <20160812024734.12352.17122.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=Bk3fSnZrIcDVeTXWRvtk9T+LbSk=; b=ifHyZY
	6Gr0ThDtnBHJeIBhioQX8lO85TQssoF0ZD+l/OW3jiqrmxIhtBGfxYZ3P07wdt5X
	5tgctiofF1OaDgDJxt7Vqj+0t7qwLC3rcjr1wmZPjPZvs59ixSwGRqq52owLsXpq
	GbZ8G4N/uB/vGajm4iConTmgLYBpdQ6VvFCMY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Bk3fSnZrIcDVeTX
	WRvtk9T+LbSk=; b=OVPN5DrwpiU2rWiWfy2+a2Dv65O3bYGP+Wbnv8mSUhw3mjL
	Fhw2ZhA8cNxbeMtAlxyh52WY/1fEv5EkUNtcS4lJAkCgO/ZoUEioGKicxvZqYssW
	HVObJi4ytwILAGJ3GNpQUTIGo+W3IMY6Iix2lMJtZp02qrV6ZA3dJCKr2QLc=
In-Reply-To: <20160812024734.12352.17122.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

The inode allocation failure case in autofs4_dir_symlink() frees
the autofs dentry info of the dentry without setting ->d_fsdata to
NULL.

That could lead to a double free so just get rid of the free and
leave it to ->d_release().

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 fs/autofs4/root.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index fa84bb8..1b0495a 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -577,8 +577,6 @@ static int autofs4_dir_symlink(struct inode *dir,
 	inode = autofs4_get_inode(dir->i_sb, S_IFLNK | 0555);
 	if (!inode) {
 		kfree(cp);
-		if (!dentry->d_fsdata)
-			kfree(ino);
 		return -ENOMEM;
 	}
 	inode->i_private = cp;

