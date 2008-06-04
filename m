From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: System hanging in /proc/mounts almost every night...
	help!
Date: Wed, 04 Jun 2008 09:00:24 -0400
Message-ID: <x49ve0picd3.fsf@segfault.boston.devel.redhat.com>
References: <1212521944.7156.93.camel@psmithub.netezza.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1212521944.7156.93.camel@psmithub.netezza.com> (Paul Smith's
	message of "Tue, 03 Jun 2008 15:39:04 -0400")
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
To: psmith@netezza.com
Cc: autofs@linux.kernel.org

Paul Smith <psmith@netezza.com> writes:

> Hi all.  I'm running Ubuntu 8.04 (kernel 2.6.24-17-generic, autofs 4.1.4
> +debian-2.1ubuntu2) on an Intel Pentium D 3GHz system with
> hyperthreading (SMP kernel) and 1G RAM.
>
> I'm using DHCP for networking and obtaining my automount maps via NIS.
>
> For the last week or so, almost every morning when I come into work my
> system is hung up in a strange way.  I can move my mouse but I never get
> asked for my password to unlock my screen.  I can C-A-F1 etc. to get
> back to a console but after I type my username at the login prompt, I
> never get asked for a password and then that console is locked up.  If I
> have a console session already logged in from the day before, then I can
> use it for a while but eventually some command will lock hard; can't ^C,
> can't ^Z, can't kill -9, nothing.
>
> If I try to C-A-D to reboot the system starts to come down but then
> hangs, hard, trying to bring down automount.  Reset just tries to reboot
> again and hangs in the same place.  I have to power off/on the system
> completely.  Bummer.
>
> I did some debugging on this problem.  I logged in as root on every
> console (F1-F6).  The next morning when the system was hung, I found a
> command that hung (just "ls") and then I ran it in another console under
> strace.
>
> It turns out what's happening is it's opening /proc/mounts, which
> succeeds, then trying to read(2) from it.  The read system call never
> returns and there's no way to kill that process, at all, once it's in
> that state.  Also I note the load on the system is very high: typically
> over 7.  However top shows no processes chewing CPU.  I also note that
> there are some "duplicate" automount processes running (that is, more
> than one for the same map).  After I reboot, of course, everything is
> fine.
>
> Last night I started all the consoles and in one of them I wrote a
> little shell script that ran `date`, then did cat /proc/mounts, then
> slept for 15 seconds, then did it again.  I sent the output to a file.
>
> I found that the hang happened last night at ~22:51 EDT.  There was
> nothing interesting in the messages log, but in syslog I find a lot of
> messages right around that time trying to get to non-existent automount
> files (this is caused by some bogosity in the Tracker utility in Gnome,
> but it shouldn't cause the system to hang!):
>
> Jun  2 22:51:29 psmithub automount[29241]: >> mount.nfs: access denied by server while mounting snap-dev01:/user/.Trash-10490
> Jun  2 22:51:29 psmithub automount[29241]: mount(nfs): nfs: mount failure snap-dev01:/user/.Trash-10490 on /user/.Trash-10490
> Jun  2 22:51:29 psmithub automount[29241]: failed to mount /user/.Trash-10490
> Jun  2 22:51:29 psmithub automount[29342]: failed to mount /nfs/.Trash
> Jun  2 22:51:29 psmithub automount[29343]: failed to mount /nfs/.Trash-10490
> Jun  2 22:51:29 psmithub automount[29344]: failed to mount /mnt/.Trash
> Jun  2 22:51:29 psmithub automount[29345]: failed to mount /mnt/.Trash-10490
> Jun  2 22:51:29 psmithub automount[29346]: >> /sbin/showmount: can't get address for .Trash
> Jun  2 22:51:29 psmithub automount[29346]: lookup(program): lookup for .Trash failed
> Jun  2 22:51:29 psmithub automount[29346]: failed to mount /net/.Trash
> Jun  2 22:51:29 psmithub automount[29353]: >> /sbin/showmount: can't get address for .Trash-10490
> Jun  2 22:51:29 psmithub automount[29353]: lookup(program): lookup for .Trash-10490 failed
> Jun  2 22:51:29 psmithub automount[29353]: failed to mount /net/.Trash-10490
> Jun  2 22:51:34 psmithub automount[29212]: mount(nfs): nfs: mount failure snap-dev01:/tools on /opt/net/tools
> Jun  2 22:51:34 psmithub automount[29212]: failed to mount /opt/net/tools
>

This .Trash madness has to end.  It keep autofs from expiring mounts in
other situations.  *grumble*

My advice for further debugging is to enabled autofs debug logging (see
http://people.redhat.com/jmoyer), and when hung, get the output from
sysrq-t.  So, when you come in in the morning, issue the sysrq-t and
make sure you can capture the output somehow (serial console or
netconsole would be best).

More below...

> That's the last message of interest in the syslog.  Here's the end of
> the shell script loop log:
>
> Mon Jun  2 22:51:30 EDT 2008
> rootfs / rootfs rw 0 0
> none /sys sysfs rw,nosuid,nodev,noexec 0 0
> none /proc proc rw,nosuid,nodev,noexec 0 0
> udev /dev tmpfs rw,relatime 0 0
> fusectl /sys/fs/fuse/connections fusectl rw,relatime 0 0
> /dev/disk/by-uuid/c7ada654-6e09-4400-ae85-c93e7fcd99d7 / ext3 rw,relatime,errors=remount-ro,data=ordered 0 0
> /dev/disk/by-uuid/c7ada654-6e09-4400-ae85-c93e7fcd99d7 /dev/.static/dev ext3 rw,relatime,errors=remount-ro,data=ordered 0 0
> tmpfs /var/run tmpfs rw,nosuid,nodev,noexec 0 0
> tmpfs /var/lock tmpfs rw,nosuid,nodev,noexec 0 0
> tmpfs /lib/modules/2.6.24-17-generic/volatile tmpfs rw,relatime 0 0
> tmpfs /dev/shm tmpfs rw,relatime 0 0
> devpts /dev/pts devpts rw,relatime 0 0
> tmpfs /var/run tmpfs rw,nosuid,nodev,noexec 0 0
> tmpfs /var/lock tmpfs rw,nosuid,nodev,noexec 0 0
> /dev/sda5 /home ext3 rw,relatime,data=ordered 0 0
> securityfs /sys/kernel/security securityfs rw,relatime 0 0
> rpc_pipefs /var/lib/nfs/rpc_pipefs rpc_pipefs rw,relatime 0 0
> automount(pid5466) /net autofs rw,relatime,fd=4,pgrp=5466,timeout=300,minproto=2,maxproto=4,indirect 0 0
> automount(pid5367) /mnt autofs rw,relatime,fd=4,pgrp=5367,timeout=60,minproto=2,maxproto=4,indirect 0 0
> automount(pid5404) /nfs autofs rw,relatime,fd=4,pgrp=5404,timeout=3600,minproto=2,maxproto=4,indirect 0 0
> automount(pid5532) /user autofs rw,relatime,fd=4,pgrp=5532,timeout=300,minproto=2,maxproto=4,indirect 0 0
> automount(pid5612) /export/autofs autofs rw,relatime,fd=4,pgrp=5612,timeout=60,minproto=2,maxproto=4,indirect 0 0
> automount(pid5684) /opt/net autofs rw,relatime,fd=4,pgrp=5684,timeout=36000,minproto=2,maxproto=4,indirect 0 0
> nfsd /proc/fs/nfsd nfsd rw,relatime 0 0

Well, I don't see the duplicate entry you mentioned above.  It is
possible that there are multiple automount daemons for the same
mountpoint during a mount or expire event.  That's just normal
operations.

How about your ps listing and maybe a gdb backtrace of the daemon (if
your system will allow you to get that).

Cheers,

Jeff
