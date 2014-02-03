From: fedfs-utils Release Announcements <fedfs-utils-announce-N0ozoZBvEnrZJqsBc5GL+g@public.gmane.org>
Subject: Announcing the release of fedfs-utils
	version 0.10.0
Date: Mon, 3 Feb 2014 12:34:35 -0500
Message-ID: <99CE2C34-8A84-4BE0-A03D-40DA4D7E9903@oracle.com>
Reply-To: fedfs-utils Release Announcements
	<fedfs-utils-announce-N0ozoZBvEnrZJqsBc5GL+g@public.gmane.org>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
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

This package contains an implementation of the Federated Filesystem (FedFS)=
 Proposed Standard for Linux.  For an introduction to FedFS, see RFC 5716.

This is an ALPHA quality release.  The code in this release is not guarante=
ed to work.  Programming, administrative, and user interfaces may change si=
gnificantly before the next release.  This release is for technology previe=
w only.

Non-backwards compatible changes:
	=95 *ldaperr removed from libnsdb API
	=95 ADMIN client tools no longer use AUTH_NONE security
	=95 ADMIN client tools no longer exit with FedFS status code

New features:
	=95 Python package PyFedfs added
	=95 Tool for configuring FedFS domain root directories
	=95 Tool for setting up NSDBs using OpenLDAP
	=95 Simpler NCE discovery (compliant with new FedFS NCE I-D)
	=95 admin_t API for performing remote ADMIN requests
	=95 rpc.fedfsd uses an ACL to control who can perform ADMIN requests
	=95 rpc.fedfsd and ADMIN tools support RPCSEC and Kerberos v5
    =

Minor fixes:
	=95 FEDFS_LOOKUP_JUNCTION no longer returns NSDB_LDAP_VAL
	=95 fedfs-map-nfs4 handles multiple SRV records
	=95 Packaging simplifications
	=95 Dozens of code clean-ups and bug fixes; consult Changelog for details


Going forward, stable patches now go into =93master,=94 rather than a separ=
ate branch.  Development for fedfs-utils 0.11 will be moved to a topic bran=
ch.

fedfs-utils 0.9 is packaged for EPEL 6 and will continue to see bug fixes.


Tarball releases available at:
  http://git.linux-nfs.org/?p=3Dcel/fedfs-releases.git;a=3Dsummary

Git repository available at:
  http://git.linux-nfs.org/?p=3Dcel/fedfs-utils.git;a=3Dshortlog;h=3Drefs/h=
eads/master

Patchwork available at:
  http://patchwork.ozlabs.org/project/fedfs-utils/list/

--
Chuck Lever
