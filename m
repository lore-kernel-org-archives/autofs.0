From: Ian Kent <raven@themaw.net>
Subject: [ANNOUNCE] autofs 5.1.2 release
Date: Wed, 15 Jun 2016 11:15:37 +0800
Message-ID: <1465960537.3164.1.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=KCg
	NIAl73ENEhx9TEJV7w+VpxBo=; b=osH3kkNxPRx2Dw+YWRiIKFXa+5izrSYPz9Y
	QCMiQCDc3VLlonAfPKejqBXjcVhygAZ9NxdWCcqPTDajBcHt4BmXemTAse8r1vzS
	1E1pFYpWhqREqRdPkqohMmYRbpMW/djp/8lwzctly1e9RkLqCUgPnXXgXczLU6zk
	5kAb2Ylg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=KCgNIAl73ENEhx9TEJV7w+VpxBo=; b=s+ch9
	Fpgqo6tgbrW+dDRP/TZLJH3hjZc5b28zyde0CUnQhAfoE/BRkWjEM85qpGXng4Qh
	+J4dTK7JbcbucvJ33JyfHe+PSltKDmufl1cXNGJEbYiPkhZ4Z3Wcr3PtSTmcKvXg
	VSbsQOMv2n0R/iNd9ByY1TQqmAXR0ZFI3Ycj4Y=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

Hi all,

An update is overdue so here it is.

It's mostly a bug fix update.

autofs
======

The package can be found at:

ftp://ftp.kernel.org/pub/linux/daemons/autofs/v5

It is autofs-5.1.2.tar.[gz|xz]

No source rpm is there as it can be produced by using:

rpmbuild -ts autofs-5.1.2.tar.gz

and the binary rpm by using:

rpmbuild -tb autofs-5.1.2.tar.gz

See the README.amd-maps file for information about using amd format
maps.

Here are the entries from the CHANGELOG which outline the updates:

15/06/2015 autofs-5.1.2
=======================
- update libtirpc workaround for new soname.
- revert fix libtirpc name clash.
- fix left mount count return from umount_multi_triggers().
- fix return handling in sss lookup module.
- move query dn calculation from do_bind() to do_connect().
- make do_connect() return a status.
- make connect_to_server() return a status.
- make find_dc_server() return a status.
- make find_server() return a status.
- fix return handling of do_reconnect() in ldap module.
- fix rwlock unlock crash.
- fix config old name lookup.
- fix error handling on ldap bind fail.
- fix direct mount stale instance flag reset.
- fix direct map expire not set for initail empty map.
- fix missing source sss in multi map lookup.
- fix update_hosts_mounts() return.
- change lookup to use reinit instead of reopen.
- update map_hash_table_size description.
- add configuration option to use fqdn in mounts.
- fix out of order call in program map lookup.
- fix error handling of is_mounted().
- Add a mode option for master map entries.
- define monotonic clock helper functions.
- use monotonic clock for alarm thread condition wait.
- define pending condition init helper function.
- use monotonic clock for direct mount condition.
- use monotonic clock for indirect mount condition.
- change remaining gettimeofday() to use clock_gettime().
- change time() to use monotonic_clock().
- remove unused function elapsed().
- fix unbind sasl external mech.
- fix sasl connection concurrancy problem.
- fix memory leak in nisplus lookup_reinit().
- fix memory leak in ldap do_init().
- fix use after free in sun parser parse_init().
- fix use after free in open_lookup().
- fix typo in autofs_sasl_bind().
- fix memory leak in get_network_proximity().
- fix use after free in match_my_name().
- improve scalability of direct mount path component.
- always set direct mounts catatonic at exit.
- fix use-after-free in st_queue_handler().
- log pipe read errors.
- fix handle_mounts() termination condition check.
- fix Makefile linking dependencies.
- fix modules make clean target.
- fix autofs(5) description of supported map sources.
- add autofs(5) note of IPv6 libtirpc requirement.
- add remote-fs.target systemd dependency.
- fix typo in autofs.conf.
- fix yp map age not updated during map lookup.
- add config option to supress not found log message.
- fix possible memory leak in nfs mount.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
