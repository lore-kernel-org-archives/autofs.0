From: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Wed, 30 Nov 2005 11:45:22 -0500
Message-ID: <1133369123.8625.28.camel@lade.trondhjem.org>
References: <20051116101740.GA9551@RAM>
	 <17292.64892.680738.833917@segfault.boston.redhat.com>
	 <1133315771.8978.65.camel@lade.trondhjem.org>
	 <17293.10094.111804.682032@segfault.boston.redhat.com>
	 <1133331286.8195.29.camel@lade.trondhjem.org>
	 <Pine.LNX.4.63.0511302334390.2069@donald.themaw.net>
	 <1133366016.8625.19.camel@lade.trondhjem.org>
	 <Pine.LNX.4.63.0511302358370.2069@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0511302358370.2069@donald.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: jmoyer@redhat.com, Ram Pai <linuxram@us.ibm.com>, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

On Thu, 2005-12-01 at 00:12 +0800, Ian Kent wrote:

> > 2.4 kernels did a second d_lookup() after retaking the i_sem. The
> > problem is what do you do in the case of a race: you either have to loop
> > back (may lead to infinite loops of d_lookup()+d_invalidate()) or you do
> > something like retry once, then return an error (which is what 2.4
> > kernels did).
> 
> But in this case the semaphore is already held up until the revalidate so 
> I guess the concern is that the dentry goes away after releasing the 
> semaphore?

The problem is the same: dealing with the case of someone else
populating the d_cache while you have temporarily dropped the
dir->i_sem.

> btw, a little aside.
> I'm having trouble understanding where EEXIST is returned in a call such 
> as sys_mkdir. Can you help?

The call to may_create() (at the top of vfs_mkdir()) will return EEXIST
if the dentry is already positive i.e. dentry->d_inode is non-null.

Cheers,
  Trond

