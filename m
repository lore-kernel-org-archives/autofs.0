From: Ian Kent <raven@themaw.net>
Subject: Re: Possible autofs daemon thread locking issue?
	(was:	Automounterlosing track of mounts...)
Date: Sat, 16 Aug 2008 11:01:48 +0800
Message-ID: <1218855709.3194.11.camel@raven.themaw.net>
References: <A2ECBF49F352C24F9DF65BB529DCBC70187A58BD@hqemmail01.nvidia.com>
	<1218691003.27280.92.camel@raven.themaw.net>
	<A2ECBF49F352C24F9DF65BB529DCBC70187A58C9@hqemmail01.nvidia.com>
	<1218735745.3216.13.camel@raven.themaw.net>
	<A2ECBF49F352C24F9DF65BB529DCBC70187A58CF@hqemmail01.nvidia.com>
	<A2ECBF49F352C24F9DF65BB529DCBC70187A58D8@hqemmail01.nvidia.com>
	<1218770689.3152.5.camel@raven.themaw.net>
	<A2ECBF49F352C24F9DF65BB529DCBC70187A58DF@hqemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <A2ECBF49F352C24F9DF65BB529DCBC70187A58DF@hqemmail01.nvidia.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Stephen Biggs <sbiggs@nvidia.com>
Cc: autofs@linux.kernel.org


