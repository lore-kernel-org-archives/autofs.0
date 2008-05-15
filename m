From: jimc@math.ucla.edu (Jim Carter)
Subject: Re: clients suddenly start hanging (was: (no subject))
Date: Thu, 15 May 2008 14:59:41 -0700 (PDT)
Message-ID: <20080515215941.6221B21124E@simba.math.ucla.edu>
References: <20080423185018.122C53C3B1@xena.cft.ca.us>
	<1210492627.3006.57.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1210492627.3006.57.camel@raven.themaw.net>
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

Unfortunately the last set of patches (1-8 for module and 1-3 for daemon)
did not stop the hanging.  

Source: 5.0.3 with SuSE patches.
http://download.opensuse.org/repositories/home:/makoenig/openSUSE_10.3/src/autofs-5.0.3-6.1.src.rpm

Addtional module patches:
PATCH 1/8] autofs4 - check for invalid dentry in getpath
PATCH 2/8] autofs4 - fix sparse warning in waitq.c:autofs4_expire_indirect()
PATCH 3/8] autofs4 - fix execution order race in mount request code
PATCH 4/8] autofs4 - fix incorrect return from root.c:try_to_fill_dentry()
PATCH 5/8] autofs4 - fix mntput, dput order bug
PATCH 6/8] autofs4 - use struct qstr in waitq.c
PATCH 7/8] autofs4 - don't release directory mutex if called in oz_mode
PATCH 8/8] autofs4 - fix pending mount race.

Additional daemon patches:
Patch17:        autofs-5.0.2-dns-name-lookup.patch
Patch28:        autofs-5.0.3-dont-fail-on-empty-master-fix-2.patch
Patch29:        autofs-5.0.3-mount-thread-create-cond-handling.patch
Patch30:        autofs-5.0.3-submount-shutdown-recovery-5.patch

(All patches went on cleanly.)

Run started 22:32:18, 237 filesystems mounted (until 22:34:37 to do this)
22:47:43 to 22:49:12 44 filesys still mounted after 900 secs.  Some 
    machines had 2 mounted filesys but none of these had all filesys stuck.
22:57:43 to 23:01:41 193 filesys still mounted after 900 secs.  
    Expired once or twice, then got stuck.
23:03:25 All 3 filesys on one machine hung.  So screwed up that GDB could 
    not show individual thread backtraces!  The only backtrace line said:
    0xffffe410 in __kernel_vsyscall ()
    I'm not showing the initial administrative stuff, to save space.
23:03:51 All 3 filesys on a different machine hung.  This time GDB was
    able to show the backtraces (shown below, complete).  Total of 6 hung
    clients when this backtrace was taken.
23:23:16 Test was terminated.

In a second run (backtraces available if needed) I caught a similar 
pattern of behavior: all the filesystems on particular machines would 
hang all at once.  

You're probably right that the non-expiration is irrelevant for the 
submount hangs, because the statistics are wrong (no correlation between
machines/submounts), but you never know about obscure consequential
damage.  Also, the client is my test machine and there's nothing, like
Konqueror, other than my test program that accesses the NFS mounted
directories, which would prevent expiry.  

