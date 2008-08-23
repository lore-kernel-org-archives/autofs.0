From: Joe Pruett <joey@clean.q7.com>
Subject: Re: something changed from 4 to 5
Date: Sat, 23 Aug 2008 07:45:58 -0700 (PDT)
Message-ID: <alpine.LRH.1.10.0808230743560.25167@q7.q7.com>
References: <alpine.LRH.1.10.0808120940350.4317@q7.q7.com>
	<1218596289.3148.8.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1218596289.3148.8.camel@raven.themaw.net>
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

i had one of my servers get into the mode where automount is hung up doing 
something.  i started attaching to each one and doing the gdb stack trace 
you asked for.  here are the results.  after looking at the third one, 
things cleared up.  hopefully we can figure something out on this.

Script started on Fri 22 Aug 2008 01:11:35 PM PDT
[root@titan ~]# ps axf | grep auto
  1741 ?        Ssl  116:45 automount
16772 ?        S      0:00  \_ automount
16777 ?        S      0:00  \_ automount
20963 ?        S      0:00  \_ automount
21865 ?        S      0:00  \_ automount
23136 ?        S      0:00  \_ automount
25322 pts/0    S+     0:00                  \_ grep auto
[root@titan ~]# gdb -p 1741 /usr/sbin/automount
GNU gdb Red Hat Linux (6.5-37.el5_2.2rh)
Copyright (C) 2006 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i386-redhat-linux-gnu"...Using host libthread_db library "/lib/libthread_db.so.1".

Attaching to program: /usr/sbin/automount, process 1741
Loaded symbols for /usr/sbin/automount
Reading symbols from /lib/libpthread.so.0...done.
[Thread debugging using libthread_db enabled]
[New Thread -1208218944 (LWP 1741)]
[New Thread -1228944496 (LWP 23135)]
[New Thread -1212564592 (LWP 21864)]
[New Thread -1222640752 (LWP 20962)]
[New Thread -1218868336 (LWP 18488)]
[New Thread -1216767088 (LWP 16774)]
[New Thread -1214665840 (LWP 16773)]
[New Thread -1224742000 (LWP 16771)]
[New Thread -1210463344 (LWP 1749)]
[New Thread -1208362096 (LWP 1746)]
[New Thread -1208292464 (LWP 1743)]
[New Thread -1208222832 (LWP 1742)]
Loaded symbols for /lib/libpthread.so.0
Reading symbols from /lib/libdl.so.2...done.
Loaded symbols for /lib/libdl.so.2
Reading symbols from /lib/libgcc_s.so.1...done.
Loaded symbols for /lib/libgcc_s.so.1
Reading symbols from /lib/libc.so.6...done.
Loaded symbols for /lib/libc.so.6
Reading symbols from /lib/ld-linux.so.2...done.
Loaded symbols for /lib/ld-linux.so.2
Reading symbols from /usr/lib/libxml2.so...done.
Loaded symbols for /usr/lib/libxml2.so
Reading symbols from /usr/lib/libz.so.1...done.
Loaded symbols for /usr/lib/libz.so.1
Reading symbols from /lib/libm.so.6...done.
Loaded symbols for /lib/libm.so.6
Reading symbols from /usr/lib/autofs/lookup_nis.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/lookup_yp.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/lookup_nis.so
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
Reading symbols from /lib/libnss_files.so.2...done.
Loaded symbols for /lib/libnss_files.so.2
Reading symbols from /lib/libnss_dns.so.2...done.
Loaded symbols for /lib/libnss_dns.so.2
Reading symbols from /lib/libresolv.so.2...done.
Loaded symbols for /lib/libresolv.so.2
Reading symbols from /lib/libnss_nis.so.2...done.
Loaded symbols for /lib/libnss_nis.so.2
0x002ba402 in __kernel_vsyscall ()
(gdb) thr a a bt

Thread 12 (Thread -1208222832 (LWP 1742)):
#0  0x002ba402 in __kernel_vsyscall ()
#1  0x0070f4ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
    from /lib/libpthread.so.0
#2  0x0025a9af in alarm_handler (arg=0x0) at alarm.c:227
#3  0x0070b46b in start_thread () from /lib/libpthread.so.0
#4  0x00424dbe in clone () from /lib/libc.so.6

