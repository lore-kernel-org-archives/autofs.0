From: raven@themaw.net
Subject: Re: auto direct
Date: Wed, 21 Jul 2004 00:37:13 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0407210036180.1296@donald.themaw.net>
References: <200407162031.i6GKVHK32402@ns2.ypf.com.ar>
	<40FD34FF.9000408@enterasys.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40FD34FF.9000408@enterasys.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
To: "D. Bahi" <dbahi@enterasys.com>
Cc: autofs@linux.kernel.org

On Tue, 20 Jul 2004, D. Bahi wrote:

> well - to be helpful - direct mounts are supported if you have
> a non-root mount point (a mount point other than '/')
>=20
> /etc/auto.direct (works):
>=20
> /mount/auto  -options server:/path/to/mount/point
>=20
> but
>=20
> /etc/auto.direct (won't work):
>=20
> /mountauto  -options server:/path/to/mount/point
>

That's right and it is still a problem.

>=20
> Ian Kent wrote:
>=20
> > On Fri, 16 Jul 2004 EAGOMEZC@REPSOLYPF.COM wrote:
> >=20
> >=20
> >>Hi,=20
> >>
> >>i=B4ll need to setup direct maps in a linux box using a nis server on=
 Solaris 8.=20
> >>This option is not supported in autofs 4.
> >>
> >>I don=B4t know why is not supported, why ? is not implemented, or are=
 there any security tip ?=20
> >>
> >>Are there another way to mount direct maps ?
> >>
> >=20
> >=20
> > Your not entirely correct.
> >=20
> > Maybe you should investigate a bit before making these assumptions.
> >=20
> > Ian
> >=20
> >=20
> > _______________________________________________
> > autofs mailing list
> > autofs@linux.kernel.org
> > http://linux.kernel.org/mailman/listinfo/autofs
>=20
> --=20
> db
>=20
>=20
