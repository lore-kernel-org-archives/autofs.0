From: Dan Carpenter <error27@gmail.com>
Subject: [patch] autofs4: remove unneeded null check in
	try_to_fill_dentry()
Date: Tue, 1 Jun 2010 09:15:50 +0200
Message-ID: <20100601071550.GI5483@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:date:from:to:cc:subject
	:message-id:mime-version:content-type:content-disposition:user-agent;
	bh=kaUVsUOAGKZ74MEHTFdeZyKx6SYYqWN4eRtvjUxDrJM=;
	b=qPc+ARZuV3rPITiI2ully22+Uggg8ix9wfO5uHNqDC+0/86JM/lwJ50t0gUZ1g4iPR
	F/7WISXJWZMPYEf3dm3Pro/HS5Yq5/zyd4X48sQ9BI4Be8KK+eKhUfZvqmvA4aF2y5I+
	OM8pt1SLLWR9bFkKYA8hPiFmIPGCaKmo7f/HQ=
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, kernel-janitors@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

After 97e7449a7ad: "autofs4: fix indirect mount pending expire race" we
know longer assumed that "ino" can be null.  The other null checks got
removed but this was one as missed.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index db4117e..5c0b93f 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -198,8 +198,7 @@ static int try_to_fill_dentry(struct dentry *dentry, int flags)
 	}
 
 	/* Initialize expiry counter after successful mount */
-	if (ino)
-		ino->last_used = jiffies;
+	ino->last_used = jiffies;
 
 	spin_lock(&sbi->fs_lock);
 	ino->flags &= ~AUTOFS_INF_PENDING;
