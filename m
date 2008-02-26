From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 3/4] autofs4 - track uid and gid of last mount requestor
 - correction
Date: Tue, 26 Feb 2008 14:14:11 +0900 (WST)
Message-ID: <Pine.LNX.4.64.0802261410110.15583@raven.themaw.net>
References: <Pine.LNX.4.64.0802261151400.8490@raven.themaw.net>
 <Pine.LNX.4.64.0802261208400.8490@raven.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0802261208400.8490@raven.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On Tue, 26 Feb 2008, Ian Kent wrote:
> +
> +		/* Set mount requestor */
> +		if (ino) {
> +			if (ino) {
> +				ino->uid = wq->uid;
> +				ino->gid = wq->gid;
> +			}
> +		}
> +

As has been spotted, this is obviously wrong.
And here is the correction.

Signed-off-by: Ian Kent <raven@themaw.net>

Ian

---
diff -up linux-2.6.25-rc2-mm1/fs/autofs4/waitq.c.track-last-mount-ids-fix linux-2.6.25-rc2-mm1/fs/autofs4/waitq.c
--- linux-2.6.25-rc2-mm1/fs/autofs4/waitq.c.track-last-mount-ids-fix	2008-02-26 14:02:05.000000000 +0900
+++ linux-2.6.25-rc2-mm1/fs/autofs4/waitq.c	2008-02-26 14:02:20.000000000 +0900
@@ -385,10 +385,8 @@ int autofs4_wait(struct autofs_sb_info *
 
 		/* Set mount requestor */
 		if (ino) {
-			if (ino) {
-				ino->uid = wq->uid;
-				ino->gid = wq->gid;
-			}
+			ino->uid = wq->uid;
+			ino->gid = wq->gid;
 		}
 
 		if (de)
