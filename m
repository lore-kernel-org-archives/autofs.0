From: Ian Kent <raven@themaw.net>
Subject: Re: Proposal for map refresh logic
Date: Wed, 26 May 2004 09:37:47 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405260928360.16649@wombat.indigo.net.au>
References: <Pine.LNX.4.58.0405212143160.1592@donald.themaw.net>
	<Pine.LNX.4.58.0405210855001.28570@simba.math.ucla.edu>
	<Pine.LNX.4.58.0405221120001.1524@donald.themaw.net>
	<Pine.LNX.4.58.0405231647030.4243@xena.cft.ca.us>
	<40B3741C.9010205@sun.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40B3741C.9010205@sun.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Tue, 25 May 2004, Mike Waychison wrote:

> >
> >
> > The kernel never sees the cache.
> 
> This is further complicated as the kernel may call the readdir operation
> once per directory/map entry.
> 
> > The filesystem itself must be kept up to
> > date. Creating or removing directories during a readdir operation will
> > end in tears without a doubt.
> 
> - ->readdir itself is serialized on the parent inode's i_sem, as are all
> real_lookups (the call that makes the ->lookup callback).

Can be a problem if userspace expects to see the changes as they occur. 
Directory modification seems to cause opendir/readdir calls a bit of a 
problem for large directories. So scandir is needed instead.

> 
> >
> > But the real worry is the frequency with which this happens (as I
> > mentioned above).
> >
> > If we could just come up with a workable heuristic for map refresh we
> > would be OK.
> >
> 
> What is wrong with a cache of map keys in kernelspace? (Other than
> modifying the kernel module being a last resort)

Nothing.

This is, pretty much, the way the autofs v4 internal design is. 
It's probably not a good idea to make wholsale changes within a point 
release as well. 

Of course you are working on a different design for which this does not 
apply.

Mind, I'm likely to use a similar mechinism to fix the direct map and lazy 
mounting of multi-mount map in v4. So thanks for your fresh ideas.

Ian
