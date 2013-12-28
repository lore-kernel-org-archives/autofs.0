From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/5] fyi, here are the patches that I haven't yet
 committed
Date: Sat, 28 Dec 2013 10:41:59 +0800
Message-ID: <1388198519.13774.4.camel@perseus.fritz.box>
References: <20131224075909.8321.95699.stgit@perseus.fritz.box>
	 <CAF1ZMEf+Bd664eVgkLOvGKTFGBzpgS+UoDZmJyFK-f=Rv59bkg@mail.gmail.com>
	 <1387875881.7351.12.camel@perseus.fritz.box>
	 <CAF1ZMEeUDS8wunF9AHXwQ=xf0OW6_ucmyfQicfbpP7sVavpaSw@mail.gmail.com>
	 <1387881262.7351.15.camel@perseus.fritz.box>
	 <CAF1ZMEcfVTYS=6sfVhSbO8MVaMxcU2v8qV_7O6ACMCRHLxMXeA@mail.gmail.com>
	 <CAF1ZMEfbrpZ_=GxYTNS-sfus9-QTBD-WCMaZR-ZaEpShPbFdBg@mail.gmail.com>
	 <CAF1ZMEdRhy5LcfEwUW3Os5M8nKXT1j2+M4oqOKgqF3sjLPyWpw@mail.gmail.com>
	 <1388134613.2623.7.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=5m0C3DY5xzfVOQK7BcXAw4HaUNg=; b=m2X1VOASygQ2tF1/Hdh8kqx0/VRF
	1/FWzJdJTVvjyxu25ke0crOUMdIMxTVW7s8sCu/4/9JwdIzphczzON109+gAkkxb
	w5DqUteBGbKZTSaP80nrlUj8arYNfyKDjavvgfbxGK4vyIzuyyHdUMIcNSiLKp5t
	i2IOik9p18bsEGk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=5m0C3DY5xzfVOQK7BcXAw4
	HaUNg=; b=tBSobAwk3oiG0R0Rv8f4hazmGicct8eUmTvhdPkcWv407Vb/0gZkOJ
	O8ojDs5TdVQelXV9cRvoPJxTU6W90nQzuJfBzGLCVbjxsA5tglFECU1KlpF6ykpi
	Z2qoBM8w1w3RjRNpVCmooTJgmxjxCm0Rgjcg1wj9Zh2egnCq1NqqM=
In-Reply-To: <1388134613.2623.7.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Fri, 2013-12-27 at 16:56 +0800, Ian Kent wrote:
> On Fri, 2013-12-27 at 15:30 +0800, Dennis Lan (dlan) wrote:
> > sorry, I was not accurate about the failure cases.
> > 
> > using commit ec267c2c406256e401540e5bc890b2e0c2ff6c35
> > 
> > snip from file /etc/autofs/auto.misc
> > mkynfs -ro,soft,intr,nfsvers=3 192.168.90.12:/home/dennis
> > mkydns -ro,soft,intr,nfsvers=4 mickeycn:/home/dennis
> > 
> > with libtirpc enabled (all other features disabled),[1]
> > "ls /mnt/misc/mkynfs" lead to automount segfault
> > "ls /mnt/misc/mkydns" automount fail (no crash), but report "no hosts available"
> 
> Right, I think I've worked out the issue with this second case.
> I'll push my recent changes to autofs-5.0.public once I've had a look at
> the segfault issue.
> 
> > 
> > with libtirpc disabled (all other features disabled)[2]
> > "ls /mnt/misc/mkynfs" automount fail (no crash), report "no hosts available"
> > "ls /mnt/misc/mkydns" works fine
> 
> Mmmm .. I'll need to duplicate this and have a look.
> The libtirpc disabled case shouldn't really have changed ....
> 
> Let me work through these logs and see if I can spot anything obvious.

I've updated the autofs-5.0.public branch.
Can you test it please.

Ian

