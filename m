From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Thu, 1 Dec 2005 00:12:34 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0511302358370.2069@donald.themaw.net>
References: <20051116101740.GA9551@RAM>  <17292.64892.680738.833917@segfault.boston.redhat.com>
  <1133315771.8978.65.camel@lade.trondhjem.org> 
 <17293.10094.111804.682032@segfault.boston.redhat.com> 
 <1133331286.8195.29.camel@lade.trondhjem.org>  <Pine.LNX.4.63.0511302334390.2069@donald.themaw.net>
 <1133366016.8625.19.camel@lade.trondhjem.org>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1133366016.8625.19.camel@lade.trondhjem.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: jmoyer@redhat.com, Ram Pai <linuxram@us.ibm.com>, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

On Wed, 30 Nov 2005, Trond Myklebust wrote:

> On Wed, 2005-11-30 at 23:44 +0800, Ian Kent wrote:
> > On Wed, 30 Nov 2005, Trond Myklebust wrote:
> > 
> > > On Tue, 2005-11-29 at 23:15 -0500, Jeff Moyer wrote:
> > > 
> > > > The patch only drops the semaphore if d_lookup finds the dentry and the
> > > > dentry has a revalidate routine.  I don't follow how you can end up with
> > > > multiple dentries for the same file in this case.
> > > > 
> > > > Sorry if I'm missing something obvious.
> > > 
> > > The inode->i_sem is what ensures that nobody can insert a new dentry
> > > between the lookup of the cached dentry by d_lookup() and the call to
> > > ->lookup() (which instantiates a new dentry).
> > > 
> > > Imagine you have two separate processes that are doing a __lookup_hash()
> > > of the same cached dentry. Now imagine that d_revalidate() of the dentry
> > > fails.
> > 
> > And that would be why lookup is only called if d_lookup fails in do_lookup 
> > when called from the link_path_walk routine. Do you think it is possible 
> > to do this safely in __lookup_hash with a similar re-ordering?
> 
> 2.4 kernels did a second d_lookup() after retaking the i_sem. The
> problem is what do you do in the case of a race: you either have to loop
> back (may lead to infinite loops of d_lookup()+d_invalidate()) or you do
> something like retry once, then return an error (which is what 2.4
> kernels did).

But in this case the semaphore is already held up until the revalidate so 
I guess the concern is that the dentry goes away after releasing the 
semaphore?

btw, a little aside.
I'm having trouble understanding where EEXIST is returned in a call such 
as sys_mkdir. Can you help?

If a call such as sys_mkdir (perhaps in lookup_create) was able to 
determine the directory exists before taking the semaphore the problem we 
have here goes away.

> 
> Either choice is unsatisfying which is (I assume) why the current
> behaviour was chosen for 2.6 kernels.
> 
> Cheers,
>   Trond
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

