From: Ian Kent <raven@themaw.net>
Subject: Re: autofs version?
Date: Mon, 23 Nov 2015 09:35:11 +0800
Message-ID: <1448242511.3733.5.camel@themaw.net>
References: <32D0E700-34F3-4F68-BAB8-205E146CFCDD@ukgb.net>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=X+fa2nuvLX8CKbn6J5chJSHqvG8=; b=oS3G/l
	28ITTu86e2Hc5xbXLZJtq8PuWsGBeWPqeZNaYr8qRoxrF7MgIGnSOpIaofs7pT6n
	7dhBeIPfzA81cy9oZmiIi/7TxBeH3Jt1lVD+7DsWacOYry10JLTLy6XoxFfAUIsB
	lwGdhRwIL88b1gVMot0ipNiZn1o/RhTFS/SN8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=X+fa2nuvLX8CKbn
	6J5chJSHqvG8=; b=Xj0xrAX4R2DwRmvriFsYThVc7Cm0TCnEAZhwCd/kgnf3I/K
	8zJczzeorQgtGTu0X6PxfKO/SZ3mYKon7lo3NNRejVBwxiXhp29w6Wv7W4yugxXa
	Cmd4D5sR0/XX8AXa6cx9XtcCuPR/Trq+oRRuUdhSR2gYhRuQADZLECmfJdRA=
In-Reply-To: <32D0E700-34F3-4F68-BAB8-205E146CFCDD@ukgb.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Ken Gillett <KenGroups@ukgb.net>, autofs@vger.kernel.org

On Fri, 2015-11-20 at 10:51 +0000, Ken Gillett wrote:
> I=E2=80=99m ashamed to have to ask this, but how can I find the autof=
s
> version number?
>=20
> Before calling me names, I should point out this is on OS X and
> Apple=E2=80=99s implementation of automount has NO -V or =E2=80=94ver=
sion option. Not
> shown in the man page and doesn=E2=80=99t work, so it=E2=80=99s reall=
y not there.
>=20
> No-one can make me any more irritated with Apple over stuff like
> this, but how else can I find out the autofs version number? This is
> El Capitan so maybe someone simply knows the answer?

Sorry, thus list is for Linux autofs.

I don't know what base source the OSX autofs implementation uses but I
think OSX is a BSD based OS and I'm not sure if it originally had an
autofs implementation.

I do remember seeing an announcement somewhere fairly recently about a
BSD implementation but I can't even remember which distribution that
was.

I think your only option is to log a fault with Apple.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
