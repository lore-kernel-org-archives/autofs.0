From: Ian Kent <raven@themaw.net>
Subject: [ANNOUNCE] autofs 5.1.3 release
Date: Fri, 26 May 2017 15:18:07 +0800
Message-ID: <1495783087.2574.1.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:message-id
        :mime-version:subject:to:x-me-sender:x-me-sender:x-sasl-enc
        :x-sasl-enc; s=fm1; bh=XHLDjaBz+ae2nKHBkTqftNX/q0c0dsnhkCan8/Ull
        3Q=; b=Qygweqhbf2qFaS/I0t6VuEYqqH/Es37DIjeXfS9KhSf3O7dYReXgjV0N+
        GSNMfLVLJrCDq6VYRiXU03/ZDqQCee5kW78Mo1iiOeg3ufQxj6zduWAQmrtl8Tro
        VTyNSB+cKr/cD28OaftwEQAwWmWnFUXQHytTOYdW2+upq+y2pXkhpHwqvCgMvyxC
        XfnNvV8ACGtw6v9UtakemrWOs4aKp3FJewiKJiHmd/z2jj54JjU2UlvyXU1n+Iac
        bdvRC4CZx3Avsq2VHSeaLRwjhowPptTDyzsc3CSb14TTfROnw7nje68nZPX2+Yod
        ZOBLm6aUTSc+zjD9t97Fwxxwvp5wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=XHLDjaBz+ae2nKHBkT
        qftNX/q0c0dsnhkCan8/Ull3Q=; b=afz7zOpqBsHE3QCbeOTD8M5BWXfV+qh73v
        Qtyrh5ejALr67BPXxY+hJu8s3Bqpqqg87FPgFsjJ+uXzc8tS+BaTVfHwUK/VXi/3
        /8Jr83t3+/jSavTl+VHo6xuIhDQW1vOb2Z9jYuS0V6RmS8KjmQ07bmTtKrPLp/oZ
        uGxLjQjj0aT/0f36R5WhLuYh/Yzv7nyxoswB/s+VgsH9rySbSc46UHPiFhuQrPmU
        28GiysLMddF5GOihQGyPncVDOcqkPHtI1V/jFgJjytX6fvRaqtE0eRKJkJ3X2Rk3
        k7epZ09K453fmZGg1edX2MQ2zWqU6PYAhzvm5E+oMXqyYlR1LjVQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: autofs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

Hi all,

It's time for a new release, autofs-5.1.3.

Of particular interest is the addition browse support for amd format
maps.

The browsable_dirs configuration option can be set to either "yes" or
"no" and the pseudo option "browsable" can be used as an option of
mount type "auto" mounts.

Note that the browsable_dirs "full" option and the mount type auto
"fullybrowsabe" option, mostly used for map debugging, cannot be
provided by autofs.

Related changes are the removal of the requirement to include entries
for amd format maps in the master map. The optional amd format map
 mount sections may be used without adding these entries, in the same
way these sections are used in the amd configuration.

This prevents the need to include potentially incompatible entries in
shared master maps in multi-vendor environments.

Something to watch out for is that autofs is no longer tolerant of
misconfigured nsswitch "automount:" entries. If nsswitch sources that
aren't configured are present it can lead to an unconditional 10
second delay at startup with some unexpected log errors. autofs is
probably not going to interfere with nsswitch.conf because it is not
the owner of the file so it needs to be set correctly by people using
autofs. This will often mean just removing the inappropriate "nisplus"
source present in the default installed nsswitch.conf. 

There's two added configuration parameters which hopefully will help
with map source availability problems at startup.

The "master_wait" configuration option (default 10 seconds) will retry
reading the master map for the configured time when certain errors are
encountered (the reason misconfigured nsswitch configurations cause a
delay).

And the option "sss_master_map_wait" (default 0, disabled) has been
added specifically for the sss source. This option may be needed
because the error returned when sss is not yet available to answer
queries can't be distinguished from a real "map does not exist" return.
The default of disabled is because the sss source not being ready
problem has already be resolved in recent versions of sss itself.

Additionally there a number of bug fixes and small improvements.

autofs
======

The package can be found at:
https://www.kernel.org/pub/linux/daemons/autofs/v5/

It is autofs-5.1.3.tar.[gz|xz]

No source rpm is there as it can be produced by using:

rpmbuild -ts autofs-5.1.3.tar.gz

and the binary rpm by using:

rpmbuild -tb autofs-5.1.3.tar.gz

See the README.amd-maps file for information about using amd format
maps.

Here are the entries from the CHANGELOG which outline the updates:

24/05/2016 autofs-5.1.3
=======================
- fix release date in CHANGELOG.
- build: check for clock_gettime in librt.
- fix compiler warning in try_remount().
- drop redundant \n in logerr().
- Fix size arg of fgets(3).
- fix libtirpc detection with -Wl,--as-needed.
- Fix a typo in CREDITS.
- Change .requestor to .requester for consistency.
- fix file map changed check.
- Remove unused local 2KB buffer.
- Fix typos in error messages.
- Fix fgets(3) size argument (another one).
- fix short memory allocation in lookup_amd_instance().
- fix count_mounts() function.
- configure: add cache variable for Linux proc filesystem check.
- Avoid local variable name shadowing another.
- fix typo in MOUNT_FLAG_GHOST comment.
- fix cachefs parse message not being logged.
- fix argc off by one in mount_autofs.c.
- fix _strncmp() usage.
- fix create_client() RPC client handling.
- update and add README for old autofs schema.
- wait for master map available at start.
- add master read wait option.
- work around sss startup delay.
- add sss master map wait config option.
- fix quoted key handling in sanitize_path().
- fix included master map not found return.
- dont exit on master map read fail timeout.
- set sane default master read wait timeout.
- don't return until after master map retry read.
- make lookup_nss_read_master() return nss status.
- check NFS server availability on local mount fallback.
- check NFS server availability on local mount fallback.
- make set_direct_mount_catatonic() more general.
- set autofs mounts catatonic at exit.
- honor last rw in mount options when doing a bind mount.
- fix typos in README.amd-maps.
- add ref counting to struct map_source.
- add support for amd browsable option.
- add function conf_amd_get_map_name().
- add function conf_amd_get_mount_paths().
- include amd mount sections mounts in master mounts list.
- check for conflicting amd section mounts.
- add function conf_get_map_options().
- capture cache option and its settings during parsing.
- handle map_option cache for top level mounts.
- handle amd cache option all in amd type auto mounts.
- fix bogus check in expire_cleanup().
- delay submount exit for amd submounts.
- add the mount requestor's pid to pending_args.
- create thread-local ID for mount attempts.
- log functions to prefix messages with attempt_id if available.
- factor out set_thread_mount_request_log_id().
- add config option to use mount request log id.
- use autofs_point to store expire timeout where possibe.
- fix possible NULL derefernce.
- fix work around sss startup delay.
- fix invalid reference in remount_active_mount().
- use malloc for expanded map location.
- fix offset mount location multiple expansion.
- increase worker thread per-thread stack size.
- limit getgrgid_r() buffer size.
- add congigure option for limiting getgrgid_r() stack usage.

Ian