On Fri, 2008-08-15 at 10:22 -0700, Stephen Biggs wrote:
> > -----Original Message-----
> > From: Ian Kent [mailto:raven@themaw.net] 
> > Sent: Thursday, August 14, 2008 8:25 PM
> > To: Stephen Biggs
> > Cc: autofs@linux.kernel.org
> > Subject: Re: Possible autofs daemon thread locking issue? 
> > (was: Automounterlosing track of mounts...)
> > 
> > 
> > On Thu, 2008-08-14 at 15:01 -0700, Stephen Biggs wrote:
> > > After looking at the code for spawn_mounts in daemon/spawn.c, there 
> > > are a couple of places that seem to bear more scrutiny.
> > > 
> > > On or about line 329, an if block is started:
> > > 
> > > 			if (!argv[argc]) {
> > > 				argv[argc + 1] = NULL;
> > > 				argv[argc] = argv[argc - 1];
> > > 				argv[argc - 1] = argv[argc - 2];
> > > 				argv[argc - 2] = arg_fake;
> > > 			}
> > > 
> > > Note that "arg_fake" is only added to the argument string 
> > if the last 
> > > argv pointer is null.  But, the mount is retried anyway. I don't 
> > > understand this check and don't understand if the "-f" is, in fact, 
> > > passed to `mount` if the check fails.
> > > 
> > > Also, the next if statement after the "while (retries--) {" 
> > block is 
> > > checking for equality rather than using a bit test:
> > > 
> > > 	if (ret == MTAB_NOTUPDATED) {
> > > 
> > > This looks iffy to me.
> > > 
> > > But, these are minor and may only be cosmetic.
> > > 
> > > After looking at my logs more closely, it looks really 
> > strange.  Is it 
> > > possible that there is some sort of intra-thread locking 
> > issue within 
> > > the automounter itself?
> > > 
> > > ======== Look at this sequence (all names obfuscated):
> > > 
> > > Aug 13 01:40:35 client-1 automount[30947]: handle_packet: 
> > type = 3 Aug 
> > > 13 01:40:35 client-1 automount[30947]:
> > > handle_packet_missing_indirect: token 2515187, name 
> > dir_to_automount, 
> > > request pid 16344 Aug 13 01:40:35 client-1 automount[30947]: 
> > > attempting to mount entry /home/dir_to_automount Aug 13 01:40:35 
> > > client-1 automount[30947]: lookup_mount: lookup(yp):
> > > looking up dir_to_automount
> > > Aug 13 01:40:36 client-1 automount[30947]: lookup_mount: lookup(yp):
> > > dir_to_automount ->
> > > -rw,intr,retrans=10,timeo=600,hard,rsize=32768,wsize=32768,tcp
> > > nfsserver:/vol/work/dir_to_automount
> > > Aug 13 01:40:36 client-1 automount[30947]: parse_mount: parse(sun):
> > > dequote("nfsserver:/vol/work/dir_to_automount") -> 
> > > nfsserver:/vol/work/dir_to_automount
> > > Aug 13 01:40:36 client-1 automount[30947]: parse_mount: parse(sun): 
> > > core of entry:
> > > 
> > options=rw,intr,retrans=10,timeo=600,hard,rsize=32768,wsize=32768,tcp,
> > > loc=nfsserver:/vol/work/dir_to_automount
> > > Aug 13 01:40:36 client-1 automount[30947]: sun_mount: parse(sun):
> > > mounting root /home, mountpoint dir_to_automount, what 
> > > nfsserver:/vol/work/dir_to_automount, fstype nfs, options 
> > > rw,intr,retrans=10,timeo=600,hard,rsize=32768,wsize=32768,tcp
> > > Aug 13 01:40:36 client-1 automount[30947]: mount_mount: mount(nfs):
> > > root=/home name=dir_to_automount
> > > what=nfsserver:/vol/work/dir_to_automount, fstype=nfs, 
> > > 
> > options=rw,intr,retrans=10,timeo=600,hard,rsize=32768,wsize=32768,tcp
> > > Aug 13 01:40:36 client-1 automount[30947]: mount_mount: mount(nfs): 
> > > nfs 
> > > 
> > options="rw,intr,retrans=10,timeo=600,hard,rsize=32768,wsize=32768,tcp
> > > ",
> > > nosymlink=0, ro=0
> > > Aug 13 01:40:36 client-1 automount[30947]: mount_mount: mount(nfs):
> > > calling mkdir_path /home/dir_to_automount Aug 13 01:40:36 client-1 
> > > automount[30947]: mount_mount: mount(nfs):
> > > calling mount -t nfs -s -o
> > > rw,intr,retrans=10,timeo=600,hard,rsize=32768,wsize=32768,tcp
> > > nfsserver:/vol/work/dir_to_automount /home/dir_to_automount
> > > 
> > > ======= so far, so good, the mount command is working.  
> > But, it takes 
> > > up to 4 seconds to return, and before it does, the directory that  
> > > hasn't been finished automounting already is getting 
> > expired, while it 
> > > is in the middle of the automount sequence:
> > > 
> > > Aug 13 01:40:40 client-1 automount[30947]: expire_proc_indirect: 
> > > expire /home/dir_to_automount Aug 13 01:40:40 client-1 
> > > automount[30947]: 116 remaining in /home
> > > 
> > > ======= only after that does the mount sequence finish, but 
> > I believe 
> > > that this is where it is already messed up with the 
> > dir_to_automount 
> > > directory already deleted in the automounter and the file system by 
> > > the expire thread.
> > > 
> > > Aug 13 01:40:40 client-1 automount[30947]: mount(nfs): mounted 
> > > nfsserver:/vol/work/dir_to_automount on 
> > /home/dir_to_automount Aug 13 
> > > 01:40:40 client-1 automount[30947]: expire_cleanup: got thid
> > > 3073362864 path /home stat 119
> > > Aug 13 01:40:40 client-1 automount[30947]: expire_cleanup: sigchld: 
> > > exp
> > > 3073362864 finished, switching from 2 to 1 Aug 13 01:40:40 client-1 
> > > automount[30947]: send_ready: token = 2515187 Aug 13 
> > 01:40:40 client-1 
> > > automount[30947]: mounted /home/dir_to_automount
> > > 
> > > ====== We then immediately get another request to automount and the 
> > > automounter never heard of it before, even though it is now really
> > > mounted:
> > > Aug 13 01:40:40 client-1 automount[30947]: handle_packet: 
> > type = 3 Aug 
> > > 13 01:40:41 client-1 automount[30947]:
> > > handle_packet_missing_indirect: token 2515193, name 
> > dir_to_automount, 
> > > request pid 16376 Aug 13 01:40:41 client-1 automount[30947]: 
> > > attempting to mount entry /home/dir_to_automount Aug 13 01:40:41 
> > > client-1 automount[30947]: lookup_mount: lookup(yp):
> > > looking up dir_to_automount
> > > Aug 13 01:40:41 client-1 automount[30947]: lookup_mount: lookup(yp):
> > > dir_to_automount ->
> > > -rw,intr,retrans=10,timeo=600,hard,rsize=32768,wsize=32768,tcp
> > > nfsserver:/vol/work/dir_to_automount
> > > Aug 13 01:40:41 client-1 automount[30947]: parse_mount: parse(sun):
> > > expanded entry:
> > > -rw,intr,retrans=10,timeo=600,hard,rsize=32768,wsize=32768,tcp
> > > nfsserver:/vol/work/dir_to_automount
> > > Aug 13 01:40:41 client-1 automount[30947]: parse_mount: parse(sun):
> > > gathered options:
> > > rw,intr,retrans=10,timeo=600,hard,rsize=32768,wsize=32768,tcp
> > > Aug 13 01:40:41 client-1 automount[30947]: parse_mount: parse(sun):
> > > dequote("nfsserver:/vol/work/dir_to_automount") -> 
> > > nfsserver:/vol/work/dir_to_automount
> > > Aug 13 01:40:41 client-1 automount[30947]: parse_mount: parse(sun): 
> > > core of entry:
> > > 
> > options=rw,intr,retrans=10,timeo=600,hard,rsize=32768,wsize=32768,tcp,
> > > loc=nfsserver:/vol/work/dir_to_automount
> > > Aug 13 01:40:41 client-1 automount[30947]: sun_mount: parse(sun):
> > > mounting root /home, mountpoint dir_to_automount, what 
> > > nfsserver:/vol/work/dir_to_automount, fstype nfs, options 
> > > rw,intr,retrans=10,timeo=600,hard,rsize=32768,wsize=32768,tcp
> > > Aug 13 01:40:41 client-1 automount[30947]: mount_mount: mount(nfs):
> > > root=/home name=dir_to_automount
> > > what=nfsserver:/vol/work/dir_to_automount, fstype=nfs, 
> > > 
> > options=rw,intr,retrans=10,timeo=600,hard,rsize=32768,wsize=32768,tcp
> > > Aug 13 01:40:41 client-1 automount[30947]: mount_mount: mount(nfs): 
> > > nfs 
> > > 
> > options="rw,intr,retrans=10,timeo=600,hard,rsize=32768,wsize=32768,tcp
> > > ",
> > > nosymlink=0, ro=0
> > > Aug 13 01:40:41 client-1 automount[30947]: mount_mount: mount(nfs):
> > > calling mkdir_path /home/dir_to_automount
> > > 
> > > ======= We're already dead in the water here:
> > > 
> > > Aug 13 01:40:41 client-1 automount[30947]: mount_mount: mount(nfs):
> > > warning: /home/dir_to_automount is already mounted Aug 13 01:40:41 
> > > client-1 automount[30947]: mount(nfs): nfs: mount failure 
> > > nfsserver:/vol/work/dir_to_automount on 
> > /home/dir_to_automount Aug 13 
> > > 01:40:42 client-1 automount[30947]: failed to mount 
> > > /home/dir_to_automount
> > > 
> > > ========
> > > 
> > > 
> > > There are a few more attempts to automount 
> > 'dir_to_automount' at the 
> > > same time that the expire thread is trying to expire it.
> > > 
> > > Also, after that expire attempt in the middle of the automount 
> > > sequence, about 5 more automounted directories started 
> > acting the same 
> > > way, that is, mounted via NFS but automounter didn't know about 
> > > them... No other expiry in the middle of the automount 
> > sequence as far as I can see.
> > > 
> > > 'umount -a' may work, but it will also kill any local mounts.
> > > 
> > > 'umount -a -t nfs' may be better, but anybody is mounting an NFS 
> > > resource that is not automounted, this will also mess things up.
> > 
> > You've convinced me.
> > I think your seeing the kernel issue I spoke about.
> 
> Which kernel issue?  Lots of them ... :-/

Yeah, there have been a few lately.

I believe (but could be wrong) this patch addresses that problem (patch
description only).

autofs4 - use look aside list for lookups

A while ago a patch to resolve a deadlock during directory creation
was merged. This delayed the hashing of lookup dentrys until the
->mkdir() (or ->symlink()) operation completed to ensure we always
went through ->lookup() instead of also having processes go through
->revalidate() so our VFS locking remained consistent.

Now we are seeing a couple of side affects of that change in situations
with heavy mount activity.

Two cases have been identified:

1) When a mount request is triggered, due to the delayed hashing, the
directory created by user space for the mount point doesn't have the
DCACHE_AUTOFS_PENDING flag set. In the case of an autofs multi-mount
where a tree of mount point directories are created this can lead to
the path walk continuing rather than the dentry being sent to the wait
queue to wait for request completion. This is because, if the pending
flag isn't set, the criteria for deciding this is a mount in progress
fails to hold, namely that the dentry is not a mount point and has no
subdirectories.

