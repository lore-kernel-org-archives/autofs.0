From: Rainer Krienke <krienke@uni-koblenz.de>
Subject: Re: Looking for infor on executable map format
Date: Mon, 29 Mar 2004 16:19:55 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200403291619.55686.krienke@uni-koblenz.de>
References: <200403261040.08085.krienke@uni-koblenz.de>
	<200403290900.23350.krienke@uni-koblenz.de>
	<Pine.LNX.4.58.0403291822090.26549@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============77904595051334358=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0403291822090.26549@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org


--===============77904595051334358==
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_LCDaAw9YYHtNxhc";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit


--Boundary-02=_LCDaAw9YYHtNxhc
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Montag, 29. M=E4rz 2004 12:29, you wrote:
> On Mon, 29 Mar 2004, Rainer Krienke wrote:
> > This outputs eg something like
> >
> > -fstype=3Dnfs,hard,intr,nodev,nosuid,nonstrict,rsize=3D8192,wsize=3D819=
2 \
> >         /export/user serverhost:/export/user
> > 	.....
> >
> > So there are options, a qouted newline and then the map entry without t=
he
> > key. Fine. Would be nice if this information could be integrated into t=
he
> > man pages as well. However what about my --bind paramter (alltough it
> > turned out that I probably do not need it)? Could it be given in the
> > first line, i.e does autofs treat the first line somwhat different to
> > allow options like
>
> Point taken. Bug me if you don't see anything in the next release please.
>
> The code which handles the option parsing is a bit ugly so I'd have to
> have a look, as options are generally passed starting with a single "-".
> However the bind mount is always attempted first. Thinking about it I
> think the code does check for "--". But does it handle the space....
>

Just one more point. I just found that I misinterpreted your description fr=
om=20
above one more time in that I thought that an executable map has to issue t=
he=20
exact format that the net-map uses, which is a multiple mount map format. B=
y=20
experimenting I found that it does not have to be exactly such a multiple=20
mount map but any legal one. Just in case you should work through the=20
documentation .....

Thanks
Rainer

=2D-=20
=2D------------------------------------------------------------------------=
=2D-
Rainer Krienke, Universitaet Koblenz, Rechenzentrum, Raum A022
Universitaetsstrasse 1, 56070 Koblenz, Tel: +49 261287 -1312, Fax: -1001312
Mail: krienke@uni-koblenz.de, Web: http://www.uni-koblenz.de/~krienke
Get my public PGP key: http://www.uni-koblenz.de/~krienke/mypgp.html
=2D------------------------------------------------------------------------=
=2D-

--Boundary-02=_LCDaAw9YYHtNxhc
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBAaDCLaldtjc/KDEoRAhHoAJ0eDBUMLy/Q06LFUI2TcF7d+HhBUQCgvL24
F3hpYY56RDR8Yw9f0XCPf2o=
=DDrm
-----END PGP SIGNATURE-----

--Boundary-02=_LCDaAw9YYHtNxhc--


--===============77904595051334358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============77904595051334358==--

