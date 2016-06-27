From: Ian Kent <raven@themaw.net>
Subject: Re: Regular deadlocks
Date: Mon, 27 Jun 2016 08:35:28 +0800
Message-ID: <1466987728.3191.10.camel@themaw.net>
References: <3eece3d9-ea5a-ee47-100d-6fccf58f5356@excellency.fr>
	 <1466906389.739.25.camel@themaw.net>
	 <c4d585e4-fae9-829f-b7ad-74724af5c2f9@excellency.fr>
	 <1466987208.3191.6.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=pfKJCiBBHP4gvDM3dAk2K3bZhQo=; b=FgKDmq
	qerePMG7XFwaSyAY7TT1O4h66Ex00jcm+ie7Cmkbqdj9Xu9xEgTV20sCKHVsNT++
	77WFeFEcvwrfJ/it9QsMAvR8tsqc3Pv7XYI148F4sMk5/u62F24Cr30QHAY7ljUB
	UEnevijIfiFpDQXXptpQq/LGoo/Q2Jimdqjnk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=pfKJCiBBHP4gvDM
	3dAk2K3bZhQo=; b=qtiTyKR7BNCCb+LUyNfdxtg2ogN52DOFTZDxvUyMstijaHh
	utwXdcnfVm9028V4BcdbWVoQLZiEt9JZFcq1oqTTxa6XHc0nfSvyw3J382NcqVEh
	tjdKnz/LV/o+J+ZTmimhN5TmUiyRSxSWEVBvvU+8ff22r0ulh3oJKGEXEt48=
In-Reply-To: <1466987208.3191.6.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Cyril B." <cbay@excellency.fr>, autofs@vger.kernel.org

On Mon, 2016-06-27 at 08:26 +0800, Ian Kent wrote:
> On Sun, 2016-06-26 at 12:02 +0200, Cyril B. wrote:
> > 
> > However, I've also had those "deadlocks" happen with several different 
> > NFS servers at the same time (this was not the case with the traces I 
> > sent in my previous email). If one NFS server was unmountable, should 
> > automount be blocked when trying to mount others?

And don't forget it's not different servers that affect locking.

Most of the locking that can cause blocking it is at directory level so it
should be at or below the autofs mount point directories.

> 
> How is autofs configured.
> 
> If --disable-mount-locking is not used then any mount can block all other
> mounts, if it is used then there can be mtab corruption if still using a text
> based mtab.
> 
> I always use --disable-mount-locking and nowadays the mtab is usually a
> symlink
> into the proc file system so corruption isn't a problem.
> 
> Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
