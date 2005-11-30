From: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Wed, 30 Nov 2005 15:53:35 -0500
Message-ID: <1133384015.8974.35.camel@lade.trondhjem.org>
References: <20051116101740.GA9551@RAM>
	 <17292.64892.680738.833917@segfault.boston.redhat.com>
	 <1133315771.8978.65.camel@lade.trondhjem.org> <438E0C66.6040607@us.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <438E0C66.6040607@us.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "William H. Taber" <wtaber@us.ibm.com>
Cc: jmoyer@redhat.com, Ram Pai <linuxram@us.ibm.com>, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

On Wed, 2005-11-30 at 15:32 -0500, William H. Taber wrote:

> Not only is there this case, but the original premise is wrong as well. 
>   There is a second case in which a d_revalidate function is called with 
> the parent i_sem and that is when it is called from inside of 
> lookup_one_len.  What makes this tricky is that lookup_one_len is called 
> from nfs_sillyrename from inside of nfs_rename which is called, 
> naturally enough by sys_rename.  The rename code is very careful about 
> the order in which it obtains the parent semaphores because it needs to 
> get two of them.  It must always obtain the locks in the same order so 
> that does not get into a deadly embrace.  If we start arbitrarily 
> releasing a parent semaphore in cached_lookup and taking it again after 
> the revalidate, we risk breaking the lock ordering and creating a deadly 
> embrace.
> 
> When I started writing this I thought that it would be safe for the 
> autofs revalidate code to release the parent semaphore because they do 
> not have a rename callback.  But I looked again at the rename code and 
> it calls lookup_hash on the final source and destination files after 
> locking the parents so the potential for a deadly embrace still exists 
> unless there is some other assurance that these final lookups will never 
> pend waiting on the automounter in either their revalidate or lookup 
> routines.  (Actually the requirement is that they never give up the 
> parent i_sem lock, but the lookup code has to give up the lock so that 
> the autofs demon can run and perform the mount so it amounts to the same 
> thing.)
> 
> The same issue exists for devfs which also releases the parent i_sem 
> lock so that it can wait inside its revalidation routine.

So exactly why does autofs4 want to hold the dir->i_sem in d_revalidate
in the first place? Can't we move any code that requires dir->i_sem to
be held into a ->lookup() method?

Trivially, if you have a d_revalidate that does something like

int autofs_revalidate(struct dentry *dentry, struct nameidata *nd)
{
  d_drop(dentry);
  return 0;
}

then the VFS will currently allocate a new dentry with the same name,
and call ->lookup() on it without dropping dir->i_sem. If you still need
to reference the old dentry, then put it on a private list somewhere.
That would also allow you to return the old dentry as the result of the
->lookup() operation if that is desirable.

Cheers,
  Trond

