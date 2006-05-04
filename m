From: "Neil Millar" <nmillar@gmail.com>
Subject: opensuse 10/autofs-4.1.4-6 Automount getting stuck with
	superblock/time out/no mount found errors
Date: Thu, 4 May 2006 17:46:30 +0100
Message-ID: <694d2f6c0605040946u25257f96ga8dbb5f1c24fe1f2@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

We are having a problem with autofs getting stuck mounting
a number of directories on a number of machines in a short space
of time.

We have some compute nodes that use autofs to mount
home directories and system files. We are seeing a problem with
autofs hanging:

If you log into a node interactively everything mounts and works
correctly. However
If you submit a job to, say 20 nodes at once it connects via ssh into
the nodes,
which each mount the home directory /server/staff  and because of the setup
also mounts server/pg server/ug server/misc server/group server/package
and a few /usr/local  directories, what we then see is that a few of the nodes
will get stuck trying to mount some of these directories. If you login
to the node
interactively during this time a df command will get stuck on one of
the autofs controlled directories. You can manually mount the stuck
nfs mounts, and if you wait a few minutes everything frees up and
becomes available. Usually the stuck mount becomes available, though
occasionally you get permission denied and have to restart automount.

I have attached the errors we see at the bottom, I haven't been able
to get debug output yet. The nodes I am running in debug happen to
be working at the moment :(

A very similar configuration has worked in the past with suse 9.1 and
autofs 4.0.0. The same map configuration works on other machines
with autofs-4.1.3-114 though they are used interactively so don't
need to mount so many things so quickly.

I saw this thread that may be relevant but wasn't 100% sure?:
http://hera.kernel.org/pipermail/autofs/2005-October/002521.html

Thanks for the help.

opensuse 10 x86_64 / autofs-4.1.4-6 / Kernel 2.6.15.1

auto.master file
================
/usr/local multi file /etc/auto.usr.local ---- yp auto.usr.local
rw,intr,noquota,noac,actimeo=0

ypcat -k auto.master
====================
/data /etc/auto.data            -rw,intr,noquota,nosuid
/home /etc/auto.home            -rw,intr,noquota,noac,actimeo=0
/usr/local /etc/auto.usr.local  -ro,intr,noquota

/etc/auto.usr.local file
========================
Apps -rw,intr,noquota    master:/usr/exportlocal/&
Config -rw,intr,noquota    master:/usr/exportlocal/&
Docs -rw,intr,noquota    master:/usr/exportlocal/&

ypcat -k auto.usr.local
=======================
gsview -rw,intr,noquota server:/vol/vol0/unix/apps/&/$ARCH
molden -rw,intr,noquota server:/vol/vol0/unix/apps/&/$ARCH
etc...

ypcat -k auto.home
==================
server -rw,intr,quota,noac,actimeo=0   /staff         
&:/vol/vol0/staff       /pg             &:/vol/vol0/pg  /ug           
 &:/vol/vol0/ug  /misc        &:/vol/vol0/misc  /group        
&:/vol/vol0/group       /package        &:/vol/vol0/package

server2 -rw,intr,noquota      &:/local/home

server3 -rw,intr,quota,noac,actimeo=0    /staff         
&:/vol/vol0/staff       /pg             &:/vol/vol0/pg  /ug           
 &:/vol/vol0/ug  /misc        &:/vol/vol0/misc  /group        
&:/vol/vol0/group       /package        &:/vol/vol0/package
etc.

Configured Mount Points:
------------------------
/usr/sbin/automount -v --timeout 3600 /data yp auto.data
rw,intr,noquota,nosuid -DARCH=x86_64.linux
/usr/sbin/automount -v --timeout 3600 /usr/local multi file
/etc/auto.usr.local -- yp auto.usr.local
rw,intr,noquota,noac,actimeo=0 -DARCH=x86_64.linux
/usr/sbin/automount -v --timeout 3600 /home yp auto.home
rw,intr,noquota,noac,actimeo=0 -DARCH=x86_64.linux

Active Mount Points:
--------------------
/usr/sbin/automount -v --timeout 3600 /data yp auto.data
rw,intr,noquota,nosuid -DARCH=x86_64.linux
/usr/sbin/automount -v --timeout 3600 /usr/local multi file
/etc/auto.usr.local -- yp auto.usr.local
rw,intr,noquota,noac,actimeo=0
/usr/sbin/automount -v --timeout 3600 /home yp auto.home
rw,intr,noquota,noac,actimeo=0 -DARCH=x86_64.linux

root      4820  0.0  0.0  12060   872 ?        Ss   May03   0:00
/usr/sbin/automount -v --timeout 3600 /data yp auto.data
rw,intr,noquota,nosuid -DARCH=x86_64.linux
root      4822  0.0  0.0  12056   888 ?        Ss   May03   0:00
/usr/sbin/automount -v --timeout 3600 /usr/local multi file
/etc/auto.usr.local -- yp auto.usr.local
rw,intr,noquota,noac,actimeo=0 -DARCH=x86_64.linux
root      4901  0.0  0.0   9984   840 ?        Ss   May03   0:00
/usr/sbin/automount -v --timeout 3600 /home yp auto.home
rw,intr,noquota,noac,actimeo=0 -DARCH=x86_64.linux

Some of the error messages we see are:

May  4 16:15:41 node073 automount[4879]: attempting to mount entry /home/server
May  4 16:17:27 node073 automount[4879]: attempting to mount entry
/home/server/staff
May  4 16:17:27 node073 automount[12292]: failed to mount /home/server/staff
May  4 16:17:27 node073 automount[12292]: umount_multi: no mounts
found under /home/server/staff
May  4 16:17:41 node073 automount[12288]: >> mount:
server:/vol/vol0/ug: can't read superblock
May  4 16:17:41 node073 automount[12288]: mount(nfs): nfs: mount
failure server:/vol/vol0/ug on /home/server/ug
May  4 16:18:37 node073 automount[4793]: attempting to mount entry
/usr/local/man
May  4 16:19:10 node073 automount[12313]: aquire_lock: can't lock lock
file timed out: /var/lock/autofs
May  4 16:19:10 node073 automount[12313]: mount(nfs): nfs: mount
failure server:/vol/vol0/unix/apps/usrlocal/man/x86_64.linux on
/usr/local/man
May  4 16:19:10 node073 automount[12313]: failed to mount /usr/local/man
May  4 16:19:10 node073 automount[12313]: umount_multi: no mounts
found under /usr/local/man
May  4 16:19:10 node073 automount[4793]: attempting to mount entry
/usr/local/share
May  4 16:19:41 node073 automount[12288]: >> mount:
server:/vol/vol0/pg: can't read superblock
May  4 16:19:41 node073 automount[12288]: mount(nfs): nfs: mount
failure server:/vol/vol0/pg on /home/server/pg
May  4 16:19:43 node073 automount[12314]: aquire_lock: can't lock lock
file timed out: /var/lock/autofs
May  4 16:19:43 node073 automount[12314]: mount(nfs): nfs: mount
failure server:/vol/vol0/unix/apps/usrlocal/share on /usr/local/share
May  4 16:19:43 node073 automount[12314]: failed to mount /usr/local/share
May  4 16:19:43 node073 automount[12314]: umount_multi: no mounts
found under /usr/local/share
May  4 16:19:43 node073 automount[4793]: attempting to mount entry
/usr/local/man
May  4 16:20:01 node073 /usr/sbin/cron[12318]: (root) CMD
(/usr/local/Cluster-Apps/cluster-tools/sbin/ganglia)
May  4 16:20:16 node073 automount[12316]: aquire_lock: can't lock lock
file timed out: /var/lock/autofs
May  4 16:20:16 node073 automount[12316]: mount(nfs): nfs: mount
failure server:/vol/vol0/unix/apps/usrlocal/man/x86_64.linux on
/usr/local/man
May  4 16:20:16 node073 automount[12316]: failed to mount /usr/local/man
May  4 16:20:16 node073 automount[12316]: umount_multi: no mounts
found under /usr/local/man
May  4 16:20:16 node073 automount[4793]: attempting to mount entry
/usr/local/share
May  4 16:20:49 node073 automount[12326]: aquire_lock: can't lock lock
file timed out: /var/lock/autofs
May  4 16:20:49 node073 automount[12326]: mount(nfs): nfs: mount
failure server:/vol/vol0/unix/apps/usrlocal/share on /usr/local/share
May  4 16:20:49 node073 automount[12326]: failed to mount /usr/local/share
May  4 16:20:49 node073 automount[12326]: umount_multi: no mounts
found under /usr/local/share
May  4 16:20:49 node073 automount[4793]: attempting to mount entry
/usr/local/man
May  4 16:21:22 node073 automount[12327]: aquire_lock: can't lock lock
file timed out: /var/lock/autofs
May  4 16:21:22 node073 automount[12327]: mount(nfs): nfs: mount
failure server:/vol/vol0/unix/apps/usrlocal/man/x86_64.linux on
/usr/local/man
May  4 16:21:22 node073 automount[12327]: failed to mount /usr/local/man
May  4 16:21:22 node073 automount[12327]: umount_multi: no mounts
found under /usr/local/man
May  4 16:21:22 node073 automount[4793]: attempting to mount entry
/usr/local/share
May  4 16:21:27 node073 automount[4793]: attempting to mount entry
/usr/local/sbin
May  4 16:21:27 node073 automount[4793]: attempting to mount entry
/usr/local/bin
May  4 16:21:27 node073 automount[4793]: attempting to mount entry
/usr/local/Cluster-Config
May  4 16:21:52 node073 automount[4879]: attempting to mount entry
/home/server/pg
May  4 16:21:52 node073 automount[12352]: failed to mount /home/server/pg
May  4 16:21:52 node073 automount[12352]: umount_multi: no mounts
found under /home/server/pg

May  4 11:15:45 node018 automount[4804]: attempting to mount entry
/usr/local/share
May  4 11:16:14 node018 automount[9807]: >> mount: mount point
/usr/local/share does not exist
May  4 11:16:14 node018 automount[9807]: mount(nfs): nfs: mount
failure server:/vol/vol0/unix/apps/usrlocal/share on /usr/local/share
May  4 11:16:14 node018 automount[9807]: failed to mount /usr/local/share
May  4 11:16:14 node018 automount[9807]: umount_multi: no mounts found
under /usr/local/share

We also see occasional nfs statfs errors:

May  4 13:01:14 node010 kernel: [47400.196162] nfs_statfs: statfs error = 5
May  4 13:01:16 node010 kernel: [47402.529365] nfs_statfs: statfs error = 5
May  4 13:01:48 node010 kernel: [47434.809709] nfs_statfs: statfs error = 5
