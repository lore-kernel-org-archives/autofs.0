From: Ian Kent <raven@themaw.net>
Subject: Re: autofs linux 3.8.13 and "Too many levels of symbolic links"
Date: Sat, 01 Feb 2014 11:32:08 +0800
Message-ID: <1391225528.2501.60.camel@perseus.fritz.box>
References: <52E92627.9050801@molgen.mpg.de>
		 <1391139080.2486.19.camel@perseus.fritz.box>
	 <1391145206.2486.25.camel@perseus.fritz.box> <52EB7694.20707@molgen.mpg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=9lsxxJ9v2lvv/Krg3B38yTY8CnI=; b=VZf8zjjx53zV4kiwjwYUKKTfyu5K
	U6xReJwWR8Nh3eb3ge3IN2xhp28F+WEz4oIUrDf/GE6flX5h02IDr7vnf3cZDrr8
	bZcrae2TX8cLdSlRQpJKBjEF9DvGYcAHh8hKe2cIScv/tu4vWhgA7D9Uu3tnd6dP
	CA07G2w67qA0gT0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=9lsxxJ9v2lvv/Krg3B38yT
	Y8CnI=; b=aqzHXl1wxXcbzNPzTmtAdUnu6E299J8/GSA1eGosinhnke3y2hWAKP
	I2Kg/E9XE4UhGE++wgUhNvgkZBhRWWzGGwn5GMdSQSTjAukI0UYNEb6ySRo9w8xy
	Ik+USfXiV23rRw+ki2LfnoBaR4kpm8B2TpwcHslruhu34bDtINLC0=
In-Reply-To: <52EB7694.20707@molgen.mpg.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: David Howells <dhowells@redhat.com>
Cc: autofs <autofs@vger.kernel.org>, Donald Buczek <buczek@molgen.mpg.de>

Hi David,

Wondering if you could perhaps lend a hand with this analysis.

The "Too many levels of symbolic links" error has been reported against
the rhel-6 back port and a number of kernel versions (over time) but has
not yet been reported against the most recent kernels. So it may still
be an issue.

Donald has provided quite a bit of useful information in the forgoing
discussion. Have a look at this link for debug information he has
provided so far: 
http://www.molgen.mpg.de/~buczek/autofs-demo/

I can forward mails from earlier posts if you need to see them.

