From: Ian Kent <raven@themaw.net>
Subject: Re: Regular deadlocks
Date: Sun, 26 Jun 2016 18:30:09 +0800
Message-ID: <1466937009.739.34.camel@themaw.net>
References: <3eece3d9-ea5a-ee47-100d-6fccf58f5356@excellency.fr>
	 <1466906389.739.25.camel@themaw.net>
	 <c4d585e4-fae9-829f-b7ad-74724af5c2f9@excellency.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=KWGQyLiD80P2V/WpA7g4Q484xbk=; b=kKAz4W
	YLejTTUyVjtct/x6NNdgRSs38V+jdFhfyAaQ0SI9C+xUPIg8jP/8pbOFEi1JlDvk
	8s/rfiTmPxQ3kYSZY4+2ltWXwAstL0sO+KlFyDCtr2wFsfy70DL1D9N5bjHCRkx0
	D2G/yMsnHDBkb7LNOyuGukmGaAVLDdSreRzZU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=KWGQyLiD80P2V/W
	pA7g4Q484xbk=; b=hayOiSMOV0wOFIvSQTAdnmp0IRc19tu3Oly0FANZemvEGSo
	g+Zi2xV+7SEZ5gmVji743rmGueYy/T8oIwRLCUCfXHHDwO79DyB/2USO4W7Ow8yg
	qm/A+v2K59nl2DnxGmnoHjwRObdJlvJGxZ9EKgMDU8W5ifm7s/lGmYh2WTKY=
In-Reply-To: <c4d585e4-fae9-829f-b7ad-74724af5c2f9@excellency.fr>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Cyril B." <cbay@excellency.fr>, autofs@vger.kernel.org

On Sun, 2016-06-26 at 12:02 +0200, Cyril B. wrote:
> On 06/26/2016 03:59 AM, Ian Kent wrote:
> > The autofs4_d_automount() entry here indicates this is the one that
> > triggered
> > the mount.
> > 
> > If you are seeing a problem with mount, looking for the blocked process and
> > killing it should clear the rest of these up.
> > 
> > You would think that, even if mount.nfs(8) was losing network packets, it
> > would
> > timeout after about 3 minutes. I must admit I haven't waited long enough to
> > find
> > out if that's the case so far.
> > 
> > If you find you are actually seeing this, setting the configuration option
> > mount_wait to some sensible value sufficient for a mount to complete might
> > help.
> 
> 
> Thanks for the quick response. I don't remember seeing any lingering 
> mount.nfs, but I must have overlooked.

Yep, check it and let me know.

> 
> However, I've also had those "deadlocks" happen with several different 
> NFS servers at the same time (this was not the case with the traces I 
> sent in my previous email). If one NFS server was unmountable, should 
> automount be blocked when trying to mount others?

That's a bit harder to answer, it's different for mount and umount and one can
affect the other.

I would need to check since the locking scope changes due to changes for other
problems, that's with 5.1.1 and 5.1.2 right?

That also assumes automount has got all the way to mounting or umounting, it can
block at other points too like remote key lookup.

Ideally one down server shouldn't affect other mounts or umounts but, as I say,
I'll need to check and try and fix it if it's not working like that. Having said
that it also might not be straight forward either.

> 
> Anyway, I'll investigate some more next time the "deadlock" occurs and 
> will also try setting mount_wait to a reasonable value. I'll let you 
> know how it goes.
> 
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
