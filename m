From: Chuck Lever <chuck.lever@oracle.com>
Subject: Annoucing the release of fedfs-utils version 0.10.6
Date: Mon, 25 Apr 2016 14:41:51 -0400
Message-ID: <BA325E78-BE55-455F-A22C-474360322C1D@oracle.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: "fedfs-utils;release announcements" <fedfs-utils-announce@oss.oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, samba-technical@lists.samba.org, autofs@vger.kernel.org

This package contains an implementation of the Federated Filesystem
(FedFS) Proposed Standard for Linux. For an introduction to FedFS, see
RFC 5716.

This is an ALPHA quality release.  The code in this release is not
guaranteed to work.  Programming, administrative, and user interfaces
may change significantly before the next release.  This release is for
technology preview only.


Changes since 0.10.5:
	=E2=80=A2 Fix compatibility issues with newer glibc/libtirpc releases


Changes since 0.10.4:
	=E2=80=A2 More fixes in admin tools


Changes since 0.10.3:
	=E2=80=A2 Fix bugs in admin tools


Changes since 0.10.2:
	=E2=80=A2 More error handling fixes
	=E2=80=A2 Remove an incorrect package dependency


Changes since 0.10.1:
	=E2=80=A2 Fix bugs in nsdb-jumpstart
	=E2=80=A2 Numerous fixes to error handling paths
	=E2=80=A2 Introduce basic support for Coverity analysis


Changes since 0.10.0:
	=E2=80=A2 Address packaging issues


New with fedfs-utils 0.10.0:

Non-backwards compatible changes:
	=E2=80=A2 *ldaperr removed from libnsdb API
	=E2=80=A2 ADMIN client tools no longer use AUTH_NONE security
	=E2=80=A2 ADMIN client tools no longer exit with FedFS status code

New features:
	=E2=80=A2 Python package PyFedfs added
	=E2=80=A2 Tool for configuring FedFS domain root directories
	=E2=80=A2 Tool for setting up NSDBs using OpenLDAP
	=E2=80=A2 Simpler NCE discovery (compliant with new FedFS NCE I-D)
	=E2=80=A2 admin_t API for performing remote ADMIN requests
	=E2=80=A2 rpc.fedfsd uses an ACL to control who can perform ADMIN requ=
ests
	=E2=80=A2 rpc.fedfsd and ADMIN tools support RPCSEC and Kerberos v5

Minor fixes:
	=E2=80=A2 FEDFS_LOOKUP_JUNCTION no longer returns NSDB_LDAP_VAL
	=E2=80=A2 fedfs-map-nfs4 handles multiple SRV records
	=E2=80=A2 Packaging simplifications
	=E2=80=A2 Dozens of code clean-ups and bug fixes; consult Changelog fo=
r details


Source code available at:
http://git.linux-nfs.org/?p=3Dcel/fedfs-utils.git

The new head of the master branch is commit:

448da0508a10 Release 0.10.6

Patchwork available at:
http://patchwork.ozlabs.org/project/fedfs-utils/list/

Tarball releases available at:
http://git.linux-nfs.org/?p=3Dcel/fedfs-releases.git;a=3Dsummary

--
Chuck Lever



--
To unsubscribe from this list: send the line "unsubscribe autofs" in
