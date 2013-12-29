From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/5] fyi, here are the patches that I haven't yet
 committed
Date: Sun, 29 Dec 2013 19:36:48 +0800
Message-ID: <1388317008.26021.9.camel@perseus.fritz.box>
References: <20131224075909.8321.95699.stgit@perseus.fritz.box>
	 <CAF1ZMEf+Bd664eVgkLOvGKTFGBzpgS+UoDZmJyFK-f=Rv59bkg@mail.gmail.com>
	 <1387875881.7351.12.camel@perseus.fritz.box>
	 <CAF1ZMEeUDS8wunF9AHXwQ=xf0OW6_ucmyfQicfbpP7sVavpaSw@mail.gmail.com>
	 <1387881262.7351.15.camel@perseus.fritz.box>
	 <CAF1ZMEcfVTYS=6sfVhSbO8MVaMxcU2v8qV_7O6ACMCRHLxMXeA@mail.gmail.com>
	 <CAF1ZMEfbrpZ_=GxYTNS-sfus9-QTBD-WCMaZR-ZaEpShPbFdBg@mail.gmail.com>
	 <CAF1ZMEdRhy5LcfEwUW3Os5M8nKXT1j2+M4oqOKgqF3sjLPyWpw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=LIMTvRGThylIfBcV7EOeX8Uj38o=; b=FiYRGhXmITRRigcPxD5FZk+m8RMD
	Tm76juo7Dks1HchsQAy/4Qt6QGs+QBKsTFCjr46CQE2J+6/bbqivy/uW3rEWepuG
	j1oFKlRpubhhSBepx3w0oipGZqS7ERT8Yp8vyoVpJkcO1HJ0F2ufZ3Hd0eebToO+
	NvhS2zrgBPBCmgo=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=LIMTvRGThylIfBcV7EOeX8
	Uj38o=; b=jO1I0IRCQLEawVmLluyMGKNEL1GXv68x1n3NKszxi5dw7ioDWnz6Ob
	sTl+4ovcciKBN67xS7MtgPBkVUSGDyuYbslbk1h+jGt4e2b8EmBOm3Rvpt14DNlC
	zqk3JW+0i8YAdXizGMkHIzOa4HVgxv+yOFXLnxRPbwETsQ/cicho4=
In-Reply-To: <CAF1ZMEdRhy5LcfEwUW3Os5M8nKXT1j2+M4oqOKgqF3sjLPyWpw@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Fri, 2013-12-27 at 15:30 +0800, Dennis Lan (dlan) wrote:
> sorry, I was not accurate about the failure cases.
> 
> using commit ec267c2c406256e401540e5bc890b2e0c2ff6c35
> 
> snip from file /etc/autofs/auto.misc
> mkynfs -ro,soft,intr,nfsvers=3 192.168.90.12:/home/dennis
> mkydns -ro,soft,intr,nfsvers=4 mickeycn:/home/dennis
> 
> with libtirpc enabled (all other features disabled),[1]
> "ls /mnt/misc/mkynfs" lead to automount segfault
> "ls /mnt/misc/mkydns" automount fail (no crash), but report "no hosts available"
> 
> with libtirpc disabled (all other features disabled)[2]
> "ls /mnt/misc/mkynfs" automount fail (no crash), report "no hosts available"
> "ls /mnt/misc/mkydns" works fine

What exactly does "all other features disabled" mean from a configure
POV. I always use --disable-mount-locking and --enable-ignore-busy,
always.

Maybe that's something to do with the problem your seeing .....

Ian

