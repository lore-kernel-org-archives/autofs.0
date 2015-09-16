From: Ian Kent <raven@themaw.net>
Subject: Re: Mount point not auto unmounted after system date/time change
Date: Wed, 16 Sep 2015 19:21:40 +0800
Message-ID: <1442402500.2977.80.camel@themaw.net>
References: <CAA1QoHSyMHh9LoPwAM_Nto0iTVbvaVAFH2s-gCSrpYUX1zuPuQ@mail.gmail.com>
	 <CAA1QoHQBJhORCZZY8cS27TWsa=Tk6WJDCwCXXNSQJ5=R6ZtWNw@mail.gmail.com>
	 <1442395019.2977.60.camel@themaw.net>
	 <CAA1QoHQy=SxhQNEFO8E+ZLWty4Ex_nM1GaR0emSfMS4-1WijVQ@mail.gmail.com>
	 <1442400182.2977.65.camel@themaw.net>
	 <CAA1QoHQC44B8bNtFdWz_i-zY7r_RxjZ8RWkyNYmy6eR7_qQ=qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=8t7YvE9Cv3rpoLsIiiRMIgCAydg=; b=KI+XM6
	bxZI9fnqN/G/Y3rGC8kLhfYG/V+30orZfzGmNY6ns5xuHJlLw8qc24oBBfhEb4cf
	QBMiO+vZPCwLQ657bVpvaqQ8C3HujKErzfsvYNM8TvkvfxYBG2s25xHGqL6U/Uyi
	7jSmEEetmR8PTlkiYDjhtkcufySQ5XTgsluY0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=8t7YvE9Cv3rpoLs
	IiiRMIgCAydg=; b=Btp9jBaooRgq3+lP5DTQPadmIzAJz46Hm8kv6CGLuqkXOLO
	vt8TmtCpkFbF2+h6Ug2A+RLIqsZB6nmV8mVEiKJo3gaIlt9K+9q9BJlahBMgO/Wj
	rHplC2lD7ti6FzLWhntJGEYYAjvF/THUKuDm8KGhLVl5FC5JHYUKgTPJw02w=
In-Reply-To: <CAA1QoHQC44B8bNtFdWz_i-zY7r_RxjZ8RWkyNYmy6eR7_qQ=qQ@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ning Yu <ning.yu@canonical.com>
Cc: autofs <autofs@vger.kernel.org>

On Wed, 2015-09-16 at 19:02 +0800, Ning Yu wrote:
> On Wed, Sep 16, 2015 at 6:43 PM, Ian Kent <raven@themaw.net> wrote:
> > On Wed, 2015-09-16 at 18:28 +0800, Ning Yu wrote:
> >> On Wed, Sep 16, 2015 at 5:16 PM, Ian Kent <raven@themaw.net> wrote:
> >> > On Wed, 2015-09-16 at 16:45 +0800, Ning Yu wrote:
> >> >> Hi,
> >> >>
> >> >> I have composed a patch for this issue, it works in my side, what it
> >> >> does is replacing gettimeofday() with clock_gettime(CLOCK_MONOTONIC).
> >> >>
> >> >> Would anyone please help to review it? Thanks in advance.
> >> >
> >> > Are you joking!
> >> > How is this meant to apply to the current source, it won't.
> >> >
> >> > If you can manage to post a sane patch you will need to break it up into
> >> > a few separate standalone patches with sane explanations of what each
> >> > one is meant to achieve.
> >>
> >> I'm sorry, not to offend, the previous patch was huge because all the call to
> >> time() or gettimeofday() functions are replaced with clock_gettime().
> >
> > Encountering this after a generally unpleasant day is bound to get a
> > short and unpleasant response, ;)
> >
> 
> Best wishes for you and have a nice day/night :)
> 
> >>
> >> Please allow me to re-send the patch, this time I have splitted it into
> >> several smaller patches, hope it won't be as stupid as previous one.
> >
> > Well, I see those posts but there are still problems with your email
> > program.
> >
> > Apart from the DOS line ends all the tabs appear to have been collapsed
> > to single spaces.
> >
> > I really don't want to go through and apply these hunk by hunk manually
> > when you must have a properly formatted patch already.
> >
> 
> Thanks for pointing it out, I will have to fix my email client issue first and
> resend the patches. Sorry for wasting you so much of time.

A couple of other small things.

Please make the title of the patch email the same as the tittle of the
patch. And if possible add a [PATCH x/y] prefix to the title, x being
the ordering of the patch within the y patches posted.

And in patch titles I commonly use "autofs-n-v-r - actual title".

So for example one of these would have a title like:
autofs-5.1.1 - Use monotonic clock instead of time()

assuming you had made them against the 5.1.1 source.

I've also started to use (quite recently in fact) "Signed-off-by:" in
patches so please add yours too, I don't feel right about adding it for
someone else as it's an assumption that may or may not be correct.

These things aren't a big deal as I can change most of them myself
easily if it's not convenient for you to do it.

> 
> >>
> >> >
> >> >>
> >> >> From cdb2bcd563420cd39af199309e8c0c7fc45a7bd1 Mon Sep 17 00:00:00 2001
> >> >> From: Yu Ning <ning.yu@ubuntu.com>
> >> >> Date: Wed, 16 Sep 2015 15:56:21 +0800
> >> >> Subject: [PATCH] Use clock_gettime() instead of gettimeofday().
> >> >>
> >> >> This patch is to fix the issue that a mount point may not be
> >> >> automatically unmounted after a system date/time change.
> >> >>
> >> >> Reproducer with 100% failrate:
> >> >
> >> > Since of you to hammer the result of the problem you've identified
> >> > rather than just explain the problem and what needs to be done to
> >> > resolve it in a polite and sensible manner.
> >> >
> >
> >


--
To unsubscribe from this list: send the line "unsubscribe autofs" in
