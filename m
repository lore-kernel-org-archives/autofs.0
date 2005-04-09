From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: autofs>3.9.99-4.0.0pre10-16 doesn't work any more for
	me
Date: Sat, 9 Apr 2005 17:14:30 +0200
Message-ID: <20050409151430.GA4432@uio.no>
References: <E1DD8yC-0005oi-61@mago.wo.de> <20050409120352.GA12001@uio.no>
	<ifbr8o6m1u.fsf@mago.linux-lounge.it.fh-worms.de>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <ifbr8o6m1u.fsf@mago.linux-lounge.it.fh-worms.de>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Ruppert <ruppert@Fh-Worms.de>
Cc: autofs@linux.kernel.org, 300648@bugs.debian.org

On Sat, Apr 09, 2005 at 04:51:09PM +0200, Martin Ruppert wrote:
> i not only mount one partition, but a whole system (df -T shortened):
> 
> /dev/hda8      xfs ... /mnt/auto/hda8
> /dev/hda5     ext2 ... /mnt/auto/hda8/boot
> /dev/m/vm-u0   xfs ... /mnt/auto/hda8/usr
> /dev/m/vm-v0   xfs ... /mnt/auto/hda8/var

Hm, sounds like multimount stuff. I have absolutely no experience with that;
Cc-ing upstream. (Ian: I have no idea whether this is supposed to work at all
or not, I've never seen anything like this before. Keeping the rest of the
mail intact so you get it all :-) )

BTW, you _are_ aware that the default /etc/auto.master is empty now?

/* Steinar */