Thread 11 (Thread -1208292464 (LWP 1743)):
#0  0x002ba402 in __kernel_vsyscall ()
#1  0x0070f4ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
    from /lib/libpthread.so.0
#2  0x0025477e in st_queue_handler (arg=0x0) at state.c:965
#3  0x0070b46b in start_thread () from /lib/libpthread.so.0
#4  0x00424dbe in clone () from /lib/libc.so.6

Thread 10 (Thread -1208362096 (LWP 1746)):
#0  0x002ba402 in __kernel_vsyscall ()
#1  0x0041b1c3 in poll () from /lib/libc.so.6
#2  0x00245bc0 in handle_packet (ap=0x8c64bc0) at automount.c:883
#3  0x002473e7 in handle_mounts (arg=0x8c64bc0) at automount.c:1519
#4  0x0070b46b in start_thread () from /lib/libpthread.so.0
#5  0x00424dbe in clone () from /lib/libc.so.6
---Type <return> to continue, or q <return> to quit---

Thread 9 (Thread -1210463344 (LWP 1749)):
#0  0x002ba402 in __kernel_vsyscall ()
#1  0x0041b1c3 in poll () from /lib/libc.so.6
#2  0x00245bc0 in handle_packet (ap=0x8c651b8) at automount.c:883
#3  0x002473e7 in handle_mounts (arg=0x8c651b8) at automount.c:1519
#4  0x0070b46b in start_thread () from /lib/libpthread.so.0
#5  0x00424dbe in clone () from /lib/libc.so.6

Thread 8 (Thread -1224742000 (LWP 16771)):
#0  0x002ba402 in __kernel_vsyscall ()
#1  0x00711e2b in read () from /lib/libpthread.so.0
#2  0x0024ef62 in do_spawn (logopt=0, options=2, prog=0xb6ffab26 "/bin/mount",
     argv=0xb6ffaac0) at /usr/include/bits/unistd.h:35
#3  0x0024f6c9 in spawn_bind_mount (logopt=0) at spawn.c:400
#4  0x0051c6e4 in mount_mount (ap=0x8c64bc0, root=0x8c5eb80 "/home",
     name=0xb6ffae40 "octc", name_len=4,
     what=0x8cd05c0 "/disks/hyperion.0/home/octc", fstype=0x691d2d "bind",
     options=0x51f106 "defaults", context=0x18) at mount_bind.c:140
#5  0x0068bcd0 in mount_mount (ap=0x8c64bc0, root=0x8c5eb80 "/home",
     name=0xb6ffae40 "octc", name_len=4,
     what=0xb6ffae10 ":/disks/hyperion.0/home/octc", fstype=0x1379e4 "nfs",
     options=0x0, context=0x215280) at mount_nfs.c:225
#6  0x00128b85 in sun_mount (ap=0x8c64bc0, root=0x8c5eb80 "/home", 
---Type <return> to continue, or q <return> to quit---
     name=0xb6ffd108 "octc", namelen=4,
     loc=0x8cd0130 ":/disks/hyperion.0/home/octc", loclen=28,
     options=0x8ccfe80 "", ctxt=0x8c5e668) at parse_sun.c:638
#7  0x00129ebc in parse_mount (ap=0x8c64bc0, name=0xb6ffd108 "octc",
     name_len=4, mapent=0xb6ffd0a0 ":/disks/hyperion.0/home/octc",
     context=0x8c5e668) at parse_sun.c:1452
#8  0x00ce8c6c in lookup_mount (ap=0x8c64bc0, name=0xb7200680 "octc",
     name_len=4, context=0x8c5eb20) at lookup_yp.c:646
#9  0x00250d99 in do_lookup_mount (ap=0x8c64bc0, map=0x8c5e6b0,
     name=0xb7200680 "octc", name_len=4) at lookup.c:669
#10 0x00251f13 in lookup_nss_mount (ap=0x8c64bc0, source=0x0,
     name=0xb7200680 "octc", name_len=4) at lookup.c:731
#11 0x00249e9a in do_mount_indirect (arg=0xb7200620) at indirect.c:835
#12 0x0070b46b in start_thread () from /lib/libpthread.so.0
#13 0x00424dbe in clone () from /lib/libc.so.6