2) A mount request dentry is initially created negative and unhashed.
It remains this way until the ->mkdir() callback completes. Since it is
unhashed a fresh dentry is used when the user space mount request creates
the mount point directory. This leaves the original dentry negative and
unhashed. But revalidate has no way to tell the VFS that the dentry has
changed, other than to force another ->lookup() by returning false, which
is at best wastefull and at worst not possible. This results in an
-ENOENT return from the original path walk when in fact the mount succeeded.

To resolve this we need to ensure that the same dentry is used in all
calls to ->lookup() during the course of a mount request. This patch
achieves that by adding the initial dentry to a look aside list and
removes it at ->mkdir() or ->symlink() completion (or when the dentry
is released), since these are the only create operations autofs4 supports.

> 
> I not trying to argue with you or be difficult... Just looking to figure
> this out.
> 
> I just don't understand how this is a kernel issue?
> 
> It looks to me like the automounter is trying to auto-expire a mount
> that is in the middle of being automounted.  Isn't this a straight
> daemon thread locking issue?  That is, the expire thread should not even
> try to expire a particular until the automount sequence is completely
> done, no matter what it may get from the kernel telling it to unmount
> it.
> 
> Perhaps putting a lock around the automount sequence, checking it in the
> expire thread, queueing that expire requests temporarily until the
> particular automount sequence is done, and then waking up the expire
> thread once the automount is complete. I can do a patch if you agree.
> 
> What am I missing?

But sending a request to check a mount for expiry doesn't mean that the
kernel will send the daemon a request to umount it.

In particular this code in the expire check

        /* No point expiring a pending mount */
        if (dentry->d_flags & DCACHE_AUTOFS_PENDING)
                return 0;

will ensure that doesn't happen.
There's nothing to be gained by making the daemon even more complex when
a simple check in the kernel can deal with the occasional occurrence of
this situation.

Also, I have dreams of making the expire much simpler (or maybe
nightmares) by having the kernel do a little more work, more like what
is done in version 4, but that's another matter all together.

Ian

> -----------------------------------------------------------------------------------
> This email message is for the sole use of the intended recipient(s) and may contain
> confidential information.  Any unauthorized review, use, disclosure or distribution
> is prohibited.  If you are not the intended recipient, please contact the sender by
> reply email and destroy all copies of the original message.
> -----------------------------------------------------------------------------------
