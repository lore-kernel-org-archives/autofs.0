From: Ian Kent <raven@themaw.net>
Subject: Re: Automounter losing track of mounts...
Date: Fri, 15 Aug 2008 11:33:16 +0800
Message-ID: <1218771198.3152.11.camel@raven.themaw.net>
References: <A2ECBF49F352C24F9DF65BB529DCBC70187A58BD@hqemmail01.nvidia.com>
	<48A33032.1060506@aei.mpg.de>
	<A2ECBF49F352C24F9DF65BB529DCBC70187A58CA@hqemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <A2ECBF49F352C24F9DF65BB529DCBC70187A58CA@hqemmail01.nvidia.com>
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
To: Stephen Biggs <sbiggs@nvidia.com>
Cc: autofs@linux.kernel.org


On Thu, 2008-08-14 at 10:19 -0700, Stephen Biggs wrote:
> > -----Original Message-----
> > From: autofs-bounces@linux.kernel.org 
> > [mailto:autofs-bounces@linux.kernel.org] On Behalf Of Carsten Aulbert
> > Sent: Wednesday, August 13, 2008 12:04 PM
> > To: autofs@linux.kernel.org
> > Subject: Re: [autofs] Automounter losing track of mounts...
> > 
> > 
> > 
> > Stephen Biggs wrote:
> > 
> > > 
> > > This seems to indicate failure to lock /etc/mtab (??) and 
> > then failing 
> > > to retry correctly, but setting its mount table as if it succeeded.
> > 
> > We had a related issue quite a bit and /etc/mtab and 
> > /proc/mounts went out of sync. Right now we are symlinking 
> > /etc/mtab to /proc/mounts. It works, but I don't know if 
> > that's the best solution for it.
> 
> Yes, we could do that and that seems to be a canonical solution that is
> even talked about in the 'man' pages.  But, there may be a problem with
> that.
> 
> Have you seen any cases where different processes are specifically
> writing either to /etc/mtab _or_ /proc/mounts in an asynchronous manner?
> Since it would now be the same file due to it being symlinked, what
> would that sort of write access do to the integrity of the mount tables?
> Would it even matter?

It doesn't matter because /proc/mounts is the in kernel representation
of the mount table and cannot be updated by user space processes.

But the issue with it for me is that it can become quite large and
confusing since autofs can use quite a few internal mounts in some
cases.

Eventually autofs won't rely on /etc/mtab at all and will
use /proc/mounts as little as possible but those patches are in the mm
kernel and I don't yet know when or if they will make it into the
mainline kernel.

Ian
