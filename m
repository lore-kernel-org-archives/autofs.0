From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Wed, 30 Nov 2005 09:48:42 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0511300947560.32520@wombat.indigo.net.au>
References: <20051116101740.GA9551@RAM> <17292.64892.680738.833917@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <17292.64892.680738.833917@segfault.boston.redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Ram Pai <linuxram@us.ibm.com>, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

On Tue, 29 Nov 2005, Jeff Moyer wrote:

> ==> Regarding [autofs] [RFC PATCH]autofs4: hang and proposed fix; linuxram@us.ibm.com (Ram Pai) adds:
> 
> linuxram> Autofs4 assumes that its ->revalidate() function gets called with
> linuxram> the parent_dentry's_inode_semaphore released. This is true mostly
> linuxram> but not in one particular case.
> 
> linuxram> Process P1 calls autofs4's ->lookup(). The lookup finds that the
> linuxram> dentry does not exist. It creates a dentry and adds to the
> linuxram> cache. Releases the parent's inode's semaphore and than calls
> linuxram> ->revalidate().
> 
> linuxram> Process P2 meanwhile comes in and cached_lookup() gets called. It
> linuxram> finds the dentry in the cache and finds ->revalidate() function
> linuxram> exists. So it calls ->revalidate() holding the parent's inode's
> linuxram> semaphore.
> 
> Can't we simply fix this case?  It seems like it should be perfectly safe
> to drop the parent's i_sem before calling revalidate in cached_lookup.  In
> fact, there are comments in the NFS code that would lead one to believe
> that revalidate is not supposed to be called with the parent's i_sem held:
> 
> static int nfs_lookup_revalidate(struct dentry * dentry, struct nameidata *nd)
> {
> ...
> 	/*
> 	 * Note: we're not holding inode->i_sem and so may be racing with
> 	 * operations that change the directory. We therefore save the
> 	 * change attribute *before* we do the RPC call.
> 	 */
> 
> Can you try out a patch which does this?

Could it be as simple as that?
Food for more thought.

Ian

