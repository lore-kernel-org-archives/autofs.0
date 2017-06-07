From: NeilBrown <neilb@suse.com>
Subject: [PATCH] autofs: sanity check status reported with AUTOFS_DEV_IOCTL_FAIL
Date: Wed, 07 Jun 2017 12:08:38 +1000
Message-ID: <871sqwczx5.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


If a positive status is passed with the AUTOFS_DEV_IOCTL_FAIL
ioctl, autofs4_d_automount() will return
   ERR_PTR(status)
with that status to follow_automount(), which will then
dereference an invalid pointer.

So treat a positive status the same as zero, and map
to ENOENT.

See comment in systemd src/core/automount.c::automount_send_ready().

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
 fs/autofs4/dev-ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index 734cbf8d9676..dd9f1bebb5a3 100644
=2D-- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -344,7 +344,7 @@ static int autofs_dev_ioctl_fail(struct file *fp,
 	int status;
=20
 	token =3D (autofs_wqt_t) param->fail.token;
=2D	status =3D param->fail.status ? param->fail.status : -ENOENT;
+	status =3D param->fail.status < 0 ? param->fail.status : -ENOENT;
 	return autofs4_wait_release(sbi, token, status);
 }
=20
=2D-=20
2.12.2


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlk3YCgACgkQOeye3VZi
gbkeBhAAobUhyASoRZSHqAAFSiyUk3qvglPQD/DnAVKQHatm87Kky6/JBZPy4ESr
KpjgrBY/CIJQ5RM3/8rH5CbKYgX8gP2upa7/OP1Hd1caW5pyYQot/8S5SpeBynkA
x0h9cH/mEVyG/cYlVhoGnjNJr7huFU7OffW2pgRqINYVUhPcskKFryjmfwRf9a3L
+aZIJi1cf/xTCVGBKdYGY7djsQIcgt7JE0xQegBiiNYzJuVK+ZJEpvZOm0hlXXc1
/CfaXLx/FS0sxTn4C+brQBIKaBVI1PkXd/iRbSkZRT1ym5TM8AXz9Svo7YlPjl8O
MmM4QT235ftB4hJUWUA5rjV1pm4Vu6cOfNamgllTjDmzGoejJGsF0L/OK5pHAa59
QMhSWTetQhO6XP2wbcLVIO87by86dAuDOz981Vzv5RMzQbu3AZcBQl4nzWbvoT9Y
3WOO5W/6I2Y3pWVqMcguYAJHtAXN3TERF6F8WS9mAiK6B6tVBBXvLOARBp5MInN1
EH2e7jhhqqoPwi4O5fMcyJVg9M+/qFpItd/i12yU4wbKl0jc+Gv2T1UH1Wp5NZL1
Y/tn2j9N+PQZzg5BxEY19gyXGBEtMnWD1PBfv6blYQ5T7fr7ueiDmY7pgrokMx/S
YNgdLaiK7LTBNI5okOVKTkQtMJSRWXq3D7eZcqRGGg02TOv/8Eg=
=Obeh
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
