From: Ian Kent <raven@themaw.net>
Subject: Re: [patch] buffer overflow, failure to auto-dismount,
 log file diarrhea
Date: Sat, 10 Jan 2004 13:06:11 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0401101253170.2403-100000@wombat.indigo.net.au>
References: <Pine.LNX.4.53.0401091118050.9335@simba.math.ucla.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0401091118050.9335@simba.math.ucla.edu>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Fri, 9 Jan 2004, Jim Carter wrote:

> >
> > A user write implies an open file. The expire routine must identify this
> > dentry as busy or it's a bug that needs to be fixed.
>
> No, I meant that when the sys_stat method fills in the mode field of
> the returning stat structure, it would be reported as 555 for a busy
> filesystem, or 755 if it looks idle and dismountable.  The mode field as
> seen by the VFS layer can stay at 755.  This would be when statting
> autofs's directory inode, not whatever is mounted on it.

Don't see how the modes can identify whether a directory is busy. Its
modes could just as well be 555 anyway.

>
> Is it really true that the VFS layer doesn't maintain use counts for
> directories where you can find them easily?

Good question. I'm not sure but I believe the reference count
should be incremented when the dentry is actually being used, so it
doesn't go away. For example, during a mount a dentry is obtained for the
root directory and, since it is obviously in use it has a none zero
reference count as long as the mount is present.

>
> > > So the key task is to bulldoze aside the wreckage so a new instance of the
> > > revitalized NFS server can be mounted.  Killing the moribund processes and
> > > forcibly dismounting the destroyed filesystem instance are important so as
> > > to recover resources, but the client can continue to function for quite a
> > > long time even if that's not done; the only totally vital action is to be
> > > able to remount, and that can possibly be done by renaming, or by
> > > remounting the wreckage elsewhere, deferring the actual dismount.
> >
> > I'll have to think about this for a while. The rename idea might cause all
> > sorts of problems.
>
> I can imagine.  Maybe a -move remount?  Can you even do this when the
> mounted FS is busy?  Well...
>
> mkdir mtpt1 ; mkdir mtpt2
> mount -t nfs hollyfs:/m1 mtpt1
> cd mtpt1
> sleep 3600 &		(PID is 2486)
> cd ..
> umount mtpt1		(device is busy -- correct)
> mount --move mtpt1 mtpt2	(works -- yay!)
> ls -l /proc/2486/cwd	(says: /proc/2486/cwd -> /tmp/root.jimc/mtpt2/)
> grep mtpt /proc/mounts	(says: hollyfs:/m1 /tmp/root.jimc/mtpt2 nfs...)
> grep mtpt /etc/mtab	(says: hollyfs:/m1 /tmp/root.jimc/mtpt1 nfs...
> 			/tmp/root.jimc/mtpt1 /tmp/root.jimc/mtpt2 none rw 0 0
> kill 2486
> umount mtpt2		(works -- correct)
> grep mtpt /proc/mounts	(says: nothing)
> grep mtpt /etc/mtab	(says: hollyfs:/m1 /tmp/root.jimc/mtpt1, hiss, boo)
>
> So you can do a move mount on a busy filesystem; the only downside is that
> /etc/mtab has a stale entry in it -- obviously a bug, not an essential
> behavior.
>
> > A kill -9 on the blocked process needs further investigation. I'm not sure
> > what the situation is there (probably not good).
>
> I would really like it if, when autofs decided to forcibly unmount, it
> could kill the using processes, as in "fuser -k -m /net/host/mountpoint".
> Actually this is a general issue for unmount(8), not specific to autofs.
> But one wonders whether fuser is going to run wild...
>
> > One thing I noticed in the module expire routine is that it doesn't
> > progress past a failed mount on subsequent calls. A change to the
> > adjustment of the d_subdirs list is probably needed (a bit difficult, but
> > not impossible, in my implementation of the expire routine).
>
> I thought it moved the mount point to the end, before attempting to unmount
> it.  Maybe that behavior got changed in a subsequent version, or maybe I'm
> remembering wrong.

I thought it was the front of the list. In fact I thought putting the
expire candidate on the end of the list would help with the infinite loop
problem as well, along with the limit patch you sent. In fact I think that
using the limit patch is a preferable approach to manage this bug for now.

I need to do more work on this in my module patch. Changes I needed to
make have caused this manipulation to become ineffective.

>
> > By the way. Since you are obviously interested in autofs, it would
> > be best if you could use the latest version. Please see kernel.org if
> > you are able to update.
>
> I'll discuss this with my management.  By the way, for RPM-based distros, a
> lot of updating happens via mindless scripts, and it helps if ad-hoc fixes
> are packed up as a RPM.  Then vendor updates to retro versions don't
> overwrite the latest patches.  Example:
>     Currently installed:	autofs4-4.0.0pre10-504
>     I create and install:	autofs4-4.1.0-001
>     Vendor issues patch:	autofs4-4.0.5-678
>

SuSE is a bit difficult. The rpm I have is very much RedHat centric.

Ian