Thread 7 (Thread -1214665840 (LWP 16773)):
#0  0x002ba402 in __kernel_vsyscall ()
#1  0x00711e2b in read () from /lib/libpthread.so.0
#2  0x0024ef62 in do_spawn (logopt=0, options=0, prog=0xb7996bdd "/bin/mount",
     argv=0xb7996b60) at /usr/include/bits/unistd.h:35
#3  0x0024f8f5 in spawn_mount (logopt=0) at spawn.c:301
#4  0x0068bb4d in mount_mount (ap=0x8c651b8, root=0x8c65298 "/disks",
     name=0xb7996dd0 "hyperion.0", name_len=10, 
---Type <return> to continue, or q <return> to quit---
     what=0xb7996da0 "hyperion.spiretech.com:/disk/0", fstype=0x1379e4 "nfs",
     options=0xb7996df0 "udp,rsize=32768,wsize=32768", context=0x215280)
     at mount_nfs.c:259
#5  0x00128b85 in sun_mount (ap=0x8c651b8, root=0x8c65298 "/disks",
     name=0xb7999108 "hyperion.0", namelen=10,
     loc=0x8cd0420 "hyperion.spiretech.com:/disk/0", loclen=30,
     options=0x8cd00e0 "udp,rsize=32768,wsize=32768", ctxt=0x8c5db38)
     at parse_sun.c:638
#6  0x00129ebc in parse_mount (ap=0x8c651b8, name=0xb7999108 "hyperion.0",
     name_len=10,
     mapent=0xb7999080 "-udp,rsize=32768,wsize=32768 hyperion.spiretech.com:/disk/0", context=0x8c5db38) at parse_sun.c:1452
#7  0x00ce8c6c in lookup_mount (ap=0x8c651b8, name=0x8ccfb50 "hyperion.0",
     name_len=10, context=0x8c5db08) at lookup_yp.c:646
#8  0x00250d99 in do_lookup_mount (ap=0x8c651b8, map=0x8c5dac0,
     name=0x8ccfb50 "hyperion.0", name_len=10) at lookup.c:669
#9  0x00251f13 in lookup_nss_mount (ap=0x8c651b8, source=0x0,
     name=0x8ccfb50 "hyperion.0", name_len=10) at lookup.c:731
#10 0x00249e9a in do_mount_indirect (arg=0x8ccfaf0) at indirect.c:835
#11 0x0070b46b in start_thread () from /lib/libpthread.so.0
#12 0x00424dbe in clone () from /lib/libc.so.6

Thread 6 (Thread -1216767088 (LWP 16774)):
#0  0x002ba402 in __kernel_vsyscall ()
---Type <return> to continue, or q <return> to quit---
#1  0x00711e2b in read () from /lib/libpthread.so.0
#2  0x0024ef62 in do_spawn (logopt=0, options=2, prog=0xb7795b26 "/bin/mount",
     argv=0xb7795ac0) at /usr/include/bits/unistd.h:35
#3  0x0024f6c9 in spawn_bind_mount (logopt=0) at spawn.c:400
#4  0x0051c6e4 in mount_mount (ap=0x8c64bc0, root=0x8c5eb80 "/home",
     name=0xb7795e40 "shipper", name_len=7,
     what=0x8cd03a0 "/disks/hyperion.0/home/shipper", fstype=0x691d2d "bind",
     options=0x51f106 "defaults", context=0x18) at mount_bind.c:140
#5  0x0068bcd0 in mount_mount (ap=0x8c64bc0, root=0x8c5eb80 "/home",
     name=0xb7795e40 "shipper", name_len=7,
     what=0xb7795e10 ":/disks/hyperion.0/home/shipper", fstype=0x1379e4 "nfs",
     options=0x0, context=0x215280) at mount_nfs.c:225
#6  0x00128b85 in sun_mount (ap=0x8c64bc0, root=0x8c5eb80 "/home",
     name=0xb7798108 "shipper", namelen=7,
     loc=0x8cb3d30 ":/disks/hyperion.0/home/shipper", loclen=31,
     options=0x8c6a508 "", ctxt=0x8c5e668) at parse_sun.c:638
#7  0x00129ebc in parse_mount (ap=0x8c64bc0, name=0xb7798108 "shipper",
     name_len=7, mapent=0xb77980a0 ":/disks/hyperion.0/home/shipper",
     context=0x8c5e668) at parse_sun.c:1452
