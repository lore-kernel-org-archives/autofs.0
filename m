From: fedfs-utils Release Announcements <fedfs-utils-announce-N0ozoZBvEnrZJqsBc5GL+g@public.gmane.org>
Subject: Announcing the release of fedfs-utils 0.9.2
Date: Tue, 2 Jul 2013 15:13:20 -0400
Message-ID: <17AC10A6-EDB2-4FD0-A0DB-A14FFC2B2BFE@oracle.com>
Reply-To: fedfs-utils Release Announcements
	<fedfs-utils-announce-N0ozoZBvEnrZJqsBc5GL+g@public.gmane.org>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
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
Cc: Linux NFS Mailing List <linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "autofs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <autofs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "samba-technical-w/Ol4Ecudpl8XjKLYN78aQ@public.gmane.org" <samba-technical-w/Ol4Ecudpl8XjKLYN78aQ@public.gmane.org>

This package contains an implementation of the Federated Filesystem (FedFS)=
 Proposed Standard for Linux.  For an introduction to FedFS, see RFC 5716.

This is an ALPHA quality release.  The code in this release is not guarante=
ed to work.  Programming, administrative, and user interfaces may change si=
gnificantly before the next release.  This release is for technology previe=
w only.

Changes since 0.9.1:
	=95 Packaging-related improvements

Changes since 0.9.0:
	=95 Address build issues with recent automake and libtools
	=95 Replace nl_langinfo(CODESET) check in command line tools

New with fedfs-utils 0.9.0:
	=95 NSDB schema complies with latest draft standard
	=95 DNS SRV support complies with RFC 6641
	=95 NSDB clients support the FEDFS_SEC_TLS security type
	=95 NSDB clients can follow LDAP referrals returned by NSDB nodes
	=95 New tools for configuration of NSDBs
	=95 New "display-junction" debugging command

Project web site
http://wiki.linux-nfs.org/wiki/index.php/FedFsUtilsProject

Installation guide:
http://wiki.linux-nfs.org/wiki/index.php/FedFsInstallationGuide0.9

Tarball releases:
http://git.linux-nfs.org/?p=3Dcel/fedfs-releases.git;a=3Dsummary

Git repository:
http://git.linux-nfs.org/?p=3Dcel/fedfs-utils.git;a=3Dshortlog;h=3Drefs/hea=
ds/0.9-stable

Patchwork:
http://patchwork.ozlabs.org/project/fedfs-utils/list/

-- =

Chuck Lever
chuck[dot]lever[at]oracle[dot]com
