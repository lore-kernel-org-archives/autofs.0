From: "William H. Taber" <wtaber@us.ibm.com>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Thu, 01 Dec 2005 11:30:19 -0500
Message-ID: <438F251B.7060602@us.ibm.com>
References: <20051116101740.GA9551@RAM>  <17292.64892.680738.833917@segfault.boston.redhat.com>  <1133315771.8978.65.camel@lade.trondhjem.org> <438E0C66.6040607@us.ibm.com> <1133384015.8974.35.camel@lade.trondhjem.org> <438E1A05.7000308@us.ibm.com> <Pine.LNX.4.63.0512011917010.3189@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0512011917010.3189@donald.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, Jeff Moyer <jmoyer@redhat.com>, Ram Pai <linuxram@us.ibm.com>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

Ian Kent wrote:
> On Wed, 30 Nov 2005, William H. Taber wrote:
> 
> 
>>Trond Myklebust wrote:
>>
>>>On Wed, 2005-11-30 at 15:32 -0500, William H. Taber wrote:
>>>
>>>
>>>
>>>>Not only is there this case, but the original premise is wrong as well.
>>>>There is a second case in which a d_revalidate function is called with the
>>>>parent i_sem and that is when it is called from inside of lookup_one_len.
>>>>What makes this tricky is that lookup_one_len is called from
>>>>nfs_sillyrename from inside of nfs_rename which is called, naturally
>>>>enough by sys_rename.  The rename code is very careful about the order in
>>>>which it obtains the parent semaphores because it needs to get two of
>>>>them.  It must always obtain the locks in the same order so that does not
>>>>get into a deadly embrace.  If we start arbitrarily releasing a parent
>>>>semaphore in cached_lookup and taking it again after the revalidate, we
>>>>risk breaking the lock ordering and creating a deadly embrace.
>>>>
>>>>When I started writing this I thought that it would be safe for the autofs
>>>>revalidate code to release the parent semaphore because they do not have a
>>>>rename callback.  But I looked again at the rename code and it calls
>>>>lookup_hash on the final source and destination files after locking the
>>>>parents so the potential for a deadly embrace still exists unless there is
>>>>some other assurance that these final lookups will never pend waiting on
>>>>the automounter in either their revalidate or lookup routines.  (Actually
>>>>the requirement is that they never give up the parent i_sem lock, but the
>>>>lookup code has to give up the lock so that the autofs demon can run and
>>>>perform the mount so it amounts to the same thing.)
>>>>
>>>>The same issue exists for devfs which also releases the parent i_sem lock
>>>>so that it can wait inside its revalidation routine.
>>>
>>>
>>>So exactly why does autofs4 want to hold the dir->i_sem in d_revalidate
>>>in the first place? Can't we move any code that requires dir->i_sem to
>>>be held into a ->lookup() method?
>>
>>It's not that d_revalidate wants or doesn't want to hold the lock.  The caller
>>of lookup_one_len is required to get the lock and this function calls
>>lookup_hash which calls cached_lookup which calls d_revalidate.
>>
>>
>>>Trivially, if you have a d_revalidate that does something like
>>>
>>>int autofs_revalidate(struct dentry *dentry, struct nameidata *nd)
>>>{
>>>  d_drop(dentry);
>>>  return 0;
>>>}
>>>
>>>then the VFS will currently allocate a new dentry with the same name,
>>>and call ->lookup() on it without dropping dir->i_sem. If you still need
>>>to reference the old dentry, then put it on a private list somewhere.
>>>That would also allow you to return the old dentry as the result of the
>>>->lookup() operation if that is desirable.
>>
>>Problem with that, as I understand it and Ian Kent knows better than I, is
>>that the autofs lookup code creates the dentry and fills it in partially and
>>marks it as waiting for mounting and wakes up the automount demon.  The demon
>>completes the mount and finishes filling in the dentry.  So we cannot have
>>some other lookup coming in and removing the dentry on us.  At least that is
>>what I understand from Ian's answer when I proposed the same sort of thing to
>>him.   Even if  they end up doing something like that in a future version of
>>the automounter, I would still like a simple patch that can be applied to
>>existing systems as an interim fix.
> 
> 
> Lets see if I can keep this explaination simple.
> 
> The user space process using the autofs filesystem (autodir or automount) 
> needs to be able to call mkdir at mount time as a result of a callback 
> from revalidate. Sometimes this comes indirectly from lookup (if the 
> directory does not already exist).
> 
> lookup_one_len requires the i_sem to be held so two instances of a 
> filesystem calling it lead to a deadlock when mkdir is called from 
> userspace (the third process). In the case we are discussing this happens 
> because the first process calls lookup which releases the i_sem and 
> calls revalidate itself. The second calls revalidate which doesn't release 
> the i_sem and is places on a wait queue for mount completion. Consequently 
> the mkdir blocks.
> 
> So the requirement is that autofs release the i_sem during the callback, 
> not obtain it.
> 
> Will believes that it is not safe for autofs to release i_sem for 
> the callback to user space because it is possible that path that aquired 
> it may not be the path that has called revalidate and I can see his point.
> 
> Never the less I'm still not convinced that this is possible given the 
> restrictions of autofs.
> 
> Let me try and describe this, hopefully more clearly than I've done so 
> far.
> 
> The only operations defined for autofs are:
> 
> mkdir, rmdir, symlink and unlink 
> 
> and the only processes that can do these operations must be in the same 
> process group that mounted the filesystem. EACCESS is returned for all 
> other processes attempting these operations.
> 
> The other functionality is read-only (and perhaps triggers a mount) 
> being lookup, revalidate and readdir.
> 
> So the question is, can anyone provide an example of a path that, upon 
> calling autofs revalidate or lookup with the i_sem held, not be the path 
> that aquired it?

Any other process calling lookup_one_len on a file in /net.

Will
