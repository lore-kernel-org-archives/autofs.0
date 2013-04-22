From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] avoid calling mount during configure
Date: Mon, 22 Apr 2013 09:10:08 +0800
Message-ID: <1366593008.2160.1.camel@perseus.fritz.box>
References: <5173AD94.9080301@gmx.net> <5173B722.1030807@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=Btp6Z3stuKrVXg/uX/eawlvqcgo=; b=xQFXM4oId+8/4YzXJtJ3ioKB9+Ri
	N8uPkN2SGzbn+bMMXes3t4nfCOUYVTp2o7oOAmhIxchNBN2sPVIk3atwbvBqtKWM
	lIWQBPPIpnYGgxP6pY40nGouf6I2bchNJMm3hPkA/P3/gSXDDmQophWe6K7C1a8Y
	Od3CJSxAJenhmx0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=Btp6Z3stuKrVXg/uX/eawl
	vqcgo=; b=ACMZRCenr024Wk+ODd2AWX/B0P/PAgwQFcgQuvI4m1wtneZ3k3Dltp
	uWfterh5Ymx9rr5YBLIl0BYpnCEk2oIIwQQc8lqxAcv+5HS4EoWgJgP0E/ZQR2kF
	/cqmrSsdyvDAfyIIBIAr06eTBkK6zSzRzpkZwQjTaka8NZAOh6mSk=
In-Reply-To: <5173B722.1030807@msgid.tls.msk.ru>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Martin von Gagern <Martin.vGagern@gmx.net>, autofs@vger.kernel.org

On Sun, 2013-04-21 at 13:53 +0400, Michael Tokarev wrote:
> 21.04.2013 13:12, Martin von Gagern wrote:
> > Hi!
> > 
> > The configure script unconditionally calls "mount -s" in an attempt to
> > figure out whether the command supports that option or not. This can
> 
> The support for old mount command, together with pre-2.2-something kernel,
> should be just dropped from automount, together with all these configure
> checks, instead of inventing even more workarounds.  In my opinion anyway.

That may be old but every time the sloppy option hasn't worked properly
in mount(8) I get hit with problems.

So I'm not going to drop it.

Ian

