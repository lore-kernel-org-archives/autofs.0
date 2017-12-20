From: NeilBrown <neilb@suse.com>
Subject: Re: [ANNOUNCE] autofs 5.1.2 release
Date: Wed, 20 Dec 2017 14:29:59 +1100
Message-ID: <876092krew.fsf@notabene.neil.brown.name>
References: <1465960537.3164.1.camel@themaw.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1465960537.3164.1.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi Ian,
 I've been looking at:

> - add configuration option to use fqdn in mounts.

(commit 9aeef772604) because using this new option causes a regression.
If you are using the "replicated server" functionality, then
  use_hostname_for_mounts =3D yes
completely disables it.

This is caused by:

diff --git a/modules/replicated.c b/modules/replicated.c
index 32860d5fe245..8437f5f3d5b2 100644
=2D-- a/modules/replicated.c
+++ b/modules/replicated.c
@@ -667,6 +667,12 @@ int prune_host_list(unsigned logopt, struct host **lis=
t,
        if (!*list)
                return 0;
=20
+       /* If we're using the host name then there's no point probing
+        * avialability and respose time.
+        */
+       if (defaults_use_hostname_for_mounts())
+               return 1;
+
        /* Use closest hosts to choose NFS version */

My question is: why what this particular change made.
Why can't prune_host_list() be allowed to do it's thing
when use_hostname_for_mounts is set.
I understand that it would be pointless choosing between
the different interfaces of a multi-homed host, but there is still value
in choosing between multiple distinct hosts.

What, if anything, might go wrong if I simply reverse this chunk of the
patch?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlo52TcACgkQOeye3VZi
gbmy+hAAjkS7qYBNwSVPYUGsr6qs5gqo3xqiMS6KWbiOd+bxZNHFOGHGeZn1Cr9f
Q2qV3YxjJ0sP9xpvo+mGTwIMH4k8F9WBU7Ds1INKSDb55eQl3mcP9wa3/anf9bUe
IaQut7K2t5jC5UB0npYOhy9pFR4DoNFdNRo9gi6rS64MNKRKRwNfobFMJIV/Dv7G
rF70IOVjSsEAqYEPV/GKCTW7Ueu+dSMDV1dC7M+XUXtQZnmZFzGBOCH/mv/XbQDC
QFi8+uXN4Bk2gOMGOtzny3YuiJc+iPQFRhOuGjhI3Yuv8pN3QqV98RclG8g1QaTh
nqbP+qa0i2sgXMZGyz4j6vN/ZTBgoGlrVzFFaP9IgAf7E7cYFtq/NsCcZQTqCu/P
1BdHyi6cQDA/mZNzBKOkkuHVus1cfHXOgTZKz4mzQHQnZxbHFFN++I95b3aMWwPl
Zf7G0q4JulwG5XsioChEjY/bpPHF5ZKmSAzGdglvsKJHWjFBB5rQR2fWsWukwU7/
/jeT75Re1S6lyQgrj6M3EbXqSKXEVOSgHpXS0N5Phe7fJIV9AiZmAFxu5LT9qi4b
Rubhydb1wuE/5PfBQLHmBkNjJAJbHHKEiBunRrtOWdjQymvljiPWBW8Q3VY4vjgx
oHQLNCW4PjiO7/r2Aoo3a3gxvZhrHXaXAZq02WZabGRrOInmW5A=
=SFy/
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
