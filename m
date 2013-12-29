From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/5] fyi, here are the patches that I haven't yet
 committed
Date: Sun, 29 Dec 2013 19:26:26 +0800
Message-ID: <1388316386.26021.6.camel@perseus.fritz.box>
References: <20131224075909.8321.95699.stgit@perseus.fritz.box>
	 <CAF1ZMEf+Bd664eVgkLOvGKTFGBzpgS+UoDZmJyFK-f=Rv59bkg@mail.gmail.com>
	 <1387875881.7351.12.camel@perseus.fritz.box>
	 <CAF1ZMEeUDS8wunF9AHXwQ=xf0OW6_ucmyfQicfbpP7sVavpaSw@mail.gmail.com>
	 <1387881262.7351.15.camel@perseus.fritz.box>
	 <CAF1ZMEcfVTYS=6sfVhSbO8MVaMxcU2v8qV_7O6ACMCRHLxMXeA@mail.gmail.com>
	 <CAF1ZMEfbrpZ_=GxYTNS-sfus9-QTBD-WCMaZR-ZaEpShPbFdBg@mail.gmail.com>
	 <CAF1ZMEdRhy5LcfEwUW3Os5M8nKXT1j2+M4oqOKgqF3sjLPyWpw@mail.gmail.com>
	 <1388134613.2623.7.camel@perseus.fritz.box>
	 <1388198519.13774.4.camel@perseus.fritz.box>
	 <CAF1ZMEcOgg2DA++12XHnBRue58-W_HmeByNfbs80HjmnFsZ0dA@mail.gmail.com>
	 <1388315678.26021.4.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=MZ8/mZzigF5pbIXQEafJxXCFopU=; b=W/UmmRTQkeMCE0/2XutkvEwZI1la
	FRJk2uDTPQJHqkZT9ER4bm32GlmUmgwIAioTmvpA4oDxu6i+hWvUjhYjFOsVNhqb
	cIv4PuILorKZLZ/iPTdZwmHG4DW8X2dMBDtuK8Rfy9ebTErFb2igUTE70Mr3nc7s
	HDwLeoDASg1W+5U=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=MZ8/mZzigF5pbIXQEafJxX
	CFopU=; b=d2vT80EWIg+8/Fy8vyf77Bz6Mhe49J59jQogfAWOl8/hqmVU0K15L6
	umb1yuDmkRyteOO/9YlR5NO7q6vzB7fQ5uRzpelptOLCyNUFSPPGpNuvJsGTVe1r
	IuqohL3lrXqDb3TAP8H5pZBINPNv8Fv0hpvEJl60Am4rmC685dEUM=
In-Reply-To: <1388315678.26021.4.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Sun, 2013-12-29 at 19:14 +0800, Ian Kent wrote:
> On Sat, 2013-12-28 at 20:09 +0800, Dennis Lan (dlan) wrote:
> > On Sat, Dec 28, 2013 at 10:41 AM, Ian Kent <raven@themaw.net> wrote:
> > 
> > >> > using commit ec267c2c406256e401540e5bc890b2e0c2ff6c35
> > > I've updated the autofs-5.0.public branch.
> > > Can you test it please.
> > >
> > > Ian
> > >
> > Hi Ian:
> >  Did you only fix the problem while libtirpc is disabled, as I looking
> > at your commits?
> > I've tested the case with libtirpc disabled, all works fine (test both
> > nfs mount with nfsvers=3,4)
> > 
> > but with libtirpc enabled, fail as same previous error
> 
> I'm not able to reproduce those problems with the current source.
> Tell me more (maybe again) about the server side.

Perhaps you could send a gdb backtrace, that might give ne a clue.
Run gdb on the core and capture the output of "thr a a bt".

> 
> Commit ec267c2c deals with a libtirpc failure that would result in the
> "no hosts found" message and I'm not sure you had commit 7f7b730e either
> which also caused failures.
> 
> Ian
> 


