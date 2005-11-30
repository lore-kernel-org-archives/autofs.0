From: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Wed, 30 Nov 2005 01:14:46 -0500
Message-ID: <1133331286.8195.29.camel@lade.trondhjem.org>
References: <20051116101740.GA9551@RAM>
	 <17292.64892.680738.833917@segfault.boston.redhat.com>
	 <1133315771.8978.65.camel@lade.trondhjem.org>
	 <17293.10094.111804.682032@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <17293.10094.111804.682032@segfault.boston.redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: jmoyer@redhat.com
Cc: Ram Pai <linuxram@us.ibm.com>, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

On Tue, 2005-11-29 at 23:15 -0500, Jeff Moyer wrote:

> The patch only drops the semaphore if d_lookup finds the dentry and the
> dentry has a revalidate routine.  I don't follow how you can end up with
> multiple dentries for the same file in this case.
> 
> Sorry if I'm missing something obvious.

The inode->i_sem is what ensures that nobody can insert a new dentry
between the lookup of the cached dentry by d_lookup() and the call to
->lookup() (which instantiates a new dentry).

Imagine you have two separate processes that are doing a __lookup_hash()
of the same cached dentry. Now imagine that d_revalidate() of the dentry
fails.


Process 1                                 Process 2

__lookup_hash("/foo", "bar")		__lookup_hash("/foo", "bar")
...					....
down(&inode->i_sem)
....
<enter cached_lookup("/foo","bar")>
....
dentry = d_lookup("/foo", "bar")
up(&inode->i_sem)
					down(&inode->i_sem)
					....
					<enters cached_lookup("/foo","bar")>
d_revalidate(dentry) (fails)		dentry = d_lookup("/foo","bar")
					up(&inode->i_sem)

down(&inode->i_sem)			d_revalidate(dentry); (fails)
...
<returns NULL to __lookup_hash>
....
dentry = d_alloc(parent,name)
->lookup(dentry) (instantiates "dentry")
up(&inode->i_sem)
					down(&inode->i_sem)
					....
					<returns NULL to __lookup_hash>
					....
					dentry = d_alloc(parent,name)
					->lookup(dentry) (instantiates "dentry")
....

Whoops. Suddenly you have called ->lookup() for 2 dentries that
represent the same filename in the same directory.

Cheers,
  Trond

