From: Andrei Vagin <avagin@virtuozzo.com>
Subject: Re: [PATCH] autofs4: use wake_up() instead of wake_up_interruptible
Date: Sat, 31 Mar 2018 23:21:18 -0700
Message-ID: <20180401062117.GA27067@outlook.office365.com>
References: <20180331022839.21277-1-avagin@openvz.org>
 <ebdc431d-cea8-378c-aae5-3b7441bb93c0@themaw.net>
 <8d578e49-c1a0-a38d-3b91-f0a07de0089b@themaw.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0iRSb8KmhJdCQ1fZueqn0WelcKYfY8NlwUoi2z1Mb1g=;
 b=YkAQOoyRJ/HNggEmYO4BYLVa/sbOoTY+qkPiBPeyX0orcxKVjAf2F88A6N3UgwrtKQN3fWaxCCTsJQTov2fjGFWeeBgtHC9KgTZH3Q4l3Yv8Fv7oS/ZH6KhTU4ZQlVVxszrAvQqHi52cRAw6HL+IPuCPjHVKdA/gMcAuw4J8x7U=
Content-Disposition: inline
In-Reply-To: <8d578e49-c1a0-a38d-3b91-f0a07de0089b@themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Andrei Vagin <avagin@openvz.org>, autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>

On Sun, Apr 01, 2018 at 10:01:41AM +0800, Ian Kent wrote:
> On 01/04/18 09:31, Ian Kent wrote:
> > On 31/03/18 10:28, Andrei Vagin wrote:
> >> In "autofs4: use wait_event_killable",  wait_event_interruptible() was
> >> replaced by wait_event_killable(), but in this case we have to use
> >> wake_up() instead of wake_up_interruptible().
> > 
> > Why do you believe wake_up() is needed rather than wake_up_interruptible()?
> > 
> > Now that I'm thinking about the wake up I'm wondering if this is in fact
> > what's needed. Rather, I think maybe wake_up_all() is probably the only
> > one that will actually do what's needed.
> 
> Ok, so that 1 is the number of exclusive waiters.
> So what is the difference between the two wake_up calls in this case?

In CRIU, we have the autofs test:
https://github.com/checkpoint-restore/criu/blob/master/test/zdtm/static/autofs.c

We run CRIU tests on the linux-next kernels and a few days ago this test
started to fail, actually it hangs up.

I found that wake_up_interruptible() doesn't wake up a thread, which is
waiting.

try_to_wake_up() has the argument "state", it is the mask of task states
that can be woken.

For wake_up_interruptible(), state is TASK_INTERRUPTIBLE.
For wake_up(). state is TASK_NORMAL (TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE)

If we use wait_event_killable(), the task sleeps in the TASK_KILLABLE
state, so wake_up_interruptible() isn't suitable in this case.

#define TASK_KILLABLE                   (TASK_WAKEKILL | TASK_UNINTERRUPTIBLE)

I checked that our test passes with this patch. I mean that we had a
real problem and we checked that it is fixed by this patch.

Thanks,
Andrei

> 
> > 
> > There's an individual wait queue for each mount, there can be multiple
> > waiters for a mount, they all should be woken up when the daemon signals
> > mount completion.
> > 
> >>
> >> Cc: Matthew Wilcox <mawilcox@microsoft.com>
> >> Cc: Ian Kent <raven@themaw.net>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> >> Signed-off-by: Andrei Vagin <avagin@openvz.org>
> >> ---
> >>  fs/autofs4/waitq.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
> >> index c160e9b3aa0f..be9c3dc048ab 100644
> >> --- a/fs/autofs4/waitq.c
> >> +++ b/fs/autofs4/waitq.c
> >> @@ -549,7 +549,7 @@ int autofs4_wait_release(struct autofs_sb_info *sbi, autofs_wqt_t wait_queue_tok
> >>  	kfree(wq->name.name);
> >>  	wq->name.name = NULL;	/* Do not wait on this queue */
> >>  	wq->status = status;
> >> -	wake_up_interruptible(&wq->queue);
> >> +	wake_up(&wq->queue);
> >>  	if (!--wq->wait_ctr)
> >>  		kfree(wq);
> >>  	mutex_unlock(&sbi->wq_mutex);
> >>
> > 
> 
