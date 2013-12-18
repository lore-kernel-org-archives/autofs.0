From: fedfs-utils Release Announcements <fedfs-utils-announce-N0ozoZBvEnrZJqsBc5GL+g@public.gmane.org>
Subject: Announcing the release of fedfs-utils 0.9.5
Date: Wed, 18 Dec 2013 11:39:05 -0500
Message-ID: <9313DE4F-10AB-43C0-AFD2-01F6DB904A20@oracle.com>
Reply-To: fedfs-utils Release Announcements
	<fedfs-utils-announce-N0ozoZBvEnrZJqsBc5GL+g@public.gmane.org>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/mixed; boundary="===============7167449291282199349=="
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
Cc: Linux NFS Mailing List <linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "autofs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <autofs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "samba-technical-w/Ol4Ecudpl8XjKLYN78aQ@public.gmane.org" <samba-technical-w/Ol4Ecudpl8XjKLYN78aQ@public.gmane.org>


--===============7167449291282199349==
Content-Type: multipart/signed;
	boundary="Apple-Mail=_DAFCB1C3-738F-4FE0-A5F2-0E54924E300B";
	protocol="application/pgp-signature"; micalg=pgp-sha512


--Apple-Mail=_DAFCB1C3-738F-4FE0-A5F2-0E54924E300B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

This package contains an implementation of the Federated Filesystem =
(FedFS) Proposed Standard for Linux.  For an introduction to FedFS, see =
RFC 5716.

This is an ALPHA quality release.  The code in this release is not =
guaranteed to work.  Programming, administrative, and user interfaces =
may change significantly before the next release.  This release is for =
technology preview only.

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

Project web site
http://wiki.linux-nfs.org/wiki/index.php/FedFsUtilsProject

Installation guide:
http://wiki.linux-nfs.org/wiki/index.php/FedFsInstallationGuide0.9

Tarball releases:
http://git.linux-nfs.org/?p=3Dcel/fedfs-releases.git;a=3Dsummary

Git repository:
=
http://git.linux-nfs.org/?p=3Dcel/fedfs-utils.git;a=3Dshortlog;h=3Drefs/he=
ads/0.9-stable

Patchwork:
http://patchwork.ozlabs.org/project/fedfs-utils/list/

--=20
Chuck Lever
chuck[dot]lever[at]oracle[dot]com


--Apple-Mail=_DAFCB1C3-738F-4FE0-A5F2-0E54924E300B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIcBAEBCgAGBQJSsc+xAAoJEKtSGoIDWtn6Y/QP/R5WLpOiFl+sQpEjhPhE94Ho
pc6i1mQI1HbhjfqYaNkjolofI5AJxhwp+KIURwD41aFg8JzC0N+cIr6dItUgX1AW
OOrOeOss7RQ+wSuFpd4A2mQA131zDmE3QAmWLQ7GTCsq+a7HVNElZx/E+uqMwRSU
79Xdje7Ow3Oo+MMWCJcgPFZ5ahI75dFlevTl1gxlhQ+mDh2s8TmMdrwBehKIPCZH
+fOzSokG7Jn7TRk1KzabEJEUBY9vTUKJYt4oSDHdys6Ozs0gmapuAub1Yyfv+Rpz
dgD1I9T9ZeAC381hkArvWOLuusvBZBWvwz7YsmVOOY5dJ9V2HCNSGJiwimw3wmPs
p38lnsVaBPFYv60jITPl0fVmiwIH7qQb39Sawm6sW8LJ2R861/sReqw3GOfsoY9B
Ig4R/Ay3fBO0RQiim6AA3LOOiAIZ4uzz0sNNMmauo2N9Rkk7yBh1Te+njEK3pxkt
Dh0cGYHwaqSX+Q73L9clXLpCqu/cYenRks0YfahlBPcfL4S33+9tRONzPYbq7Dir
YYxwl+834oVFRaPCjvi3vMexS9lZa2iD0U1OKHoOJfuwyTVYzGF5HqW78e0bVvV5
3yIs3oKfcx3rzQ3Fd6+UPXIt6g0xM1z9QeywpE7hAotbF9b6TqJQPw2FwDyKKeEf
QKCD6WUpyJBQELR2VjJB
=gEm9
-----END PGP SIGNATURE-----

--Apple-Mail=_DAFCB1C3-738F-4FE0-A5F2-0E54924E300B--


--===============7167449291282199349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
fedfs-utils-announce mailing list
fedfs-utils-announce-N0ozoZBvEnrZJqsBc5GL+g@public.gmane.org
https://oss.oracle.com/mailman/listinfo/fedfs-utils-announce
--===============7167449291282199349==--

