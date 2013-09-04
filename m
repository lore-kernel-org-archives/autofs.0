From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/3] autofs4 - fix device ioctl mount lookup
Date: Wed, 04 Sep 2013 11:53:04 +0800
Message-ID: <1378266784.2364.11.camel@perseus.fritz.box>
References: <20130904005456.5025.94309.stgit@perseus.fritz.box>
	 <20130904010301.GE13318@ZenIV.linux.org.uk>
	 <20130904020013.GF13318@ZenIV.linux.org.uk>
	 <CA+55aFwF+dqSMyGE+3LamM+qSDymieyReYB+RPb8fHTTmntgqw@mail.gmail.com>
	 <20130904022617.GG13318@ZenIV.linux.org.uk>
	 <20130904024230.GH13318@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=Hn/n/upqpbsgn/8iji+TBO77qe0=; b=eBJTUqXa7Rk1U01nV94u9pexaatJ
	21otJmoXgdtvNjdZ7jp6zUTbdn8crTEMvigEm++ErBAGtIDNXZaboZlXEZf8+Xg9
	HB+aWHSbrRzeQggSvePmbCYLZ6LapYlHOAPYYXd4uRTrFtARmlERrHbIkG91Wa2w
	Wgl+L7ZrjlqtjNM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=Hn/n/upqpbsgn/8iji+TBO
	77qe0=; b=bOhyiuHL4+cYIVxqVBLnGWONNipEtHKD4fPLNcMrzaUUqsClgAS/cm
	CQR/367rqtJbCcpjLpUUeJqUyXeme21f1Ca0EWBcvHC00H+4Cu9IFT7/uMecSqA6
	2FGaf7+QzdBvB79Kww0MFN2Cn5i83X0sFyN/p7FHr8tuTMDCC3kjo=
In-Reply-To: <20130904024230.GH13318@ZenIV.linux.org.uk>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, rui.xiang@huawei.com, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, 2013-09-04 at 03:42 +0100, Al Viro wrote:
> On Wed, Sep 04, 2013 at 03:26:17AM +0100, Al Viro wrote:
> > I've applied slightly modified variant of Jeff's "vfs: allow umount to handle
> > mountpoints without revalidating them" (modified by just leaving the
> > struct path filled with mountpoint and leaving the equivalent of follow_mount()
> > to caller) to the local queue and I'm pretty sure that it's what we want
> > here as well.
> 
> ... and killed the modifications since the result ends up uglier for
> caller(s) anyway.  Reapplied as-is.

But isn't that what's needed anyway?

Looks like it fits with the existing code that walks back down looking
for a match.

And that fits in with fixing the bug where we want the first match just
means breaking out early. The match should be close to the top, if not
the first then the second, for the common case.

Ian

