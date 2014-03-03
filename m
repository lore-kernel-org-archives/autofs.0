From: Ian Kent <raven@themaw.net>
Subject: Re: "Too many levels of symbolic links"
Date: Mon, 03 Mar 2014 10:40:02 +0800
Message-ID: <1393814402.2787.19.camel@perseus.fritz.box>
References: <1391145206.2486.25.camel@perseus.fritz.box>
		 <52EB7694.20707@molgen.mpg.de> <52EB7B07.2070707@molgen.mpg.de>
		 <530484B7.6030305@molgen.mpg.de>
		 <1392896501.2508.16.camel@perseus.fritz.box>
		 <1392898704.2508.26.camel@perseus.fritz.box>
		 <530625D0.7020808@molgen.mpg.de>
		 <1392946952.2495.3.camel@perseus.fritz.box>
		 <53076D91.7050703@molgen.mpg.de> <53107D4A.90904@molgen.mpg.de>
		 <20140228132906.GM15017@sh-el6.eng.rdu2.redhat.com>
		 <1393726942.9725.5.camel@perseus.fritz.box>
	 <1393744241.9725.16.camel@perseus.fritz.box>
	 <5313467C.9080102@molgen.mpg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=4c0+1x7gfIYK/L32YCxH6XGPDfE=; b=J+F74N8jo3aLfEJdgMtAgEG0yWZK
	S/1W7W/vqR1lV6MNYd14UW8vV30b3AmYP4MTpyEEPDgqWBx5lAGA22rurLHlwSv8
	QhCEyJ80mhB9ZOC1TeP27jtUkBtbetWruyMlV9WtdvN/Vh3+U1BkCDaPckWMPWvr
	CzlVi0AJ88SQZzY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=4c0+1x7gfIYK/L32YCxH6X
	GPDfE=; b=T7LM7cZONFAvJwQqSrBqfWBCshXugHkHZUGoCSLiCKrORDRTJXBpW4
	mr2h3cY4WLPPIYPRsbWwT0OTOXG1EtFV6oGsyyGSPdFrDReLm3qomZ8XtBbWtvW9
	k43Y+Oi53yWVABZOf51LUyw1zEhGswxY1YyNnVwNWKSU6OiX0X5eI=
In-Reply-To: <5313467C.9080102@molgen.mpg.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: Alexander Viro <aviro@redhat.com>, autofs <autofs@vger.kernel.org>

On Sun, 2014-03-02 at 15:55 +0100, Donald Buczek wrote:
> Am 02.03.2014 08:10, schrieb Ian Kent:
> > On Sun, 2014-03-02 at 10:22 +0800, Ian Kent wrote:
> >> On Fri, 2014-02-28 at 08:29 -0500, Alexander Viro wrote:
> >>> On Fri, Feb 28, 2014 at 01:12:58PM +0100, Donald Buczek wrote:
> >>>
> >>>> Obviously, "cleared mounted on dentry" is missing.
> >>>>
> >>>> It looks like we enter put_mountpoint() but don't get to
> >>>> dentry->d_flags &= ~DCACHE_MOUNTED;
> >>>>
> >>>> mp->m_count is not zero probably.
> >>>>
> >>>> What does it mean? The mount is still locked but not in the mount hash?
> >>> No, it means that something else is mounted on the same dentry (in another
> >>> part of mount tree, obviously).
> >>>
> >>> If you mount the same fs on two different mountpoints, e.g.
> >>> mount /dev/sda1 /mnt
> >>> mount /dev/sda1 /tmp/foo
> >>> you will have the same dentries seen in two places.  Now,
> >>> mount /dev/sdb11 /mnt/a
> >>> mount /dev/sdc5 /tmp/foo/a
> >>>
> >>> and you've got two different filesystems mounted on two different places
> >>> (/mnt/a and /tmp/foo/a).  These two places have different vfsmounts,
> >>> but the same dentry.  struct mountpoint is associated with dentry, so
> >>> it's also the same for both.  And it serves as a mountpoint for two
> >>> vfsmounts - one for fs from sdb11, another for fs from sdc5.
> >>>
> >>> Now umount /mnt/a; one of those two vfsmounts is gone now.  struct mountpoint
> >>> survives, of course, and dentry is *still* a mountpoint.  sdc5 is still
> >>> mounted on /tmp/foo/a, after all...
> > Good example but for autofs file systems doesn't this amount to saying
> > its been bound somewhere else?
> >
> > Illegal as far as autofs is concerned because an autofs mount is
> > strictly associated with a path defined by its map.
> >
> > And, yes, bind mounting an autofs file system elsewhere isn't vetoed by
> > the kernel.
> >
> > This makes be start thinking about implications wrt. containers ....
> >
> >> Ahh, right ... I'll need to think about my use (misuse) of
> >> d_mountpoint().
> > So maybe I don't need to worry about this just yet.

