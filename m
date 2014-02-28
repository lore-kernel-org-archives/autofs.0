From: Alexander Viro <aviro@redhat.com>
Subject: Re: "Too many levels of symbolic links"
Date: Fri, 28 Feb 2014 08:29:06 -0500
Message-ID: <20140228132906.GM15017@sh-el6.eng.rdu2.redhat.com>
References: <1391145206.2486.25.camel@perseus.fritz.box>
 <52EB7694.20707@molgen.mpg.de>
 <52EB7B07.2070707@molgen.mpg.de>
 <530484B7.6030305@molgen.mpg.de>
 <1392896501.2508.16.camel@perseus.fritz.box>
 <1392898704.2508.26.camel@perseus.fritz.box>
 <530625D0.7020808@molgen.mpg.de>
 <1392946952.2495.3.camel@perseus.fritz.box>
 <53076D91.7050703@molgen.mpg.de>
 <53107D4A.90904@molgen.mpg.de>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53107D4A.90904@molgen.mpg.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: Ian Kent <raven@themaw.net>, autofs <autofs@vger.kernel.org>, Alexander Viro <aviro@redhat.com>

On Fri, Feb 28, 2014 at 01:12:58PM +0100, Donald Buczek wrote:

> Obviously, "cleared mounted on dentry" is missing.
> 
> It looks like we enter put_mountpoint() but don't get to
> dentry->d_flags &= ~DCACHE_MOUNTED;
> 
> mp->m_count is not zero probably.
> 
> What does it mean? The mount is still locked but not in the mount hash?

No, it means that something else is mounted on the same dentry (in another
part of mount tree, obviously).

If you mount the same fs on two different mountpoints, e.g.
mount /dev/sda1 /mnt
mount /dev/sda1 /tmp/foo
you will have the same dentries seen in two places.  Now,
mount /dev/sdb11 /mnt/a
mount /dev/sdc5 /tmp/foo/a

and you've got two different filesystems mounted on two different places
(/mnt/a and /tmp/foo/a).  These two places have different vfsmounts,
but the same dentry.  struct mountpoint is associated with dentry, so
it's also the same for both.  And it serves as a mountpoint for two
vfsmounts - one for fs from sdb11, another for fs from sdc5.

Now umount /mnt/a; one of those two vfsmounts is gone now.  struct mountpoint
survives, of course, and dentry is *still* a mountpoint.  sdc5 is still
mounted on /tmp/foo/a, after all...
