From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: [announce] autofsng 0.3.1
Date: Mon, 22 Nov 2004 20:53:13 -0500
Message-ID: <41A29809.9090707@sun.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org
Cc: Ian Kent <raven@themaw.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello All,

I'm pleased to announce the release of AutofsNG 0.3.1.

This automounter is intended to be 100% interoperable with autofs
implementations on other Unix platforms.  As such, it supports some
feature that the current Linux automounters do not:

- - Direct Mounts (*)
- - /net (--hosts access) (*)
- - Lazy mounting of hierarchal / multimounts
- - Lazy unmounting of hierarchal / multimounts
- - Browsing (*)

(*) automount 4.1.3 supports these features but with limitations that
impact interoperability.

Of course, autofsng also supports the usual indirect map support
available elsewhere.

Maps are supported from:

- - flat files
- - executable maps
- - nis maps
- - nis+ maps
- - ldap maps (in not one, but 3! different flavours)
- - hesiod (dns) filsys namespace

Of course, all this name service stuff is handled by /etc/nsswitch.conf
logic.

Also, as an added bonus, autofsng also supports the Linux specific
'namespace' paradigm (man clone(2)).

This release marks the first where we actually posted tarballs of the
userspace bits and kernel patch in one place (at the same time as the
announcement.  They can be found at:

ftp://ftp-eng.cobalt.com/pub/users/ssmith/autofsng/0.3.1/

Also, we have bk trees at:

http://autofsng.bkbits.net

(ignore the -old tree)

There are a couple known issues with this release, all of which will get
some attention in coming releases:

- - Default mount options in auto.master are currently ignored.
- - Default timeout / timeout on the command line are ignored (all mounts
timeout after 10 seconds).
- - The parser may be a little too strict for some maps that use
non-nfs(ipv4) mounts.
- - The first process to access an automounted filesystem that hangs is
left in interruptible sleep.
- - Many applications are broken because they don't understand what a
direct mount is (and thus trample into them).
- - The kernel code is hard-coded to use '/sbin/autofsng' to perform the
mounts. (installing it anywhere else won't work).

- From the README:

Installation
- ------------

Setting up autofsng requires two main pieces of code to be built and
set up on your machine, the kernel code and the userland bits.

Once you have the autofsng bits in your kernel tree, you will need to
enabled CONFIG_AUTOFSNG_FS in the build.  If set to 'y', then autofsng
will be built into the kernel proper and provide the pseudo
filesystem 'autofsng'.  If built as a module, the module will be called
'autofsng' and it will provide the 'autofsng' filesystem.

Note that there currently exists two other autofs implementations in
the kernel.  CONFIG_AUTOFS_FS, which is the autofs3 implementation is
no longer actively maintained and the favourable replacement for it
has become autofs4, specified by CONFIG_AUTOFS4_FS.  Both of these
filesystems
are called 'autofs', which is why we call ourselves 'autofsng'.

You will need to run autoconf on the resulting pull.

To build the userspace tools , please run:

    configure

to configure the system.  See README.options for options that you can
give configure.

After configuring, you can:

make
make install

Enjoy  :)

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBopgJdQs4kOxk3/MRAnURAJ9lA8UnkQMqsEy55B+LshmGR+ARzACdGue5
TRSCaT3nZX9HpGRvbW1JxK0=
=oktk
-----END PGP SIGNATURE-----
