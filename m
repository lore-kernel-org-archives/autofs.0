From: Rainer Krienke <krienke@uni-koblenz.de>
Subject: Re: Looking for infor on executable map format
Date: Mon, 29 Mar 2004 09:00:23 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200403290900.23350.krienke@uni-koblenz.de>
References: <200403261040.08085.krienke@uni-koblenz.de>
	<200403290829.43397.krienke@uni-koblenz.de>
	<Pine.LNX.4.58.0403291450290.18783@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============072241677167466989=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0403291450290.18783@wombat.indigo.net.au>
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
Cc: autofs@linux.kernel.org, Jim Carter <jimc@krienke.org>


--===============072241677167466989==
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_Hm8ZACCZLXGMotS";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit


--Boundary-02=_Hm8ZACCZLXGMotS
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Montag, 29. M=E4rz 2004 08:54, Ian Kent wrote:
> On Mon, 29 Mar 2004, Rainer Krienke wrote:
> > Where did you find the information that the format should be like a
> > filemap without the key? I searched the manuals but the only information
> > I was able to find, was that an executable map has to echo a "map" to
> > stdout. A map would have been the key, then optinal options as well as
> > the
> > server:/filesystem entry. But exactly this does not work. So you are
> > probably right that one should omit the key but its not documented as f=
ar
> > as I can see.
>
> Looking at the auto.net script in the distribution you see immediately it
> receives a single parameter, the key. Using that it is expected to return
> the map entry corresponding to that key. Excecuting auto.net with a
> host name that has exports, for example, shows what the autofs lookup
> module is expecting back.
>
> Ian

This outputs eg something like=20

=2Dfstype=3Dnfs,hard,intr,nodev,nosuid,nonstrict,rsize=3D8192,wsize=3D8192 \
        /export/user serverhost:/export/user=20
	.....

So there are options, a qouted newline and then the map entry without the k=
ey.=20
=46ine. Would be nice if this information could be integrated into the man=
=20
pages as well. However what about my --bind paramter (alltough it turned ou=
t=20
that I probably do not need it)? Could it be given in the first line, i.e=20
does autofs treat the first line somwhat different to allow options like=20

=2D-bind  -fstype=3Dnfs,hard,intr,nodev,nosuid,nonstrict,rsize=3D8192,wsize=
=3D8192

or does this lead to problems like Jim Carter supposed?

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

--Boundary-02=_Hm8ZACCZLXGMotS
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBAZ8mHaldtjc/KDEoRAtrlAKCj2xD57c5tICT4CikVjifB9rHkuwCg9boL
pFSp5MYzdlBy5fPPLzk3n4o=
=mj+K
-----END PGP SIGNATURE-----

--Boundary-02=_Hm8ZACCZLXGMotS--


--===============072241677167466989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============072241677167466989==--