#8  0x00ce8c6c in lookup_mount (ap=0x8c64bc0, name=0xb7200b40 "shipper",
     name_len=7, context=0x8c5eb20) at lookup_yp.c:646
#9  0x00250d99 in do_lookup_mount (ap=0x8c64bc0, map=0x8c5e6b0,
     name=0xb7200b40 "shipper", name_len=7) at lookup.c:669
#10 0x00251f13 in lookup_nss_mount (ap=0x8c64bc0, source=0x0, 
---Type <return> to continue, or q <return> to quit---
     name=0xb7200b40 "shipper", name_len=7) at lookup.c:731
#11 0x00249e9a in do_mount_indirect (arg=0xb7200ae0) at indirect.c:835
#12 0x0070b46b in start_thread () from /lib/libpthread.so.0
#13 0x00424dbe in clone () from /lib/libc.so.6

Thread 5 (Thread -1218868336 (LWP 18488)):
#0  0x002ba402 in __kernel_vsyscall ()
#1  0x0041d219 in ioctl () from /lib/libc.so.6
#2  0x00248743 in expire_indirect (ap=0x8c651b8, ioctlfd=15,
     path=<value optimized out>, when=0) at indirect.c:341
#3  0x0024947b in expire_proc_indirect (arg=0x8cd08a0) at indirect.c:459
#4  0x0070b46b in start_thread () from /lib/libpthread.so.0
#5  0x00424dbe in clone () from /lib/libc.so.6

Thread 4 (Thread -1222640752 (LWP 20962)):
#0  0x002ba402 in __kernel_vsyscall ()
#1  0x00711e2b in read () from /lib/libpthread.so.0
#2  0x0024ef62 in do_spawn (logopt=0, options=2, prog=0xb71fbb26 "/bin/mount",
     argv=0xb71fbac0) at /usr/include/bits/unistd.h:35
#3  0x0024f6c9 in spawn_bind_mount (logopt=0) at spawn.c:400
#4  0x0051c6e4 in mount_mount (ap=0x8c64bc0, root=0x8c5eb80 "/home",
     name=0xb71fbe40 "hemphill", name_len=8,
     what=0x8cd0750 "/disks/hyperion.0/home/hemphill", fstype=0x691d2d "bind",
     options=0x51f106 "defaults", context=0x18) at mount_bind.c:140
---Type <return> to continue, or q <return> to quit---
#5  0x0068bcd0 in mount_mount (ap=0x8c64bc0, root=0x8c5eb80 "/home",
     name=0xb71fbe40 "hemphill", name_len=8,
     what=0xb71fbe10 ":/disks/hyperion.0/home/hemphill", fstype=0x1379e4 "nfs",
     options=0x0, context=0x215280) at mount_nfs.c:225
#6  0x00128b85 in sun_mount (ap=0x8c64bc0, root=0x8c5eb80 "/home",
     name=0xb71fe108 "hemphill", namelen=8,
     loc=0x8cd0700 ":/disks/hyperion.0/home/hemphill", loclen=32,
     options=0x8ccda20 "", ctxt=0x8c5e668) at parse_sun.c:638
#7  0x00129ebc in parse_mount (ap=0x8c64bc0, name=0xb71fe108 "hemphill",
     name_len=8, mapent=0xb71fe0a0 ":/disks/hyperion.0/home/hemphill",
     context=0x8c5e668) at parse_sun.c:1452
#8  0x00ce8c6c in lookup_mount (ap=0x8c64bc0, name=0xb7200cc0 "hemphill",
     name_len=8, context=0x8c5eb20) at lookup_yp.c:646
#9  0x00250d99 in do_lookup_mount (ap=0x8c64bc0, map=0x8c5e6b0,
     name=0xb7200cc0 "hemphill", name_len=8) at lookup.c:669
#10 0x00251f13 in lookup_nss_mount (ap=0x8c64bc0, source=0x0,
     name=0xb7200cc0 "hemphill", name_len=8) at lookup.c:731
#11 0x00249e9a in do_mount_indirect (arg=0xb7200c60) at indirect.c:835
#12 0x0070b46b in start_thread () from /lib/libpthread.so.0
#13 0x00424dbe in clone () from /lib/libc.so.6

