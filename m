From: Jeff Mahoney <jeffm@suse.com>
Subject: [BUG] contained_in_local_fs will *always* return true
Date: Fri, 18 Mar 2016 16:44:07 -0400
Message-ID: <56EC6897.7040409@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="LnLeULDECsUQ05d9P4p1NGvhoBdQM1iaD"
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: autofs@vger.kernel.org
Cc: Ian Kent <raven@themaw.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LnLeULDECsUQ05d9P4p1NGvhoBdQM1iaD
Content-Type: multipart/mixed; boundary="XuvwtdjjIUMQQ9HFLQuw2fKtTaTeNvNv6"
From: Jeff Mahoney <jeffm@suse.com>
To: autofs@vger.kernel.org
Cc: Ian Kent <raven@themaw.net>
Message-ID: <56EC6897.7040409@suse.com>
Subject: [BUG] contained_in_local_fs will *always* return true

--XuvwtdjjIUMQQ9HFLQuw2fKtTaTeNvNv6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi autofs maintainers -

I'm investigating a bug in which the user has > 8k direct mounts set up.
 As documented in the README, this performs very, very badly and I'm
looking at ways to improve that situation.

In my research, I discovered commit d3ce65e05d1 (autofs-5.0.3 - allow
directory create on NFS root), which was intended to return true for
rootfs.  It would pass that test.  It also returns true for every other
case as long as there is *any* root file system in the mount table.  So,
ultimately, we read the mount table for every path component of every
direct mount for no benefit whatsoever.

=3D=3D=3D=3D8<=3D=3D=3D=3D
for (this =3D mnts; this !=3D NULL; this =3D this->next) {
        size_t len =3D strlen(this->path);

        if (!strncmp(path, this->path, len)) {
                if (len > 1 && pathlen > len && path[len] !=3D '/')
                        continue;
                else if (len =3D=3D 1 && this->path[0] =3D=3D '/') {

			/*
			 * jeffm -> This will cause the entire
			 * function to always return true.  It
			 * turns the loop into a test to see if
			 * anything is mounted on /.
			 */

                        /*
                         * always return true on rootfs, we don't
                         * want to break diskless clients.
                         */
                        ret =3D 1;
                } else if (this->fs_name[0] =3D=3D '/') {
                        if (strlen(this->fs_name) > 1) {
                                if (this->fs_name[1] !=3D '/')
                                        ret =3D 1;
                        } else
                                ret =3D 1;
                } else if (!strncmp("LABEL=3D", this->fs_name, 6) ||
                           !strncmp("UUID=3D", this->fs_name, 5))
                        ret =3D 1;
                break;
        }
}
=3D=3D=3D=3D>8=3D=3D=3D=3D

This commit landed in 2008 and, since it hasn't changed since then, I
assume there haven't been any bugs reported.  I had trouble trying to
locate a mailing list archive for the autofs list, so I can't confirm
that.  Googling for contained_in_local_fs really only showed the thread
that proposed the patch initially.

So, I suppose my question is this:  Since this bug has existed for
nearly 8 years already, would fixing it at this point be considered a
regression?

If so, we can skip all the checking in do_mkdir entirely, which also
removes the performance impact of large numbers of direct mounts while
using /proc/self/mounts.

If not, how do we move forward ensuring minimal breakage?  I have a
patch worked up that skips the mount table parsing entirely and just
tests to see if the parent is either on the root file system, regardless
of file system type, or contained in a file system mounted on a block
device (grab st_dev and see if it exists in /sys/dev/block).  Is that
enough or is there a corner case I'm missing?

Thanks,

-Jeff

--=20
Jeff Mahoney
SUSE Labs


--XuvwtdjjIUMQQ9HFLQuw2fKtTaTeNvNv6--

--LnLeULDECsUQ05d9P4p1NGvhoBdQM1iaD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.19 (Darwin)
Comment: GPGTools - http://gpgtools.org

iQIcBAEBAgAGBQJW7GidAAoJEB57S2MheeWy6t4P/RelJNI2J5o3xieIw4RfUjAF
2yHh30GEIgua5MTzhZGbvXcAAvmqUZuvGgeAV9XPCelfX2TYIpamNstW9BtH1gbl
Bd5G7isEWxIpwtZOY/nVwIRQD0cq8qtIV888+8Au71AxR0eTgAq0UoB2os0/1q66
0GPaFEOc5ukmgEHz2I/FbmeOVhHLWdBQZTAJn409IzJ3BSTT+gqUimr3+aWB9R0T
iGFn9Myxuw1i+ZipFIGFinhBI3BXk7tK3aPEsnRus2J93gtiC7XuH3igcu6unqs/
eaI0cHDGZ4K+WuiuAn5NnWkADVeIMEVqS2QHK4CyAl+askFLO/XTG6YqLcShjyB2
5FngTM7CYzsn0vyzXEDKqc/CpYa00iV2aP2lJRBY9koxLRHwiRQMJK1Me6V5p30j
eLN9dV/R49kbQt/YY3LrnI3u1U7haavd96IyH6ErQYPXeirfFPJv0eonRDAGWxL1
Xy3k4enAxqdezM5LAB0df+9UuBLlnmQU9fKYBf+NIBfpvEMDiSlnR7Bk2zab1YHn
+PzXkFE6zCUo0Qax1ds1kYFDiRvg/WNhcAHZs0AbPeSl5WXrPMK0sXDGH2pH7S5b
Wyg0wbq+XDgHbQkj++B0UZ57fBM9JwXjHlWSvvReae+DV8OAnOqC7mzaZXxt7NUk
G82oPNDJzk9K1RUMmyos
=uMC4
-----END PGP SIGNATURE-----

--LnLeULDECsUQ05d9P4p1NGvhoBdQM1iaD--
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
