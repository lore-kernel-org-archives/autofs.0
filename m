From: raven@themaw.net
Subject: Re: [PATCH 1/3] autofs4 - expiring filesystem from under process
Date: Wed, 20 Apr 2005 22:34:26 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504202227130.8800@donald.themaw.net>
References: <Pine.LNX.4.62.0504102044140.5212@donald.themaw.net>
 <16986.44640.269893.824019@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <16986.44640.269893.824019@segfault.boston.redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, autofs mailing list <autofs@linux.kernel.org>, Michael Blandford <michael@kmaclub.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On Mon, 11 Apr 2005, Jeff Moyer wrote:

> ==> Regarding [PATCH 1/3] autofs4 - expiring filesystem from under process; raven@themaw.net adds:
>
> Could also please explain how the following is handled:
>
> expire process runs and issues AUTOFS_EXPIRE_MULTI, which sets
> AUTOFS_INF_EXPIRING in flags.  While the expire is in progress, another
> process access the directory in question, causing a call to
> try_to_fill_dentry.  try_to_fill_dentry sees the AUTOFS_INF_EXPIRING flag
> is set, and so calls autofs4_wait with notify set to NFY_NONE.  However,
> when we take the wq sem, we find that the expire has finished, and thus
> create a new wq entry.  Because NFY_NONE is set, we don't tell the daemon.
>
> So how will this process ever get woken up?
>

I've thought about this for quite a while and I think all that's needed is 
to recognise that we're about to expire a dentry that's not mounted 
anymore.

Can you think of a case for which this patch fails?

Ian

--- linux-2.6.12-rc2-mm3/fs/autofs4/waitq.c.post-expire-race	2005-04-20 22:07:32.000000000 +0800
+++ linux-2.6.12-rc2-mm3/fs/autofs4/waitq.c	2005-04-20 22:08:29.000000000 +0800
@@ -191,6 +191,13 @@ int autofs4_wait(struct autofs_sb_info *
  	}

  	if ( !wq ) {
+		/* Can't expire if we are not mounted */
+		if (notify == NFY_EXPIRE && !d_mountpoint(dentry)) {
+			kfree(name);
+			up(&sbi->wq_sem);
+			return -ENOENT;
+		}
+
  		/* Create a new wait queue */
  		wq = kmalloc(sizeof(struct autofs_wait_queue),GFP_KERNEL);
  		if ( !wq ) {
