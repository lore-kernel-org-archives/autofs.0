From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 1/3] autofs4 - expiring filesystem from under
	process
Date: Mon, 11 Apr 2005 13:05:36 -0400
Message-ID: <16986.44640.269893.824019@segfault.boston.redhat.com>
References: <Pine.LNX.4.62.0504102044140.5212@donald.themaw.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0504102044140.5212@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: Andrew Morton <akpm@osdl.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Michael Blandford <michael@kmaclub.com>

==> Regarding [PATCH 1/3] autofs4 - expiring filesystem from under process; raven@themaw.net adds:

raven> autofs4-2.6.12-rc1-mm4-wait-order.patch

raven> It's possible for an event wait request to arive before the event
raven> requestor. If this happens the daemon never gets notified and autofs
raven> hangs.

I'm not sure I understand your problem description.  Could you please
elaborate on the set of circumstances that lead to this?

Could also please explain how the following is handled:

expire process runs and issues AUTOFS_EXPIRE_MULTI, which sets
AUTOFS_INF_EXPIRING in flags.  While the expire is in progress, another
process access the directory in question, causing a call to
try_to_fill_dentry.  try_to_fill_dentry sees the AUTOFS_INF_EXPIRING flag
is set, and so calls autofs4_wait with notify set to NFY_NONE.  However,
when we take the wq sem, we find that the expire has finished, and thus
create a new wq entry.  Because NFY_NONE is set, we don't tell the daemon.

So how will this process ever get woken up?

Thanks!

Jeff


raven> Signed-off-by: Ian Kent <raven@themaw.net>

raven> --- linux-2.6.12-rc1-mm4/fs/autofs4/waitq.c.wait-order	2005-04-03 12:30:14.000000000 +0800
raven> +++ linux-2.6.12-rc1-mm4/fs/autofs4/waitq.c	2005-04-03 12:31:57.000000000 +0800
raven> @@ -210,17 +210,8 @@ int autofs4_wait(struct autofs_sb_info *
wq-> len = len;
wq-> status = -EINTR; /* Status return if interrupted */
raven>   		atomic_set(&wq->wait_ctr, 2);
raven> +		atomic_set(&wq->notified, 1);
raven>   		up(&sbi->wq_sem);
raven> -
raven> -		DPRINTK("new wait id = 0x%08lx, name = %.*s, nfy=%d",
raven> -			(unsigned long) wq->wait_queue_token, wq->len, wq->name, notify);
raven> -		/* autofs4_notify_daemon() may block */
raven> -		if (notify != NFY_NONE) {
raven> -			autofs4_notify_daemon(sbi,wq, 
raven> -					notify == NFY_MOUNT ?
raven> -						  autofs_ptype_missing :
raven> -						  autofs_ptype_expire_multi);
raven> -		}
raven>   	} else {
raven>   		atomic_inc(&wq->wait_ctr);
raven>   		up(&sbi->wq_sem);
raven> @@ -229,6 +220,17 @@ int autofs4_wait(struct autofs_sb_info *
raven>   			(unsigned long) wq->wait_queue_token, wq->len, wq->name, notify);
raven>   	}

raven> +	if (notify != NFY_NONE && atomic_dec_and_test(&wq->notified)) {
raven> +		int type = (notify == NFY_MOUNT ? 
raven> +			autofs_ptype_missing : autofs_ptype_expire_multi);
raven> +
raven> +		DPRINTK(("new wait id = 0x%08lx, name = %.*s, nfy=%d\n",
raven> +			(unsigned long) wq->wait_queue_token, wq->len, wq->name, notify));
raven> +
raven> +		/* autofs4_notify_daemon() may block */
raven> +		autofs4_notify_daemon(sbi, wq, type);
raven> +	}
raven> +
raven>   	/* wq->name is NULL if and only if the lock is already released */

raven>   	if ( sbi->catatonic ) {
raven> --- linux-2.6.12-rc1-mm4/fs/autofs4/autofs_i.h.wait-order	2005-04-03 12:30:24.000000000 +0800
raven> +++ linux-2.6.12-rc1-mm4/fs/autofs4/autofs_i.h	2005-04-03 12:30:46.000000000 +0800
raven> @@ -84,6 +84,7 @@ struct autofs_wait_queue {
raven>   	char *name;
raven>   	/* This is for status reporting upon return */
raven>   	int status;
raven> +	atomic_t notified;
raven>   	atomic_t wait_ctr;
raven>   };
