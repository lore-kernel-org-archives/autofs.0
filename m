From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 1/3] autofs4 - expiring filesystem from under process
Date: Wed, 20 Apr 2005 17:03:13 -0400
Message-ID: <16998.50065.652052.980908@segfault.boston.redhat.com>
References: <Pine.LNX.4.62.0504102044140.5212@donald.themaw.net>
	<16986.44640.269893.824019@segfault.boston.redhat.com>
	<Pine.LNX.4.62.0504202227130.8800@donald.themaw.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0504202227130.8800@donald.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: Andrew Morton <akpm@osdl.org>, autofs mailing list <autofs@linux.kernel.org>, Michael Blandford <michael@kmaclub.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

==> Regarding Re: [PATCH 1/3] autofs4 - expiring filesystem from under process; raven@themaw.net adds:

raven> On Mon, 11 Apr 2005, Jeff Moyer wrote:
>> ==> Regarding [PATCH 1/3] autofs4 - expiring filesystem from under
>> process; raven@themaw.net adds:
>> 
>> Could also please explain how the following is handled:
>> 
>> expire process runs and issues AUTOFS_EXPIRE_MULTI, which sets
>> AUTOFS_INF_EXPIRING in flags.  While the expire is in progress, another
>> process access the directory in question, causing a call to
>> try_to_fill_dentry.  try_to_fill_dentry sees the AUTOFS_INF_EXPIRING
>> flag is set, and so calls autofs4_wait with notify set to NFY_NONE.
>> However, when we take the wq sem, we find that the expire has finished,
>> and thus create a new wq entry.  Because NFY_NONE is set, we don't tell
>> the daemon.
>> 
>> So how will this process ever get woken up?
>> 

raven> I've thought about this for quite a while and I think all that's
raven> needed is to recognise that we're about to expire a dentry that's
raven> not mounted anymore.

raven> Can you think of a case for which this patch fails?

I don't see how the patch you provided addresses the race between an expire
event and a lookup.  The real issue here is that the checking of
AUTOFS_INF_EXPIRING and the list operations associated therewith need to
happen atomically.  Until this happens, we will have races.

The attached patch is more in line with how I think the problem should be
fixed.  I have not yet tested or even compiled this.  Could you please look
this over and comment?

Do you have a reproducer test case for this, by the way?  That would be
vastly useful.

Thanks,

Jeff

--- linux-2.6.9/fs/autofs4/waitq.c.orig	2005-04-20 14:34:40.746320400 -0400
+++ linux-2.6.9/fs/autofs4/waitq.c	2005-04-20 16:39:34.543090128 -0400
@@ -161,6 +161,7 @@ int autofs4_wait(struct autofs_sb_info *
 		enum autofs_notify notify)
 {
 	struct autofs_wait_queue *wq;
+	struct autofs_info *de_info = autofs4_dentry_ino(dentry);
 	char *name;
 	int len, status;
 
@@ -183,6 +184,22 @@ int autofs4_wait(struct autofs_sb_info *
 		return -EINTR;
 	}
 
+	/*
+	 *  The following two notify values are special:
+	 *
+	 *  The only case in which we don:t want notification is when we
+	 *  are trying to fill a dentry and there is an expiry in process.
+	 *  So, we check if we are expiring inside the wq_sem to avoid
+	 *  races.  Notice that we moved the setting of AUTOFS_INF_EXPIRING
+	 *  to inside the lock, as well.
+	 */
+	if (notify & NFY_EXPIRE)
+		de_info->d_flags |= AUTOFS_INF_EXPIRING;
+
+	if (notify & NFY_NONE)
+		if (!de_info->d_flags & AUTOFS_INF_EXPIRING)
+			return NFY_NONE;
+
 	for (wq = sbi->queues ; wq ; wq = wq->next) {
 		if (wq->hash == dentry->d_name.hash &&
 		    wq->len == len &&
@@ -208,6 +225,7 @@ int autofs4_wait(struct autofs_sb_info *
 		wq->hash = dentry->d_name.hash;
 		wq->name = name;
 		wq->len = len;
+		wq->info = de_info;
 		wq->status = -EINTR; /* Status return if interrupted */
 		atomic_set(&wq->wait_ctr, 2);
 		up(&sbi->wq_sem);
@@ -287,6 +305,8 @@ int autofs4_wait_release(struct autofs_s
 	}
 
 	*wql = wq->next;	/* Unlink from chain */
+	/* at this point, expiries have finished */
+	wq->info->flags &= ~AUTOFS_INF_EXPIRING;
 	up(&sbi->wq_sem);
 	kfree(wq->name);
 	wq->name = NULL;	/* Do not wait on this queue */
--- linux-2.6.9/fs/autofs4/expire.c.orig	2005-04-20 15:11:41.940647536 -0400
+++ linux-2.6.9/fs/autofs4/expire.c	2005-04-20 16:00:13.627003928 -0400
@@ -343,13 +343,9 @@ int autofs4_expire_multi(struct super_bl
 		return -EFAULT;
 
 	if ((dentry = autofs4_expire(sb, mnt, sbi, do_now)) != NULL) {
-		struct autofs_info *de_info = autofs4_dentry_ino(dentry);
-
 		/* This is synchronous because it makes the daemon a
                    little easier */
-		de_info->flags |= AUTOFS_INF_EXPIRING;
 		ret = autofs4_wait(sbi, dentry, NFY_EXPIRE);
-		de_info->flags &= ~AUTOFS_INF_EXPIRING;
 		dput(dentry);
 	}
 		
--- linux-2.6.9/fs/autofs4/autofs_i.h.orig	2005-04-20 15:36:49.956394296 -0400
+++ linux-2.6.9/fs/autofs4/autofs_i.h	2005-04-20 16:41:50.617403688 -0400
@@ -82,6 +82,7 @@ struct autofs_wait_queue {
 	int hash;
 	int len;
 	char *name;
+	struct autofs_info *info;
 	/* This is for status reporting upon return */
 	int status;
 	atomic_t wait_ctr;
