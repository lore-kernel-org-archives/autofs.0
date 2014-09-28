From: Ian Kent <raven@themaw.net>
Subject: Re: NFSv4: Unable to mount, nonsensical error
Date: Sun, 28 Sep 2014 10:10:14 +0800
Message-ID: <1411870214.6107.5.camel@perseus.themaw.net>
References: <5426C943.1060307@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	x-sasl-enc:message-id:subject:from:to:cc:date:in-reply-to
	:references:content-type:mime-version:content-transfer-encoding;
	 s=mesmtp; bh=N15ktq/bTGYzAtd7QV93jPho6yc=; b=vEH1GAYv3ZZ97QdcAa
	Oce1kXTTj5A2Qgj2iYMFUmgRA5LknnxSvC0vDxKeI8+uMr4eUwRQ39EScSvwfQHV
	8G4I7nTNlE73Uavx4ov9Bg4ZrwFw3qx3jbAL0PqfeOpRqHlgdRBWyh5gOhrpjvpy
	oUY92hiksWU1OthRwUpX8LAi0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:subject:from:to:cc
	:date:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=N15ktq/bTGYzAtd7QV93jP
	ho6yc=; b=HSCdwyGRMSXzT78lqKRtz/p9QTQXiMrkJmkbo5/kmks78sp/1+edr1
	raJS2ACFB6e15S1zclzumjDW8gmWUePEMisWvsihxdv0o+4Fqy6W+xMmiHasWmE7
	uZBgKnXesv56yI/Odla8f1vbb8JMcBMC5PXmaAyVh6jbtYagkAXXo=
In-Reply-To: <5426C943.1060307@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Andreas Reis <andreas.reis@gmail.com>
Cc: autofs@vger.kernel.org

On Sat, 2014-09-27 at 16:27 +0200, Andreas Reis wrote:
> Hi,
>=20
> I'm trying to automount a NFSv4 share to /mnt/bar from Host A via a=20
> direct map, but can't get it to work no matter what.
>=20
> Mounting it manually with the very same options works perfectly fine.
>=20
> auto.master:
> /-     /etc/autofs/bar.nfs    --timeout=3D15 --ghost
> /foo   /etc/autofs/auto.nfs   --timeout=3D15
>=20
> The second line is an executable map for NFSv3 shares from Host B. Th=
at=20
> one works as intended. However=E2=80=A6
>=20
> fs.nfs:
> /mnt/bar -fstype=3Dnfs4,rw,soft,async,_netdev,rsize=3D8192,wsize=3D81=
92=20
> 192.168.1.144:bar
> (on one line)
>=20
> =E2=80=A6 fails. Instead, the folder is still created, but accessing =
it yields=20
> "No such file or directory".
>=20
> Meanwhile automount prints a nonsensical =E2=80=A6
>=20
> "validate_location: expected colon delimeter not found in location=20
> 192.168.1.144:bar"
>=20
> =E2=80=A6 which from an error path (with a typo) in parse_sun.c's=20
> validate_location that was added in autofs 5.0.6.
>=20
> Maybe the person who added it missed that unlike mount requests for=20
> NFSv3 shares, NFSv4 ones need not (depending on the server, must not)=
=20
> have a "/" after the ":"?

It is surprising that I'm not aware of this "convention" since a simple
search turns up results from quite a few years past.

Unfortunately there are a number of other places where this will cause
problems and some won't be at all straight forward to change.

Ian

