From: jimc@math.ucla.edu (Jim Carter)
Subject: Re: clients suddenly start hanging (was: (no subject))
Date: Sat, 10 May 2008 21:14:55 -0700 (PDT)
Message-ID: <20080511041455.21CB02111B1@simba.math.ucla.edu>
References: <20080423185018.122C53C3B1@xena.cft.ca.us>
	<1210227208.1392.51.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1210227208.1392.51.camel@raven.themaw.net>
	(Ian Kent "Mon, 28 Apr 2008 14:26:34 +0800")
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

On Thu, 08 May 2008 14:13:28 +0800 Ian Kent wrote:

> But the patch that may make a real difference for your case is for the
> daemon and hasn't been merged yet because were still testing it. I would
> have posted it for you to test but I though we were still undecided as
> to whether you wanted me to attempt a back port to an older SuSE code
> base or you were happy to use the latest source.

> Anyway, here it is, against the latest source, for you to test.

We need the eventual patch, and I think it's probably going to work out
best if we use a consistent code base, i.e. 5.0.3.  When SuSE eventually 
catches up, then we'll stop using our private build of autofs.

I obtained 
http://download.opensuse.org/repositories/home:/makoenig/openSUSE_10.3/src/autofs-5.0.3-6.1.src.rpm
and successfully applied the patch to it (I'm provisionally calling
the patch "submount-A").  Unlike in my previous attempt I could not 
preserve the symbol table in the RPM file although symbols were present
in the compiled exe and *.so, so I installed those manually (and the
debuginfo package in the normal way).  

Without the submount-A patch in my previous test run (but with the 2
kernel patches) I had 3 hung client processes in 2.0 hours, and 60
"failed" tests.  "Failed" means that the test thread gets ENOENT when
opening the target directory, but if the directory is left alone for 900
seconds, it often behaves normally after that -- 49 of 60 directories
revived and the rest might have if the test had run longer.  Expiration
was hit-or-miss: frequently filesystems stayed mounted for over 900 secs
(but eventually got expired) even though the expiry time is at the
default of 300 secs.  (This result is similar to what I see without the
2 kernel patches.)

First the good news: with the patch there were no "failed" tests at all
in 4.5 hours of testing.  Now the bad news: although the rate of hung
client processes was reduced by 1:3, to 2 hung processes in 4.5 hours,
they're still hanging.  

As a clue, I analysed some of the expiration issues in detail.  At one
point 1/2 hour after starting the test, almost all of the 238
filesystems had expired and been remounted at least once, but at that
point the program detected that all but 12 of them had stayed mounted
for at least 900 secs.  Looking through time at particular machines
(submounts), two of them had two filesystems each, one of which expired
and remounted normally through the whole test, and one didn't expire
when the rest didn't expire.  Another machine that exports 6 filesystems
had all of them expire properly, or not expire, in synchrony except one
filesystem missed expiration one extra time when the others did expire. 
There were three intervals of non-expiration shared by (almost?) all 
filesystems, lasting about 1/2 hour (2 cases) or 1 hour (once).  
My conclusion on this is that there is a common cause that omits
expiration on almost every filesystem but which self-heals eventually.

See below for one backtrace immediately after the second hung process
was recognized (25 secs after it started).

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 520 Portola Plaza; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)

