From: jimc@math.ucla.edu (Jim Carter)
Subject: Re: clients suddenly start hanging (was: (no subject))
Date: Sun, 25 May 2008 17:34:42 -0700 (PDT)
Message-ID: <20080526003442.F3E27211250@simba.math.ucla.edu>
References: <20080423185018.122C53C3B1@xena.cft.ca.us>
	<1211510100.15090.27.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1211510100.15090.27.camel@raven.themaw.net>
	(Ian Kent "Fri, 23 May 2008 10:35:00 +0800")
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
Cc: Ian Kent <raven@themaw.net>

I applied autofs-5.0.3-expire-thread-create-cond-handling.patch.  There
is still hanging, but I have the impression that it may be a bit less 
than before: 4 hangs in 3+ hours, having mounted 247 filesystems.  Below 
I've included backtraces from all 4 hangs (oink, oink).  

There was one confusing incident in this test run: after one of the
filesystems was automounted, the host machine crashed (or more likely,
the owner pulled the Ethernet cable so he could plug in his laptop).
This caused every access to that machine to be very slow, which the test
program interpreted as hung automount processes.  I snipped those out.
Likely you won't see any evidence -- I don't see the string
/net/rangers/m1 in any argument list -- but if you notice a thread
working on that filesystem, ignore it.

(Re. Heads Up: I'm using the SuSE copy of the source, not GIT.  The 
patch went on with no complaints.)

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 520 Portola Plaza; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)

10:09:12 --                   #1, chkd 0, run 0, OK 576, mtd 2, of 576

10:11:36 --                   #2, chkd 574, run 5, OK 247, mtd 247, of 247

10:12:01 --                   #3, chkd 574, run 0, OK 247, mtd 247, of 247

(--snip--)

10:50:05 /net/vallejo/m1      hung
10:50:05 /net/testudo/m2      hung
10:50:05 /net/testudo/m1      hung
10:50:05 --                   #1008, chkd 1266, run 3, OK 243, mtd 240, of 247

