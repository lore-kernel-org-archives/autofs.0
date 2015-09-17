From: Ian Kent <raven@themaw.net>
Subject: Re: Mount point not auto unmounted after system date/time change
Date: Thu, 17 Sep 2015 14:05:15 +0800
Message-ID: <1442469915.2915.4.camel@themaw.net>
References: <CAA1QoHSyMHh9LoPwAM_Nto0iTVbvaVAFH2s-gCSrpYUX1zuPuQ@mail.gmail.com>
	 <CAA1QoHQBJhORCZZY8cS27TWsa=Tk6WJDCwCXXNSQJ5=R6ZtWNw@mail.gmail.com>
	 <1442395019.2977.60.camel@themaw.net>
	 <CAA1QoHQy=SxhQNEFO8E+ZLWty4Ex_nM1GaR0emSfMS4-1WijVQ@mail.gmail.com>
	 <1442400182.2977.65.camel@themaw.net>
	 <CAA1QoHQC44B8bNtFdWz_i-zY7r_RxjZ8RWkyNYmy6eR7_qQ=qQ@mail.gmail.com>
	 <1442402500.2977.80.camel@themaw.net>
	 <CAA1QoHT7GK1Ry4-wuVUJuAEuQyaDHE-3CzxWV9xMECUM+chyyw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=V0ZMXf3CFqPbQRbNP/R4UzMLuEU=; b=nila/F
	nBAwjzaxfHL6SFtU8Jl+9u+qGztwzN0f5JfLpPYGPkhMjSM6vQkM1aNf+dI1kEQc
	jzTQVXm1YwLDSHI6DtcvqCjvkw+Me8q3kuxX+mKA6T9eeVB1KtLPsfdR/j6UOa1V
	qFEAp4E7O636fZNQCno/ZtA/Zuf7LVBK+oBeY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=V0ZMXf3CFqPbQRb
	NP/R4UzMLuEU=; b=T8fsF/ssatttdeCiJ/1IaPLqRd9sAMSL6s018RvuuPf21M8
	7Ffz04WMlRqNd7hnDt8i6GY49IOohtGI1A3ee5tbqT7vGL/4x/ux19/6+jpyZPZp
	i7/IapBL2Qgtk/UaAtUuUID2D72ycxI9qUoWB4h3HoI75sH2rHAvcnMFYJbY=
In-Reply-To: <CAA1QoHT7GK1Ry4-wuVUJuAEuQyaDHE-3CzxWV9xMECUM+chyyw@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ning Yu <ning.yu@canonical.com>
Cc: autofs <autofs@vger.kernel.org>

On Thu, 2015-09-17 at 12:02 +0800, Ning Yu wrote:
> On Wed, Sep 16, 2015 at 7:21 PM, Ian Kent <raven@themaw.net> wrote:
> > On Wed, 2015-09-16 at 19:02 +0800, Ning Yu wrote:
> >> On Wed, Sep 16, 2015 at 6:43 PM, Ian Kent <raven@themaw.net> wrote:
> >> > On Wed, 2015-09-16 at 18:28 +0800, Ning Yu wrote:
> >> >> On Wed, Sep 16, 2015 at 5:16 PM, Ian Kent <raven@themaw.net> wrote:
> >> >> > On Wed, 2015-09-16 at 16:45 +0800, Ning Yu wrote:
> >> >> >> Hi,
> >> >> >>
> >> >> >> I have composed a patch for this issue, it works in my side, what it
> >> >> >> does is replacing gettimeofday() with clock_gettime(CLOCK_MONOTONIC).
> >> >> >>
> >> >> >> Would anyone please help to review it? Thanks in advance.
> >> >> >
> >> >> > Are you joking!
> >> >> > How is this meant to apply to the current source, it won't.
> >> >> >
> >> >> > If you can manage to post a sane patch you will need to break it up into
> >> >> > a few separate standalone patches with sane explanations of what each
> >> >> > one is meant to achieve.
> >> >>
> >> >> I'm sorry, not to offend, the previous patch was huge because all the call to
> >> >> time() or gettimeofday() functions are replaced with clock_gettime().
> >> >
> >> > Encountering this after a generally unpleasant day is bound to get a
> >> > short and unpleasant response, ;)
> >> >
> >>
> >> Best wishes for you and have a nice day/night :)
> >>
> >> >>
> >> >> Please allow me to re-send the patch, this time I have splitted it into
> >> >> several smaller patches, hope it won't be as stupid as previous one.
> >> >
> >> > Well, I see those posts but there are still problems with your email
> >> > program.
> >> >
> >> > Apart from the DOS line ends all the tabs appear to have been collapsed
> >> > to single spaces.
> >> >
> >> > I really don't want to go through and apply these hunk by hunk manually
> >> > when you must have a properly formatted patch already.
> >> >
> >>
> >> Thanks for pointing it out, I will have to fix my email client issue first and
> >> resend the patches. Sorry for wasting you so much of time.
> >
> > A couple of other small things.
> >
> > Please make the title of the patch email the same as the tittle of the
> > patch. And if possible add a [PATCH x/y] prefix to the title, x being
> > the ordering of the patch within the y patches posted.
> >
> > And in patch titles I commonly use "autofs-n-v-r - actual title".
> >
> > So for example one of these would have a title like:
> > autofs-5.1.1 - Use monotonic clock instead of time()
> >
> > assuming you had made them against the 5.1.1 source.
> >
> > I've also started to use (quite recently in fact) "Signed-off-by:" in
> > patches so please add yours too, I don't feel right about adding it for
> > someone else as it's an assumption that may or may not be correct.
> >
> > These things aren't a big deal as I can change most of them myself
> > easily if it's not convenient for you to do it.
> >
> 
> Thanks very much for the suggestions, I have resent the v3 patches with git
> command, by CCing myself I checked the patches just now:

Thanks for the effort.

Even though this is mostly a straight forward change it's still quite a
bit of effort to find and make all these small changes.

> * the Signed-off-by part is added;
> * the email subject is same with the patch title;
> * and the autofs-5.1.1 prefix is added;
> * however the EOL is still \r\n, this is really weird, because I use Linux
>   and vim to do the job, and the original patches are generated with
>   'git format-patch', they contains unix EOL as expected, and they are sent
>   with 'git send-email', not sure why gmail convert them to dos EOL.

Yes, that's strange and I don't use a gmail account for patches so I
don't know about what that might mean.

> 
> Maybe I have to resend them as attachment.

Perhaps, I'll see if they apply after dos2unix conversion, when I get to
them.

> 
> >>
> >> >>
> >> >> >
> >> >> >>
> >> >> >> From cdb2bcd563420cd39af199309e8c0c7fc45a7bd1 Mon Sep 17 00:00:00 2001
> >> >> >> From: Yu Ning <ning.yu@ubuntu.com>
> >> >> >> Date: Wed, 16 Sep 2015 15:56:21 +0800
> >> >> >> Subject: [PATCH] Use clock_gettime() instead of gettimeofday().
> >> >> >>
> >> >> >> This patch is to fix the issue that a mount point may not be
> >> >> >> automatically unmounted after a system date/time change.
> >> >> >>
> >> >> >> Reproducer with 100% failrate:
> >> >> >
> >> >> > Since of you to hammer the result of the problem you've identified
> >> >> > rather than just explain the problem and what needs to be done to
> >> >> > resolve it in a polite and sensible manner.
> >> >> >
> >> >
> >> >
> >
> >


--
To unsubscribe from this list: send the line "unsubscribe autofs" in
