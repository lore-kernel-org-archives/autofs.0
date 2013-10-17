From: Ian Kent <raven@themaw.net>
Subject: [ANNOUNCE] autofs 5.0.8 release
Date: Thu, 17 Oct 2013 16:00:54 +0800
Message-ID: <1381996854.2861.2.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:content-type:mime-version
	:content-transfer-encoding; s=mesmtp; bh=s35uPhaIsb4Idhpcy3QwycK
	kogo=; b=y2edej+eYI5y8Qs6NJ5cD0mknp8mRI8jm65ME4CmXsF3jzhYD2/d51m
	ZkmiHPldgIRtgPVO8UlrNN35pJKOXUOwpoZGIM71Vz8Rt/dUlE1TUw7zdVqzRR1/
	TxKBbCHkl+qE4+Whs2WwAQtABsUdMLbn74oP17qiH/le4N+OE8kU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:content-type:mime-version:content-transfer-encoding; s=smtpout;
	 bh=s35uPhaIsb4Idhpcy3QwycKkogo=; b=JeicQJOEvydaFOUyH/b/f8AcUIPk
	snDCJgzkPvv+ljEvK5UdSHM3HeK+jUjkf0myb1oOlg9fehFm6zhBstx4bj6UnoNO
	tt+2CtapiNI7+QdK+odrH7w86geSk+EfGyh7sCnGTfmXk+VhBmnL/P5s1srSaM/3
	xjhG0W7qBMzElgU=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

Hi all,

Once again this is long overdue so there are many changes.

The kernel patches are not being updated any more because of the
introduction of the vfs-automount changes to the VFS. If there
are needs in this area we will need to discuss how to deal with
them on the mailing list.

Known issues (haven't changed since 5.0.7, still)
================================================

- Quoted strings in the master map are still not yet handled.
- When the active restart is being used it will happily re-connect a
  mount that is unresponsive, perhaps because the server is not
  responding. A forced expire (USR1 signal) should be enough to clean
  up.

autofs
======

The package can be found at:

ftp://ftp.kernel.org/pub/linux/daemons/autofs/v5

It is autofs-5.0.8.tar.[gz|bz2|xz]

No source rpm is there as it can be produced by using:

rpmbuild -ts autofs-5.0.8.tar.gz

and the binary rpm by using:

rpmbuild -tb autofs-5.0.8.tar.gz

See the INSTALL file for information about configure options and
kernel requirements.

Here are the entries from the CHANGELOG which outline the updates:

17/10/2013 autofs-5.0.8
=======================
- fix nobind sun escaped map entries.
- fix use cache entry after free in lookup_prune_one_cache().
- fix ipv6 proximity calculation.
- fix parse buffer initialization.
- fix typo in automount(8).
- dont wait forever to restart.
- add timeout option description to man page.
- fix null map entry order handling.
- make description of default MOUNT_WAIT setting clear.
- configure.in: allow cross compilation.
- README: update mailing list subscription info.
- allow non root user to check status.
- fix recursive mount deadlock.
- increase file map read buffer size.
- handle new location of systemd.
- fix map entry duplicate offset detection.
- Allow nsswitch.conf to not contain "automount:" lines.
- fix nobind man page description.
- fix submount offset delete.
- fix init script status return.
- fix use get_proximity() without libtirpc.
- don't use dirent d_type to filter out files in scandir()
- don't schedule new alarms after readmap.
- use numeric protocol ids instead of protoent structs.
- lib/defaults.c: use WITH_LDAP conditional around LDAP types.
- make yellow pages support optional.
- modules/replicated.c: use sin6_addr.s6_addr32.
- workaround missing GNU versionsort extension.
- dont fail on master map self include.
- fix wildcard multi map regression.
- fix file descriptor leak when reloading the daemon.
- depricate nosymlink pseudo option.
- add symlink pseudo option.
- fix requires in spec file.
- fix libtirpc build option to require libtirpc-devel if needed.
- fix systemd unidir in spec file.
- document browse option in man page.
- fix some automount(8) typos.
- syncronize handle_mounts() shutdown.
- fix submount tree not all expiring.
- make dump maps check for duplicate indirect mounts.
- document allowed map sources in auto.master.
- add enable sloppy mount option to configure.
- fix interface address null check.
- dont probe rdma mounts.
- fix master map mount options matching.
- fix master map bogus keywork match.
- fix fix map entry duplicate offset detection.
- probe each nfs version in turn for singleton mounts.
- add changlog entry for coverity fixes.
- fix probe each nfs version in turn for singleton mounts.
- misc man page fixes.
- fix add null check in parse_server_string().
- don't override LDFLAGS in make rules.
- fix a couple of compiler warnings.
- add after sssd dependency to unit file.
- dont start readmap unless ready.
- fix crash due to thread unsafe use of libldap.
- fix compile error with heimdal support enabled.
- fix typo forced-shutdown should be force-shutdown.
- fix hesiod check error and use correct $(LIBS) setting.
- fix dead LDAP symbolic link when LDAP support is disabled.
- add missing libtirpc lib to mount_nfs.so when TIRPC enabled.
- use compiler determined by configure instead of hard-coded ones.
- remove hard-coded STRIP variable.
- use LIBS for link libraries.
- unbundle NOTSTRIP from DEBUG so they dont depend on each other.
- fix compilation of lookup_ldap.c without sasl.
- fix dumpmaps multi output.
- try and cleanup after dumpmaps.
- teach dumpmaps to output simple key value pairs.
- fix syncronize handle_mounts() shutdown.
- fix fix wildcard multi map regression.
- improve timeout option description.
- only probe specific nfs version if requested.
- fix bad mkdir permission on create.
- setup program map env from macro table.
- add short host name standard marco variable.
- fix get_nfs_info() probe.
- fix portmap lookup.
- add std vars to program map invocation.
- samples/auto.smb: add logic to obtain credentials.

Ian

