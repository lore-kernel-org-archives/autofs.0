From: Terrence Martin <tmartin@physics.ucsd.edu>
Subject: Re: 	Is it normal for autofs to remount a file system more
	than once?
Date: Fri, 03 Sep 2004 01:01:54 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <413824F2.5040603@physics.ucsd.edu>
References: <41379549.2040305@physics.ucsd.edu> <4137DB6E.3020204@sun.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4137DB6E.3020204@sun.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: autofs@linux.kernel.org

Hi,

Aparently it looks like I have a problem

cat /proc/mounts
automount(pid4347) /home autofs rw 0 0
192.168.20.3:/home/cdfcaf /home/cdfcaf nfs 
rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=192.168.20.3 0 0
192.168.20.3:/home/cdfsoft /home/cdfsoft nfs 
rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=192.168.20.3 0 0
192.168.10.5:/falcon/0/users /home/users nfs 
rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=192.168.10.5 0 0
automount(pid23831) /home autofs rw 0 0
192.168.20.3:/home/cdfcaf /home/cdfcaf nfs 
rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=192.168.20.3 0 0
192.168.20.3:/home/cdfsoft /home/cdfsoft nfs 
rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=192.168.20.3 0 0
automount(pid18432) /home autofs rw 0 0
192.168.20.3:/home/cdfcaf /home/cdfcaf nfs 
rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=192.168.20.3 0 0
192.168.20.3:/home/cdfsoft /home/cdfsoft nfs 
rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=192.168.20.3 0 0
frontend-3.local:/export/home/install /home/install nfs 
rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=frontend-3.local 0 0
automount(pid29678) /home autofs rw 0 0
192.168.10.5:/falcon/0/users /home/users nfs 
rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=192.168.10.5 0 0
automount(pid3017) /home autofs rw 0 0
automount(pid3047) /netstor autofs rw 0 0
automount(pid3077) /afs autofs rw 0 0
automount(pid3105) /groot autofs rw 0 0
192.168.10.5:/falcon/0/users /home/users nfs 
rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=192.168.10.5 0 0
frontend-3.local:/export/home/install /home/install nfs 
rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=frontend-3.local 0 0
192.168.20.3:/home/cdfsoft /home/cdfsoft nfs 
rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=192.168.20.3 0 0

Several entries occure more than once.

I am not sure what you are meaning by multiple name spaces with regards 
to autofs?

Also my kernel is a RedHat RHEL3 stock kernel.

uname -a
Linux compute-3-4.local 2.4.21-4.0.1.ELsmp #1 SMP Sat Nov 29 04:15:49 
GMT 2003 i686 i686 i386 GNU/Linux

Autofs version 3.1.7-41

Terrence

Mike Waychison wrote:

>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>Terrence Martin wrote:
>  
>
>>Hi,
>>
>>I am not sure if this is related to my NFS mount hanging problems, but I
>>have noticed that autofs will often remount a file system multiple
>>times.  Is this normal? I think I have pretty straight forward auto.
>>files....
>>
>>Terrence Martin
>>UCSD Physics
>>
>>mount
>>    
>>
>
>  
>
>>df
>>    
>>
>
>
>Both of these tools get their mount information from /etc/mtab, a plain
>text file.  This file can get out of sync for a variety of reasons
>unfortunately.  Some common reasons I usually see are:
>
>- - You may be using multiple namespaces.  [u]mount(8) doesn't know how to
>handle this.
>- - [u]mount(8) has trouble getting a lock on the file, so it has trouble
>updating.
>
>The only way to see an accurate picture of your mount tree is to look at
>/proc/mounts.  If this file has multiple entries for your automounted
>filesystem, then there indeed is a problem.
>
>Btw, you didn't mention which kernel(+patches?) and automount version
>are you using.  That would help :)
>
>Thanks,
>
>- --
>Mike Waychison
>Sun Microsystems, Inc.
>1 (650) 352-5299 voice
>1 (416) 202-8336 voice
>http://www.sun.com
>
>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>NOTICE:  The opinions expressed in this email are held by me,
>and may not represent the views of Sun Microsystems, Inc.
>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>-----BEGIN PGP SIGNATURE-----
>Version: GnuPG v1.2.4 (GNU/Linux)
>
>iD8DBQFBN9ttdQs4kOxk3/MRAnxeAJ9EU/vVu0J2OIl8hjFPWWkGd6IvMACeMkY5
>VUKsB/GK2poT2NBx5AEZD30=
>=AqLw
>-----END PGP SIGNATURE-----
>
>  
>
