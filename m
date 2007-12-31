From: Jim Duda <jim@duda.tzo.com>
Subject: automount won't start - just hangs
Date: Mon, 31 Dec 2007 17:03:25 -0500
Message-ID: <flbove$pg9$1@ger.gmane.org>
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

I'm attempting to use autofs on some diskless machines which operate 
using an NFS mounted root file system.  I have three different computers 
which share the same root file system (with unique /tmp and /var 
directories) and the same 2.6.22 kernel.

I want to use autofs for removable USB memory sticks.

On one machine, I can use autofs just fine.  Autofs mounts and unmounts 
the usb sticks as I expect it to.  Works nice.

However, on the other two machines, I cannot get automount to start.  It 
simply hangs upon startup, I cannot ^C to exit or anything.  I have to 
kill -9 the process.

I cannot figure out what automount is looking for, and not getting, 
which would cause it to hang.  I've attempted to use gdb to help me find 
the problem, but I haven't had much luck.  (I've downloaded the most 
recent 5.0.2 tar bar and build automount with -g to debug.

I'm hoping someone might shed some light on how best to debug this issue.

On the two machines which fail, I see this message appear on the NFS 
server which is serving up the root file system.

Dec 31 16:05:50 linux mountd[2130]: authenticated unmount request from 
asterisk:621 for /tftpboot/muekow/i386 (/tftpboot/muekow)

I don't see any such message on the machine which works properly (the 
only clue I currently have).

On the diskless machines, I have these mount points already defined 
before I attempt to start automount.

192.168.1.254:/tftpboot/muekow/i386 on /nfsroot type nfs 
(rw,vers=3,rsize=32768,wsize=32768,hard,nolock,proto=udp,timeo=7,retrans=3,sec=sys,addr=192.168.1.254)
none on /proc type proc (rw)
none on /dev type tmpfs (rw)
/sys on /sys type sysfs (rw)
none on /proc/bus/usb type usbfs (rw)
192.168.1.254:/home on /home type nfs 
(rw,vers=3,rsize=32768,wsize=32768,hard,nolock,proto=udp,timeo=7,retrans=3,sec=sys,addr=192.168.1.254)
192.168.1.254:/media on /media type nfs 
(rw,vers=3,rsize=32768,wsize=32768,hard,nolock,proto=udp,timeo=7,retrans=3,sec=sys,addr=192.168.1.254)

Does automount for any reason attempt to unmount nfs mount points which 
are already in place?

Thanks for any advice, I'm really stumped as to why automount won't start.

Jim
