From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Release of AutofsNG 0.4
Date: Thu, 09 Dec 2004 18:21:13 -0500
Message-ID: <41B8DDE9.4020904@sun.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <nfs-admin@lists.sourceforge.net>
Sender: nfs-admin@lists.sourceforge.net
Errors-To: nfs-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/nfs>,
	<mailto:nfs-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <autofs.vger.kernel.org>
List-Post: <mailto:nfs@lists.sourceforge.net>
List-Help: <mailto:nfs-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/nfs>,
	<mailto:nfs-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=nfs>
Content-Type: text/plain; charset="us-ascii"
To: nfs@lists.sourceforge.net, autofs@linux.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello All,

I'm pleased to announce the release of AutofsNG 0.4.

BK trees at:
http://autofsng.bkbits.net

Tarballs are available by FTP:
ftp://ftp-eng.cobalt.com/pub/users/ssmith/autofsng/0.4/

CHANGES
- -------

0.3.1 -> 0.4
- - Kernel automount trapping is now interruptible
- - Expiry fixes for multimounts with > ~1024 entries
- - Agent cleanup, less likelyhood of the agent leaving garbage in /tmp
- - Moved MOUNTPROG xdr generation into the build so we don't rely on
librpcsvc.a
- - MOUNTFD is now closed before exec()ing mount(8): killing the agent
alone now
  cancels an automount trap and lookup for userspace.
- - xprt sharing added: Multiple NFS mounts to the same server use a single
  tcp/udp connection. (allows for > 800 nfs mounts)
- - The kernel mapcache used for browsing now uses it's own slab cache to
save a
  couple bytes.
- - Memory leaks plugged in the kernel browse mapcache.

KNOWN ISSUES
- ------------
- - Default mount options in auto.master are currently ignored.
- - Default timeout / timeout on the command line are ignored (all mounts
timeout
  after 10 seconds).
- - The parser may be a little too strict for some maps that use
non-nfs(ipv4)
  mounts.
- - Many applications are broken because they don't understand what a direct
  mount is (and thus trample into them).
- - The kernel code is hard-coded to use '/sbin/autofsng' to perform the
mounts.
  (installing it anywhere else won't work).
- - Only x86 has syscall table entries at present.

(patches welcome :)

RECAP
- -----
This automounter is intended to be 100% interoperable with autofs
implementations on other Unix platforms.  As such, it supports some
feature that the current Linux automounters do not:

- - Direct Mounts
- - /net (--hosts access)
- - Lazy mounting of hierarchal / multimounts
- - Lazy unmounting of hierarchal / multimounts
- - Browsing

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

INSTALLATION
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

    autoconf
    ./configure

to configure the system.  See README.options for options that you can
give configure.

After configuring, you can:

make
make install

Enjoy :)

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

iD8DBQFBuN3pdQs4kOxk3/MRAhcdAKCLOmoEB1oXUbJHKN7LPzdweykf+gCfcvZA
Tjm5rWPAsbyXGCsOsXmz6q4=
=TKPS
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
NFS maillist  -  NFS@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/nfs
