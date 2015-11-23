From: Ian Kent <raven@themaw.net>
Subject: Re: space(s) in key or location names
Date: Mon, 23 Nov 2015 09:53:46 +0800
Message-ID: <1448243626.3733.18.camel@themaw.net>
References: <B75A85DC-1A7A-475F-AE15-7FBF60FCE936@ukgb.net>
	 <1448242837.3733.11.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=2e5fUGcIYvv3xFt1DEvrzULHdR0=; b=OrhfiV
	zGXdOgqsF6PEwihJOdCXfYjUcLHQhEbGSqec6qvi5kS6HscHLmnl4kP0tcaKwoLu
	jo0RigiMvLSk1TgFSteXcJ7cFIEIluS2KEf2iKrYOA41E2urlsJBWWICGuExrbHk
	fQxGpQcGB1031CVtn8KJvDFvWRIU3gq7KQ2ws=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=2e5fUGcIYvv3xFt
	1DEvrzULHdR0=; b=SoUHyDJw1AHKso2+OxBF+OxxmBbK26HW9JXRAmszr2qNe/t
	Fy6XbJLFsjjMwWTMG90EpJM1mfkB3xUzVdvf+5bQuyN8SdxzjYQjlICnU/rObs8r
	VtGOdLm+mBV7FBWqoIbPUP/jbq0SHswNdFuPNQNZHdv1XuOjcofNKqisM8qE=
In-Reply-To: <1448242837.3733.11.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Ken Gillett <KenGroups@ukgb.net>, autofs@vger.kernel.org

On Mon, 2015-11-23 at 09:40 +0800, Ian Kent wrote:
> On Fri, 2015-11-20 at 09:42 +0000, Ken Gillett wrote:
> > I=E2=80=99m really struggling with this and hope someone can point =
me to a
> > solution.
> >=20
> > I need to automount onto a mountpoint (directory, i.e. folder as
> > it=E2=80=99s
> > on OS X) that has a space in the name and I cannot change that.
> > I=E2=80=99ve
> > read many suggestions to escape the space with a =E2=80=98\=E2=80=99=
 or =E2=80=98\040=E2=80=99 or
> > quote the path, but nothing I=E2=80=99ve tried works. It either sim=
ply
> > fails
> > to work or creates the mountpoint that includes the escape chars in
> > its name.
> >=20
> > To clarify, other mounts that have no space involved work fine, so
> > the basic setup is sound and if the automount is configured in a
> > local (LDAP) directory, the space is no problem. However, I don=E2=80=
=99t
> > want to use that method and really need to use simple map files in
> > /etc, but there seems to be this issue with how they are parsed. I
> > am
> > clearly not the only person with this problem.
> >=20
> > I=E2=80=99d really appreciate it if someone could explain how to ov=
ercome
> > this and allow for spaces in pathnames used in map files.
>=20
> The handling of spaces in automounting when using Sun format maps is
> difficult because of the syntax of the map format, it allows for
> ambiguity which make quoting difficult.
>=20
> So I'm not surprised to here this.
> But sadly I don't think we can help you because OSX uses a different
> implementation to Linux autofs which I know nothing about.

Thinking about this, if the OSX implementation is from the original BSD
(and a Google search shows the utilities look like those in old IRIX
distributions) then they would have been trying to provide
functionality as found in Solaris.

So a web search for Solars autofs documentation might help but quoting
in that was difficult too. For example I seem to remember that to quote
a location you needed to quote the path and not the server name, eg.
server:"/path/to share". Don't remember seeing anything about keys
though.

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
