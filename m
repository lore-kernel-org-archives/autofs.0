From: jimc@math.ucla.edu (Jim Carter)
Subject: Re: clients suddenly start hanging (was: (no subject))
Date: Thu, 22 May 2008 14:42:33 -0700 (PDT)
Message-ID: <20080522214233.7F5D4211250@simba.math.ucla.edu>
References: <20080423185018.122C53C3B1@xena.cft.ca.us>
	<1211083674.3118.5.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1211083674.3118.5.camel@raven.themaw.net>
	(Ian Kent "Sun, 11 May 2008 15:57:07 +0800")
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

Sorry for the delay -- we have a crisis with KDE menus disappearing :-(
Anyway: the new patch did not stop the hanging, unfortunately.  Again 
upon the first hang gdb was not able to print out the individual thread
tracebacks, but the second time around, it succeeded.  But strangely,
the hung daemon thread from the first hang is easily identified, but
strings pertaining to the second hang are not evident.

I'm calling the patch "take-submount-lock".  

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 520 Portola Plaza; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)

11:04:58 --                   #1, chkd 0, run 0, OK 576, mtd 3, of 576

11:07:22 --                   #2, chkd 573, run 6, OK 245, mtd 245, of 245

11:07:47 --                   #3, chkd 573, run 0, OK 245, mtd 245, of 245
(--snip--)
11:36:36 /net/stockton/m1     hung
11:36:36 --                   #716, chkd 1086, run 1, OK 244, mtd 239, of 245

=----- gdb backtrace of all threads -----
GNU gdb 6.6.50.20070726-cvs
Copyright (C) 2007 Free Software Foundation, Inc.
(--snip--)
Reading symbols from /usr/lib/autofs/mount_autofs.so...done.
Loaded symbols for /usr/lib/autofs/mount_autofs.so
0xffffe410 in __kernel_vsyscall ()
(gdb) Hangup detected on fd 0
error detected on stdin
The program is running.  Quit anyway (and detach it)? (y or n) [answered Y; input not from terminal]
Detaching from program: /usr/sbin/automount, process 24023
=----- end of backtrace -----
11:36:37 /net/arachne/m1      still mounted after 900 secs, state = success
11:37:03 /net/mukilteo/m1     hung
11:37:03 --                   #717, chkd 1092, run 2, OK 243, mtd 243, of 245

