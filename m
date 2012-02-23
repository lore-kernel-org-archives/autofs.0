From: Ian Kent <raven@themaw.net>
Subject: Re: compat: autofs v5 packet size ambiguity - update
Date: Thu, 23 Feb 2012 09:35:02 +0800
Message-ID: <1329960902.2244.2.camel@perseus.themaw.net>
References: <CA+55aFzhS69QSoN1j+Z2md116u+3OfniAoE0QMo6xyBjDyjbEw@mail.gmail.com>
	  <20120221.221609.218135609185671883.davem@davemloft.net>
	  <CA+55aFwvmZGDzO_8wwYfH8HsLE=qCmLkJfeMyCe4PVvOYbDMHQ@mail.gmail.com>
	  <CA+55aFzv3X3yW8WZGMZO+aKa=qWi2w8=zn2DP-Q3jRry8Ermyw@mail.gmail.com>
	  <CA+55aFyh1NmBt0LwR3+iD6B-Xa8wAs-nGJ0MBouPhTzWUi8W5g@mail.gmail.com>
	  <1329889428.2193.45.camel@perseus.themaw.net>
	  <1329890027.2193.48.camel@perseus.themaw.net>
	  <1329890251.2193.50.camel@perseus.themaw.net>
	 <1329903139.2193.66.camel@perseus.themaw.net> <4F45062C.8000104@zytor.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=mesmtp;
	 bh=QAwhst2VoDcuchMf0GE29bb0JM0=; b=fFfB+ZfH9fq/1jZkwKhyLVXuMAG2
	h/HtFlfNCc0tZewTjRd0fY0/q0Yju+rzfw16s6BNAK6/5wmRAcyXmSuMtK0wH6E7
	GGKztBuJ/LGYmGW0/qFriokkplNTupq0Az2IBxkt4A8g+evm12G1hn08nFHD6vAz
	12G1pKYGpAEv508=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:content-transfer-encoding
	:mime-version; s=smtpout; bh=QAwhst2VoDcuchMf0GE29bb0JM0=; b=gOc
	ktmm8pWPAjWHwAAARrOgdBzGxVqERvvQRmzfGFjG12V5vvVPT/3ewpdsRJ/dC4OR
	XIVsZ3ydxQ3ydFcpKBNy/D01sZVRfHkBq6ZVlwd6tYyY/k+adKttERDnpvfvLYiC
	3Fajr8/aTNCeLblybxD1N2kpWELRRBffIsZFRAyI=
In-Reply-To: <4F45062C.8000104@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, autofs@vger.kernel.org, Thomas Meyer <thomas@m3y3r.de>, Al Viro <viro@zeniv.linux.org.uk>

On Wed, 2012-02-22 at 07:13 -0800, H. Peter Anvin wrote:
> On 02/22/2012 01:32 AM, Ian Kent wrote:
> > 
> > Oh, DOH ... 
> > 
> > The process mounting the autofs mount is passing the pipe it will use
> > for communication via a mount option so we can do this right in
> > fill_super.
> > 
> 
> Does that mean that the autofs v5 daemon calls mount() by itself, unlike
> the older autofs daemon?  Otherwise you're reading the compatness of
> /bin/mount...

Version 5 does, yes.

There was nothing to be gained by the extra overhead of calling mount(8)
since I wanted to minimize mtab usage and contention, and didn't want
these showing up in mtab either.

> 
> 	-hpa
> 

