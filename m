From: jack snodgrass <mylinuxguy+autofs@gmail.com>
Subject: autofs mounts drives that should not be mounted.
Date: Wed, 20 Sep 2006 12:44:51 +0000 (UTC)
Message-ID: <loom.20060920T144018-489@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org

I am having an issue with autofs mouting drives that should not be mounted.
It may be a kernel or FC5 or somethng else.... what ever it is... I need to 
resovle the issue....

I have:
Fedora Core release 5 (Bordeaux)
It's a base install... no hal, no nautilis, no vfs, no graphics, etc.

/etc/auto.master:
/myth   /etc/auto.myth --timeout=60

/etc/auto.myth:
store           -fstype=xfs             :/dev/sda3
store2          -fstype=xfs             :/dev/hde1
video1          -fstype=xfs             :/dev/hdg1
video2          -fstype=xfs             :/dev/hdh2
video3          -fstype=xfs             :/dev/hda1
video4          -fstype=ext3            :/dev/hdd1

/etc/exports: ( contains 8 lines.... shown here formated for 80 chars ) 
/export0       
192.168.0.0/255.255.0.0(rw,sync,nohide,no_root_squash,no_subtree_check,
no_auth_nlm,no_acl) 

/opt           
192.168.0.0/255.255.0.0(rw,sync,nohide,no_root_squash,no_subtree_check,
no_auth_nlm,no_acl) 

/myth/store    
192.168.0.0/255.255.0.0(rw,sync,nohide,no_root_squash,no_subtree_check,
no_auth_nlm,no_acl) 

/myth/store2   
192.168.0.0/255.255.0.0(rw,sync,nohide,no_root_squash,no_subtree_check,
no_auth_nlm,no_acl) 

/myth/video1   
192.168.0.0/255.255.0.0(rw,sync,nohide,no_root_squash,no_subtree_check,
no_auth_nlm,no_acl)

/myth/video2   
192.168.0.0/255.255.0.0(rw,sync,nohide,no_root_squash,no_subtree_check,
no_auth_nlm,no_acl)

/myth/video3   
192.168.0.0/255.255.0.0(rw,sync,nohide,no_root_squash,no_subtree_check,
no_auth_nlm,no_acl)

/myth/video4   
192.168.0.0/255.255.0.0(rw,sync,nohide,no_root_squash,no_subtree_check,
no_auth_nlm,no_acl)



at the start of my test... I have
df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/sdb3              48G  9.1G   36G  21% /
/dev/sdb1              99M   17M   78M  18% /boot
/dev/sdb5             230G  159G   71G  70% /opt
tmpfs                 505M     0  505M   0% /dev/shm


when I do ( on the same box ) 
mount nas:/opt /mnt/tmp

I end up with:
df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/sdb3              48G  9.1G   36G  21% /
/dev/sdb1              99M   17M   78M  18% /boot
/dev/sdb5             230G  159G   71G  70% /opt
tmpfs                 505M     0  505M   0% /dev/shm
/dev/hde1             280G  4.1G  276G   2% /myth/store2
/dev/hdg1             187G   27G  161G  15% /myth/video1
/dev/hdh2             280G  274G  5.6G  98% /myth/video2
/dev/hda1             187G  170G   17G  92% /myth/video3
/dev/hdd1             231G  214G  4.9G  98% /myth/video4
/dev/sda3             464G  154G  311G  34% /myth/store
nas:/opt              230G  159G   71G  70% /mnt/tmp

