From: Ian Kent <raven@themaw.net>
Subject: Re: autofs: make the autofsv5 packet file descriptor use a
 packetized pipe
Date: Mon, 30 Apr 2012 09:29:58 +0800
Message-ID: <1335749398.2281.0.camel@perseus.themaw.net>
References: <20120429205429.63CCD7C0064@ra.kernel.org>
	 <4F9DD994.70202@zytor.com>
	 <CA+55aFy72rPMq3M2_PU0ue45Fb38_Effrfhu2uOpdVXt9H1XOg@mail.gmail.com>
	 <4F9DDCB6.1070908@zytor.com>
	 <CA+55aFwGZm4+rdJ+xArhsVJ8P5gH3xxCfuoHibotr0Sik484=w@mail.gmail.com>
	 <4F9DDE47.5060008@zytor.com>
	 <CA+55aFzDhkVzaUYQwKbkUqoRNb223+w0-k=pOxTZHja75JOMvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=mesmtp;
	 bh=c/u82V1QohAZt/MBYCj0L4uCBIY=; b=jh/MtUA+IROEnaZusmfEc4wmIeUb
	Dq0vL96DCsOh/u/titEWrlsNGZbvc+rTPF7wbCh2Vdejo4eJ8jsNgFsobbklWxXO
	9H4l5zE5Kor4lqJ0O6cNbQsY7TgfAsfg8+mVEcNs0wQNjOB6+1nXD+Cv3eymBxPP
	r/awSYqUy1d98UU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:content-transfer-encoding
	:mime-version; s=smtpout; bh=c/u82V1QohAZt/MBYCj0L4uCBIY=; b=ueC
	KyVSikzkHVsz8LWRDH1Hrho+mRiixG2/JJjPEOeuFodtEiKUubcZ9NEKzILDEJKr
	w6QhGGWaQvN8hWsI6G9uloyN0V/o3LtVDeVDSeCtKi1pTEVcxbzWjQoItYG2wLGi
	wq0kSHTBRs9CMSELY7lwlBBW9hiLffizafr8Acgo=
In-Reply-To: <CA+55aFzDhkVzaUYQwKbkUqoRNb223+w0-k=pOxTZHja75JOMvQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michael Tokarev <mjt@tls.msk.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Thomas Meyer <thomas@m3y3r.de>, autofs@vger.kernel.org

On Sun, 2012-04-29 at 17:43 -0700, Linus Torvalds wrote:
> On Sun, Apr 29, 2012 at 5:35 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> >
> > Which is funny/sad, because that's actually the intended way the
> > interface is meant to work.
> 
> Well, the autofs packet model is actually horribly badly misdesigned
> even for that: the header doesn't contain the size of the packet. It
> contains the packet *type*, and from that you can then determine the
> size (of course, every other program would determine it *wrongly* for
> this whole x86-64 alignment reason), but that is actually a horrible
> model because it assumes you know all the packet types.
> 
> (There's a "len" field in the v5 packet, but that's not the packet
> length, that's the length of the name component)
> 
> And the reason nobody does that is that in practice there is only ever
> one single type of packet that is possible anyway, so there's no point
> in even reading the header to find the type.
> 
> So a much nicer model is one where the actual *size* of the packet is
> in the header. That would have allowed for not having that fixed
> maximum size of a name etc, and would have avoided the whole problem
> to begin with.
> 
> Of course, the nicest model of all is to just use a packetized
> interface to begin with, so that none of these issues exist. Which is
> what we're now effectively moving to, unless we can find some horrible
> program that makes that impossible due to it playing games and knowing
> it's a "stream".
> 
> Looking at am-utils, I think we're ok so far. But maybe you know of
> yet another crazy user of the autofs interfaces.

autodir looks ok as well.

http://sourceforge.net/projects/intraperson/files/latest/download

> 
>                       Linus

