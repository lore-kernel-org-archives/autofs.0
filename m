From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] Autofs SMBFS no write in files
Date: Thu, 06 Jan 2011 22:04:53 +0800
Message-ID: <1294322693.2852.2.camel@perseus>
References: <alpine.LNX.2.00.1012122357570.9206@swampdragon.chaosbits.net>
	 <1292382195.2979.17.camel@perseus>
	 <alpine.LNX.2.00.1012171306310.4638@swampdragon.chaosbits.net>
	 <4D1A31B2.4000103@gmail.Com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding; s=smtpout; bh=+F/EqvBvpabXkTPL7Z1jdT0x/rI=; b=doUjcVGWPmafp6z7CU1Uw/aeDwiN9CHv+fgDkvBJereQ53MN8gm+q4OAvUwB4UCPQCSzysqUNrTf9fMBBeW84sdkyxHGEm6TvXk59u0HW+E23VHgjex0SDnHWz8xVrt0N5X4tr9Fh+hWu5Vh8d+cuShJp61jdrBstVa7Tsz/jcI=
In-Reply-To: <4D1A31B2.4000103@gmail.Com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Issa <frechdesign@gmail.com>
Cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2010-12-28 at 19:51 +0100, Issa wrote:
> Hello,
>=20
>=20
> Autofs acc=C3=A9s smbfs impossible d'=C3=A9crire sur le disque ?
> Autofs smbfs no writing ?

A bit off topic but is there some reason you need to use smbfs.
It's deprecated and I expect it will go away some time soon.
You should try using CIFS if you have a reasonably recent (or even not
so recent should be ok) kernel.

>=20
> Im usint autofs with ubuntu 10.10
> Im using autofs like this
>=20
>=20
> sudo nano /etc/auto.master
>=20
>=20
> +auto.master
> /mnt/smb       /etc/auto.auto   --timeout=3D60 --ghost
> et le fichier sudo nano /etc/auto.auto
>=20
>=20
> #directory name         option for mount                             =
                     device to mount
> win1            -fstype=3Dsmbfs,rw,credentials=3D/etc/smb.auth       =
  ://win1/docs/
> Authentication files :
> sudo nano /etc/smb.auth
>=20
>=20
> username=3Dusers1
> password=3DmotDePasse
> domain=3DwindowsDomaine
>=20
> now with this i can access only in read
> /mnt/smb/win1
>=20
> My question how add acess to write ?
>=20
>=20
> because i can write for the moment.
>=20
>=20
> thanks
>=20
>=20
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs

