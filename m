From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH v2] Introduce a version6 of autofs interface, to fix
 design error.
Date: Sat, 28 Apr 2012 09:56:24 +0800
Message-ID: <1335578184.4141.9.camel@perseus.themaw.net>
References: <20120427.143402.1028957981042061092.davem@davemloft.net>
	 <CA+55aFwvFaxBT8Mdp5s4-6Gxy7nM4WVzbWna4RF_OUK3hnx+jQ@mail.gmail.com>
	 <CA+55aFyLk-uPMVaic19YOWdvdj2pv4R+E3s7UQ6voAy6UkO_Sg@mail.gmail.com>
	 <20120427.151433.1007849975903946491.davem@davemloft.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=mesmtp;
	 bh=7vjm039AlxYZfGCIMfvaSqDJHGk=; b=OYBMHdOvjmd1iWxwERnv6s2p8gg6
	GunuRNY9gwW8Up4vFsN0c7JEVaybg98Hll6s7XEkPo3RqjAZ4dnUWDEnpfGFrT2R
	WQuQ5WVHJ+Bxt4ccEZaIqLIQd7QWhEfn4hRxaV3D15VaHpUICljlZryfW9BSZZAZ
	JKTbvrgepAKgZzw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:content-transfer-encoding
	:mime-version; s=smtpout; bh=7vjm039AlxYZfGCIMfvaSqDJHGk=; b=TEI
	hEdVcBOxHQoTbsOG4l2QF/tfckeDrXWYhc1e1vvMM3Af6EPnYlV9LjGmMXttsWPP
	yg68C96AZFu6udAR8P113EU9TBGVZ9DFzaDrxfOX0FswQK9nezAq7DB9sWfKpKBt
	i0F15v5qQ6ZfwdMUDDqvq+FiXg6RQhrfdLQbFmXA=
In-Reply-To: <20120427.151433.1007849975903946491.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: David Miller <davem@davemloft.net>
Cc: torvalds@linux-foundation.org, mjt@tls.msk.ru, linux-kernel@vger.kernel.org, autofs@vger.kernel.org, thomas@m3y3r.de, stable@kernel.org

On Fri, 2012-04-27 at 15:14 -0400, David Miller wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Fri, 27 Apr 2012 11:55:12 -0700
> 
> > On Fri, Apr 27, 2012 at 11:42 AM, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> >>
> >> There's no question that systemd is broken.
> > 
> > Actually, I'll take that back.
> > 
> > Yes, systemd has breakage. But it's actually automount that is the
> > truly broken piece of sh*t.
> > 
> > I think that 'automount' is even more broken. The fact that the
> > automount maintainers knew about this, and added TOTALLY BROKEN code
> > to their automount source tree, over five years ago, because the
> > authors clearly did not understand what the f*ck they were doing,
> > that's the real problem.
> 
> I respectfully disagree.
> 
> It's ugly as shit, but it is the only one place where one can be
> absolutely sure that we are dealing with a pipe passing those v5
> things around.
> 
> All these hacks we have been talking about, assuming the mount means
> the pipe is for passing structure so-and-so around, and now trying
> to find some other check such as one on current->comm...
> 
> That's better?
> 
> Only the application really knows.  And I bet the person who wrote
> that automountd code you find so distasteful analyzed this and came
> to realize how difficult the kernel side would be to get right.

There's nothing I can say in my defense, Linus has made that very clear,
over and again.

When I realized the alignment mistake there were already shipping
binaries so I decided it was too late to change that.

And I see I got the analysis of the architectures alignment wrong, mmmm,
that's bad as well.

I guess I'll just be quiet now since anything I say is probably going to
be wrong.

Ian

