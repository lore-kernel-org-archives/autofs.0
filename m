From: Ian Kent <raven@themaw.net>
Subject: Re: Automounting of smb shares with dollar sign
Date: Fri, 01 Jul 2016 11:44:00 +0800
Message-ID: <1467344640.3900.21.camel@themaw.net>
References: <974581467282064@web15m.yandex.ru>
	 <1467342935.3900.17.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=JU5yBcubMWh2TKssJtX1mqA4xWU=; b=W6YAi1
	MR6jEtCxSyo8lFqhTRjWPFZgNTyyurgs9GC0m2mumA0zWPWmYtsatKuZpS5iZycs
	gtSfCtilHkquY7g3t5FS2BEMoaMr/RUbuqCwGHcS+DQOEX/Y98AyAR0tJXI5pmhp
	ucVeRwZfD5oTllL3bYzvGsCcyemR5TEVqg4Hc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=JU5yBcubMWh2TKs
	sJtX1mqA4xWU=; b=KkWDEpfzy6n5Jn9lsPW79C/YBAvA1e+qXGpu2CVgH9aJEiw
	w4R/95QzKd7FF9XkUbC9WxevNQEFjLW+AWtAmGW6btt+BuR0QJkDBrr/zhTMKhH1
	ejeiMtLLHeiyX7pLjpmMFQILIKtGs6R4jBjTKPGkZ6AdzgHtXlMn+gX2cPSI=
In-Reply-To: <1467342935.3900.17.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Yury Krivopalov <ykrivopalov@yandex.ru>, autofs@vger.kernel.org

On Fri, 2016-07-01 at 11:15 +0800, Ian Kent wrote:
> On Thu, 2016-06-30 at 13:21 +0300, Yury Krivopalov wrote:
> > Hello,
> > I found a problem, that started to reproduce on my new environment
> > (archlinux), before that I used Debian Wheezy and everything worked fine.
> > The point is that I can't automount smb shares with dollar sign (Ex.:
> > //hostname/C$).
> >  
> > It happend because two facts:
> > 1. Autofs reads '$' as a special symbol
> > 2. mount.cifs reads '\\' as a delimiter
> >  
> > So in my case if I returns "//hostname/C$" from auto.smb, then automount
> > daemon replace '$' to '' and if I returns "//hostname/C\\$" then mount.cifs
> > crops "\\$" and uses '$' as a prefixpath mount option.
> 
> Escaping of cifs mount entries has been a long standing problem over and over
> again.
> 
> Mostly fixes seem to always to have bad side effects, dropping them of trying
> to
> fix them often results in the problems returning.
> 
> I'll have a look at this and try and work out if it would have side effects
> for
> other than cifs mounts.
> 
> >  
> > I attached simple fix for autofs-5.1.2, that drops back slash after
> > arguments
> > parsing. It works in my case, 

Actually, now I look closer, this might be a bug in expandsunent().

The expandsunent() function is called before parsing the map entry not after so
changing this could have unexpected side effects.

I'll run parser tests with this change and see what happens, when I get a
chance.

> >  
> 
> Thanks for our patch.
> Ian
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
