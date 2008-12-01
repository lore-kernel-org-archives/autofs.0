From: Todd Denniston <Todd.Denniston@ssa.crane.navy.mil>
Subject: Re: automount usb key (vfat and ntfs)
Date: Mon, 01 Dec 2008 10:06:13 -0500
Message-ID: <4933FD65.5060802@ssa.crane.navy.mil>
References: <4aa525de0812010542k29530958r359ae01f1a514e58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4aa525de0812010542k29530958r359ae01f1a514e58@mail.gmail.com>
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
To: Paolo Minazzi <paolo.minazzi@gmail.com>
Cc: autofs@linux.kernel.org

Paolo Minazzi wrote, On 12/01/2008 08:42 AM:
> Hi,
> I'd like to use automount in an arm embedded system to mount
> automatically usb keys.
> I have done it for vfat and all is OK.
> Now I'd like to include also ntfs file system, so my system can
> automount also ntfs filesystems.
> 
> I have searched in this list, but I have not found a post that shows
> how do it in a CLEAN way.
> 
> This is my /etc/auto.misc
> 
>>>> /etc/auto.misc
> pen   -fstype=vfat   :/dev/sda1
> 
> I run automount in this way :
>>>>  /sbin/automount --timeout=20 /media file /etc/auto.misc
> 
> I would like to add ntfs (using ntfs-3g fuse driver).
> I have tried two ways to do it, but no one is very good.
> 
> ** 1 **
> I have tried this /etc/auto.misc:
> 
> pen   -fstype=vfat        :/dev/sda1
> pen   -fstype=ntfs-3g   :/dev/sda1
> 


`man mount` has the following to say under "-t vfstype":
  "Creating a  file /etc/filesystems can be useful to change the probe order 
(e.g., to try vfat before msdos or ext3 before ext2) or  if  you use  a 
kernel  module  autoloader." ...
" More  than  one type may be specified in a comma separated list."



So, have you tried something like:
pen   -fstype=vfat,ntfs-3g        :/dev/sda1

-- 
Todd Denniston
Crane Division, Naval Surface Warfare Center (NSWC Crane)
Harnessing the Power of Technology for the Warfighter
