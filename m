From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 00/10] autofs4 - rename autofs4 to autofs
Date: Tue, 03 Sep 2013 20:47:13 +0800
Message-ID: <1378212433.2310.3.camel@perseus.fritz.box>
References: <20130831114133.11807.35953.stgit@perseus.themaw.net>
	 <5225C7F0.10103@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=THaISTiNmcrvi8blulsQP/t5nKM=; b=KGivFOTI7IFw7c954tNCMyQqPNyB
	qaYBAtcm3wUbv31qkqgbjIssk5uVBUzzPqs3+1fPyBhzxg+bUMm0EzelQ5tF/qXN
	vv2vr6qcAeZX91cWErLt0oZ3MRGnZgFW2rhHxpWF2rm10plwkELCMLHGyRrXgvnc
	QlO1JEgjGTI/NRs=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=THaISTiNmcrvi8blulsQP/
	t5nKM=; b=aJIIQcKi63Yok5Qa7mrldaWpdfprJJNdfGwzPq/Rr9uQxeNHT52enN
	uf4Px7wmRV335LQ9KwVc8V/MWCGCOra61WIIzg5nDxzczlDdAtE9vGbBR/JHEbtZ
	sxMibvgbHAwJKMzL7vYD/yQ3Sx30u8RZ72twzYpvZo9ZqhDeGDrcU=
In-Reply-To: <5225C7F0.10103@msgid.tls.msk.ru>
Sender: linux-next-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: linux-next@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, 2013-09-03 at 15:28 +0400, Michael Tokarev wrote:
> 31.08.2013 15:42, Ian Kent wrote:
> [...]
> > By leaving a Kconfig and Makefile in fs/autofs4 (to build autofs4.ko)
> > with a deprication message sub-system maintainers and other users will
> > make any needed changes before these are removed after two kernel versions.
> > IMHO the presence of the warning is reason enough to leave a build stub
> > rather than do a straight out rename.
> 
> Why do you want to continue building autofs4.ko? (or allowing to)
> What's actually wrong with a stright rename?
> If the new module can be auto-loaded by both name (by providing an
> alias), there's no need to keep ability to build autofs4.ko, I think.

The hope is that within two subsequent kernel versions, when it is
removed, people that need to change will have noticed this and made the
needed changes. That's scripts that may have looked for autofs4.ko to
work around the auto-load problem, aliases that won't work now, kernel
configurations, etc...

The configuration message for autofs4 now says these things and says the
module is going to be removed.

> 
> Well, maybe except of the case when autofs is needed in initramfs (like
> for systemd).  For this, indeed, you can keep autofs4.ko which is a
> dummy depending on autofs.ko...
> 
> > Ian Kent (10):
> >       autofs4 - coding style fixes
> >       autofs4 - fix string.h include in auto_dev-ioctl.h
> >       autofs4 - move linux/auto_dev-ioctl.h to uapi/linux
> >       autofs - merge auto_fs.h and auto_fs4.h
> >       autofs - use autofs instead of autofs4 everywhere
> >       autofs - copy autofs4 to autofs
> >       autofs - create autofs Kconfig and Makefile
> >       autofs - update fs/autofs4/Kconfig
> >       autofs - update fs/autofs4/Makefile
> >       autofs - delete fs/autofs4
> 
> By doing it this way, you're losing all git history.
> If you perform stright rename and git detects it, you
> can use, eg, git log --follow to see whole hostory
> across rename.  This way you create new files without
> history.
> 
> So I strongly shuggest actually renaming the subdirectory
> (together with appropriate kconfig/makefile changes so
> things are bisectable), and creating the stubs after this.
> 
> Thanks,
> 
> /mjt
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