=----- gdb backtrace of all threads -----
GNU gdb 6.6.50.20070726-cvs
Copyright (C) 2007 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i586-suse-linux"...
Using host libthread_db library "/lib/libthread_db.so.1".
Attaching to program: /usr/sbin/automount, process 24023
Loaded symbols for /usr/sbin/automount
Reading symbols from /lib/libpthread.so.0...done.
[Thread debugging using libthread_db enabled]
[New Thread 0xb7e0a6c0 (LWP 24023)]
[New Thread 0xb70ceb90 (LWP 31294)]
[New Thread 0x74cdfb90 (LWP 30468)]
[New Thread 0x74addb90 (LWP 27049)]
[New Thread 0x75ae6b90 (LWP 26410)]
[New Thread 0x763e8b90 (LWP 26307)]
[New Thread 0x76be9b90 (LWP 26301)]
[New Thread 0x773eab90 (LWP 26251)]
[New Thread 0x77bebb90 (LWP 26233)]
[New Thread 0x785eeb90 (LWP 26192)]
[New Thread 0x78defb90 (LWP 26166)]
[New Thread 0x796f1b90 (LWP 26144)]
[New Thread 0x79ff3b90 (LWP 26114)]
[New Thread 0x7aff5b90 (LWP 26054)]
[New Thread 0x7b7f6b90 (LWP 26036)]
[New Thread 0x7bff7b90 (LWP 26026)]
[New Thread 0x7c7f8b90 (LWP 26008)]
[New Thread 0x7cff9b90 (LWP 25898)]
[New Thread 0x7d7fab90 (LWP 25868)]
[New Thread 0x7dffbb90 (LWP 25854)]
[New Thread 0x7e7fcb90 (LWP 25844)]
[New Thread 0x7effdb90 (LWP 25810)]
[New Thread 0x7f7feb90 (LWP 25800)]
[New Thread 0x80d38b90 (LWP 25704)]
[New Thread 0x81f3cb90 (LWP 25648)]
[New Thread 0x8273db90 (LWP 25587)]
[New Thread 0x82f3eb90 (LWP 25528)]
[New Thread 0x83840b90 (LWP 25505)]
[New Thread 0x84a44b90 (LWP 25437)]
[New Thread 0x85346b90 (LWP 25422)]
[New Thread 0x85c48b90 (LWP 25415)]
[New Thread 0x86449b90 (LWP 25388)]
[New Thread 0x86c4ab90 (LWP 25321)]
[New Thread 0x8744bb90 (LWP 25314)]
[New Thread 0x87c4cb90 (LWP 25295)]
[New Thread 0x88c4eb90 (LWP 25277)]
[New Thread 0x8944fb90 (LWP 25250)]
[New Thread 0x89c50b90 (LWP 25207)]
[New Thread 0x8a451b90 (LWP 25196)]
[New Thread 0x8ac52b90 (LWP 25177)]
[New Thread 0x8b453b90 (LWP 25154)]
[New Thread 0x8bc54b90 (LWP 25135)]
[New Thread 0x8c556b90 (LWP 25128)]
[New Thread 0x8cd57b90 (LWP 25113)]
[New Thread 0x8d558b90 (LWP 25102)]
[New Thread 0x8dd59b90 (LWP 25095)]
[New Thread 0x8e65bb90 (LWP 25080)]
[New Thread 0x8f75eb90 (LWP 25062)]
[New Thread 0x90760b90 (LWP 25032)]
[New Thread 0x90f61b90 (LWP 25013)]
[New Thread 0x91863b90 (LWP 25006)]
[New Thread 0x92865b90 (LWP 24948)]
[New Thread 0x93066b90 (LWP 24925)]
[New Thread 0x93867b90 (LWP 24906)]
[New Thread 0x94068b90 (LWP 24899)]
[New Thread 0x9506ab90 (LWP 24861)]
[New Thread 0x9586bb90 (LWP 24846)]
[New Thread 0x9606cb90 (LWP 24819)]
[New Thread 0x9686db90 (LWP 24808)]
[New Thread 0x9706eb90 (LWP 24801)]
[New Thread 0x9786fb90 (LWP 24794)]
[New Thread 0x98070b90 (LWP 24759)]
[New Thread 0x98871b90 (LWP 24752)]
[New Thread 0x99072b90 (LWP 24745)]
[New Thread 0x99873b90 (LWP 24730)]
[New Thread 0x9a074b90 (LWP 24715)]
[New Thread 0x9a875b90 (LWP 24708)]
[New Thread 0x9b076b90 (LWP 24701)]
[New Thread 0x9b877b90 (LWP 24694)]
[New Thread 0x9c078b90 (LWP 24679)]
[New Thread 0x9c97ab90 (LWP 24660)]
[New Thread 0x9e37fb90 (LWP 24623)]
[New Thread 0x9f482b90 (LWP 24609)]
[New Thread 0xa0484b90 (LWP 24595)]
[New Thread 0xa0c85b90 (LWP 24588)]
[New Thread 0xa1486b90 (LWP 24581)]
[New Thread 0xa1c87b90 (LWP 24574)]
[New Thread 0xa2488b90 (LWP 24563)]
[New Thread 0xa2c89b90 (LWP 24548)]
[New Thread 0xa358bb90 (LWP 24537)]
[New Thread 0xa458db90 (LWP 24519)]
[New Thread 0xa4d8eb90 (LWP 24512)]
[New Thread 0xa558fb90 (LWP 24500)]
[New Thread 0xa5e91b90 (LWP 24493)]
[New Thread 0xa6e93b90 (LWP 24479)]
[New Thread 0xa7694b90 (LWP 24472)]
[New Thread 0xa7e95b90 (LWP 24465)]
[New Thread 0xa8696b90 (LWP 24458)]
[New Thread 0xa8e97b90 (LWP 24451)]
[New Thread 0xa9698b90 (LWP 24444)]
[New Thread 0xa9e99b90 (LWP 24437)]
[New Thread 0xaa69ab90 (LWP 24430)]
[New Thread 0xaae9bb90 (LWP 24423)]
[New Thread 0xabe9db90 (LWP 24401)]
[New Thread 0xac69eb90 (LWP 24394)]
[New Thread 0xace9fb90 (LWP 24387)]
[New Thread 0xad6a0b90 (LWP 24380)]
[New Thread 0xadea1b90 (LWP 24373)]
[New Thread 0xae6a2b90 (LWP 24366)]
[New Thread 0xaeea3b90 (LWP 24359)]
[New Thread 0xaf6a4b90 (LWP 24352)]
[New Thread 0xafea5b90 (LWP 24345)]
[New Thread 0xb06a6b90 (LWP 24338)]
[New Thread 0xb0ea7b90 (LWP 24331)]
[New Thread 0xb16a8b90 (LWP 24316)]
[New Thread 0xb1ea9b90 (LWP 24309)]
[New Thread 0xb26aab90 (LWP 24302)]
[New Thread 0xb2eabb90 (LWP 24295)]
[New Thread 0xb36acb90 (LWP 24288)]
[New Thread 0xb3eadb90 (LWP 24281)]
[New Thread 0xb46aeb90 (LWP 24270)]
[New Thread 0xb4eafb90 (LWP 24263)]
[New Thread 0xb56b0b90 (LWP 24256)]
[New Thread 0xb5eb1b90 (LWP 24249)]
[New Thread 0xb66b2b90 (LWP 24235)]
[New Thread 0xb6fcdb90 (LWP 24224)]
[New Thread 0xb78cfb90 (LWP 24033)]
[New Thread 0xb7b25b90 (LWP 24031)]
[New Thread 0xb7c62b90 (LWP 24028)]
[New Thread 0xb7e09b90 (LWP 24025)]
[New Thread 0xb7f77b90 (LWP 24024)]
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
Thread 121 (Thread 0xb7f77b90 (LWP 24024)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f4b7ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib/libpthread.so.0
#2  0x8001decc in alarm_handler (arg=0x0) at alarm.c:204
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 120 (Thread 0xb7e09b90 (LWP 24025)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f4b7ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib/libpthread.so.0
#2  0x80017e89 in st_queue_handler (arg=0x0) at state.c:966
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 119 (Thread 0xb7c62b90 (LWP 24028)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8004e8a8) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 118 (Thread 0xb7b25b90 (LWP 24031)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8004eec8) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 117 (Thread 0xb78cfb90 (LWP 24033)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800513b0) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 116 (Thread 0xb6fcdb90 (LWP 24224)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8004fd58) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 115 (Thread 0xb66b2b90 (LWP 24235)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80067170) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 114 (Thread 0xb5eb1b90 (LWP 24249)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80067758) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 113 (Thread 0xb56b0b90 (LWP 24256)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800680b0) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 112 (Thread 0xb4eafb90 (LWP 24263)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80068a20) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 111 (Thread 0xb46aeb90 (LWP 24270)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80069298) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 110 (Thread 0xb3eadb90 (LWP 24281)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80069ba0) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 109 (Thread 0xb36acb90 (LWP 24288)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006a520) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 108 (Thread 0xb2eabb90 (LWP 24295)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006ae98) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 107 (Thread 0xb26aab90 (LWP 24302)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006b810) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 106 (Thread 0xb1ea9b90 (LWP 24309)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006c110) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 105 (Thread 0xb16a8b90 (LWP 24316)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006ca20) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 104 (Thread 0xb0ea7b90 (LWP 24331)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006d5a8) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 103 (Thread 0xb06a6b90 (LWP 24338)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006d328) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 102 (Thread 0xafea5b90 (LWP 24345)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006e7a8) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 101 (Thread 0xaf6a4b90 (LWP 24352)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006f0b8) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 100 (Thread 0xaeea3b90 (LWP 24359)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006dd98) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 99 (Thread 0xae6a2b90 (LWP 24366)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80070338) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 98 (Thread 0xadea1b90 (LWP 24373)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006f920) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 97 (Thread 0xad6a0b90 (LWP 24380)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800715b8) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 96 (Thread 0xace9fb90 (LWP 24387)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80071ec0) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 95 (Thread 0xac69eb90 (LWP 24394)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80070b98) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 94 (Thread 0xabe9db90 (LWP 24401)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80073148) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 93 (Thread 0xaae9bb90 (LWP 24423)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80074520) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 92 (Thread 0xaa69ab90 (LWP 24430)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80075058) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 91 (Thread 0xa9e99b90 (LWP 24437)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80075808) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 90 (Thread 0xa9698b90 (LWP 24444)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800760f0) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 89 (Thread 0xa8e97b90 (LWP 24451)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80076a20) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 88 (Thread 0xa8696b90 (LWP 24458)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80077328) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 87 (Thread 0xa7e95b90 (LWP 24465)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80077c30) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 86 (Thread 0xa7694b90 (LWP 24472)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80074dd8) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 85 (Thread 0xa6e93b90 (LWP 24479)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80078ed8) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 84 (Thread 0xa5e91b90 (LWP 24493)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007a208) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 83 (Thread 0xa558fb90 (LWP 24500)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007ac58) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 82 (Thread 0xa4d8eb90 (LWP 24512)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007b7a0) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 81 (Thread 0xa458db90 (LWP 24519)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007bf50) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 80 (Thread 0xa358bb90 (LWP 24537)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007d2a0) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 79 (Thread 0xa2c89b90 (LWP 24548)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007de18) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 78 (Thread 0xa2488b90 (LWP 24563)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007db98) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 77 (Thread 0xa1c87b90 (LWP 24574)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007f028) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 76 (Thread 0xa1486b90 (LWP 24581)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007e618) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 75 (Thread 0xa0c85b90 (LWP 24588)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007f8a8) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 74 (Thread 0xa0484b90 (LWP 24595)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80080c38) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 73 (Thread 0x9f482b90 (LWP 24609)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800820b0) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 72 (Thread 0x9e37fb90 (LWP 24623)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80082910) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 71 (Thread 0x9c97ab90 (LWP 24660)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80085428) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 70 (Thread 0x9c078b90 (LWP 24679)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80085f08) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 69 (Thread 0x9b877b90 (LWP 24694)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80086a00) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 68 (Thread 0x9b076b90 (LWP 24701)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80087188) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 67 (Thread 0x9a875b90 (LWP 24708)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80087a98) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 66 (Thread 0x9a074b90 (LWP 24715)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80086780) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 65 (Thread 0x99873b90 (LWP 24730)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80088328) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 64 (Thread 0x99072b90 (LWP 24745)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800898a0) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 63 (Thread 0x98871b90 (LWP 24752)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80089620) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 62 (Thread 0x98070b90 (LWP 24759)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80089f98) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 61 (Thread 0x9786fb90 (LWP 24794)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008b5c0) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 60 (Thread 0x9706eb90 (LWP 24801)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008bd50) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 59 (Thread 0x9686db90 (LWP 24808)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008c640) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 58 (Thread 0x9606cb90 (LWP 24819)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008d138) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 57 (Thread 0x9586bb90 (LWP 24846)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008dad8) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 56 (Thread 0x9506ab90 (LWP 24861)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008e5c0) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 55 (Thread 0x94068b90 (LWP 24899)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008fa30) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 54 (Thread 0x93867b90 (LWP 24906)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008f720) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 53 (Thread 0x93066b90 (LWP 24925)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80090eb0) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 52 (Thread 0x92865b90 (LWP 24948)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80091958) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 51 (Thread 0x91863b90 (LWP 25006)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80092e70) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 50 (Thread 0x90f61b90 (LWP 25013)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800938b0) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 49 (Thread 0x90760b90 (LWP 25032)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80094220) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 48 (Thread 0x8f75eb90 (LWP 25062)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80094b58) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 47 (Thread 0x8e65bb90 (LWP 25080)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80096c20) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 46 (Thread 0x8dd59b90 (LWP 25095)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800977a8) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 45 (Thread 0x8d558b90 (LWP 25102)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800982a0) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 44 (Thread 0x8cd57b90 (LWP 25113)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80098c18) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 43 (Thread 0x8c556b90 (LWP 25128)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800995a8) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 42 (Thread 0x8bc54b90 (LWP 25135)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80099ef0) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 41 (Thread 0x8b453b90 (LWP 25154)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009aa70) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 40 (Thread 0x8ac52b90 (LWP 25177)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009b470) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 39 (Thread 0x8a451b90 (LWP 25196)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009bf58) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 38 (Thread 0x89c50b90 (LWP 25207)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009c760) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 37 (Thread 0x8944fb90 (LWP 25250)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009d380) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 36 (Thread 0x88c4eb90 (LWP 25277)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009dd70) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 35 (Thread 0x87c4cb90 (LWP 25295)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009f220) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 34 (Thread 0x8744bb90 (LWP 25314)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009fbc0) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 33 (Thread 0x86c4ab90 (LWP 25321)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f4af42 in pthread_rwlock_wrlock () from /lib/libpthread.so.0
#2  0x800204c8 in master_source_writelock (entry=0x8004e808) at master.c:558
#3  0x8000a753 in handle_mounts (arg=0x800a03d0) at automount.c:1549
#4  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#5  0xb7ece02e in clone () from /lib/libc.so.6

Thread 32 (Thread 0x86449b90 (LWP 25388)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a12c8) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 31 (Thread 0x85c48b90 (LWP 25415)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a1048) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 30 (Thread 0x85346b90 (LWP 25422)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a28c0) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 29 (Thread 0x84a44b90 (LWP 25437)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a3390) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 28 (Thread 0x83840b90 (LWP 25505)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a4e40) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 27 (Thread 0x82f3eb90 (LWP 25528)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a5870) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 26 (Thread 0x8273db90 (LWP 25587)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a6508) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 25 (Thread 0x81f3cb90 (LWP 25648)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b2d10) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 24 (Thread 0x80d38b90 (LWP 25704)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b4578) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 23 (Thread 0x7f7feb90 (LWP 25800)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b6230) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 22 (Thread 0x7effdb90 (LWP 25810)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b5fa8) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 21 (Thread 0x7e7fcb90 (LWP 25844)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b7770) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 20 (Thread 0x7dffbb90 (LWP 25854)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b74f0) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 19 (Thread 0x7d7fab90 (LWP 25868)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b8b38) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 18 (Thread 0x7cff9b90 (LWP 25898)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b9488) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 17 (Thread 0x7c7f8b90 (LWP 26008)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800ba488) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 16 (Thread 0x7bff7b90 (LWP 26026)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800bafa0) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 15 (Thread 0x7b7f6b90 (LWP 26036)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800bb880) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 14 (Thread 0x7aff5b90 (LWP 26054)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800bc360) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 13 (Thread 0x79ff3b90 (LWP 26114)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800bd888) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 12 (Thread 0x796f1b90 (LWP 26144)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800be510) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 11 (Thread 0x78defb90 (LWP 26166)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800bf138) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 10 (Thread 0x785eeb90 (LWP 26192)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800bfc40) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 9 (Thread 0x77bebb90 (LWP 26233)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800c07a0) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 8 (Thread 0x773eab90 (LWP 26251)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800c0520) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 7 (Thread 0x76be9b90 (LWP 26301)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800c20c0) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 6 (Thread 0x763e8b90 (LWP 26307)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800c2a68) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 5 (Thread 0x75ae6b90 (LWP 26410)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800c3ad8) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 4 (Thread 0x74addb90 (LWP 27049)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec4817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800d0218) at automount.c:909
#3  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ece02e in clone () from /lib/libc.so.6

Thread 3 (Thread 0x74cdfb90 (LWP 30468)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f4b566 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib/libpthread.so.0
#2  0x80021767 in master_notify_submount (ap=0x8004e8a8, 
    path=0x8009c630 "/net/mukilteo", state=ST_EXPIRE) at master.c:920
#3  0x8000c90d in expire_proc_indirect (arg=0x800bcd38) at indirect.c:468
#4  0xb7f47192 in start_thread () from /lib/libpthread.so.0
#5  0xb7ece02e in clone () from /lib/libc.so.6

Thread 2 (Thread 0xb70ceb90 (LWP 31294)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f4dc1e in __lll_mutex_lock_wait () from /lib/libpthread.so.0
#2  0xb7f49a58 in _L_mutex_lock_86 () from /lib/libpthread.so.0
#3  0xb7f4947d in pthread_mutex_lock () from /lib/libpthread.so.0
#4  0xb79f771e in mount_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
    name=0xb70ccaa0 "stockton", name_len=8, what=0xb70cca70 "file", 
    fstype=0xb70ccac0 "autofs", 
    c_options=0xb70ccae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=stockton", context=0x18) at mount_autofs.c:217
#5  0x80013984 in do_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
    name=0xb70ccaa0 "stockton", name_len=8, what=0xb70cca70 "file", 
    fstype=0xb70ccac0 "autofs", 
    options=0xb70ccae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=stockton")
    at mount.c:73
#6  0xb7b4baa3 in sun_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
    name=0xb70cce10 "stockton", namelen=8, 
    loc=0x800a3318 "file:/etc/auto.net.generic", loclen=26, 
    options=0xb70ccae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=stockton", 
    ctxt=0x8003a600) at parse_sun.c:657
#7  0xb7b4c91a in parse_mount (ap=0x8004e8a8, name=0xb70cce10 "stockton", 
    name_len=8, 
    mapent=0xb70ccd80 "-rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=&\tfile:/etc/auto.net.generic", context=0x8003a600) at parse_sun.c:1458
#8  0xb7de3e70 in lookup_mount (ap=0x8004e8a8, name=0xb70ce1c8 "stockton", 
    name_len=8, context=0x8004e7f8) at lookup_file.c:1136
#9  0x8001451c in do_lookup_mount (ap=0x8004e8a8, map=0x8003a6e8, 
    name=0xb70ce1c8 "stockton", name_len=8) at lookup.c:668