=----- gdb backtrace of all threads -----
GNU gdb 6.6.50.20070726-cvs
Copyright (C) 2007 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i586-suse-linux"...
Using host libthread_db library "/lib/libthread_db.so.1".
Attaching to program: /usr/sbin/automount, process 6115
Loaded symbols for /usr/sbin/automount
Reading symbols from /lib/libpthread.so.0...done.
[Thread debugging using libthread_db enabled]
[New Thread 0xb7e2d6c0 (LWP 6115)]
[New Thread 0xab6bfb90 (LWP 1596)]
[New Thread 0xa6eb6b90 (LWP 1528)]
[New Thread 0xa0ba7b90 (LWP 1357)]
[New Thread 0x7dffbb90 (LWP 1293)]
[New Thread 0x8eb7cb90 (LWP 1254)]
[New Thread 0x82760b90 (LWP 983)]
[New Thread 0xb17ccb90 (LWP 562)]
[New Thread 0x790ebb90 (LWP 32766)]
[New Thread 0xafec8b90 (LWP 32470)]
[New Thread 0xb67d6b90 (LWP 32396)]
[New Thread 0xaf6c7b90 (LWP 32314)]
[New Thread 0x91583b90 (LWP 32265)]
[New Thread 0x8bb76b90 (LWP 32247)]
[New Thread 0x99795b90 (LWP 32232)]
[New Thread 0xb2fcfb90 (LWP 32168)]
[New Thread 0x92686b90 (LWP 32150)]
[New Thread 0x9f3a4b90 (LWP 31993)]
[New Thread 0xb1fcdb90 (LWP 31457)]
[New Thread 0x8cb78b90 (LWP 31417)]
[New Thread 0x83863b90 (LWP 31397)]
[New Thread 0x9478bb90 (LWP 31337)]
[New Thread 0x7bef6b90 (LWP 31327)]
[New Thread 0x7c7f8b90 (LWP 31321)]
[New Thread 0x8726cb90 (LWP 31315)]
[New Thread 0xa13a8b90 (LWP 31293)]
[New Thread 0x8a373b90 (LWP 31279)]
[New Thread 0x84865b90 (LWP 30634)]
[New Thread 0xa4db1b90 (LWP 30357)]
[New Thread 0x8836fb90 (LWP 30263)]
[New Thread 0x7b5f4b90 (LWP 30113)]
[New Thread 0x8d379b90 (LWP 28917)]
[New Thread 0xb78f2b90 (LWP 28799)]
[New Thread 0x99f96b90 (LWP 28760)]
[New Thread 0xb37d0b90 (LWP 28724)]
[New Thread 0x93789b90 (LWP 28714)]
[New Thread 0xa24abb90 (LWP 28694)]
[New Thread 0xaeec6b90 (LWP 28684)]
[New Thread 0xa1caab90 (LWP 28244)]
[New Thread 0xa35aeb90 (LWP 27989)]
[New Thread 0xa66b5b90 (LWP 27973)]
[New Thread 0xa7eb8b90 (LWP 27963)]
[New Thread 0xa8ebab90 (LWP 27957)]
[New Thread 0xa9ebcb90 (LWP 27951)]
[New Thread 0xaa6bdb90 (LWP 27944)]
[New Thread 0x93f8ab90 (LWP 27504)]
[New Thread 0x7adf3b90 (LWP 26729)]
[New Thread 0x9fba5b90 (LWP 26670)]
[New Thread 0x83062b90 (LWP 26495)]
[New Thread 0x89371b90 (LWP 26237)]
[New Thread 0xa86b9b90 (LWP 26103)]
[New Thread 0x9578db90 (LWP 25163)]
[New Thread 0x98f94b90 (LWP 25155)]
[New Thread 0xa2cacb90 (LWP 25149)]
[New Thread 0xac6c1b90 (LWP 25139)]
[New Thread 0xa45b0b90 (LWP 25128)]
[New Thread 0xa03a6b90 (LWP 25118)]
[New Thread 0xad6c3b90 (LWP 25093)]
[New Thread 0x90581b90 (LWP 25087)]
[New Thread 0xa3dafb90 (LWP 24927)]
[New Thread 0xa5db3b90 (LWP 24908)]
[New Thread 0x9d89eb90 (LWP 24032)]
[New Thread 0x9e3a2b90 (LWP 23980)]
[New Thread 0x9eba3b90 (LWP 23974)]
[New Thread 0x9c79bb90 (LWP 23958)]
[New Thread 0x8c377b90 (LWP 23917)]
[New Thread 0x8fc7fb90 (LWP 23911)]
[New Thread 0x97791b90 (LWP 23905)]
[New Thread 0x9bf9ab90 (LWP 23894)]
[New Thread 0x7f7feb90 (LWP 22938)]
[New Thread 0xb57d4b90 (LWP 22482)]
[New Thread 0x96f90b90 (LWP 21036)]
[New Thread 0x7a5f2b90 (LWP 20955)]
[New Thread 0xb0fcbb90 (LWP 19727)]
[New Thread 0x8626ab90 (LWP 19004)]
[New Thread 0x9b799b90 (LWP 18561)]
[New Thread 0x8e37bb90 (LWP 17999)]
[New Thread 0xa76b7b90 (LWP 17284)]
[New Thread 0x94f8cb90 (LWP 17132)]
[New Thread 0x9a797b90 (LWP 17051)]
[New Thread 0xabec0b90 (LWP 15359)]
[New Thread 0xacec2b90 (LWP 12965)]
[New Thread 0x8145bb90 (LWP 12890)]
[New Thread 0xa96bbb90 (LWP 12739)]
[New Thread 0x9cf9cb90 (LWP 12433)]
[New Thread 0xa55b2b90 (LWP 11126)]
[New Thread 0x97f92b90 (LWP 9290)]
[New Thread 0x95f8eb90 (LWP 6501)]
[New Thread 0x9678fb90 (LWP 3377)]
[New Thread 0xb6fd7b90 (LWP 2542)]
[New Thread 0xb4fd3b90 (LWP 28608)]
[New Thread 0x80c5ab90 (LWP 28450)]
[New Thread 0x7cff9b90 (LWP 28374)]
[New Thread 0x8ab74b90 (LWP 23528)]
[New Thread 0x7ffffb90 (LWP 23429)]
[New Thread 0x81c5cb90 (LWP 23417)]
[New Thread 0x87b6eb90 (LWP 23396)]
[New Thread 0xb47d2b90 (LWP 21309)]
[New Thread 0xb3fd1b90 (LWP 21235)]
[New Thread 0xadec4b90 (LWP 21221)]
[New Thread 0xae6c5b90 (LWP 21215)]
[New Thread 0xb07cab90 (LWP 21209)]
[New Thread 0xb27ceb90 (LWP 21198)]
[New Thread 0x85167b90 (LWP 18712)]
[New Thread 0x9af98b90 (LWP 17784)]
[New Thread 0x91d84b90 (LWP 17642)]
[New Thread 0x98793b90 (LWP 12058)]
[New Thread 0xaaebeb90 (LWP 6416)]
[New Thread 0xb7b48b90 (LWP 6123)]
[New Thread 0xb7c85b90 (LWP 6120)]
[New Thread 0xb7e2cb90 (LWP 6117)]
[New Thread 0xb7f9ab90 (LWP 6116)]
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
0xffffe410 in __kernel_vsyscall ()
(gdb) (gdb) 
Thread 112 (Thread 0xb7f9ab90 (LWP 6116)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f6e7ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib/libpthread.so.0
#2  0x8001dfcc in alarm_handler (arg=0x0) at alarm.c:204
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 111 (Thread 0xb7e2cb90 (LWP 6117)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f6e7ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib/libpthread.so.0
#2  0x80017f89 in st_queue_handler (arg=0x0) at state.c:966
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 110 (Thread 0xb7c85b90 (LWP 6120)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8004e8a8) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 109 (Thread 0xb7b48b90 (LWP 6123)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8004eeb0) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 108 (Thread 0xaaebeb90 (LWP 6416)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800744f0) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 107 (Thread 0x98793b90 (LWP 12058)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f6e566 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib/libpthread.so.0
#2  0x8000b6c2 in handle_packet_missing_indirect (ap=0x80082dc0, 
    pkt=0x987931a4) at indirect.c:966
#3  0x8000aa63 in handle_mounts (arg=0x80082dc0) at automount.c:1086
#4  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#5  0xb7ef102e in clone () from /lib/libc.so.6

Thread 106 (Thread 0x91d84b90 (LWP 17642)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80093080) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 105 (Thread 0x9af98b90 (LWP 17784)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800876f0) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 104 (Thread 0x85167b90 (LWP 18712)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008fe10) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 103 (Thread 0xb27ceb90 (LWP 21198)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006ffe0) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 102 (Thread 0xb07cab90 (LWP 21209)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80074168) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 101 (Thread 0xae6c5b90 (LWP 21215)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800710b0) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 100 (Thread 0xadec4b90 (LWP 21221)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006e540) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 99 (Thread 0xb3fd1b90 (LWP 21235)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007aa50) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 98 (Thread 0xb47d2b90 (LWP 21309)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80069c40) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 97 (Thread 0x87b6eb90 (LWP 23396)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b98c0) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 96 (Thread 0x81c5cb90 (LWP 23417)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a4c58) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 95 (Thread 0x7ffffb90 (LWP 23429)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800bf078) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 94 (Thread 0x8ab74b90 (LWP 23528)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a4ab8) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 93 (Thread 0x7cff9b90 (LWP 28374)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007bb58) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 92 (Thread 0x80c5ab90 (LWP 28450)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b5cb8) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 91 (Thread 0xb4fd3b90 (LWP 28608)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80098908) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 90 (Thread 0xb6fd7b90 (LWP 2542)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80072d80) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 89 (Thread 0x9678fb90 (LWP 3377)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80099808) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 88 (Thread 0x95f8eb90 (LWP 6501)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80099390) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 87 (Thread 0x97f92b90 (LWP 9290)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008bc48) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 86 (Thread 0xa55b2b90 (LWP 11126)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a6b78) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 85 (Thread 0x9cf9cb90 (LWP 12433)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007cbb0) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 84 (Thread 0xa96bbb90 (LWP 12739)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80075fa0) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 83 (Thread 0x8145bb90 (LWP 12890)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800bab70) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 82 (Thread 0xacec2b90 (LWP 12965)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006a860) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 81 (Thread 0xabec0b90 (LWP 15359)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80094900) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 80 (Thread 0x9a797b90 (LWP 17051)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009c348) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 79 (Thread 0x94f8cb90 (LWP 17132)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a42f0) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 78 (Thread 0xa76b7b90 (LWP 17284)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800789e0) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 77 (Thread 0x8e37bb90 (LWP 17999)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009b020) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 76 (Thread 0x9b799b90 (LWP 18561)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80082aa8) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 75 (Thread 0x8626ab90 (LWP 19004)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800974a0) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 74 (Thread 0xb0fcbb90 (LWP 19727)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80091060) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 73 (Thread 0x7a5f2b90 (LWP 20955)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80081f28) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 72 (Thread 0x96f90b90 (LWP 21036)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80087018) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 71 (Thread 0xb57d4b90 (LWP 22482)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800676e8) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 70 (Thread 0x7f7feb90 (LWP 22938)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80082570) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 69 (Thread 0x9bf9ab90 (LWP 23894)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008cd68) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 68 (Thread 0x97791b90 (LWP 23905)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009ee70) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 67 (Thread 0x8fc7fb90 (LWP 23911)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800962f8) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 66 (Thread 0x8c377b90 (LWP 23917)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008baf8) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 65 (Thread 0x9c79bb90 (LWP 23958)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80086ca0) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 64 (Thread 0x9eba3b90 (LWP 23974)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009a460) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 63 (Thread 0x9e3a2b90 (LWP 23980)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008b8f8) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 62 (Thread 0x9d89eb90 (LWP 24032)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009ebc8) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 61 (Thread 0xa5db3b90 (LWP 24908)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800719a0) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 60 (Thread 0xa3dafb90 (LWP 24927)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009d1c8) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 59 (Thread 0x90581b90 (LWP 25087)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008f238) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 58 (Thread 0xad6c3b90 (LWP 25093)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80089c48) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 57 (Thread 0xa03a6b90 (LWP 25118)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006ab30) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 56 (Thread 0xa45b0b90 (LWP 25128)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008a1b0) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 55 (Thread 0xac6c1b90 (LWP 25139)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80098ad0) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 54 (Thread 0xa2cacb90 (LWP 25149)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a56d8) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 53 (Thread 0x98f94b90 (LWP 25155)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800517e0) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 52 (Thread 0x9578db90 (LWP 25163)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80072c48) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 51 (Thread 0xa86b9b90 (LWP 26103)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a5c30) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 50 (Thread 0x89371b90 (LWP 26237)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80080740) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 49 (Thread 0x83062b90 (LWP 26495)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800c2ea8) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 48 (Thread 0x9fba5b90 (LWP 26670)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a9830) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 47 (Thread 0x7adf3b90 (LWP 26729)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800aa098) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 46 (Thread 0x93f8ab90 (LWP 27504)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80093498) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 45 (Thread 0xaa6bdb90 (LWP 27944)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80094818) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 44 (Thread 0xa9ebcb90 (LWP 27951)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007dac0) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 43 (Thread 0xa8ebab90 (LWP 27957)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80079f08) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 42 (Thread 0xa7eb8b90 (LWP 27963)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80076e88) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 41 (Thread 0xa66b5b90 (LWP 27973)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800753b8) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 40 (Thread 0xa35aeb90 (LWP 27989)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80077c58) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 39 (Thread 0xa1caab90 (LWP 28244)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80087d88) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 38 (Thread 0xaeec6b90 (LWP 28684)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006a9f8) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 37 (Thread 0xa24abb90 (LWP 28694)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008a338) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 36 (Thread 0x93789b90 (LWP 28714)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006b1c8) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 35 (Thread 0xb37d0b90 (LWP 28724)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80079b30) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 34 (Thread 0x99f96b90 (LWP 28760)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80079d20) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 33 (Thread 0xb78f2b90 (LWP 28799)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800668c0) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 32 (Thread 0x8d379b90 (LWP 28917)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80090978) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 31 (Thread 0x7b5f4b90 (LWP 30113)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800ab008) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 30 (Thread 0x8836fb90 (LWP 30263)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800bfd40) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 29 (Thread 0xa4db1b90 (LWP 30357)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a75a8) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 28 (Thread 0x84865b90 (LWP 30634)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800bafa0) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 27 (Thread 0x8a373b90 (LWP 31279)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800c1128) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 26 (Thread 0xa13a8b90 (LWP 31293)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80084f58) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 25 (Thread 0x8726cb90 (LWP 31315)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800bda08) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 24 (Thread 0x7c7f8b90 (LWP 31321)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800802c8) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 23 (Thread 0x7bef6b90 (LWP 31327)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80084d08) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 22 (Thread 0x9478bb90 (LWP 31337)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009b758) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 21 (Thread 0x83863b90 (LWP 31397)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006d328) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 20 (Thread 0x8cb78b90 (LWP 31417)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008f918) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 19 (Thread 0xb1fcdb90 (LWP 31457)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a11b0) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 18 (Thread 0x9f3a4b90 (LWP 31993)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009d5a8) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 17 (Thread 0x92686b90 (LWP 32150)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80097158) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 16 (Thread 0xb2fcfb90 (LWP 32168)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008b208) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 15 (Thread 0x99795b90 (LWP 32232)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b6810) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 14 (Thread 0x8bb76b90 (LWP 32247)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007f228) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 13 (Thread 0x91583b90 (LWP 32265)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006dc90) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 12 (Thread 0xaf6c7b90 (LWP 32314)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80095408) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 11 (Thread 0xb67d6b90 (LWP 32396)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007a900) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 10 (Thread 0xafec8b90 (LWP 32470)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800680f8) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 9 (Thread 0x790ebb90 (LWP 32766)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f6e566 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib/libpthread.so.0
#2  0x80021545 in master_notify_submount (ap=0x8004e8a8, 
    path=0x80086570 "/net/bamboo45", state=ST_EXPIRE) at master.c:894
#3  0x8000c97d in expire_proc_indirect (arg=0x8004fc70) at indirect.c:468
#4  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#5  0xb7ef102e in clone () from /lib/libc.so.6

Thread 8 (Thread 0xb17ccb90 (LWP 562)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80082438) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 7 (Thread 0x82760b90 (LWP 983)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800aa830) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 6 (Thread 0x8eb7cb90 (LWP 1254)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008f7e0) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 5 (Thread 0x7dffbb90 (LWP 1293)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800bbc18) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 4 (Thread 0xa0ba7b90 (LWP 1357)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006a538) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 3 (Thread 0xa6eb6b90 (LWP 1528)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80083ae8) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 2 (Thread 0xab6bfb90 (LWP 1596)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ee7817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b9780) at automount.c:909
#3  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ef102e in clone () from /lib/libc.so.6

Thread 1 (Thread 0xb7e2d6c0 (LWP 6115)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f722aa in do_sigwait () from /lib/libpthread.so.0
#2  0xb7f7234f in sigwait () from /lib/libpthread.so.0
#3  0x80008349 in main (argc=0, argv=0xbfcea838) at automount.c:1366
#0  0xffffe410 in __kernel_vsyscall ()
(gdb) Hangup detected on fd 0
error detected on stdin
The program is running.  Quit anyway (and detach it)? (y or n) [answered Y; input not from terminal]
Detaching from program: /usr/sbin/automount, process 6115
=----- end of backtrace -----
