From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] autofs4: Use wait_event_killable
Date: Mon, 19 Mar 2018 20:12:02 -0700
Message-ID: <20180320031202.GA22556@bombadil.infradead.org>
References: <20180319191609.23880-1-willy@infradead.org>
 <7dae3cc8-bad1-ec18-bcf1-ae91a87f74fa@themaw.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tjjk+rb/ftUaO9vkrqzDbtFa/l1wD5Rxr+D4zkm4h2E=; b=AHz9Y5jp9nPhLGsOha/5XD8KB
        u/u/3fcl+Nz2Dthloic9GfBdRpi4u3ANP6Zjz/gIDtlpZJPam4QCXyy2rU2qqayJk9OqA8LEAbkIT
        iuP6TjSn6LQB0/wc64U/q6DzMNPzPEMmjTTRCHc7FPR2k3PH212HB0cHxfbh6EnmlVmdlFrIqGewy
        v5zu6rgEhA/rO9bfxIyiYiV4p3+OilYmZmhu/NeIMlTloGP5Gm/mDofIPAadwyuvilZ18CXdKDNqm
        8wmkiDQU4yRtBzHfi5PMBuY1zHR8JkjOmb2MxzmAIsuhQ5JTzai7h6NJqFwD4T67tZztCoEEEbsyi
    
Content-Disposition: inline
In-Reply-To: <7dae3cc8-bad1-ec18-bcf1-ae91a87f74fa@themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 09:58:59AM +0800, Ian Kent wrote:
> On 20/03/18 03:16, Matthew Wilcox wrote:
> > From: Matthew Wilcox <mawilcox@microsoft.com>
> > This playing with signals to allow only fatal signals appears to predate
> > the introduction of wait_event_killable(), and I'm fairly sure that
> > wait_event_killable is what was meant to happen here.
> 
> Predates is an understatement, this is really, really old code.
> Do I need to forward this to Al or Andrew?

Looks like Andrew usually picks these up directly.  Here's the line
he'll want:

Link: http://lkml.kernel.org/r/20180319191609.23880-1-willy@infradead.org

> > Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> Signed-off-by: Ian Kent <raven@themaw.net>


> > +	wait_event_killable(wq->queue, wq->name.name == NULL);
> 
> The wait event code looks like this will wake up on most any unmasked signal.
> But my assumption is that TASK_KILLABLE tasks are only forwarded specific
> signals ...
> 
> Is that right or am I missing something?

The signal code is gnarly.  As far as I can decipher it, a fatal
signal is always turned into SIGKILL (in complete_signal()), and the
task is woken.  For a task sleeping in TASK_KILLABLE, signal_wake_up()
passes TASK_WAKEKILL to signal_wake_up_state() if the signal is SIGKILL.
TASK_KILLABLE sets (TASK_WAKEKILL | TASK_UNINTERRUPTIBLE) so it will be
woken in order to die.

If the signal being sent isn't sig_fatal(), then we don't wake the task.
The signal will still be in the pending set, so it can notice when
exiting to userspace, but it won't be woken.