I think you've hit on almost all the current problems I'm struggling
with and adds to it, ;)

> 
> I think you should, because exactly this is the bug.
> d_mountpoint(dentry) just says, that we have a struct mountpoint for the 
> dentry. It does not say, that the path is mounted in the current 
> namespace. The struct mountpoint might exists, because the path is 
> mounted in other namespaces but not ours.

Yes, and this adds a new case to the list of problems.

> 
> The problem at our site is clear now:
> 
> We have only one service with PrivateTmp=yes which is colord.service. 
> And here is the missing mount:
> 
> > root:kasslerbraten:/lib/systemd/system/# ps -Af|fgrep colord
> > root      7670     1  0 Feb28 ?        00:00:00 /usr/lib/colord/colord
> > root      7897  7329  0 14:46 pts/8    00:00:00 fgrep colord
> > root:kasslerbraten:/lib/systemd/system/# cat /proc/7670/mounts|grep 
> > mariux32
> > pille:/amd/pille/1/project/mariux32 /project/mariux32 nfs 
> > rw,nosuid,relatime,vers=3,rsize=524288,wsize=524288,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=141.14.28.250,mountvers=3,mountport=56263,mountproto=udp,local_lock=none,addr=141.14.28.250 
> > 0 0
> 
> colord.service is dbus-started. So it is started quiet randomly and 
> depending on user usage pattern, mostly but not exclusively on 
> workstations. That is exactly how we've seen the bug to appear.
> 
> When the services is started, systemd uses unshare(CLONE_NEWNS) to clone 
> the namespace. This new namespace inherits existing mounts, including 
> automounted ones.
> These mounts might eventually expire at a later time. When this occurs, 
> they are dismounted from the automount daemons namespace, which is the 
> global, pid 1 namespace. But because they are still mounted in another 
> namespace, the dentry stays flagged as DCACHE_MOUNTED, which prevents 
> autofs to remount it on access. The mount, however, just exists in 
> another namespace and is useless for anybody else.

Useless yes, but there is currently no way to mount something so that it
won't be propagated. No, MS_PRIVATE says "I'm private don't propagate my
children". To add a flag to do this isn't a simple task either AFAICS.

And then there are those that explicitly want the propagation and expect
it to work. I think they will eventually be disappointed.

> 
> Final prove, that this is the true story:
> 
> > root:kasslerbraten:/lib/systemd/system/# ls /project/mariux32
> > ls: cannot open directory /project/mariux32: Too many levels of 
> > symbolic links
> > root:kasslerbraten:/lib/systemd/system/# kill -9 7670
> > root:kasslerbraten:/lib/systemd/system/# ls /project/mariux32
> > beeroot  home  i686  svnroot
> > root:kasslerbraten:/lib/systemd/system/#
> 
> Of course, I can easily work around that in our environment (eg. just 
> remove PrivateTmp=yes from the service). So I'm pretty sure, it will 
> work for me now.
> The bug, however, is in autofs. systemd is doing perfectly legal 
> user-mode things.
> 
> Perhaps autofs should use lookup_mnt()  to decide along this pattern:
> 
> if ( dentry->d_flags & DCACHE_MOUNTED && lookup_mnt(path)  ) {
>    /* mounted */
> } else {
>    /* not mounted */
> }

Also, not as simple as you might think.

First lookup_mnt() isn't exported and I believe the preference is that,
that doesn't change. But follow_down_one() is exported and could be
used.

Next, it would involve changing the function signature of a dentry
operation function. That function could be used by other modules that we
don't know about and they would break.

> 
> That doesn't solve the problem, however, that mounts cloned by a 
> unshare(CLONE_NEWNS) would never expire. Also there is another bug 
> somewhere, because I see, that the mount, visible to the 
> /usr/lib/colord/colord process was logged as "unmounted" in the nfs 
> server when it expired in the global namespace. So I doubt it would be 
> working even for that process. So possibly automounted mounts shouldn't 
> be cloned at all? Together with chroot or pivot_root the sematics would 
> be more than unclear anyway. Your problem now :-)

Hehe, like I said some people are going to be disappointed.

There's just one question about this that remains.

Assuming systemd is setting "/" shared what happens if "mount
--make-rprivate /" is run before autofs is started?

So if you can spend a little more time on this an answer to this would
be helpful.

> 
> Thanks for you help with this!

Actually, thank you.
This investigation has given me quite a bit of new insight into the
current difficulties I have with namespace handling.

Ian


