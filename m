From: NeilBrown <neilb@suse.com>
Subject: [PATCH] autofs: clear O_NONBLOCK on the pipe.
Date: Mon, 11 Feb 2019 10:37:02 +1100
Message-ID: <871s4fi5b5.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


autofs does not expect the pipe it is given
to have O_NONBLOCK set - specifically if __kernel_write()
in autofs_write() returns -EAGAIN, this is treated
as a fatal error and the pipe is closed.

For safety autofs should, therefore, clear the O_NONBLOCK flag.

Releases of systemd prior to 8th February 2019 used
  pipe2(p, O_NONBLOCK|O_CLOEXEC)
and thus (inadvertently) set this flag.

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
 fs/autofs/autofs_i.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index 3e59f0ed777b..331192bed0d5 100644
=2D-- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -215,6 +215,8 @@ static inline int autofs_prepare_pipe(struct file *pipe)
 		return -EINVAL;
 	/* We want a packet pipe */
 	pipe->f_flags |=3D O_DIRECT;
+	/* We don't expect -EAGAIN */
+	pipe->f_flags &=3D ~O_NONBLOCK;
 	return 0;
 }
=20
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlxgtZ8ACgkQOeye3VZi
gbkKfxAAovzwzLeVTTLauw7I0IV/UMT4W3i6kGU0oz3My/MjneljT69J03n9049j
LS+nZ0NwUx3sRjbVzZaExcG1v3W//72laRRGrZaYReyezH2oC1FVaDNwbDzO7QcV
poElvVKtf8XGi5jRzY2hF+Olvhudfg4DqaTOBCBqiqwJBJoR7SLhOOzp6nC+coem
0bLn3p6igW6W7M5J4n44RdQ0R+ITvKd8B3iuWrlDEel8cl/OMDHwbqS1ndPYBYJ+
e+gsWgSBb63GT0wG6l8ZjolVA0piF+H3Gol97kWo5lSwZdSyd/Ti4vfymBsmhSyi
dcrpcZ1/ymiXSWkY3q2T72UJfRWA7Zq9scRn4e71Pz7tADQaRh1BTBQ4dq9YzyOO
dwWfvYxowOXDUYqU9OIGwR0ct+yuuz+XEvX1u/2Xk+s60PHmY6IWvRy1qDmPc3eN
GaoiQA36psC6u3WiCkjVvPoCV7JJhrSTiNetnbqavRf21yTNowt9wtHokRFsE3+o
JBQRTcFta4mSDO0NZcZy1JJOrv6b4xhvuHap18qjqpWKWARe92SvfE8C64a+b7HO
kkWGgnuwSs6ywKP/nzvTMKDzVaBslB0/xKHSIvr7SuUyD3ZWzxWptKofuEkpVBxi
B/27RMA508BfXFXbiMpy5nqPwFz7Wgg6IMwS3deF6NCPPQ5cJK4=
=gIWk
-----END PGP SIGNATURE-----
--=-=-=--
