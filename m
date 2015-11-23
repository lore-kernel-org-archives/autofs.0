From: Ian Kent <raven@themaw.net>
Subject: Re: space(s) in key or location names
Date: Mon, 23 Nov 2015 09:40:37 +0800
Message-ID: <1448242837.3733.11.camel@themaw.net>
References: <B75A85DC-1A7A-475F-AE15-7FBF60FCE936@ukgb.net>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=mO4Wy/dRa9I6rLqVR1Zlpt+ZsGc=; b=cwB4rx
	4wuYuwAyM/sTdSZjtRYs7+7RIOrFBkNy+B/Z+Pg49vyHKhF6xH4t8Usukr9gJb6S
	IxeCZNT77kJRWvy7qoxcyivxtkQUdU+6rZUKD27bc8dmiayozhMgfX5AHSa1Tx5B
	tscVlqt4I1VAE5uoIqRN43j6Z8PgintMlM+r8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=mO4Wy/dRa9I6rLq
	VR1Zlpt+ZsGc=; b=j0U/J1dCv7iOm7+9030Rj0SJH4V1II+cFbb6J02L1dI3A6o
	qdSQCjXwFCE2oi/fXGLDiL/+DDRk6wcHNRANKq/cI1NP88v/2BAqo/ckkjHunUKC
	YkZ2iX5rspP9SWfNnNJEi8lmhIDAiXNdhJJHH/XwsHPBB5/zU6dXS7YT7mLs=
In-Reply-To: <B75A85DC-1A7A-475F-AE15-7FBF60FCE936@ukgb.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Ken Gillett <KenGroups@ukgb.net>, autofs@vger.kernel.org

On Fri, 2015-11-20 at 09:42 +0000, Ken Gillett wrote:
> I=E2=80=99m really struggling with this and hope someone can point me=
 to a
> solution.
>=20
> I need to automount onto a mountpoint (directory, i.e. folder as it=E2=
=80=99s
> on OS X) that has a space in the name and I cannot change that. I=E2=80=
=99ve
> read many suggestions to escape the space with a =E2=80=98\=E2=80=99 =
or =E2=80=98\040=E2=80=99 or
> quote the path, but nothing I=E2=80=99ve tried works. It either simpl=
y fails
> to work or creates the mountpoint that includes the escape chars in
> its name.
>=20
> To clarify, other mounts that have no space involved work fine, so
> the basic setup is sound and if the automount is configured in a
> local (LDAP) directory, the space is no problem. However, I don=E2=80=
=99t
> want to use that method and really need to use simple map files in
> /etc, but there seems to be this issue with how they are parsed. I am
> clearly not the only person with this problem.
>=20
> I=E2=80=99d really appreciate it if someone could explain how to over=
come
> this and allow for spaces in pathnames used in map files.

The handling of spaces in automounting when using Sun format maps is
difficult because of the syntax of the map format, it allows for
ambiguity which make quoting difficult.

So I'm not surprised to here this.
But sadly I don't think we can help you because OSX uses a different
implementation to Linux autofs which I know nothing about.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
