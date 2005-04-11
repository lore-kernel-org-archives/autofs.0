From: raven@themaw.net
Subject: Re: [PATCH 2/3] autofs4 - expiring filesystem from under process
Date: Mon, 11 Apr 2005 10:44:03 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504111029440.1345@donald.themaw.net>
References: <Pine.LNX.4.62.0504102048370.5212@donald.themaw.net>
 <20050410161520.19f67220.akpm@osdl.org>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20050410161520.19f67220.akpm@osdl.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: michael@kmaclub.com, linux-fsdevel@vger.kernel.org, jmoyer@redhat.com, autofs@linux.kernel.org

On Sun, 10 Apr 2005, Andrew Morton wrote:

> raven@themaw.net wrote:
>>
>> +	/* Is someone visiting anywhere in the tree ? */
>>  +	if (autofs4_may_umount(mnt))
>
> There's no such function in my tree...
>

Sorry about the hastle Andrew.
Thanks for the feedback. I'll make sure it doesn't happen again.

As far as the call above goes I'm unable to find when this was correct in 
the patch. I'm wondering how the kernel compiled (but that was a while 
back).

Everything else looks OK but I'll review the patches to make sure all is 
well.

The correct function call is

--- linux-2.6.12-rc2-mm2/fs/autofs4/expire.c.dumb	2005-04-11 10:24:28.000000000 +0800
+++ linux-2.6.12-rc2-mm2/fs/autofs4/expire.c	2005-04-11 10:37:27.000000000 +0800
@@ -100,7 +100,7 @@ static int autofs4_check_tree(struct vfs
  		return 0;

  	/* Is someone visiting anywhere in the tree ? */
-	if (autofs4_may_umount(mnt))
+	if (may_umount_tree(mnt))
  		return 0;

  	spin_lock(&dcache_lock);
