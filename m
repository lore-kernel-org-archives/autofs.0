From: jack snodgrass <mylinuxguy+autofs@gmail.com>
Subject: autofs mounts drives every 15 minutes
Date: Mon, 18 Sep 2006 13:49:07 +0000 (UTC)
Message-ID: <loom.20060918T154329-602@post.gmane.org>
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

I have autofs from Fedora FC5. ( autofs-4.1.4-29 ) 

when my systems are mostly idel... autofs seems to want
to mount my drives every 15 minutes. 

My logs show:
Sep 18 04:47:42 nas kernel: XFS mounting filesystem hde1
Sep 18 04:47:49 nas kernel: XFS mounting filesystem hdg1
Sep 18 04:47:49 nas kernel: XFS mounting filesystem hdh2
Sep 18 04:47:55 nas kernel: XFS mounting filesystem hda1
Sep 18 04:48:03 nas kernel: EXT3 FS on hdd1, internal journal
Sep 18 04:48:11 nas kernel: XFS mounting filesystem sda3
Sep 18 05:03:43 nas kernel: XFS mounting filesystem hde1
Sep 18 05:03:50 nas kernel: XFS mounting filesystem hdg1
Sep 18 05:03:50 nas kernel: XFS mounting filesystem hdh2
Sep 18 05:03:55 nas kernel: XFS mounting filesystem hda1
Sep 18 05:04:03 nas kernel: EXT3 FS on hdd1, internal journal
Sep 18 05:04:12 nas kernel: XFS mounting filesystem sda3
Sep 18 05:19:43 nas kernel: XFS mounting filesystem hde1
Sep 18 05:19:50 nas kernel: XFS mounting filesystem hdg1
Sep 18 05:19:50 nas kernel: XFS mounting filesystem hdh2
Sep 18 05:19:56 nas kernel: XFS mounting filesystem hda1
Sep 18 05:20:04 nas kernel: EXT3 FS on hdd1, internal journal
Sep 18 05:20:09 nas kernel: XFS mounting filesystem sda3
Sep 18 05:35:43 nas kernel: XFS mounting filesystem hde1
Sep 18 05:35:50 nas kernel: XFS mounting filesystem hdg1
Sep 18 05:35:50 nas kernel: XFS mounting filesystem hdh2
Sep 18 05:35:56 nas kernel: XFS mounting filesystem hda1
Sep 18 05:36:04 nas kernel: EXT3 FS on hdd1, internal journal
Sep 18 05:36:12 nas kernel: XFS mounting filesystem sda3
Sep 18 05:51:43 nas kernel: XFS mounting filesystem hde1
Sep 18 05:51:50 nas kernel: XFS mounting filesystem hdg1
Sep 18 05:51:51 nas kernel: XFS mounting filesystem hdh2
Sep 18 05:51:56 nas kernel: XFS mounting filesystem hda1
Sep 18 05:52:04 nas kernel: EXT3 FS on hdd1, internal journal
Sep 18 05:52:13 nas kernel: XFS mounting filesystem sda3
Sep 18 06:07:44 nas kernel: XFS mounting filesystem hde1
Sep 18 06:07:51 nas kernel: XFS mounting filesystem hdg1
Sep 18 06:07:51 nas kernel: XFS mounting filesystem hdh2
Sep 18 06:07:57 nas kernel: XFS mounting filesystem hda1
Sep 18 06:08:05 nas kernel: EXT3 FS on hdd1, internal journal
Sep 18 06:08:13 nas kernel: XFS mounting filesystem sda3
Sep 18 06:23:44 nas kernel: XFS mounting filesystem hde1
Sep 18 06:23:51 nas kernel: XFS mounting filesystem hdg1
Sep 18 06:23:51 nas kernel: XFS mounting filesystem hdh2
Sep 18 06:23:57 nas kernel: XFS mounting filesystem hda1
Sep 18 06:24:05 nas kernel: EXT3 FS on hdd1, internal journal
Sep 18 06:24:13 nas kernel: XFS mounting filesystem sda3
Sep 18 06:39:44 nas kernel: XFS mounting filesystem hde1
Sep 18 06:39:51 nas kernel: XFS mounting filesystem hdg1
Sep 18 06:39:51 nas kernel: XFS mounting filesystem hdh2
Sep 18 06:39:57 nas kernel: XFS mounting filesystem hda1
Sep 18 06:40:05 nas kernel: EXT3 FS on hdd1, internal journal
Sep 18 06:40:09 nas kernel: XFS mounting filesystem sda3
Sep 18 06:55:45 nas kernel: XFS mounting filesystem hde1
Sep 18 06:55:52 nas kernel: XFS mounting filesystem hdg1
Sep 18 06:55:52 nas kernel: XFS mounting filesystem hdh2
Sep 18 06:55:57 nas kernel: XFS mounting filesystem hda1
Sep 18 06:56:05 nas kernel: EXT3 FS on hdd1, internal journal
Sep 18 06:56:14 nas kernel: XFS mounting filesystem sda3
Sep 18 07:11:45 nas kernel: XFS mounting filesystem hde1
Sep 18 07:11:52 nas kernel: XFS mounting filesystem hdg1
Sep 18 07:11:52 nas kernel: XFS mounting filesystem hdh2
Sep 18 07:11:58 nas kernel: XFS mounting filesystem hda1
Sep 18 07:12:06 nas kernel: EXT3 FS on hdd1, internal journal
Sep 18 07:12:14 nas kernel: XFS mounting filesystem sda3
Sep 18 07:27:45 nas kernel: XFS mounting filesystem hde1
Sep 18 07:27:52 nas kernel: XFS mounting filesystem hdg1
Sep 18 07:27:52 nas kernel: XFS mounting filesystem hdh2
Sep 18 07:27:58 nas kernel: XFS mounting filesystem hda1
Sep 18 07:28:06 nas kernel: EXT3 FS on hdd1, internal journal
Sep 18 07:28:15 nas kernel: XFS mounting filesystem sda3
Sep 18 07:43:46 nas kernel: XFS mounting filesystem hde1
Sep 18 07:43:53 nas kernel: XFS mounting filesystem hdg1
Sep 18 07:43:53 nas kernel: XFS mounting filesystem hdh2
Sep 18 07:43:58 nas kernel: XFS mounting filesystem hda1
Sep 18 07:44:06 nas kernel: EXT3 FS on hdd1, internal journal
Sep 18 07:44:15 nas kernel: XFS mounting filesystem sda3

I don't want my drives mounted 4 times per hour unless
they are being used. 

Does anyone know if this is autofs and why it's doing it? 

This is a pretty basic install of FC5. It's a NAS box only. 
No users, no graphics, no hal or printing or anyhing.... 
don't know why these are being mounted. 

On my NAS box, I use hdparm -y to spin down the drives
when they are not being used... ( unmounted by autofs ) 
as-is... my drives spin up every 15 minutes and they shoud
not be... 

Thanks - jack 