Thread 3 (Thread -1212564592 (LWP 21864)):
#0  0x002ba402 in __kernel_vsyscall ()
#1  0x00711e2b in read () from /lib/libpthread.so.0
---Type <return> to continue, or q <return> to quit---
#2  0x0024ef62 in do_spawn (logopt=0, options=2, prog=0xb7b97b26 "/bin/mount",
     argv=0xb7b97ac0) at /usr/include/bits/unistd.h:35
#3  0x0024f6c9 in spawn_bind_mount (logopt=0) at spawn.c:400
#4  0x0051c6e4 in mount_mount (ap=0x8c64bc0, root=0x8c5eb80 "/home",
     name=0xb7b97e40 "havelkaj", name_len=8,
     what=0x8cd0b50 "/disks/hyperion.0/home/havelkaj", fstype=0x691d2d "bind",
     options=0x51f106 "defaults", context=0x18) at mount_bind.c:140
#5  0x0068bcd0 in mount_mount (ap=0x8c64bc0, root=0x8c5eb80 "/home",
     name=0xb7b97e40 "havelkaj", name_len=8,
     what=0xb7b97e10 ":/disks/hyperion.0/home/havelkaj", fstype=0x1379e4 "nfs",
     options=0x0, context=0x215280) at mount_nfs.c:225
#6  0x00128b85 in sun_mount (ap=0x8c64bc0, root=0x8c5eb80 "/home",
     name=0xb7b9a108 "havelkaj", namelen=8,
     loc=0x8cd0728 ":/disks/hyperion.0/home/havelkaj", loclen=32,
     options=0x8c6a0a0 "", ctxt=0x8c5e668) at parse_sun.c:638
#7  0x00129ebc in parse_mount (ap=0x8c64bc0, name=0xb7b9a108 "havelkaj",
     name_len=8, mapent=0xb7b9a0a0 ":/disks/hyperion.0/home/havelkaj",
     context=0x8c5e668) at parse_sun.c:1452
#8  0x00ce8c6c in lookup_mount (ap=0x8c64bc0, name=0xb7200e40 "havelkaj",
     name_len=8, context=0x8c5eb20) at lookup_yp.c:646
#9  0x00250d99 in do_lookup_mount (ap=0x8c64bc0, map=0x8c5e6b0,
     name=0xb7200e40 "havelkaj", name_len=8) at lookup.c:669
#10 0x00251f13 in lookup_nss_mount (ap=0x8c64bc0, source=0x0,
     name=0xb7200e40 "havelkaj", name_len=8) at lookup.c:731
---Type <return> to continue, or q <return> to quit---
#11 0x00249e9a in do_mount_indirect (arg=0xb7200de0) at indirect.c:835
#12 0x0070b46b in start_thread () from /lib/libpthread.so.0
#13 0x00424dbe in clone () from /lib/libc.so.6

Thread 2 (Thread -1228944496 (LWP 23135)):
#0  0x002ba402 in __kernel_vsyscall ()
#1  0x00711e2b in read () from /lib/libpthread.so.0
#2  0x0024ef62 in do_spawn (logopt=0, options=2, prog=0xb6bf8af6 "/bin/mount",
     argv=0xb6bf8a90) at /usr/include/bits/unistd.h:35
#3  0x0024f6c9 in spawn_bind_mount (logopt=0) at spawn.c:400
#4  0x0051c6e4 in mount_mount (ap=0x8c64bc0, root=0x8c5eb80 "/home",
     name=0xb6bf8e20 "jason_not", name_len=9,
     what=0x8cd0bc8 "/disks/hyperion.0/home/jason_not", fstype=0x691d2d "bind",
     options=0x51f106 "defaults", context=0x18) at mount_bind.c:140
#5  0x0068bcd0 in mount_mount (ap=0x8c64bc0, root=0x8c5eb80 "/home",
     name=0xb6bf8e20 "jason_not", name_len=9,
     what=0xb6bf8de0 ":/disks/hyperion.0/home/jason_not",
     fstype=0x1379e4 "nfs", options=0x0, context=0x215280) at mount_nfs.c:225
#6  0x00128b85 in sun_mount (ap=0x8c64bc0, root=0x8c5eb80 "/home",
     name=0xb6bfb108 "jason_not", namelen=9,
     loc=0x8cd0b28 ":/disks/hyperion.0/home/jason_not", loclen=33,
     options=0x8c6b680 "", ctxt=0x8c5e668) at parse_sun.c:638