#10 0x800146aa in lookup_name_file_source_instance (ap=0x8004e8a8, 
    map=0x8004e9b0, name=0xb70ce1c8 "stockton", name_len=8) at lookup.c:708
#11 0x80015279 in lookup_nss_mount (ap=0x8004e8a8, source=0x0, 
    name=0xb70ce1c8 "stockton", name_len=8) at lookup.c:856
#12 0x8000be7a in do_mount_indirect (arg=0x800ceb20) at indirect.c:883
#13 0xb7f47192 in start_thread () from /lib/libpthread.so.0
#14 0xb7ece02e in clone () from /lib/libc.so.6

Thread 1 (Thread 0xb7e0a6c0 (LWP 24023)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f4f2aa in do_sigwait () from /lib/libpthread.so.0
#2  0xb7f4f34f in sigwait () from /lib/libpthread.so.0
#3  0x80008349 in main (argc=0, argv=0xbfd958e8) at automount.c:1366
#0  0xffffe410 in __kernel_vsyscall ()
(gdb) Hangup detected on fd 0
error detected on stdin
The program is running.  Quit anyway (and detach it)? (y or n) [answered Y; input not from terminal]
Detaching from program: /usr/sbin/automount, process 24023
=----- end of backtrace -----
11:39:54 /net/nasturtium/m1   still mounted after 900 secs, state = success
11:40:28 /net/sassafras/m1    still mounted after 900 secs, state = success
11:40:28 /net/sassafras/m2    still mounted after 900 secs, state = success
11:40:33 /net/papyrus70/m1    still mounted after 900 secs, state = success
(test stopped)
