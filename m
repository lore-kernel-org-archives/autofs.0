From: Ian Kent <raven@themaw.net>
Subject: Re: automount subprocesses accumulate
Date: Mon, 14 Sep 2015 09:30:58 +0800
Message-ID: <1442194258.3030.4.camel@themaw.net>
References: <55F1971B.1050301@excellency.fr>
	   <1441949699.5198.6.camel@themaw.net> <55F2EFBD.2020104@excellency.fr>
	  <1442142599.2902.13.camel@themaw.net> <55F55C0E.3010806@excellency.fr>
	 <1442145133.2902.26.camel@themaw.net> <55F5669B.7050409@excellency.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=g6DX4eZ+3FL8CVhi2sfvIx4JrgM=; b=Sp2bHE
	i0rKrST79zBXUB3ZQACWGeKX4DHXIGaNe+OkG9lrbxv/XfqWxv3Hh8BC1okohDDG
	JEMhrCjU9nzfX9zHG86qLk4Y9YDUgb3lJtztUVqjMJlth22Azw33QCmZNeNnj5Q0
	ddvOQt0O5jeeLK89TbfJv1epQfuO5SzUm8nok=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=g6DX4eZ+3FL8CVh
	i2sfvIx4JrgM=; b=olOcAHPid0ZC6yG10rr7bqOfkoeMfxKASHAPUakuIjwz7EE
	Z3Epc59Q5BtrrchF+0NoBI7MMGzyrs43gO4eykL0LlTFW0G8YlohyqNNrQ8IONdG
	fZG3EQdKXhjYkqw5p22vRnLT6ww65AAU68J8qopPKQ/rqdQLP3ul99mTakKc=
In-Reply-To: <55F5669B.7050409@excellency.fr>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: cbay@excellency.fr
Cc: autofs@vger.kernel.org

On Sun, 2015-09-13 at 14:05 +0200, Cyril B. wrote:
> Ian Kent wrote:
> > OK, see if you can apply this patch.
> > The CHANGELOG hunk won't apply, of course, so just ignore the reject or
> > delete the hunk from the patch before applying it.
> >
> > Umm ... now I see I need to fix a couple of spelling mistakes as
> > well,;)
> 
> 
> It looks like it fixes the bug indeed! At least I'm unable to reproduce 
> it on my test environment.

Sounds promising.

> 
> I'll deploy that version on my production server today, I'll let you 
> know how it goes.

OK, assuming it goes well, I have a bunch of other patches but I'm still
not sure they're ready to be committed upstream. I'll work through those
to work out what I can commit so I can make those (including this)
available in the repo and as a patch on kernel.org.

> 
> Thank you!
> 

My pleasure.
Ian

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