On Fri, 2014-01-31 at 11:10 +0100, Donald Buczek wrote:
> On 01/31/14 06:13, Ian Kent wrote:
> > On Fri, 2014-01-31 at 11:31 +0800, Ian Kent wrote:
> >> On Wed, 2014-01-29 at 17:02 +0100, Donald Buczek wrote:
> >>> Hello,
> >>>
> >>> we are trying to switch from amd to autofs. After successfully testing
> >>> and rolling it out to the first several machines, from time to time we
> >>> get directories stuck with "Too many levels of symbolic links" on a path
> >>> which should be automounted via an indirect map.
> >>>
> >>> linux 3.8.13
> >>> autofs 5.0.8
> >>>
> >>> As an example, here is data from a system where the path /scratch/tmp is
> >>> stuck:
> >>>
> >>> http://www.molgen.mpg.de/~buczek/autofs-demo/
> >>>
> >>>     auto.master    # master map
> >>>     auto.scratch    # indirect map for /scratch
> >>>     autofs            # from /etc/defaults
> >>>     typescript       # shows the problem and a bit of gdb dump of kernel
> >>> structures
> >>>     typescript.l     # same with line numbers for reference
> >>>     gdb-macros     # macros used in the gdb session
> >>>
> >>>   From typescript.l , line 122ff it is clear, that /scratch/tmp is not
> >>> currently mounted. On the other hand, the gdb session finds the dentry
> >>> of /scratch/tmp which has d_flags 0x70080 (line 99,120). This is
> >>> DCACHE_MANAGE_TRANSIT+DCACHE_NEED_AUTOMOUNT+DCACHE_MOUNTED+DCACHE_RCUACCESS
> >>> with DCACHE_MOUNTED indicating that there should be something mounted
> >>> there(?). I think, this state is faulty and necessarily leads to ELOOP
> >>> during path walk. Probably the situation is known by the gurus here?
> >> Yes, I can see how DCACHE_MOUNTED being set would lead to ELOOP in this
> >> case. But, having been there before too, I couldn't see any way the
> >> DCACHE_MOUNTED would not be cleared on umount. Also, DCACHE_MOUNTED is
> >> only changed within the VFS and isn't changed very often. It can't see
> >> how a code path that should lead to one of those changes doesn't go
> >> there.
> >>
> >> I'll have another look .....
> > Then the question becomes ....
> >
> > Can a dentry be a mount point for more than one mount ....
> > Obviously not you say ... but what about clone(2) with CLONE_NEWNS?
> >
> > If you still have that kernel you used to get the info above could you
> > check the mount (ie. struct mount not struct vfsmount) structures to see
> > if there is one with its mnt_mountpoint set to the dentry in question?
> >
> > Ian
> >
> >
> 
> Hello, Ian,
> 
> you said, "how DCACHE_MOUNTED would not be cleared on umount", so you 
> are thinking about the unmount path. I asked my users and in two cases 
> (including the one described in this thread) they think, it happened the 
> very first time they accessed the path after boot. This suggest, the 
> problem might appear on the mount path.
> 
> Also, both were on workstations (single user!) and they both used a 
> shell ( "cd /failing/path" and "do_something > /failing/path/bla" ) , so 
> collisions (other threads accessing the same path at the same time) are 
> unlikely.
> 
> We don't have any hints which would suggests, that there might have been 
> a problem with the fileserver or network involved (which would imply a 
> bug in the "mount failure" path)
> 
> Oh... Just found another important peace of information :
> 
> > root:thehawk:~/# date
> > Fri Jan 31 10:27:48 CET 2014
> > root:thehawk:~/# uptime
> >  10:27:51 up 8 days, 21:58,  3 users,  load average: 0.37, 0.30, 0.26
> 
> The system was bootet Jan 22, 12:00 something
> 
> > root:thehawk:~/# ls -al /scratch/
> > total 2
> > drwxr-xr-x  4 root system    0 Jan 27 13:37 .
> > drwxr-xr-x 35 root system  888 Jan 20 10:28 ..
> > drwxrwxrwt 16 root system 1136 Jan 29 14:39 local
> > dr-xr-xr-x  2 root system    0 Jan 27 13:37 tmp
> > root:thehawk:~/# ^C
> 
> The creation of the dentry was Jan 27, 13:37
> 
> And here's from the fileserver:
> > root:moep:~/# fgrep thehawk /var/log/messages |tail -5
> > 2014-01-09T14:09:35+01:00 moep rpc.mountd[646]: authenticated unmount 
> > request from thehawk.molgen.mpg.de:797 for 
> > /amd/moep/X/X2016/scratch/tolzmann (/amd/moep/X/X2016)
> > 2014-01-13T15:43:22+01:00 moep rpc.mountd[646]: authenticated mount 
> > request from thehawk.molgen.mpg.de:922 for 
> > /amd/moep/X/X2016/scratch/tmp (/amd/moep/X/X2016)
> > 2014-01-13T15:48:36+01:00 moep rpc.mountd[646]: authenticated unmount 
> > request from thehawk.molgen.mpg.de:660 for 
> > /amd/moep/X/X2016/scratch/tmp (/amd/moep/X/X2016)
> > 2014-01-16T15:52:18+01:00 moep rpc.mountd[646]: authenticated mount 
> > request from thehawk.molgen.mpg.de:877 for 
> > /amd/moep/X/X2016/scratch/tmp (/amd/moep/X/X2016)
> > 2014-01-16T15:57:30+01:00 moep rpc.mountd[646]: authenticated unmount 
> > request from thehawk.molgen.mpg.de:745 for 
> > /amd/moep/X/X2016/scratch/tmp (/amd/moep/X/X2016)
> 
> Last access seen on the Filerver (what would be mounted on /scratch/tmp 
> if everything went well) was days before that.
> 
> So /scratch/tmp has never been mounted.

This is the most interesting information so far.

As you know the mounted flag is only ever set at mount and umount.
The implication that it is set on a dentry that's never been mounted is
very strange.

But first, a question for Donald.
Given that the autofs configuration has BROWSE_MODE="no" we don't know
how the tmp directory in /scratch got created since it has never been
mounted. It shouldn't exist, any idea how it got created? Unfortunately
we probably need a full autofs debug log to answer that.

Anyway, ignoring that for now and assuming tmp was never mounted there's
only one place I can see where this might happen and only if there were
some strange compiler optimization badness and that's in
fs/namei.c:follow_managed():

        while (managed = ACCESS_ONCE(path->dentry->d_flags),
               managed &= DCACHE_MANAGED_DENTRY,
               unlikely(managed != 0)) {

I just can't see how this incorrect flags setting could happen at all so
I'm clutching at straws.

Any further thoughts on how this might be happening David?

> 
> I've checked the mounts as you asked ( 
> http://owww.molgen.mpg.de/~buczek/autofs-demo/typescript_3.l ) the 
> dentry 0xffff88016a31c440 identified in the previous sessions (and still 
> there) is not in any mnt_mountpoint
> 
> How can DCACHE_MOUNTED be set when there was no mount?
> The problem appears rarely and (until now) randomly. Locking failure?
> 
> Okay, I've managed to get the nvidia bullshit drivers to work on linux 
> 3.13.1 , so I'm going to reboot this workstation (with the three 
> failures) to the latest kernel now with DEBUG set in the autofs4 directory.
> 
> Perhaps we shouldn't waste to much time analyzing code which is 
> obsoleted already. I'll surly tell you, when the problem is seen again 
> with 8.13.
> 
> Regards
>    Donald
> 


