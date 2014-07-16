From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/6] autofs4: support RCU-walk
Date: Wed, 16 Jul 2014 15:21:20 +0800
Message-ID: <1405495280.2527.84.camel@perseus.fritz.box>
References: <20140709233541.4525.25151.stgit@notabene.brown>
	 <1405481098.2527.9.camel@perseus.fritz.box>
	 <20140716160005.6c43668d@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=n294NOrBoIaOJcBGcz0m3Gp0Bzk=; b=wYu8uB/rAxbLlcnSPQuPGtkhFSbs
	T1cq4Bkhc9DQMuLDMJc6u7G3SBPSrZnYcPqQ+EPji1/4WjQubQ7sbIoSwf4S8VdH
	xeIhvp+qefSQbpp7trJbk37X0Mwy0+VsVyyIyBWuH7A5S5+UlQ58Rtq1JQPYDYBH
	LLajLVtVD2xOgi4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=n294NOrBoIaOJcBGcz0m3G
	p0Bzk=; b=uW4/repdRetz4TwHRsECvbm1eTMoO17nEHmq0nRzN8Uiq5BJb/bWdO
	/lrHQ3VzByF7V4pbr2raJuoa0/XJgNpOwJEQZ/n82OKIKmm6E7QPtlbi5tcMfEdp
	+5BrlkU00W8Wb7ZgGfNtP0sazZGTyKc9s8j/poU6wI/uhmEft06Ug=
In-Reply-To: <20140716160005.6c43668d@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.de>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2014-07-16 at 16:00 +1000, NeilBrown wrote:
> On Wed, 16 Jul 2014 11:24:58 +0800 Ian Kent <raven@themaw.net> wrote:
> 
> > On Thu, 2014-07-10 at 09:41 +1000, NeilBrown wrote:
> > > autofs4 currently doesn't support RCU-walk - it immediately
> > > aborts any attempt at RCU-walk to force REF-walk for path name
> > > lookup.
> > 
> > As discussed I don't have time to properly test these just now but I'll
> > do my best to review the patches and return to test them later.
> 
> Thanks.
> 
> > 
> > My impression is that you will be submitting these patches rather than
> > expecting me to pick them up and submit them. If that's not what your
> > expecting please let me know.
> 
> I had assumed that you would take them as you are listed as the maintainer.
> However if you would like me to send them on I can certainly do that.
> You seem to send via Andrew Morton so I'll do that when they seem to be ready
> if you like.

Either or, we can decide that once we're done with the patches.

I don't maintain an autofs tree because the module isn't volatile enough
to warrant it. I was sloppy with patches I sent to Linus a few times and
Andrew politely asked me to send them via him, and rightly so, ;)

I guess it comes down to how urgent it is to get these merged since I'd
like to hammer them with my submount test before passing them on and at
this point I don't know when I'll have time to work through that.

I could just set aside some time to run the test a few times and not try
and fix any problems at the time. Point being the test has a habit of
exposing problems that can be difficult to work out let alone fix.

Ian

