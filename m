From: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Wed, 30 Nov 2005 17:32:21 -0500
Message-ID: <1133389942.8267.7.camel@lade.trondhjem.org>
References: <20051116101740.GA9551@RAM>
	 <17292.64892.680738.833917@segfault.boston.redhat.com>
	 <1133315771.8978.65.camel@lade.trondhjem.org> <438E0C66.6040607@us.ibm.com>
	 <1133384015.8974.35.camel@lade.trondhjem.org> <438E1A05.7000308@us.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <438E1A05.7000308@us.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "William H. Taber" <wtaber@us.ibm.com>
Cc: jmoyer@redhat.com, Ram Pai <linuxram@us.ibm.com>, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

On Wed, 2005-11-30 at 16:30 -0500, William H. Taber wrote:

> > 
> > Trivially, if you have a d_revalidate that does something like
> > 
> > int autofs_revalidate(struct dentry *dentry, struct nameidata *nd)
> > {
> >   d_drop(dentry);
> >   return 0;
> > }
> > 
> > then the VFS will currently allocate a new dentry with the same name,
> > and call ->lookup() on it without dropping dir->i_sem. If you still need
> > to reference the old dentry, then put it on a private list somewhere.
> > That would also allow you to return the old dentry as the result of the
> > ->lookup() operation if that is desirable.
> 
> Problem with that, as I understand it and Ian Kent knows better than I, 
> is that the autofs lookup code creates the dentry and fills it in 
> partially and marks it as waiting for mounting and wakes up the 
> automount demon.  The demon completes the mount and finishes filling in 
> the dentry.  So we cannot have some other lookup coming in and removing 
> the dentry on us.  At least that is what I understand from Ian's answer 
> when I proposed the same sort of thing to him.

What do you mean by "removing the dentry on us"? It is perfectly
possible to have lookup() return the original dentry every time, which
is precisely what I suggested above.

>    Even if  they end up 
> doing something like that in a future version of the automounter, I 
> would still like a simple patch that can be applied to existing systems 
> as an interim fix.

"Interim" fixes to the entire VFS API such as the ones that have
proposed here tend to be a poor idea...

Cheers,
  Trond

