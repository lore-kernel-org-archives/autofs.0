From: Ian Kent <raven@themaw.net>
Subject: Re: fix undefined authtype_requires_creds error
Date: Tue, 29 Oct 2013 09:15:14 +0800
Message-ID: <1383009314.2368.8.camel@perseus.fritz.box>
References: <CAF1ZMEc84Ep6cpEbnmYw4YJpuQJwrOVketBtNcgNZZTGTBHz_g@mail.gmail.com>
	 <1382948864.2523.25.camel@perseus.fritz.box>
	 <CAF1ZMEfYrE_USvigHEpOvwidKDFjFvN=30mt_qnZM+HV5Rm4vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=MfNIe5wXp4OJv/ldVyj0/I9Focw=; b=d9ERjs1D22KXAE/OhSkxIjoE7Uf4
	hz8751PCkhrMomPseE9c0lRQQdlE2IDPDC5uhvNOA4FGuxJmbqGF1vnyPjNN68R8
	E0hN48K5OQjMQHRinlWa7ZFYctsBbyz3J5LrZ6iIjUfbAFG4aYGTAnZHecmTRH9Z
	LAQGG0JwtPCNYwk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=MfNIe5wXp4OJv/ldVyj0/I
	9Focw=; b=GS7Ofk6JBRmTj42nBDCe7Bd1Ho4TJXff38xOqLbbHzv2HDDUkOf25N
	mAXCzI/no945uE4w8KT/jdpCyqQ9UWhAUPKljw7MkCXA6MdvCjhdlDqPT96VKcM5
	K2h0KjkaEr4PBqZSsjc26JSf3wA0U3pv1NcGduTSALWarY936oEP4=
In-Reply-To: <CAF1ZMEfYrE_USvigHEpOvwidKDFjFvN=30mt_qnZM+HV5Rm4vQ@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Mon, 2013-10-28 at 17:59 +0800, Dennis Lan (dlan) wrote:
> On Mon, Oct 28, 2013 at 4:27 PM, Ian Kent <raven@themaw.net> wrote:
> > On Thu, 2013-10-24 at 11:34 +0800, Dennis Lan (dlan) wrote:
> >> HI Ian:
> >>   here is simple patch for fixing undefined authtype_requires_creds
> >> error while LDAP enabled but without SASL.
> >>
> >>   sorry for using attached file, since I have problem to use "git
> >> send-email" in my office.
> >>
> >>   also the downstream bug here, https://bugs.gentoo.org/show_bug.cgi?id=489128
> >
> > Ahh ... something I missed in 5.0.8.
> >
> > I've added it to the pending patch queue in the autofs-5.0 and master
> > branches.
> >
> > Not sure yet how I'll manage the two branches but I'll see how it goes
> > and then decide.
> >
> > The master branch will eventually become autofs-5.1.
> >
> > Ian
> >
> >
> HI Ian:
>   Ok, I'm fine with this, just make sure you accept the patch ;-)

It'll get committed next time I do a commit on the patch queue.

>   And thanks a lot.
> 
> Dennis Lan (dlan)
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


