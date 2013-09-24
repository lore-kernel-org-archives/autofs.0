From: fedfs-utils Release Announcements <fedfs-utils-announce-N0ozoZBvEnrZJqsBc5GL+g@public.gmane.org>
Subject: fedfs-utils 0.9.3 packaged in Fedora
Date: Tue, 24 Sep 2013 09:00:00 -0400
Message-ID: <B94A9B58-EA2D-4566-A3B5-EAC15F428E9A@oracle.com>
Reply-To: fedfs-utils Release Announcements
	<fedfs-utils-announce-N0ozoZBvEnrZJqsBc5GL+g@public.gmane.org>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
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

The latest upstream release of fedfs-utils (0.9.3) is now available in Fedo=
ra 18, 19, 20, and rawhide.  This update replaces the previous version of t=
he package (0.9.2).

The fedfs-utils package contains an implementation of the Federated Filesys=
tem (FedFS) Proposed Standard for Linux.  For an introduction to FedFS, see=
 RFC 5716.

This is an ALPHA quality release.  The code in this release is not guarante=
ed to work. Programming, administrative, and user interfaces may change sig=
nificantly before the next release.  This release is for technology preview=
 only.

Changes since 0.9.2:
	=95 Allow fedfs-utils to build on systems that do not have liburiparser

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

Tarball releases available at
http://git.linux-nfs.org/?p=3Dcel/fedfs-releases.git;a=3Dsummary

Git repository available at
http://git.linux-nfs.org/?p=3Dcel/fedfs-utils.git;a=3Dshortlog;h=3Drefs/hea=
ds/0.9-stable

Patchwork available at
http://patchwork.ozlabs.org/project/fedfs-utils/list/
