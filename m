From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] Add a --mode option to chmod the mount point of the maps
Date: Mon, 14 Sep 2015 11:23:06 +0800
Message-ID: <1442200986.3030.45.camel@themaw.net>
References: <55F58085.4090509@excellency.fr>
	 <1442199959.3030.40.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=ZctWuVuF96tzz+G4OilMOyH9HNo=; b=ZXC5sT
	11J1XJFDyLHdd3qAovobXG7EU+s8luUtFVutahptNx364hlWbVC5dgZ61VL3y1rB
	K8daoJV6wr37aMUzbUeQeet5tf0XIycchGnftADHqem/gxxzRyyo4phPJ8TKAUOh
	uLuZWEO5ftW31vtrK8vgYEtROSVby8i+o5MLs=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=ZctWuVuF96tzz+G
	4OilMOyH9HNo=; b=FMBepQzDk315KS5+wXGycgBCxh9niBBF12YTFs6QBSKDxC7
	/f/qUiT5jPTGu9QtzenAtD1j+lzZ9OaFQe4s70BOj4KJDZ8ez6MW4opwhtsWxfOJ
	iK2TlZnzikrOXrW+V9ASOcN5JWd1iDUNLPyJyPe+Ocs1bROerrVZwwZ0sFso=
In-Reply-To: <1442199959.3030.40.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Cyril B." <cbay@excellency.fr>
Cc: "autofs@vger.kernel.org" <autofs@vger.kernel.org>

On Mon, 2015-09-14 at 11:05 +0800, Ian Kent wrote:
> On Sun, 2015-09-13 at 15:56 +0200, Cyril B. wrote:
> > 
> > My solution was to add a --mode option to autofs, with the included 
> > patch. I'm not familiar with autofs's code or even Lex and Yacc, so my 
> > code is probably more of a proof of concept. It seems to work fine in my 
> > use case, though.
> 
> If you want to contribute patches then post then in-line as text without
> any additional change (eg. ensure the mailer doesn't split lines therby
> corrupting the patch).
> 
> I can't properly comment on the patch, even if I wanted too, because it
> isn't in-line.
> 
> Anyway, what about updating the man pages with your new option?
> Should text modes be considered, perhaps octal modes are sufficient, and
> should be all that's allowed, to keep the change as simple (generally a
> good idea) ...

And btw, I've been trying to ensure that all autofs patches have a
problem description for quite a long time now, so we need that too.

Generally describing what the change does isn't OK, a description of why
it's needed is more important and usually negates the need to describe
what the patch does.

Recently I've started adding "Signed-off-by:" annotation too.

Ian 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
