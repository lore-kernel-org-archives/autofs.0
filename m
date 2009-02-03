From: Ian Kent <raven@themaw.net>
Subject: Re: AutoFS Race Conditions?  Negative Cache?
Date: Tue, 03 Feb 2009 12:34:36 +0900
Message-ID: <1233632076.2951.32.camel@zeus.themaw.net>
References: <F76FAA9B4E7600AAC1FFA15B@ZOP-MACTEL.local>
	<1233113406.3005.21.camel@zeus.themaw.net>
	<E53DDD7AD6715F60A879D415@ZOP-MACTEL.local>
	<1233621955.2951.18.camel@zeus.themaw.net>
	<587B15FCE26A5069952E314B@ZOP-MACTEL.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <587B15FCE26A5069952E314B@ZOP-MACTEL.local>
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
To: Michael Loftis <mloftis@wgops.com>
Cc: autofs@linux.kernel.org

On Mon, 2009-02-02 at 18:05 -0700, Michael Loftis wrote:
> >
> >>
> >> Another problem I ran into was that there's no way to pass the -n flag
> >> to  mount.  I'm probably going to have to make my own autofs4 daemon
> >> packages,  but is this a feature of autofs5 daemon?  The reason I ask is
> >> the  webservers here well, linking /proc/mounts to /etc/mtab is bad for
> >> the same  reason, ls takes a few seconds (as do many other things) to
> >> execute when  there's 12k+ mounts in /etc/mtab (that might be less if we
> >> can get  timeout's to work but as we don't have any profiles on
> >> this...).  We'd need  this long term for both nfs and bind mounts.  It
> >> doesn't appear that it's  an option in autofs5 either as the call ends
> >> up being :: err = spawn_bind_mount(ap->logopt, SLOPPYOPT "-o", options,
> >>                              what, fullpath, NULL);
> >
> > Right, have a look at 5.0.4, those functions will check if /etc/mtab is
> > a link to /proc/mounts and add "-n" to the mount options if it is. I try
> > my best to keep all the individual patches for each version update (at
> > least through the v5 updates) and often they are straight forward to
> > backport.
> >
> > It's true that there are still bugs in v5, even after more than two
> > years working at it, but as far as I can tell, people generally feel
> > that v5 is much better than v4.
> 
> Yeah doing a symlink still has the same problem for us.  ls does 
> 'something' that reads /etc/mtab.  With our current script which walks our 
> NFS tree and calls mount -n --bind everything is good, so for us we just 
> need to be able to pass -n because we need a short /etc/mtab.  -- /root is 
> local btw...  and if you strace you can see it walking through /etc/mtab. 
> Other utils, like df too.  Granted once we can get timeouts working they'll 
> be a lot shorter but the delay will still be significant.  Right now it's 
> carrying ~6k mounts from the old system and the active mounts from the 
> autofs based stuff (again it's not unmounting right now because turning 
> that on caused it to become completely unstable)  No symlinks in either, 
> just a few misc files (excluded from here though).
> 

Using "-n" is likely a problem for autofs prior to 5.0.4 but would also
require the 2.6.28 kernel module patch update for the kernel you are
using and you need to tell autofs to use the newly introduced ioctl
interface otherwise it will still scan mtab from time to time, expecting
it to be up to date.

But, once the above is in place it should be possible to use a "-n" on
the mount commands without affecting autofs function. Not sure the best
way to provide that though.

Ian
