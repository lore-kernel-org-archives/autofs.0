From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/5] fyi, here are the patches that I haven't yet
 committed
Date: Tue, 24 Dec 2013 18:34:22 +0800
Message-ID: <1387881262.7351.15.camel@perseus.fritz.box>
References: <20131224075909.8321.95699.stgit@perseus.fritz.box>
	 <CAF1ZMEf+Bd664eVgkLOvGKTFGBzpgS+UoDZmJyFK-f=Rv59bkg@mail.gmail.com>
	 <1387875881.7351.12.camel@perseus.fritz.box>
	 <CAF1ZMEeUDS8wunF9AHXwQ=xf0OW6_ucmyfQicfbpP7sVavpaSw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=40pqU4AgVbmbkWLiylhWSp9PPi4=; b=SEdyO/5G1a0STK0Hxqa6Fo5ob46Q
	wbGNMcs6R7/LzHDFTDX8IoYojq5e83h2SuNevDd5xHmq6cCIOnGqhywMXE4exKL5
	95PUZ4kF5qo/XTzTNADWt6GFXCqTvSvPGbOoLGd16dmafhDNg6qoBQWtxmCL3hJn
	PuhpWgOESzOEcHQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=40pqU4AgVbmbkWLiylhWSp
	9PPi4=; b=bxXI4curmbsAhHzrAK/3XxZClW8cuP5httSR52YVsMjGznJFz+26ix
	sfjvChVs0mumacYpeesdMBbwrUJfRoxpEuDoDnQyXC2FdKPUta6A9QKJIVSepCOk
	E1br5YtcmpH2jnJZ1JSGh8YhAbnvEejZMI0f3aCR9CuWsb+blmGk0=
In-Reply-To: <CAF1ZMEeUDS8wunF9AHXwQ=xf0OW6_ucmyfQicfbpP7sVavpaSw@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Tue, 2013-12-24 at 17:42 +0800, Dennis Lan (dlan) wrote:
> On Tue, Dec 24, 2013 at 5:04 PM, Ian Kent <raven@themaw.net> wrote:
> > On Tue, 2013-12-24 at 16:38 +0800, Dennis Lan (dlan) wrote:
> >> Hi Ian:
> >>   Do you mind push a temporary branch into your git repo (if you don't
> >> want to queue other patches)?
> >> That would much convenient for me to test.
> >
> > Try branch autofs-5.0.public.
> > As master and autofs-5.0 branches diverge the autofs-5.0 will be the
> > place for version 5.0.
> >
> >
> 
> Hi Ian
>  Have problem with branch autofs-5.0.public
> most obvious error
> 461:Dec 24 17:29:12 ofire automount[11496]: mount(nfs): no hosts available
> 462:Dec 24 17:29:12 ofire automount[11496]: dev_ioctl_send_fail: token = 79

Are you sure you're using the autofs-5.0.public branch.
That's the error I'd expect to see using master.

I put an entry with the same options into a map and tested it.
Worked fine for me.

What server are you using?
What kernel is on the server?
rpcbind or portmap?

Ian

