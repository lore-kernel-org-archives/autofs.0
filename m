From: maximilian attems <janitor@sternwelten.at>
Subject: [Kernel-janitors] [patch] use list_for_each() in fs/autofs4/expire.c
Date: Wed, 10 Sep 2003 16:38:02 +0200
Sender: kernel-janitors-bounces@lists.osdl.org
Message-ID: <20030910143802.GJ24711@mail.sternwelten.at>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============022615011962984211=="
Return-path: <kernel-janitors-bounces@lists.osdl.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/kernel-janitors>,
	<mailto:kernel-janitors-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://localhost.localdomain/pipermail/kernel-janitors>
List-Post: <mailto:kernel-janitors@lists.osdl.org>
List-Help: <mailto:kernel-janitors-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/kernel-janitors>,
	<mailto:kernel-janitors-request@lists.osdl.org?subject=subscribe>
Errors-To: kernel-janitors-bounces@lists.osdl.org
To: kj <kernel-janitors@osdl.org>
Cc: autofs@linux.kernel.org, jeremy@goop.org


--===============022615011962984211==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1BdFSKqAqVdu8k/"
Content-Disposition: inline


--k1BdFSKqAqVdu8k/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Use list_for_each() where applicable
From: Domen Puncer <domen@coderock.org>
- for (list =3D ymf_devs.next; list !=3D &ymf_devs; list =3D list->next) {
+ list_for_each(list, &ymf_devs) {
pure cosmetic change, defined as a preprocessor macro in:
include/linux/list.h

please apply
maks


--- linux-2.6.0-test5/fs/autofs4/expire.c	Mon Sep  8 21:50:16 2003
+++ linux/fs/autofs4/expire.c	Wed Sep 10 12:13:24 2003
@@ -169,9 +169,7 @@
 	timeout =3D sbi->exp_timeout;
=20
 	spin_lock(&dcache_lock);
-	for(tmp =3D root->d_subdirs.next;
-	    tmp !=3D &root->d_subdirs;=20
-	    tmp =3D tmp->next) {
+	list_for_each(tmp, &root->d_subdirs) {
 		struct autofs_info *ino;
 		struct dentry *dentry =3D list_entry(tmp, struct dentry, d_child);
=20

--k1BdFSKqAqVdu8k/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/XzdK6//kSTNjoX0RAkSeAJ97lNBX6mUqzkU4bSu8mqi6gRNo1ACfb1En
lo4AanJKt7hJahsjSL0NM+w=
=v53g
-----END PGP SIGNATURE-----

--k1BdFSKqAqVdu8k/--

--===============022615011962984211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Kernel-janitors mailing list
Kernel-janitors@lists.osdl.org
http://lists.osdl.org/mailman/listinfo/kernel-janitors

--===============022615011962984211==--
