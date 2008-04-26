From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: clients suddenly start hanging (was: (no subject))
Date: Sat, 26 Apr 2008 15:16:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0804261511180.13820@xena.cft.ca.us>
References: <20080423185018.122C53C3B1@xena.cft.ca.us> 
	<20080426011727.BBE6CF8E2B@serval.math.ucla.edu>
	<1209188097.3120.27.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1209188097.3120.27.camel@raven.themaw.net>
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
content-type: text/plain
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Sat, 26 Apr 2008, Ian Kent wrote:

> Pity those backtraces don't have symbols for the threads that are
> probably the important ones.

OK, I got failures, with complete symbols!  Sorry for the big pile of 
output (6 traces) but this time it may be useful.  

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)

11:52:21 --                   #1, chkd 0, run 0, OK 561, mtd 2, of 561

=----- gdb backtrace of all threads -----
[?1034hGNU gdb 6.6.50.20070726-cvs
Copyright (C) 2007 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i586-suse-linux"...
Using host libthread_db library "/lib/libthread_db.so.1".
Attaching to program: /usr/sbin/automount, process 15086
Loaded symbols for /usr/sbin/automount
Reading symbols from /lib/libpthread.so.0...done.
[Thread debugging using libthread_db enabled]
[New Thread 0xb7e0c6c0 (LWP 15086)]
[New Thread 0xb724bb90 (LWP 15101)]
[New Thread 0xb7a4cb90 (LWP 15096)]
[New Thread 0xb7ca2b90 (LWP 15094)]
[New Thread 0xb7dfab90 (LWP 15091)]
[New Thread 0xb7e0bb90 (LWP 15088)]
[New Thread 0xb7f79b90 (LWP 15087)]
Loaded symbols for /lib/libpthread.so.0
Reading symbols from /lib/libdl.so.2...done.
Loaded symbols for /lib/libdl.so.2
Reading symbols from /lib/libc.so.6...done.
Loaded symbols for /lib/libc.so.6
Reading symbols from /lib/ld-linux.so.2...done.
Loaded symbols for /lib/ld-linux.so.2
Reading symbols from /usr/lib/autofs/lookup_file.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/lookup_file.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/lookup_file.so
Reading symbols from /lib/libnsl.so.1...done.
Loaded symbols for /lib/libnsl.so.1
Reading symbols from /usr/lib/autofs/parse_sun.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/parse_sun.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/parse_sun.so
Reading symbols from /usr/lib/autofs/mount_nfs.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/mount_nfs.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/mount_nfs.so
Reading symbols from /usr/lib/autofs/mount_bind.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/mount_bind.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/mount_bind.so
Reading symbols from /usr/lib/autofs/lookup_yp.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/lookup_yp.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/lookup_yp.so
Reading symbols from /lib/libnss_compat.so.2...done.
Loaded symbols for /lib/libnss_compat.so.2
Reading symbols from /lib/libnss_nis.so.2...done.
Loaded symbols for /lib/libnss_nis.so.2
Reading symbols from /lib/libnss_files.so.2...done.
Loaded symbols for /lib/libnss_files.so.2
Reading symbols from /lib/libnss_dns.so.2...done.
Loaded symbols for /lib/libnss_dns.so.2
Reading symbols from /lib/libresolv.so.2...done.
Loaded symbols for /lib/libresolv.so.2
0xffffe410 in __kernel_vsyscall ()
(gdb) Hangup detected on fd 0
error detected on stdin
The program is running.  Quit anyway (and detach it)? (y or n) [answered Y; input not from terminal]
Detaching from program: /usr/sbin/automount, process 15086
=----- end of backtrace -----
11:54:43 --                   #2, chkd 559, run 0, OK 197, mtd 197, of 197

11:54:43 --                   #3, chkd 559, run 0, OK 197, mtd 197, of 197

12:04:48 /net/bamboo43/m2     mtab: /net/bamboo43/m2 <=> mounts: 
12:04:57 /net/bamboo33/m1     mtab: /net/bamboo40/h1 <=> mounts: 
12:06:29 /net/bamboo08/m2     mtab: /net/bamboo04/h1 <=> mounts: 
12:06:29 --                   #345, chkd 650, run 0, OK 197, mtd 196, of 197

12:06:53 /net/rangers/m1      mtab: /net/daggett/m1 <=> mounts: 
12:07:34 --                   #372, chkd 700, run 0, OK 197, mtd 197, of 197

12:08:33 --                   #384, chkd 756, run 0, OK 197, mtd 197, of 197

12:22:28 /net/papyrus70/m1    hung
12:22:28 /net/papyrus70/h1    hung
12:22:28 --                   #786, chkd 767, run 2, OK 195, mtd 183, of 197

=----- gdb backtrace of all threads -----
[?1034hGNU gdb 6.6.50.20070726-cvs
Copyright (C) 2007 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i586-suse-linux"...
Using host libthread_db library "/lib/libthread_db.so.1".
Attaching to program: /usr/sbin/automount, process 15086
Loaded symbols for /usr/sbin/automount
Reading symbols from /lib/libpthread.so.0...done.
[Thread debugging using libthread_db enabled]
[New Thread 0xb7e0c6c0 (LWP 15086)]
[New Thread 0xa6f0fb90 (LWP 19767)]
[New Thread 0x78ff1b90 (LWP 17015)]
[New Thread 0x797f2b90 (LWP 16915)]
[New Thread 0x79ff3b90 (LWP 16909)]
[New Thread 0x7b7f6b90 (LWP 16775)]
[New Thread 0x7bff7b90 (LWP 16750)]
[New Thread 0x7cff9b90 (LWP 16680)]
[New Thread 0x7d7fab90 (LWP 16670)]
[New Thread 0x7dffbb90 (LWP 16656)]
[New Thread 0x7e7fcb90 (LWP 16544)]
[New Thread 0x7effdb90 (LWP 16506)]
[New Thread 0x7f7feb90 (LWP 16496)]
[New Thread 0x7ffffb90 (LWP 16464)]
[New Thread 0x80cbab90 (LWP 16456)]
[New Thread 0x814bbb90 (LWP 16372)]
[New Thread 0x81cbcb90 (LWP 16366)]
[New Thread 0x824bdb90 (LWP 16338)]
[New Thread 0x82cbeb90 (LWP 16316)]
[New Thread 0x834bfb90 (LWP 16215)]
[New Thread 0x83cc0b90 (LWP 16209)]
[New Thread 0x84cc2b90 (LWP 16153)]
[New Thread 0x854c3b90 (LWP 16139)]
[New Thread 0x85cc4b90 (LWP 16133)]
[New Thread 0x864c5b90 (LWP 16107)]
[New Thread 0x86cc6b90 (LWP 16047)]
[New Thread 0x874c7b90 (LWP 16041)]
[New Thread 0x87cc8b90 (LWP 16023)]
[New Thread 0x88ccab90 (LWP 16009)]
[New Thread 0x894cbb90 (LWP 15985)]
[New Thread 0x89cccb90 (LWP 15975)]
[New Thread 0x8a4cdb90 (LWP 15937)]
[New Thread 0x8acceb90 (LWP 15927)]
[New Thread 0x8b4cfb90 (LWP 15909)]
[New Thread 0x8bcd0b90 (LWP 15887)]
[New Thread 0x8c4d1b90 (LWP 15869)]
[New Thread 0x8ccd2b90 (LWP 15863)]
[New Thread 0x8d4d3b90 (LWP 15851)]
[New Thread 0x8dcd4b90 (LWP 15841)]
[New Thread 0x8e4d5b90 (LWP 15827)]
[New Thread 0x8ecd6b90 (LWP 15821)]
[New Thread 0x8f4d7b90 (LWP 15813)]
[New Thread 0x904d9b90 (LWP 15793)]
[New Thread 0x90cdab90 (LWP 15775)]
[New Thread 0x914dbb90 (LWP 15769)]
[New Thread 0x924ddb90 (LWP 15717)]
[New Thread 0x92cdeb90 (LWP 15697)]
[New Thread 0x93ce0b90 (LWP 15675)]
[New Thread 0x94ce2b90 (LWP 15641)]
[New Thread 0x954e3b90 (LWP 15623)]
[New Thread 0x95ce4b90 (LWP 15597)]
[New Thread 0x964e5b90 (LWP 15587)]
[New Thread 0x96ce6b90 (LWP 15581)]
[New Thread 0x974e7b90 (LWP 15575)]
[New Thread 0x984e9b90 (LWP 15537)]
[New Thread 0x98ceab90 (LWP 15531)]
[New Thread 0x994ebb90 (LWP 15525)]
[New Thread 0x99cecb90 (LWP 15511)]
[New Thread 0x9a4edb90 (LWP 15497)]
[New Thread 0x9aceeb90 (LWP 15491)]
[New Thread 0x9b4efb90 (LWP 15485)]
[New Thread 0x9c5f2b90 (LWP 15475)]
[New Thread 0x9cef4b90 (LWP 15463)]
[New Thread 0x9d6f5b90 (LWP 15445)]
[New Thread 0x9e7f8b90 (LWP 15427)]
[New Thread 0xa01fdb90 (LWP 15408)]
[New Thread 0xa1c02b90 (LWP 15394)]
[New Thread 0xa2403b90 (LWP 15388)]
[New Thread 0xa3405b90 (LWP 15374)]
[New Thread 0xa3c06b90 (LWP 15360)]
[New Thread 0xa4407b90 (LWP 15350)]
[New Thread 0xa560bb90 (LWP 15336)]
[New Thread 0xa5e0cb90 (LWP 15330)]
[New Thread 0xa660db90 (LWP 15320)]
[New Thread 0xa6e0eb90 (LWP 15314)]
[New Thread 0xa7f11b90 (LWP 15304)]
[New Thread 0xa8712b90 (LWP 15298)]
[New Thread 0xa9815b90 (LWP 15288)]
[New Thread 0xaa016b90 (LWP 15282)]
[New Thread 0xaa817b90 (LWP 15276)]
[New Thread 0xab018b90 (LWP 15270)]
[New Thread 0xab819b90 (LWP 15264)]
[New Thread 0xac01ab90 (LWP 15257)]
[New Thread 0xad11db90 (LWP 15239)]
[New Thread 0xad91eb90 (LWP 15233)]
[New Thread 0xae11fb90 (LWP 15227)]
[New Thread 0xae920b90 (LWP 15221)]
[New Thread 0xaf121b90 (LWP 15215)]
[New Thread 0xaf922b90 (LWP 15209)]
[New Thread 0xb0123b90 (LWP 15203)]
[New Thread 0xb0924b90 (LWP 15197)]
[New Thread 0xb1125b90 (LWP 15191)]
[New Thread 0xb1926b90 (LWP 15185)]
[New Thread 0xb2928b90 (LWP 15165)]
[New Thread 0xb3a2bb90 (LWP 15155)]
[New Thread 0xb422cb90 (LWP 15149)]
[New Thread 0xb4a2db90 (LWP 15143)]
[New Thread 0xb522eb90 (LWP 15133)]
[New Thread 0xb5a2fb90 (LWP 15127)]
[New Thread 0xb6230b90 (LWP 15121)]
[New Thread 0xb6a31b90 (LWP 15115)]
[New Thread 0xb724bb90 (LWP 15101)]
[New Thread 0xb7a4cb90 (LWP 15096)]
[New Thread 0xb7ca2b90 (LWP 15094)]
[New Thread 0xb7dfab90 (LWP 15091)]
[New Thread 0xb7e0bb90 (LWP 15088)]
[New Thread 0xb7f79b90 (LWP 15087)]
Loaded symbols for /lib/libpthread.so.0
Reading symbols from /lib/libdl.so.2...done.
Loaded symbols for /lib/libdl.so.2
Reading symbols from /lib/libc.so.6...done.
Loaded symbols for /lib/libc.so.6
Reading symbols from /lib/ld-linux.so.2...done.
Loaded symbols for /lib/ld-linux.so.2
Reading symbols from /usr/lib/autofs/lookup_file.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/lookup_file.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/lookup_file.so
Reading symbols from /lib/libnsl.so.1...done.
Loaded symbols for /lib/libnsl.so.1
Reading symbols from /usr/lib/autofs/parse_sun.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/parse_sun.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/parse_sun.so
Reading symbols from /usr/lib/autofs/mount_nfs.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/mount_nfs.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/mount_nfs.so
Reading symbols from /usr/lib/autofs/mount_bind.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/mount_bind.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/mount_bind.so
Reading symbols from /usr/lib/autofs/lookup_yp.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/lookup_yp.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/lookup_yp.so
Reading symbols from /lib/libnss_compat.so.2...done.
Loaded symbols for /lib/libnss_compat.so.2
Reading symbols from /lib/libnss_nis.so.2...done.
Loaded symbols for /lib/libnss_nis.so.2
Reading symbols from /lib/libnss_files.so.2...done.
Loaded symbols for /lib/libnss_files.so.2
Reading symbols from /lib/libnss_dns.so.2...done.
Loaded symbols for /lib/libnss_dns.so.2
Reading symbols from /lib/libresolv.so.2...done.
Loaded symbols for /lib/libresolv.so.2
Reading symbols from /lib/libgcc_s.so.1...done.
Loaded symbols for /lib/libgcc_s.so.1
0xffffe410 in __kernel_vsyscall ()
(gdb) (gdb) 
Thread 107 (Thread 0xb7f79b90 (LWP 15087)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f4d7ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib/libpthread.so.0
#2  0x8001e0a3 in alarm_handler (arg=0x0) at alarm.c:202
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 106 (Thread 0xb7e0bb90 (LWP 15088)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f4d7ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib/libpthread.so.0
#2  0x800179c9 in st_queue_handler (arg=0x0) at state.c:947
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 105 (Thread 0xb7dfab90 (LWP 15091)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8004ce60) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 104 (Thread 0xb7ca2b90 (LWP 15094)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8004d458) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 103 (Thread 0xb7a4cb90 (LWP 15096)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8004e598) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 102 (Thread 0xb724bb90 (LWP 15101)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8004f848) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 101 (Thread 0xb6a31b90 (LWP 15115)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80065758) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 100 (Thread 0xb6230b90 (LWP 15121)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80066108) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 99 (Thread 0xb5a2fb90 (LWP 15127)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800669e8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 98 (Thread 0xb522eb90 (LWP 15133)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800672a8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 97 (Thread 0xb4a2db90 (LWP 15143)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80067b68) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 96 (Thread 0xb422cb90 (LWP 15149)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800684c0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 95 (Thread 0xb3a2bb90 (LWP 15155)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80068d70) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 94 (Thread 0xb2928b90 (LWP 15165)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006a610) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 93 (Thread 0xb1926b90 (LWP 15185)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006b920) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 92 (Thread 0xb1125b90 (LWP 15191)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006c1d0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 91 (Thread 0xb0924b90 (LWP 15197)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006caa0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 90 (Thread 0xb0123b90 (LWP 15203)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006d400) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 89 (Thread 0xaf922b90 (LWP 15209)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006dca8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 88 (Thread 0xaf121b90 (LWP 15215)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006e698) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 87 (Thread 0xae920b90 (LWP 15221)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006ae60) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 86 (Thread 0xae11fb90 (LWP 15227)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006f7a8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 85 (Thread 0xad91eb90 (LWP 15233)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800700d8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 84 (Thread 0xad11db90 (LWP 15239)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006eeb0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 83 (Thread 0xac01ab90 (LWP 15257)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800722f8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 82 (Thread 0xab819b90 (LWP 15264)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80072c38) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 81 (Thread 0xab018b90 (LWP 15270)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80073578) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 80 (Thread 0xaa817b90 (LWP 15276)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80073da8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 79 (Thread 0xaa016b90 (LWP 15282)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80074700) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 78 (Thread 0xa9815b90 (LWP 15288)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80074fc0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 77 (Thread 0xa8712b90 (LWP 15298)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80076808) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 76 (Thread 0xa7f11b90 (LWP 15304)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80077100) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 75 (Thread 0xa6e0eb90 (LWP 15314)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800789b0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 74 (Thread 0xa660db90 (LWP 15320)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800792a8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 73 (Thread 0xa5e0cb90 (LWP 15330)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80079be0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 72 (Thread 0xa560bb90 (LWP 15336)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8007a528) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 71 (Thread 0xa4407b90 (LWP 15350)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80076500) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 70 (Thread 0xa3c06b90 (LWP 15360)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8007c818) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 69 (Thread 0xa3405b90 (LWP 15374)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8007d140) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 68 (Thread 0xa2403b90 (LWP 15388)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8007e990) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 67 (Thread 0xa1c02b90 (LWP 15394)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8007f2f0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 66 (Thread 0xa01fdb90 (LWP 15408)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80081708) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 65 (Thread 0x9e7f8b90 (LWP 15427)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80083f90) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 64 (Thread 0x9d6f5b90 (LWP 15445)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80085818) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 63 (Thread 0x9cef4b90 (LWP 15463)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800855d0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 62 (Thread 0x9c5f2b90 (LWP 15475)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80086e90) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 61 (Thread 0x9b4efb90 (LWP 15485)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800886d0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 60 (Thread 0x9aceeb90 (LWP 15491)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80088fd8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 59 (Thread 0x9a4edb90 (LWP 15497)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80089950) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 58 (Thread 0x99cecb90 (LWP 15511)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80076358) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 57 (Thread 0x994ebb90 (LWP 15525)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80086ae8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 56 (Thread 0x98ceab90 (LWP 15531)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8008ab68) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 55 (Thread 0x984e9b90 (LWP 15537)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8008b460) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 54 (Thread 0x974e7b90 (LWP 15575)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8008c798) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 53 (Thread 0x96ce6b90 (LWP 15581)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8008c588) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 52 (Thread 0x964e5b90 (LWP 15587)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8008d6d8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 51 (Thread 0x95ce4b90 (LWP 15597)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8007e608) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 50 (Thread 0x954e3b90 (LWP 15623)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8008c4b0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 49 (Thread 0x94ce2b90 (LWP 15641)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80071250) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 48 (Thread 0x93ce0b90 (LWP 15675)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80071d98) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 47 (Thread 0x92cdeb90 (LWP 15697)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80071b80) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 46 (Thread 0x924ddb90 (LWP 15717)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80080400) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 45 (Thread 0x914dbb90 (LWP 15769)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80092808) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 44 (Thread 0x90cdab90 (LWP 15775)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80083c78) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 43 (Thread 0x904d9b90 (LWP 15793)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80086150) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 42 (Thread 0x8f4d7b90 (LWP 15813)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80095518) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 41 (Thread 0x8ecd6b90 (LWP 15821)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80090b28) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 40 (Thread 0x8e4d5b90 (LWP 15827)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80096a70) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 39 (Thread 0x8dcd4b90 (LWP 15841)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800961a8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 38 (Thread 0x8d4d3b90 (LWP 15851)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80071f98) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 37 (Thread 0x8ccd2b90 (LWP 15863)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80098590) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 36 (Thread 0x8c4d1b90 (LWP 15869)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8008fff8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 35 (Thread 0x8bcd0b90 (LWP 15887)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8008c0a8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 34 (Thread 0x8b4cfb90 (LWP 15909)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800999a8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 33 (Thread 0x8acceb90 (LWP 15927)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80098310) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 32 (Thread 0x8a4cdb90 (LWP 15937)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8009ab68) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 31 (Thread 0x89cccb90 (LWP 15975)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80078608) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 30 (Thread 0x894cbb90 (LWP 15985)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8009b908) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 29 (Thread 0x88ccab90 (LWP 16009)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8009c1b0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 28 (Thread 0x87cc8b90 (LWP 16023)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8009d020) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 27 (Thread 0x874c7b90 (LWP 16041)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8009d9f0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 26 (Thread 0x86cc6b90 (LWP 16047)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8009e280) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 25 (Thread 0x864c5b90 (LWP 16107)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800937f8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 24 (Thread 0x85cc4b90 (LWP 16133)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80092240) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 23 (Thread 0x854c3b90 (LWP 16139)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8009fe50) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 22 (Thread 0x84cc2b90 (LWP 16153)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a06a0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 21 (Thread 0x83cc0b90 (LWP 16209)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a2448) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 20 (Thread 0x834bfb90 (LWP 16215)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a2d98) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 19 (Thread 0x82cbeb90 (LWP 16316)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a3d00) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 18 (Thread 0x824bdb90 (LWP 16338)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a3900) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 17 (Thread 0x81cbcb90 (LWP 16366)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a1af0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 16 (Thread 0x814bbb90 (LWP 16372)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a5290) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 15 (Thread 0x80cbab90 (LWP 16456)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a7878) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 14 (Thread 0x7ffffb90 (LWP 16464)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a8698) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 13 (Thread 0x7f7feb90 (LWP 16496)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a7660) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 12 (Thread 0x7effdb90 (LWP 16506)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a9a58) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 11 (Thread 0x7e7fcb90 (LWP 16544)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800aa820) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 10 (Thread 0x7dffbb90 (LWP 16656)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a45b8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 9 (Thread 0x7d7fab90 (LWP 16670)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800ab3f0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 8 (Thread 0x7cff9b90 (LWP 16680)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800abc48) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 7 (Thread 0x7bff7b90 (LWP 16750)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800acb20) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 6 (Thread 0x7b7f6b90 (LWP 16775)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800bd518) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 5 (Thread 0x79ff3b90 (LWP 16909)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800c00d0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 4 (Thread 0x797f2b90 (LWP 16915)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800c0a70) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 3 (Thread 0x78ff1b90 (LWP 17015)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800ad2f0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 2 (Thread 0xa6f0fb90 (LWP 19767)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f4d566 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib/libpthread.so.0
#2  0x80022015 in master_notify_submount (ap=0x8004ce60, 
    path=0x800972a0 "/net/bamboo20", state=ST_EXPIRE) at master.c:885
#3  0x8000bcc1 in expire_proc_indirect (arg=0x8008ebf8) at indirect.c:477
#4  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#5  0xb7ed002e in clone () from /lib/libc.so.6

Thread 1 (Thread 0xb7e0c6c0 (LWP 15086)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f512aa in do_sigwait () from /lib/libpthread.so.0
#2  0xb7f5134f in sigwait () from /lib/libpthread.so.0
#3  0x80007ad9 in main (argc=1, argv=<value optimized out>) at automount.c:1046
#0  0xffffe410 in __kernel_vsyscall ()
(gdb) Hangup detected on fd 0
error detected on stdin
The program is running.  Quit anyway (and detach it)? (y or n) [answered Y; input not from terminal]
Detaching from program: /usr/sbin/automount, process 15086
=----- end of backtrace -----
12:22:36 /net/bamboo24/m2     mtab: /net/bamboo24/m2 <=> mounts: 
12:22:56 /net/bamboo27/m1     mtab: /net/bamboo01/h1 <=> mounts: 
12:22:56 /net/bamboo01/m1     mtab: /net/bamboo01/m2 <=> mounts: 
12:23:40 --                   #814, chkd 852, run 2, OK 195, mtd 191, of 197

12:24:50 /net/spruce/m1       mtab: /net/laguna/m1 <=> mounts: 
12:25:22 /net/cedar/h1        failed
12:25:22 /net/cedar/s1        failed
12:25:27 /net/sumac/s1        mtab: /net/julia/s3 <=> mounts: 
12:25:29 --                   #846, chkd 954, run 2, OK 193, mtd 190, of 197

12:25:36 /net/pong/m2         failed
12:25:43 /net/lodi/m1         failed
12:25:48 /net/zuma/h1         failed
12:25:48 /net/zuma/m1         failed
12:39:14 /net/naseberry/m1    failed
12:39:39 /net/bamboo43/m2     failed
12:40:04 /net/bamboo43/m1     hung
12:40:04 --                   #1265, chkd 993, run 3, OK 186, mtd 169, of 197

=----- gdb backtrace of all threads -----
[?1034hGNU gdb 6.6.50.20070726-cvs
Copyright (C) 2007 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i586-suse-linux"...
Using host libthread_db library "/lib/libthread_db.so.1".
Attaching to program: /usr/sbin/automount, process 15086
Loaded symbols for /usr/sbin/automount
Reading symbols from /lib/libpthread.so.0...done.
[Thread debugging using libthread_db enabled]
[New Thread 0xb7e0c6c0 (LWP 15086)]
[New Thread 0xa4508b90 (LWP 22195)]
[New Thread 0x87cc8b90 (LWP 21950)]
[New Thread 0x9aceeb90 (LWP 21917)]
[New Thread 0xa6f0fb90 (LWP 21907)]
[New Thread 0x98ceab90 (LWP 21591)]
[New Thread 0x94ce2b90 (LWP 21567)]
[New Thread 0xb0123b90 (LWP 21472)]
[New Thread 0xb2127b90 (LWP 21448)]
[New Thread 0xb322ab90 (LWP 21438)]
[New Thread 0xb422cb90 (LWP 21432)]
[New Thread 0xb4a2db90 (LWP 21415)]
[New Thread 0x8acceb90 (LWP 21397)]
[New Thread 0x8c4d1b90 (LWP 21387)]
[New Thread 0x9e7f8b90 (LWP 21376)]
[New Thread 0x914dbb90 (LWP 21370)]
[New Thread 0x924ddb90 (LWP 21363)]
[New Thread 0x984e9b90 (LWP 21098)]
[New Thread 0x8f4d7b90 (LWP 21069)]
[New Thread 0x854c3b90 (LWP 20999)]
[New Thread 0x824bdb90 (LWP 20832)]
[New Thread 0x797f2b90 (LWP 20757)]
[New Thread 0xb1125b90 (LWP 20681)]
[New Thread 0xa5e0cb90 (LWP 20491)]
[New Thread 0xa560bb90 (LWP 20466)]
[New Thread 0x81cbcb90 (LWP 20083)]
[New Thread 0x7d7fab90 (LWP 19994)]
[New Thread 0x7a7f4b90 (LWP 19946)]
[New Thread 0x7aff5b90 (LWP 19928)]
[New Thread 0x7bff7b90 (LWP 16750)]
[New Thread 0x7f7feb90 (LWP 16496)]
[New Thread 0x7ffffb90 (LWP 16464)]
[New Thread 0x80cbab90 (LWP 16456)]
[New Thread 0x83cc0b90 (LWP 16209)]
[New Thread 0x85cc4b90 (LWP 16133)]
[New Thread 0x864c5b90 (LWP 16107)]
[New Thread 0x86cc6b90 (LWP 16047)]
[New Thread 0x874c7b90 (LWP 16041)]
[New Thread 0x88ccab90 (LWP 16009)]
[New Thread 0x894cbb90 (LWP 15985)]
[New Thread 0x89cccb90 (LWP 15975)]
[New Thread 0x8a4cdb90 (LWP 15937)]
[New Thread 0x8b4cfb90 (LWP 15909)]
[New Thread 0x8bcd0b90 (LWP 15887)]
[New Thread 0x8ccd2b90 (LWP 15863)]
[New Thread 0x8d4d3b90 (LWP 15851)]
[New Thread 0x8dcd4b90 (LWP 15841)]
[New Thread 0x8e4d5b90 (LWP 15827)]
[New Thread 0x8ecd6b90 (LWP 15821)]
[New Thread 0x904d9b90 (LWP 15793)]
[New Thread 0x90cdab90 (LWP 15775)]
[New Thread 0x92cdeb90 (LWP 15697)]
[New Thread 0x93ce0b90 (LWP 15675)]
[New Thread 0x954e3b90 (LWP 15623)]
[New Thread 0x95ce4b90 (LWP 15597)]
[New Thread 0x964e5b90 (LWP 15587)]
[New Thread 0x96ce6b90 (LWP 15581)]
[New Thread 0x974e7b90 (LWP 15575)]
[New Thread 0x994ebb90 (LWP 15525)]
[New Thread 0x99cecb90 (LWP 15511)]
[New Thread 0x9a4edb90 (LWP 15497)]
[New Thread 0x9b4efb90 (LWP 15485)]
[New Thread 0x9c5f2b90 (LWP 15475)]
[New Thread 0x9cef4b90 (LWP 15463)]
[New Thread 0x9d6f5b90 (LWP 15445)]
[New Thread 0xa01fdb90 (LWP 15408)]
[New Thread 0xa1c02b90 (LWP 15394)]
[New Thread 0xa2403b90 (LWP 15388)]
[New Thread 0xa3405b90 (LWP 15374)]
[New Thread 0xa3c06b90 (LWP 15360)]
[New Thread 0xa660db90 (LWP 15320)]
[New Thread 0xa6e0eb90 (LWP 15314)]
[New Thread 0xa7f11b90 (LWP 15304)]
[New Thread 0xa8712b90 (LWP 15298)]
[New Thread 0xa9815b90 (LWP 15288)]
[New Thread 0xaa016b90 (LWP 15282)]
[New Thread 0xaa817b90 (LWP 15276)]
[New Thread 0xab018b90 (LWP 15270)]
[New Thread 0xab819b90 (LWP 15264)]
[New Thread 0xac01ab90 (LWP 15257)]
[New Thread 0xad11db90 (LWP 15239)]
[New Thread 0xad91eb90 (LWP 15233)]
[New Thread 0xae11fb90 (LWP 15227)]
[New Thread 0xae920b90 (LWP 15221)]
[New Thread 0xaf121b90 (LWP 15215)]
[New Thread 0xaf922b90 (LWP 15209)]
[New Thread 0xb1926b90 (LWP 15185)]
[New Thread 0xb2928b90 (LWP 15165)]
[New Thread 0xb3a2bb90 (LWP 15155)]
[New Thread 0xb522eb90 (LWP 15133)]
[New Thread 0xb5a2fb90 (LWP 15127)]
[New Thread 0xb6230b90 (LWP 15121)]
[New Thread 0xb724bb90 (LWP 15101)]
[New Thread 0xb7ca2b90 (LWP 15094)]
[New Thread 0xb7dfab90 (LWP 15091)]
[New Thread 0xb7e0bb90 (LWP 15088)]
[New Thread 0xb7f79b90 (LWP 15087)]
Loaded symbols for /lib/libpthread.so.0
Reading symbols from /lib/libdl.so.2...done.
Loaded symbols for /lib/libdl.so.2
Reading symbols from /lib/libc.so.6...done.
Loaded symbols for /lib/libc.so.6
Reading symbols from /lib/ld-linux.so.2...done.
Loaded symbols for /lib/ld-linux.so.2
Reading symbols from /usr/lib/autofs/lookup_file.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/lookup_file.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/lookup_file.so
Reading symbols from /lib/libnsl.so.1...done.
Loaded symbols for /lib/libnsl.so.1
Reading symbols from /usr/lib/autofs/parse_sun.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/parse_sun.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/parse_sun.so
Reading symbols from /usr/lib/autofs/mount_nfs.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/mount_nfs.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/mount_nfs.so
Reading symbols from /usr/lib/autofs/mount_bind.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/mount_bind.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/mount_bind.so
Reading symbols from /usr/lib/autofs/lookup_yp.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/lookup_yp.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/lookup_yp.so
Reading symbols from /lib/libnss_compat.so.2...done.
Loaded symbols for /lib/libnss_compat.so.2
Reading symbols from /lib/libnss_nis.so.2...done.
Loaded symbols for /lib/libnss_nis.so.2
Reading symbols from /lib/libnss_files.so.2...done.
Loaded symbols for /lib/libnss_files.so.2
Reading symbols from /lib/libnss_dns.so.2...done.
Loaded symbols for /lib/libnss_dns.so.2
Reading symbols from /lib/libresolv.so.2...done.
Loaded symbols for /lib/libresolv.so.2
Reading symbols from /lib/libgcc_s.so.1...done.
Loaded symbols for /lib/libgcc_s.so.1
0xffffe410 in __kernel_vsyscall ()
(gdb) (gdb) 
Thread 97 (Thread 0xb7f79b90 (LWP 15087)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f4d7ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib/libpthread.so.0
#2  0x8001e0a3 in alarm_handler (arg=0x0) at alarm.c:202
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 96 (Thread 0xb7e0bb90 (LWP 15088)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f4d7ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib/libpthread.so.0
#2  0x800179c9 in st_queue_handler (arg=0x0) at state.c:947
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 95 (Thread 0xb7dfab90 (LWP 15091)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8004ce60) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 94 (Thread 0xb7ca2b90 (LWP 15094)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8004d458) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 93 (Thread 0xb724bb90 (LWP 15101)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8004f848) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 92 (Thread 0xb6230b90 (LWP 15121)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80066108) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 91 (Thread 0xb5a2fb90 (LWP 15127)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800669e8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 90 (Thread 0xb522eb90 (LWP 15133)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800672a8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 89 (Thread 0xb3a2bb90 (LWP 15155)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80068d70) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 88 (Thread 0xb2928b90 (LWP 15165)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006a610) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 87 (Thread 0xb1926b90 (LWP 15185)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006b920) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 86 (Thread 0xaf922b90 (LWP 15209)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006dca8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 85 (Thread 0xaf121b90 (LWP 15215)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006e698) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 84 (Thread 0xae920b90 (LWP 15221)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006ae60) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 83 (Thread 0xae11fb90 (LWP 15227)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006f7a8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 82 (Thread 0xad91eb90 (LWP 15233)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800700d8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 81 (Thread 0xad11db90 (LWP 15239)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006eeb0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 80 (Thread 0xac01ab90 (LWP 15257)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800722f8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 79 (Thread 0xab819b90 (LWP 15264)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80072c38) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 78 (Thread 0xab018b90 (LWP 15270)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80073578) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 77 (Thread 0xaa817b90 (LWP 15276)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80073da8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 76 (Thread 0xaa016b90 (LWP 15282)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80074700) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 75 (Thread 0xa9815b90 (LWP 15288)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80074fc0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 74 (Thread 0xa8712b90 (LWP 15298)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80076808) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 73 (Thread 0xa7f11b90 (LWP 15304)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80077100) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 72 (Thread 0xa6e0eb90 (LWP 15314)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800789b0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 71 (Thread 0xa660db90 (LWP 15320)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800792a8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 70 (Thread 0xa3c06b90 (LWP 15360)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8007c818) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 69 (Thread 0xa3405b90 (LWP 15374)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8007d140) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 68 (Thread 0xa2403b90 (LWP 15388)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8007e990) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 67 (Thread 0xa1c02b90 (LWP 15394)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8007f2f0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 66 (Thread 0xa01fdb90 (LWP 15408)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80081708) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 65 (Thread 0x9d6f5b90 (LWP 15445)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80085818) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 64 (Thread 0x9cef4b90 (LWP 15463)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800855d0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 63 (Thread 0x9c5f2b90 (LWP 15475)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80086e90) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 62 (Thread 0x9b4efb90 (LWP 15485)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800886d0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 61 (Thread 0x9a4edb90 (LWP 15497)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80089950) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 60 (Thread 0x99cecb90 (LWP 15511)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80076358) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 59 (Thread 0x994ebb90 (LWP 15525)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80086ae8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 58 (Thread 0x974e7b90 (LWP 15575)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8008c798) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 57 (Thread 0x96ce6b90 (LWP 15581)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8008c588) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 56 (Thread 0x964e5b90 (LWP 15587)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8008d6d8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 55 (Thread 0x95ce4b90 (LWP 15597)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8007e608) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 54 (Thread 0x954e3b90 (LWP 15623)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8008c4b0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 53 (Thread 0x93ce0b90 (LWP 15675)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80071d98) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 52 (Thread 0x92cdeb90 (LWP 15697)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80071b80) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 51 (Thread 0x90cdab90 (LWP 15775)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80083c78) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 50 (Thread 0x904d9b90 (LWP 15793)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80086150) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 49 (Thread 0x8ecd6b90 (LWP 15821)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80090b28) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 48 (Thread 0x8e4d5b90 (LWP 15827)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80096a70) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 47 (Thread 0x8dcd4b90 (LWP 15841)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800961a8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 46 (Thread 0x8d4d3b90 (LWP 15851)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80071f98) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 45 (Thread 0x8ccd2b90 (LWP 15863)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80098590) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 44 (Thread 0x8bcd0b90 (LWP 15887)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8008c0a8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 43 (Thread 0x8b4cfb90 (LWP 15909)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800999a8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 42 (Thread 0x8a4cdb90 (LWP 15937)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8009ab68) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 41 (Thread 0x89cccb90 (LWP 15975)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80078608) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 40 (Thread 0x894cbb90 (LWP 15985)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8009b908) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 39 (Thread 0x88ccab90 (LWP 16009)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8009c1b0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 38 (Thread 0x874c7b90 (LWP 16041)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8009d9f0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 37 (Thread 0x86cc6b90 (LWP 16047)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8009e280) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 36 (Thread 0x864c5b90 (LWP 16107)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800937f8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 35 (Thread 0x85cc4b90 (LWP 16133)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80092240) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 34 (Thread 0x83cc0b90 (LWP 16209)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a2448) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 33 (Thread 0x80cbab90 (LWP 16456)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a7878) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 32 (Thread 0x7ffffb90 (LWP 16464)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a8698) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 31 (Thread 0x7f7feb90 (LWP 16496)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a7660) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 30 (Thread 0x7bff7b90 (LWP 16750)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800acb20) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 29 (Thread 0x7aff5b90 (LWP 19928)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800bf928) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 28 (Thread 0x7a7f4b90 (LWP 19946)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006b5c0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 27 (Thread 0x7d7fab90 (LWP 19994)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800ab968) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 26 (Thread 0x81cbcb90 (LWP 20083)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a1a60) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 25 (Thread 0xa560bb90 (LWP 20466)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800bd250) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 24 (Thread 0xa5e0cb90 (LWP 20491)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8007aaa0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 23 (Thread 0xb1125b90 (LWP 20681)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006c1d0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 22 (Thread 0x797f2b90 (LWP 20757)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800c1000) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 21 (Thread 0x824bdb90 (LWP 20832)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a3870) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 20 (Thread 0x854c3b90 (LWP 20999)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80079f50) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 19 (Thread 0x8f4d7b90 (LWP 21069)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8007a420) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 18 (Thread 0x984e9b90 (LWP 21098)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80095ab8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 17 (Thread 0x924ddb90 (LWP 21363)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800682c8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 16 (Thread 0x914dbb90 (LWP 21370)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80091550) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 15 (Thread 0x9e7f8b90 (LWP 21376)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80084520) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 14 (Thread 0x8c4d1b90 (LWP 21387)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a4e90) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 13 (Thread 0x8acceb90 (LWP 21397)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a44d8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 12 (Thread 0xb4a2db90 (LWP 21415)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8008ba38) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 11 (Thread 0xb422cb90 (LWP 21432)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80092d78) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 10 (Thread 0xb322ab90 (LWP 21438)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80088008) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 9 (Thread 0xb2127b90 (LWP 21448)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80092b88) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 8 (Thread 0xb0123b90 (LWP 21472)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006d370) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 7 (Thread 0x94ce2b90 (LWP 21567)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80081430) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 6 (Thread 0x98ceab90 (LWP 21591)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800bf340) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 5 (Thread 0xa6f0fb90 (LWP 21907)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f4d566 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib/libpthread.so.0
#2  0x80022015 in master_notify_submount (ap=0x8004ce60, 
    path=0x80075f78 "/net/bamboo23", state=ST_EXPIRE) at master.c:885
#3  0x8000bcc1 in expire_proc_indirect (arg=0x800c1c88) at indirect.c:477
#4  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#5  0xb7ed002e in clone () from /lib/libc.so.6

Thread 4 (Thread 0x9aceeb90 (LWP 21917)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80080d00) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 3 (Thread 0x87cc8b90 (LWP 21950)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8009d608) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 2 (Thread 0xa4508b90 (LWP 22195)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f50846 in nanosleep () from /lib/libpthread.so.0
#2  0x8000b8ef in expire_indirect (ap=0x800937f8, ioctlfd=506, 
    path=<value optimized out>, when=0) at indirect.c:410
#3  0x8000c16b in expire_proc_indirect (arg=0x800aaf18) at indirect.c:531
#4  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#5  0xb7ed002e in clone () from /lib/libc.so.6

Thread 1 (Thread 0xb7e0c6c0 (LWP 15086)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f512aa in do_sigwait () from /lib/libpthread.so.0
#2  0xb7f5134f in sigwait () from /lib/libpthread.so.0
#3  0x80007ad9 in main (argc=1, argv=<value optimized out>) at automount.c:1046
#0  0xffffe410 in __kernel_vsyscall ()
(gdb) The program is running.  Quit anyway (and detach it)? (y or n) [answered Y; input not from terminal]
Detaching from program: /usr/sbin/automount, process 15086
=----- end of backtrace -----
12:40:13 /net/bamboo35/m1     failed
12:40:13 /net/bamboo35/m2     failed
12:40:26 /net/bamboo09/m2     failed
12:40:26 /net/bamboo09/m1     failed
12:40:36 /net/bamboo45/m1     failed
12:40:44 --                   #1280, chkd 1051, run 3, OK 181, mtd 180, of 197

12:40:54 /net/bamboo11/m2     failed
12:40:54 /net/bamboo11/m1     failed
12:41:04 /net/bamboo34/m1     failed
12:41:04 /net/bamboo34/m2     failed
12:41:14 /net/bamboo10/m1     failed
12:41:44 /net/holly04/m1      failed
12:41:59 /net/quantum/h1      failed
12:42:28 --                   #1321, chkd 1154, run 3, OK 174, mtd 173, of 197

12:55:59 /net/bamboo10/m2     mtab: /net/bamboo45/m2 <=> mounts: 
12:56:51 /net/bamboo03/m2     failed
12:56:52 /net/bamboo03/m1     failed
12:56:54 --                   #1742, chkd 1250, run 3, OK 172, mtd 170, of 197

12:57:27 /net/bamboo44/m2     failed
12:57:32 /net/bamboo19/m1     failed
12:57:32 /net/bamboo19/m2     failed
12:57:47 --                   #1763, chkd 1301, run 3, OK 169, mtd 167, of 197

12:58:11 /net/testudo/m1      failed
12:59:04 /net/simba/h1        mtab: /net/trejo/m1 <=> mounts: 
13:12:06 --                   #2180, chkd 1401, run 3, OK 168, mtd 166, of 197

13:12:18 /net/bamboo10/m2     failed
13:12:30 /net/whittier/m1     failed
13:13:07 /net/bamboo01/m2     failed
13:13:26 /net/bamboo28/m1     failed
13:13:26 /net/bamboo28/m2     failed
13:13:38 /net/hollyfs/h1      mtab: /net/quantum/m1 <=> mounts: 
13:13:45 /net/animals/m1      failed
13:13:50 /net/rangers/m1      failed
13:13:55 --                   #2224, chkd 1500, run 3, OK 161, mtd 159, of 197

13:14:46 --                   #2244, chkd 1555, run 3, OK 161, mtd 161, of 197

13:27:39 /net/bamboo41/m2     mtab: /net/bamboo44/m1 <=> mounts: 
13:28:12 /net/bamboo29/m2     failed
13:28:12 /net/bamboo29/m1     failed
13:28:19 /net/bamboo16/m1     failed
13:28:39 --                   #2637, chkd 1651, run 3, OK 158, mtd 157, of 197

13:28:43 /net/rosemead/m1     failed
13:28:56 /net/bamboo06/m1     failed
13:29:03 /net/bamboo26/m1     failed
13:29:23 /net/vallejo/m1      failed
13:29:40 /net/merced/m1       mtab: /net/tulare/m1 <=> mounts: 
13:29:45 /net/serval/m1       failed
13:29:56 /net/heston/m1       failed
13:30:24 --                   #2679, chkd 1750, run 3, OK 152, mtd 148, of 197

13:30:29 /net/julia/s2        mtab: /net/pong/m1 <=> mounts: 
13:42:49 /net/bamboo05/m2     failed
13:42:52 /net/bamboo27/m1     failed
13:42:59 /net/bamboo23/m1     failed
13:43:01 --                   #3051, chkd 1800, run 3, OK 149, mtd 146, of 197

13:43:11 /net/bamboo37/m2     failed
13:43:14 /net/bamboo07/m2     failed
13:43:16 /net/bamboo42/m2     mtab: /net/whitesox/m1 <=> mounts: 
13:43:19 /net/whitesox/m1     failed
13:43:56 /net/bamboo04/m1     failed
13:44:21 /net/bamboo04/m2     hung
13:44:21 --                   #3073, chkd 1849, run 4, OK 144, mtd 125, of 197

=----- gdb backtrace of all threads -----
[?1034hGNU gdb 6.6.50.20070726-cvs
Copyright (C) 2007 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i586-suse-linux"...
Using host libthread_db library "/lib/libthread_db.so.1".
Attaching to program: /usr/sbin/automount, process 15086
Loaded symbols for /usr/sbin/automount
Reading symbols from /lib/libpthread.so.0...done.
[Thread debugging using libthread_db enabled]
[New Thread 0xb7e0c6c0 (LWP 15086)]
[New Thread 0xa1c02b90 (LWP 30419)]
[New Thread 0x84cc2b90 (LWP 30256)]
[New Thread 0xb0924b90 (LWP 30231)]
[New Thread 0x9b4efb90 (LWP 30123)]
[New Thread 0x9c5f2b90 (LWP 30090)]
[New Thread 0xa01fdb90 (LWP 30035)]
[New Thread 0xa7710b90 (LWP 30002)]
[New Thread 0x8a4cdb90 (LWP 29957)]
[New Thread 0x9d6f5b90 (LWP 29928)]
[New Thread 0xa6f0fb90 (LWP 29684)]
[New Thread 0x98ceab90 (LWP 29591)]
[New Thread 0x9e7f8b90 (LWP 29417)]
[New Thread 0xaf922b90 (LWP 29390)]
[New Thread 0x994ebb90 (LWP 29242)]
[New Thread 0x8acceb90 (LWP 28987)]
[New Thread 0xa3405b90 (LWP 28951)]
[New Thread 0x8ccd2b90 (LWP 28921)]
[New Thread 0x96ce6b90 (LWP 28870)]
[New Thread 0x88ccab90 (LWP 28795)]
[New Thread 0x93ce0b90 (LWP 28747)]
[New Thread 0xae920b90 (LWP 28643)]
[New Thread 0xa9815b90 (LWP 28598)]
[New Thread 0xa6e0eb90 (LWP 28564)]
[New Thread 0x81cbcb90 (LWP 28369)]
[New Thread 0xa5e0cb90 (LWP 28345)]
[New Thread 0xb1125b90 (LWP 28324)]
[New Thread 0x834bfb90 (LWP 28286)]
[New Thread 0xb6a31b90 (LWP 28233)]
[New Thread 0x7a7f4b90 (LWP 28123)]
[New Thread 0x86cc6b90 (LWP 28099)]
[New Thread 0xaf121b90 (LWP 28041)]
[New Thread 0x954e3b90 (LWP 27922)]
[New Thread 0x9aceeb90 (LWP 27797)]
[New Thread 0x94ce2b90 (LWP 27682)]
[New Thread 0xb2127b90 (LWP 27568)]
[New Thread 0x984e9b90 (LWP 27284)]
[New Thread 0x83cc0b90 (LWP 27116)]
[New Thread 0x7bff7b90 (LWP 27046)]
[New Thread 0xa8712b90 (LWP 26818)]
[New Thread 0x864c5b90 (LWP 26406)]
[New Thread 0xae11fb90 (LWP 25338)]
[New Thread 0x904d9b90 (LWP 25223)]
[New Thread 0x8f4d7b90 (LWP 25137)]
[New Thread 0x85cc4b90 (LWP 24958)]
[New Thread 0xb522eb90 (LWP 24799)]
[New Thread 0xab018b90 (LWP 24665)]
[New Thread 0x9a4edb90 (LWP 24453)]
[New Thread 0x8d4d3b90 (LWP 23776)]
[New Thread 0xb3a2bb90 (LWP 22946)]
[New Thread 0x974e7b90 (LWP 22549)]
[New Thread 0x90cdab90 (LWP 22487)]
[New Thread 0xac91cb90 (LWP 22274)]
[New Thread 0x7effdb90 (LWP 22239)]
[New Thread 0x87cc8b90 (LWP 21950)]
[New Thread 0xb0123b90 (LWP 21472)]
[New Thread 0xb322ab90 (LWP 21438)]
[New Thread 0xb422cb90 (LWP 21432)]
[New Thread 0x8c4d1b90 (LWP 21387)]
[New Thread 0x914dbb90 (LWP 21370)]
[New Thread 0x924ddb90 (LWP 21363)]
[New Thread 0x7d7fab90 (LWP 19994)]
[New Thread 0x7aff5b90 (LWP 19928)]
[New Thread 0x7ffffb90 (LWP 16464)]
[New Thread 0x80cbab90 (LWP 16456)]
[New Thread 0x894cbb90 (LWP 15985)]
[New Thread 0x89cccb90 (LWP 15975)]
[New Thread 0x8b4cfb90 (LWP 15909)]
[New Thread 0x8e4d5b90 (LWP 15827)]
[New Thread 0x92cdeb90 (LWP 15697)]
[New Thread 0x95ce4b90 (LWP 15597)]
[New Thread 0x9cef4b90 (LWP 15463)]
[New Thread 0xa660db90 (LWP 15320)]
[New Thread 0xab819b90 (LWP 15264)]
[New Thread 0xad11db90 (LWP 15239)]
[New Thread 0xb2928b90 (LWP 15165)]
[New Thread 0xb724bb90 (LWP 15101)]
[New Thread 0xb7ca2b90 (LWP 15094)]
[New Thread 0xb7dfab90 (LWP 15091)]
[New Thread 0xb7e0bb90 (LWP 15088)]
[New Thread 0xb7f79b90 (LWP 15087)]
Loaded symbols for /lib/libpthread.so.0
Reading symbols from /lib/libdl.so.2...done.
Loaded symbols for /lib/libdl.so.2
Reading symbols from /lib/libc.so.6...done.
Loaded symbols for /lib/libc.so.6
Reading symbols from /lib/ld-linux.so.2...done.
Loaded symbols for /lib/ld-linux.so.2
Reading symbols from /usr/lib/autofs/lookup_file.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/lookup_file.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/lookup_file.so
Reading symbols from /lib/libnsl.so.1...done.
Loaded symbols for /lib/libnsl.so.1
Reading symbols from /usr/lib/autofs/parse_sun.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/parse_sun.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/parse_sun.so
Reading symbols from /usr/lib/autofs/mount_nfs.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/mount_nfs.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/mount_nfs.so
Reading symbols from /usr/lib/autofs/mount_bind.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/mount_bind.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/mount_bind.so
Reading symbols from /usr/lib/autofs/lookup_yp.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/lookup_yp.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/lookup_yp.so
Reading symbols from /lib/libnss_compat.so.2...done.
Loaded symbols for /lib/libnss_compat.so.2
Reading symbols from /lib/libnss_nis.so.2...done.
Loaded symbols for /lib/libnss_nis.so.2
Reading symbols from /lib/libnss_files.so.2...done.
Loaded symbols for /lib/libnss_files.so.2
Reading symbols from /lib/libnss_dns.so.2...done.
Loaded symbols for /lib/libnss_dns.so.2
Reading symbols from /lib/libresolv.so.2...done.
Loaded symbols for /lib/libresolv.so.2
Reading symbols from /lib/libgcc_s.so.1...done.
Loaded symbols for /lib/libgcc_s.so.1
0xffffe410 in __kernel_vsyscall ()
(gdb) (gdb) 
Thread 81 (Thread 0xb7f79b90 (LWP 15087)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f4d7ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib/libpthread.so.0
#2  0x8001e0a3 in alarm_handler (arg=0x0) at alarm.c:202
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 80 (Thread 0xb7e0bb90 (LWP 15088)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f4d7ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib/libpthread.so.0
#2  0x800179c9 in st_queue_handler (arg=0x0) at state.c:947
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 79 (Thread 0xb7dfab90 (LWP 15091)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8004ce60) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 78 (Thread 0xb7ca2b90 (LWP 15094)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8004d458) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 77 (Thread 0xb724bb90 (LWP 15101)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8004f848) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 76 (Thread 0xb2928b90 (LWP 15165)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006a610) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 75 (Thread 0xad11db90 (LWP 15239)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006eeb0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 74 (Thread 0xab819b90 (LWP 15264)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80072c38) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 73 (Thread 0xa660db90 (LWP 15320)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800792a8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 72 (Thread 0x9cef4b90 (LWP 15463)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800855d0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 71 (Thread 0x95ce4b90 (LWP 15597)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8007e608) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 70 (Thread 0x92cdeb90 (LWP 15697)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80071b80) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 69 (Thread 0x8e4d5b90 (LWP 15827)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80096a70) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 68 (Thread 0x8b4cfb90 (LWP 15909)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800999a8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 67 (Thread 0x89cccb90 (LWP 15975)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80078608) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 66 (Thread 0x894cbb90 (LWP 15985)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8009b908) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 65 (Thread 0x80cbab90 (LWP 16456)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a7878) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 64 (Thread 0x7ffffb90 (LWP 16464)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a8698) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 63 (Thread 0x7aff5b90 (LWP 19928)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800bf928) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 62 (Thread 0x7d7fab90 (LWP 19994)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800ab968) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 61 (Thread 0x924ddb90 (LWP 21363)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800682c8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 60 (Thread 0x914dbb90 (LWP 21370)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80091550) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 59 (Thread 0x8c4d1b90 (LWP 21387)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a4e90) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 58 (Thread 0xb422cb90 (LWP 21432)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80092d78) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 57 (Thread 0xb322ab90 (LWP 21438)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80088008) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 56 (Thread 0xb0123b90 (LWP 21472)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006d370) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 55 (Thread 0x87cc8b90 (LWP 21950)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8009d608) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 54 (Thread 0x7effdb90 (LWP 22239)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a7200) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 53 (Thread 0xac91cb90 (LWP 22274)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a5aa0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 52 (Thread 0x90cdab90 (LWP 22487)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800abc48) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 51 (Thread 0x974e7b90 (LWP 22549)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8009f0d8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 50 (Thread 0xb3a2bb90 (LWP 22946)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80070508) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 49 (Thread 0x8d4d3b90 (LWP 23776)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800bfd20) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 48 (Thread 0x9a4edb90 (LWP 24453)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8008c350) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 47 (Thread 0xab018b90 (LWP 24665)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80088ad0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 46 (Thread 0xb522eb90 (LWP 24799)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006ebf0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 45 (Thread 0x85cc4b90 (LWP 24958)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a13a8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 44 (Thread 0x8f4d7b90 (LWP 25137)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a6d60) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 43 (Thread 0x904d9b90 (LWP 25223)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8008dca0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 42 (Thread 0xae11fb90 (LWP 25338)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006fd88) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 41 (Thread 0x864c5b90 (LWP 26406)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800937f8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 40 (Thread 0xa8712b90 (LWP 26818)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80076808) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 39 (Thread 0x7bff7b90 (LWP 27046)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800c1000) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 38 (Thread 0x83cc0b90 (LWP 27116)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a2a48) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 37 (Thread 0x984e9b90 (LWP 27284)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80095ab8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 36 (Thread 0xb2127b90 (LWP 27568)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80076358) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 35 (Thread 0x94ce2b90 (LWP 27682)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80077690) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 34 (Thread 0x9aceeb90 (LWP 27797)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8004e508) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 33 (Thread 0x954e3b90 (LWP 27922)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80089200) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 32 (Thread 0xaf121b90 (LWP 28041)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006b428) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 31 (Thread 0x86cc6b90 (LWP 28099)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8008c4b0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 30 (Thread 0x7a7f4b90 (LWP 28123)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006b5c0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 29 (Thread 0xb6a31b90 (LWP 28233)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800783c8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 28 (Thread 0x834bfb90 (LWP 28286)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80089550) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 27 (Thread 0xb1125b90 (LWP 28324)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800c0900) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 26 (Thread 0xa5e0cb90 (LWP 28345)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8007aaa0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 25 (Thread 0x81cbcb90 (LWP 28369)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a1a60) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 24 (Thread 0xa6e0eb90 (LWP 28564)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800c23b0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 23 (Thread 0xa9815b90 (LWP 28598)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80075518) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 22 (Thread 0xae920b90 (LWP 28643)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006ed08) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 21 (Thread 0x93ce0b90 (LWP 28747)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80067800) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 20 (Thread 0x88ccab90 (LWP 28795)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006c1d0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 19 (Thread 0x96ce6b90 (LWP 28870)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8008ce78) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 18 (Thread 0x8ccd2b90 (LWP 28921)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80071d98) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 17 (Thread 0xa3405b90 (LWP 28951)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8008ba38) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 16 (Thread 0x8acceb90 (LWP 28987)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a44d8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 15 (Thread 0x994ebb90 (LWP 29242)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80079f50) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 14 (Thread 0xaf922b90 (LWP 29390)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80078500) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 13 (Thread 0x9e7f8b90 (LWP 29417)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80084520) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 12 (Thread 0x98ceab90 (LWP 29591)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006e278) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 11 (Thread 0xa6f0fb90 (LWP 29684)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f4d566 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib/libpthread.so.0
#2  0x80022015 in master_notify_submount (ap=0x8004ce60, 
    path=0x80076178 "/net/riemann", state=ST_EXPIRE) at master.c:885
#3  0x8000bcc1 in expire_proc_indirect (arg=0x800a50a8) at indirect.c:477
#4  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#5  0xb7ed002e in clone () from /lib/libc.so.6

Thread 10 (Thread 0x9d6f5b90 (LWP 29928)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8008a680) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 9 (Thread 0x8a4cdb90 (LWP 29957)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8007cdb8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 8 (Thread 0xa7710b90 (LWP 30002)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80070388) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 7 (Thread 0xa01fdb90 (LWP 30035)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80081c88) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 6 (Thread 0x9c5f2b90 (LWP 30090)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80088c70) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 5 (Thread 0x9b4efb90 (LWP 30123)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80089ea8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 4 (Thread 0xb0924b90 (LWP 30231)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a32f0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 3 (Thread 0x84cc2b90 (LWP 30256)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80065f98) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 2 (Thread 0xa1c02b90 (LWP 30419)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8008f028) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 1 (Thread 0xb7e0c6c0 (LWP 15086)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f512aa in do_sigwait () from /lib/libpthread.so.0
#2  0xb7f5134f in sigwait () from /lib/libpthread.so.0
#3  0x80007ad9 in main (argc=1, argv=<value optimized out>) at automount.c:1046
#0  0xffffe410 in __kernel_vsyscall ()
(gdb) The program is running.  Quit anyway (and detach it)? (y or n) [answered Y; input not from terminal]
Detaching from program: /usr/sbin/automount, process 15086
=----- end of backtrace -----
13:44:44 /net/sunset/s3       mtab: /net/spruce/s1 <=> mounts: 
13:44:47 /net/walnut/s3       mtab: /net/walnut/s1 <=> mounts: 
13:44:48 --                   #3082, chkd 1901, run 4, OK 144, mtd 140, of 197

13:56:38 /net/athletics/m1    failed
13:57:25 /net/mukilteo/m1     failed
13:57:32 /net/bamboo47/m2     failed
13:57:32 /net/bamboo47/m1     failed
13:57:42 /net/bamboo17/m2     failed
13:57:42 /net/bamboo17/m1     failed
13:57:59 /net/bamboo24/m2     failed
13:57:59 /net/bamboo24/m1     failed
13:58:04 --                   #3468, chkd 2002, run 4, OK 136, mtd 134, of 197

13:58:11 /net/bamboo22/m2     failed
13:58:12 /net/bamboo22/m1     failed
13:58:43 /net/ontario/m1      failed
13:58:46 /net/mothra/m1       failed
13:59:34 /net/julia/s3        failed
13:59:34 /net/julia/m1        failed
13:59:34 /net/julia/s1        failed
14:10:05 --                   #3805, chkd 2100, run 4, OK 129, mtd 129, of 197

14:10:55 /net/bamboo39/m1     failed
14:10:55 /net/bamboo39/m2     failed
14:11:02 /net/bamboo40/m1     failed
14:11:17 /net/bamboo06/m2     failed
14:11:28 /net/bamboo16/m2     failed
14:11:33 /net/stockton/m1     failed
14:11:35 --                   #3845, chkd 2150, run 4, OK 123, mtd 120, of 197

14:11:45 /net/bamboo42/m1     failed
14:12:00 /net/bamboo13/m1     failed
14:12:27 /net/reedley/m1      failed
14:12:32 /net/daggett/h1      failed
14:12:32 --                   #3868, chkd 2201, run 4, OK 119, mtd 116, of 197

14:12:43 /net/malibu/h1       failed
14:13:08 /net/malibu/m1       hung
14:13:08 --                   #3872, chkd 2214, run 5, OK 117, mtd 87, of 197

=----- gdb backtrace of all threads -----
[?1034hGNU gdb 6.6.50.20070726-cvs
Copyright (C) 2007 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i586-suse-linux"...
Using host libthread_db library "/lib/libthread_db.so.1".
Attaching to program: /usr/sbin/automount, process 15086
Loaded symbols for /usr/sbin/automount
Reading symbols from /lib/libpthread.so.0...done.
[Thread debugging using libthread_db enabled]
[New Thread 0xb7e0c6c0 (LWP 15086)]
[New Thread 0xb7b87b90 (LWP 1620)]
[New Thread 0x7bff7b90 (LWP 1383)]
[New Thread 0x7f7feb90 (LWP 1315)]
[New Thread 0x7ffffb90 (LWP 1278)]
[New Thread 0xb5a2fb90 (LWP 1253)]
[New Thread 0x8b4cfb90 (LWP 1164)]
[New Thread 0x89cccb90 (LWP 1136)]
[New Thread 0xac91cb90 (LWP 1082)]
[New Thread 0x90cdab90 (LWP 1046)]
[New Thread 0x9a4edb90 (LWP 1013)]
[New Thread 0xaf121b90 (LWP 954)]
[New Thread 0x81cbcb90 (LWP 877)]
[New Thread 0xa6e0eb90 (LWP 852)]
[New Thread 0x9d6f5b90 (LWP 797)]
[New Thread 0xa7710b90 (LWP 776)]
[New Thread 0x9c5f2b90 (LWP 746)]
[New Thread 0xb0924b90 (LWP 726)]
[New Thread 0xa6f0fb90 (LWP 489)]
[New Thread 0x8d4d3b90 (LWP 32698)]
[New Thread 0x98ceab90 (LWP 32678)]
[New Thread 0xb724bb90 (LWP 32650)]
[New Thread 0x914dbb90 (LWP 32615)]
[New Thread 0x8f4d7b90 (LWP 32555)]
[New Thread 0x924ddb90 (LWP 32549)]
[New Thread 0xb322ab90 (LWP 32527)]
[New Thread 0xad11db90 (LWP 32442)]
[New Thread 0xb2127b90 (LWP 32412)]
[New Thread 0x984e9b90 (LWP 32236)]
[New Thread 0x8ccd2b90 (LWP 32203)]
[New Thread 0x83cc0b90 (LWP 32107)]
[New Thread 0x88ccab90 (LWP 32062)]
[New Thread 0x9cef4b90 (LWP 31928)]
[New Thread 0x894cbb90 (LWP 31843)]
[New Thread 0x7effdb90 (LWP 31749)]
[New Thread 0x974e7b90 (LWP 31703)]
[New Thread 0xb522eb90 (LWP 31621)]
[New Thread 0xa5e0cb90 (LWP 31488)]
[New Thread 0x8c4d1b90 (LWP 31067)]
[New Thread 0x95ce4b90 (LWP 30649)]
[New Thread 0xb4a2db90 (LWP 30632)]
[New Thread 0xa7f11b90 (LWP 30596)]
[New Thread 0xb6230b90 (LWP 30544)]
[New Thread 0xa1c02b90 (LWP 30419)]
[New Thread 0x84cc2b90 (LWP 30256)]
[New Thread 0x9b4efb90 (LWP 30123)]
[New Thread 0xa01fdb90 (LWP 30035)]
[New Thread 0x8a4cdb90 (LWP 29957)]
[New Thread 0x9e7f8b90 (LWP 29417)]
[New Thread 0x994ebb90 (LWP 29242)]
[New Thread 0x96ce6b90 (LWP 28870)]
[New Thread 0xae920b90 (LWP 28643)]
[New Thread 0xb6a31b90 (LWP 28233)]
[New Thread 0x7a7f4b90 (LWP 28123)]
[New Thread 0x954e3b90 (LWP 27922)]
[New Thread 0x9aceeb90 (LWP 27797)]
[New Thread 0x94ce2b90 (LWP 27682)]
[New Thread 0xa8712b90 (LWP 26818)]
[New Thread 0xab018b90 (LWP 24665)]
[New Thread 0xb0123b90 (LWP 21472)]
[New Thread 0xb422cb90 (LWP 21432)]
[New Thread 0x7d7fab90 (LWP 19994)]
[New Thread 0x7aff5b90 (LWP 19928)]
[New Thread 0xab819b90 (LWP 15264)]
[New Thread 0xb7ca2b90 (LWP 15094)]
[New Thread 0xb7dfab90 (LWP 15091)]
[New Thread 0xb7e0bb90 (LWP 15088)]
[New Thread 0xb7f79b90 (LWP 15087)]
Loaded symbols for /lib/libpthread.so.0
Reading symbols from /lib/libdl.so.2...done.
Loaded symbols for /lib/libdl.so.2
Reading symbols from /lib/libc.so.6...done.
Loaded symbols for /lib/libc.so.6
Reading symbols from /lib/ld-linux.so.2...done.
Loaded symbols for /lib/ld-linux.so.2
Reading symbols from /usr/lib/autofs/lookup_file.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/lookup_file.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/lookup_file.so
Reading symbols from /lib/libnsl.so.1...done.
Loaded symbols for /lib/libnsl.so.1
Reading symbols from /usr/lib/autofs/parse_sun.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/parse_sun.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/parse_sun.so
Reading symbols from /usr/lib/autofs/mount_nfs.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/mount_nfs.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/mount_nfs.so
Reading symbols from /usr/lib/autofs/mount_bind.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/mount_bind.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/mount_bind.so
Reading symbols from /usr/lib/autofs/lookup_yp.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/lookup_yp.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/lookup_yp.so
Reading symbols from /lib/libnss_compat.so.2...done.
Loaded symbols for /lib/libnss_compat.so.2
Reading symbols from /lib/libnss_nis.so.2...done.
Loaded symbols for /lib/libnss_nis.so.2
Reading symbols from /lib/libnss_files.so.2...done.
Loaded symbols for /lib/libnss_files.so.2
Reading symbols from /lib/libnss_dns.so.2...done.
Loaded symbols for /lib/libnss_dns.so.2
Reading symbols from /lib/libresolv.so.2...done.
Loaded symbols for /lib/libresolv.so.2
Reading symbols from /lib/libgcc_s.so.1...done.
Loaded symbols for /lib/libgcc_s.so.1
0xffffe410 in __kernel_vsyscall ()
(gdb) (gdb) 
Thread 68 (Thread 0xb7f79b90 (LWP 15087)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f4d7ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib/libpthread.so.0
#2  0x8001e0a3 in alarm_handler (arg=0x0) at alarm.c:202
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 67 (Thread 0xb7e0bb90 (LWP 15088)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f4d7ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib/libpthread.so.0
#2  0x800179c9 in st_queue_handler (arg=0x0) at state.c:947
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 66 (Thread 0xb7dfab90 (LWP 15091)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8004ce60) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 65 (Thread 0xb7ca2b90 (LWP 15094)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8004d458) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 64 (Thread 0xab819b90 (LWP 15264)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80072c38) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 63 (Thread 0x7aff5b90 (LWP 19928)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800bf928) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 62 (Thread 0x7d7fab90 (LWP 19994)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800ab968) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 61 (Thread 0xb422cb90 (LWP 21432)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80092d78) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 60 (Thread 0xb0123b90 (LWP 21472)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006d370) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 59 (Thread 0xab018b90 (LWP 24665)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80088ad0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 58 (Thread 0xa8712b90 (LWP 26818)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80076808) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 57 (Thread 0x94ce2b90 (LWP 27682)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80077690) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 56 (Thread 0x9aceeb90 (LWP 27797)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8004e508) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 55 (Thread 0x954e3b90 (LWP 27922)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80089200) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 54 (Thread 0x7a7f4b90 (LWP 28123)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006b5c0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 53 (Thread 0xb6a31b90 (LWP 28233)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800783c8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 52 (Thread 0xae920b90 (LWP 28643)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006ed08) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 51 (Thread 0x96ce6b90 (LWP 28870)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8008ce78) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 50 (Thread 0x994ebb90 (LWP 29242)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80079f50) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 49 (Thread 0x9e7f8b90 (LWP 29417)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80084520) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 48 (Thread 0x8a4cdb90 (LWP 29957)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8007cdb8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 47 (Thread 0xa01fdb90 (LWP 30035)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80081c88) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 46 (Thread 0x9b4efb90 (LWP 30123)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80089ea8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 45 (Thread 0x84cc2b90 (LWP 30256)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80065f98) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 44 (Thread 0xa1c02b90 (LWP 30419)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8008f028) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 43 (Thread 0xb6230b90 (LWP 30544)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80099650) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 42 (Thread 0xa7f11b90 (LWP 30596)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8007eee8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 41 (Thread 0xb4a2db90 (LWP 30632)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80098178) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 40 (Thread 0x95ce4b90 (LWP 30649)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a96d0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 39 (Thread 0x8c4d1b90 (LWP 31067)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800911e8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 38 (Thread 0xa5e0cb90 (LWP 31488)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8007aaa0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 37 (Thread 0xb522eb90 (LWP 31621)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800937f8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 36 (Thread 0x974e7b90 (LWP 31703)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8009d608) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 35 (Thread 0x7effdb90 (LWP 31749)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006ebf0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 34 (Thread 0x894cbb90 (LWP 31843)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8009be60) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 33 (Thread 0x9cef4b90 (LWP 31928)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a7200) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 32 (Thread 0x88ccab90 (LWP 32062)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006c1d0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 31 (Thread 0x83cc0b90 (LWP 32107)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a2a48) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 30 (Thread 0x8ccd2b90 (LWP 32203)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a13a8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 29 (Thread 0x984e9b90 (LWP 32236)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80095ab8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 28 (Thread 0xb2127b90 (LWP 32412)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a6d60) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 27 (Thread 0xad11db90 (LWP 32442)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800682c8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 26 (Thread 0xb322ab90 (LWP 32527)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80086808) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 25 (Thread 0x924ddb90 (LWP 32549)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8009f0d8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 24 (Thread 0x8f4d7b90 (LWP 32555)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800bf4c0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 23 (Thread 0x914dbb90 (LWP 32615)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80091550) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 22 (Thread 0xb724bb90 (LWP 32650)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80088220) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 21 (Thread 0x98ceab90 (LWP 32678)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80076358) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 20 (Thread 0x8d4d3b90 (LWP 32698)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80067fb8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 19 (Thread 0xa6f0fb90 (LWP 489)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f4d566 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib/libpthread.so.0
#2  0x80022015 in master_notify_submount (ap=0x8004ce60, 
    path=0x8009c888 "/net/simba", state=ST_EXPIRE) at master.c:885
#3  0x8000bcc1 in expire_proc_indirect (arg=0x8007b8f0) at indirect.c:477
#4  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#5  0xb7ed002e in clone () from /lib/libc.so.6

Thread 18 (Thread 0xb0924b90 (LWP 726)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a32f0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 17 (Thread 0x9c5f2b90 (LWP 746)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80088c70) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 16 (Thread 0xa7710b90 (LWP 776)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80070388) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 15 (Thread 0x9d6f5b90 (LWP 797)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a5120) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 14 (Thread 0xa6e0eb90 (LWP 852)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a8670) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 13 (Thread 0x81cbcb90 (LWP 877)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a1a60) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 12 (Thread 0xaf121b90 (LWP 954)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800c0900) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 11 (Thread 0x9a4edb90 (LWP 1013)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80089550) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 10 (Thread 0x90cdab90 (LWP 1046)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8008c350) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 9 (Thread 0xac91cb90 (LWP 1082)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800abc48) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 8 (Thread 0x89cccb90 (LWP 1136)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800952a0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 7 (Thread 0x8b4cfb90 (LWP 1164)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800c23b0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 6 (Thread 0xb5a2fb90 (LWP 1253)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8007bdb0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 5 (Thread 0x7ffffb90 (LWP 1278)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a8c38) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 4 (Thread 0x7f7feb90 (LWP 1315)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8007e418) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 3 (Thread 0x7bff7b90 (LWP 1383)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800c1000) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 2 (Thread 0xb7b87b90 (LWP 1620)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f50846 in nanosleep () from /lib/libpthread.so.0
#2  0x8000b8ef in expire_indirect (ap=0x800911e8, ioctlfd=266, 
    path=<value optimized out>, when=0) at indirect.c:410
#3  0x8000bc17 in expire_proc_indirect (arg=0x800a1760) at indirect.c:517
#4  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#5  0xb7ed002e in clone () from /lib/libc.so.6

Thread 1 (Thread 0xb7e0c6c0 (LWP 15086)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f512aa in do_sigwait () from /lib/libpthread.so.0
#2  0xb7f5134f in sigwait () from /lib/libpthread.so.0
#3  0x80007ad9 in main (argc=1, argv=<value optimized out>) at automount.c:1046
#0  0xffffe410 in __kernel_vsyscall ()
(gdb) The program is running.  Quit anyway (and detach it)? (y or n) [answered Y; input not from terminal]
Detaching from program: /usr/sbin/automount, process 15086
=----- end of backtrace -----
14:13:18 /net/koala/m1        mtab: /net/ojai/m1 <=> mounts: 
14:23:15 /net/nasturtium/m1   failed
14:23:38 /net/sassafras/m3    mtab: /net/sassafras/m3 <=> mounts: 
14:24:11 /net/bamboo32/m2     mtab: /net/bamboo45/m2 <=> mounts: 
14:24:35 --                   #4206, chkd 2300, run 5, OK 116, mtd 115, of 197

14:25:14 /net/bamboo33/m1     hung
14:25:14 /net/bamboo33/m2     hung
14:25:14 --                   #4212, chkd 2313, run 7, OK 114, mtd 86, of 197

=----- gdb backtrace of all threads -----
[?1034hGNU gdb 6.6.50.20070726-cvs
Copyright (C) 2007 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i586-suse-linux"...
Using host libthread_db library "/lib/libthread_db.so.1".
Attaching to program: /usr/sbin/automount, process 15086
Loaded symbols for /usr/sbin/automount
Reading symbols from /lib/libpthread.so.0...done.
[Thread debugging using libthread_db enabled]
[New Thread 0xb7e0c6c0 (LWP 15086)]
[New Thread 0xb7a4cb90 (LWP 2658)]
[New Thread 0xb7b87b90 (LWP 2641)]
[New Thread 0xa8712b90 (LWP 2466)]
[New Thread 0x7a7f4b90 (LWP 2430)]
[New Thread 0xae920b90 (LWP 2402)]
[New Thread 0x8a4cdb90 (LWP 2379)]
[New Thread 0x9b4efb90 (LWP 2353)]
[New Thread 0xa1c02b90 (LWP 2318)]
[New Thread 0x974e7b90 (LWP 2288)]
[New Thread 0xa6f0fb90 (LWP 2003)]
[New Thread 0xb422cb90 (LWP 1838)]
[New Thread 0xb1926b90 (LWP 1814)]
[New Thread 0xb0123b90 (LWP 1804)]
[New Thread 0x9e7f8b90 (LWP 1739)]
[New Thread 0xb3a2bb90 (LWP 1708)]
[New Thread 0x904d9b90 (LWP 1702)]
[New Thread 0x8c4d1b90 (LWP 1679)]
[New Thread 0x8e4d5b90 (LWP 1658)]
[New Thread 0xa660db90 (LWP 1644)]
[New Thread 0xb2928b90 (LWP 1638)]
[New Thread 0x7bff7b90 (LWP 1383)]
[New Thread 0x7f7feb90 (LWP 1315)]
[New Thread 0x7ffffb90 (LWP 1278)]
[New Thread 0xb5a2fb90 (LWP 1253)]
[New Thread 0x8b4cfb90 (LWP 1164)]
[New Thread 0x89cccb90 (LWP 1136)]
[New Thread 0xac91cb90 (LWP 1082)]
[New Thread 0x90cdab90 (LWP 1046)]
[New Thread 0x9a4edb90 (LWP 1013)]
[New Thread 0xaf121b90 (LWP 954)]
[New Thread 0x81cbcb90 (LWP 877)]
[New Thread 0xa6e0eb90 (LWP 852)]
[New Thread 0x9d6f5b90 (LWP 797)]
[New Thread 0xa7710b90 (LWP 776)]
[New Thread 0x9c5f2b90 (LWP 746)]
[New Thread 0xb0924b90 (LWP 726)]
[New Thread 0x8d4d3b90 (LWP 32698)]
[New Thread 0x98ceab90 (LWP 32678)]
[New Thread 0xb724bb90 (LWP 32650)]
[New Thread 0x914dbb90 (LWP 32615)]
[New Thread 0x8f4d7b90 (LWP 32555)]
[New Thread 0x924ddb90 (LWP 32549)]
[New Thread 0xb322ab90 (LWP 32527)]
[New Thread 0xad11db90 (LWP 32442)]
[New Thread 0xb2127b90 (LWP 32412)]
[New Thread 0x984e9b90 (LWP 32236)]
[New Thread 0x8ccd2b90 (LWP 32203)]
[New Thread 0x83cc0b90 (LWP 32107)]
[New Thread 0x9cef4b90 (LWP 31928)]
[New Thread 0x894cbb90 (LWP 31843)]
[New Thread 0x7effdb90 (LWP 31749)]
[New Thread 0xb522eb90 (LWP 31621)]
[New Thread 0xa5e0cb90 (LWP 31488)]
[New Thread 0x95ce4b90 (LWP 30649)]
[New Thread 0xa7f11b90 (LWP 30596)]
[New Thread 0xb6230b90 (LWP 30544)]
[New Thread 0x84cc2b90 (LWP 30256)]
[New Thread 0xa01fdb90 (LWP 30035)]
[New Thread 0x994ebb90 (LWP 29242)]
[New Thread 0xb6a31b90 (LWP 28233)]
[New Thread 0x954e3b90 (LWP 27922)]
[New Thread 0x94ce2b90 (LWP 27682)]
[New Thread 0xab018b90 (LWP 24665)]
[New Thread 0x7d7fab90 (LWP 19994)]
[New Thread 0xab819b90 (LWP 15264)]
[New Thread 0xb7ca2b90 (LWP 15094)]
[New Thread 0xb7dfab90 (LWP 15091)]
[New Thread 0xb7e0bb90 (LWP 15088)]
[New Thread 0xb7f79b90 (LWP 15087)]
Loaded symbols for /lib/libpthread.so.0
Reading symbols from /lib/libdl.so.2...done.
Loaded symbols for /lib/libdl.so.2
Reading symbols from /lib/libc.so.6...done.
Loaded symbols for /lib/libc.so.6
Reading symbols from /lib/ld-linux.so.2...done.
Loaded symbols for /lib/ld-linux.so.2
Reading symbols from /usr/lib/autofs/lookup_file.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/lookup_file.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/lookup_file.so
Reading symbols from /lib/libnsl.so.1...done.
Loaded symbols for /lib/libnsl.so.1
Reading symbols from /usr/lib/autofs/parse_sun.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/parse_sun.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/parse_sun.so
Reading symbols from /usr/lib/autofs/mount_nfs.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/mount_nfs.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/mount_nfs.so
Reading symbols from /usr/lib/autofs/mount_bind.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/mount_bind.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/mount_bind.so
Reading symbols from /usr/lib/autofs/lookup_yp.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/lookup_yp.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/lookup_yp.so
Reading symbols from /lib/libnss_compat.so.2...done.
Loaded symbols for /lib/libnss_compat.so.2
Reading symbols from /lib/libnss_nis.so.2...done.
Loaded symbols for /lib/libnss_nis.so.2
Reading symbols from /lib/libnss_files.so.2...done.
Loaded symbols for /lib/libnss_files.so.2
Reading symbols from /lib/libnss_dns.so.2...done.
Loaded symbols for /lib/libnss_dns.so.2
Reading symbols from /lib/libresolv.so.2...done.
Loaded symbols for /lib/libresolv.so.2
Reading symbols from /lib/libgcc_s.so.1...done.
Loaded symbols for /lib/libgcc_s.so.1
0xffffe410 in __kernel_vsyscall ()
(gdb) (gdb) 
Thread 70 (Thread 0xb7f79b90 (LWP 15087)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f4d7ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib/libpthread.so.0
#2  0x8001e0a3 in alarm_handler (arg=0x0) at alarm.c:202
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 69 (Thread 0xb7e0bb90 (LWP 15088)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f4d7ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib/libpthread.so.0
#2  0x800179c9 in st_queue_handler (arg=0x0) at state.c:947
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 68 (Thread 0xb7dfab90 (LWP 15091)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8004ce60) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 67 (Thread 0xb7ca2b90 (LWP 15094)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8004d458) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 66 (Thread 0xab819b90 (LWP 15264)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80072c38) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 65 (Thread 0x7d7fab90 (LWP 19994)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800ab968) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 64 (Thread 0xab018b90 (LWP 24665)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80088ad0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 63 (Thread 0x94ce2b90 (LWP 27682)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80077690) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 62 (Thread 0x954e3b90 (LWP 27922)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80089200) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 61 (Thread 0xb6a31b90 (LWP 28233)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800783c8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 60 (Thread 0x994ebb90 (LWP 29242)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80079f50) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 59 (Thread 0xa01fdb90 (LWP 30035)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80081c88) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 58 (Thread 0x84cc2b90 (LWP 30256)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80065f98) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 57 (Thread 0xb6230b90 (LWP 30544)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80099650) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 56 (Thread 0xa7f11b90 (LWP 30596)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8007eee8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 55 (Thread 0x95ce4b90 (LWP 30649)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a96d0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 54 (Thread 0xa5e0cb90 (LWP 31488)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8007aaa0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 53 (Thread 0xb522eb90 (LWP 31621)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800937f8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 52 (Thread 0x7effdb90 (LWP 31749)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006ebf0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 51 (Thread 0x894cbb90 (LWP 31843)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8009be60) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 50 (Thread 0x9cef4b90 (LWP 31928)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a7200) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 49 (Thread 0x83cc0b90 (LWP 32107)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a2a48) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 48 (Thread 0x8ccd2b90 (LWP 32203)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a13a8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 47 (Thread 0x984e9b90 (LWP 32236)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80095ab8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 46 (Thread 0xb2127b90 (LWP 32412)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a6d60) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 45 (Thread 0xad11db90 (LWP 32442)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800682c8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 44 (Thread 0xb322ab90 (LWP 32527)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80086808) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 43 (Thread 0x924ddb90 (LWP 32549)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8009f0d8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 42 (Thread 0x8f4d7b90 (LWP 32555)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800bf4c0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 41 (Thread 0x914dbb90 (LWP 32615)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80091550) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 40 (Thread 0xb724bb90 (LWP 32650)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80088220) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 39 (Thread 0x98ceab90 (LWP 32678)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80076358) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 38 (Thread 0x8d4d3b90 (LWP 32698)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80067fb8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 37 (Thread 0xb0924b90 (LWP 726)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a32f0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 36 (Thread 0x9c5f2b90 (LWP 746)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80088c70) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 35 (Thread 0xa7710b90 (LWP 776)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80070388) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 34 (Thread 0x9d6f5b90 (LWP 797)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a5120) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 33 (Thread 0xa6e0eb90 (LWP 852)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a8670) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 32 (Thread 0x81cbcb90 (LWP 877)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a1a60) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 31 (Thread 0xaf121b90 (LWP 954)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800c0900) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 30 (Thread 0x9a4edb90 (LWP 1013)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80089550) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 29 (Thread 0x90cdab90 (LWP 1046)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8008c350) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 28 (Thread 0xac91cb90 (LWP 1082)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800abc48) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 27 (Thread 0x89cccb90 (LWP 1136)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800952a0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 26 (Thread 0x8b4cfb90 (LWP 1164)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800c23b0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 25 (Thread 0xb5a2fb90 (LWP 1253)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8007bdb0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 24 (Thread 0x7ffffb90 (LWP 1278)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a8c38) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 23 (Thread 0x7f7feb90 (LWP 1315)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8007e418) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 22 (Thread 0x7bff7b90 (LWP 1383)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800c1000) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 21 (Thread 0xb2928b90 (LWP 1638)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a44d8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 20 (Thread 0xa660db90 (LWP 1644)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8008ba38) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 19 (Thread 0x8e4d5b90 (LWP 1658)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006fd88) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 18 (Thread 0x8c4d1b90 (LWP 1679)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8008dca0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 17 (Thread 0x904d9b90 (LWP 1702)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800ac518) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 16 (Thread 0xb3a2bb90 (LWP 1708)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a4fd8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 15 (Thread 0x9e7f8b90 (LWP 1739)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8009fcd8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 14 (Thread 0xb0123b90 (LWP 1804)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80067800) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 13 (Thread 0xb1926b90 (LWP 1814)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x800a5aa0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 12 (Thread 0xb422cb90 (LWP 1838)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80079858) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 11 (Thread 0xa6f0fb90 (LWP 2003)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f4d566 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib/libpthread.so.0
#2  0x80022015 in master_notify_submount (ap=0x8004ce60, 
    path=0x80078308 "/net/walnut", state=ST_EXPIRE) at master.c:885
#3  0x8000bcc1 in expire_proc_indirect (arg=0x800943d8) at indirect.c:477
#4  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#5  0xb7ed002e in clone () from /lib/libc.so.6

Thread 10 (Thread 0x974e7b90 (LWP 2288)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8004e508) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 9 (Thread 0xa1c02b90 (LWP 2318)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8008f028) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 8 (Thread 0x9b4efb90 (LWP 2353)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80089ea8) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 7 (Thread 0x8a4cdb90 (LWP 2379)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80069168) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 6 (Thread 0xae920b90 (LWP 2402)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006ae60) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 5 (Thread 0x7a7f4b90 (LWP 2430)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x8006b5c0) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 4 (Thread 0xa8712b90 (LWP 2466)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec6817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts (arg=0x80076778) at automount.c:659
#3  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed002e in clone () from /lib/libc.so.6

Thread 3 (Thread 0xb7b87b90 (LWP 2641)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec8af9 in ioctl () from /lib/libc.so.6
#2  0x8000b91c in expire_indirect (ap=0x8006fd88, ioctlfd=190, 
    path=<value optimized out>, when=0) at indirect.c:399
#3  0x8000bc17 in expire_proc_indirect (arg=0x80086218) at indirect.c:517
#4  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#5  0xb7ed002e in clone () from /lib/libc.so.6

Thread 2 (Thread 0xb7a4cb90 (LWP 2658)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f4fffb in read () from /lib/libpthread.so.0
#2  0x80011d2b in do_spawn (log=0x8001c510 <null>, options=0, 
    prog=0xb7a4b07c "/bin/umount", argv=0xb7a4b050)
    at /usr/include/bits/unistd.h:35
#3  0x80012301 in spawn_umount (log=0x8001c510 <null>) at spawn.c:390
#4  0x80024250 in umount_ent (ap=0x8006fd88, path=0xb7a4b2eb "/net/walnut/s1")
    at parse_subs.c:341
#5  0x80008c73 in umount_subtree_mounts (ap=0x8006fd88, 
    path=0xb7a4b2eb "/net/walnut/s1", is_autofs_fs=0) at automount.c:483
#6  0x80008e75 in umount_multi (ap=0x8006fd88, 
    path=0xb7a4b2eb "/net/walnut/s1", incl=1) at automount.c:528
#7  0x80009014 in do_expire (ap=0x8006fd88, name=0x800aa7f0 "s1", namelen=2)
    at automount.c:731
#8  0x8000b683 in do_expire_indirect (arg=0x800aa790) at indirect.c:634
#9  0xb7f49192 in start_thread () from /lib/libpthread.so.0
#10 0xb7ed002e in clone () from /lib/libc.so.6

Thread 1 (Thread 0xb7e0c6c0 (LWP 15086)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f512aa in do_sigwait () from /lib/libpthread.so.0
#2  0xb7f5134f in sigwait () from /lib/libpthread.so.0
#3  0x80007ad9 in main (argc=1, argv=<value optimized out>) at automount.c:1046
#0  0xffffe410 in __kernel_vsyscall ()
(gdb) The program is running.  Quit anyway (and detach it)? (y or n) [answered Y; input not from terminal]
Detaching from program: /usr/sbin/automount, process 15086
=----- end of backtrace -----
14:25:34 /net/merced/m1       failed
14:25:54 /net/pecos/m1        failed
14:25:59 /net/cedar/s3        failed
14:26:07 /net/pong/m1         failed
14:36:19 --                   #4535, chkd 2401, run 7, OK 110, mtd 107, of 197

14:36:41 /net/bamboo02/m1     failed
14:36:51 /net/bamboo40/m2     failed
14:36:58 /net/bamboo32/m2     failed
14:37:12 /net/pacifica/m1     failed
14:37:17 /net/bamboo08/m2     failed
14:37:22 /net/testudo/m2      mtab: /net/holly03/m1 <=> mounts: 
14:37:54 /net/laguna/m1       failed
14:38:30 --                   #4577, chkd 2513, run 7, OK 104, mtd 98, of 197

14:38:36 /net/acdc/m1         failed
14:49:20 /net/bamboo20/m1     failed
14:49:32 /net/holly04/m2      mtab: /net/hollyfs/m1 <=> mounts: 
14:49:35 /net/hollyfs/h1      failed
14:49:40 /net/riemann/m1      failed
14:49:44 /net/arachne/h1      failed
14:49:47 /net/holly02/h1      failed
14:49:55 --                   #4909, chkd 2602, run 7, OK 98, mtd 95, of 197

14:50:16 /net/cedar/m1        mtab: /net/amboy/m1 <=> mounts: 
14:50:29 /net/ojai/m1         failed
15:00:11 /net/buellton/m1     mtab: /net/bamboo05/m1 <=> mounts: 
15:00:49 /net/bamboo01/h1     failed
15:00:49 /net/bamboo01/m1     failed
15:00:52 /net/palmdale/m1     failed
15:01:18 --                   #5239, chkd 2701, run 7, OK 94, mtd 90, of 197

15:01:30 /net/oxnard/m1       failed
