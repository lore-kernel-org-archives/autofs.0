From: Axel Thimm <Axel.Thimm@atrpms.net>
Subject: mount 2.12: proplist and failed mounts
Date: Fri, 25 Jun 2004 13:02:43 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040625110243.GH22003@neu.nirvana>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============81344550933193127=="
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org


--===============81344550933193127==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RMedoP2+Pr6Rq0N2"
Content-Disposition: inline


--RMedoP2+Pr6Rq0N2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I was happily using autofs 4.1.3 with mount 2.11y. The maps contained
the proplist option (we share the maps with some OSF1 boxes), but that
did not disturb.

for other reasons I had to upgrade mount to 2.11 (part of
util-linux). Suddenly autofs will not mount anymore with errors like:

Jun 25 12:25:50 heretic automount[12646]: failed to mount /home/thimm
Jun 25 12:25:50 heretic automount[12648]: >> Unsupported nfs mount option: =
proplist
Jun 25 12:25:50 heretic automount[12648]: mount(nfs): nfs: mount failure nu=
kleon:/amd/nukleon/1/home/ag-linke/thimm on /home/thimm

I tested mount -o proplist and I got the above error and the exit code was =
32:
# mount -o proplist nukleon:/amd/nukleon/1/home/ag-linke/thimm /home/thimm
Unsupported nfs mount option: proplist
# echo $?
32

OK, so I thought mount has become quite picky now, and downgraded. I
retried the manual mount and got the same error & exit code!

But autofs works properly again?!?

For one I'd like to understand how autofs manages to workaround this
error for 2.11y, and perhaps whether this can be used for mount 2.12,
also. Granted, the true error lies in the configuration asking for
unsupported proplist options, but since it had a nice and greceful
error fallback until now, it would be nice to keep it.

Thanks!
--=20
Axel.Thimm at ATrpms.net

--RMedoP2+Pr6Rq0N2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA3AZTQBVS1GOamfERAkySAJ92cWKoSBTxSMSfv9BXAcGQdt1HTACfR1ff
/5hhJOfqGFausxoW3TNmIsQ=
=GxrN
-----END PGP SIGNATURE-----

--RMedoP2+Pr6Rq0N2--


--===============81344550933193127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============81344550933193127==--

