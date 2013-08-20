From: Ian Kent <raven@themaw.net>
Subject: Re: Seperate option for install systemd unit file
Date: Tue, 20 Aug 2013 15:18:35 +0800
Message-ID: <1376983115.2426.33.camel@perseus.fritz.box>
References: <1376893398-11765-1-git-send-email-dennis.yxun@gmail.com>
	 <1376969008.2426.3.camel@perseus.fritz.box>
	 <1376970260.2426.11.camel@perseus.fritz.box>
	 <CAF1ZMEdE-_W39NNnxA88qztpmGRSudmLQDqSMfbiJP1wEjBF7w@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=FhjbAfeSS+49DN7ebRTnBGAyYIE=; b=NA8U/ooAO29BokejVDRisL8Oa/8A
	f6LeAlZy4L4hJX8WcXoYd0Pso76NYZFMa3KCPLhXQi9FSjjSzqulX+dn67cAUG89
	R2nQ5HXCMW0wlrq9uckSluJjlkayG2p57aNcJ8RO/JnvIbBBVTpxyCSBpUfxDvQO
	QyPcq31+xCIVPQU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=FhjbAfeSS+49DN7ebRTnBG
	AyYIE=; b=QN3N8yyfbi81AFVWNzt8/bF8PfSemUqI5BVPAm+rgFIWyoG2nJCq2X
	C8HNFP7LavA79gNQA4YHUymibBp/uB4YO93os1ha2ZEwmSv+xra4RprZb5XYHzfE
	eu2JY/GXCe8nBf9Hjvmj/xwf//24KwVqD6RdCYX2EfRapOxVwyD5A=
In-Reply-To: <CAF1ZMEdE-_W39NNnxA88qztpmGRSudmLQDqSMfbiJP1wEjBF7w@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Tue, 2013-08-20 at 12:34 +0800, Dennis Lan (dlan) wrote:
> On Tue, Aug 20, 2013 at 11:44 AM, Ian Kent <raven@themaw.net> wrote:
> > On Tue, 2013-08-20 at 11:23 +0800, Ian Kent wrote:
> >> On Mon, 2013-08-19 at 14:23 +0800, Lan Yixun (dlan) wrote:
> >> > those patches are very trivial changes which only instroduce a new --with-systemdsystemunitdir option
> >> > to better control where we should install system unit file to
> >> >
> >> > 1) seperate --with-systemd opiton, but been kept now for future use (but it's useless now)
> >> > 2) add new option --with-systemdsystemunitdir to manage the path where unit file will be installed
> >> > 3) --with-systemd and --with-systemdsystemunitdir are two seperate option, so unit can be installed even systemd support is not enabled.
> >> >
> >> > downstream discussion: https://bugs.gentoo.org/show_bug.cgi?id=479492
> >> >
> >> > let me know whether this looks good to you..
> >>
> >> Looks OK but I'll need to spend some time on it in case it conflicts
> >> with downstream usage I already have.
> >
> > After a very quick initial look ....
> >
> > It appears that the change does two things.
> >
> > Defines WITH_SYSTEMD for subsequent use, although applications usually
> > don't need to know if they are being managed by systemd. Do you know of
> > any cases where that is important?
> >
> No, no cases I know of,
> So, I leave you to decide whether to keep it or not

Yeah, but it may be needed to control whether the unit file is actuall
installed. Seems a bit round of a round about way to do this.

> 
> > And changes the original --with-systemd configure option to
> > --with-systemdsystemunitdir adding the ability to specify a unit
> > directory explicitly.
> >
> > Why is it worthwhile changing the configure option as part of this
> > change?
> >
> > Ian
> >
> >
> As talked with gentoo @systemd team, it's conventional to use
> "--with-systemdsystemunitdir"[1]
> and I think it's would be slight better/explicitly to pass the unit
> directory via  --with-systemdsystemunitdir=/my/unit/dir/?current logic
> is "--with-systemd systemddir=/my/unit/dir/"

It amounts to changing the configure option name and adding the ability
to specify a directory.

The discussion implies there's precedent for using this name, do your
the systemd guys know of other packages that use this naming, what are
they?

I get the request to be able to specify a directory, that's cool.

The other thing I think I saw in the discussion was unconditional
installation of the unit file. The unit file has substitution done on it
unconditionally but the macro paths are only set if the configure option
is given. So there's no way to say, look for the systemd directories or
use the given path but don't actually install the unit file. The actual
unconditional install is probably best done in the ebuild, simple
enough.

Ian




