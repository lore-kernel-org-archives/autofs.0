From: "Mick" <email_mick_groups@bigpond.com>
Subject: no auto in autofs...
Date: Wed, 1 Sep 2004 23:09:12 +0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <JCEBJEOKALMICCBFAFIBIEIDCFAA.email_mick_groups@bigpond.com>
Mime-Version: 1.0
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
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Hi,

This is my first post so please bear with me while I try to report this
issues.

I'm using kernel 2.6.7 with no patches..   Here are my relavent config
files:

cat /etc/autofs/auto.master
# $Id: auto.master,v 1.1 2000/08/08 17:53:33 achim Exp $
# Sample auto.master file
# Format of this file:
# mountpoint map options
# For details of the format look at autofs(8).
/misc   /etc/autofs/auto.misc --timeout=20

cat /etc/autofs/auto.misc
# $Id: auto.misc,v 1.2 2002/10/27 05:21:15 bcowan Exp $
# This is an automounter map and it has the following format
# key [ -mount-options-separated-by-comma ] location
# Details may be found in the autofs(5) manpage
#boot           -fstype=ext2            :/dev/hda1
#cd             -fstype=iso9660,ro      :/dev/cdrom
#floppy         -fstype=auto            :/dev/fd0
beast           -fstype=smbfs,uid=wheel,username=mick,password=""
://beast/tmp
beast-cd-dvd    -fstype=smbfs,uid=wheel,username=mick,password=""
://beast/dvd-cdrw
beast-cd        -fstype=smbfs,uid=wheel,username=mick,password=""
://MICKPERLAPTOP/dvd-cdrw

I have some confusion about whether one is meant to use the ip hostname of a
device, or the SMB hostname from 'smbtree' so I'm testing with both..

automount is running:
ps aux | grep auto
root      5288  0.0  0.2  1556  664 ?        S    22:27   0:00
/usr/sbin/automount --timeout 20 /misc file /etc/autofs/auto.misc

I have tried with both having autofs create /misc or me 'mkdir /misc' ing
the dir.  Both seem to have the same effect, so I'm assuming most of the
documentation floating around is wrong, as what I have read says you must
create the dir for autofs to mount to.

However, nothing mounts (well, it does, but not without my intervention, as
you'll read later)...

freevo / # ls -lah /misc
total 4.0K
drwxr-xr-x    2 root     root            0 Sep  1 22:28 .
drwxr-xr-x   24 root     root         4.0K Sep  1 22:27 ..
freevo / #

The only way I can find to mount it is to try to mkdir one of the dirs.. (I
stumbles onto this..)
freevo / # mkdir /misc/beast
mkdir: cannot create directory `/misc/beast': File exists

freevo / # ls -lah /misc
total 8.0K
drwxr-xr-x    3 root     root            0 Sep  1 22:39 .
drwxr-xr-x   24 root     root         4.0K Sep  1 22:27 ..
drwxr-xr-x    1 65535    root         4.0K Sep  1 22:39 beast
freevo / #

And now the dir is mounted and accessable..

Please, has anyone experienced anythign like this??  Any ideas what is going
wrong?

Mick

One more thing... Whever I am 'in' (ssh) the /misc dir and doing systemsy
things..  I get funny /var/log/messages in relations to automount.  I've
executed the majority of the commands from within /misc, they worked as
expected but for some reason automount logs the following (NB: These are the
ONLY logs for automount in /var/log/messages..):

Sep  1 21:42:34 freevo automount[12926]: failed to mount /misc/dmesg
Sep  1 21:44:58 freevo automount[13042]: failed to mount /misc/dmesg
Sep  1 21:51:14 freevo automount[13534]: failed to mount /misc/smbcacls
Sep  1 21:51:14 freevo automount[13535]: failed to mount /misc/smbcontrol
Sep  1 21:51:14 freevo automount[13536]: failed to mount /misc/smbd
Sep  1 21:51:14 freevo automount[13537]: failed to mount /misc/smbmnt
Sep  1 21:51:14 freevo automount[13538]: failed to mount /misc/smbpasswd
Sep  1 21:51:14 freevo automount[13539]: failed to mount /misc/smbstatus
Sep  1 21:51:14 freevo automount[13540]: failed to mount /misc/smbtorture
Sep  1 21:51:14 freevo automount[13541]: failed to mount /misc/smbumount
Sep  1 21:51:14 freevo automount[13542]: failed to mount /misc/smbclient
Sep  1 21:51:14 freevo automount[13543]: failed to mount /misc/smbcquotas
Sep  1 21:51:14 freevo automount[13544]: failed to mount /misc/smbfilter
Sep  1 21:51:14 freevo automount[13545]: failed to mount /misc/smbmount
Sep  1 21:51:14 freevo automount[13546]: failed to mount /misc/smbspool
Sep  1 21:51:14 freevo automount[13547]: failed to mount /misc/smbtar
Sep  1 21:51:14 freevo automount[13548]: failed to mount /misc/smbtree

I am fairly newbie, so please go easy on me ;-)

Mick