Also, I'm surprised that GDB couldn't show the individual
backtraces the first time, then did the second time.

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
Attaching to program: /usr/sbin/automount, process 6288
Loaded symbols for /usr/sbin/automount
Reading symbols from /lib/libpthread.so.0...done.
[Thread debugging using libthread_db enabled]
[New Thread 0xb7e116c0 (LWP 6288)]
[New Thread 0x78feab90 (LWP 12138)]
[New Thread 0x78ee9b90 (LWP 11528)]
[New Thread 0x79aeeb90 (LWP 8592)]
[New Thread 0x7a3f0b90 (LWP 8493)]
[New Thread 0x7abf1b90 (LWP 8487)]
[New Thread 0x7b4f3b90 (LWP 8424)]
[New Thread 0x7bcf4b90 (LWP 8366)]
[New Thread 0x7c5f6b90 (LWP 8344)]
[New Thread 0x7cff9b90 (LWP 8314)]
[New Thread 0x7dffbb90 (LWP 8242)]
[New Thread 0x7e7fcb90 (LWP 8232)]
[New Thread 0x7effdb90 (LWP 8218)]
[New Thread 0x7f7feb90 (LWP 8108)]
[New Thread 0x7ffffb90 (LWP 8070)]
[New Thread 0x80b3db90 (LWP 8060)]
[New Thread 0x8133eb90 (LWP 8026)]
[New Thread 0x81b3fb90 (LWP 8016)]
[New Thread 0x82643b90 (LWP 7926)]
[New Thread 0x82e44b90 (LWP 7920)]
[New Thread 0x83746b90 (LWP 7890)]
[New Thread 0x83f47b90 (LWP 7868)]
[New Thread 0x84748b90 (LWP 7765)]
[New Thread 0x84f49b90 (LWP 7759)]
[New Thread 0x8614db90 (LWP 7698)]
[New Thread 0x8694eb90 (LWP 7684)]
[New Thread 0x87a51b90 (LWP 7652)]
[New Thread 0x88353b90 (LWP 7588)]
[New Thread 0x88b54b90 (LWP 7581)]
[New Thread 0x89355b90 (LWP 7562)]
[New Thread 0x8a357b90 (LWP 7544)]
[New Thread 0x8ab58b90 (LWP 7517)]
[New Thread 0x8b359b90 (LWP 7474)]
[New Thread 0x8bb5ab90 (LWP 7463)]
[New Thread 0x8c35bb90 (LWP 7444)]
[New Thread 0x8cb5cb90 (LWP 7421)]
[New Thread 0x8d35db90 (LWP 7402)]
[New Thread 0x8db5eb90 (LWP 7395)]
[New Thread 0x8e35fb90 (LWP 7380)]
[New Thread 0x8eb60b90 (LWP 7369)]
[New Thread 0x8f361b90 (LWP 7353)]
[New Thread 0x8fc63b90 (LWP 7346)]
[New Thread 0x90565b90 (LWP 7335)]
[New Thread 0x91567b90 (LWP 7307)]
[New Thread 0x9266ab90 (LWP 7281)]
[New Thread 0x9366cb90 (LWP 7223)]
[New Thread 0x93e6db90 (LWP 7200)]
[New Thread 0x94e6fb90 (LWP 7174)]
[New Thread 0x95e71b90 (LWP 7136)]
[New Thread 0x96672b90 (LWP 7121)]
[New Thread 0x96e73b90 (LWP 7094)]
[New Thread 0x97674b90 (LWP 7083)]
[New Thread 0x97e75b90 (LWP 7076)]
[New Thread 0x98676b90 (LWP 7069)]
[New Thread 0x98e77b90 (LWP 7034)]
[New Thread 0x99779b90 (LWP 7027)]
[New Thread 0x99f7ab90 (LWP 7020)]
[New Thread 0x9a77bb90 (LWP 7005)]
[New Thread 0x9af7cb90 (LWP 6990)]
[New Thread 0x9b77db90 (LWP 6983)]
[New Thread 0x9bf7eb90 (LWP 6976)]
[New Thread 0x9c77fb90 (LWP 6969)]
[New Thread 0x9cf80b90 (LWP 6954)]
[New Thread 0x9d882b90 (LWP 6935)]
[New Thread 0x9fb89b90 (LWP 6891)]
[New Thread 0xa0b8bb90 (LWP 6877)]
[New Thread 0xa138cb90 (LWP 6870)]
[New Thread 0xa1c8eb90 (LWP 6863)]
[New Thread 0xa2c90b90 (LWP 6845)]
[New Thread 0xa3491b90 (LWP 6830)]
[New Thread 0xa3d93b90 (LWP 6819)]
[New Thread 0xa4d95b90 (LWP 6801)]
[New Thread 0xa5596b90 (LWP 6794)]
[New Thread 0xa5d97b90 (LWP 6783)]
[New Thread 0xa6598b90 (LWP 6776)]
[New Thread 0xa759ab90 (LWP 6762)]
[New Thread 0xa7d9bb90 (LWP 6755)]
[New Thread 0xa859cb90 (LWP 6748)]
[New Thread 0xa8d9db90 (LWP 6740)]
[New Thread 0xa959eb90 (LWP 6733)]
[New Thread 0xa9ea0b90 (LWP 6726)]
[New Thread 0xaa6a1b90 (LWP 6719)]
[New Thread 0xaaea2b90 (LWP 6712)]
[New Thread 0xab6a3b90 (LWP 6705)]
[New Thread 0xac6a5b90 (LWP 6683)]
[New Thread 0xacea6b90 (LWP 6676)]
[New Thread 0xad6a7b90 (LWP 6669)]
[New Thread 0xadea8b90 (LWP 6662)]
[New Thread 0xae6a9b90 (LWP 6655)]
[New Thread 0xaeeaab90 (LWP 6648)]
[New Thread 0xaf6abb90 (LWP 6641)]
[New Thread 0xafeacb90 (LWP 6634)]
[New Thread 0xb06adb90 (LWP 6627)]
[New Thread 0xb0eaeb90 (LWP 6620)]
[New Thread 0xb16afb90 (LWP 6613)]
[New Thread 0xb1eb0b90 (LWP 6598)]
[New Thread 0xb26b1b90 (LWP 6591)]
[New Thread 0xb2eb2b90 (LWP 6584)]
[New Thread 0xb36b3b90 (LWP 6577)]
[New Thread 0xb3eb4b90 (LWP 6570)]
[New Thread 0xb46b5b90 (LWP 6559)]
[New Thread 0xb4eb6b90 (LWP 6552)]
[New Thread 0xb56b7b90 (LWP 6545)]
[New Thread 0xb5eb8b90 (LWP 6538)]
[New Thread 0xb67bab90 (LWP 6308)]
[New Thread 0xb6fbbb90 (LWP 6307)]
[New Thread 0xb78d6b90 (LWP 6298)]
[New Thread 0xb7b2cb90 (LWP 6296)]
[New Thread 0xb7c69b90 (LWP 6293)]
[New Thread 0xb7e10b90 (LWP 6290)]
[New Thread 0xb7f7eb90 (LWP 6289)]
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
Thread 111 (Thread 0xb7f7eb90 (LWP 6289)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f527ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib/libpthread.so.0
#2  0x8001decc in alarm_handler (arg=0x0) at alarm.c:204
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 110 (Thread 0xb7e10b90 (LWP 6290)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f527ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib/libpthread.so.0
#2  0x80017e89 in st_queue_handler (arg=0x0) at state.c:966
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 109 (Thread 0xb7c69b90 (LWP 6293)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8004e8a8) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 108 (Thread 0xb7b2cb90 (LWP 6296)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8004eec8) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 107 (Thread 0xb78d6b90 (LWP 6298)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800513f0) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 106 (Thread 0xb6fbbb90 (LWP 6307)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80066400) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 105 (Thread 0xb67bab90 (LWP 6308)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80066c58) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 104 (Thread 0xb5eb8b90 (LWP 6538)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80067770) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 103 (Thread 0xb56b7b90 (LWP 6545)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80067fd8) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 102 (Thread 0xb4eb6b90 (LWP 6552)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800688c0) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 101 (Thread 0xb46b5b90 (LWP 6559)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800691c8) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 100 (Thread 0xb3eb4b90 (LWP 6570)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80069ad0) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 99 (Thread 0xb36b3b90 (LWP 6577)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006a468) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 98 (Thread 0xb2eb2b90 (LWP 6584)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006ade8) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 97 (Thread 0xb26b1b90 (LWP 6591)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006b6e0) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 96 (Thread 0xb1eb0b90 (LWP 6598)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006bfe8) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 95 (Thread 0xb16afb90 (LWP 6613)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006cb70) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 94 (Thread 0xb0eaeb90 (LWP 6620)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006c8f0) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 93 (Thread 0xb06adb90 (LWP 6627)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006dd70) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 92 (Thread 0xafeacb90 (LWP 6634)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006e680) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 91 (Thread 0xaf6abb90 (LWP 6641)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006d360) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 90 (Thread 0xaeeaab90 (LWP 6648)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006f900) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 89 (Thread 0xae6a9b90 (LWP 6655)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8006eee8) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 88 (Thread 0xadea8b90 (LWP 6662)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80070b80) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 87 (Thread 0xad6a7b90 (LWP 6669)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80071488) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 86 (Thread 0xacea6b90 (LWP 6676)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80070160) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 85 (Thread 0xac6a5b90 (LWP 6683)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80072710) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 84 (Thread 0xab6a3b90 (LWP 6705)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80073ae8) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 83 (Thread 0xaaea2b90 (LWP 6712)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80074620) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 82 (Thread 0xaa6a1b90 (LWP 6719)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80074dd0) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 81 (Thread 0xa9ea0b90 (LWP 6726)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80074448) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 80 (Thread 0xa959eb90 (LWP 6733)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80075648) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 79 (Thread 0xa8d9db90 (LWP 6740)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80076ac0) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 78 (Thread 0xa859cb90 (LWP 6748)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800773c8) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 77 (Thread 0xa7d9bb90 (LWP 6755)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80077c70) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 76 (Thread 0xa759ab90 (LWP 6762)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80078530) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 75 (Thread 0xa6598b90 (LWP 6776)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80079990) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 74 (Thread 0xa5d97b90 (LWP 6783)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80079710) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 73 (Thread 0xa5596b90 (LWP 6794)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007a160) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 72 (Thread 0xa4d95b90 (LWP 6801)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007b4d8) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 71 (Thread 0xa3d93b90 (LWP 6819)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007c958) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 70 (Thread 0xa3491b90 (LWP 6830)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007d3a0) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 69 (Thread 0xa2c90b90 (LWP 6845)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007d120) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 68 (Thread 0xa1c8eb90 (LWP 6863)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007ef60) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 67 (Thread 0xa138cb90 (LWP 6870)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8007f9b0) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 66 (Thread 0xa0b8bb90 (LWP 6877)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80080308) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 65 (Thread 0x9fb89b90 (LWP 6891)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80080c18) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 64 (Thread 0x9d882b90 (LWP 6935)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80084128) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 63 (Thread 0x9cf80b90 (LWP 6954)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80084c80) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 62 (Thread 0x9c77fb90 (LWP 6969)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80085788) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 61 (Thread 0x9bf7eb90 (LWP 6976)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80085f38) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 60 (Thread 0x9b77db90 (LWP 6983)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80086840) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 59 (Thread 0x9af7cb90 (LWP 6990)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80085508) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 58 (Thread 0x9a77bb90 (LWP 7005)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800870d0) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 57 (Thread 0x99f7ab90 (LWP 7020)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80087a38) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 56 (Thread 0x99779b90 (LWP 7027)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80088458) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 55 (Thread 0x98e77b90 (LWP 7034)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80089808) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 54 (Thread 0x98676b90 (LWP 7069)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f51f42 in pthread_rwlock_wrlock () from /lib/libpthread.so.0
#2  0x800203a8 in master_source_writelock (entry=0x8004e808) at master.c:558
#3  0x8000a753 in handle_mounts (arg=0x8008a328) at automount.c:1549
#4  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#5  0xb7ed502e in clone () from /lib/libc.so.6

Thread 53 (Thread 0x97e75b90 (LWP 7076)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008aab8) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 52 (Thread 0x97674b90 (LWP 7083)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008b360) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 51 (Thread 0x96e73b90 (LWP 7094)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008a0a8) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 50 (Thread 0x96672b90 (LWP 7121)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008c7d0) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 49 (Thread 0x95e71b90 (LWP 7136)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008d2c8) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 48 (Thread 0x94e6fb90 (LWP 7174)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008e740) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 47 (Thread 0x93e6db90 (LWP 7200)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8008fbf0) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 46 (Thread 0x9366cb90 (LWP 7223)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80090730) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 45 (Thread 0x9266ab90 (LWP 7281)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800911e0) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 44 (Thread 0x91567b90 (LWP 7307)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800926a8) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 43 (Thread 0x90565b90 (LWP 7335)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80093a80) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 42 (Thread 0x8fc63b90 (LWP 7346)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80095158) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 41 (Thread 0x8f361b90 (LWP 7353)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80095ad8) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 40 (Thread 0x8eb60b90 (LWP 7369)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80096580) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 39 (Thread 0x8e35fb90 (LWP 7380)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80096300) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 38 (Thread 0x8db5eb90 (LWP 7395)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80097978) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 37 (Thread 0x8d35db90 (LWP 7402)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800982d0) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 36 (Thread 0x8cb5cb90 (LWP 7421)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x80098db8) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 35 (Thread 0x8c35bb90 (LWP 7444)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800997b8) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 34 (Thread 0x8bb5ab90 (LWP 7463)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800995c8) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 33 (Thread 0x8b359b90 (LWP 7474)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009aa10) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 32 (Thread 0x8ab58b90 (LWP 7517)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009b640) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 31 (Thread 0x8a357b90 (LWP 7544)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009c168) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 30 (Thread 0x89355b90 (LWP 7562)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009d438) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 29 (Thread 0x88b54b90 (LWP 7581)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009ca30) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 28 (Thread 0x88353b90 (LWP 7588)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x8009e7c0) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 27 (Thread 0x87a51b90 (LWP 7652)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800a9ab0) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 26 (Thread 0x8694eb90 (LWP 7684)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800ab0e0) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 25 (Thread 0x8614db90 (LWP 7698)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800abb88) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 24 (Thread 0x84f49b90 (LWP 7759)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800ad3c0) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 23 (Thread 0x84748b90 (LWP 7765)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800add48) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 22 (Thread 0x83f47b90 (LWP 7868)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800aeec8) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 21 (Thread 0x83746b90 (LWP 7890)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800af8d8) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 20 (Thread 0x82e44b90 (LWP 7920)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b0548) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 19 (Thread 0x82643b90 (LWP 7926)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b0e20) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 18 (Thread 0x81b3fb90 (LWP 8016)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b21d8) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 17 (Thread 0x8133eb90 (LWP 8026)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b2a90) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 16 (Thread 0x80b3db90 (LWP 8060)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b3608) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 15 (Thread 0x7ffffb90 (LWP 8070)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b3388) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 14 (Thread 0x7f7feb90 (LWP 8108)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b4a20) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 13 (Thread 0x7effdb90 (LWP 8218)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b59b8) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 12 (Thread 0x7e7fcb90 (LWP 8232)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b64c0) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 11 (Thread 0x7dffbb90 (LWP 8242)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b6d30) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 10 (Thread 0x7cff9b90 (LWP 8314)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b8510) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 9 (Thread 0x7c5f6b90 (LWP 8344)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800b9438) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 8 (Thread 0x7bcf4b90 (LWP 8366)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800ba050) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 7 (Thread 0x7b4f3b90 (LWP 8424)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800bacd0) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 6 (Thread 0x7abf1b90 (LWP 8487)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800bbbb0) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 5 (Thread 0x7a3f0b90 (LWP 8493)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800bc550) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 4 (Thread 0x79aeeb90 (LWP 8592)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ecb817 in poll () from /lib/libc.so.6
#2  0x8000a343 in handle_mounts (arg=0x800bd540) at automount.c:909
#3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ed502e in clone () from /lib/libc.so.6

Thread 3 (Thread 0x78ee9b90 (LWP 11528)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f52566 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib/libpthread.so.0
#2  0x800215b7 in master_notify_submount (ap=0x8004e8a8, 
    path=0x800a9630 "/net/bamboo45", state=ST_EXPIRE) at master.c:908
#3  0x8000c90d in expire_proc_indirect (arg=0x800825e8) at indirect.c:468
#4  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#5  0xb7ed502e in clone () from /lib/libc.so.6

Thread 2 (Thread 0x78feab90 (LWP 12138)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f54c1e in __lll_mutex_lock_wait () from /lib/libpthread.so.0
#2  0xb7f50a58 in _L_mutex_lock_86 () from /lib/libpthread.so.0
#3  0xb7f5047d in pthread_mutex_lock () from /lib/libpthread.so.0
#4  0xb79fe60e in mount_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
    name=0x78fe8aa0 "bamboo14", name_len=8, what=0x78fe8a70 "file", 
    fstype=0x78fe8ac0 "autofs", 
    c_options=0x78fe8ae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=bamboo14", context=0x18) at mount_autofs.c:217
#5  0x80013984 in do_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
    name=0x78fe8aa0 "bamboo14", name_len=8, what=0x78fe8a70 "file", 
    fstype=0x78fe8ac0 "autofs", 
    options=0x78fe8ae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=bamboo14")
    at mount.c:73
#6  0xb7b52993 in sun_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
    name=0x78fe8e10 "bamboo14", namelen=8, 
    loc=0x80091e18 "file:/etc/auto.net.generic", loclen=26, 
    options=0x78fe8ae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=bamboo14", 
    ctxt=0x8003a600) at parse_sun.c:657
#7  0xb7b5380a in parse_mount (ap=0x8004e8a8, name=0x78fe8e10 "bamboo14", 
    name_len=8, 
    mapent=0x78fe8d80 "-rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=&\tfile:/etc/auto.net.generic", context=0x8003a600) at parse_sun.c:1458
#8  0xb7deae70 in lookup_mount (ap=0x8004e8a8, name=0x78fea1c8 "bamboo14", 
    name_len=8, context=0x8004e7f8) at lookup_file.c:1136
#9  0x8001451c in do_lookup_mount (ap=0x8004e8a8, map=0x8003a6e8, 
    name=0x78fea1c8 "bamboo14", name_len=8) at lookup.c:668
#10 0x800146aa in lookup_name_file_source_instance (ap=0x8004e8a8, 
    map=0x8004e9b0, name=0x78fea1c8 "bamboo14", name_len=8) at lookup.c:708
#11 0x80015279 in lookup_nss_mount (ap=0x8004e8a8, source=0x0, 
    name=0x78fea1c8 "bamboo14", name_len=8) at lookup.c:856
#12 0x8000be7a in do_mount_indirect (arg=0x800928f8) at indirect.c:883
#13 0xb7f4e192 in start_thread () from /lib/libpthread.so.0
#14 0xb7ed502e in clone () from /lib/libc.so.6

Thread 1 (Thread 0xb7e116c0 (LWP 6288)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f562aa in do_sigwait () from /lib/libpthread.so.0
#2  0xb7f5634f in sigwait () from /lib/libpthread.so.0
#3  0x80008349 in main (argc=0, argv=0xbfac8e28) at automount.c:1366
#0  0xffffe410 in __kernel_vsyscall ()
(gdb) Hangup detected on fd 0
error detected on stdin
The program is running.  Quit anyway (and detach it)? (y or n) [answered Y; input not from terminal]
Detaching from program: /usr/sbin/automount, process 6288
=----- end of backtrace -----
