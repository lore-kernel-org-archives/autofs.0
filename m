From: Ian Kent <raven@themaw.net>
Subject: Re: [RFC PATCH]autofs4: hang and proposed fix
Date: Wed, 30 Nov 2005 23:44:34 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0511302334390.2069@donald.themaw.net>
References: <20051116101740.GA9551@RAM>
	<17292.64892.680738.833917@segfault.boston.redhat.com>
	<1133315771.8978.65.camel@lade.trondhjem.org> 
	<17293.10094.111804.682032@segfault.boston.redhat.com>
	<1133331286.8195.29.camel@lade.trondhjem.org>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1133331286.8195.29.camel@lade.trondhjem.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

On Wed, 30 Nov 2005, Trond Myklebust wrote:

> On Tue, 2005-11-29 at 23:15 -0500, Jeff Moyer wrote:
> 
> > The patch only drops the semaphore if d_lookup finds the dentry and the
> > dentry has a revalidate routine.  I don't follow how you can end up with
> > multiple dentries for the same file in this case.
> > 
> > Sorry if I'm missing something obvious.
> 
> The inode->i_sem is what ensures that nobody can insert a new dentry
> between the lookup of the cached dentry by d_lookup() and the call to
> ->lookup() (which instantiates a new dentry).
> 
> Imagine you have two separate processes that are doing a __lookup_hash()
> of the same cached dentry. Now imagine that d_revalidate() of the dentry
> fails.

And that would be why lookup is only called if d_lookup fails in do_lookup 
when called from the link_path_walk routine. Do you think it is possible 
to do this safely in __lookup_hash with a similar re-ordering?

Ian
