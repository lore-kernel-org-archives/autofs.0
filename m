From: Ian Kent <raven@themaw.net>
Subject: Re: Re: autofs>3.9.99-4.0.0pre10-16 doesn't work any more
	for me
Date: Fri, 10 Jun 2005 09:04:25 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0506100852350.25943@wombat.indigo.net.au>
References: <E1DD8yC-0005oi-61@mago.wo.de> <20050409120352.GA12001@uio.no>
	<ifbr8o6m1u.fsf@mago.linux-lounge.it.fh-worms.de>
	<20050409151430.GA4432@uio.no>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050409151430.GA4432@uio.no>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, 300648@bugs.debian.org, Martin Ruppert <ruppert@Fh-Worms.de>

On Sat, 9 Apr 2005, Steinar H. Gunderson wrote:

I think this is a known bug.
Fixed during the 4.1.4 and probably should be OK in the current Debian 
version but I will need to check.

See below for required map syntax update.

> On Sat, Apr 09, 2005 at 04:51:09PM +0200, Martin Ruppert wrote:
> > i not only mount one partition, but a whole system (df -T shortened):
> > 
> > /dev/hda8      xfs ... /mnt/auto/hda8
> > /dev/hda5     ext2 ... /mnt/auto/hda8/boot
> > /dev/m/vm-u0   xfs ... /mnt/auto/hda8/usr
> > /dev/m/vm-v0   xfs ... /mnt/auto/hda8/var
> 
> Hm, sounds like multimount stuff. I have absolutely no experience with that;
> Cc-ing upstream. (Ian: I have no idea whether this is supposed to work at all
> or not, I've never seen anything like this before. Keeping the rest of the
> mail intact so you get it all :-) )
> 
> BTW, you _are_ aware that the default /etc/auto.master is empty now?
> 
> /* Steinar */
> 
> 
> > 
> > The information to do it i found in some Documentation, but the
> > Documentation is not up to date (man page from 14 Jan 2000), so i had
> > to try some time until it worked. And therefore i don't know what has
> > changed.   
> > 
> > > (I'll need the whole script 
> > 
> > here it is (/etc/auto.misc):
> > #!/bin/sh
> > 
> > #function perr(){
> > #    echo "`date +%Y%m%d.%H%M%S`:$1">>/var/log/autofs.debug
> > #}
> > #perr $@
> > 
> > case "$1" in
> >     DVDs)
> > 	echo "-fstype=auto / /dev/s/$1 /raw /dev/s/raw"

The mount entry syntax is now required to be consistent with the Sun 
escape ":" for all types of mount maps including multimount entries 
(previously not).

So this should be:

 	echo "-fstype=auto / :/dev/s/$1 /raw :/dev/s/raw"

> > 	;;
> >     backup)
> > 	echo "-fstype=auto :/dev/s0/bu"
> > 	;;
> >     boot)
> > 	echo "-fstype=ext2 :/dev/hda8"
> > 	;;
> >     cd*)
> > 	echo "-fstype=auto,ro,sync,nodev,nosuid,user :/dev/hdc"
> > 	;;
> >     dvd*)
> > 	echo "-fstype=auto,ro,sync,nodev,nosuid,user :/dev/hdc"
> > 	;;
> >     f[dl]*)
> > 	echo "-fstype=auto,sync,nodev,nosuid,user :/dev/fd0"
> > 	;;
> >     #hda[23])
> >     #  echo "-fstype=ufs,ufstype=44bsd,rw :/dev/$1"
> >     #  ;;
> >     hda8)
> > 	echo "-fstype=auto / /dev/$1 /boot /dev/hda5 /usr /dev/vm/u0 /var /dev/vm/v0"

and again.
 	echo "-fstype=auto / :/dev/$1 /boot :/dev/hda5 \
			/usr :/dev/vm/u0 /var :/dev/vm/v0"
and the rest below.

> > 	;;
> >     hda9)
> > 	echo "-fstype=auto / /dev/$1 /boot /dev/hda5 /usr /dev/vm/u1 /var /dev/vm/v1"
> > 	;;
> >     hda10)
> > 	echo "-fstype=auto / /dev/$1 /boot /dev/hda5 /usr /dev/vm/u2 /var /dev/vm/v2"
> > 	;;
> >     hd*)
> > 	echo "-fstype=auto :/dev/$1"
> > 	;;
> >     knoppix)
> > 	echo "-fstype=iso9660,ro,sync,loop :/home/ftp/pub/knoppix.iso"
> > 	;;
> >     pub*)
> > 	echo "-fstype=auto :/dev/vm/$1"
> > 	;;
> >     s[cdr]*)
> > 	echo "-fstype=auto :/dev/$1"
> > 	;;
> >     vm-*)
> > 	set -x
> > 	h=`echo $1|perl -ne 'chomp;split(/-/);print $_[1];'`
> >         echo "-fstype=auto :/dev/vm/$h"
> > 	;;
> >     [uv][012])
> >         echo "-fstype=auto :/dev/vm/$1"
> > 	;;
> >     *)
> > 	:
> > 	;;
> > esac
> > exit 0
> > 

So please try this out.

> > > and precise autofs version in any case.)
> > 
> > the last working version is:
> > mago:~ 0409.15:38:07# automount --version
> > Linux automount version 4.0.0
> > 
> > Debian-Package is
> > autofs_3.9.99-4.0.0pre10-16_i386.deb

Sorry but these versions are simply to old.

Please update to the latest stable autofs in Debian, update your maps as 
above and try again. We will work on this from there if a problem remains.

Ian
