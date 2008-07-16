From: Chris Walker <cwalker@pixar.com>
Subject: Re: statfs() and autofs
Date: Tue, 15 Jul 2008 22:30:09 -0700
Message-ID: <20080716053008.GE5858@pixar.com>
References: <20080715204839.GU5858@pixar.com>
	<1216179794.22783.46.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <1216179794.22783.46.camel@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Thanks for your response.

In this case, it appears that statsfs triggers the mount, but returns
before the mount completes. stat waits for the automount to complete
before returning.

I would like statfs() to wait--is there a way to make it?

Thanks for all your hard work on this critical piece of software.

From raven [07/15 20:47]:
> 
> On Tue, 2008-07-15 at 13:48 -0700, Chris Walker wrote:
> > autofs 5.0.3
> > linux 2.6.18
> > 
> > When statfs() is called on an automounted directory, it returns before
> > the automount occurs. This results in output like this initially:
> 
> That may be because there are a group of system calls that don't trigger
> a mount because we have to avoid mount storms for map entries that use
> the browse option. In particular stat(2) and calls that use the same
> kernel path lookup flags, such as statfs(2).
> 
> Basically, if the mount point directory exists in the autofs file system
> but doesn't currently have a mount for some reason (perhaps it wasn't
> removed at expire or the entry uses the browse option), these calls will
> return the attributes of the autofs directory without performing a
> mount.
> 
> > 
> > % df /home/XXX
> > Filesystem           1K-blocks      Used Available Use% Mounted on
> > -                            0         0         0   -  /home
> > 
> > If df is run a second later,
> > 
> > % df /home/XXX
> > Filesystem           1K-blocks      Used Available Use% Mounted on
> > XXX:/home/XXX
> >                       80634688  77952736   2681952  97% /home/XXX
> > 
> > Perhaps there are options of which I'm not aware to mitigate this
> > behavior.
> > 
> > Apologies if the answer to my query lies elsewhere in the kernel.
> > 
> 

-- 
Chris Walker -- cwalker@pixar.com