=----- gdb backtrace of all threads -----
GNU gdb 6.6.50.20070726-cvs
Copyright (C) 2007 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i586-suse-linux"...
Using host libthread_db library "/lib/libthread_db.so.1".
Attaching to program: /usr/sbin/automount, process 14153
Loaded symbols for /usr/sbin/automount
Reading symbols from /lib/libpthread.so.0...done.
[Thread debugging using libthread_db enabled]
[New Thread 0xb7e766c0 (LWP 14153)]
[New Thread 0xb713ab90 (LWP 22025)]
[New Thread 0x79cf0b90 (LWP 21980)]
[New Thread 0x81aaab90 (LWP 21842)]
[New Thread 0x753dfb90 (LWP 19583)]
[New Thread 0x75fe4b90 (LWP 16446)]
[New Thread 0x767e5b90 (LWP 16337)]
[New Thread 0x770e7b90 (LWP 16330)]
[New Thread 0x779e9b90 (LWP 16277)]
[New Thread 0x781eab90 (LWP 16258)]
[New Thread 0x789ebb90 (LWP 16217)]
[New Thread 0x792edb90 (LWP 16189)]
[New Thread 0x79befb90 (LWP 16165)]
[New Thread 0x7a4f1b90 (LWP 16133)]
[New Thread 0x7acf2b90 (LWP 16117)]
[New Thread 0x7b4f3b90 (LWP 16068)]
[New Thread 0x7bcf4b90 (LWP 16049)]
[New Thread 0x7c4f5b90 (LWP 16038)]
[New Thread 0x7ccf6b90 (LWP 16017)]
[New Thread 0x7d4f7b90 (LWP 15902)]
[New Thread 0x7dcf8b90 (LWP 15869)]
[New Thread 0x7e4f9b90 (LWP 15854)]
[New Thread 0x7ecfab90 (LWP 15843)]
[New Thread 0x7f4fbb90 (LWP 15806)]
[New Thread 0x7fdfdb90 (LWP 15795)]
[New Thread 0x809a7b90 (LWP 15700)]
[New Thread 0x812a9b90 (LWP 15693)]
[New Thread 0x822abb90 (LWP 15633)]
[New Thread 0x82aacb90 (LWP 15569)]
[New Thread 0x832adb90 (LWP 15516)]
[New Thread 0x83bafb90 (LWP 15509)]
[New Thread 0x845b2b90 (LWP 15473)]
[New Thread 0x84db3b90 (LWP 15441)]
[New Thread 0x855b4b90 (LWP 15426)]
[New Thread 0x85eb6b90 (LWP 15418)]
[New Thread 0x866b7b90 (LWP 15390)]
[New Thread 0x86eb8b90 (LWP 15320)]
[New Thread 0x876b9b90 (LWP 15313)]
[New Thread 0x87ebab90 (LWP 15293)]
[New Thread 0x88ebcb90 (LWP 15275)]
[New Thread 0x896bdb90 (LWP 15246)]
[New Thread 0x89ebeb90 (LWP 15201)]
[New Thread 0x8a6bfb90 (LWP 15190)]
[New Thread 0x8aec0b90 (LWP 15171)]
[New Thread 0x8bec2b90 (LWP 15127)]
[New Thread 0x8c7c4b90 (LWP 15120)]
[New Thread 0x8cfc5b90 (LWP 15105)]
[New Thread 0x8d7c6b90 (LWP 15093)]
[New Thread 0x8dfc7b90 (LWP 15085)]
[New Thread 0x8e8c9b90 (LWP 15070)]
[New Thread 0x8f8cbb90 (LWP 15052)]
[New Thread 0x908cdb90 (LWP 15020)]
[New Thread 0x910ceb90 (LWP 15001)]
[New Thread 0x918cfb90 (LWP 14994)]
[New Thread 0x928d1b90 (LWP 14934)]
[New Thread 0x930d2b90 (LWP 14909)]
[New Thread 0x938d3b90 (LWP 14890)]
[New Thread 0x940d4b90 (LWP 14883)]
[New Thread 0x950d6b90 (LWP 14843)]
[New Thread 0x958d7b90 (LWP 14824)]
[New Thread 0x960d8b90 (LWP 14795)]
[New Thread 0x968d9b90 (LWP 14784)]
[New Thread 0x970dab90 (LWP 14777)]
[New Thread 0x978dbb90 (LWP 14770)]
[New Thread 0x980dcb90 (LWP 14733)]
[New Thread 0x989deb90 (LWP 14726)]
[New Thread 0x991dfb90 (LWP 14719)]
[New Thread 0x999e0b90 (LWP 14704)]
[New Thread 0x9a1e1b90 (LWP 14688)]
[New Thread 0x9a9e2b90 (LWP 14680)]
[New Thread 0x9b1e3b90 (LWP 14673)]
[New Thread 0x9b9e4b90 (LWP 14666)]
[New Thread 0x9c1e5b90 (LWP 14651)]
[New Thread 0x9c9e6b90 (LWP 14632)]
[New Thread 0x9d2e8b90 (LWP 14624)]
[New Thread 0x9dae9b90 (LWP 14612)]
[New Thread 0x9e2eab90 (LWP 14601)]
[New Thread 0x9ebecb90 (LWP 14590)]
[New Thread 0x9fcefb90 (LWP 14576)]
[New Thread 0xa04f0b90 (LWP 14569)]
[New Thread 0xa0cf1b90 (LWP 14562)]
[New Thread 0xa14f2b90 (LWP 14555)]
[New Thread 0xa24f4b90 (LWP 14539)]
[New Thread 0xa2cf5b90 (LWP 14528)]
[New Thread 0xa34f6b90 (LWP 14513)]
[New Thread 0xa3df8b90 (LWP 14502)]
[New Thread 0xa4dfab90 (LWP 14483)]
[New Thread 0xa55fbb90 (LWP 14475)]
[New Thread 0xa5dfcb90 (LWP 14464)]
[New Thread 0xa66feb90 (LWP 14457)]
[New Thread 0xa7700b90 (LWP 14442)]
[New Thread 0xa7f01b90 (LWP 14435)]
[New Thread 0xa8702b90 (LWP 14428)]
[New Thread 0xa8f03b90 (LWP 14421)]
[New Thread 0xa9704b90 (LWP 14414)]
[New Thread 0xa9f05b90 (LWP 14406)]
[New Thread 0xaa706b90 (LWP 14399)]
[New Thread 0xaaf07b90 (LWP 14391)]
[New Thread 0xab809b90 (LWP 14384)]
[New Thread 0xac00ab90 (LWP 14369)]
[New Thread 0xac80bb90 (LWP 14362)]
[New Thread 0xad00cb90 (LWP 14355)]
[New Thread 0xad80db90 (LWP 14348)]
[New Thread 0xae00eb90 (LWP 14341)]
[New Thread 0xae80fb90 (LWP 14334)]
[New Thread 0xaf010b90 (LWP 14326)]
[New Thread 0xaf811b90 (LWP 14318)]
[New Thread 0xb0012b90 (LWP 14311)]
[New Thread 0xb0813b90 (LWP 14304)]
[New Thread 0xb1014b90 (LWP 14297)]
[New Thread 0xb1815b90 (LWP 14290)]
[New Thread 0xb2016b90 (LWP 14275)]
[New Thread 0xb2817b90 (LWP 14268)]
[New Thread 0xb3018b90 (LWP 14261)]
[New Thread 0xb3819b90 (LWP 14253)]
[New Thread 0xb401ab90 (LWP 14245)]
[New Thread 0xb481bb90 (LWP 14238)]
[New Thread 0xb501cb90 (LWP 14227)]
[New Thread 0xb581db90 (LWP 14220)]
[New Thread 0xb601eb90 (LWP 14213)]
[New Thread 0xb681fb90 (LWP 14206)]
[New Thread 0xb7020b90 (LWP 14198)]
[New Thread 0xb793bb90 (LWP 14171)]
[New Thread 0xb7b91b90 (LWP 14161)]
[New Thread 0xb7cceb90 (LWP 14158)]
[New Thread 0xb7e75b90 (LWP 14155)]
[New Thread 0xb7fe3b90 (LWP 14154)]
Loaded symbols for /lib/libpthread.so.0
Reading symbols from /lib/libdl.so.2...done.
Loaded symbols for /lib/libdl.so.2
Reading symbols from /lib/libc.so.6...done.
Loaded symbols for /lib/libc.so.6
Reading symbols from /lib/ld-linux.so.2...done.
Loaded symbols for /lib/ld-linux.so.2
Reading symbols from /usr/lib/libxml2.so...done.
Loaded symbols for /usr/lib/libxml2.so
Reading symbols from /lib/libz.so.1...done.
Loaded symbols for /lib/libz.so.1
Reading symbols from /lib/libm.so.6...done.
Loaded symbols for /lib/libm.so.6
Reading symbols from /usr/lib/autofs/lookup_file.so...done.
Loaded symbols for /usr/lib/autofs/lookup_file.so
Reading symbols from /lib/libnsl.so.1...done.
Loaded symbols for /lib/libnsl.so.1
Reading symbols from /usr/lib/autofs/parse_sun.so...done.
Loaded symbols for /usr/lib/autofs/parse_sun.so
Reading symbols from /usr/lib/autofs/mount_nfs.so...done.
Loaded symbols for /usr/lib/autofs/mount_nfs.so
Reading symbols from /usr/lib/autofs/mount_bind.so...done.
Loaded symbols for /usr/lib/autofs/mount_bind.so
Reading symbols from /usr/lib/autofs/lookup_yp.so...done.
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
Reading symbols from /usr/lib/autofs/mount_autofs.so...done.
Loaded symbols for /usr/lib/autofs/mount_autofs.so
0xffffe410 in __kernel_vsyscall ()
(gdb) (gdb) 
Thread 127 (Thread 0xb7fe3b90 (LWP 14154)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7fb77ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib/libpthread.so.0
#2  0x8001dedc in alarm_handler (arg=0x0) at alarm.c:204
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 126 (Thread 0xb7e75b90 (LWP 14155)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7fb77ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib/libpthread.so.0
#2  0x80017e99 in st_queue_handler (arg=0x0) at state.c:966
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 125 (Thread 0xb7cceb90 (LWP 14158)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8004e8a8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 124 (Thread 0xb7b91b90 (LWP 14161)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8004eec8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 123 (Thread 0xb793bb90 (LWP 14171)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800513b0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 122 (Thread 0xb7020b90 (LWP 14198)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800664f8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 121 (Thread 0xb681fb90 (LWP 14206)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80066e08) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 120 (Thread 0xb601eb90 (LWP 14213)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800677a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 119 (Thread 0xb581db90 (LWP 14220)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80068098) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 118 (Thread 0xb501cb90 (LWP 14227)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80068998) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 117 (Thread 0xb481bb90 (LWP 14238)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800692a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 116 (Thread 0xb401ab90 (LWP 14245)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80069c38) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 115 (Thread 0xb3819b90 (LWP 14253)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006a5b8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 114 (Thread 0xb3018b90 (LWP 14261)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006af30) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 113 (Thread 0xb2817b90 (LWP 14268)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006b820) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 112 (Thread 0xb2016b90 (LWP 14275)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006c120) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 111 (Thread 0xb1815b90 (LWP 14290)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006cca8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 110 (Thread 0xb1014b90 (LWP 14297)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006ca28) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 109 (Thread 0xb0813b90 (LWP 14304)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006dea8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 108 (Thread 0xb0012b90 (LWP 14311)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006e7b8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 107 (Thread 0xaf811b90 (LWP 14318)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006d498) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 106 (Thread 0xaf010b90 (LWP 14326)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006fa38) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 105 (Thread 0xae80fb90 (LWP 14334)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006f020) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 104 (Thread 0xae00eb90 (LWP 14341)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80070cb8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 103 (Thread 0xad80db90 (LWP 14348)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800715c0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 102 (Thread 0xad00cb90 (LWP 14355)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80070298) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 101 (Thread 0xac80bb90 (LWP 14362)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80072848) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 100 (Thread 0xac00ab90 (LWP 14369)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80073138) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 99 (Thread 0xab809b90 (LWP 14384)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80073c20) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 98 (Thread 0xaaf07b90 (LWP 14391)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80074610) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 97 (Thread 0xaa706b90 (LWP 14399)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80074f78) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 96 (Thread 0xa9f05b90 (LWP 14406)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80075880) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 95 (Thread 0xa9704b90 (LWP 14414)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80076158) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 94 (Thread 0xa8f03b90 (LWP 14421)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80076a88) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 93 (Thread 0xa8702b90 (LWP 14428)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80077380) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 92 (Thread 0xa7f01b90 (LWP 14435)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800739a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 91 (Thread 0xa7700b90 (LWP 14442)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80078638) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 90 (Thread 0xa66feb90 (LWP 14457)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80078f40) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 89 (Thread 0xa5dfcb90 (LWP 14464)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007a4e8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 88 (Thread 0xa55fbb90 (LWP 14475)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007a268) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 87 (Thread 0xa4dfab90 (LWP 14483)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007b6b0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 86 (Thread 0xa3df8b90 (LWP 14502)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007cb20) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 85 (Thread 0xa34f6b90 (LWP 14513)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007d568) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 84 (Thread 0xa2cf5b90 (LWP 14528)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007d2e8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 83 (Thread 0xa24f4b90 (LWP 14539)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007e780) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 82 (Thread 0xa14f2b90 (LWP 14555)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007f000) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 81 (Thread 0xa0cf1b90 (LWP 14562)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80080390) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 80 (Thread 0xa04f0b90 (LWP 14569)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80080e88) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 79 (Thread 0x9fcefb90 (LWP 14576)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800816e0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 78 (Thread 0x9ebecb90 (LWP 14590)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80080c98) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 77 (Thread 0x9e2eab90 (LWP 14601)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800836b8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 76 (Thread 0x9dae9b90 (LWP 14612)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80083ed0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 75 (Thread 0x9d2e8b90 (LWP 14624)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800834e0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 74 (Thread 0x9c9e6b90 (LWP 14632)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80085338) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 73 (Thread 0x9c1e5b90 (LWP 14651)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80085e90) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 72 (Thread 0x9b9e4b90 (LWP 14666)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80085c10) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 71 (Thread 0x9b1e3b90 (LWP 14673)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80087088) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 70 (Thread 0x9a9e2b90 (LWP 14680)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80087998) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 69 (Thread 0x9a1e1b90 (LWP 14688)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80086680) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 68 (Thread 0x999e0b90 (LWP 14704)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80088228) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 67 (Thread 0x991dfb90 (LWP 14719)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800897a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 66 (Thread 0x989deb90 (LWP 14726)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008a118) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 65 (Thread 0x980dcb90 (LWP 14733)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80089e98) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 64 (Thread 0x978dbb90 (LWP 14770)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008b4b0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 63 (Thread 0x970dab90 (LWP 14777)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008bca8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 62 (Thread 0x968d9b90 (LWP 14784)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008c5b0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 61 (Thread 0x960d8b90 (LWP 14795)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008d098) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 60 (Thread 0x958d7b90 (LWP 14824)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008da10) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 59 (Thread 0x950d6b90 (LWP 14843)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008e508) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 58 (Thread 0x940d4b90 (LWP 14883)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008f970) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 57 (Thread 0x938d3b90 (LWP 14890)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800902b8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 56 (Thread 0x930d2b90 (LWP 14909)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008f6f0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 55 (Thread 0x928d1b90 (LWP 14934)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800918a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 54 (Thread 0x918cfb90 (LWP 14994)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800921d0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 53 (Thread 0x910ceb90 (LWP 15001)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80093970) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 52 (Thread 0x908cdb90 (LWP 15020)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80094120) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 51 (Thread 0x8f8cbb90 (LWP 15052)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800956b0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 50 (Thread 0x8e8c9b90 (LWP 15070)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800969c0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 49 (Thread 0x8dfc7b90 (LWP 15085)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80097520) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 48 (Thread 0x8d7c6b90 (LWP 15093)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800972a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 47 (Thread 0x8cfc5b90 (LWP 15105)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80097dd8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 46 (Thread 0x8c7c4b90 (LWP 15120)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80099348) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 45 (Thread 0x8bec2b90 (LWP 15127)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80099c98) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 44 (Thread 0x8aec0b90 (LWP 15171)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009b218) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 43 (Thread 0x8a6bfb90 (LWP 15190)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009bcf8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 42 (Thread 0x89ebeb90 (LWP 15201)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009c500) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 41 (Thread 0x896bdb90 (LWP 15246)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009d120) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 40 (Thread 0x88ebcb90 (LWP 15275)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009db10) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 39 (Thread 0x87ebab90 (LWP 15293)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009efc0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 38 (Thread 0x876b9b90 (LWP 15313)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009f950) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 37 (Thread 0x86eb8b90 (LWP 15320)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a0160) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 36 (Thread 0x866b7b90 (LWP 15390)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a1070) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 35 (Thread 0x85eb6b90 (LWP 15418)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a0df0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 34 (Thread 0x855b4b90 (LWP 15426)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a2510) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 33 (Thread 0x84db3b90 (LWP 15441)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a3068) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 32 (Thread 0x845b2b90 (LWP 15473)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a3ba8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 31 (Thread 0x83bafb90 (LWP 15509)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a49f8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 30 (Thread 0x832adb90 (LWP 15516)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a5438) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 29 (Thread 0x82aacb90 (LWP 15569)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a6070) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 28 (Thread 0x822abb90 (LWP 15633)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a6f00) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 27 (Thread 0x812a9b90 (LWP 15693)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a85a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 26 (Thread 0x809a7b90 (LWP 15700)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a8fd0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 25 (Thread 0x7fdfdb90 (LWP 15795)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800aa278) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 24 (Thread 0x7f4fbb90 (LWP 15806)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800aabd8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 23 (Thread 0x7ecfab90 (LWP 15843)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800ab710) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 22 (Thread 0x7e4f9b90 (LWP 15854)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800ab400) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 21 (Thread 0x7dcf8b90 (LWP 15869)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800abfb8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 20 (Thread 0x7d4f7b90 (LWP 15902)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800ad528) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 19 (Thread 0x7ccf6b90 (LWP 16017)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800ae580) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 18 (Thread 0x7c4f5b90 (LWP 16038)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800af088) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 17 (Thread 0x7bcf4b90 (LWP 16049)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800af980) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 16 (Thread 0x7b4f3b90 (LWP 16068)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800aee98) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 15 (Thread 0x7acf2b90 (LWP 16117)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b0e78) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 14 (Thread 0x7a4f1b90 (LWP 16133)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b19e8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 13 (Thread 0x79befb90 (LWP 16165)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b26a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 12 (Thread 0x792edb90 (LWP 16189)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b32b8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 11 (Thread 0x789ebb90 (LWP 16217)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7fb6f42 in pthread_rwlock_wrlock () from /lib/libpthread.so.0
#2  0x800204d8 in master_source_writelock (entry=0x8004e808) at master.c:558
#3  0x8000a753 in handle_mounts (arg=0x800b3e80) at automount.c:1549
#4  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#5  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 10 (Thread 0x781eab90 (LWP 16258)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b4968) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 9 (Thread 0x779e9b90 (LWP 16277)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b5458) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 8 (Thread 0x770e7b90 (LWP 16330)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b62c0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 7 (Thread 0x767e5b90 (LWP 16337)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b6ce8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 6 (Thread 0x75fe4b90 (LWP 16446)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b7c20) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 5 (Thread 0x753dfb90 (LWP 19583)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7fb7566 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib/libpthread.so.0
#2  0x80021777 in master_notify_submount (ap=0x8004e8a8, 
    path=0x800c8078 "/net/nemo07", state=ST_EXPIRE) at master.c:920
#3  0x8000c84d in expire_proc_indirect (arg=0x800b7a20) at indirect.c:468
#4  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#5  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 4 (Thread 0x81aaab90 (LWP 21842)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a8170) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 3 (Thread 0x79cf0b90 (LWP 21980)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7fb9c1e in __lll_mutex_lock_wait () from /lib/libpthread.so.0
#2  0xb7fb5a58 in _L_mutex_lock_86 () from /lib/libpthread.so.0
#3  0xb7fb547d in pthread_mutex_lock () from /lib/libpthread.so.0
#4  0xb796271e in mount_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
    name=0x79ceeaa0 "testudo", name_len=7, what=0x79ceea70 "file", 
    fstype=0x79ceeac0 "autofs", 
    c_options=0x79ceeae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=testudo", context=0x18) at mount_autofs.c:217
#5  0x80013994 in do_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
    name=0x79ceeaa0 "testudo", name_len=7, what=0x79ceea70 "file", 
    fstype=0x79ceeac0 "autofs", 
    options=0x79ceeae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=testudo")
    at mount.c:73
#6  0xb7bb7aa3 in sun_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
    name=0x79ceee10 "testudo", namelen=7, 
    loc=0x80080180 "file:/etc/auto.net.generic", loclen=26, 
    options=0x79ceeae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=testudo", 
    ctxt=0x8003a600) at parse_sun.c:657
#7  0xb7bb891a in parse_mount (ap=0x8004e8a8, name=0x79ceee10 "testudo", 
    name_len=7, 
    mapent=0x79ceed80 "-rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=&\tfile:/etc/auto.net.generic", context=0x8003a600) at parse_sun.c:1458
#8  0xb7e4fe70 in lookup_mount (ap=0x8004e8a8, name=0x79cf01c8 "testudo", 
    name_len=7, context=0x8004e7f8) at lookup_file.c:1136
#9  0x8001452c in do_lookup_mount (ap=0x8004e8a8, map=0x8003a6e8, 
    name=0x79cf01c8 "testudo", name_len=7) at lookup.c:668
#10 0x800146ba in lookup_name_file_source_instance (ap=0x8004e8a8, 
    map=0x8004e9b0, name=0x79cf01c8 "testudo", name_len=7) at lookup.c:708
#11 0x80015289 in lookup_nss_mount (ap=0x8004e8a8, source=0x0, 
    name=0x79cf01c8 "testudo", name_len=7) at lookup.c:856
#12 0x8000be7a in do_mount_indirect (arg=0x80096370) at indirect.c:885
#13 0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#14 0xb7f3a02e in clone () from /lib/libc.so.6

Thread 2 (Thread 0xb713ab90 (LWP 22025)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7fb9c1e in __lll_mutex_lock_wait () from /lib/libpthread.so.0
#2  0xb7fb5a58 in _L_mutex_lock_86 () from /lib/libpthread.so.0
#3  0xb7fb547d in pthread_mutex_lock () from /lib/libpthread.so.0
#4  0xb796271e in mount_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
    name=0xb7138aa0 "vallejo", name_len=7, what=0xb7138a70 "file", 
    fstype=0xb7138ac0 "autofs", 
    c_options=0xb7138ae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=vallejo", context=0x18) at mount_autofs.c:217
#5  0x80013994 in do_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
    name=0xb7138aa0 "vallejo", name_len=7, what=0xb7138a70 "file", 
    fstype=0xb7138ac0 "autofs", 
    options=0xb7138ae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=vallejo")
    at mount.c:73
#6  0xb7bb7aa3 in sun_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
    name=0xb7138e10 "vallejo", namelen=7, 
    loc=0x80081610 "file:/etc/auto.net.generic", loclen=26, 
    options=0xb7138ae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=vallejo", 
    ctxt=0x8003a600) at parse_sun.c:657
#7  0xb7bb891a in parse_mount (ap=0x8004e8a8, name=0xb7138e10 "vallejo", 
    name_len=7, 
    mapent=0xb7138d80 "-rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=&\tfile:/etc/auto.net.generic", context=0x8003a600) at parse_sun.c:1458
#8  0xb7e4fe70 in lookup_mount (ap=0x8004e8a8, name=0xb713a1c8 "vallejo", 
    name_len=7, context=0x8004e7f8) at lookup_file.c:1136
#9  0x8001452c in do_lookup_mount (ap=0x8004e8a8, map=0x8003a6e8, 
    name=0xb713a1c8 "vallejo", name_len=7) at lookup.c:668
#10 0x800146ba in lookup_name_file_source_instance (ap=0x8004e8a8, 
    map=0x8004e9b0, name=0xb713a1c8 "vallejo", name_len=7) at lookup.c:708
#11 0x80015289 in lookup_nss_mount (ap=0x8004e8a8, source=0x0, 
    name=0xb713a1c8 "vallejo", name_len=7) at lookup.c:856
#12 0x8000be7a in do_mount_indirect (arg=0x80096370) at indirect.c:885
#13 0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#14 0xb7f3a02e in clone () from /lib/libc.so.6

Thread 1 (Thread 0xb7e766c0 (LWP 14153)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7fbb2aa in do_sigwait () from /lib/libpthread.so.0
#2  0xb7fbb34f in sigwait () from /lib/libpthread.so.0
#3  0x80008349 in main (argc=0, argv=0xbfe48998) at automount.c:1366
#0  0xffffe410 in __kernel_vsyscall ()
(gdb) Hangup detected on fd 0
error detected on stdin
The program is running.  Quit anyway (and detach it)? (y or n) [answered Y; input not from terminal]
Detaching from program: /usr/sbin/automount, process 14153
=----- end of backtrace -----
10:50:31 /net/nemo07/m1       hung
10:50:31 --                   #1009, chkd 1270, run 4, OK 242, mtd 243, of 247

=----- gdb backtrace of all threads -----
GNU gdb 6.6.50.20070726-cvs
Copyright (C) 2007 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i586-suse-linux"...
Using host libthread_db library "/lib/libthread_db.so.1".
Attaching to program: /usr/sbin/automount, process 14153
Loaded symbols for /usr/sbin/automount
Reading symbols from /lib/libpthread.so.0...done.
[Thread debugging using libthread_db enabled]
[New Thread 0xb7e766c0 (LWP 14153)]
[New Thread 0xb713ab90 (LWP 22025)]
[New Thread 0x79cf0b90 (LWP 21980)]
[New Thread 0x81aaab90 (LWP 21842)]
[New Thread 0x753dfb90 (LWP 19583)]
[New Thread 0x75fe4b90 (LWP 16446)]
[New Thread 0x767e5b90 (LWP 16337)]
[New Thread 0x770e7b90 (LWP 16330)]
[New Thread 0x779e9b90 (LWP 16277)]
[New Thread 0x781eab90 (LWP 16258)]
[New Thread 0x789ebb90 (LWP 16217)]
[New Thread 0x792edb90 (LWP 16189)]
[New Thread 0x79befb90 (LWP 16165)]
[New Thread 0x7a4f1b90 (LWP 16133)]
[New Thread 0x7acf2b90 (LWP 16117)]
[New Thread 0x7b4f3b90 (LWP 16068)]
[New Thread 0x7bcf4b90 (LWP 16049)]
[New Thread 0x7c4f5b90 (LWP 16038)]
[New Thread 0x7ccf6b90 (LWP 16017)]
[New Thread 0x7d4f7b90 (LWP 15902)]
[New Thread 0x7dcf8b90 (LWP 15869)]
[New Thread 0x7e4f9b90 (LWP 15854)]
[New Thread 0x7ecfab90 (LWP 15843)]
[New Thread 0x7f4fbb90 (LWP 15806)]
[New Thread 0x7fdfdb90 (LWP 15795)]
[New Thread 0x809a7b90 (LWP 15700)]
[New Thread 0x812a9b90 (LWP 15693)]
[New Thread 0x822abb90 (LWP 15633)]
[New Thread 0x82aacb90 (LWP 15569)]
[New Thread 0x832adb90 (LWP 15516)]
[New Thread 0x83bafb90 (LWP 15509)]
[New Thread 0x845b2b90 (LWP 15473)]
[New Thread 0x84db3b90 (LWP 15441)]
[New Thread 0x855b4b90 (LWP 15426)]
[New Thread 0x85eb6b90 (LWP 15418)]
[New Thread 0x866b7b90 (LWP 15390)]
[New Thread 0x86eb8b90 (LWP 15320)]
[New Thread 0x876b9b90 (LWP 15313)]
[New Thread 0x87ebab90 (LWP 15293)]
[New Thread 0x88ebcb90 (LWP 15275)]
[New Thread 0x896bdb90 (LWP 15246)]
[New Thread 0x89ebeb90 (LWP 15201)]
[New Thread 0x8a6bfb90 (LWP 15190)]
[New Thread 0x8aec0b90 (LWP 15171)]
[New Thread 0x8bec2b90 (LWP 15127)]
[New Thread 0x8c7c4b90 (LWP 15120)]
[New Thread 0x8cfc5b90 (LWP 15105)]
[New Thread 0x8d7c6b90 (LWP 15093)]
[New Thread 0x8dfc7b90 (LWP 15085)]
[New Thread 0x8e8c9b90 (LWP 15070)]
[New Thread 0x8f8cbb90 (LWP 15052)]
[New Thread 0x908cdb90 (LWP 15020)]
[New Thread 0x910ceb90 (LWP 15001)]
[New Thread 0x918cfb90 (LWP 14994)]
[New Thread 0x928d1b90 (LWP 14934)]
[New Thread 0x930d2b90 (LWP 14909)]
[New Thread 0x938d3b90 (LWP 14890)]
[New Thread 0x940d4b90 (LWP 14883)]
[New Thread 0x950d6b90 (LWP 14843)]
[New Thread 0x958d7b90 (LWP 14824)]
[New Thread 0x960d8b90 (LWP 14795)]
[New Thread 0x968d9b90 (LWP 14784)]
[New Thread 0x970dab90 (LWP 14777)]
[New Thread 0x978dbb90 (LWP 14770)]
[New Thread 0x980dcb90 (LWP 14733)]
[New Thread 0x989deb90 (LWP 14726)]
[New Thread 0x991dfb90 (LWP 14719)]
[New Thread 0x999e0b90 (LWP 14704)]
[New Thread 0x9a1e1b90 (LWP 14688)]
[New Thread 0x9a9e2b90 (LWP 14680)]
[New Thread 0x9b1e3b90 (LWP 14673)]
[New Thread 0x9b9e4b90 (LWP 14666)]
[New Thread 0x9c1e5b90 (LWP 14651)]
[New Thread 0x9c9e6b90 (LWP 14632)]
[New Thread 0x9d2e8b90 (LWP 14624)]
[New Thread 0x9dae9b90 (LWP 14612)]
[New Thread 0x9e2eab90 (LWP 14601)]
[New Thread 0x9ebecb90 (LWP 14590)]
[New Thread 0x9fcefb90 (LWP 14576)]
[New Thread 0xa04f0b90 (LWP 14569)]
[New Thread 0xa0cf1b90 (LWP 14562)]
[New Thread 0xa14f2b90 (LWP 14555)]
[New Thread 0xa24f4b90 (LWP 14539)]
[New Thread 0xa2cf5b90 (LWP 14528)]
[New Thread 0xa34f6b90 (LWP 14513)]
[New Thread 0xa3df8b90 (LWP 14502)]
[New Thread 0xa4dfab90 (LWP 14483)]
[New Thread 0xa55fbb90 (LWP 14475)]
[New Thread 0xa5dfcb90 (LWP 14464)]
[New Thread 0xa66feb90 (LWP 14457)]
[New Thread 0xa7700b90 (LWP 14442)]
[New Thread 0xa7f01b90 (LWP 14435)]
[New Thread 0xa8702b90 (LWP 14428)]
[New Thread 0xa8f03b90 (LWP 14421)]
[New Thread 0xa9704b90 (LWP 14414)]
[New Thread 0xa9f05b90 (LWP 14406)]
[New Thread 0xaa706b90 (LWP 14399)]
[New Thread 0xaaf07b90 (LWP 14391)]
[New Thread 0xab809b90 (LWP 14384)]
[New Thread 0xac00ab90 (LWP 14369)]
[New Thread 0xac80bb90 (LWP 14362)]
[New Thread 0xad00cb90 (LWP 14355)]
[New Thread 0xad80db90 (LWP 14348)]
[New Thread 0xae00eb90 (LWP 14341)]
[New Thread 0xae80fb90 (LWP 14334)]
[New Thread 0xaf010b90 (LWP 14326)]
[New Thread 0xaf811b90 (LWP 14318)]
[New Thread 0xb0012b90 (LWP 14311)]
[New Thread 0xb0813b90 (LWP 14304)]
[New Thread 0xb1014b90 (LWP 14297)]
[New Thread 0xb1815b90 (LWP 14290)]
[New Thread 0xb2016b90 (LWP 14275)]
[New Thread 0xb2817b90 (LWP 14268)]
[New Thread 0xb3018b90 (LWP 14261)]
[New Thread 0xb3819b90 (LWP 14253)]
[New Thread 0xb401ab90 (LWP 14245)]
[New Thread 0xb481bb90 (LWP 14238)]
[New Thread 0xb501cb90 (LWP 14227)]
[New Thread 0xb581db90 (LWP 14220)]
[New Thread 0xb601eb90 (LWP 14213)]
[New Thread 0xb681fb90 (LWP 14206)]
[New Thread 0xb7020b90 (LWP 14198)]
[New Thread 0xb793bb90 (LWP 14171)]
[New Thread 0xb7b91b90 (LWP 14161)]
[New Thread 0xb7cceb90 (LWP 14158)]
[New Thread 0xb7e75b90 (LWP 14155)]
[New Thread 0xb7fe3b90 (LWP 14154)]
Loaded symbols for /lib/libpthread.so.0
Reading symbols from /lib/libdl.so.2...done.
Loaded symbols for /lib/libdl.so.2
Reading symbols from /lib/libc.so.6...done.
Loaded symbols for /lib/libc.so.6
Reading symbols from /lib/ld-linux.so.2...done.
Loaded symbols for /lib/ld-linux.so.2
Reading symbols from /usr/lib/libxml2.so...done.
Loaded symbols for /usr/lib/libxml2.so
Reading symbols from /lib/libz.so.1...done.
Loaded symbols for /lib/libz.so.1
Reading symbols from /lib/libm.so.6...done.
Loaded symbols for /lib/libm.so.6
Reading symbols from /usr/lib/autofs/lookup_file.so...done.
Loaded symbols for /usr/lib/autofs/lookup_file.so
Reading symbols from /lib/libnsl.so.1...done.
Loaded symbols for /lib/libnsl.so.1
Reading symbols from /usr/lib/autofs/parse_sun.so...done.
Loaded symbols for /usr/lib/autofs/parse_sun.so
Reading symbols from /usr/lib/autofs/mount_nfs.so...done.
Loaded symbols for /usr/lib/autofs/mount_nfs.so
Reading symbols from /usr/lib/autofs/mount_bind.so...done.
Loaded symbols for /usr/lib/autofs/mount_bind.so
Reading symbols from /usr/lib/autofs/lookup_yp.so...done.
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
Reading symbols from /usr/lib/autofs/mount_autofs.so...done.
Loaded symbols for /usr/lib/autofs/mount_autofs.so
0xffffe410 in __kernel_vsyscall ()
(gdb) (gdb) 
Thread 127 (Thread 0xb7fe3b90 (LWP 14154)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7fb77ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib/libpthread.so.0
#2  0x8001dedc in alarm_handler (arg=0x0) at alarm.c:204
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 126 (Thread 0xb7e75b90 (LWP 14155)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7fb77ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib/libpthread.so.0
#2  0x80017e99 in st_queue_handler (arg=0x0) at state.c:966
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 125 (Thread 0xb7cceb90 (LWP 14158)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8004e8a8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 124 (Thread 0xb7b91b90 (LWP 14161)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8004eec8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 123 (Thread 0xb793bb90 (LWP 14171)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800513b0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 122 (Thread 0xb7020b90 (LWP 14198)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800664f8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 121 (Thread 0xb681fb90 (LWP 14206)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80066e08) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 120 (Thread 0xb601eb90 (LWP 14213)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800677a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 119 (Thread 0xb581db90 (LWP 14220)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80068098) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 118 (Thread 0xb501cb90 (LWP 14227)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80068998) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 117 (Thread 0xb481bb90 (LWP 14238)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800692a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 116 (Thread 0xb401ab90 (LWP 14245)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80069c38) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 115 (Thread 0xb3819b90 (LWP 14253)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006a5b8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 114 (Thread 0xb3018b90 (LWP 14261)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006af30) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 113 (Thread 0xb2817b90 (LWP 14268)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006b820) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 112 (Thread 0xb2016b90 (LWP 14275)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006c120) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 111 (Thread 0xb1815b90 (LWP 14290)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006cca8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 110 (Thread 0xb1014b90 (LWP 14297)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006ca28) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 109 (Thread 0xb0813b90 (LWP 14304)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006dea8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 108 (Thread 0xb0012b90 (LWP 14311)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006e7b8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 107 (Thread 0xaf811b90 (LWP 14318)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006d498) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 106 (Thread 0xaf010b90 (LWP 14326)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006fa38) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 105 (Thread 0xae80fb90 (LWP 14334)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006f020) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 104 (Thread 0xae00eb90 (LWP 14341)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80070cb8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 103 (Thread 0xad80db90 (LWP 14348)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800715c0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 102 (Thread 0xad00cb90 (LWP 14355)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80070298) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 101 (Thread 0xac80bb90 (LWP 14362)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80072848) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 100 (Thread 0xac00ab90 (LWP 14369)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80073138) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 99 (Thread 0xab809b90 (LWP 14384)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80073c20) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 98 (Thread 0xaaf07b90 (LWP 14391)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80074610) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 97 (Thread 0xaa706b90 (LWP 14399)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80074f78) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 96 (Thread 0xa9f05b90 (LWP 14406)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80075880) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 95 (Thread 0xa9704b90 (LWP 14414)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80076158) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 94 (Thread 0xa8f03b90 (LWP 14421)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80076a88) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 93 (Thread 0xa8702b90 (LWP 14428)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80077380) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 92 (Thread 0xa7f01b90 (LWP 14435)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800739a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 91 (Thread 0xa7700b90 (LWP 14442)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80078638) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 90 (Thread 0xa66feb90 (LWP 14457)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80078f40) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 89 (Thread 0xa5dfcb90 (LWP 14464)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007a4e8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 88 (Thread 0xa55fbb90 (LWP 14475)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007a268) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 87 (Thread 0xa4dfab90 (LWP 14483)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007b6b0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 86 (Thread 0xa3df8b90 (LWP 14502)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007cb20) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 85 (Thread 0xa34f6b90 (LWP 14513)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007d568) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 84 (Thread 0xa2cf5b90 (LWP 14528)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007d2e8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 83 (Thread 0xa24f4b90 (LWP 14539)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007e780) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 82 (Thread 0xa14f2b90 (LWP 14555)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007f000) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 81 (Thread 0xa0cf1b90 (LWP 14562)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80080390) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 80 (Thread 0xa04f0b90 (LWP 14569)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80080e88) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 79 (Thread 0x9fcefb90 (LWP 14576)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800816e0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 78 (Thread 0x9ebecb90 (LWP 14590)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80080c98) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 77 (Thread 0x9e2eab90 (LWP 14601)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800836b8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 76 (Thread 0x9dae9b90 (LWP 14612)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80083ed0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 75 (Thread 0x9d2e8b90 (LWP 14624)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800834e0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 74 (Thread 0x9c9e6b90 (LWP 14632)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80085338) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 73 (Thread 0x9c1e5b90 (LWP 14651)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80085e90) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 72 (Thread 0x9b9e4b90 (LWP 14666)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80085c10) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 71 (Thread 0x9b1e3b90 (LWP 14673)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80087088) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 70 (Thread 0x9a9e2b90 (LWP 14680)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80087998) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 69 (Thread 0x9a1e1b90 (LWP 14688)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80086680) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 68 (Thread 0x999e0b90 (LWP 14704)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80088228) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 67 (Thread 0x991dfb90 (LWP 14719)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800897a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 66 (Thread 0x989deb90 (LWP 14726)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008a118) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 65 (Thread 0x980dcb90 (LWP 14733)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80089e98) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 64 (Thread 0x978dbb90 (LWP 14770)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008b4b0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 63 (Thread 0x970dab90 (LWP 14777)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008bca8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 62 (Thread 0x968d9b90 (LWP 14784)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008c5b0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 61 (Thread 0x960d8b90 (LWP 14795)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008d098) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 60 (Thread 0x958d7b90 (LWP 14824)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008da10) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 59 (Thread 0x950d6b90 (LWP 14843)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008e508) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 58 (Thread 0x940d4b90 (LWP 14883)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008f970) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 57 (Thread 0x938d3b90 (LWP 14890)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800902b8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 56 (Thread 0x930d2b90 (LWP 14909)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008f6f0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 55 (Thread 0x928d1b90 (LWP 14934)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800918a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 54 (Thread 0x918cfb90 (LWP 14994)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800921d0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 53 (Thread 0x910ceb90 (LWP 15001)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80093970) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 52 (Thread 0x908cdb90 (LWP 15020)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80094120) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 51 (Thread 0x8f8cbb90 (LWP 15052)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800956b0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 50 (Thread 0x8e8c9b90 (LWP 15070)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800969c0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 49 (Thread 0x8dfc7b90 (LWP 15085)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80097520) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 48 (Thread 0x8d7c6b90 (LWP 15093)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800972a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 47 (Thread 0x8cfc5b90 (LWP 15105)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80097dd8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 46 (Thread 0x8c7c4b90 (LWP 15120)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80099348) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 45 (Thread 0x8bec2b90 (LWP 15127)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80099c98) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 44 (Thread 0x8aec0b90 (LWP 15171)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009b218) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 43 (Thread 0x8a6bfb90 (LWP 15190)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009bcf8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 42 (Thread 0x89ebeb90 (LWP 15201)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009c500) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 41 (Thread 0x896bdb90 (LWP 15246)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009d120) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 40 (Thread 0x88ebcb90 (LWP 15275)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009db10) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 39 (Thread 0x87ebab90 (LWP 15293)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009efc0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 38 (Thread 0x876b9b90 (LWP 15313)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009f950) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 37 (Thread 0x86eb8b90 (LWP 15320)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a0160) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 36 (Thread 0x866b7b90 (LWP 15390)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a1070) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 35 (Thread 0x85eb6b90 (LWP 15418)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a0df0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 34 (Thread 0x855b4b90 (LWP 15426)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a2510) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 33 (Thread 0x84db3b90 (LWP 15441)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a3068) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 32 (Thread 0x845b2b90 (LWP 15473)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a3ba8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 31 (Thread 0x83bafb90 (LWP 15509)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a49f8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 30 (Thread 0x832adb90 (LWP 15516)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a5438) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 29 (Thread 0x82aacb90 (LWP 15569)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a6070) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 28 (Thread 0x822abb90 (LWP 15633)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a6f00) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 27 (Thread 0x812a9b90 (LWP 15693)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a85a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 26 (Thread 0x809a7b90 (LWP 15700)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a8fd0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 25 (Thread 0x7fdfdb90 (LWP 15795)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800aa278) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 24 (Thread 0x7f4fbb90 (LWP 15806)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800aabd8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 23 (Thread 0x7ecfab90 (LWP 15843)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800ab710) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 22 (Thread 0x7e4f9b90 (LWP 15854)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800ab400) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 21 (Thread 0x7dcf8b90 (LWP 15869)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800abfb8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 20 (Thread 0x7d4f7b90 (LWP 15902)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800ad528) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 19 (Thread 0x7ccf6b90 (LWP 16017)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800ae580) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 18 (Thread 0x7c4f5b90 (LWP 16038)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800af088) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 17 (Thread 0x7bcf4b90 (LWP 16049)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800af980) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 16 (Thread 0x7b4f3b90 (LWP 16068)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800aee98) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 15 (Thread 0x7acf2b90 (LWP 16117)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b0e78) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 14 (Thread 0x7a4f1b90 (LWP 16133)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b19e8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 13 (Thread 0x79befb90 (LWP 16165)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b26a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 12 (Thread 0x792edb90 (LWP 16189)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b32b8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 11 (Thread 0x789ebb90 (LWP 16217)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7fb6f42 in pthread_rwlock_wrlock () from /lib/libpthread.so.0
#2  0x800204d8 in master_source_writelock (entry=0x8004e808) at master.c:558
#3  0x8000a753 in handle_mounts (arg=0x800b3e80) at automount.c:1549
#4  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#5  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 10 (Thread 0x781eab90 (LWP 16258)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b4968) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 9 (Thread 0x779e9b90 (LWP 16277)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b5458) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 8 (Thread 0x770e7b90 (LWP 16330)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b62c0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 7 (Thread 0x767e5b90 (LWP 16337)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b6ce8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 6 (Thread 0x75fe4b90 (LWP 16446)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b7c20) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 5 (Thread 0x753dfb90 (LWP 19583)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7fb7566 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib/libpthread.so.0
#2  0x80021777 in master_notify_submount (ap=0x8004e8a8, 
    path=0x800c8078 "/net/nemo07", state=ST_EXPIRE) at master.c:920
#3  0x8000c84d in expire_proc_indirect (arg=0x800b7a20) at indirect.c:468
#4  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#5  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 4 (Thread 0x81aaab90 (LWP 21842)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a8170) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 3 (Thread 0x79cf0b90 (LWP 21980)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7fb9c1e in __lll_mutex_lock_wait () from /lib/libpthread.so.0
#2  0xb7fb5a58 in _L_mutex_lock_86 () from /lib/libpthread.so.0
#3  0xb7fb547d in pthread_mutex_lock () from /lib/libpthread.so.0
#4  0xb796271e in mount_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
    name=0x79ceeaa0 "testudo", name_len=7, what=0x79ceea70 "file", 
    fstype=0x79ceeac0 "autofs", 
    c_options=0x79ceeae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=testudo", context=0x18) at mount_autofs.c:217
#5  0x80013994 in do_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
    name=0x79ceeaa0 "testudo", name_len=7, what=0x79ceea70 "file", 
    fstype=0x79ceeac0 "autofs", 
    options=0x79ceeae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=testudo")
    at mount.c:73
#6  0xb7bb7aa3 in sun_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
    name=0x79ceee10 "testudo", namelen=7, 
    loc=0x80080180 "file:/etc/auto.net.generic", loclen=26, 
    options=0x79ceeae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=testudo", 
    ctxt=0x8003a600) at parse_sun.c:657
#7  0xb7bb891a in parse_mount (ap=0x8004e8a8, name=0x79ceee10 "testudo", 
    name_len=7, 
    mapent=0x79ceed80 "-rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=&\tfile:/etc/auto.net.generic", context=0x8003a600) at parse_sun.c:1458
#8  0xb7e4fe70 in lookup_mount (ap=0x8004e8a8, name=0x79cf01c8 "testudo", 
    name_len=7, context=0x8004e7f8) at lookup_file.c:1136
#9  0x8001452c in do_lookup_mount (ap=0x8004e8a8, map=0x8003a6e8, 
    name=0x79cf01c8 "testudo", name_len=7) at lookup.c:668
#10 0x800146ba in lookup_name_file_source_instance (ap=0x8004e8a8, 
    map=0x8004e9b0, name=0x79cf01c8 "testudo", name_len=7) at lookup.c:708
#11 0x80015289 in lookup_nss_mount (ap=0x8004e8a8, source=0x0, 
    name=0x79cf01c8 "testudo", name_len=7) at lookup.c:856
#12 0x8000be7a in do_mount_indirect (arg=0x80096370) at indirect.c:885
#13 0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#14 0xb7f3a02e in clone () from /lib/libc.so.6

Thread 2 (Thread 0xb713ab90 (LWP 22025)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7fb9c1e in __lll_mutex_lock_wait () from /lib/libpthread.so.0
#2  0xb7fb5a58 in _L_mutex_lock_86 () from /lib/libpthread.so.0
#3  0xb7fb547d in pthread_mutex_lock () from /lib/libpthread.so.0
#4  0xb796271e in mount_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
    name=0xb7138aa0 "vallejo", name_len=7, what=0xb7138a70 "file", 
    fstype=0xb7138ac0 "autofs", 
    c_options=0xb7138ae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=vallejo", context=0x18) at mount_autofs.c:217
#5  0x80013994 in do_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
    name=0xb7138aa0 "vallejo", name_len=7, what=0xb7138a70 "file", 
    fstype=0xb7138ac0 "autofs", 
    options=0xb7138ae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=vallejo")
    at mount.c:73
#6  0xb7bb7aa3 in sun_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
    name=0xb7138e10 "vallejo", namelen=7, 
    loc=0x80081610 "file:/etc/auto.net.generic", loclen=26, 
    options=0xb7138ae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=vallejo", 
    ctxt=0x8003a600) at parse_sun.c:657
#7  0xb7bb891a in parse_mount (ap=0x8004e8a8, name=0xb7138e10 "vallejo", 
    name_len=7, 
    mapent=0xb7138d80 "-rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=&\tfile:/etc/auto.net.generic", context=0x8003a600) at parse_sun.c:1458
#8  0xb7e4fe70 in lookup_mount (ap=0x8004e8a8, name=0xb713a1c8 "vallejo", 
    name_len=7, context=0x8004e7f8) at lookup_file.c:1136
#9  0x8001452c in do_lookup_mount (ap=0x8004e8a8, map=0x8003a6e8, 
    name=0xb713a1c8 "vallejo", name_len=7) at lookup.c:668
#10 0x800146ba in lookup_name_file_source_instance (ap=0x8004e8a8, 
    map=0x8004e9b0, name=0xb713a1c8 "vallejo", name_len=7) at lookup.c:708
#11 0x80015289 in lookup_nss_mount (ap=0x8004e8a8, source=0x0, 
    name=0xb713a1c8 "vallejo", name_len=7) at lookup.c:856
#12 0x8000be7a in do_mount_indirect (arg=0x80096370) at indirect.c:885
#13 0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#14 0xb7f3a02e in clone () from /lib/libc.so.6

Thread 1 (Thread 0xb7e766c0 (LWP 14153)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7fbb2aa in do_sigwait () from /lib/libpthread.so.0
#2  0xb7fbb34f in sigwait () from /lib/libpthread.so.0
#3  0x80008349 in main (argc=0, argv=0xbfe48998) at automount.c:1366
#0  0xffffe410 in __kernel_vsyscall ()
(gdb) Hangup detected on fd 0
error detected on stdin
The program is running.  Quit anyway (and detach it)? (y or n) [answered Y; input not from terminal]
Detaching from program: /usr/sbin/automount, process 14153
=----- end of backtrace -----

(--snip--)

12:00:44 /net/ulanda/m2       still mounted after 900 secs, state = success
12:00:44 /net/ulanda/m1       still mounted after 900 secs, state = success
12:01:09 /net/ulanda/m2       hung
12:01:09 --                   #2924, chkd 2428, run 5, OK 241, mtd 243, of 247

=----- gdb backtrace of all threads -----
GNU gdb 6.6.50.20070726-cvs
Copyright (C) 2007 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i586-suse-linux"...
Using host libthread_db library "/lib/libthread_db.so.1".
Attaching to program: /usr/sbin/automount, process 14153
Loaded symbols for /usr/sbin/automount
Reading symbols from /lib/libpthread.so.0...done.
[Thread debugging using libthread_db enabled]
[New Thread 0xb7e766c0 (LWP 14153)]
[New Thread 0xb713ab90 (LWP 22025)]
[New Thread 0x79cf0b90 (LWP 21980)]
[New Thread 0x81aaab90 (LWP 21842)]
[New Thread 0x753dfb90 (LWP 19583)]
[New Thread 0x75fe4b90 (LWP 16446)]
[New Thread 0x767e5b90 (LWP 16337)]
[New Thread 0x770e7b90 (LWP 16330)]
[New Thread 0x779e9b90 (LWP 16277)]
[New Thread 0x781eab90 (LWP 16258)]
[New Thread 0x789ebb90 (LWP 16217)]
[New Thread 0x792edb90 (LWP 16189)]
[New Thread 0x79befb90 (LWP 16165)]
[New Thread 0x7a4f1b90 (LWP 16133)]
[New Thread 0x7acf2b90 (LWP 16117)]
[New Thread 0x7b4f3b90 (LWP 16068)]
[New Thread 0x7bcf4b90 (LWP 16049)]
[New Thread 0x7c4f5b90 (LWP 16038)]
[New Thread 0x7ccf6b90 (LWP 16017)]
[New Thread 0x7d4f7b90 (LWP 15902)]
[New Thread 0x7dcf8b90 (LWP 15869)]
[New Thread 0x7e4f9b90 (LWP 15854)]
[New Thread 0x7ecfab90 (LWP 15843)]
[New Thread 0x7f4fbb90 (LWP 15806)]
[New Thread 0x7fdfdb90 (LWP 15795)]
[New Thread 0x809a7b90 (LWP 15700)]
[New Thread 0x812a9b90 (LWP 15693)]
[New Thread 0x822abb90 (LWP 15633)]
[New Thread 0x82aacb90 (LWP 15569)]
[New Thread 0x832adb90 (LWP 15516)]
[New Thread 0x83bafb90 (LWP 15509)]
[New Thread 0x845b2b90 (LWP 15473)]
[New Thread 0x84db3b90 (LWP 15441)]
[New Thread 0x855b4b90 (LWP 15426)]
[New Thread 0x85eb6b90 (LWP 15418)]
[New Thread 0x866b7b90 (LWP 15390)]
[New Thread 0x86eb8b90 (LWP 15320)]
[New Thread 0x876b9b90 (LWP 15313)]
[New Thread 0x87ebab90 (LWP 15293)]
[New Thread 0x88ebcb90 (LWP 15275)]
[New Thread 0x896bdb90 (LWP 15246)]
[New Thread 0x89ebeb90 (LWP 15201)]
[New Thread 0x8a6bfb90 (LWP 15190)]
[New Thread 0x8aec0b90 (LWP 15171)]
[New Thread 0x8bec2b90 (LWP 15127)]
[New Thread 0x8c7c4b90 (LWP 15120)]
[New Thread 0x8cfc5b90 (LWP 15105)]
[New Thread 0x8d7c6b90 (LWP 15093)]
[New Thread 0x8dfc7b90 (LWP 15085)]
[New Thread 0x8e8c9b90 (LWP 15070)]
[New Thread 0x8f8cbb90 (LWP 15052)]
[New Thread 0x908cdb90 (LWP 15020)]
[New Thread 0x910ceb90 (LWP 15001)]
[New Thread 0x918cfb90 (LWP 14994)]
[New Thread 0x928d1b90 (LWP 14934)]
[New Thread 0x930d2b90 (LWP 14909)]
[New Thread 0x938d3b90 (LWP 14890)]
[New Thread 0x940d4b90 (LWP 14883)]
[New Thread 0x950d6b90 (LWP 14843)]
[New Thread 0x958d7b90 (LWP 14824)]
[New Thread 0x960d8b90 (LWP 14795)]
[New Thread 0x968d9b90 (LWP 14784)]
[New Thread 0x970dab90 (LWP 14777)]
[New Thread 0x978dbb90 (LWP 14770)]
[New Thread 0x980dcb90 (LWP 14733)]
[New Thread 0x989deb90 (LWP 14726)]
[New Thread 0x991dfb90 (LWP 14719)]
[New Thread 0x999e0b90 (LWP 14704)]
[New Thread 0x9a1e1b90 (LWP 14688)]
[New Thread 0x9a9e2b90 (LWP 14680)]
[New Thread 0x9b1e3b90 (LWP 14673)]
[New Thread 0x9b9e4b90 (LWP 14666)]
[New Thread 0x9c1e5b90 (LWP 14651)]
[New Thread 0x9c9e6b90 (LWP 14632)]
[New Thread 0x9d2e8b90 (LWP 14624)]
[New Thread 0x9dae9b90 (LWP 14612)]
[New Thread 0x9e2eab90 (LWP 14601)]
[New Thread 0x9ebecb90 (LWP 14590)]
[New Thread 0x9fcefb90 (LWP 14576)]
[New Thread 0xa04f0b90 (LWP 14569)]
[New Thread 0xa0cf1b90 (LWP 14562)]
[New Thread 0xa14f2b90 (LWP 14555)]
[New Thread 0xa24f4b90 (LWP 14539)]
[New Thread 0xa2cf5b90 (LWP 14528)]
[New Thread 0xa34f6b90 (LWP 14513)]
[New Thread 0xa3df8b90 (LWP 14502)]
[New Thread 0xa4dfab90 (LWP 14483)]
[New Thread 0xa55fbb90 (LWP 14475)]
[New Thread 0xa5dfcb90 (LWP 14464)]
[New Thread 0xa66feb90 (LWP 14457)]
[New Thread 0xa7700b90 (LWP 14442)]
[New Thread 0xa7f01b90 (LWP 14435)]
[New Thread 0xa8702b90 (LWP 14428)]
[New Thread 0xa8f03b90 (LWP 14421)]
[New Thread 0xa9704b90 (LWP 14414)]
[New Thread 0xa9f05b90 (LWP 14406)]
[New Thread 0xaa706b90 (LWP 14399)]
[New Thread 0xaaf07b90 (LWP 14391)]
[New Thread 0xab809b90 (LWP 14384)]
[New Thread 0xac00ab90 (LWP 14369)]
[New Thread 0xac80bb90 (LWP 14362)]
[New Thread 0xad00cb90 (LWP 14355)]
[New Thread 0xad80db90 (LWP 14348)]
[New Thread 0xae00eb90 (LWP 14341)]
[New Thread 0xae80fb90 (LWP 14334)]
[New Thread 0xaf010b90 (LWP 14326)]
[New Thread 0xaf811b90 (LWP 14318)]
[New Thread 0xb0012b90 (LWP 14311)]
[New Thread 0xb0813b90 (LWP 14304)]
[New Thread 0xb1014b90 (LWP 14297)]
[New Thread 0xb1815b90 (LWP 14290)]
[New Thread 0xb2016b90 (LWP 14275)]
[New Thread 0xb2817b90 (LWP 14268)]
[New Thread 0xb3018b90 (LWP 14261)]
[New Thread 0xb3819b90 (LWP 14253)]
[New Thread 0xb401ab90 (LWP 14245)]
[New Thread 0xb481bb90 (LWP 14238)]
[New Thread 0xb501cb90 (LWP 14227)]
[New Thread 0xb581db90 (LWP 14220)]
[New Thread 0xb601eb90 (LWP 14213)]
[New Thread 0xb681fb90 (LWP 14206)]
[New Thread 0xb7020b90 (LWP 14198)]
[New Thread 0xb793bb90 (LWP 14171)]
[New Thread 0xb7b91b90 (LWP 14161)]
[New Thread 0xb7cceb90 (LWP 14158)]
[New Thread 0xb7e75b90 (LWP 14155)]
[New Thread 0xb7fe3b90 (LWP 14154)]
Loaded symbols for /lib/libpthread.so.0
Reading symbols from /lib/libdl.so.2...done.
Loaded symbols for /lib/libdl.so.2
Reading symbols from /lib/libc.so.6...done.
Loaded symbols for /lib/libc.so.6
Reading symbols from /lib/ld-linux.so.2...done.
Loaded symbols for /lib/ld-linux.so.2
Reading symbols from /usr/lib/libxml2.so...done.
Loaded symbols for /usr/lib/libxml2.so
Reading symbols from /lib/libz.so.1...done.
Loaded symbols for /lib/libz.so.1
Reading symbols from /lib/libm.so.6...done.
Loaded symbols for /lib/libm.so.6
Reading symbols from /usr/lib/autofs/lookup_file.so...done.
Loaded symbols for /usr/lib/autofs/lookup_file.so
Reading symbols from /lib/libnsl.so.1...done.
Loaded symbols for /lib/libnsl.so.1
Reading symbols from /usr/lib/autofs/parse_sun.so...done.
Loaded symbols for /usr/lib/autofs/parse_sun.so
Reading symbols from /usr/lib/autofs/mount_nfs.so...done.
Loaded symbols for /usr/lib/autofs/mount_nfs.so
Reading symbols from /usr/lib/autofs/mount_bind.so...done.
Loaded symbols for /usr/lib/autofs/mount_bind.so
Reading symbols from /usr/lib/autofs/lookup_yp.so...done.
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
Reading symbols from /usr/lib/autofs/mount_autofs.so...done.
Loaded symbols for /usr/lib/autofs/mount_autofs.so
0xffffe410 in __kernel_vsyscall ()
(gdb) (gdb) 
Thread 127 (Thread 0xb7fe3b90 (LWP 14154)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7fb77ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib/libpthread.so.0
#2  0x8001dedc in alarm_handler (arg=0x0) at alarm.c:204
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 126 (Thread 0xb7e75b90 (LWP 14155)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7fb77ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib/libpthread.so.0
#2  0x80017e99 in st_queue_handler (arg=0x0) at state.c:966
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 125 (Thread 0xb7cceb90 (LWP 14158)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8004e8a8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 124 (Thread 0xb7b91b90 (LWP 14161)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8004eec8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 123 (Thread 0xb793bb90 (LWP 14171)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800513b0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 122 (Thread 0xb7020b90 (LWP 14198)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800664f8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 121 (Thread 0xb681fb90 (LWP 14206)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80066e08) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 120 (Thread 0xb601eb90 (LWP 14213)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800677a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 119 (Thread 0xb581db90 (LWP 14220)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80068098) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 118 (Thread 0xb501cb90 (LWP 14227)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80068998) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 117 (Thread 0xb481bb90 (LWP 14238)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800692a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 116 (Thread 0xb401ab90 (LWP 14245)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80069c38) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 115 (Thread 0xb3819b90 (LWP 14253)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006a5b8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 114 (Thread 0xb3018b90 (LWP 14261)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006af30) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 113 (Thread 0xb2817b90 (LWP 14268)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006b820) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 112 (Thread 0xb2016b90 (LWP 14275)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006c120) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 111 (Thread 0xb1815b90 (LWP 14290)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006cca8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 110 (Thread 0xb1014b90 (LWP 14297)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006ca28) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 109 (Thread 0xb0813b90 (LWP 14304)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006dea8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 108 (Thread 0xb0012b90 (LWP 14311)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006e7b8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 107 (Thread 0xaf811b90 (LWP 14318)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006d498) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 106 (Thread 0xaf010b90 (LWP 14326)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006fa38) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 105 (Thread 0xae80fb90 (LWP 14334)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006f020) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 104 (Thread 0xae00eb90 (LWP 14341)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80070cb8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 103 (Thread 0xad80db90 (LWP 14348)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800715c0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 102 (Thread 0xad00cb90 (LWP 14355)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80070298) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 101 (Thread 0xac80bb90 (LWP 14362)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80072848) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 100 (Thread 0xac00ab90 (LWP 14369)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80073138) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 99 (Thread 0xab809b90 (LWP 14384)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80073c20) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 98 (Thread 0xaaf07b90 (LWP 14391)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80074610) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 97 (Thread 0xaa706b90 (LWP 14399)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80074f78) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 96 (Thread 0xa9f05b90 (LWP 14406)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80075880) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 95 (Thread 0xa9704b90 (LWP 14414)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80076158) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 94 (Thread 0xa8f03b90 (LWP 14421)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80076a88) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 93 (Thread 0xa8702b90 (LWP 14428)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80077380) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 92 (Thread 0xa7f01b90 (LWP 14435)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800739a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 91 (Thread 0xa7700b90 (LWP 14442)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80078638) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 90 (Thread 0xa66feb90 (LWP 14457)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80078f40) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 89 (Thread 0xa5dfcb90 (LWP 14464)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007a4e8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 88 (Thread 0xa55fbb90 (LWP 14475)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007a268) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 87 (Thread 0xa4dfab90 (LWP 14483)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007b6b0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 86 (Thread 0xa3df8b90 (LWP 14502)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007cb20) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 85 (Thread 0xa34f6b90 (LWP 14513)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007d568) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 84 (Thread 0xa2cf5b90 (LWP 14528)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007d2e8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 83 (Thread 0xa24f4b90 (LWP 14539)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007e780) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 82 (Thread 0xa14f2b90 (LWP 14555)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007f000) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 81 (Thread 0xa0cf1b90 (LWP 14562)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80080390) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 80 (Thread 0xa04f0b90 (LWP 14569)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80080e88) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 79 (Thread 0x9fcefb90 (LWP 14576)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800816e0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 78 (Thread 0x9ebecb90 (LWP 14590)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80080c98) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 77 (Thread 0x9e2eab90 (LWP 14601)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800836b8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 76 (Thread 0x9dae9b90 (LWP 14612)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80083ed0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 75 (Thread 0x9d2e8b90 (LWP 14624)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800834e0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 74 (Thread 0x9c9e6b90 (LWP 14632)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80085338) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 73 (Thread 0x9c1e5b90 (LWP 14651)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80085e90) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 72 (Thread 0x9b9e4b90 (LWP 14666)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80085c10) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 71 (Thread 0x9b1e3b90 (LWP 14673)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80087088) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 70 (Thread 0x9a9e2b90 (LWP 14680)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80087998) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 69 (Thread 0x9a1e1b90 (LWP 14688)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80086680) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 68 (Thread 0x999e0b90 (LWP 14704)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80088228) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 67 (Thread 0x991dfb90 (LWP 14719)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800897a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 66 (Thread 0x989deb90 (LWP 14726)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008a118) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 65 (Thread 0x980dcb90 (LWP 14733)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80089e98) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 64 (Thread 0x978dbb90 (LWP 14770)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008b4b0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 63 (Thread 0x970dab90 (LWP 14777)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008bca8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 62 (Thread 0x968d9b90 (LWP 14784)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008c5b0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 61 (Thread 0x960d8b90 (LWP 14795)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008d098) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 60 (Thread 0x958d7b90 (LWP 14824)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008da10) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 59 (Thread 0x950d6b90 (LWP 14843)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008e508) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 58 (Thread 0x940d4b90 (LWP 14883)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008f970) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 57 (Thread 0x938d3b90 (LWP 14890)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800902b8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 56 (Thread 0x930d2b90 (LWP 14909)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008f6f0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 55 (Thread 0x928d1b90 (LWP 14934)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800918a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 54 (Thread 0x918cfb90 (LWP 14994)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800921d0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 53 (Thread 0x910ceb90 (LWP 15001)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80093970) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 52 (Thread 0x908cdb90 (LWP 15020)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80094120) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 51 (Thread 0x8f8cbb90 (LWP 15052)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800956b0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 50 (Thread 0x8e8c9b90 (LWP 15070)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800969c0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 49 (Thread 0x8dfc7b90 (LWP 15085)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80097520) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 48 (Thread 0x8d7c6b90 (LWP 15093)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800972a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 47 (Thread 0x8cfc5b90 (LWP 15105)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80097dd8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 46 (Thread 0x8c7c4b90 (LWP 15120)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80099348) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 45 (Thread 0x8bec2b90 (LWP 15127)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80099c98) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 44 (Thread 0x8aec0b90 (LWP 15171)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009b218) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 43 (Thread 0x8a6bfb90 (LWP 15190)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009bcf8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 42 (Thread 0x89ebeb90 (LWP 15201)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009c500) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 41 (Thread 0x896bdb90 (LWP 15246)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009d120) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 40 (Thread 0x88ebcb90 (LWP 15275)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009db10) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 39 (Thread 0x87ebab90 (LWP 15293)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009efc0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 38 (Thread 0x876b9b90 (LWP 15313)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009f950) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 37 (Thread 0x86eb8b90 (LWP 15320)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a0160) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 36 (Thread 0x866b7b90 (LWP 15390)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a1070) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 35 (Thread 0x85eb6b90 (LWP 15418)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a0df0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 34 (Thread 0x855b4b90 (LWP 15426)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a2510) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 33 (Thread 0x84db3b90 (LWP 15441)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a3068) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 32 (Thread 0x845b2b90 (LWP 15473)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a3ba8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 31 (Thread 0x83bafb90 (LWP 15509)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a49f8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 30 (Thread 0x832adb90 (LWP 15516)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a5438) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 29 (Thread 0x82aacb90 (LWP 15569)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a6070) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 28 (Thread 0x822abb90 (LWP 15633)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a6f00) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 27 (Thread 0x812a9b90 (LWP 15693)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a85a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 26 (Thread 0x809a7b90 (LWP 15700)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a8fd0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 25 (Thread 0x7fdfdb90 (LWP 15795)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800aa278) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 24 (Thread 0x7f4fbb90 (LWP 15806)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800aabd8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 23 (Thread 0x7ecfab90 (LWP 15843)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800ab710) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 22 (Thread 0x7e4f9b90 (LWP 15854)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800ab400) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 21 (Thread 0x7dcf8b90 (LWP 15869)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800abfb8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 20 (Thread 0x7d4f7b90 (LWP 15902)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800ad528) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 19 (Thread 0x7ccf6b90 (LWP 16017)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800ae580) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 18 (Thread 0x7c4f5b90 (LWP 16038)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800af088) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 17 (Thread 0x7bcf4b90 (LWP 16049)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800af980) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 16 (Thread 0x7b4f3b90 (LWP 16068)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800aee98) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 15 (Thread 0x7acf2b90 (LWP 16117)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b0e78) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 14 (Thread 0x7a4f1b90 (LWP 16133)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b19e8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 13 (Thread 0x79befb90 (LWP 16165)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b26a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 12 (Thread 0x792edb90 (LWP 16189)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b32b8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 11 (Thread 0x789ebb90 (LWP 16217)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7fb6f42 in pthread_rwlock_wrlock () from /lib/libpthread.so.0
#2  0x800204d8 in master_source_writelock (entry=0x8004e808) at master.c:558
#3  0x8000a753 in handle_mounts (arg=0x800b3e80) at automount.c:1549
#4  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#5  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 10 (Thread 0x781eab90 (LWP 16258)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b4968) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 9 (Thread 0x779e9b90 (LWP 16277)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b5458) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 8 (Thread 0x770e7b90 (LWP 16330)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b62c0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 7 (Thread 0x767e5b90 (LWP 16337)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b6ce8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 6 (Thread 0x75fe4b90 (LWP 16446)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b7c20) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 5 (Thread 0x753dfb90 (LWP 19583)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7fb7566 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib/libpthread.so.0
#2  0x80021777 in master_notify_submount (ap=0x8004e8a8, 
    path=0x800c8078 "/net/nemo07", state=ST_EXPIRE) at master.c:920
#3  0x8000c84d in expire_proc_indirect (arg=0x800b7a20) at indirect.c:468
#4  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#5  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 4 (Thread 0x81aaab90 (LWP 21842)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a8170) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 3 (Thread 0x79cf0b90 (LWP 21980)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7fb9c1e in __lll_mutex_lock_wait () from /lib/libpthread.so.0
#2  0xb7fb5a58 in _L_mutex_lock_86 () from /lib/libpthread.so.0
#3  0xb7fb547d in pthread_mutex_lock () from /lib/libpthread.so.0
#4  0xb796271e in mount_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
    name=0x79ceeaa0 "testudo", name_len=7, what=0x79ceea70 "file", 
    fstype=0x79ceeac0 "autofs", 
    c_options=0x79ceeae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=testudo", context=0x18) at mount_autofs.c:217
#5  0x80013994 in do_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
    name=0x79ceeaa0 "testudo", name_len=7, what=0x79ceea70 "file", 
    fstype=0x79ceeac0 "autofs", 
    options=0x79ceeae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=testudo")
    at mount.c:73
#6  0xb7bb7aa3 in sun_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
    name=0x79ceee10 "testudo", namelen=7, 
    loc=0x80080180 "file:/etc/auto.net.generic", loclen=26, 
    options=0x79ceeae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=testudo", 
    ctxt=0x8003a600) at parse_sun.c:657
#7  0xb7bb891a in parse_mount (ap=0x8004e8a8, name=0x79ceee10 "testudo", 
    name_len=7, 
    mapent=0x79ceed80 "-rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=&\tfile:/etc/auto.net.generic", context=0x8003a600) at parse_sun.c:1458
#8  0xb7e4fe70 in lookup_mount (ap=0x8004e8a8, name=0x79cf01c8 "testudo", 
    name_len=7, context=0x8004e7f8) at lookup_file.c:1136
#9  0x8001452c in do_lookup_mount (ap=0x8004e8a8, map=0x8003a6e8, 
    name=0x79cf01c8 "testudo", name_len=7) at lookup.c:668
#10 0x800146ba in lookup_name_file_source_instance (ap=0x8004e8a8, 
    map=0x8004e9b0, name=0x79cf01c8 "testudo", name_len=7) at lookup.c:708
#11 0x80015289 in lookup_nss_mount (ap=0x8004e8a8, source=0x0, 
    name=0x79cf01c8 "testudo", name_len=7) at lookup.c:856
#12 0x8000be7a in do_mount_indirect (arg=0x80096370) at indirect.c:885
#13 0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#14 0xb7f3a02e in clone () from /lib/libc.so.6

Thread 2 (Thread 0xb713ab90 (LWP 22025)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7fb9c1e in __lll_mutex_lock_wait () from /lib/libpthread.so.0
#2  0xb7fb5a58 in _L_mutex_lock_86 () from /lib/libpthread.so.0
#3  0xb7fb547d in pthread_mutex_lock () from /lib/libpthread.so.0
#4  0xb796271e in mount_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
    name=0xb7138aa0 "vallejo", name_len=7, what=0xb7138a70 "file", 
    fstype=0xb7138ac0 "autofs", 
    c_options=0xb7138ae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=vallejo", context=0x18) at mount_autofs.c:217
#5  0x80013994 in do_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
    name=0xb7138aa0 "vallejo", name_len=7, what=0xb7138a70 "file", 
    fstype=0xb7138ac0 "autofs", 
    options=0xb7138ae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=vallejo")
    at mount.c:73
#6  0xb7bb7aa3 in sun_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
    name=0xb7138e10 "vallejo", namelen=7, 
    loc=0x80081610 "file:/etc/auto.net.generic", loclen=26, 
    options=0xb7138ae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=vallejo", 
    ctxt=0x8003a600) at parse_sun.c:657
#7  0xb7bb891a in parse_mount (ap=0x8004e8a8, name=0xb7138e10 "vallejo", 
    name_len=7, 
    mapent=0xb7138d80 "-rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=&\tfile:/etc/auto.net.generic", context=0x8003a600) at parse_sun.c:1458
#8  0xb7e4fe70 in lookup_mount (ap=0x8004e8a8, name=0xb713a1c8 "vallejo", 
    name_len=7, context=0x8004e7f8) at lookup_file.c:1136
#9  0x8001452c in do_lookup_mount (ap=0x8004e8a8, map=0x8003a6e8, 
    name=0xb713a1c8 "vallejo", name_len=7) at lookup.c:668
#10 0x800146ba in lookup_name_file_source_instance (ap=0x8004e8a8, 
    map=0x8004e9b0, name=0xb713a1c8 "vallejo", name_len=7) at lookup.c:708
#11 0x80015289 in lookup_nss_mount (ap=0x8004e8a8, source=0x0, 
    name=0xb713a1c8 "vallejo", name_len=7) at lookup.c:856
#12 0x8000be7a in do_mount_indirect (arg=0x80096370) at indirect.c:885
#13 0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#14 0xb7f3a02e in clone () from /lib/libc.so.6

Thread 1 (Thread 0xb7e766c0 (LWP 14153)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7fbb2aa in do_sigwait () from /lib/libpthread.so.0
#2  0xb7fbb34f in sigwait () from /lib/libpthread.so.0
#3  0x80008349 in main (argc=0, argv=0xbfe48998) at automount.c:1366
#0  0xffffe410 in __kernel_vsyscall ()
(gdb) Hangup detected on fd 0
error detected on stdin
The program is running.  Quit anyway (and detach it)? (y or n) [answered Y; input not from terminal]
Detaching from program: /usr/sbin/automount, process 14153
=----- end of backtrace -----

(--snip--)

12:01:42 /net/sumac/s1        hung
12:01:42 --                   #2925, chkd 2460, run 6, OK 240, mtd 243, of 247

=----- gdb backtrace of all threads -----
GNU gdb 6.6.50.20070726-cvs
Copyright (C) 2007 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i586-suse-linux"...
Using host libthread_db library "/lib/libthread_db.so.1".
Attaching to program: /usr/sbin/automount, process 14153
Loaded symbols for /usr/sbin/automount
Reading symbols from /lib/libpthread.so.0...done.
[Thread debugging using libthread_db enabled]
[New Thread 0xb7e766c0 (LWP 14153)]
[New Thread 0xb713ab90 (LWP 22025)]
[New Thread 0x79cf0b90 (LWP 21980)]
[New Thread 0x81aaab90 (LWP 21842)]
[New Thread 0x753dfb90 (LWP 19583)]
[New Thread 0x75fe4b90 (LWP 16446)]
[New Thread 0x767e5b90 (LWP 16337)]
[New Thread 0x770e7b90 (LWP 16330)]
[New Thread 0x779e9b90 (LWP 16277)]
[New Thread 0x781eab90 (LWP 16258)]
[New Thread 0x789ebb90 (LWP 16217)]
[New Thread 0x792edb90 (LWP 16189)]
[New Thread 0x79befb90 (LWP 16165)]
[New Thread 0x7a4f1b90 (LWP 16133)]
[New Thread 0x7acf2b90 (LWP 16117)]
[New Thread 0x7b4f3b90 (LWP 16068)]
[New Thread 0x7bcf4b90 (LWP 16049)]
[New Thread 0x7c4f5b90 (LWP 16038)]
[New Thread 0x7ccf6b90 (LWP 16017)]
[New Thread 0x7d4f7b90 (LWP 15902)]
[New Thread 0x7dcf8b90 (LWP 15869)]
[New Thread 0x7e4f9b90 (LWP 15854)]
[New Thread 0x7ecfab90 (LWP 15843)]
[New Thread 0x7f4fbb90 (LWP 15806)]
[New Thread 0x7fdfdb90 (LWP 15795)]
[New Thread 0x809a7b90 (LWP 15700)]
[New Thread 0x812a9b90 (LWP 15693)]
[New Thread 0x822abb90 (LWP 15633)]
[New Thread 0x82aacb90 (LWP 15569)]
[New Thread 0x832adb90 (LWP 15516)]
[New Thread 0x83bafb90 (LWP 15509)]
[New Thread 0x845b2b90 (LWP 15473)]
[New Thread 0x84db3b90 (LWP 15441)]
[New Thread 0x855b4b90 (LWP 15426)]
[New Thread 0x85eb6b90 (LWP 15418)]
[New Thread 0x866b7b90 (LWP 15390)]
[New Thread 0x86eb8b90 (LWP 15320)]
[New Thread 0x876b9b90 (LWP 15313)]
[New Thread 0x87ebab90 (LWP 15293)]
[New Thread 0x88ebcb90 (LWP 15275)]
[New Thread 0x896bdb90 (LWP 15246)]
[New Thread 0x89ebeb90 (LWP 15201)]
[New Thread 0x8a6bfb90 (LWP 15190)]
[New Thread 0x8aec0b90 (LWP 15171)]
[New Thread 0x8bec2b90 (LWP 15127)]
[New Thread 0x8c7c4b90 (LWP 15120)]
[New Thread 0x8cfc5b90 (LWP 15105)]
[New Thread 0x8d7c6b90 (LWP 15093)]
[New Thread 0x8dfc7b90 (LWP 15085)]
[New Thread 0x8e8c9b90 (LWP 15070)]
[New Thread 0x8f8cbb90 (LWP 15052)]
[New Thread 0x908cdb90 (LWP 15020)]
[New Thread 0x910ceb90 (LWP 15001)]
[New Thread 0x918cfb90 (LWP 14994)]
[New Thread 0x928d1b90 (LWP 14934)]
[New Thread 0x930d2b90 (LWP 14909)]
[New Thread 0x938d3b90 (LWP 14890)]
[New Thread 0x940d4b90 (LWP 14883)]
[New Thread 0x950d6b90 (LWP 14843)]
[New Thread 0x958d7b90 (LWP 14824)]
[New Thread 0x960d8b90 (LWP 14795)]
[New Thread 0x968d9b90 (LWP 14784)]
[New Thread 0x970dab90 (LWP 14777)]
[New Thread 0x978dbb90 (LWP 14770)]
[New Thread 0x980dcb90 (LWP 14733)]
[New Thread 0x989deb90 (LWP 14726)]
[New Thread 0x991dfb90 (LWP 14719)]
[New Thread 0x999e0b90 (LWP 14704)]
[New Thread 0x9a1e1b90 (LWP 14688)]
[New Thread 0x9a9e2b90 (LWP 14680)]
[New Thread 0x9b1e3b90 (LWP 14673)]
[New Thread 0x9b9e4b90 (LWP 14666)]
[New Thread 0x9c1e5b90 (LWP 14651)]
[New Thread 0x9c9e6b90 (LWP 14632)]
[New Thread 0x9d2e8b90 (LWP 14624)]
[New Thread 0x9dae9b90 (LWP 14612)]
[New Thread 0x9e2eab90 (LWP 14601)]
[New Thread 0x9ebecb90 (LWP 14590)]
[New Thread 0x9fcefb90 (LWP 14576)]
[New Thread 0xa04f0b90 (LWP 14569)]
[New Thread 0xa0cf1b90 (LWP 14562)]
[New Thread 0xa14f2b90 (LWP 14555)]
[New Thread 0xa24f4b90 (LWP 14539)]
[New Thread 0xa2cf5b90 (LWP 14528)]
[New Thread 0xa34f6b90 (LWP 14513)]
[New Thread 0xa3df8b90 (LWP 14502)]
[New Thread 0xa4dfab90 (LWP 14483)]
[New Thread 0xa55fbb90 (LWP 14475)]
[New Thread 0xa5dfcb90 (LWP 14464)]
[New Thread 0xa66feb90 (LWP 14457)]
[New Thread 0xa7700b90 (LWP 14442)]
[New Thread 0xa7f01b90 (LWP 14435)]
[New Thread 0xa8702b90 (LWP 14428)]
[New Thread 0xa8f03b90 (LWP 14421)]
[New Thread 0xa9704b90 (LWP 14414)]
[New Thread 0xa9f05b90 (LWP 14406)]
[New Thread 0xaa706b90 (LWP 14399)]
[New Thread 0xaaf07b90 (LWP 14391)]
[New Thread 0xab809b90 (LWP 14384)]
[New Thread 0xac00ab90 (LWP 14369)]
[New Thread 0xac80bb90 (LWP 14362)]
[New Thread 0xad00cb90 (LWP 14355)]
[New Thread 0xad80db90 (LWP 14348)]
[New Thread 0xae00eb90 (LWP 14341)]
[New Thread 0xae80fb90 (LWP 14334)]
[New Thread 0xaf010b90 (LWP 14326)]
[New Thread 0xaf811b90 (LWP 14318)]
[New Thread 0xb0012b90 (LWP 14311)]
[New Thread 0xb0813b90 (LWP 14304)]
[New Thread 0xb1014b90 (LWP 14297)]
[New Thread 0xb1815b90 (LWP 14290)]
[New Thread 0xb2016b90 (LWP 14275)]
[New Thread 0xb2817b90 (LWP 14268)]
[New Thread 0xb3018b90 (LWP 14261)]
[New Thread 0xb3819b90 (LWP 14253)]
[New Thread 0xb401ab90 (LWP 14245)]
[New Thread 0xb481bb90 (LWP 14238)]
[New Thread 0xb501cb90 (LWP 14227)]
[New Thread 0xb581db90 (LWP 14220)]
[New Thread 0xb601eb90 (LWP 14213)]
[New Thread 0xb681fb90 (LWP 14206)]
[New Thread 0xb7020b90 (LWP 14198)]
[New Thread 0xb793bb90 (LWP 14171)]
[New Thread 0xb7b91b90 (LWP 14161)]
[New Thread 0xb7cceb90 (LWP 14158)]
[New Thread 0xb7e75b90 (LWP 14155)]
[New Thread 0xb7fe3b90 (LWP 14154)]
Loaded symbols for /lib/libpthread.so.0
Reading symbols from /lib/libdl.so.2...done.
Loaded symbols for /lib/libdl.so.2
Reading symbols from /lib/libc.so.6...done.
Loaded symbols for /lib/libc.so.6
Reading symbols from /lib/ld-linux.so.2...done.
Loaded symbols for /lib/ld-linux.so.2
Reading symbols from /usr/lib/libxml2.so...done.
Loaded symbols for /usr/lib/libxml2.so
Reading symbols from /lib/libz.so.1...done.
Loaded symbols for /lib/libz.so.1
Reading symbols from /lib/libm.so.6...done.
Loaded symbols for /lib/libm.so.6
Reading symbols from /usr/lib/autofs/lookup_file.so...done.
Loaded symbols for /usr/lib/autofs/lookup_file.so
Reading symbols from /lib/libnsl.so.1...done.
Loaded symbols for /lib/libnsl.so.1
Reading symbols from /usr/lib/autofs/parse_sun.so...done.
Loaded symbols for /usr/lib/autofs/parse_sun.so
Reading symbols from /usr/lib/autofs/mount_nfs.so...done.
Loaded symbols for /usr/lib/autofs/mount_nfs.so
Reading symbols from /usr/lib/autofs/mount_bind.so...done.
Loaded symbols for /usr/lib/autofs/mount_bind.so
Reading symbols from /usr/lib/autofs/lookup_yp.so...done.
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
Reading symbols from /usr/lib/autofs/mount_autofs.so...done.
Loaded symbols for /usr/lib/autofs/mount_autofs.so
0xffffe410 in __kernel_vsyscall ()
(gdb) (gdb) 
Thread 127 (Thread 0xb7fe3b90 (LWP 14154)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7fb77ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib/libpthread.so.0
#2  0x8001dedc in alarm_handler (arg=0x0) at alarm.c:204
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 126 (Thread 0xb7e75b90 (LWP 14155)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7fb77ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib/libpthread.so.0
#2  0x80017e99 in st_queue_handler (arg=0x0) at state.c:966
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 125 (Thread 0xb7cceb90 (LWP 14158)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8004e8a8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 124 (Thread 0xb7b91b90 (LWP 14161)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8004eec8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 123 (Thread 0xb793bb90 (LWP 14171)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800513b0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 122 (Thread 0xb7020b90 (LWP 14198)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800664f8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 121 (Thread 0xb681fb90 (LWP 14206)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80066e08) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 120 (Thread 0xb601eb90 (LWP 14213)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800677a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 119 (Thread 0xb581db90 (LWP 14220)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80068098) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 118 (Thread 0xb501cb90 (LWP 14227)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80068998) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 117 (Thread 0xb481bb90 (LWP 14238)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800692a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 116 (Thread 0xb401ab90 (LWP 14245)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80069c38) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 115 (Thread 0xb3819b90 (LWP 14253)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006a5b8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 114 (Thread 0xb3018b90 (LWP 14261)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006af30) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 113 (Thread 0xb2817b90 (LWP 14268)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006b820) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 112 (Thread 0xb2016b90 (LWP 14275)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006c120) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 111 (Thread 0xb1815b90 (LWP 14290)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006cca8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 110 (Thread 0xb1014b90 (LWP 14297)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006ca28) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 109 (Thread 0xb0813b90 (LWP 14304)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006dea8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 108 (Thread 0xb0012b90 (LWP 14311)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006e7b8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 107 (Thread 0xaf811b90 (LWP 14318)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006d498) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 106 (Thread 0xaf010b90 (LWP 14326)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006fa38) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 105 (Thread 0xae80fb90 (LWP 14334)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006f020) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 104 (Thread 0xae00eb90 (LWP 14341)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80070cb8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 103 (Thread 0xad80db90 (LWP 14348)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800715c0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 102 (Thread 0xad00cb90 (LWP 14355)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80070298) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 101 (Thread 0xac80bb90 (LWP 14362)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80072848) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 100 (Thread 0xac00ab90 (LWP 14369)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80073138) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 99 (Thread 0xab809b90 (LWP 14384)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80073c20) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 98 (Thread 0xaaf07b90 (LWP 14391)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80074610) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 97 (Thread 0xaa706b90 (LWP 14399)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80074f78) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 96 (Thread 0xa9f05b90 (LWP 14406)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80075880) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 95 (Thread 0xa9704b90 (LWP 14414)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80076158) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 94 (Thread 0xa8f03b90 (LWP 14421)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80076a88) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 93 (Thread 0xa8702b90 (LWP 14428)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80077380) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 92 (Thread 0xa7f01b90 (LWP 14435)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800739a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 91 (Thread 0xa7700b90 (LWP 14442)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80078638) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 90 (Thread 0xa66feb90 (LWP 14457)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80078f40) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 89 (Thread 0xa5dfcb90 (LWP 14464)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007a4e8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 88 (Thread 0xa55fbb90 (LWP 14475)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007a268) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 87 (Thread 0xa4dfab90 (LWP 14483)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007b6b0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 86 (Thread 0xa3df8b90 (LWP 14502)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007cb20) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 85 (Thread 0xa34f6b90 (LWP 14513)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007d568) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 84 (Thread 0xa2cf5b90 (LWP 14528)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007d2e8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 83 (Thread 0xa24f4b90 (LWP 14539)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007e780) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 82 (Thread 0xa14f2b90 (LWP 14555)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007f000) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 81 (Thread 0xa0cf1b90 (LWP 14562)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80080390) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 80 (Thread 0xa04f0b90 (LWP 14569)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80080e88) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 79 (Thread 0x9fcefb90 (LWP 14576)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800816e0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 78 (Thread 0x9ebecb90 (LWP 14590)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80080c98) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 77 (Thread 0x9e2eab90 (LWP 14601)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800836b8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 76 (Thread 0x9dae9b90 (LWP 14612)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80083ed0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 75 (Thread 0x9d2e8b90 (LWP 14624)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800834e0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 74 (Thread 0x9c9e6b90 (LWP 14632)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80085338) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 73 (Thread 0x9c1e5b90 (LWP 14651)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80085e90) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 72 (Thread 0x9b9e4b90 (LWP 14666)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80085c10) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 71 (Thread 0x9b1e3b90 (LWP 14673)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80087088) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 70 (Thread 0x9a9e2b90 (LWP 14680)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80087998) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 69 (Thread 0x9a1e1b90 (LWP 14688)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80086680) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 68 (Thread 0x999e0b90 (LWP 14704)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80088228) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 67 (Thread 0x991dfb90 (LWP 14719)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800897a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 66 (Thread 0x989deb90 (LWP 14726)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008a118) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 65 (Thread 0x980dcb90 (LWP 14733)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80089e98) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 64 (Thread 0x978dbb90 (LWP 14770)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008b4b0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 63 (Thread 0x970dab90 (LWP 14777)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008bca8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 62 (Thread 0x968d9b90 (LWP 14784)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008c5b0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 61 (Thread 0x960d8b90 (LWP 14795)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008d098) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 60 (Thread 0x958d7b90 (LWP 14824)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008da10) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 59 (Thread 0x950d6b90 (LWP 14843)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008e508) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 58 (Thread 0x940d4b90 (LWP 14883)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008f970) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 57 (Thread 0x938d3b90 (LWP 14890)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800902b8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 56 (Thread 0x930d2b90 (LWP 14909)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008f6f0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 55 (Thread 0x928d1b90 (LWP 14934)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800918a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 54 (Thread 0x918cfb90 (LWP 14994)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800921d0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 53 (Thread 0x910ceb90 (LWP 15001)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80093970) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 52 (Thread 0x908cdb90 (LWP 15020)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80094120) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 51 (Thread 0x8f8cbb90 (LWP 15052)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800956b0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 50 (Thread 0x8e8c9b90 (LWP 15070)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800969c0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 49 (Thread 0x8dfc7b90 (LWP 15085)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80097520) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 48 (Thread 0x8d7c6b90 (LWP 15093)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800972a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 47 (Thread 0x8cfc5b90 (LWP 15105)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80097dd8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 46 (Thread 0x8c7c4b90 (LWP 15120)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80099348) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 45 (Thread 0x8bec2b90 (LWP 15127)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80099c98) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 44 (Thread 0x8aec0b90 (LWP 15171)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009b218) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 43 (Thread 0x8a6bfb90 (LWP 15190)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009bcf8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 42 (Thread 0x89ebeb90 (LWP 15201)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009c500) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 41 (Thread 0x896bdb90 (LWP 15246)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009d120) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 40 (Thread 0x88ebcb90 (LWP 15275)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009db10) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 39 (Thread 0x87ebab90 (LWP 15293)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009efc0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 38 (Thread 0x876b9b90 (LWP 15313)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009f950) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 37 (Thread 0x86eb8b90 (LWP 15320)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a0160) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 36 (Thread 0x866b7b90 (LWP 15390)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a1070) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 35 (Thread 0x85eb6b90 (LWP 15418)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a0df0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 34 (Thread 0x855b4b90 (LWP 15426)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a2510) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 33 (Thread 0x84db3b90 (LWP 15441)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a3068) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 32 (Thread 0x845b2b90 (LWP 15473)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a3ba8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 31 (Thread 0x83bafb90 (LWP 15509)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a49f8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 30 (Thread 0x832adb90 (LWP 15516)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a5438) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 29 (Thread 0x82aacb90 (LWP 15569)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a6070) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 28 (Thread 0x822abb90 (LWP 15633)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a6f00) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 27 (Thread 0x812a9b90 (LWP 15693)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a85a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 26 (Thread 0x809a7b90 (LWP 15700)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a8fd0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 25 (Thread 0x7fdfdb90 (LWP 15795)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800aa278) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 24 (Thread 0x7f4fbb90 (LWP 15806)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800aabd8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 23 (Thread 0x7ecfab90 (LWP 15843)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800ab710) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 22 (Thread 0x7e4f9b90 (LWP 15854)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800ab400) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 21 (Thread 0x7dcf8b90 (LWP 15869)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800abfb8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 20 (Thread 0x7d4f7b90 (LWP 15902)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800ad528) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 19 (Thread 0x7ccf6b90 (LWP 16017)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800ae580) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 18 (Thread 0x7c4f5b90 (LWP 16038)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800af088) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 17 (Thread 0x7bcf4b90 (LWP 16049)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800af980) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 16 (Thread 0x7b4f3b90 (LWP 16068)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800aee98) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 15 (Thread 0x7acf2b90 (LWP 16117)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b0e78) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 14 (Thread 0x7a4f1b90 (LWP 16133)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b19e8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 13 (Thread 0x79befb90 (LWP 16165)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b26a0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 12 (Thread 0x792edb90 (LWP 16189)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b32b8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 11 (Thread 0x789ebb90 (LWP 16217)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7fb6f42 in pthread_rwlock_wrlock () from /lib/libpthread.so.0
#2  0x800204d8 in master_source_writelock (entry=0x8004e808) at master.c:558
#3  0x8000a753 in handle_mounts (arg=0x800b3e80) at automount.c:1549
#4  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#5  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 10 (Thread 0x781eab90 (LWP 16258)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b4968) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 9 (Thread 0x779e9b90 (LWP 16277)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b5458) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 8 (Thread 0x770e7b90 (LWP 16330)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b62c0) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 7 (Thread 0x767e5b90 (LWP 16337)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b6ce8) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 6 (Thread 0x75fe4b90 (LWP 16446)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b7c20) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 5 (Thread 0x753dfb90 (LWP 19583)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7fb7566 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib/libpthread.so.0
#2  0x80021777 in master_notify_submount (ap=0x8004e8a8, 
    path=0x800c8078 "/net/nemo07", state=ST_EXPIRE) at master.c:920
#3  0x8000c84d in expire_proc_indirect (arg=0x800b7a20) at indirect.c:468
#4  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#5  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 4 (Thread 0x81aaab90 (LWP 21842)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f30817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a8170) at automount.c:909
#3  0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#4  0xb7f3a02e in clone () from /lib/libc.so.6

Thread 3 (Thread 0x79cf0b90 (LWP 21980)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7fb9c1e in __lll_mutex_lock_wait () from /lib/libpthread.so.0
#2  0xb7fb5a58 in _L_mutex_lock_86 () from /lib/libpthread.so.0
#3  0xb7fb547d in pthread_mutex_lock () from /lib/libpthread.so.0
#4  0xb796271e in mount_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
    name=0x79ceeaa0 "testudo", name_len=7, what=0x79ceea70 "file", 
    fstype=0x79ceeac0 "autofs", 
    c_options=0x79ceeae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=testudo", context=0x18) at mount_autofs.c:217
#5  0x80013994 in do_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
    name=0x79ceeaa0 "testudo", name_len=7, what=0x79ceea70 "file", 
    fstype=0x79ceeac0 "autofs", 
    options=0x79ceeae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=testudo")
    at mount.c:73
#6  0xb7bb7aa3 in sun_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
    name=0x79ceee10 "testudo", namelen=7, 
    loc=0x80080180 "file:/etc/auto.net.generic", loclen=26, 
    options=0x79ceeae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=testudo", 
    ctxt=0x8003a600) at parse_sun.c:657
#7  0xb7bb891a in parse_mount (ap=0x8004e8a8, name=0x79ceee10 "testudo", 
    name_len=7, 
    mapent=0x79ceed80 "-rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=&\tfile:/etc/auto.net.generic", context=0x8003a600) at parse_sun.c:1458
#8  0xb7e4fe70 in lookup_mount (ap=0x8004e8a8, name=0x79cf01c8 "testudo", 
    name_len=7, context=0x8004e7f8) at lookup_file.c:1136
#9  0x8001452c in do_lookup_mount (ap=0x8004e8a8, map=0x8003a6e8, 
    name=0x79cf01c8 "testudo", name_len=7) at lookup.c:668
#10 0x800146ba in lookup_name_file_source_instance (ap=0x8004e8a8, 
    map=0x8004e9b0, name=0x79cf01c8 "testudo", name_len=7) at lookup.c:708
#11 0x80015289 in lookup_nss_mount (ap=0x8004e8a8, source=0x0, 
    name=0x79cf01c8 "testudo", name_len=7) at lookup.c:856
#12 0x8000be7a in do_mount_indirect (arg=0x80096370) at indirect.c:885
#13 0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#14 0xb7f3a02e in clone () from /lib/libc.so.6

Thread 2 (Thread 0xb713ab90 (LWP 22025)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7fb9c1e in __lll_mutex_lock_wait () from /lib/libpthread.so.0
#2  0xb7fb5a58 in _L_mutex_lock_86 () from /lib/libpthread.so.0
#3  0xb7fb547d in pthread_mutex_lock () from /lib/libpthread.so.0
#4  0xb796271e in mount_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
    name=0xb7138aa0 "vallejo", name_len=7, what=0xb7138a70 "file", 
    fstype=0xb7138ac0 "autofs", 
    c_options=0xb7138ae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=vallejo", context=0x18) at mount_autofs.c:217
#5  0x80013994 in do_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
    name=0xb7138aa0 "vallejo", name_len=7, what=0xb7138a70 "file", 
    fstype=0xb7138ac0 "autofs", 
    options=0xb7138ae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=vallejo")
    at mount.c:73
#6  0xb7bb7aa3 in sun_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
    name=0xb7138e10 "vallejo", namelen=7, 
    loc=0x80081610 "file:/etc/auto.net.generic", loclen=26, 
    options=0xb7138ae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=vallejo", 
    ctxt=0x8003a600) at parse_sun.c:657
#7  0xb7bb891a in parse_mount (ap=0x8004e8a8, name=0xb7138e10 "vallejo", 
    name_len=7, 
    mapent=0xb7138d80 "-rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=&\tfile:/etc/auto.net.generic", context=0x8003a600) at parse_sun.c:1458
#8  0xb7e4fe70 in lookup_mount (ap=0x8004e8a8, name=0xb713a1c8 "vallejo", 
    name_len=7, context=0x8004e7f8) at lookup_file.c:1136
#9  0x8001452c in do_lookup_mount (ap=0x8004e8a8, map=0x8003a6e8, 
    name=0xb713a1c8 "vallejo", name_len=7) at lookup.c:668
#10 0x800146ba in lookup_name_file_source_instance (ap=0x8004e8a8, 
    map=0x8004e9b0, name=0xb713a1c8 "vallejo", name_len=7) at lookup.c:708
#11 0x80015289 in lookup_nss_mount (ap=0x8004e8a8, source=0x0, 
    name=0xb713a1c8 "vallejo", name_len=7) at lookup.c:856
#12 0x8000be7a in do_mount_indirect (arg=0x80096370) at indirect.c:885
#13 0xb7fb3192 in start_thread () from /lib/libpthread.so.0
#14 0xb7f3a02e in clone () from /lib/libc.so.6

Thread 1 (Thread 0xb7e766c0 (LWP 14153)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7fbb2aa in do_sigwait () from /lib/libpthread.so.0
#2  0xb7fbb34f in sigwait () from /lib/libpthread.so.0
#3  0x80008349 in main (argc=0, argv=0xbfe48998) at automount.c:1366
#0  0xffffe410 in __kernel_vsyscall ()
(gdb) Hangup detected on fd 0
error detected on stdin
The program is running.  Quit anyway (and detach it)? (y or n) [answered Y; input not from terminal]
Detaching from program: /usr/sbin/automount, process 14153
=----- end of backtrace -----

(--snip--)
13:20:18 /net/nemo02/m1       still mounted after 900 secs, state = success
13:20:18 --                   #5048, chkd 3700, run 4, OK 242, mtd 243, of 247

13:20:48 /net/tempestsuse/m1  still mounted after 900 secs, state = success
(--test stopped--)
