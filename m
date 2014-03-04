From: Ian Kent <raven@themaw.net>
Subject: Re: "Too many levels of symbolic links"
Date: Tue, 04 Mar 2014 14:06:47 +0800
Message-ID: <1393913207.2781.20.camel@perseus.fritz.box>
References: <1391145206.2486.25.camel@perseus.fritz.box>
	 <52EB7694.20707@molgen.mpg.de> <52EB7B07.2070707@molgen.mpg.de>
	 <530484B7.6030305@molgen.mpg.de>
	 <1392896501.2508.16.camel@perseus.fritz.box>
	 <1392898704.2508.26.camel@perseus.fritz.box>
	 <530625D0.7020808@molgen.mpg.de>
	 <1392946952.2495.3.camel@perseus.fritz.box>
	 <53076D91.7050703@molgen.mpg.de> <53107D4A.90904@molgen.mpg.de>
	 <20140228132906.GM15017@sh-el6.eng.rdu2.redhat.com>
	 <1393726942.9725.5.camel@perseus.fritz.box>
	 <1393744241.9725.16.camel@perseus.fritz.box>
	 <5313467C.9080102@molgen.mpg.de>
	 <1393814402.2787.19.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=naES58l7MIDFucG8XPjLMRJY978=; b=PfudIuUuI+BCny/kXmyBrXsTiAso
	6YwZ4A1QfuSIP3T0pwSiVHMJ2uoD2I/vSSjOzFBRcxtILicGI2GmDZ/C5LQTpbrY
	vtX/At/bO7aqQPVaIx2RGiyYR97kCywfyJNq32NRgauf7xT8NHqN0doBxXCm/Xcp
	79NR3itEhiTcOVM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=naES58l7MIDFucG8XPjLMR
	JY978=; b=hCXniX4P0Y2DujrCiCnsao2A2wvhVn1vDOTiglPnb2ebLOMjsOcjKU
	7Fq/gmXDH3vuS+S4IvQSa4zVw8mjRr/YwtXnsb3yttptRtVryzBA4M9MpTqT5HK1
	zlXJZqyrPxxyUbHnChbgcF3pm2FC2efAZbzIWdWDHbCJdtgu+CIoU=
In-Reply-To: <1393814402.2787.19.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: Alexander Viro <aviro@redhat.com>, autofs <autofs@vger.kernel.org>

On Mon, 2014-03-03 at 10:40 +0800, Ian Kent wrote:
> 
> > 
> > That doesn't solve the problem, however, that mounts cloned by a 
> > unshare(CLONE_NEWNS) would never expire. Also there is another bug 
> > somewhere, because I see, that the mount, visible to the 
> > /usr/lib/colord/colord process was logged as "unmounted" in the nfs 
> > server when it expired in the global namespace. So I doubt it would be 
> > working even for that process. So possibly automounted mounts shouldn't 
> > be cloned at all? Together with chroot or pivot_root the sematics would 
> > be more than unclear anyway. Your problem now :-)
> 
> Hehe, like I said some people are going to be disappointed.
> 
> There's just one question about this that remains.
> 
> Assuming systemd is setting "/" shared what happens if "mount
> --make-rprivate /" is run before autofs is started?
> 
> So if you can spend a little more time on this an answer to this would
> be helpful.

No need for this, thanks to your reproducer.

In fact the problem doesn't appear happen if "/" is set shared so in
your case "/" must be set either slave or private.

And expanding the reproducer a bit I see another failure case too, and
it doesn't appear to be the unreliable d_mountpoint() check, not sure
yet exactly what it is.

Thanks
Ian

