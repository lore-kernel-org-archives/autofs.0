From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: [patch] buffer overflow, failure to auto-dismount,
 log file diarrhea
Date: Fri, 9 Jan 2004 11:58:53 -0800 (PST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.53.0401091118050.9335@simba.math.ucla.edu>
References: <Pine.LNX.4.44.0401031051350.4413-100000@raven.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0401031051350.4413-100000@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Sat, 3 Jan 2004, Ian Kent wrote:
> On Fri, 2 Jan 2004, Jim Carter wrote:
> > Right, expire.c :: autofs4_expire() bypasses a mount point if its last_used
> > field is too recent, and then it checks is_tree_busy().  Oh, look, a kludge
> > that could be added, how wonderful!  Assuming that it's feasible to get
> > module-provided data into the inode data returned from sys_stat or
> > sys_fstat, a mode bit could be set to indicate busyness, e.g. user write
> > implies not busy.
>
> A user write implies an open file. The expire routine must identify this
> dentry as busy or it's a bug that needs to be fixed.

No, I meant that when the sys_stat method fills in the mode field of
the returning stat structure, it would be reported as 555 for a busy
filesystem, or 755 if it looks idle and dismountable.  The mode field as
seen by the VFS layer can stay at 755.  This would be when statting
autofs's directory inode, not whatever is mounted on it.

Is it really true that the VFS layer doesn't maintain use counts for
directories where you can find them easily?

> > So the key task is to bulldoze aside the wreckage so a new instance of the
> > revitalized NFS server can be mounted.  Killing the moribund processes and
> > forcibly dismounting the destroyed filesystem instance are important so as
> > to recover resources, but the client can continue to function for quite a
> > long time even if that's not done; the only totally vital action is to be
> > able to remount, and that can possibly be done by renaming, or by
> > remounting the wreckage elsewhere, deferring the actual dismount.
>
> I'll have to think about this for a while. The rename idea might cause all
> sorts of problems.

I can imagine.  Maybe a -move remount?  Can you even do this when the
mounted FS is busy?  Well...

mkdir mtpt1 ; mkdir mtpt2
mount -t nfs hollyfs:/m1 mtpt1
cd mtpt1
sleep 3600 &		(PID is 2486)
cd ..
umount mtpt1		(device is busy -- correct)
mount --move mtpt1 mtpt2	(works -- yay!)
ls -l /proc/2486/cwd	(says: /proc/2486/cwd -> /tmp/root.jimc/mtpt2/)
grep mtpt /proc/mounts	(says: hollyfs:/m1 /tmp/root.jimc/mtpt2 nfs...)
grep mtpt /etc/mtab	(says: hollyfs:/m1 /tmp/root.jimc/mtpt1 nfs...
			/tmp/root.jimc/mtpt1 /tmp/root.jimc/mtpt2 none rw 0 0
kill 2486
umount mtpt2		(works -- correct)
grep mtpt /proc/mounts	(says: nothing)
grep mtpt /etc/mtab	(says: hollyfs:/m1 /tmp/root.jimc/mtpt1, hiss, boo)

So you can do a move mount on a busy filesystem; the only downside is that
/etc/mtab has a stale entry in it -- obviously a bug, not an essential
behavior.

> A kill -9 on the blocked process needs further investigation. I'm not sure
> what the situation is there (probably not good).

I would really like it if, when autofs decided to forcibly unmount, it
could kill the using processes, as in "fuser -k -m /net/host/mountpoint".
Actually this is a general issue for unmount(8), not specific to autofs.
But one wonders whether fuser is going to run wild...

> One thing I noticed in the module expire routine is that it doesn't
> progress past a failed mount on subsequent calls. A change to the
> adjustment of the d_subdirs list is probably needed (a bit difficult, but
> not impossible, in my implementation of the expire routine).

I thought it moved the mount point to the end, before attempting to unmount
it.  Maybe that behavior got changed in a subsequent version, or maybe I'm
remembering wrong.

> By the way. Since you are obviously interested in autofs, it would
> be best if you could use the latest version. Please see kernel.org if
> you are able to update.

I'll discuss this with my management.  By the way, for RPM-based distros, a
lot of updating happens via mindless scripts, and it helps if ad-hoc fixes
are packed up as a RPM.  Then vendor updates to retro versions don't
overwrite the latest patches.  Example:
    Currently installed:	autofs4-4.0.0pre10-504
    I create and install:	autofs4-4.1.0-001
    Vendor issues patch:	autofs4-4.0.5-678

The scripts know that the vendor's patch should be bypassed.  If I get the
go-ahead to install 4.1.0, I'll fake up a spec file (like steal it from the
SuSE package) and send in some notes for how to use it.

By the way, sorry for the late reply.  Your message just arrived
(2003-01-09) -- probably stuck on some MX somewhere for 3 days.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
