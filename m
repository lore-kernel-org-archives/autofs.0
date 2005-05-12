From: Ian Kent <raven@themaw.net>
Subject: Re: autofs and dollar sign in hidden NT volumes
Date: Thu, 12 May 2005 10:05:37 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0505121004290.2818@wombat.indigo.net.au>
References: <428233B9.8080401@riu.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <428233B9.8080401@riu.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
To: =?ISO-8859-1?Q?Xisco_Fern=E1ndez?= <fjfernandez@riu.com>
Cc: autofs@linux.kernel.org

On Wed, 11 May 2005, [ISO-8859-1] Xisco Fern=E1ndez wrote:

> Hello list,
>=20
> I'm having some sort of problem w/ automount. I'm trying to automount
> hidden windows volumes (volume$), but the dollar sign isn't being
> recognized by autofs.
>=20
> I am able to mount that share manually with mount.smbfs.
> I am able to mount other non hidden shares with automount.
>=20
> It's not a credentials problem:
>=20
> auto.master:
>=20
> /mnt/auto       /etc/auto.sgil --timeout=3D2
>=20
> auto.sgil:
>=20
> cdrom -fstype=3Diso9660,ro,nosuid,nodev :/dev/cdrom
> sgil  -fstype=3Dsmbfs,username=3Druben,password=3Dtosidad,codepage=3Dcp=
850=20
> ://192.168.2.57/SGIL$

Have you tried escaping the $?
It has special meaning to autofs.

Ian
