From: Thomas Richter <richter@rus.uni-stuttgart.de>
Subject: autofsv4: "ghost" entries prevent timeout of mounts
Date: Wed, 14 Mar 2012 21:58:08 +0100
Message-ID: <4F610660.7020902@rus.uni-stuttgart.de>
Reply-To: richter@rus.uni-stuttgart.de
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	rus.uni-stuttgart.de; h=content-transfer-encoding:content-type
	:content-type:subject:subject:user-agent:reply-to:from:from:date
	:date:message-id:received:received:received; s=dkim20100209; t=
	1331758709; x=1333573110; bh=iVzHZghlYYvgq/vIGkLkV7AIK1OJ4qzUpLX
	H1howJ2A=; b=tQEfb+TMliyT5gdwIiSMfuGPwkj9tn6PEERsjVfrGjir/aUXibS
	uEaOky2jw9/bmb3shL0NzK392rcdlBrhVlz/CzW16vLrjjkHBwb97R/I2k0+pEFT
	tIsv3zxqUxW4m/ARwhcH0OQ3mYxj762LvlUhpXeNZPMfOEZMVaHlD7zY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-kernel@vger.kernel.org, raven@themaw.net, autofs@linux.kernel.org

Dear kernel developers,

starting with at least kernel version 3.2.9, but probably earlier, 
mounting autofs with the --ghost option to create dummy directory 
entries in its mount point prevents the autofs mounts from timing out. 
Instead, the mounts persist and are never unmounted.

This problem did not exist in kernel 2.6.35.13, at least, so autofs must 
have been broken somewhere between 2.3.35.13 and 3.2.9.

/etc/auto.master reads as follows:

# $Id: auto.master,v 1.2 1997/10/06 21:52:03 hpa Exp $
# Sample auto.master file
# Format of this file:
# mountpoint map options
# For details of the format look at autofs(8).
#
# Note: Due to a bug in the init.d/autofs script, there
# *MUST* be a blank space behind the options (here: -t=10 <--).
# Unlike the debian reference, options must be given in the
# form "-option=<value>".
#
# -g is broken and stops automatic unmounting from working.
#

/var/autofs/misc        /etc/auto.misc  -g -t=2

/etc/auto.misc is as follows:

# $Id: auto.misc,v 1.2 1997/10/06 21:52:04 hpa Exp $
# This is an automounter map and it has the following format
# key [ -mount-options-separated-by-comma ] location
# Details may be found in the autofs(5) manpage

cdrom0          -fstype=auto,noatime,rw,user,nodev,nosuid       :/dev/cdrom0
cdrom1          -fstype=auto,noatime,rw,user,nodev,nosuid       :/dev/cdrom1
zip             -fstype=auto,nodev,nosuid                       :/dev/zip
usbstick 
-fstype=auto,noatime,rw,user,nodev,nosuid,gid=floppy,umask=0200 
:/dev/usbstick
usbdisk         -fstype=auto,noatime,rw,user,nodev,nosuid 
:/dev/usbdisk
camera 
-fstype=auto,noatime,rw,user,nodev,nosuid,gid=floppy,umask=0200 :/dev/camera
floppy          -fstype=auto,rw,async,nodev,nosuid,umask=000    :/dev/fd0

/etc/default/autofs contains the following non-default entries:

MASTER_MAP_NAME="/etc/auto.master"
TIMEOUT=2		# <- also makes no difference
NEGATIVE_TIMEOUT=1	# <- neither this
BROWSE_MODE="no"
USE_MISC_DEVICE="no" # <- makes no difference, actually

Userspace tools are from Debian Squeeze (is there a relation? Might they 
break autofs?)

How to reproduce:

Instead a medium in one of the auto-mounted devices, e.g. cdrom0,
mount it by going into /var/autofs/misc/cdrom0, then leave the 
directory. Wait for the timeout (or longer). Testing with "mount" shows 
that the corresponding device file remains mounted, regardless how long 
you wait.


Best regards,

	Thomas
