From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/5] fyi, here are the patches that I haven't yet
 committed
Date: Sun, 29 Dec 2013 19:14:38 +0800
Message-ID: <1388315678.26021.4.camel@perseus.fritz.box>
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
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=nFiRghXOE8xISTawIPrB7jgyspU=; b=XAVlDRQve0QPHT1BuFWcMWYjaXJu
	EdJbPfmnLgTt7pWMB6ma2XwQi1Xa+ZAIiyzr1yqKh/mZmpPoO74qADyCxgY1Bzew
	+DNKUtn/irHc+lrjJSqy3a2gWzBcfgGnoR+JOQCNtoJYQ+Nppfewsh/spTXAr3+w
	+ZylHcJ+equU5VY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=nFiRghXOE8xISTawIPrB7j
	gyspU=; b=BSKGKUlp6mjW+mJj/7+BB9KbqFXCJzk3UlYWVRl1Dx0CkZA8qObaXZ
	38b3s3blVn+I+OgJA4Q4O2TC3nLi0vygu9XA1a5zReHU2q0sASJa94L/as5ka6Ay
	ZcwGmeOH3AEeCoVEyYUPMensb5R6HgFq9bhu6KqlLI2Ak4VQzTyUw=
In-Reply-To: <CAF1ZMEcOgg2DA++12XHnBRue58-W_HmeByNfbs80HjmnFsZ0dA@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Sat, 2013-12-28 at 20:09 +0800, Dennis Lan (dlan) wrote:
> On Sat, Dec 28, 2013 at 10:41 AM, Ian Kent <raven@themaw.net> wrote:
> 
> >> > using commit ec267c2c406256e401540e5bc890b2e0c2ff6c35
> > I've updated the autofs-5.0.public branch.
> > Can you test it please.
> >
> > Ian
> >
> Hi Ian:
>  Did you only fix the problem while libtirpc is disabled, as I looking
> at your commits?
> I've tested the case with libtirpc disabled, all works fine (test both
> nfs mount with nfsvers=3,4)
> 
> but with libtirpc enabled, fail as same previous error

I'm not able to reproduce those problems with the current source.
Tell me more (maybe again) about the server side.

Commit ec267c2c deals with a libtirpc failure that would result in the
"no hosts found" message and I'm not sure you had commit 7f7b730e either
which also caused failures.

Ian


