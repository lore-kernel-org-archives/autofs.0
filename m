From: fedfs-utils Release Announcements <fedfs-utils-announce-N0ozoZBvEnrZJqsBc5GL+g@public.gmane.org>
Subject: [ANNOUNCE] Announcing the release of
	fedfs-utils 0.9.6
Date: Wed, 4 Jun 2014 10:48:25 -0400
Message-ID: <D15355AD-FF6D-40B5-92FA-43F7A1061F80@oracle.com>
Reply-To: fedfs-utils Release Announcements
	<fedfs-utils-announce-N0ozoZBvEnrZJqsBc5GL+g@public.gmane.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: multipart/mixed; boundary="===============8394447629490758216=="
Return-path: <fedfs-utils-announce-bounces-N0ozoZBvEnrZJqsBc5GL+g@public.gmane.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <https://oss.oracle.com/mailman/listinfo/fedfs-utils-announce>, 
	<mailto:fedfs-utils-announce-request-N0ozoZBvEnrZJqsBc5GL+g@public.gmane.org?subject=unsubscribe>
List-Archive: <http://oss.oracle.com/pipermail/fedfs-utils-announce>
List-Post: <mailto:fedfs-utils-announce-N0ozoZBvEnrZJqsBc5GL+g@public.gmane.org>
List-Help: <mailto:fedfs-utils-announce-request-N0ozoZBvEnrZJqsBc5GL+g@public.gmane.org?subject=help>
List-Subscribe: <https://oss.oracle.com/mailman/listinfo/fedfs-utils-announce>, 
	<mailto:fedfs-utils-announce-request-N0ozoZBvEnrZJqsBc5GL+g@public.gmane.org?subject=subscribe>
Sender: fedfs-utils-announce-bounces-N0ozoZBvEnrZJqsBc5GL+g@public.gmane.org
Errors-To: fedfs-utils-announce-bounces-N0ozoZBvEnrZJqsBc5GL+g@public.gmane.org
To: "fedfs-utils;release announcements" <fedfs-utils-announce-N0ozoZBvEnrZJqsBc5GL+g@public.gmane.org>
Cc: Linux NFS Mailing List <linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, autofs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, samba-technical-w/Ol4Ecudpl8XjKLYN78aQ@public.gmane.org


--===============8394447629490758216==
Content-Type: multipart/signed;
	boundary="Apple-Mail=_30B0B594-81C2-4703-9619-9982BD265C11";
	protocol="application/pgp-signature"; micalg=pgp-sha512


--Apple-Mail=_30B0B594-81C2-4703-9619-9982BD265C11
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

This package contains an implementation of the Federated Filesystem =
(FedFS) Proposed Standard for Linux. For an introduction to FedFS, see =
RFC 5716.

This is an ALPHA quality release.  The code in this release is not =
guaranteed to work.  Programming, administrative, and user interfaces =
may change significantly before the next release.  This release is for =
technology preview only.

Git repository:
git://git.linux-nfs.org/projects/cel/fedfs-utils.git 0.9-stable

The new head of the 0.9-stable branch is commit:

  f04774c5 Release 0.9.6


Changes since 0.9.5:   =20
	=95 Man page correction
	=95 Numerous fixes to error handling paths

Changes since 0.9.4:
	=95 Run rpcfedfsd.service after network.target is started
	=95 Use correct RPC result type in fedfs-get-limited-nsdb-params
	=95 SET_NSDB_PARAMS should not return NSDB_LDAP_VAL

Changes since 0.9.3:
	=95 Mount fails when domain has multiple SRV records
	=95 Fix a problem with build environment

Changes since 0.9.2:
	=95 Make the use of liburiparser optional

Changes since 0.9.1:
	=95 Packaging-related improvements

Changes since 0.9.0:
	=95 Address build issues with recent automake and libtools
	=95 Replace nl_langinfo(CODESET) check in command line tools

New with fedfs-utils 0.9.0:
	=95 NSDB schema complies with latest draft standard
	=95 DNS SRV support complies with RFC 6641
	=95 NSDB clients support the FEDFS_SEC_TLS security type
	=95 NSDB clients can follow LDAP referrals returned by NSDB =
nodes
	=95 New tools for configuration of NSDBs
	=95 New "display-junction" debugging command

Tarball releases:
git://git.linux-nfs.org/projects/cel/fedfs-releases.git

Project web site
http://wiki.linux-nfs.org/wiki/index.php/FedFsUtilsProject

Installation guide:
http://wiki.linux-nfs.org/wiki/index.php/FedFsInstallationGuide0.9

Patchwork:
http://patchwork.ozlabs.org/project/fedfs-utils/list/

--=20
Chuck Lever
chuck[dot]lever[at]oracle[dot]com


--Apple-Mail=_30B0B594-81C2-4703-9619-9982BD265C11
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIcBAEBCgAGBQJTjzHBAAoJEDNqszNvZn+Xm+0P/0SkE8sty+biFrS19h8zfl8E
ZdKrQtA18717tdamPUw7P6e1jUyCF3vmHXlJ0FUQ1RT7vxO7w5h6M8/b9BvfZpuw
GLUZuq0Sa/M5xqDoZcNtRAHUMq+2+VziuqaDC5Gryin1/wL2skZYlmhb1BdKWH4E
Op0FB/QW3TAbQoa/0XUGl913MqLysGWeK6gCDD2J+G9IUctSzM6qWhRengOoauDX
j44D+ep4jT4swN6y66SwfDDibeyU62a6hbYIDGaAy8XlCHSIwoIzG70JmWDcvsCK
V2i2xFjs4SHDB3AfLbLkawJbjjPgCV9iU/24mH/D/om9uks/iNrQp0Q1e0iu8l4Y
/PKp9DfGghMwB7MZydIrBbAOaSel4WhDQTy7dphc30drtXlE94QvejzX5/cJN0sj
/mBG+P/P7gyus100j537b57DJ+mLhKj88JqJQmv4Gy43RGxW9E5usfyrEzGL6T6A
dJvR3oo2Ki7mkJhfnd9CWKfOyy8I9sF+crBQyu64KJVfzXHTQTgP7Kor7uOs10xK
n6MKiJAuScJsMPzq9FHeY44sSgEqV8pL28IWn5E95BPX/Te3Y78y4jA5WTqfPAgd
r9OLlsSG/TaGTqRDIO96IMX8DlYZmB9FXOJoLEOaKFYt7auYiap5qFW3MxqHttSV
mQm5bdDyGENP1qvmTbeF
=Kchk
-----END PGP SIGNATURE-----

--Apple-Mail=_30B0B594-81C2-4703-9619-9982BD265C11--


--===============8394447629490758216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
fedfs-utils-announce mailing list
fedfs-utils-announce-N0ozoZBvEnrZJqsBc5GL+g@public.gmane.org
https://oss.oracle.com/mailman/listinfo/fedfs-utils-announce
--===============8394447629490758216==--

