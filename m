From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] unbreak automount daemon after fixing autofs5 ABI
Date: Thu, 26 Apr 2012 20:03:46 +0800
Message-ID: <1335441826.6702.49.camel@perseus.themaw.net>
References: <1335421594-10499-1-git-send-email-mjt@msgid.tls.msk.ru>
	 <1335428498.6702.33.camel@perseus.themaw.net>
	 <4F99082F.1040902@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=mesmtp;
	 bh=nOa7NZQP16zQ4cSPUjRH90Qro8s=; b=HrG4jKB5HionUs6u2Z9J5ZzLulSE
	9O8okcXNJ9cKgzif5hMMdebOYPonO9SCPh0F5qCsi8mcZWY3FNJ56koe9Cz+21wd
	8g6ortQICFQJVJUxAzi3fgiQdC0fXMJvEJeVqfDnUHaZUiJY/KQRsZvK2PNZqhTg
	3KUML4bVPmvzEWk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:content-transfer-encoding
	:mime-version; s=smtpout; bh=nOa7NZQP16zQ4cSPUjRH90Qro8s=; b=mZS
	IPKMOVPPmhDbpUXQ+REzxr99xSulJpywwEoB/jK4dMX1RiEK6N57sXzn2W8onCWf
	PcINqs8kdt675JC+2mSgjBlRvcWk86TzuuIXWxK/wdlT9onVNj0g0u4203kDN0sg
	Vkvo6yh74Tst/fpGGMDM7v1bpaGy8B97zYJdeil0=
In-Reply-To: <4F99082F.1040902@msgid.tls.msk.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Meyer <thomas@m3y3r.de>, stable@kernel.org, autofs@vger.kernel.org

On Thu, 2012-04-26 at 12:32 +0400, Michael Tokarev wrote:
> On 26.04.2012 12:21, Ian Kent wrote:
> > On Thu, 2012-04-26 at 10:26 +0400, Michael Tokarev wrote:
> []
> >> Change 499f286dc02cde6b tries to fix the original interface
> >> bug for 32bit userspace running on 64bit kernel.  But the
> >> issue is that autofs5 already has a workaround for it, so
> >> the end result is that the two (kernel & user) disagree
> >> again.  "Fix" this by applying the in-kernel fix only if
> >> the process is not named "automount" -- which is how autofs5
> >> daemon is named.
> > 
> > No, you cannot be sure the autofs binary is named automount.
> 
> Well, I checked several distributions, all have the binary named
> this way.  Yes a user can rename it and it will break again, but
> it is at least better than now when it does not work at all.  And
> yes it is messy, just like current situation already is.
> 
> > Not only that, this approach makes an unpleasant change even more
> > unpleasant.
> > 
> > I still think that my original proposed patches were the better approach
> > to handling this problem.
> > 
> > My recommendation was that the major autofs kernel protocol version be
> > bumped and a packed structure used from that version on. That allows
> > user space to request that protocol version for communication at mount
> > time. If systemd doesn't want to support earlier protocol versions then
> > it can complain, instructing the user to update to a later kernel.
> 
> This is exactly what I was proposing when I started my thread about
> 3.0.24 autofs breakage -- to _revert_ the in-kernel fix and introduce
> a new interface (or variation thereof, in means of a new mount option
> or something).  This way, breakage and mess are both minimal.
> 
> Note that a major protocol changes aren't really needed, just a single
> mount option, which uses a right size of the structure.  Unless at the
> same time you want to change something else.

There's no new interface needed, as such. Basically the structure used
for communication just needs to be declared packed and used instead of
the current one. Since it's not a backward compatible change the major
version needs to be increased to indicate that.

The autofs kernel protocol version (major version number) is specified
when mounting autofs mounts. The minor version is meant to be used to
identify the bug fix level. So increasing the major version number is
the normal way that change may be introduced without breaking existing
applications or requiring any changes to them. New applications simply
set the major version at mount time and can decide if they want to use a
lower version if the mount fails, assuming the lower version has the
functionality that's needed. And, yes, it isn't quite that simple at run
time but that is the way it's meant to work.

So using the word "major" probably gives the wrong impression even
though the term is correct usage.

Ian

