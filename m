From: Stef Bon <stef@bononline.nl>
Subject: writing to fstab or mtab
Date: Fri, 29 May 2009 14:18:01 +0200
Message-ID: <4A1FD279.7030009@bononline.nl>
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

Hello,

I've created a construction which mounts via autofs local (USB devices) 
and remote resources (SMB, FTP and SSH) resources in
a subdirectory of the homedirectory of the user logged in. This works 
with ConsoleKit, udev and autofs.

Look at:

http://linux.bononline.nl/linux/autofsmanaged/index.php

It looks like:

http://www.gentoo-wiki.info/Autofs#UDEV_with_autofs


But there is some trouble with hal, hal tries to mount the local devices 
at /media, which is exported to the desktopenvironment KDE. This leads 
to the confusing situation that in the places toolbar there is a icon 
for the device, and in my homedirectory a directory managed by autofs.
When I click on the icon, the device is mounted at /media, when I enter 
the directory

$HOME/Connections/Devices/USB stick

(for example), it's mounted here.

The nice thing here is that the icon in my places toolbar changes also 
then. It's notified (via mtab/HAL I think) that the device is mounted. 
Now when I click on it, Dolphin leads me to the right place.

Now to prevent HAL to try to mount the device at /media, the scripts in 
my contruction write a line to /etc/fstab, like:

/dev/sdb1 /home/sbon/Connections/Devices/USB\040stick auto noauto,user 0 0

This works very good, but this setting in fstab confuses the 
automounter. I'm not trying to solve my problem here with hal, but how 
come the setting in fstab to confuse autofs?

Stef Bon

PS problems with hal are there because it's to rigid about where devices 
are mounted, and it's not aware of user sessions.
Linux is a multiuser system, but HAL not.
