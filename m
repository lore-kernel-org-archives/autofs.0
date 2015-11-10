From: Ian Kent <raven@themaw.net>
Subject: Re: "rmdir_path: lstat of <path> failed" issues, despite updated
 autofs RPM
Date: Tue, 10 Nov 2015 16:48:04 +0800
Message-ID: <1447145284.3028.8.camel@themaw.net>
References: <7D63CDFD-57AB-4BCA-AD12-138CBC44342D@isolar.DynDNS.ORG>
	 <1446964411.2974.7.camel@themaw.net>
	 <8C7EFEF6-C73F-43F2-AC63-5CB5ED2B806B@isolar.DynDNS.ORG>
	 <1447026421.2990.11.camel@themaw.net>
	 <80BF6988-2849-49A0-AEC5-4079AB9B8CFF@isolar.DynDNS.ORG>
	 <1447134536.3010.21.camel@themaw.net>
	 <146CD18A-8C87-4E7D-8FA8-262FAA9C1195@isolar.DynDNS.ORG>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=r456FWzsGF92Hb4I9bbErAYHCms=; b=hcv76w
	eF2fuzNR/WenSKlWfw35rKeGp1YMknbYrvzCOQBKLJcv0Bbk/nUD3AXNXyjvuqBx
	I6vsNAcjLgaqKrlL3Vm/Iz6Juww4U5hr9S8+sCS1Cjwm1uM9gi/d/9IPZTePOPOS
	h/ThN8XmRn5ATCWCg6yaNWaj5lYqr9qqEujms=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=r456FWzsGF92Hb4
	I9bbErAYHCms=; b=GPy/GAaYPXxFWF2O2cZIKwftKET7imTuvbaKiu49FKVzzQh
	kMQdXxP/qpGOSKHGruR1/gO7UzZIdlcM8CSqy/jEqlYQ4ntO50a85+8BRVxvwv9n
	MKm4STsO1M0QnpJQPdBjrZaZixtTmop8NkCQQ4ChztZdnxO2r9nC/ySkVaIo=
In-Reply-To: <146CD18A-8C87-4E7D-8FA8-262FAA9C1195@isolar.DynDNS.ORG>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs@vger.kernel.org

On Mon, 2015-11-09 at 23:18 -0800, Greg Earle wrote:
> > On Nov 9, 2015, at 9:48 PM, Ian Kent <raven@themaw.net> wrote:
> > 
> > If there are directories that are possibly broken in some way then
> > to
> > clear them up the autofs managed mount point must be umounted.
> > 
> > But if any mounts are busy at shutdown they are left mounted, and
> > the
> > autofs mount itself obviously must be left mounted too, then autofs
> > re
> > -connects to the mounts when it starts again.
> 
> That's interesting, never knew that before.  So maybe it thinks these
> phantom mounts should still be "mounted", and keeps trying to do it.
> 
> 
> > That complexity is the reason I usually just recommend a re-boot be
> > scheduled, plus if there is some sort of brokenness within the
> > mounted
> > autofs file system there's no knowing if there were side effects
> > when
> > it happened.
> > 
> > Sorry, I'm not really much help with this.
> 
> Well, I've already told Xymon to ignore these (at my peril!), so as
> long
> as they are just harmless messages, I'll live  :-)

It's hard to know for sure if these indicate you're in for further
problems but there doesn't seem to be much you can do about it for the
time being.

As long as the system continues to provide the expected service then I
have to say it should be fine to ignore them.

But I always get a bit nervous when I see unexpected things like this
so I still recommend scheduling a re-boot. As long as you aren't seeing
other bad things happen the urgency of doing so isn't high.

So as and when the opportunity arises would be the thing to do. At
least get the request on the operations radar.

> 
> Thanks for looking at the code just in case.  Was hoping it might be
> something simple; obviously it wasn't.
> 
> 	- Greg
> 
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