.... why did all of the /myth/* mounts happen if I was mounting /opt?

Here are the log entries:
Sep 20 07:31:01 nas mountd[1034]: authenticated mount request from
nas.private.net:1021 for /opt (/opt)
Sep 20 07:31:01 nas automount[1261]: attempting to mount entry /myth/store2
Sep 20 07:31:01 nas kernel: XFS mounting filesystem hde1
Sep 20 07:31:01 nas automount[1261]: attempting to mount entry /myth/video1
Sep 20 07:31:01 nas kernel: XFS mounting filesystem hdg1
Sep 20 07:31:01 nas automount[1261]: attempting to mount entry /myth/video2
Sep 20 07:31:01 nas kernel: XFS mounting filesystem hdh2
Sep 20 07:31:02 nas automount[1261]: attempting to mount entry /myth/video3
Sep 20 07:31:02 nas kernel: XFS mounting filesystem hda1
Sep 20 07:31:02 nas automount[1261]: attempting to mount entry /myth/video4
Sep 20 07:31:02 nas kernel: EXT3 FS on hdd1, internal journal
Sep 20 07:31:02 nas automount[1261]: attempting to mount entry /myth/store
Sep 20 07:31:02 nas kernel: XFS mounting filesystem sda3

shortly after... I get:
Sep 20 07:32:12 nas automount[1306]: rm_unwanted: /myth/store
Sep 20 07:32:12 nas automount[1306]: expired /myth/store
Sep 20 07:32:12 nas automount[1309]: rm_unwanted: /myth/video4
Sep 20 07:32:12 nas automount[1309]: expired /myth/video4
Sep 20 07:32:13 nas automount[1312]: rm_unwanted: /myth/video3
Sep 20 07:32:13 nas automount[1312]: expired /myth/video3
Sep 20 07:32:13 nas automount[1315]: rm_unwanted: /myth/video2
Sep 20 07:32:13 nas automount[1315]: expired /myth/video2
Sep 20 07:32:13 nas automount[1318]: rm_unwanted: /myth/video1
Sep 20 07:32:13 nas automount[1318]: expired /myth/video1
Sep 20 07:32:13 nas automount[1321]: rm_unwanted: /myth/store2
Sep 20 07:32:13 nas automount[1321]: expired /myth/store2

.... that part works... why were they mounted in the first place?


.... for a little background, I am trying to set up a dedicated NAS server
that mounts drives "as needed". When the drives are not mounted, I use
hdparm -y to spin them down. This keeps my NAS Server cool and quiet.


Unfortunatly... my logs show:
Sep 19 23:40:03 nas automount[22895]: attempting to mount entry /myth/store2
Sep 19 23:40:11 nas kernel: XFS mounting filesystem hde1
Sep 19 23:40:11 nas automount[22895]: attempting to mount entry /myth/video1
Sep 19 23:40:18 nas kernel: XFS mounting filesystem hdg1
Sep 19 23:40:18 nas automount[22895]: attempting to mount entry /myth/video2
Sep 19 23:40:18 nas kernel: XFS mounting filesystem hdh2
Sep 19 23:40:18 nas automount[22895]: attempting to mount entry /myth/video3
Sep 19 23:40:24 nas kernel: XFS mounting filesystem hda1
Sep 19 23:40:24 nas automount[22895]: attempting to mount entry /myth/video4
Sep 19 23:40:32 nas kernel: kjournald starting.  Commit interval 5 seconds
Sep 19 23:40:32 nas kernel: EXT3 FS on hdd1, internal journal
Sep 19 23:40:32 nas kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep 19 23:40:32 nas automount[22895]: attempting to mount entry /myth/store
Sep 19 23:40:40 nas kernel: XFS mounting filesystem sda3
Sep 19 23:41:15 nas automount[28989]: rm_unwanted: /myth/video1
Sep 19 23:41:15 nas automount[28989]: expired /myth/video1
Sep 19 23:41:15 nas automount[28992]: rm_unwanted: /myth/store2
Sep 19 23:41:15 nas automount[28992]: expired /myth/store2
Sep 19 23:41:30 nas automount[28996]: rm_unwanted: /myth/video4
Sep 19 23:41:30 nas automount[28996]: expired /myth/video4
Sep 19 23:41:30 nas automount[28999]: rm_unwanted: /myth/video3
Sep 19 23:41:30 nas automount[28999]: expired /myth/video3
Sep 19 23:41:30 nas automount[29002]: rm_unwanted: /myth/video2
Sep 19 23:41:30 nas automount[29002]: expired /myth/video2
Sep 19 23:41:45 nas automount[29006]: rm_unwanted: /myth/store
Sep 19 23:41:45 nas automount[29006]: expired /myth/store
Sep 19 23:55:53 nas automount[22895]: attempting to mount entry /myth/store2
Sep 19 23:56:01 nas kernel: XFS mounting filesystem hde1
Sep 19 23:56:01 nas automount[22895]: attempting to mount entry /myth/video1
Sep 19 23:56:07 nas kernel: XFS mounting filesystem hdg1
Sep 19 23:56:08 nas automount[22895]: attempting to mount entry /myth/video2
Sep 19 23:56:08 nas kernel: XFS mounting filesystem hdh2
Sep 19 23:56:08 nas automount[22895]: attempting to mount entry /myth/video3
Sep 19 23:56:13 nas kernel: XFS mounting filesystem hda1
Sep 19 23:56:13 nas automount[22895]: attempting to mount entry /myth/video4
Sep 19 23:57:01 nas automount[29137]: rm_unwanted: /myth/store2
Sep 19 23:57:01 nas automount[29137]: expired /myth/store2
Sep 19 23:57:01 nas automount[29140]: rm_unwanted: /myth/video1
Sep 19 23:57:01 nas automount[29140]: expired /myth/video1
Sep 19 23:57:16 nas automount[29144]: rm_unwanted: /myth/video3
Sep 19 23:57:16 nas automount[29144]: expired /myth/video3
Sep 19 23:57:16 nas automount[29147]: rm_unwanted: /myth/video2
Sep 19 23:57:16 nas automount[29147]: expired /myth/video2
Sep 20 00:03:38 nas kernel: kjournald starting.  Commit interval 5 seconds
Sep 20 00:03:38 nas kernel: EXT3 FS on hdd1, internal journal
Sep 20 00:03:38 nas kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep 20 00:03:38 nas automount[22895]: attempting to mount entry /myth/store
Sep 20 00:03:47 nas kernel: XFS mounting filesystem sda3
Sep 20 00:03:47 nas automount[29201]: rm_unwanted: /myth/video4
Sep 20 00:03:47 nas automount[29201]: expired /myth/video4
Sep 20 00:04:47 nas automount[29210]: rm_unwanted: /myth/store
Sep 20 00:04:47 nas automount[29210]: expired /myth/store
Sep 20 00:18:55 nas automount[22895]: attempting to mount entry /myth/store2
Sep 20 00:19:02 nas kernel: XFS mounting filesystem hde1
Sep 20 00:19:02 nas automount[22895]: attempting to mount entry /myth/video1
Sep 20 00:19:09 nas kernel: XFS mounting filesystem hdg1
Sep 20 00:19:09 nas automount[22895]: attempting to mount entry /myth/video2
Sep 20 00:19:09 nas kernel: XFS mounting filesystem hdh2
Sep 20 00:19:09 nas automount[22895]: attempting to mount entry /myth/video3
Sep 20 00:19:14 nas kernel: XFS mounting filesystem hda1
Sep 20 00:19:15 nas automount[22895]: attempting to mount entry /myth/video4
Sep 20 00:19:23 nas kernel: kjournald starting.  Commit interval 5 seconds
Sep 20 00:19:23 nas kernel: EXT3 FS on hdd1, internal journal
Sep 20 00:19:23 nas kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep 20 00:19:23 nas automount[22895]: attempting to mount entry /myth/store
Sep 20 00:19:31 nas kernel: XFS mounting filesystem sda3
Sep 20 00:20:02 nas automount[29364]: rm_unwanted: /myth/video1
Sep 20 00:20:02 nas automount[29364]: expired /myth/video1
Sep 20 00:20:03 nas automount[29367]: rm_unwanted: /myth/store2
Sep 20 00:20:03 nas automount[29367]: expired /myth/store2
Sep 20 00:20:18 nas automount[29371]: rm_unwanted: /myth/video4
Sep 20 00:20:18 nas automount[29371]: expired /myth/video4
Sep 20 00:20:18 nas automount[29374]: rm_unwanted: /myth/video3
Sep 20 00:20:18 nas automount[29374]: expired /myth/video3
Sep 20 00:20:18 nas automount[29377]: rm_unwanted: /myth/video2
Sep 20 00:20:18 nas automount[29377]: expired /myth/video2
Sep 20 00:20:33 nas automount[29381]: rm_unwanted: /myth/store
Sep 20 00:20:33 nas automount[29381]: expired /myth/store

when nothing is really going on..... each time the drives mount and
unmount, they spin down and them up or vica versa.... not what I
want to have happen.

jack
