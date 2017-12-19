From: Ian Kent <raven@themaw.net>
Subject: [ANNOUNCE] autofs 5.1.4 release
Date: Tue, 19 Dec 2017 16:29:48 +0800
Message-ID: <6e84aeff-a175-10a0-315f-59912c5cc93b@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:message-id
        :mime-version:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=loszWk455oJbuPPAehqAyBhJcg/mpW2XaK49nzPlrLs=; b=Ywx6oyC2
        AihzPAiGGjaCqn66xqXMN+53H7CgzRnUDFcNywfsJF+CXsTbzd501DjMDv+cx39x
        gxG4Ndi4roHwqmQ5bydmTezOtMYHeXLj/RtXzoKkEtErN2154HKiKNT+iU82i1RD
        tITFcaGR6dmnCsindMULhncSEEI7xSWJJbMV2jD5RD1ZgUTSLij8jj6QPFg8C+pz
        c/uBpwysElh0jfq4L8Hh+J2jIb5WJ3zM1LKRRc3qgo3hr+gFkMCLSyR4/slUKtbd
        mEuqvcViIHMaOnIOr2F+TKIErE5L3qcFNce1YGuLGjvNKFtzWjz1BB84+U3MZ0nh
        zUNlV24tdB9Dig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=loszWk455oJbuPPAehqAyBhJcg/mp
        W2XaK49nzPlrLs=; b=g5B2xNKGt1UrYNugj3IKKd/jpQedn6ECTpnW+WjcMtRbJ
        nDItDkb1gbE9LJgei29yQIkKn21pgW0G36ONQ39YsnnjFjNAz7V9G47MPQ9fZDnL
        e0FeyVD7VIPuGPTRU0+Hm2sIrLTmwWHcZjkxf52VE4LlA3B3pfQv4TUC0FfRRe78
        28jITOMkBmuv3VW2h5F4jhqfz3EgAhSm3wvSqZOqLB5DFpyMBBwd84t86wlBKu9Q
        b9Jrzt8LRMQsQgC3GpvWnF0o9mYfNs6tjXyURPUpUSk3YlLn7jrCucxB5T6Dh+h6
        bv1x+C/RWu6Z71XSz98q+gg2E1RHmNXR4G0luusbg==
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi all,

It's finally time for a release, autofs-5.1.4.

Unfortunately there were a couple of annoying regressions in 5.1.3.

I believe they have been resolved in this release.

Also, the startup retry on the master map not available logic has
been improved so that should function properly now and help with
reported problems of startup failures. The delay is configurable
in case the default is not sufficient.

A new amd mount type has been added. The amd mount type "program"
has been added which allows a user provided program to be given
in a map entry that will be used for performing the mount and
optionally another program to be used at umount.

Additionally there are a number of bug fixes and other minor
improvements.

autofs
======

The package can be found at:
https://www.kernel.org/pub/linux/daemons/autofs/v5/

It is autofs-5.1.4.tar.[gz|xz]

No source rpm is there as it can be produced by using:

rpmbuild -ts autofs-5.1.4.tar.gz

and the binary rpm by using:

rpmbuild -tb autofs-5.1.4.tar.gz

See the README.amd-maps file for information about using amd format
maps.

Here are the entries from the CHANGELOG which outline the updates:

19/12/2017 autofs-5.1.4
- fix spec file url.
- fix unset tsd group name handling.
- Add -c option when calling /bin/umount - if supported.
- remove some redundant rpc library code.
- add port parameter to rpc_ping().
- dont probe NFSv2 by default.
- add version parameter to rpc_ping().
- fix typo in autofs config file comments.
- fix typos in autofs man pages.
- use pkg-config to search for libtirpc to fix cross-compilation.
- fix incorrect status return in get_nfs_info().
- fix a couple of compiler warnings.
- set systemd KillMode to process.
- fix mount.nfs blocks on first mount.
- fix some man page problems.
- add some more debug logging to get_nfs_info().
- add some more debug logging to get_supported_ver_and_cost().
- fix ipv6 proto option handling.
- also check flag file exe name.
- fix possible map instance memory leak.
- check map instances for staleness on map update.
- allow dot in OPTIONSTR value lexer pattern.
- fix autofs_use_lofs description.
- fix amd parser error buffer size.
- make spawn_bind_mount() use mount_wait as well.
- document ghost option in auto.master man page.
- only take master map mutex for master map update.
- revert fix argc off by one in mount_autofs.c.
- reset master map list on startup retry.
- fix nisplus lookup init not configured check.
- make open_lookup() error handling more consistent.
- be silent about sss library not found.
- be silent about nis domain not set.
- make map source reference message debug only.
- improve description of mount_nfs_default_protocol.
- the port option should not behave like nobind option.
- handle additional nfs versions in mount_nfs.c.
- fix symlink option passthrough in mount_nfs.c.
- fix ordering of seteuid/setegid in do_spawn().
- update configure to check for pipe2(2).
- fix open calls not using open_xxxx() calls.
- move open_xxxx() functions to spawn.c.
- serialize calls to open_xxxx() functions.
- improve debug logging of lookup key.
- fix typo in amd_parse.c.
- add missing MODPREFIX to logging in amd parser.
- fix symlink false negative in umount_multi().
- remove expand_selectors() on amd parser entry.
- fix amd defaults map entry handling.
- refactor amd_parse.c.
- fix amd parser double quote handling.
- fix expandamdent() quote handling.
- fix possible memory leak during amd parse.
- remove path restriction of amd external mount.
- add function umount_amd_ext_mount().
- add function ext_mount_inuse().
- add function construct_argv().
- add amd mount type program mount support.
- fix memory leak in umount_amd_ext_mount().
- fix strerror_r() parameter declaration in do program_mount().
- fix incorrect check in validate_program_options().
- fix log message in spawn_umount().
- workaround getaddrinfo(3) ai_canonname bug

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