> 
> The information to do it i found in some Documentation, but the
> Documentation is not up to date (man page from 14 Jan 2000), so i had
> to try some time until it worked. And therefore i don't know what has
> changed.   
> 
> > (I'll need the whole script 
> 
> here it is (/etc/auto.misc):
> #!/bin/sh
> 
> #function perr(){
> #    echo "`date +%Y%m%d.%H%M%S`:$1">>/var/log/autofs.debug
> #}
> #perr $@
> 
> case "$1" in
>     DVDs)
> 	echo "-fstype=auto / /dev/s/$1 /raw /dev/s/raw"
> 	;;
>     backup)
> 	echo "-fstype=auto :/dev/s0/bu"
> 	;;
>     boot)
> 	echo "-fstype=ext2 :/dev/hda8"
> 	;;
>     cd*)
> 	echo "-fstype=auto,ro,sync,nodev,nosuid,user :/dev/hdc"
> 	;;
>     dvd*)
> 	echo "-fstype=auto,ro,sync,nodev,nosuid,user :/dev/hdc"
> 	;;
>     f[dl]*)
> 	echo "-fstype=auto,sync,nodev,nosuid,user :/dev/fd0"
> 	;;
>     #hda[23])
>     #  echo "-fstype=ufs,ufstype=44bsd,rw :/dev/$1"
>     #  ;;
>     hda8)
> 	echo "-fstype=auto / /dev/$1 /boot /dev/hda5 /usr /dev/vm/u0 /var /dev/vm/v0"
> 	;;
>     hda9)
> 	echo "-fstype=auto / /dev/$1 /boot /dev/hda5 /usr /dev/vm/u1 /var /dev/vm/v1"
> 	;;
>     hda10)
> 	echo "-fstype=auto / /dev/$1 /boot /dev/hda5 /usr /dev/vm/u2 /var /dev/vm/v2"
> 	;;
>     hd*)
> 	echo "-fstype=auto :/dev/$1"
> 	;;
>     knoppix)
> 	echo "-fstype=iso9660,ro,sync,loop :/home/ftp/pub/knoppix.iso"
> 	;;
>     pub*)
> 	echo "-fstype=auto :/dev/vm/$1"
> 	;;
>     s[cdr]*)
> 	echo "-fstype=auto :/dev/$1"
> 	;;
>     vm-*)
> 	set -x
> 	h=`echo $1|perl -ne 'chomp;split(/-/);print $_[1];'`
>         echo "-fstype=auto :/dev/vm/$h"
> 	;;
>     [uv][012])
>         echo "-fstype=auto :/dev/vm/$1"
> 	;;
>     *)
> 	:
> 	;;
> esac
> exit 0
> 
> > and precise autofs version in any case.)
> 
> the last working version is:
> mago:~ 0409.15:38:07# automount --version
> Linux automount version 4.0.0
> 
> Debian-Package is
> autofs_3.9.99-4.0.0pre10-16_i386.deb
> 
> And after ls -l /mnt/auto/hda8 tail -... /var/log/syslog delivers:
> 
> Apr  9 16:28:27 mago automount[8602]: attempting to mount entry /mnt/auto/hda8
> Apr  9 16:28:27 mago automount[9386]: lookup(program): looking up hda8
> Apr  9 16:28:27 mago automount[9386]: lookup(program): hda8 -> -fstype=auto / /dev/hda8 /usr /dev/vm/u0 /var /dev/vm/v0
> Apr  9 16:28:27 mago automount[9386]: parse(sun): expanded entry: -fstype=auto / /dev/hda8 /usr /dev/vm/u0 /var /dev/vm/v0
> Apr  9 16:28:27 mago automount[9386]: parse(sun): dequote("fstype=auto") -> fstype=auto
> Apr  9 16:28:27 mago automount[9386]: parse(sun): gathered options: fstype=auto
> Apr  9 16:28:27 mago automount[9386]: parse(sun): dequote("/") -> /
> Apr  9 16:28:27 mago automount[9386]: parse(sun): dequote("/dev/hda8") -> /dev/hda8
> Apr  9 16:28:27 mago automount[9386]: parse(sun): multimount: /dev/hda8 on / with options fstype=auto
> Apr  9 16:28:27 mago automount[9386]: parse(sun): mounting root /mnt/auto, mountpoint hda8, what /dev/hda8, fstype auto, options  
> Apr  9 16:28:27 mago automount[9386]: do_mount /dev/hda8 /mnt/auto/hda8 type auto options  using module generic
> Apr  9 16:28:27 mago automount[9386]: mount(generic): calling mkdir_path /mnt/auto/hda8
> Apr  9 16:28:27 mago automount[9386]: mount(generic): calling mount -t auto -s -o  /dev/hda8 /mnt/auto/hda8
> Apr  9 16:28:28 mago kernel: XFS mounting filesystem hda8
> Apr  9 16:28:28 mago kernel: Ending clean XFS mount for filesystem: hda8
> Apr  9 16:28:28 mago automount[9386]: mount(generic): mounted /dev/hda8 type auto on /mnt/auto/hda8
> Apr  9 16:28:28 mago automount[9386]: parse(sun): dequote("/usr") -> /usr
> Apr  9 16:28:28 mago automount[9386]: parse(sun): dequote("/dev/vm/u0") -> /dev/vm/u0
> Apr  9 16:28:28 mago automount[9386]: parse(sun): multimount: /dev/vm/u0 on /usr with options fstype=auto
> Apr  9 16:28:28 mago automount[9386]: parse(sun): mounting root /mnt/auto, mountpoint hda8/usr, what /dev/vm/u0, fstype auto, options  
> Apr  9 16:28:28 mago automount[9386]: do_mount /dev/vm/u0 /mnt/auto/hda8/usr type auto options  using module generic
> Apr  9 16:28:28 mago automount[9386]: mount(generic): calling mkdir_path /mnt/auto/hda8/usr
> Apr  9 16:28:28 mago automount[9386]: mount(generic): calling mount -t auto -s -o  /dev/vm/u0 /mnt/auto/hda8/usr
> Apr  9 16:28:28 mago kernel: XFS mounting filesystem dm-1
> Apr  9 16:28:28 mago kernel: Ending clean XFS mount for filesystem: dm-1
> Apr  9 16:28:28 mago automount[9386]: mount(generic): mounted /dev/vm/u0 type auto on /mnt/auto/hda8/usr
> Apr  9 16:28:28 mago automount[9386]: parse(sun): dequote("/var") -> /var
> Apr  9 16:28:28 mago automount[9386]: parse(sun): dequote("/dev/vm/v0") -> /dev/vm/v0
> Apr  9 16:28:28 mago automount[9386]: parse(sun): multimount: /dev/vm/v0 on /var with options fstype=auto
> Apr  9 16:28:28 mago automount[9386]: parse(sun): mounting root /mnt/auto, mountpoint hda8/var, what /dev/vm/v0, fstype auto, options  
> Apr  9 16:28:28 mago automount[9386]: do_mount /dev/vm/v0 /mnt/auto/hda8/var type auto options  using module generic
> Apr  9 16:28:28 mago automount[9386]: mount(generic): calling mkdir_path /mnt/auto/hda8/var
> Apr  9 16:28:28 mago automount[9386]: mount(generic): calling mount -t auto -s -o  /dev/vm/v0 /mnt/auto/hda8/var
> Apr  9 16:28:28 mago kernel: XFS mounting filesystem dm-2
> Apr  9 16:28:28 mago kernel: Ending clean XFS mount for filesystem: dm-2
> Apr  9 16:28:28 mago automount[9386]: mount(generic): mounted /dev/vm/v0 type auto on /mnt/auto/hda8/var
> 
> On this sid-system, there is something else wrong (didn't realize it
> any time before), because attempt to mount /dev/hda5 on
> /mnt/auto/hda8/boot fails with error message
> 
> /dev/hda5 is mounted on /boot
> 
> and also does the attempt to mount /dev/hda5 on /mnt/hda5,
> but with an actual sarge on another system, all wents well.
> 
> Installing
> autofs_4.1.3-9_i386.deb
> 
> and doing
> ls -l /mnt/auto/hda8
> 
> there are no error-messages and nothing in /var/log/syslog, but i only
> get
> 
> ls: /mnt/auto/hda8: No such file or directory
> 
> Hope this helps and thank you very much.
> 
> > /* Steinar */
> 
> Best regards
> M.Ruppert
> 

-- 
Homepage: http://www.sesse.net/
