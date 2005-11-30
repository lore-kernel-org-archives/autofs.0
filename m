From: "William H. Taber" <wtaber@us.ibm.com>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Wed, 30 Nov 2005 15:32:38 -0500
Message-ID: <438E0C66.6040607@us.ibm.com>
References: <20051116101740.GA9551@RAM>	 <17292.64892.680738.833917@segfault.boston.redhat.com> <1133315771.8978.65.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1133315771.8978.65.camel@lade.trondhjem.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: jmoyer@redhat.com, Ram Pai <linuxram@us.ibm.com>, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

Trond Myklebust wrote:
> On Tue, 2005-11-29 at 20:16 -0500, Jeff Moyer wrote:
> 
>>==> Regarding [autofs] [RFC PATCH]autofs4: hang and proposed fix; linuxram@us.ibm.com (Ram Pai) adds:
>>
>>linuxram> Autofs4 assumes that its ->revalidate() function gets called with
>>linuxram> the parent_dentry's_inode_semaphore released. This is true mostly
>>linuxram> but not in one particular case.
>>
>>linuxram> Process P1 calls autofs4's ->lookup(). The lookup finds that the
>>linuxram> dentry does not exist. It creates a dentry and adds to the
>>linuxram> cache. Releases the parent's inode's semaphore and than calls
>>linuxram> ->revalidate().
>>
>>linuxram> Process P2 meanwhile comes in and cached_lookup() gets called. It
>>linuxram> finds the dentry in the cache and finds ->revalidate() function
>>linuxram> exists. So it calls ->revalidate() holding the parent's inode's
>>linuxram> semaphore.
>>
>>Can't we simply fix this case?  It seems like it should be perfectly safe
>>to drop the parent's i_sem before calling revalidate in cached_lookup.  In
>>fact, there are comments in the NFS code that would lead one to believe
>>that revalidate is not supposed to be called with the parent's i_sem held:
>>
>>static int nfs_lookup_revalidate(struct dentry * dentry, struct nameidata *nd)
>>{
>>...
>>	/*
>>	 * Note: we're not holding inode->i_sem and so may be racing with
>>	 * operations that change the directory. We therefore save the
>>	 * change attribute *before* we do the RPC call.
>>	 */
>>
>>Can you try out a patch which does this?
>>
>>-Jeff
>>
>>--- linux-2.6.14/fs/namei.c.orig	2005-11-29 20:14:30.000000000 -0500
>>+++ linux-2.6.14/fs/namei.c	2005-11-29 20:14:48.000000000 -0500
>>@@ -332,10 +332,12 @@ static struct dentry * cached_lookup(str
>> 		dentry = d_lookup(parent, name);
>> 
>> 	if (dentry && dentry->d_op && dentry->d_op->d_revalidate) {
>>+		up(&parent->d_inode->i_sem);
>> 		if (!dentry->d_op->d_revalidate(dentry, nd) && !d_invalidate(dentry)) {
>> 			dput(dentry);
>> 			dentry = NULL;
>> 		}
>>+		down(&parent->d_inode->i_sem);
>> 	}
>> 	return dentry;
>> }
> 
> 
> Woah! Definitely not safe. NFS might not care, but the VFS will
> certainly barf over that!
> 
> By dropping the dir->i_sem in cached_lookup() you are allowing 2
> processes to allocate and lookup multiple dentries for the same file
> inside __lookup_hash().
> 
> Cheers,
>   Trond
Not only is there this case, but the original premise is wrong as well. 
  There is a second case in which a d_revalidate function is called with 
the parent i_sem and that is when it is called from inside of 
lookup_one_len.  What makes this tricky is that lookup_one_len is called 
from nfs_sillyrename from inside of nfs_rename which is called, 
naturally enough by sys_rename.  The rename code is very careful about 
the order in which it obtains the parent semaphores because it needs to 
get two of them.  It must always obtain the locks in the same order so 
that does not get into a deadly embrace.  If we start arbitrarily 
releasing a parent semaphore in cached_lookup and taking it again after 
the revalidate, we risk breaking the lock ordering and creating a deadly 
embrace.

When I started writing this I thought that it would be safe for the 
autofs revalidate code to release the parent semaphore because they do 
not have a rename callback.  But I looked again at the rename code and 
it calls lookup_hash on the final source and destination files after 
locking the parents so the potential for a deadly embrace still exists 
unless there is some other assurance that these final lookups will never 
pend waiting on the automounter in either their revalidate or lookup 
routines.  (Actually the requirement is that they never give up the 
parent i_sem lock, but the lookup code has to give up the lock so that 
the autofs demon can run and perform the mount so it amounts to the same 
thing.)

The same issue exists for devfs which also releases the parent i_sem 
lock so that it can wait inside its revalidation routine.

Will