#7  0x00129ebc in parse_mount (ap=0x8c64bc0, name=0xb6bfb108 "jason_not",
     name_len=9, mapent=0xb6bfb090 ":/disks/hyperion.0/home/jason_not", 
---Type <return> to continue, or q <return> to quit---
     context=0x8c5e668) at parse_sun.c:1452
#8  0x00ce8c6c in lookup_mount (ap=0x8c64bc0, name=0xb7200fc0 "jason_not",
     name_len=9, context=0x8c5eb20) at lookup_yp.c:646
#9  0x00250d99 in do_lookup_mount (ap=0x8c64bc0, map=0x8c5e6b0,
     name=0xb7200fc0 "jason_not", name_len=9) at lookup.c:669
#10 0x00251f13 in lookup_nss_mount (ap=0x8c64bc0, source=0x0,
     name=0xb7200fc0 "jason_not", name_len=9) at lookup.c:731
#11 0x00249e9a in do_mount_indirect (arg=0xb7200f60) at indirect.c:835
#12 0x0070b46b in start_thread () from /lib/libpthread.so.0
#13 0x00424dbe in clone () from /lib/libc.so.6

Thread 1 (Thread -1208218944 (LWP 1741)):
#0  0x002ba402 in __kernel_vsyscall ()
#1  0x00712f7e in do_sigwait () from /lib/libpthread.so.0
#2  0x0071301f in sigwait () from /lib/libpthread.so.0
#3  0x00243e38 in statemachine (arg=<value optimized out>) at automount.c:1343
#4  0x002452e0 in main (argc=0, argv=0xbf9a5208) at automount.c:2064
#0  0x002ba402 in __kernel_vsyscall ()
(gdb) q
The program is running.  Quit anyway (and detach it)? (y or n) y
Detaching from program: /usr/sbin/automount, process 1741
[root@titan ~]# ps axf | grep auto
  1741 ?        Ssl  116:45 automount
16772 ?        S      0:00  \_ automount
16777 ?        S      0:00  \_ automount
20963 ?        S      0:00  \_ automount
21865 ?        S      0:00  \_ automount
23136 ?        S      0:00  \_ automount
25333 pts/0    S+     0:00                  \_ grep auto
[root@titan ~]# gdb -p 16772 /usr/sbin/automount
GNU gdb Red Hat Linux (6.5-37.el5_2.2rh)
Copyright (C) 2006 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i386-redhat-linux-gnu"...Using host libthread_db library "/lib/libthread_db.so.1".

Attaching to program: /usr/sbin/automount, process 16772
Loaded symbols for /usr/sbin/automount
Reading symbols from /lib/libpthread.so.0...done.
[Thread debugging using libthread_db enabled]
[New Thread -1224742000 (LWP 16772)]
Loaded symbols for /lib/libpthread.so.0
Reading symbols from /lib/libdl.so.2...done.
Loaded symbols for /lib/libdl.so.2
Reading symbols from /lib/libgcc_s.so.1...done.
Loaded symbols for /lib/libgcc_s.so.1
Reading symbols from /lib/libc.so.6...done.
Loaded symbols for /lib/libc.so.6
Reading symbols from /lib/ld-linux.so.2...done.
Loaded symbols for /lib/ld-linux.so.2
Reading symbols from /usr/lib/libxml2.so...done.
Loaded symbols for /usr/lib/libxml2.so
Reading symbols from /usr/lib/libz.so.1...done.
Loaded symbols for /usr/lib/libz.so.1
Reading symbols from /lib/libm.so.6...done.
Loaded symbols for /lib/libm.so.6
Reading symbols from /usr/lib/autofs/lookup_nis.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/lookup_yp.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/lookup_nis.so
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
Reading symbols from /lib/libnss_files.so.2...done.
Loaded symbols for /lib/libnss_files.so.2
Reading symbols from /lib/libnss_dns.so.2...done.
Loaded symbols for /lib/libnss_dns.so.2
Reading symbols from /lib/libresolv.so.2...done.
Loaded symbols for /lib/libresolv.so.2
Reading symbols from /lib/libnss_nis.so.2...done.
Loaded symbols for /lib/libnss_nis.so.2
0x002ba402 in __kernel_vsyscall ()
(gdb) thr a a bt

