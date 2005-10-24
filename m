From: Rainer Krienke <krienke@uni-koblenz.de>
Subject: Re: Unable to mount with autofs-4.1.4: aquire_lock: can't
	lock lock file timed out: /var/lock/autofs
Date: Mon, 24 Oct 2005 12:59:27 +0200
Message-ID: <200510241259.31961.krienke@uni-koblenz.de>
References: <200510181321.08443.krienke@uni-koblenz.de>
	<Pine.LNX.4.63.0510231153350.19690@donald.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0602932724=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0510231153350.19690@donald.themaw.net>
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
To: Ian Kent <raven@themaw.net>, autofs mailing list <autofs@linux.kernel.org>

--===============0602932724==
Content-Type: multipart/signed; boundary="nextPart4104423.b7xt5LLEsj";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4104423.b7xt5LLEsj
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sonntag 23 Oktober 2005 06:00, you wrote:
> On Tue, 18 Oct 2005, Rainer Krienke wrote:
> > Hello,
> >
> > using the autofs package from suse10.0 (autofs-4.1.4-6.i586.rpm; autofs4
> > kernel module, Kernel2.6.13-15) NFS mounts of user directories fail when
> > using indirect mounts. The problem can be reproduced in a certrain setup
> > describes below. Because of this, the description is a bit lenghty.
>
> Here is a patch to add a configure option to disable locking when calling
> mount. It also adds a patch for mount that I hope will prevent mtab
> coruption. Obviousy autofs needs to be built with the option added to
> configure.
>

I tried the patch (compiled with --disable-mount-locking) on a opensuse10=20
client. For me it seems to work. I wrote a script that randomly selects use=
rs=20
from our NIS auto.home map and accesses the home directory. After a while I=
=20
had about 4000 mounts on the client (99.9% bind mounts of course) and nothi=
ng=20
went wrong as far as I saw. The most important thing for me is of course th=
at=20
using this patch my solution for hierarchcal mounts of the home directories=
=20
does work again.

Thanks and have a nice day
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

--nextPart4104423.b7xt5LLEsj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDXL6Taldtjc/KDEoRAircAJ9RyFt360+pdpM/G8kNDnMNWmcbjACaAxKf
F9GMTPGDDeJwOsTLbHfMI6M=
=qbhS
-----END PGP SIGNATURE-----

--nextPart4104423.b7xt5LLEsj--


--===============0602932724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============0602932724==--

