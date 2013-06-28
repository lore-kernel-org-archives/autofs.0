From: Ian Kent <raven@themaw.net>
Subject: Re: Linking against libldap_r instead of libldap?
Date: Fri, 28 Jun 2013 15:26:50 +0800
Message-ID: <1372404410.21110.12.camel@perseus.fritz.box>
References: <CAEySpB4wm76DEJE-752Qd=_vtEMMi_vzr=eGu7RfUaJmbVT2GQ@mail.gmail.com>
	 <1372401060.21110.6.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=YPFNT04w5g+RuZG8328MKZ38TD0=; b=OYDkvDqFKNITNKuNb38ZZY2vSxiM
	GaFIeU99Dp9jMhJa356QRdTv80IpuyWb5IMgIZ6mq8IHEnB+LVRRPE68gVpoKHaR
	u8jIx5qD0knaEJE5kAvIBKvMxnONfRzXXe9Ys7Sr9sTUrzQ5nosA2Hom4TqBURnD
	gn584qlJSvi3F2c=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=YPFNT04w5g+RuZG8328MKZ
	38TD0=; b=NUEEwPBXcPGv7+L6D9WmcpQ28Ql1paHhcEZXIL5xGb7Jwv5zZGJz8r
	wruxblhG+1zcKLbiSHEE07WXFnI8bhw1o/0yF5/ztNSn6d1dcpLRXXiW+Lgh/w+k
	wGDSJcB3Ywjba5U5t9QffEwcxiODmEF+gnSEW4KoP/yKNjWBtplU0=
In-Reply-To: <1372401060.21110.6.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs <autofs@vger.kernel.org>

On Fri, 2013-06-28 at 14:31 +0800, Ian Kent wrote:
> On Thu, 2013-06-27 at 22:42 -0300, Leonardo Chiquitto wrote:
> > Hi,
> > 
> > I'm investigating one segmentation fault report (multiple occurrences)
> > in automount where the OpenSSL context (using LDAP with TLS) is
> > clearly corrupted. Reading OpenSSL documentation I found that the
> > the library needs to be correctly initialized in order to run in a multi-
> > threaded environment. I also found that *only* the reentrant build of
> > the OpenLDAP libraries (libldap_r) initialize openssl for multi-threading.
> > 
> > By default (since commit 04dfd15590a) automount is linked against
> > libldap (non-reentrant), but I failed to find the reason behind the change.
> > Could you help me understand why it shouldn't be linked against
> > libldap_r?
> 
> That was a long time ago, Jan 2008.
> Sorry, I don't remember why I committed that change.
> 
> TBH I always thought the re-entrant version of the library should be
> used so there must have been a case to justify not using it, I just
> can't remember what it was.
> 
> Not a good change log entry either .....

I've found a reference to the post this originated from:
http://www.mail-archive.com/autofs@linux.kernel.org/msg06499.html

I'm guessing the claim actually is that -D_REENTRANT should deal with
this although LDFLAGS contains -lpthread so perhaps this was actually a
problem with Mandriva.

In short:

Hello list.
Latest release (5.0.3) attempt to link against libldap_r, and fails on
mandriva because of unresolved pthread symbols. However, according to
ldap maintainer, libldap_r is supposed to be a private library. Hence
autofs should use -lldap, not -lldap_r. Attached patch fix this.
-- 
Guillaume Rousse
Moyens Informatiques - INRIA Futurs