Thread 1 (Thread -1224742000 (LWP 16772)):
#0  0x002ba402 in __kernel_vsyscall ()
#1  0x00415b76 in access () from /lib/libc.so.6
#2  0x0024ee66 in do_spawn (logopt=0, options=<value optimized out>,
     prog=0xb6ffab26 "/bin/mount", argv=0xb6ffaac0) at spawn.c:156
#3  0x0024f6c9 in spawn_bind_mount (logopt=0) at spawn.c:400
#4  0x0051c6e4 in mount_mount (ap=0x8c64bc0, root=0x8c5eb80 "/home",
     name=0xb6ffae40 "octc", name_len=4,
     what=0x8cd05c0 "/disks/hyperion.0/home/octc", fstype=0x691d2d "bind",
     options=0x51f106 "defaults", context=0x18) at mount_bind.c:140
#5  0x0068bcd0 in mount_mount (ap=0x8c64bc0, root=0x8c5eb80 "/home",
     name=0xb6ffae40 "octc", name_len=4,
     what=0xb6ffae10 ":/disks/hyperion.0/home/octc", fstype=0x1379e4 "nfs",
     options=0x0, context=0x215280) at mount_nfs.c:225
#6  0x00128b85 in sun_mount (ap=0x8c64bc0, root=0x8c5eb80 "/home",
     name=0xb6ffd108 "octc", namelen=4,
     loc=0x8cd0130 ":/disks/hyperion.0/home/octc", loclen=28,
     options=0x8ccfe80 "", ctxt=0x8c5e668) at parse_sun.c:638
#7  0x00129ebc in parse_mount (ap=0x8c64bc0, name=0xb6ffd108 "octc",
     name_len=4, mapent=0xb6ffd0a0 ":/disks/hyperion.0/home/octc",
     context=0x8c5e668) at parse_sun.c:1452
#8  0x00ce8c6c in lookup_mount (ap=0x8c64bc0, name=0xb7200680 "octc",
     name_len=4, context=0x8c5eb20) at lookup_yp.c:646
---Type <return> to continue, or q <return> to quit---
#9  0x00250d99 in do_lookup_mount (ap=0x8c64bc0, map=0x8c5e6b0,
     name=0xb7200680 "octc", name_len=4) at lookup.c:669
#10 0x00251f13 in lookup_nss_mount (ap=0x8c64bc0, source=0x0,
     name=0xb7200680 "octc", name_len=4) at lookup.c:731
#11 0x00249e9a in do_mount_indirect (arg=0xb7200620) at indirect.c:835
#12 0x0070b46b in start_thread () from /lib/libpthread.so.0
#13 0x00424dbe in clone () from /lib/libc.so.6
#0  0x002ba402 in __kernel_vsyscall ()
(gdb) q
The program is running.  Quit anyway (and detach it)? (y or n) y
Detaching from program: /usr/sbin/automount, process 16772
[root@titan ~]# ps axf | grep auto
  1741 ?        Ssl  116:46 automount
16777 ?        S      0:00  \_ automount
20963 ?        S      0:00  \_ automount
21865 ?        S      0:00  \_ automount
23136 ?        S      0:00  \_ automount
25346 pts/0    S+     0:00                  \_ grep auto
[root@titan ~]# gdb -p 16777 /usr/sbin/automount
GNU gdb Red Hat Linux (6.5-37.el5_2.2rh)
Copyright (C) 2006 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i386-redhat-linux-gnu"...Using host libthread_db library "/lib/libthread_db.so.1".

