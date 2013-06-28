From: Ian Kent <raven@themaw.net>
Subject: Re: Linking against libldap_r instead of libldap?
Date: Fri, 28 Jun 2013 14:31:00 +0800
Message-ID: <1372401060.21110.6.camel@perseus.fritz.box>
References: <CAEySpB4wm76DEJE-752Qd=_vtEMMi_vzr=eGu7RfUaJmbVT2GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=/OZzAd11wGsimsEygutxBQNWpG4=; b=wRZj7WNrSWz2trAEM2Bx+Hi86J0N
	RwSHbVrIjpifEcY+J6FwXxty+ck7r7is4eYCNMsvU6TfsL0by4BSNQZxctLrxXTH
	qVRiHsHJNT8KPeqXKXaUzPFi6p3bxm8Op17jeTP+x5GDiu2Sff0hvJgUo8HoX7VC
	uEsNESYB90o2qj8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=/OZzAd11wGsimsEygutxBQ
	NWpG4=; b=pgNc6l5L8TJbFfNz187EbAvewDY4Yf3vUR/GbkMPLteAGlRoMPTNj4
	mHd+s1VhFb7zKlJHVcGuckY85MIbOAvmeKwkHJ5qGyBDzsdNLvce5QK0uuL0ujqb
	WqoLyJw2THhHsN6bjioPhIKD7SDLEJWWBWsQowh3tSVgUaEfh28z4=
In-Reply-To: <CAEySpB4wm76DEJE-752Qd=_vtEMMi_vzr=eGu7RfUaJmbVT2GQ@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs <autofs@vger.kernel.org>

On Thu, 2013-06-27 at 22:42 -0300, Leonardo Chiquitto wrote:
> Hi,
> 
> I'm investigating one segmentation fault report (multiple occurrences)
> in automount where the OpenSSL context (using LDAP with TLS) is
> clearly corrupted. Reading OpenSSL documentation I found that the
> the library needs to be correctly initialized in order to run in a multi-
> threaded environment. I also found that *only* the reentrant build of
> the OpenLDAP libraries (libldap_r) initialize openssl for multi-threading.
> 
> By default (since commit 04dfd15590a) automount is linked against
> libldap (non-reentrant), but I failed to find the reason behind the change.
> Could you help me understand why it shouldn't be linked against
> libldap_r?

That was a long time ago, Jan 2008.
Sorry, I don't remember why I committed that change.

TBH I always thought the re-entrant version of the library should be
used so there must have been a case to justify not using it, I just
can't remember what it was.

Not a good change log entry either .....

Ian


