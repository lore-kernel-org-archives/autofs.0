From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: opensuse 10/autofs-4.1.4-6 Automount getting stuck with
	superblock/time out/no mount found errors
Date: Thu, 04 May 2006 17:17:23 -0400
Message-ID: <x491wv9xzfg.fsf@redhat.com>
References: <694d2f6c0605040946u25257f96ga8dbb5f1c24fe1f2@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <694d2f6c0605040946u25257f96ga8dbb5f1c24fe1f2@mail.gmail.com>
	(Neil Millar's message of "Thu, 4 May 2006 17:46:30 +0100")
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Neil Millar <nmillar@gmail.com>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] opensuse 10/autofs-4.1.4-6 Automount getting stuck with superblock/time out/no mount found errors; "Neil Millar" <nmillar@gmail.com> adds:

nmillar> We are having a problem with autofs getting stuck mounting a
nmillar> number of directories on a number of machines in a short space of
nmillar> time.

nmillar> We have some compute nodes that use autofs to mount home
nmillar> directories and system files. We are seeing a problem with autofs
nmillar> hanging:

nmillar> If you log into a node interactively everything mounts and works
nmillar> correctly. However If you submit a job to, say 20 nodes at once it
nmillar> connects via ssh into the nodes, which each mount the home
nmillar> directory /server/staff and because of the setup also mounts
nmillar> server/pg server/ug server/misc server/group server/package and a
nmillar> few /usr/local directories, what we then see is that a few of the
nmillar> nodes will get stuck trying to mount some of these directories. If
nmillar> you login to the node interactively during this time a df command
nmillar> will get stuck on one of the autofs controlled directories. You
nmillar> can manually mount the stuck nfs mounts, and if you wait a few
nmillar> minutes everything frees up and becomes available. Usually the
nmillar> stuck mount becomes available, though occasionally you get
nmillar> permission denied and have to restart automount.

What do the logs on the NFS server show?  If/when you do get debug logs
from the automounter, that will certainly help debug the problem.

-Jeff

p.s. your auto.master refers to /etc/auto.home, but you only include the
contents of the yp map auto.home.