Attaching to program: /usr/sbin/automount, process 16777
Loaded symbols for /usr/sbin/automount
Reading symbols from /lib/libpthread.so.0...done.
[Thread debugging using libthread_db enabled]
[New Thread -1216767088 (LWP 16777)]
Loaded symbols for /lib/libpthread.so.0
Reading symbols from /lib/libdl.so.2...done.
Loaded symbols for /lib/libdl.so.2
Reading symbols from /lib/libgcc_s.so.1...done.
Loaded symbols for /lib/libgcc_s.so.1
Reading symbols from /lib/libc.so.6...done.
Loaded symbols for /lib/libc.so.6
Reading symbols from /lib/ld-linux.so.2...done.
Loaded symbols for /lib/ld-linux.so.2
Reading symbols from /usr/lib/libxml2.so...done.
Loaded symbols for /usr/lib/libxml2.so
Reading symbols from /usr/lib/libz.so.1...done.
Loaded symbols for /usr/lib/libz.so.1
Reading symbols from /lib/libm.so.6...done.
Loaded symbols for /lib/libm.so.6
Reading symbols from /usr/lib/autofs/lookup_nis.so...Reading symbols from /usr/lib/debug/usr/lib/autofs/lookup_yp.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/lookup_nis.so
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
Reading symbols from /lib/libnss_files.so.2...done.
Loaded symbols for /lib/libnss_files.so.2
Reading symbols from /lib/libnss_dns.so.2...done.
Loaded symbols for /lib/libnss_dns.so.2
Reading symbols from /lib/libresolv.so.2...done.
Loaded symbols for /lib/libresolv.so.2
Reading symbols from /lib/libnss_nis.so.2...done.
Loaded symbols for /lib/libnss_nis.so.2
0x002ba402 in __kernel_vsyscall ()
(gdb) thr a a bt

Thread 1 (Thread -1216767088 (LWP 16777)):
#0  0x002ba402 in __kernel_vsyscall ()
#1  0x00415b76 in access () from /lib/libc.so.6
#2  0x0024ee66 in do_spawn (logopt=0, options=<value optimized out>,
     prog=0xb7795b26 "/bin/mount", argv=0xb7795ac0) at spawn.c:156
#3  0x0024f6c9 in spawn_bind_mount (logopt=0) at spawn.c:400
#4  0x0051c6e4 in mount_mount (ap=0x8c64bc0, root=0x8c5eb80 "/home",
     name=0xb7795e40 "shipper", name_len=7,
     what=0x8cd03a0 "/disks/hyperion.0/home/shipper", fstype=0x691d2d "bind",
     options=0x51f106 "defaults", context=0x18) at mount_bind.c:140
#5  0x0068bcd0 in mount_mount (ap=0x8c64bc0, root=0x8c5eb80 "/home",
     name=0xb7795e40 "shipper", name_len=7,
     what=0xb7795e10 ":/disks/hyperion.0/home/shipper", fstype=0x1379e4 "nfs",
     options=0x0, context=0x215280) at mount_nfs.c:225
#6  0x00128b85 in sun_mount (ap=0x8c64bc0, root=0x8c5eb80 "/home",
     name=0xb7798108 "shipper", namelen=7,
     loc=0x8cb3d30 ":/disks/hyperion.0/home/shipper", loclen=31,
     options=0x8c6a508 "", ctxt=0x8c5e668) at parse_sun.c:638
#7  0x00129ebc in parse_mount (ap=0x8c64bc0, name=0xb7798108 "shipper",
     name_len=7, mapent=0xb77980a0 ":/disks/hyperion.0/home/shipper",
     context=0x8c5e668) at parse_sun.c:1452
#8  0x00ce8c6c in lookup_mount (ap=0x8c64bc0, name=0xb7200b40 "shipper",
     name_len=7, context=0x8c5eb20) at lookup_yp.c:646
---Type <return> to continue, or q <return> to quit---
#9  0x00250d99 in do_lookup_mount (ap=0x8c64bc0, map=0x8c5e6b0,
     name=0xb7200b40 "shipper", name_len=7) at lookup.c:669
#10 0x00251f13 in lookup_nss_mount (ap=0x8c64bc0, source=0x0,
     name=0xb7200b40 "shipper", name_len=7) at lookup.c:731
#11 0x00249e9a in do_mount_indirect (arg=0xb7200ae0) at indirect.c:835
#12 0x0070b46b in start_thread () from /lib/libpthread.so.0
#13 0x00424dbe in clone () from /lib/libc.so.6
#0  0x002ba402 in __kernel_vsyscall ()
(gdb) q
The program is running.  Quit anyway (and detach it)? (y or n) y
Detaching from program: /usr/sbin/automount, process 16777
[root@titan ~]# ps axf | grep auto
  1741 ?        Ssl  116:46 automount
25359 pts/0    S+     0:00                  \_ grep auto
[root@titan ~]# 
Script done on Fri 22 Aug 2008 01:12:55 PM PDT
