From: peter.a.harris@exgate.tek.com
Subject: RE: autofs v4
Date: Mon, 17 Nov 2003 10:03:50 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <BA0E4392AD99D040885C414D992C24BE059A4C45@us-bv-m11.bv.tek.com>
Mime-Version: 1.0
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
Content-Transfer-Encoding: 7bit
To: gregb@rhythm.com
Cc: autofs@linux.kernel.org

Are you doing an ASCII sort on the showmount output?  I think the
automounter needs to mount the root file system first.  At least that is my
experience.

I ran into what I think is a similar problem awhile back with the standard
script that is sent out with (I think) both the 4.0 and 4.1 versions of
autofs.  It stems from the sort command and your locale.  Our locale is the
default Red Hat installation en_us...  Without changes, I would get:

showmount --no-headers -e lx4 | sort 
/boot       @ng_cse,@ng_tmecc
/localtmp   @ng_cse,@ng_tmecc
/           @ng_cse,@ng_tmecc
/usr        @ng_cse,@ng_tmecc
/var        @ng_cse,@ng_tmecc

With that I would not see all the mounts, because the early mounts were
being covered by the late mount of /.

I initially solved the problem by

showmount --no-headers -e lx4 | sort +0 -1
/           @ng_cse,@ng_tmecc
/boot       @ng_cse,@ng_tmecc
/localtmp   @ng_cse,@ng_tmecc
/usr        @ng_cse,@ng_tmecc
/var        @ng_cse,@ng_tmecc

and I have subsequently learned I could set LANG=C to get the expected ASCII
sort sequence.



Pete Harris
Central Engineering / Technical Computing
Phone:	1-503-627-3989
Fax:	1-503-627-5587

   __++__            ---------  ___,--. --+_._._:_    
  _|____|_ _________ |__|_|__| |_SP&S_| |_|_===__|    
   oo  oo ~ oo   oo ~ oo   oo ~ ooo ooo~ o OOOO =o\   
============================================================
Perform random acts of kindness and senseless beauty...


-----Original Message-----
From: Greg Bradner [mailto:gregb@rhythm.com] 
Sent: Thursday, October 23, 2003 09:06
To: autofs@linux.kernel.org
Subject: [autofs] autofs v4

It is not making the mount  points for program mounts. Any ideas?

This is from /etc/auto_maps/autofs_host_mount.pl, my program for program 
mounts.
PARGS /usr/sbin/automount --timeout 60 /n program 
/etc/auto_maps/autofs_host_mount.pl vers=2,mountvers=2 
rsize=32768,wsize=32768
TEST = --timeout
TEST = 60
TEST = /n
BASEDIR = /n (2)
MOUNT OPTS: -o  vers=2,mountvers=2,rsize=32768,wsize=32768
am_mount -o  vers=2,mountvers=2,rsize=32768,wsize=32768 linn:/etc 
/n/linn/etc
am_mount -o  vers=2,mountvers=2,rsize=32768,wsize=32768 linn:/usr 
/n/linn/usr
am_mount -o  vers=2,mountvers=2,rsize=32768,wsize=32768 linn:/local/b 
/n/linn/local/b
am_mount -o  vers=2,mountvers=2,rsize=32768,wsize=32768 linn:/local/a 
/n/linn/local/a
/n/linn

[34] lid2:/# tail /var/log/messages
Oct 23 08:55:50 lid2 am_mount[11720]: am_mount /n/linn/usr
Oct 23 08:55:50 lid2 automount[2281]: attempting to mount entry /n/linn
Oct 23 08:55:50 lid2 am_mount[11725]: am_mount /n/linn/etc
Oct 23 08:55:50 lid2 am_mount[11726]: am_mount /n/linn/usr
Oct 23 08:55:50 lid2 am_mount[11727]: am_mount /n/linn/local/b
Oct 23 08:55:50 lid2 am_mount[11728]: am_mount /n/linn/local/a
Oct 23 08:55:50 lid2 automount[11722]: >> mount: wrong fs type, bad 
option, bad superblock on ,
Oct 23 08:55:50 lid2 automount[11722]: >>        or too many mounted 
file systems


_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs
