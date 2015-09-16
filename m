From: Ian Kent <raven@themaw.net>
Subject: Re: Mount point not auto unmounted after system date/time change
Date: Wed, 16 Sep 2015 18:43:02 +0800
Message-ID: <1442400182.2977.65.camel@themaw.net>
References: <CAA1QoHSyMHh9LoPwAM_Nto0iTVbvaVAFH2s-gCSrpYUX1zuPuQ@mail.gmail.com>
	 <CAA1QoHQBJhORCZZY8cS27TWsa=Tk6WJDCwCXXNSQJ5=R6ZtWNw@mail.gmail.com>
	 <1442395019.2977.60.camel@themaw.net>
	 <CAA1QoHQy=SxhQNEFO8E+ZLWty4Ex_nM1GaR0emSfMS4-1WijVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=PpYJmaL1ujNO7A1VBj7dvbdGjPY=; b=f8uZXo
	G6UVrLQ1IgTC68Fzyay6HvH3REjdqK9KmqmKe0dNt7ZOVb8HoGUGYSCWs1X4784m
	JxlzQLG2RfyrWEm2Gj1Dixykl8UBlLFbsLGG3ihAOl/zKh1Zf9QHYoOuRj7tzNpy
	fN4gpxBdQsWDdd/I2aIosG3lk+YRddNoZJyS8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=PpYJmaL1ujNO7A1
	VBj7dvbdGjPY=; b=t3mbJi2GDXnXySP7wkOa4RvA9MU87GPTN5e2dKVf7hN49Lw
	VWxebCy7JHiXp1hqkeeWt/YyNG2JEzb9zDEsTck/hRx63rKzGyhtpLNDetfyVTxU
	o+VHhEfiTAps2+x0JEtVdNUKCRYHk0Xr0NZfDTefSy46OWpMoP0JiCjJb9n0=
In-Reply-To: <CAA1QoHQy=SxhQNEFO8E+ZLWty4Ex_nM1GaR0emSfMS4-1WijVQ@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ning Yu <ning.yu@canonical.com>
Cc: autofs <autofs@vger.kernel.org>

On Wed, 2015-09-16 at 18:28 +0800, Ning Yu wrote:
> On Wed, Sep 16, 2015 at 5:16 PM, Ian Kent <raven@themaw.net> wrote:
> > On Wed, 2015-09-16 at 16:45 +0800, Ning Yu wrote:
> >> Hi,
> >>
> >> I have composed a patch for this issue, it works in my side, what it
> >> does is replacing gettimeofday() with clock_gettime(CLOCK_MONOTONIC).
> >>
> >> Would anyone please help to review it? Thanks in advance.
> >
> > Are you joking!
> > How is this meant to apply to the current source, it won't.
> >
> > If you can manage to post a sane patch you will need to break it up into
> > a few separate standalone patches with sane explanations of what each
> > one is meant to achieve.
> 
> I'm sorry, not to offend, the previous patch was huge because all the call to
> time() or gettimeofday() functions are replaced with clock_gettime().

Encountering this after a generally unpleasant day is bound to get a
short and unpleasant response, ;)

> 
> Please allow me to re-send the patch, this time I have splitted it into
> several smaller patches, hope it won't be as stupid as previous one.

Well, I see those posts but there are still problems with your email
program.

Apart from the DOS line ends all the tabs appear to have been collapsed
to single spaces.

I really don't want to go through and apply these hunk by hunk manually
when you must have a properly formatted patch already.

> 
> >
> >>
> >> From cdb2bcd563420cd39af199309e8c0c7fc45a7bd1 Mon Sep 17 00:00:00 2001
> >> From: Yu Ning <ning.yu@ubuntu.com>
> >> Date: Wed, 16 Sep 2015 15:56:21 +0800
> >> Subject: [PATCH] Use clock_gettime() instead of gettimeofday().
> >>
> >> This patch is to fix the issue that a mount point may not be
> >> automatically unmounted after a system date/time change.
> >>
> >> Reproducer with 100% failrate:
> >
> > Since of you to hammer the result of the problem you've identified
> > rather than just explain the problem and what needs to be done to
> > resolve it in a polite and sensible manner.
> >


--
To unsubscribe from this list: send the line "unsubscribe autofs" in
