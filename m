From: Chuck Lever <chuck.lever-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Annoucing the release of fedfs-utils version 0.10.7
Date: Fri, 21 Apr 2017 17:52:51 -0400
Message-ID: <8ED2BC20-C168-4E9E-BE4F-9300EB9E9838@oracle.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Transfer-Encoding: 8bit
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: "fedfs-utils;release announcements" <fedfs-utils-announce-N0ozoZBvEnrZJqsBc5GL+g@public.gmane.org>
Cc: Linux NFS Mailing List <linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, autofs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, samba-technical-w/Ol4Ecudpl8XjKLYN78aQ@public.gmane.org

This package contains an implementation of the Federated Filesystem
(FedFS) Proposed Standard for Linux. For an introduction to FedFS, see
RFC 5716.

This is an ALPHA quality release.  The code in this release is not
guaranteed to work.  Programming, administrative, and user interfaces
may change significantly before the next release.  This release is for
technology preview only.


Changes since 0.10.6:
	• Fix compatibility issues with newer OpenSSL releases


Changes since 0.10.5:
	• Fix compatibility issues with newer glibc/libtirpc releases


Changes since 0.10.4:
	• More fixes in admin tools


Changes since 0.10.3:
	• Fix bugs in admin tools


Changes since 0.10.2:
	• More error handling fixes
	• Remove an incorrect package dependency


Changes since 0.10.1:
	• Fix bugs in nsdb-jumpstart
	• Numerous fixes to error handling paths
	• Introduce basic support for Coverity analysis


Changes since 0.10.0:
	• Address packaging issues


New with fedfs-utils 0.10.0:

Non-backwards compatible changes:
	• *ldaperr removed from libnsdb API
	• ADMIN client tools no longer use AUTH_NONE security
	• ADMIN client tools no longer exit with FedFS status code

New features:
	• Python package PyFedfs added
	• Tool for configuring FedFS domain root directories
	• Tool for setting up NSDBs using OpenLDAP
	• Simpler NCE discovery (compliant with new FedFS NCE I-D)
	• admin_t API for performing remote ADMIN requests
	• rpc.fedfsd uses an ACL to control who can perform ADMIN requests
	• rpc.fedfsd and ADMIN tools support RPCSEC and Kerberos v5

Minor fixes:
	• FEDFS_LOOKUP_JUNCTION no longer returns NSDB_LDAP_VAL
	• fedfs-map-nfs4 handles multiple SRV records
	• Packaging simplifications
	• Dozens of code clean-ups and bug fixes; consult Changelog for details


Source code available at:
http://git.linux-nfs.org/?p=cel/fedfs-utils.git

The new head of the master branch is commit:

6f356f7badec Release 0.10.7

Patchwork available at:
http://patchwork.ozlabs.org/project/fedfs-utils/list/

Tarball releases available at:
http://git.linux-nfs.org/?p=cel/fedfs-releases.git;a=summary

--
Chuck Lever



--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
