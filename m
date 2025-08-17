Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B54189;
	Sun, 17 Aug 2025 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755452866; cv=none; b=tglhslxJrGWdfm2RH+7BPM78fY8922U5JlALYzzFBFdJHIWQJA6V8QkcmJtdSnmNyqtX5XE7rsKrKaoC9+sGpt+/faoSeWCJo62DrhmZlwsiFBAnAL38af1UvVTDr95OxCT+4tgqjGQpwqQ9032Vmm2TfsObmP1pdsiouLqWZvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755452866; c=relaxed/simple;
	bh=Nb3p2/dQ3dd2RU2uehYUc8SwM1amhrKz8LeEUiVXMHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plveJcohLyTQrHmuY0PPCrwQ09JZuJuDtsh0Wkd16CVTKuyasiUF8zqT23fknYVvLelLMglWdJq51DzJn9OLgYtcnufks2ZKw1aGufPnfQimriTXxfZEluk0iSqsibtoJQokUhx+vNuZOYRoem4MXiVFBwtxDaNZzheU3p6v0wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ehq71RP1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ehq71RP1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pETT1V4Ybq1eUqs8XQoOTyrWdlzRYVHjm07CxdFZWwk=; b=ehq71RP1BHqMeC1TxwPR6osPq+
	Cn4FRwRVs1JA55vMPiGvQ6YNfyDjgCjPPB/RuUbDE5PdeBk1exhgMwdDBG/jIX5viGVIekkhg93Nk
	Zx1eX9ixuqd0myxUACTS64RUEHUu3DjCx7G8YhhIp0MYpDezj5j4QETfoO4fDe0N63wXHjIfX3TgB
	ugAd9Pn9eWjRkBmGckkP0FZZ4G8rRfa8Q0rGTc0vZVuGvalA4SMAEwPM/+WyoUex3+dsE9Qp7WweP
	/f+gEl5Ep9c2xEp8/miTiZrzSYe3O+vWbmYlYp1DU3WxkGMjPhNmXtWMJzB/nRZtcEX6hlYgMSW/I
	SFp+exfA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unhTp-0000000BSQ2-1MKz;
	Sun, 17 Aug 2025 17:47:41 +0000
Date: Sun, 17 Aug 2025 18:47:41 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spin_lock_irqsave() in autofs_write() is bogus
Message-ID: <20250817174741.GX222315@ZenIV>
References: <20250817163609.GV222315@ZenIV>
 <CAHk-=wj-NB_5KTCj7yhBsF145oLDuxQPt4J87tXsd6j+p3vzDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj-NB_5KTCj7yhBsF145oLDuxQPt4J87tXsd6j+p3vzDw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Aug 17, 2025 at 09:50:25AM -0700, Linus Torvalds wrote:
> On Sun, 17 Aug 2025 at 09:36, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >         That function should never be (and never is) called with irqs
> > disabled - we have an explicit mutex_lock() in there, if nothing else.
> > Which makes spin_lock_irqsave() use in there pointless - we do need to
> > disable irqs for ->siglock, but that should be spin_lock_irq().
> 
> I think we basically did the irqsave/restore version as the default
> when not wanting to think about the context.
>
> Your patch looks fine, but I doubt it's measurable outside of "it
> makes the code a few bytes smaller".
>
> So ACK on it, but I'm not convinced it's worth spending time actively
> _looking_ for these kinds of things.

It's obviously not a hot path of any sort; the only cost is head-scratching
of later readers.  OTOH, seeing that nobody had looked at it that one in
what, 28 years...

For another head-scratcher in that area: I started to look at __rcu sparse
noise, and ->sighand->siglock accesses had been quite a part of that.
current->sighand is obviously stable and should need no rcu_dereference(),
right?  So what the hell is
        rcu_read_lock();
	sighand = rcu_dereference(current->sighand);
	spin_lock_irqsave(&sighand->siglock, flags);
	recalc_sigpending();
	spin_unlock_irqrestore(&sighand->siglock, flags);
	rcu_read_unlock();
in net/sunrpc/svc.c:svc_unregister() about?  Is there something subtle I'm
missing there?  AFAICS, that came from 00a87e5d1d67 "SUNRPC: Address
RCU warning in net/sunrpc/svc.c" and commit message in there contains
no explanation beyond "sparse is complaining, let's make it STFU"...

Looking for ->sighand stores gives this:
fs/exec.c:1070:         rcu_assign_pointer(me->sighand, newsighand);
	store to current->sighand, called from begin_new_exec(), with
'me' set to current.
kernel/exit.c:215:      tsk->sighand = NULL;
	__exit_signal(), from release_task(), and if it's ever done
asynchronously to the current thread, we are really fucked (note that
we do *not* check that sighand is non-NULL in that snippet).
kernel/fork.c:1608:     RCU_INIT_POINTER(tsk->sighand, sig);
	copy_sighand(), from copy_process(), done to the child task
that is nowhere near running at that point.

So nothing weird has happened and that code looks very much like
a pointless head-scratcher.  Sure, the cost in execution time is
not going to be measurable, but the cost for readers is non-trivial...

FWIW, I suspect that the right way would be something like
static inline struct sighand_struct *current_sighand(void)
{
	return unrcu_pointer(current->sighand);
}
if unrcu_pointer is idiomatic in such case, plus conversion of open-coded
instances to it...
