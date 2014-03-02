From: Ian Kent <raven@themaw.net>
Subject: Re: "Too many levels of symbolic links"
Date: Sun, 02 Mar 2014 19:25:46 +0800
Message-ID: <1393759546.9725.66.camel@perseus.fritz.box>
References: <1391145206.2486.25.camel@perseus.fritz.box>
	 <52EB7694.20707@molgen.mpg.de> <52EB7B07.2070707@molgen.mpg.de>
	 <530484B7.6030305@molgen.mpg.de>
	 <1392896501.2508.16.camel@perseus.fritz.box>
	 <1392898704.2508.26.camel@perseus.fritz.box>
	 <530625D0.7020808@molgen.mpg.de>
	 <1392946952.2495.3.camel@perseus.fritz.box>
	 <53076D91.7050703@molgen.mpg.de> <53107D4A.90904@molgen.mpg.de>
	 <20140228132906.GM15017@sh-el6.eng.rdu2.redhat.com>
	 <5310F30D.9040407@molgen.mpg.de> <53125771.4030000@molgen.mpg.de>
	 <531280C5.1050906@molgen.mpg.de>
	 <1393726632.9725.3.camel@perseus.fritz.box>
	 <5312EBAC.2070200@molgen.mpg.de>
	 <1393753284.9725.31.camel@perseus.fritz.box>
	 <5313066F.6040302@molgen.mpg.de>
	 <1393758213.9725.60.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=Mg9LsANQ52VFVjW9tldyb19YSt8=; b=kOO/na5LDf3lYfT+lYaV83qU//51
	Rq73R1pVYIjUcqFblKkiT7YUAP9deUxq7uWUp9RseOL72pFPEbOwnwd+gVyediPi
	3qA8lWVInITGujEVeyoI1mcjg+hv6JQzLj//h94eRRgB5ioJ4t3se98U8qm2FNVl
	xhEot2r+lEEw58k=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=Mg9LsANQ52VFVjW9tldyb1
	9YSt8=; b=O3tkXiLLDuoMTelCaGN9f9Hb5cBVU4SA6zWgIt/o+FPpcrb6sKW2fK
	IGgYjnyXs+8flqIQK3ZeydSLiLtazNC4L+cSi1geST4srPjaCoQQcNxG4yFk55/+
	xtJSBO03ZSiBskUryduJ8obtrRoz/nTzHHddx9ACXpRP+/qU9DZJY=
In-Reply-To: <1393758213.9725.60.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: Alexander Viro <aviro@redhat.com>, autofs <autofs@vger.kernel.org>

On Sun, 2014-03-02 at 19:03 +0800, Ian Kent wrote:
> On Sun, 2014-03-02 at 11:22 +0100, Donald Buczek wrote:
> > 
> > This goes in the direction you mentioned in your other mail ("Illegal as 
> > far as autofs is concerned because an autofs mount is strictly 
> > associated with a path defined by its map") The system-wide, absolute 
> > semantics of pathnames in the automount world don't fit well into the 
> > process-local, relative mount semantics of the kernel.
> 
> Yes, but a bigger issue is that the autofs semantics of multiple name
> spaces aren't defined which means all I can do for now is make
> statements like the one above.
> 
> No, asking folks concerned with namespaces didn't result in useful
> feedback. Perhaps I'm asking the question in the wrong way, I don't know
> yet.

Or asking the wrong people!

But there are two namespace related patches in the 3.14.0 rc kernel.

TBH I can't see how they would make a difference here but we probably
should try a patched kernel to find out for sure.

See commits 6eaba35b and fbff0870 in the current Linus kernel tree.

If you need me to send you the patches for the kernel your using I can
do that but I'll need specific kernel version.

Ian


