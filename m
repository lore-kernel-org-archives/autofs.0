From: "Paolo Minazzi" <paolo.minazzi@gmail.com>
Subject: automount usb key (vfat and ntfs)
Date: Mon, 1 Dec 2008 14:42:57 +0100
Message-ID: <4aa525de0812010542k29530958r359ae01f1a514e58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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

Hi,
I'd like to use automount in an arm embedded system to mount
automatically usb keys.
I have done it for vfat and all is OK.
Now I'd like to include also ntfs file system, so my system can
automount also ntfs filesystems.

I have searched in this list, but I have not found a post that shows
how do it in a CLEAN way.

This is my /etc/auto.misc

>>> /etc/auto.misc
pen   -fstype=vfat   :/dev/sda1

I run automount in this way :
>>>  /sbin/automount --timeout=20 /media file /etc/auto.misc

I would like to add ntfs (using ntfs-3g fuse driver).
I have tried two ways to do it, but no one is very good.

** 1 **
I have tried this /etc/auto.misc:

pen   -fstype=vfat        :/dev/sda1
pen   -fstype=ntfs-3g   :/dev/sda1

** 2 **
I have tried an executable map, but in this way I will need to
identify the filesystem type (for example using fdisk -l) and I will
prefer to avoid to do in this way.




In my opinion the best way should be the ** 1**.
Automount should try first to mount as vfat, and if it fails try ** 2
**(ntfs-3g)
But the syntax I used does not work ok.

There is a way to do it ?

Thanks in advance.
Paolo
