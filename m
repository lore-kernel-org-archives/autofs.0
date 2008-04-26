From: jimc@math.ucla.edu (Jim Carter)
Subject: Re: clients suddenly start hanging (was: (no subject))
Date: Fri, 25 Apr 2008 18:17:27 -0700 (PDT)
Message-ID: <20080426011727.BBE6CF8E2B@serval.math.ucla.edu>
References: <20080423185018.122C53C3B1@xena.cft.ca.us>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x4963u8ibhf.fsf@segfault.boston.devel.redhat.com>
	(Jeff Moyer "Wed, 23 Apr 2008 16:04:44 -0400")
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
To: autofs@linux.kernel.org
Cc: Ian Kent <raven@themaw.net>

On Wed, 23 Apr 2008 16:04:44 -0400 Jeff Moyer writes:

> For starters, can you install the autofs debuginfo package and attach to
> the running automounter (when in a bad state) and get the output from:

> gdb> thr a a bt

> ?  That would be a great help.

SuSE does not save the debuginfo packages, unfortunately.  The source 
RPM is
http://download.opensuse.org/repositories/openSUSE:/10.3/standard/src/autofs-5.0.2-30.src.rpm

There is an update (autofs-5.0.2-30.2) in which the issue is a missing
dependency, so no code change is involved.  The included patches are:
Patch0:         autofs-5.0.2-add-krb5-include.patch
Patch1:         autofs-5.0.2-bad-proto-init.patch
Patch2:         autofs-5.0.2-add-missing-multi-support.patch
Patch3:         autofs-5.0.2-add-multi-nsswitch-lookup.patch
Patch10:        autofs-suse-auto_master_default.patch
Patch11:        autofs-suse-autofs_init.patch
Patch12:        autofs-5.0.1-mount_xdr_no_strict_aliasing.patch
Patch13:        autofs-5.0.2-use_local_cflags.patch
# UCLA-Mathnet non-hack: this file was in a previous source RPM but
# not in the current one (???)
# Patch14:        autofs-5.0.2-nested_mounts.patch
# UCLA-Mathnet hack: special patch from Ian Kent...
Patch15:	autofs-5.0.2-dns-name-lookup.patch

Configuration parameters are:
./configure %{_target_cpu}-suse-linux \
            --libdir=%{_libdir} --mandir=%{_mandir} \
            --disable-mount-locking \
            --enable-forced-shutdown \
            --with-hesiod=no

In the %build section I appended -g to this line:
make all STRIP=: LOCAL_CFLAGS="$RPM_OPT_FLAGS %(getconf LFS_CFLAGS) -g"

