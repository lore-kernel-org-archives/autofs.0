From: Ian Kent <raven@themaw.net>
Subject: Re: autofs {3, 4,
	5} and bind mounts which point to other	automount points
Date: Fri, 25 Aug 2006 22:29:02 +0800
Message-ID: <1156516142.30971.35.camel@raven.themaw.net>
References: <Pine.LNX.4.64.0608241525320.1854@frank.dcs.qmul.ac.uk>
	<Pine.LNX.4.64.0608250926270.6382@raven.themaw.net>
	<Pine.LNX.4.64.0608250736190.10216@frank.dcs.qmul.ac.uk>
	<Pine.LNX.4.64.0608251506180.25004@raven.themaw.net>
	<Pine.LNX.4.64.0608251917030.30523@raven.themaw.net>
	<Pine.LNX.4.64.0608251407560.14075@frank.dcs.qmul.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0608251407560.14075@frank.dcs.qmul.ac.uk>
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
To: Matt Bernstein <+systems.extlists.autofs@dcs.qmul.ac.uk>
Cc: autofs@linux.kernel.org

On Fri, 2006-08-25 at 14:09 +0100, Matt Bernstein wrote:
> At 19:18 +0800 Ian Kent wrote:
> 
> >>> Aug 25 07:31:29 laurel automount[17274]: attempting to mount entry /homes/mb
> >>> Aug 25 07:31:29 laurel automount[17274]: mount_mount: mount(nfs): no hosts
> >>> available
> >>
> >> Mmmm ... I shouldn't be defaulting to NFS for a ":" escaped mount.
> >
> > Could you try this patch please.
> 
> Thanks.. now my messages are slightly different (though it still fails).
> 
> Aug 25 14:07:19 laurel automount[17416]: attempting to mount entry /homes/mb
> Aug 25 14:07:19 laurel automount[17416]: mount(nfs): nfs: mount failure :/home/cream/home71/mb on /homes/mb

This was broken for sure but I tested the usual cases.

Did the patch apply cleanly?

And where's the rest of the output that will tell us the mount command
that was actually used.

Send daemon.* to a log and run with debug enabled.

Ian
