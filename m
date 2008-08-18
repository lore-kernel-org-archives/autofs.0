From: "Stephen Biggs" <sbiggs@nvidia.com>
Subject: Re: Possible autofs daemon thread locking issue?
	(was:Automounterlosing track of mounts...)
Date: Mon, 18 Aug 2008 13:00:19 -0700
Message-ID: <A2ECBF49F352C24F9DF65BB529DCBC70187A58F2@hqemmail01.nvidia.com>
References: <A2ECBF49F352C24F9DF65BB529DCBC70187A58BD@hqemmail01.nvidia.com>
	<1218691003.27280.92.camel@raven.themaw.net>
	<A2ECBF49F352C24F9DF65BB529DCBC70187A58C9@hqemmail01.nvidia.com>
	<1218735745.3216.13.camel@raven.themaw.net>
	<A2ECBF49F352C24F9DF65BB529DCBC70187A58CF@hqemmail01.nvidia.com>
	<A2ECBF49F352C24F9DF65BB529DCBC70187A58D8@hqemmail01.nvidia.com>
	<1218770689.3152.5.camel@raven.themaw.net>
	<A2ECBF49F352C24F9DF65BB529DCBC70187A58DF@hqemmail01.nvidia.com>
	<1218855709.3194.11.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1218855709.3194.11.camel@raven.themaw.net>
Content-class: urn:content-classes:message
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

> -----Original Message-----
> From: Ian Kent [mailto:raven@themaw.net] 
> Sent: Friday, August 15, 2008 8:02 PM
> To: Stephen Biggs
> Cc: autofs@linux.kernel.org
> Subject: RE: Possible autofs daemon thread locking issue? 
> (was:Automounterlosing track of mounts...)
> 
> 

-- snip --

> > Which kernel issue?  Lots of them ... :-/
> 
> Yeah, there have been a few lately.
> 
> I believe (but could be wrong) this patch addresses that 
> problem (patch description only).
> 
> autofs4 - use look aside list for lookups
> 
> A while ago a patch to resolve a deadlock during directory 
> creation was merged. This delayed the hashing of lookup 
> dentrys until the
> ->mkdir() (or ->symlink()) operation completed to ensure we always
> went through ->lookup() instead of also having processes go through
> ->revalidate() so our VFS locking remained consistent.
> 
> Now we are seeing a couple of side affects of that change in 
> situations with heavy mount activity.
> 
> Two cases have been identified:
> 
> 1) When a mount request is triggered, due to the delayed 
> hashing, the directory created by user space for the mount 
> point doesn't have the DCACHE_AUTOFS_PENDING flag set. In the 
> case of an autofs multi-mount where a tree of mount point 
> directories are created this can lead to the path walk 
> continuing rather than the dentry being sent to the wait 
> queue to wait for request completion. This is because, if the 
> pending flag isn't set, the criteria for deciding this is a 
> mount in progress fails to hold, namely that the dentry is 
> not a mount point and has no subdirectories.
> 
> 2) A mount request dentry is initially created negative and unhashed.
> It remains this way until the ->mkdir() callback completes. 
> Since it is unhashed a fresh dentry is used when the user 
> space mount request creates the mount point directory. This 
> leaves the original dentry negative and unhashed. But 
> revalidate has no way to tell the VFS that the dentry has 
> changed, other than to force another ->lookup() by returning 
> false, which is at best wastefull and at worst not possible. 
> This results in an -ENOENT return from the original path walk 
> when in fact the mount succeeded.
> 
> To resolve this we need to ensure that the same dentry is 
> used in all calls to ->lookup() during the course of a mount 
> request. This patch achieves that by adding the initial 
> dentry to a look aside list and removes it at ->mkdir() or 
> ->symlink() completion (or when the dentry is released), 
> since these are the only create operations autofs4 supports.

Where was this patch merged, into the latest development kernel?  Will
this be part of the latest and greatest release?

Was the patch posted to the autofs list?

I am still trying to access the archives which still "forbid" me.

> 
> > 
> > I not trying to argue with you or be difficult... Just looking to 
> > figure this out.
> > 
> > I just don't understand how this is a kernel issue?
> > 
> > It looks to me like the automounter is trying to 
> auto-expire a mount 
> > that is in the middle of being automounted.  Isn't this a straight 
> > daemon thread locking issue?  That is, the expire thread should not 
> > even try to expire a particular until the automount sequence is 
> > completely done, no matter what it may get from the kernel 
> telling it 
> > to unmount it.
> > 
> > Perhaps putting a lock around the automount sequence, 
> checking it in 
> > the expire thread, queueing that expire requests 
> temporarily until the 
> > particular automount sequence is done, and then waking up 
> the expire 
> > thread once the automount is complete. I can do a patch if 
> you agree.
> > 
> > What am I missing?
> 
> But sending a request to check a mount for expiry doesn't 
> mean that the kernel will send the daemon a request to umount it.
> 
> In particular this code in the expire check
> 
>         /* No point expiring a pending mount */
>         if (dentry->d_flags & DCACHE_AUTOFS_PENDING)
>                 return 0;
> 
> will ensure that doesn't happen.
> There's nothing to be gained by making the daemon even more 
> complex when a simple check in the kernel can deal with the 
> occasional occurrence of this situation.

Yes, it depends on when the DCACHE_AUTOFS_PENDING bit flag is set.  If
it is not set before a wait causes the expire thread to run, then it
could manifest itself as our catastrophic race condition here.

-- snip --

Steve
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