nmillar> I have attached the errors we see at the bottom, I haven't been
nmillar> able to get debug output yet. The nodes I am running in debug
nmillar> happen to be working at the moment :(

nmillar> A very similar configuration has worked in the past with suse 9.1
nmillar> and autofs 4.0.0. The same map configuration works on other
nmillar> machines with autofs-4.1.3-114 though they are used interactively
nmillar> so don't need to mount so many things so quickly.

nmillar> I saw this thread that may be relevant but wasn't 100% sure?:
nmillar> http://hera.kernel.org/pipermail/autofs/2005-October/002521.html

nmillar> Thanks for the help.

nmillar> opensuse 10 x86_64 / autofs-4.1.4-6 / Kernel 2.6.15.1

nmillar> auto.master file ================ /usr/local multi file
nmillar> /etc/auto.usr.local ---- yp auto.usr.local
nmillar> rw,intr,noquota,noac,actimeo=0

nmillar> ypcat -k auto.master ==================== /data /etc/auto.data
nmillar> -rw,intr,noquota,nosuid /home /etc/auto.home
nmillar> -rw,intr,noquota,noac,actimeo=0 /usr/local /etc/auto.usr.local
nmillar> -ro,intr,noquota

nmillar> /etc/auto.usr.local file ======================== Apps
nmillar> -rw,intr,noquota master:/usr/exportlocal/& Config -rw,intr,noquota
nmillar> master:/usr/exportlocal/& Docs -rw,intr,noquota
nmillar> master:/usr/exportlocal/&

nmillar> ypcat -k auto.usr.local ======================= gsview
nmillar> -rw,intr,noquota server:/vol/vol0/unix/apps/&/$ARCH molden
nmillar> -rw,intr,noquota server:/vol/vol0/unix/apps/&/$ARCH etc...

nmillar> ypcat -k auto.home ================== server
nmillar> -rw,intr,quota,noac,actimeo=0 /staff &:/vol/vol0/staff /pg
nmillar> &:/vol/vol0/pg /ug &:/vol/vol0/ug /misc &:/vol/vol0/misc /group
nmillar> &:/vol/vol0/group /package &:/vol/vol0/package

nmillar> server2 -rw,intr,noquota &:/local/home

nmillar> server3 -rw,intr,quota,noac,actimeo=0 /staff &:/vol/vol0/staff /pg
nmillar> &:/vol/vol0/pg /ug &:/vol/vol0/ug /misc &:/vol/vol0/misc /group
nmillar> &:/vol/vol0/group /package &:/vol/vol0/package etc.

nmillar> Configured Mount Points: ------------------------
nmillar> /usr/sbin/automount -v --timeout 3600 /data yp auto.data
nmillar> rw,intr,noquota,nosuid -DARCH=x86_64.linux /usr/sbin/automount -v
nmillar> --timeout 3600 /usr/local multi file /etc/auto.usr.local -- yp
nmillar> auto.usr.local rw,intr,noquota,noac,actimeo=0 -DARCH=x86_64.linux
nmillar> /usr/sbin/automount -v --timeout 3600 /home yp auto.home
nmillar> rw,intr,noquota,noac,actimeo=0 -DARCH=x86_64.linux

nmillar> Active Mount Points: -------------------- /usr/sbin/automount -v
nmillar> --timeout 3600 /data yp auto.data rw,intr,noquota,nosuid
nmillar> -DARCH=x86_64.linux /usr/sbin/automount -v --timeout 3600
nmillar> /usr/local multi file /etc/auto.usr.local -- yp auto.usr.local
nmillar> rw,intr,noquota,noac,actimeo=0 /usr/sbin/automount -v --timeout
nmillar> 3600 /home yp auto.home rw,intr,noquota,noac,actimeo=0
nmillar> -DARCH=x86_64.linux

nmillar> root 4820 0.0 0.0 12060 872 ?  Ss May03 0:00 /usr/sbin/automount
nmillar> -v --timeout 3600 /data yp auto.data rw,intr,noquota,nosuid
nmillar> -DARCH=x86_64.linux root 4822 0.0 0.0 12056 888 ?  Ss May03 0:00
nmillar> /usr/sbin/automount -v --timeout 3600 /usr/local multi file
nmillar> /etc/auto.usr.local -- yp auto.usr.local
nmillar> rw,intr,noquota,noac,actimeo=0 -DARCH=x86_64.linux root 4901 0.0
nmillar> 0.0 9984 840 ?  Ss May03 0:00 /usr/sbin/automount -v --timeout
nmillar> 3600 /home yp auto.home rw,intr,noquota,noac,actimeo=0
nmillar> -DARCH=x86_64.linux

nmillar> Some of the error messages we see are:

nmillar> May 4 16:15:41 node073 automount[4879]: attempting to mount entry
nmillar> /home/server May 4 16:17:27 node073 automount[4879]: attempting to
nmillar> mount entry /home/server/staff May 4 16:17:27 node073
nmillar> automount[12292]: failed to mount /home/server/staff May 4
nmillar> 16:17:27 node073 automount[12292]: umount_multi: no mounts found
nmillar> under /home/server/staff May 4 16:17:41 node073 automount[12288]:
nmillar> >> mount: server:/vol/vol0/ug: can't read superblock May 4
nmillar> 16:17:41 node073 automount[12288]: mount(nfs): nfs: mount failure
nmillar> server:/vol/vol0/ug on /home/server/ug May 4 16:18:37 node073
nmillar> automount[4793]: attempting to mount entry /usr/local/man May 4
nmillar> 16:19:10 node073 automount[12313]: aquire_lock: can't lock lock
nmillar> file timed out: /var/lock/autofs May 4 16:19:10 node073
nmillar> automount[12313]: mount(nfs): nfs: mount failure
nmillar> server:/vol/vol0/unix/apps/usrlocal/man/x86_64.linux on
nmillar> /usr/local/man May 4 16:19:10 node073 automount[12313]: failed to
nmillar> mount /usr/local/man May 4 16:19:10 node073 automount[12313]:
nmillar> umount_multi: no mounts found under /usr/local/man May 4 16:19:10
nmillar> node073 automount[4793]: attempting to mount entry
nmillar> /usr/local/share May 4 16:19:41 node073 automount[12288]: >>
nmillar> mount: server:/vol/vol0/pg: can't read superblock May 4 16:19:41
nmillar> node073 automount[12288]: mount(nfs): nfs: mount failure
nmillar> server:/vol/vol0/pg on /home/server/pg May 4 16:19:43 node073
nmillar> automount[12314]: aquire_lock: can't lock lock file timed out:
nmillar> /var/lock/autofs May 4 16:19:43 node073 automount[12314]:
nmillar> mount(nfs): nfs: mount failure
nmillar> server:/vol/vol0/unix/apps/usrlocal/share on /usr/local/share May
nmillar> 4 16:19:43 node073 automount[12314]: failed to mount
nmillar> /usr/local/share May 4 16:19:43 node073 automount[12314]:
nmillar> umount_multi: no mounts found under /usr/local/share May 4
nmillar> 16:19:43 node073 automount[4793]: attempting to mount entry
nmillar> /usr/local/man May 4 16:20:01 node073 /usr/sbin/cron[12318]:
nmillar> (root) CMD (/usr/local/Cluster-Apps/cluster-tools/sbin/ganglia)
nmillar> May 4 16:20:16 node073 automount[12316]: aquire_lock: can't lock
nmillar> lock file timed out: /var/lock/autofs May 4 16:20:16 node073
nmillar> automount[12316]: mount(nfs): nfs: mount failure
nmillar> server:/vol/vol0/unix/apps/usrlocal/man/x86_64.linux on
nmillar> /usr/local/man May 4 16:20:16 node073 automount[12316]: failed to
nmillar> mount /usr/local/man May 4 16:20:16 node073 automount[12316]:
nmillar> umount_multi: no mounts found under /usr/local/man May 4 16:20:16
nmillar> node073 automount[4793]: attempting to mount entry
nmillar> /usr/local/share May 4 16:20:49 node073 automount[12326]:
nmillar> aquire_lock: can't lock lock file timed out: /var/lock/autofs May
nmillar> 4 16:20:49 node073 automount[12326]: mount(nfs): nfs: mount
nmillar> failure server:/vol/vol0/unix/apps/usrlocal/share on
nmillar> /usr/local/share May 4 16:20:49 node073 automount[12326]: failed
nmillar> to mount /usr/local/share May 4 16:20:49 node073 automount[12326]:
nmillar> umount_multi: no mounts found under /usr/local/share May 4
nmillar> 16:20:49 node073 automount[4793]: attempting to mount entry
nmillar> /usr/local/man May 4 16:21:22 node073 automount[12327]:
nmillar> aquire_lock: can't lock lock file timed out: /var/lock/autofs May
nmillar> 4 16:21:22 node073 automount[12327]: mount(nfs): nfs: mount
nmillar> failure server:/vol/vol0/unix/apps/usrlocal/man/x86_64.linux on
nmillar> /usr/local/man May 4 16:21:22 node073 automount[12327]: failed to
nmillar> mount /usr/local/man May 4 16:21:22 node073 automount[12327]:
nmillar> umount_multi: no mounts found under /usr/local/man May 4 16:21:22
nmillar> node073 automount[4793]: attempting to mount entry
nmillar> /usr/local/share May 4 16:21:27 node073 automount[4793]:
nmillar> attempting to mount entry /usr/local/sbin May 4 16:21:27 node073
nmillar> automount[4793]: attempting to mount entry /usr/local/bin May 4
nmillar> 16:21:27 node073 automount[4793]: attempting to mount entry
nmillar> /usr/local/Cluster-Config May 4 16:21:52 node073 automount[4879]:
nmillar> attempting to mount entry /home/server/pg May 4 16:21:52 node073
nmillar> automount[12352]: failed to mount /home/server/pg May 4 16:21:52
nmillar> node073 automount[12352]: umount_multi: no mounts found under
nmillar> /home/server/pg

nmillar> May 4 11:15:45 node018 automount[4804]: attempting to mount entry
nmillar> /usr/local/share May 4 11:16:14 node018 automount[9807]: >> mount:
nmillar> mount point /usr/local/share does not exist May 4 11:16:14 node018
nmillar> automount[9807]: mount(nfs): nfs: mount failure
nmillar> server:/vol/vol0/unix/apps/usrlocal/share on /usr/local/share May
nmillar> 4 11:16:14 node018 automount[9807]: failed to mount
nmillar> /usr/local/share May 4 11:16:14 node018 automount[9807]:
nmillar> umount_multi: no mounts found under /usr/local/share

nmillar> We also see occasional nfs statfs errors:

nmillar> May 4 13:01:14 node010 kernel: [47400.196162] nfs_statfs: statfs
nmillar> error = 5 May 4 13:01:16 node010 kernel: [47402.529365]
nmillar> nfs_statfs: statfs error = 5 May 4 13:01:48 node010 kernel:
nmillar> [47434.809709] nfs_statfs: statfs error = 5

nmillar> _______________________________________________ autofs mailing
nmillar> list autofs@linux.kernel.org
nmillar> http://linux.kernel.org/mailman/listinfo/autofs
