From: Ian Kent <raven@themaw.net>
Subject: Re: autofs {3, 4,
	5} and bind mounts which point to other	automount points
Date: Thu, 31 Aug 2006 18:25:20 +0800
Message-ID: <1157019921.14116.5.camel@raven.themaw.net>
References: <Pine.LNX.4.64.0608241525320.1854@frank.dcs.qmul.ac.uk>
	<Pine.LNX.4.64.0608250926270.6382@raven.themaw.net>
	<Pine.LNX.4.64.0608250736190.10216@frank.dcs.qmul.ac.uk>
	<Pine.LNX.4.64.0608251506180.25004@raven.themaw.net>
	<Pine.LNX.4.64.0608251917030.30523@raven.themaw.net>
	<Pine.LNX.4.64.0608251407560.14075@frank.dcs.qmul.ac.uk>
	<Pine.LNX.4.64.0608251417500.14075@frank.dcs.qmul.ac.uk>
	<1156516669.30971.43.camel@raven.themaw.net>
	<Pine.LNX.4.64.0608271549370.21043@raven.themaw.net>
	<1156849871.15241.9.camel@raven.themaw.net>
	<Pine.LNX.4.64.0608302028550.4441@frank.dcs.qmul.ac.uk>
	<1156994282.5281.4.camel@raven.themaw.net>
	<Pine.LNX.4.64.0608311040070.2953@frank.dcs.qmul.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0608311040070.2953@frank.dcs.qmul.ac.uk>
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

On Thu, 2006-08-31 at 10:45 +0100, Matt Bernstein wrote:
> At 11:18 +0800 Ian Kent wrote:
> 
> > On Wed, 2006-08-30 at 20:44 +0100, Matt Bernstein wrote:
> >>
> >> Your patch applied cleanlyish (just line wrapping to deal with), and now
> >> it does *most* of the right things.
> >
> > My mistake, must have broken the patch when I sent it.
> > I was able to duplicate the setup reflected in the log and the mount
> > succeeded.
> >
> > How about we try the patch again but properly formatted.
> 
> Same deal, I think :-\
> 
> Aug 31 10:37:39 laurel automount[20951]: mount(nfs): mounted cream:/export71 on /server/cream/export71
> Aug 31 10:37:39 laurel automount[20951]: send_ready: token = 2135
> Aug 31 10:37:39 laurel automount[20951]: mounted /server/cream/export71
> Aug 31 10:37:39 laurel automount[20951]: mount_mount: mount(bind): mounted /server/cream/export71/users type bind on /home/cream/home71
>                                           ^^^^^^^^^^^^^^^^^^^^^^^^
> looks good
> 
> Aug 31 10:37:39 laurel automount[20951]: send_ready: token = 2134
> Aug 31 10:37:39 laurel automount[20951]: mounted /home/cream/home71
> Aug 31 10:37:39 laurel automount[20951]: mount(nfs): nfs: mount failure :/home/cream/home71/mb on /homes/mb
>                                           ^^^^^^^^^^^^^^^
> looks less good

That's just because the nfs mount module calls the bind mount module.
If it gets a fail return from the bind mount it reports it itself.

But I don't see any fails so I don't understand where this is comming
from.

> 
> Aug 31 10:37:39 laurel automount[20951]: send_fail: token = 2133
> Aug 31 10:37:39 laurel automount[20951]: failed to mount /homes/mb
> 
> Maybe my auto.master is not right? Here are the relevant entries:

Don't this this has anything to do with this.

Ian
