From: Ian Kent <raven@themaw.net>
Subject: Re: autofs 5 not recognizing manual umounts	properly
Date: Wed, 01 Nov 2006 11:35:34 +0800
Message-ID: <1162352134.3579.33.camel@localhost>
References: <10272992.2537671162323983680.JavaMail.servlet@kundenserver>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <10272992.2537671162323983680.JavaMail.servlet@kundenserver>
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
To: twendt@online.de
Cc: autofs@linux.kernel.org

On Tue, 2006-10-31 at 20:46 +0100, twendt@online.de wrote:
> >On Sat, 2006-10-28 at 18:41 +0200, Timo Wendt wrote:
> >> Hi,
> >> 
> >> 
> >> I have just installed FC6 to do some tests with autofs 5 as I need to
> >> use direct mounts. The new version works really great. The only thing
> >> I figured out so far that does not work fine is, when I umount one of
> >> the automounted fs manually.
> >> If I then try to list the contents of that directory it says, that it
> >> is empty. As soon as I try to create a file in that directory, it
> >> fails and seems to realize, that the directory should be mounted and
> >> remounts it, without creating the file though.
> >
> >And what kernel are you using?
> >And the version of autofs?
> >
> >Ian
> >
> >
> Hi,
> 
> sorry for the delay I didn't get to check this yesterday.

I'll try and duplicate this.

> 
> I have the following maps:
> 
> /etc/auto.master:
> 
> /- /etc/auto.direct
> 
> /etc/auto.direct:
> 
> /home/timo      192.168.178.187:/mnt
> 
> The IP is actually the local IP, therefore I get bind mounts instead of NFS mounts.
> 
> Here is what I am doing:
> 
> [root@localhost autofs-5.0.1]# mount
> /dev/mapper/vg00-lvroot on / type ext3 (rw)
> proc on /proc type proc (rw)
> sysfs on /sys type sysfs (rw)
> devpts on /dev/pts type devpts (rw,gid=5,mode=620)
> /dev/hda5 on /boot type ext3 (rw)
> tmpfs on /dev/shm type tmpfs (rw)
> /dev/mapper/vg00-lvxen on /xen_domains type ext3 (rw)
> none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
> sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)
> nfsd on /proc/fs/nfsd type nfsd (rw)
> 
> [root@localhost autofs-5.0.1]# ll /home/timo
> total 0
> -rw-r--r-- 1 root root 0 Oct 27 20:09 a

Would have been good to have a list of mounts here.
And at this point a copy of /proc/mounts.

> 
> [root@localhost autofs-5.0.1]# umount /mnt
> 
> [root@localhost autofs-5.0.1]# mount
> /dev/mapper/vg00-lvroot on / type ext3 (rw)
> proc on /proc type proc (rw)
> sysfs on /sys type sysfs (rw)
> devpts on /dev/pts type devpts (rw,gid=5,mode=620)
> /dev/hda5 on /boot type ext3 (rw)
> tmpfs on /dev/shm type tmpfs (rw)
> /dev/mapper/vg00-lvxen on /xen_domains type ext3 (rw)
> none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
> sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)
> nfsd on /proc/fs/nfsd type nfsd (rw)

And again a copy of /proc/mounts.

> 
> [root@localhost autofs-5.0.1]# ll /home/timo
> total 0
> 
> [root@localhost autofs-5.0.1]# ll /home/timo
> total 0
> 
> [root@localhost autofs-5.0.1]# touch /home/timo/b
> touch: cannot touch `/home/timo/b': Permission denied
> 
> [root@localhost autofs-5.0.1]# mount
> /dev/mapper/vg00-lvroot on / type ext3 (rw)
> proc on /proc type proc (rw)
> sysfs on /sys type sysfs (rw)
> devpts on /dev/pts type devpts (rw,gid=5,mode=620)
> /dev/hda5 on /boot type ext3 (rw)
> tmpfs on /dev/shm type tmpfs (rw)
> /dev/mapper/vg00-lvxen on /xen_domains type ext3 (rw)
> none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
> sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)
> nfsd on /proc/fs/nfsd type nfsd (rw)
> /mnt on /home/timo type none (rw,bind)
> 
> [root@localhost autofs-5.0.1]# ll /home/timo
> total 0
> -rw-r--r-- 1 root root 0 Oct 27 20:09 a
> 
> Here are the logentries of all that:

snip ...

> Oct 31 21:31:57 localhost automount[4407]: mounted /home/timo
> Oct 31 21:32:04 localhost automount[4407]: st_expire: state 1 path /-
> Oct 31 21:32:04 localhost automount[4407]: expire_proc: exp_proc = 3084585872 path /-
> Oct 31 21:32:04 localhost automount[4407]: expire_proc_direct: send expire to trigger /home/timo
> Oct 31 21:32:04 localhost automount[4407]: expire_proc_direct: send expire to trigger /home/timo

This isn't right.
There should only be one real mount at this point.

The mount lists above should tell us what's wrong here.

> Oct 31 21:32:05 localhost automount[4407]: expire_cleanup: got thid 3084585872 path /- stat 2
> Oct 31 21:32:05 localhost automount[4407]: expire_cleanup: sigchld: exp 3084585872 finished, switching from 2 to 1
> Oct 31 21:32:05 localhost automount[4407]: st_ready: st_ready(): state = 2 path /-
> 
> 
> 
> There is no logentry when I umount the directory and then also nothing when I try the ll /home/timo

Looking at the code I can see a problem but it doesn't look like it
would lead to this symptom, but you never know. Again I'll try this out.
and see.

> 
> My Kernel version is:
> Linux localhost.localdomain 2.6.18-1.2798.fc6xen #1 SMP Mon Oct 16 15:11:19 EDT 2006 i686 i686 i386 GNU/Linux
> 
> [root@localhost autofs-5.0.1]# automount -V
> 
> Linux automount version 5.0.1-0.rc2.17
> 
> Directories:
>         config dir:     /etc/sysconfig
>         maps dir:       /etc
>         modules dir:    /usr/lib/autofs
> 
> Compile options:
>   DISABLE_MOUNT_LOCKING ENABLE_IGNORE_BUSY_MOUNTS WITH_HESIOD WITH_LDAP 
>   WITH_SASL 
> 
> 
> Another thing I realized is that it still does expired the mount after the timeout period even if I try to access it it the meantime. After the expiration it does the mount again and everything is working again.

Yes.
The expire semantic is a little different in v5.
A mount is considered busy only if it is continually busy. An open file
or a process working directory will do it.

> 
> So a workaround seems to be to choose fairly small timeouts. Is there any minimum time out that should be used? Are there any performance affects if I choose very small timeouts?

Only the frequency of expire runs.
Shouldn't be a problem for small maps.

Ian
