From: Ian Kent <raven@themaw.net>
Subject: Re: [RFC PATCH]autofs4: hang and proposed fix
Date: Sun, 4 Dec 2005 22:54:35 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0512042252200.31847@donald.themaw.net>
References: <20051116101740.GA9551@RAM>
	<17292.64892.680738.833917@segfault.boston.redhat.com>
	<1133315771.8978.65.camel@lade.trondhjem.org>
	<438E0C66.6040607@us.ibm.com>
	<1133384015.8974.35.camel@lade.trondhjem.org>
	<438E1A05.7000308@us.ibm.com>
	<Pine.LNX.4.63.0512011917010.3189@donald.themaw.net>
	<438F251B.7060602@us.ibm.com>
	<Pine.LNX.4.63.0512022059350.2070@donald.themaw.net>
	<17296.28812.390586.101214@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0512030131240.2632@donald.themaw.net>
	<4390938E.3050502@us.ibm.com>
	<Pine.LNX.4.63.0512041740480.1564@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0512041740480.1564@donald.themaw.net>
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
To: Will Taber <wtaber@us.ibm.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Trond Myklebust <trond.myklebust@fys.uio.no>

On Sun, 4 Dec 2005, Ian Kent wrote:

> On Fri, 2 Dec 2005, Will Taber wrote:
> 
> > > > 
> > > > Well, I think we've determined that the reported problem doesn't happen
> > > > with any in-tree callers.  The question, then, is do you want to fix the
> > > > locking problem?  Two approaches were presented in this thread.  I don't
> > > > really like the idea of the hack used by devfs, since it relies on
> > > > implicit
> > > > semantics.  I haven't given much thought to the second approach, though
> > > > (are we sure it can be made to work?).  It may require a good deal of
> > > > effort, but if it makes things work properly, it's worth considering.  I'm
> > > > just not sure where it sits in the list of priorities, as I know you've
> > > > got
> > > > a lot on your plate, Ian.
> > > 
> > > 
> > > It appears to me that the unhashed directory approach proposed by Will does
> > > not account for directories that exist but don't have current mounts.
> > > 
> > > I will re-read the posts, I expect I missed something, and give it more
> > > thought.
> > > 
> > It doesn't consider that case.  You had mentioned it but I had forgotten.
> > 
> 
> OK so I decided to give Wills recommendation a bit of a run and I've come 
> up with a first cut patch which of course doesn't work.
> 
> The approach is to force all callbacks to go through lookup instead of 
> some through revalidate as well. The patch basically posts the dentry to a 
> pending list and unhashs it, then picks it up from the list in the lookup 
> and rehash it. Should be fairly simple really but I'm doing something 
> obviously wrong somewhere.
> 
> I'm seeing slab corruption and I really can't see why this should be the 
> case. Anyone got any ideas. The patch is against 2.6.15-rc1 but the kernel 
> I'm compliling against is a RedHat patched 2.6.11 (Aurora).
> 

Interestingly it seems to function OK on my Intel FC3 box?

And the patch only deals with the revalidate and lookup logic, the readdir 
stuff will need to be reworked as well.

Ian
