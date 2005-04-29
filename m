From: Axel Thimm <Axel.Thimm@atrpms.net>
Subject: memory leak in autofs-4.1.3-114 on FC3/i386?
Date: Fri, 29 Apr 2005 03:20:54 +0200
Message-ID: <20050429012054.GA17598@neu.nirvana>
Reply-To: autofs@linux.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1427206832=="
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org


--===============1427206832==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

an updated FC3/i386 box with mail server functionality accesses
O(1000) accounts over NFS (NFS server is a dated Tru64 Unixcluster).

The automount process consumes memory until we have to kill it, or the
machine starts oom-killing us. Here is a graph:

	http://www.physik.fu-berlin.de/~dreger/memusage.png

(We have also seen bad behaviour of rpc.idmapd in the past, and 200MB
looks a bit too much for mapping 1000 accounts)

As a side note: Even though there are only 1000 accounts on this
system, mounts are attempted on each forged incoming address,
e.g. there is a multitude of failing mount requests, perhaps that's
causing the large rpc.idmapd process space and automount's memory
consumption?

Anything else we can provide for debugging? Thanks.
--=20
Axel.Thimm at ATrpms.net

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCcYv0QBVS1GOamfERAjhHAJ43pwd+VAVcwW3MJ0BMV0C8q3VOugCfRAIQ
sxdayspo4kNrzWwVSQ+W3fc=
=VcEh
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--


--===============1427206832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============1427206832==--

