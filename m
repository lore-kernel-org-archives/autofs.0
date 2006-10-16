From: "Brian J. Murrell" <brian@interlinx.bc.ca>
Subject: Re: automounted filesystems being unmounted and
	mounted	every minute
Date: Mon, 16 Oct 2006 13:26:13 -0400
Message-ID: <1161019573.3184.15.camel@pc.ilinx>
References: <1161005417.3184.5.camel@pc.ilinx>
	<1161016376.3085.86.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3542678627358731605=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1161016376.3085.86.camel@localhost>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org


--===============3542678627358731605==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Y4g3iSRD6fuhVid1Ss+B"


--=-Y4g3iSRD6fuhVid1Ss+B
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-17-10 at 00:32 +0800, Ian Kent wrote:
> On Mon, 2006-10-16 at 09:30 -0400, Brian J. Murrell wrote:
> > Autofs 5.0.1 seems to be doing an unmount/mount of my home dir
> > filesystems every minute or so.  Verbose output from autofs shows:
> >=20
> > Oct 16 09:27:23 jenny automount[18632]: expiring path /autohome/share
> > Oct 16 09:27:23 jenny automount[18632]: unmounting dir =3D /autohome/sh=
are
> > Oct 16 09:27:23 jenny automount[18632]: expired /autohome/share
> > Oct 16 09:27:23 jenny automount[18632]: expiring path /autohome/brian
> > Oct 16 09:27:23 jenny automount[18632]: unmounting dir =3D /autohome/br=
ian
> > Oct 16 09:27:23 jenny automount[18632]: expired /autohome/brian
> > Oct 16 09:27:24 jenny automount[18632]: attempting to mount entry /auto=
home/share
> > Oct 16 09:27:24 jenny automount[18632]: mount(nfs): mounted linux:/home=
/share on /autohome/share
> > Oct 16 09:27:24 jenny automount[18632]: mounted /autohome/share
> > Oct 16 09:27:24 jenny automount[18632]: mount still busy /autohome
> >=20
> > Why is it in the same window of operation expiring, unmounting and
> > remounting filesystems?
>=20
> Is the directory busy?
> That is is it the pwd of some process or have open files?

Don't think so:

$ sudo ls -l /proc/*/cwd | grep share
[nothing]

> If it's not then it will be umounted when it times out, after 1 minute
> in this case. Then if some smart application scans directory trees when
> it sees mount or umount activity then it will be mounted again. We've
> seen this with older versions of hald.

Heh.

> The best way to find out what is causing this is to enable debug logging

As in "automount -d"?

> on a test machine and check what pid is causing mount activity.

I tried this (automount -d) but am not seeing any more information than
-v provides.

b.

--=20
My other computer is your Microsoft Windows server.

Brian J. Murrell

--=-Y4g3iSRD6fuhVid1Ss+B
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFM8C1l3EQlGLyuXARAjanAJwLW3r5zeJXfAmRx7yx2yl2NwBocQCdHjra
hGboifAY3u3YAAv3smaNg4s=
=AhZm
-----END PGP SIGNATURE-----

--=-Y4g3iSRD6fuhVid1Ss+B--


--===============3542678627358731605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============3542678627358731605==--

