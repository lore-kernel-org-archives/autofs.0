From: Paul Raines <raines@nmr.mgh.harvard.edu>
Subject: Re: rm hangs on symlinks to down mount points
Date: Tue, 30 Dec 2003 22:17:40 -0500 (EST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0312301903460.24097-100000@gate.nmr.mgh.harvard.edu>
References: <3FF21106.4000907@zytor.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FF21106.4000907@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: autofs@linux.kernel.org

On Tue, 30 Dec 2003, H. Peter Anvin wrote:
> People constantly ask for various kinds of NFS support crap in autofs, 
> and it's *ALWAYS* wrong.  There is really no excuse for a feature 
> working from within autofs and not when mounted normally.
> 
> None.

Also, one could conceivably expect the kernel NFS developers to say to me
"that is feature only people who use autofs would ever want so get those
guys to do it".

I have sort of considered autofs as a wrapper around that basic NFS that
improves it.  And this is one way I would like it improved.  And I sort of
feel like I am really asking for a change in autofs behavior rather than
NFS.  I want autofs to give up on a mount that is taking too long after a
shorter time then for mounts done by hand or in /etc/fstab.

> 
> > 
> >>>I am often getting automount processes that are hung and don't die
> >>>with a simple kill.  I can "kill -9" them but that leaves things in 
> >>>a bad state usually (though sometimes I will just hand edit /etc/mtab
> >>>so I can get something done).
> >>
> >>That's why they don't die with a simple kill.
> > 
> > Which is a pain.  Just because some remote server went down I had 
> > automounted should not force me into a reboot of the client.
> > 
> 
> OK... clue call... *AUTOFS ISN'T INVOLVED.*  Autofs *CANNOT* help you 
> when an in-use filesystem has its server removed from underneath it. 
> All autofs does is mount and unmount filesystems... it's not involved in 
> any shape, way or form with the running thereof.  All autofs can see is 
> that the filesystem is still in use, and there is nothing it can do 
> about it.

Yet somehow it is invovled.  I never have the problem with any hard mounts.
On those I can always succeed in unmounting them when they go down. I do
that by killing processes and doing a 'umount -f'.  A small percentage of
mounts made by autofs seem to become "permanent".  They seem usually tied
to a automount subprocess that will not go away.  Again, I can do a 'kill
-9' on that automount subprocess.  After that, sometimes an 'umount -f'
will work, and sometimes I still get 'device busy'.

fuser is totally useless in these situations since it hangs on down
NFS mounts.  I have discovered doing "find /proc -lname '/mnt/point/*'"
is the way to find processes with files open on a mount.  But even
when that shows nothing, I still get device busy.  

I can shutdown autofs totally but that sometimes stops in ways that
leave the pidXXX entries in mtab.  And that of course disturbs users
of the system accessing volumes that have nothing to do with the
problem volume.

Why am I so keen on getting these volumes unmounted?  Well, too many
programs stop working as soon as any single NFS volume goes down. df is
obvious and not unexpected.  But even 'df /mnt' fails when /mnt is a still
valid mount as for some stupid reason df still goes out and stats every NFS
mount.  Other problems are quota and rpm which both stat every mount. And
we have talked about rm and fuser. These are of course not an autofs
problem.

I guess what I should do is write a 'unautofs' service.  It would
constantly monitor a specific subset of NFS mounts and when it sees a
server has been down for X amount of time then it will unmount its volumes
killing whatever processes it needs to to do it.  However, I am having
a problem finding a reliable way to do that because of the behavior
described above.

> 
> If this sort of things happen to you often you may want to consider soft 
> mounts.  Of course, you take the risk of data loss, but that is the only 
> possible choice -- if the server cannot be accessed, the only options 
> are to wait (hard mount) or return failure and throw the data away (soft 
> mount.)

Yes, using "soft" has been called a bad thing by many, many people
and I want to avoid it.  And I don't think that would help with my problem
anway.  I do use "intr" so I can kill the processing using a dead mount.

Maybe I should give some perspective by describing my situation.

Our center is behind a firewall with incoming ssh access only allowed to a
Linux box called 'gate'.  Within the center we have over 200 Linux user
desktops each with various amounts of data volumes.  We are a Biomedical
Imaging research facility so I am not joking when I say many desktops
have over 2TB of space.  For backup reasons, partitions are limited to
100GB or under so most desktops have several NFS exported volumes. 

The user desktop volumes are mounted through an autofs map on the gate
server.  This is mainly so users can scp or sftp their data from remote
sites.  As I sit right now there are 91 volumes mounted.  The map has
over 1200 entries.

Of course inevitably users login to gate and cd into their desktop's
volumes and then leave that login and forget about it.  Later they may shut
down their desktop (or with over 200 we always have one or two down for
hardware reasons).  Then gate become unhappy when users start using df,
quota, etc.

Of course I have tons of problems with users browsing to the autofs
mountpoint, in nautilus for instance, and then basically reporting to me
that their desktops are frozen.  The really bad thing about nautilus is it
constantly caches the mount points it finds for its Trashcan and then they
all get remounted when the user logins in again. So now I have users who
cause 60 or so mounts to happen everytime they login to their desktop.  
Again that is not autofs's problem, just a design failure on the nautilus
writer's part.  Same issue with AFS.

Well I guess that is more than you wanted to know and I should really
just go complain to the NFS writers and the writers of fuser, df, rm
and quota.

-- 
---------------------------------------------------------------
Paul Raines                   email: raines@nmr.mgh.harvard.edu
MGH/MIT/HMS Athinoula A. Martinos Center for Biomedical Imaging
149 (2301) 13th Street        Charlestown, MA 02129	USA   
