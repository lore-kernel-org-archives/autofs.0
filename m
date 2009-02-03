From: Ian Kent <raven@themaw.net>
Subject: Re: AutoFS Race Conditions?  Negative Cache?
Date: Tue, 03 Feb 2009 09:45:55 +0900
Message-ID: <1233621955.2951.18.camel@zeus.themaw.net>
References: <F76FAA9B4E7600AAC1FFA15B@ZOP-MACTEL.local>
	<1233113406.3005.21.camel@zeus.themaw.net>
	<E53DDD7AD6715F60A879D415@ZOP-MACTEL.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E53DDD7AD6715F60A879D415@ZOP-MACTEL.local>
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

On Mon, 2009-02-02 at 14:13 -0700, Michael Loftis wrote:
> 
> --On January 28, 2009 12:30:06 PM +0900 Ian Kent <raven@themaw.net> wrote:
> 
> > It was quite a long while before we realized that a change to the VFS
> > between kernel 2.4 and 2.6 stopped the kernel module negative caching
> > from working. Trying to re-implement it in the kernel proved to be far
> > to complicated so it was eventually added to the daemon. I haven't
> > updated version 4 for a long time and don't plan to do so as the effort
> > in targeted at version 5 and has been for some time. I don't have time
> > to do both so version 5 gets the effort. Of course, if distribution
> > package maintainers want to update their packages, patches are around
> > and I can help with that effort.
> 
> I'll get ahold of the Debian (kernel and autofs) maintainer email addresses 
> and ask them about that.  It's not that I/we can't maintain our own kernels 
> and autofs packages, it's just that (atleast for the kernel) it's a pretty 
> high work load on an already thin staff.

Understood.

> 
> > There are other problems with the kernel module in 2.6.18 that appear to
> > give similar symptoms as well. You could try patching the kernel with
> > the latest autofs4 kernel module patches, which can be found in the
> > current version 5 tarball. There is still one issue that I'm aware of
> > that affects version 4 specifically, but I can't yet duplicate it and so
> > can't check if a fix would introduce undesirable side effects.
> 
> I understand that.  I'm having trouble reproducing this one except under 
> load, which is why I decided it's probably some sort of race condition. 
> And it goes away when i set timeout=0.  I'm betting though that with 
> 'current' autofs4 module it may not happen or with 'current' daemon and 
> module. I tried to get autofs5 debian package from sid/lenny (debian 
> unstable/testing) to compile but because it's using some symbols that don't 
> exist in ldap.h from openldap 2.1 it won't compile for Debian 4.0 without a 
> little bit of massaging.

What are the symbols?
Send over the compile breakage output or the Debian source package (I
can probably check it out on my Ubuntu test machine).

> 
> Another problem I ran into was that there's no way to pass the -n flag to 
> mount.  I'm probably going to have to make my own autofs4 daemon packages, 
> but is this a feature of autofs5 daemon?  The reason I ask is the 
> webservers here well, linking /proc/mounts to /etc/mtab is bad for the same 
> reason, ls takes a few seconds (as do many other things) to execute when 
> there's 12k+ mounts in /etc/mtab (that might be less if we can get 
> timeout's to work but as we don't have any profiles on this...).  We'd need 
> this long term for both nfs and bind mounts.  It doesn't appear that it's 
> an option in autofs5 either as the call ends up being ::
>                 err = spawn_bind_mount(ap->logopt,
>                              SLOPPYOPT "-o", options, what, fullpath, NULL);

Right, have a look at 5.0.4, those functions will check if /etc/mtab is
a link to /proc/mounts and add "-n" to the mount options if it is. I try
my best to keep all the individual patches for each version update (at
least through the v5 updates) and often they are straight forward to
backport.

It's true that there are still bugs in v5, even after more than two
years working at it, but as far as I can tell, people generally feel
that v5 is much better than v4.

> 
> >
> >>
> >> for ex (actual domain name changed to protect bystanders):  (in
> >> /proc/mounts)
> >> nfs0:/www/vhosts/l /d1/l/luserdomain.org/logs nfs
> >> rw,vers=3,rsize=8192,wsize=8192,hard,intr,proto=udp,timeo=11,retrans=2,s
> >> ec=sys,addr=nfs0  0 0
> >> /dev/hda3 /d1/l/luserdomain.org/logs/.renv ext3 rw,noatime,data=ordered
> >> 0 0
> >>
> >>
> >> == auto.master ==
> >> /d1/0 /etc/auto.jail -strict -DH=0
> >> /d1/1 /etc/auto.jail -strict -DH=1
> >> ...
> >> /d1/z /etc/auto.jail -strict -DH=z
> >>
> >> == auto.jail ==
> >> *	/	:/www/vhosts/${H}/& /.renv :/opt/jail
> >
> > I don't know where these mounts are coming from.
> > It doesn't look right but we don't know as we don't have a debug log to
> > refer to.
> 
> I did try that, but there just isn't fast enough disks to get the condition 
> to happen and get the logs.  I'll poke with it a bit more though and see if 
> I can get any more useful information, my hunch is it's a race condition on 
> the umount call(s) somehow with multi-mounts.
> 
> 