(I assume STRIP=: turns stripping into a no-op; we'll see what it does...)

Wrote: /usr/src/packages/RPMS/i586/autofs-5.0.2-30.4.i586.rpm
Wrote: /usr/src/packages/RPMS/i586/autofs-debuginfo-5.0.2-30.4.i586.rpm
nm BUILD/autofs-5.0.2/daemon/automount: no symbols, hiss, boo!

Each shared library (plugin) and the main program is individually [not]
stripped with the command ": automount" etc., so the symbols should not
have been lost.  If you can give me a clue how to preserve the symbols
with the main automount binary I'll try this again.  Anyway, here's the 
result, in which at least some symbols are useable.  


This debug command line was used in the test script when it started up
and when a checking process was seen to hang.
gdb /usr/sbin/automount $PID
gdb> thread apply all backtrace

In the interest of not running recipients over their mail quota I've
deleted repetitive information.  If I've mistakenly removed something
important I still have the original data.

14:08:23 --                   #1, chkd 0, run 0, OK 561, mtd 55, of 561

=----- gdb backtrace of all threads -----
GNU gdb 6.6.50.20070726-cvs
Copyright (C) 2007 Free Software Foundation, Inc.
-- snip --
This GDB was configured as "i586-suse-linux"...
(no debugging symbols found)
Using host libthread_db library "/lib/libthread_db.so.1".
Attaching to program: /usr/sbin/automount, process 15494
(no debugging symbols found)
Loaded symbols for /usr/sbin/automount
Reading symbols from /lib/libpthread.so.0...(no debugging symbols found)...done.
[Thread debugging using libthread_db enabled]
[New Thread 0xb7dfa6c0 (LWP 15494)]
[New Thread 0x92dcdb90 (LWP 16660)]
[New Thread 0x935ceb90 (LWP 16644)]
-- snip --
[New Thread 0xb621eb90 (LWP 16083)]
[New Thread 0xb6a1fb90 (LWP 16077)]
[New Thread 0xb7239b90 (LWP 16068)]
[New Thread 0xb7a3ab90 (LWP 16063)]
[New Thread 0xb7c90b90 (LWP 16061)]
[New Thread 0xb7de8b90 (LWP 15499)]
[New Thread 0xb7df9b90 (LWP 15496)]
[New Thread 0xb7f67b90 (LWP 15495)]
Loaded symbols for /lib/libpthread.so.0
Reading symbols from /lib/libdl.so.2...(no debugging symbols found)...done.
-- snip -- if you need to know which libraries did and didn't have
	debugging symbols I can send this info.

0xffffe410 in __kernel_vsyscall ()
(gdb) (gdb) 
Thread 78 (Thread 0xb7f67b90 (LWP 15495)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f3b7ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib/libpthread.so.0
#2  0x8001e0a3 in ?? () from /usr/sbin/automount
#3  0x80031560 in ?? () from /usr/sbin/automount
#4  0x80031540 in ?? () from /usr/sbin/automount
#5  0xb7f673b4 in ?? ()
#6  0xb7f755df in ?? () from /lib/ld-linux.so.2
#7  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#8  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 77 (Thread 0xb7df9b90 (LWP 15496)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f3b7ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib/libpthread.so.0
#2  0x80017968 in ?? () from /usr/sbin/automount
#3  0x800314c0 in ?? () from /usr/sbin/automount
#4  0x800314a0 in ?? () from /usr/sbin/automount
#5  0xb7df93b4 in ?? ()
#6  0x00000000 in ?? ()

Thread 76 (Thread 0xb7de8b90 (LWP 15499)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 75 (Thread 0xb7c90b90 (LWP 16061)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

-- snip -- 65 threads omitted, identical backtrace addresses.

Thread 10 (Thread 0x96dd5b90 (LWP 16544)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 9 (Thread 0x965d4b90 (LWP 16550)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 8 (Thread 0x95dd3b90 (LWP 16560)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 7 (Thread 0x955d2b90 (LWP 16586)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 6 (Thread 0x94dd1b90 (LWP 16604)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 5 (Thread 0x945d0b90 (LWP 16622)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 4 (Thread 0x93dcfb90 (LWP 16638)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 3 (Thread 0x935ceb90 (LWP 16644)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 2 (Thread 0x92dcdb90 (LWP 16660)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 1 (Thread 0xb7dfa6c0 (LWP 15494)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f3f2aa in do_sigwait () from /lib/libpthread.so.0
#2  0xb7f3f34f in sigwait () from /lib/libpthread.so.0
#3  0x80007ad9 in main () from /usr/sbin/automount
#0  0xffffe410 in __kernel_vsyscall ()
(gdb) The program is running.  Quit anyway (and detach it)? (y or n) [answered Y; input not from terminal]
Detaching from program: /usr/sbin/automount, process 15494
=----- end of backtrace -----
14:09:47 /net/zuma/h4         mtab: <=> mounts: /net/bamboo03/h1 
-- A mount point was in /proc/mounts but not in mtab.  This situation
	was rectified very quickly, before the next check. --
14:10:34 --                   #2, chkd 506, run 0, OK 211, mtd 211, of 211

14:10:34 --                   #3, chkd 506, run 0, OK 211, mtd 211, of 211

14:19:31 /net/riemann/m1      mtab: /net/riemann/m1 <=> mounts: 
14:20:58 --                   #266, chkd 630, run 0, OK 199, mtd 197, of 199

14:27:51 --                   #464, chkd 700, run 0, OK 199, mtd 198, of 199

14:36:50 /net/bamboo11/m2     failed
-- "failed" means the checking process read zero entries from the 
	mount point directory, taking less than 25 secs (typically 
	10 secs) to do so. --
14:36:50 /net/bamboo11/m1     failed
14:37:22 /net/bamboo39/m1     mtab: /net/bamboo39/h1 <=> mounts: 
14:37:22 --                   #743, chkd 750, run 0, OK 197, mtd 197, of 199

14:37:58 /net/quantum/h1      failed
14:38:03 /net/hollyfs/m1      failed
14:38:13 /net/tulare/m1       failed
14:38:31 --                   #772, chkd 800, run 0, OK 194, mtd 189, of 199

14:39:02 /net/cedar/h2        mtab: /net/sumac/h1 <=> mounts: 
14:39:02 /net/yermo/h1        mtab: /net/sumac/s2 <=> mounts: 
14:39:02 /net/cedar/m1        mtab: /net/sumac/s3 <=> mounts: 
14:39:06 /net/sumac/s2        failed
14:39:06 /net/sumac/h1        mtab: /net/sumac/s1 <=> mounts: 
14:39:06 /net/sumac/h1        failed
14:39:06 /net/sumac/m1        failed
-- Note that all the Sumac filesystems failed together.  This can also
	be seen on other hosts that export several filesystems. --
14:44:10 /net/athletics/m1    failed
14:44:10 --                   #924, chkd 850, run 0, OK 190, mtd 186, of 199

14:44:12 /net/papyrus19/m1    mtab: /net/sassafras/m3 <=> mounts: 
14:44:38 /net/palmdale/m1     failed
14:44:43 /net/bamboo33/m1     mtab: /net/bamboo33/m1 <=> mounts: 
14:45:21 --                   #954, chkd 903, run 0, OK 189, mtd 188, of 199

14:54:09 /net/buellton/m1     failed
14:54:35 /net/bamboo17/m1     mtab: /net/bamboo17/m1 <=> mounts: 
14:55:00 /net/papyrus/h1      failed
14:55:01 /net/papyrus/m1      failed
14:55:12 /net/arachne/h1      failed
14:55:25 /net/puppis/m1       mtab: /net/heston/m1 <=> mounts: 
14:55:30 /net/merced/m1       failed
14:55:32 --                   #1248, chkd 1001, run 0, OK 184, mtd 183, of 199
-- At this point nothing is wrong (except the "failures") but the 
	script did a backtrace because it felt like it (every 1000 
	checks).  It has been removed for lack of interest, but I 
	still have it in the original data. --

14:56:01 /net/trejo/m1        mtab: /net/trejo/m1 <=> mounts: 
15:01:23 /net/redlands/m1     failed
15:01:59 /net/bamboo35/m1     failed
15:01:59 /net/bamboo35/m2     failed
15:02:04 /net/bamboo32/m1     failed
15:02:04 /net/bamboo32/m2     failed
15:02:07 --                   #1422, chkd 1103, run 0, OK 179, mtd 176, of 199

15:02:21 /net/bamboo45/m2     mtab: /net/bamboo45/m2 <=> mounts: 
15:02:26 /net/bamboo07/m1     mtab: /net/bamboo07/m1 <=> mounts: 
15:03:25 /net/rangers/m1      failed
15:11:56 --                   #1694, chkd 1200, run 0, OK 178, mtd 177, of 199

15:12:10 /net/carson/m1       failed
15:12:52 /net/cedar/s3        failed
15:13:21 /net/cedar/h1        hung
15:13:21 /net/cedar/m1        hung
15:13:21 /net/cedar/h2        hung
15:13:21 /net/cedar/s1        hung
-- Oooo, the first serious error, and again all of a server's 
	filesystems got horked at the same time.  In other test
	runs the first hang occurs on workstations -- the presence
	of multiple filesystems I think is not a risk factor.
15:13:21 --                   #1707, chkd 1248, run 4, OK 172, mtd 165, of 199

=----- gdb backtrace of all threads -----
[?1034hGNU gdb 6.6.50.20070726-cvs
Copyright (C) 2007 Free Software Foundation, Inc.
-- snip -- identical to startup chatter from the first gdb run.
[Thread debugging using libthread_db enabled]
[New Thread 0xb7dfa6c0 (LWP 15494)]
[New Thread 0xb0010b90 (LWP 26490)]
-- snip --
[New Thread 0xb7de8b90 (LWP 15499)]
[New Thread 0xb7df9b90 (LWP 15496)]
[New Thread 0xb7f67b90 (LWP 15495)]
Loaded symbols for /lib/libpthread.so.0
-- snip --
Loaded symbols for /lib/libgcc_s.so.1

0xffffe410 in __kernel_vsyscall ()
(gdb) (gdb) 
-- I'm leaving all 96 threads in place even though there are a
	lot of duplications. --
Thread 96 (Thread 0xb7f67b90 (LWP 15495)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f3b7ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib/libpthread.so.0
#2  0x8001e0a3 in ?? () from /usr/sbin/automount
#3  0x80031560 in ?? () from /usr/sbin/automount
#4  0x80031540 in ?? () from /usr/sbin/automount
#5  0xb7f673b4 in ?? ()
#6  0xb7f755df in ?? () from /lib/ld-linux.so.2
#7  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#8  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 95 (Thread 0xb7df9b90 (LWP 15496)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f3b7ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib/libpthread.so.0
#2  0x800179c9 in ?? () from /usr/sbin/automount
#3  0x800314c0 in ?? () from /usr/sbin/automount
#4  0x800314a0 in ?? () from /usr/sbin/automount
#5  0xb7df93b4 in ?? ()
#6  0x00000000 in ?? ()

Thread 94 (Thread 0xb7de8b90 (LWP 15499)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 93 (Thread 0xb7c90b90 (LWP 16061)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 92 (Thread 0xb5a1db90 (LWP 16089)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 91 (Thread 0xb521cb90 (LWP 16095)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 90 (Thread 0xb3a19b90 (LWP 16117)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 89 (Thread 0xb2916b90 (LWP 16127)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 88 (Thread 0xb2014b90 (LWP 16141)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 87 (Thread 0xb1813b90 (LWP 16147)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 86 (Thread 0xb1012b90 (LWP 16153)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 85 (Thread 0xaf00eb90 (LWP 16177)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 84 (Thread 0xae80db90 (LWP 16183)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 83 (Thread 0xad80bb90 (LWP 16195)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 82 (Thread 0xad00ab90 (LWP 16201)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 81 (Thread 0xab807b90 (LWP 16225)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 80 (Thread 0xab006b90 (LWP 16231)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 79 (Thread 0xaa805b90 (LWP 16237)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 78 (Thread 0xaa004b90 (LWP 16243)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 77 (Thread 0xa9803b90 (LWP 16249)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 76 (Thread 0xa8700b90 (LWP 16259)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 75 (Thread 0xa65fbb90 (LWP 16281)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 74 (Thread 0xa55f9b90 (LWP 16297)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 73 (Thread 0xa23f1b90 (LWP 16349)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 72 (Thread 0xa1bf0b90 (LWP 16355)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 71 (Thread 0x9d7e4b90 (LWP 16408)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 70 (Thread 0x9cfe3b90 (LWP 16426)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 69 (Thread 0x9c6e1b90 (LWP 16438)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 68 (Thread 0x9b5deb90 (LWP 16448)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 67 (Thread 0x9adddb90 (LWP 16454)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 66 (Thread 0x9a5dcb90 (LWP 16460)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 65 (Thread 0x975d6b90 (LWP 16538)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 64 (Thread 0x955d2b90 (LWP 16586)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 63 (Thread 0x92dcdb90 (LWP 16660)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 62 (Thread 0x90ac6b90 (LWP 17004)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 61 (Thread 0x8eac2b90 (LWP 17050)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 60 (Thread 0x8e2c1b90 (LWP 17056)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 59 (Thread 0x8dac0b90 (LWP 17070)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 58 (Thread 0x8babcb90 (LWP 17116)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 57 (Thread 0x8b2bbb90 (LWP 17138)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 56 (Thread 0x8a2b9b90 (LWP 17166)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 55 (Thread 0x89ab8b90 (LWP 17204)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 54 (Thread 0x88ab6b90 (LWP 17239)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 53 (Thread 0x86ab2b90 (LWP 17277)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 52 (Thread 0x862b1b90 (LWP 17337)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 51 (Thread 0x832abb90 (LWP 17447)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 50 (Thread 0x80aa6b90 (LWP 17698)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 49 (Thread 0x7f7feb90 (LWP 17739)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 48 (Thread 0x7e7fcb90 (LWP 17788)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 47 (Thread 0x7dffbb90 (LWP 17905)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 46 (Thread 0x7d7fab90 (LWP 17919)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 45 (Thread 0x7cff9b90 (LWP 17929)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 44 (Thread 0x7b7f6b90 (LWP 18026)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 43 (Thread 0x7aff5b90 (LWP 18045)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 42 (Thread 0xb6a1fb90 (LWP 20046)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 41 (Thread 0x93dcfb90 (LWP 21483)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 40 (Thread 0xa7effb90 (LWP 21561)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 39 (Thread 0xb621eb90 (LWP 21597)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 38 (Thread 0x852afb90 (LWP 21613)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 37 (Thread 0x995dab90 (LWP 21719)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 36 (Thread 0x922c9b90 (LWP 21980)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 35 (Thread 0x8c2bdb90 (LWP 22000)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 34 (Thread 0xb4a1bb90 (LWP 22017)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 33 (Thread 0x7a7f4b90 (LWP 22414)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 32 (Thread 0x81aa8b90 (LWP 22559)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 31 (Thread 0x85ab0b90 (LWP 23467)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 30 (Thread 0x95dd3b90 (LWP 23509)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 29 (Thread 0x96dd5b90 (LWP 23551)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 28 (Thread 0x985d8b90 (LWP 23694)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 27 (Thread 0xae00cb90 (LWP 23820)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 26 (Thread 0xa43f5b90 (LWP 24050)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 25 (Thread 0x94dd1b90 (LWP 24060)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 24 (Thread 0x8d2bfb90 (LWP 24066)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 23 (Thread 0xb7239b90 (LWP 24076)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 22 (Thread 0x78ff1b90 (LWP 24816)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 21 (Thread 0x7effdb90 (LWP 24947)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 20 (Thread 0x812a7b90 (LWP 24977)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 19 (Thread 0x84aaeb90 (LWP 25018)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 18 (Thread 0x965d4b90 (LWP 25239)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 17 (Thread 0xac008b90 (LWP 25383)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 16 (Thread 0xa6dfcb90 (LWP 25389)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 15 (Thread 0x7bff7b90 (LWP 25488)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 14 (Thread 0x822a9b90 (LWP 25519)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 13 (Thread 0xa4df8b90 (LWP 25580)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f3e846 in nanosleep () from /lib/libpthread.so.0
#2  0x8000b8ef in ?? () from /usr/sbin/automount
#3  0xa4df8260 in ?? ()
#4  0x00000000 in ?? ()

Thread 12 (Thread 0x7ffffb90 (LWP 25956)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 11 (Thread 0x99ddbb90 (LWP 25975)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 10 (Thread 0xb421ab90 (LWP 26033)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 9 (Thread 0x902c5b90 (LWP 26087)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 8 (Thread 0xaf80fb90 (LWP 26253)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 7 (Thread 0x912c7b90 (LWP 26395)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 6 (Thread 0x9e8e7b90 (LWP 26416)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 5 (Thread 0xb7a3ab90 (LWP 26431)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 4 (Thread 0x9f0e8b90 (LWP 26446)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 3 (Thread 0xb3117b90 (LWP 26468)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 2 (Thread 0xb0010b90 (LWP 26490)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7eb4817 in poll () from /lib/libc.so.6
#2  0x8000931e in handle_mounts () from /usr/sbin/automount
#3  0xb7f37192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ebe02e in clone () from /lib/libc.so.6

Thread 1 (Thread 0xb7dfa6c0 (LWP 15494)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f3f2aa in do_sigwait () from /lib/libpthread.so.0
#2  0xb7f3f34f in sigwait () from /lib/libpthread.so.0
#3  0x80007ad9 in main () from /usr/sbin/automount
#0  0xffffe410 in __kernel_vsyscall ()
(gdb) The program is running.  Quit anyway (and detach it)? (y or n) [answered Y; input not from terminal]
Detaching from program: /usr/sbin/automount, process 15494
=----- end of backtrace -----
15:17:54 /net/bamboo04/m1     mtab: /net/bamboo04/m1 <=> mounts: 
15:18:03 /net/stockton/m1     mtab: /net/bamboo29/m2 <=> mounts: 
15:18:35 /net/bamboo23/m1     failed
15:19:00 /net/bamboo23/m2     hung
15:19:00 --                   #1859, chkd 1299, run 5, OK 170, mtd 150, of 199
=----- gdb backtrace of all threads -----
-- snip -- the rest of the record is assumed to duplicate what's
	above, but if not I can send it.  The rest of the testing
	is similar to what we've already seen.


James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 520 Portola Plaza; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
