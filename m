From: jimc@math.ucla.edu (Jim Carter)
Subject: Re: clients suddenly start hanging (was: (no subject))
Date: Thu, 19 Jun 2008 11:34:46 -0700 (PDT)
Message-ID: <20080619183446.532D82111B1@simba.math.ucla.edu>
References: <20080423185018.122C53C3B1@xena.cft.ca.us>
	<1213414942.18072.26.camel@raven.themaw.net>
	<1213845274.2971.11.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1213845274.2971.11.camel@raven.themaw.net>
	(Ian Kent "Thu, 19 Jun 2008 11:14:34 +0800")
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

This is with the module patches in the referenced message (versus kernel
2.6.22.17 from SuSE 10.3) and the following daemon patches:
autofs-5.0.2-dns-name-lookup.patch
autofs-5.0.3-dont-fail-on-empty-master-fix-2.patch
autofs-5.0.3-mount-thread-create-cond-handling.patch
autofs-5.0.3-mount-thread-create-cond-handling-fix.patch
autofs-5.0.3-dont-abuse-ap-ghost-field.patch
autofs-5.0.3-submount-shutdown-recovery-7.patch

I modified the test program to allow 120 secs (rather than 25 secs) to
mount a filesystem, so it would not trigger on the long delays seen the
previous time around.  The long delays may have been due to thrashing:
the test machine has 524 Mb physical memory, and the automount daemon
(counting all threads together) had a virtual memory size of 931 Mb. But
near the start of the test, zero swap was occupied, and only 32 Kb at
the end.  (No more than 50 Mb was shared, i.e. readonly libraries.
Likely lots of the material was copy-on-write that never needed to be
copied.)  Even so, when earlier I did some funky stuff in the test
program the machine got into a very sluggish state.  I should have
looked at swapping then, but didn't think of it.

I ran a test overnight, successfully doing 5164 mount/unmount cycles on
241 filesystems on about 110 machines.  This took about 5.75 hours.  
However, at that point there were two failure classes (plus some 
self-healing items earlier that the test program complained about).

/net/bamboo03/h1 No such file or directory -- seen once each on 6
	filesys. One machine had 3 affected filesys but one of its
	filesys was not affected.  Half an hour later the test program
	tried these filesys again and mounted them successfully then and
	subsequently.
/net/bamboo19/h1 hung -- 8 machines (in compute cluster), all 3 filesys
	per machine affected.  The test processes are waiting forever;
	the filesys was never mounted after this.  Neither could it be
	automounted by a separate process (ls /net/bamboo19/h1/.)  All
	occurred at the same time, after running 5 hr 47mins.  There is
	no indication on the servers themselves to pin the blame there
	-- they're exporting to other clients, not overloaded, etc.
/net/zuma/m1 still mounted after 1800 secs, state = success -- 216
	filesys got into a state where they were never unmounted. This
	is approximately all of them (at most 1 unaffected; it's hard to
	get the number exact at this point) except the hung ones. One
	isolated instance after 49 mins which self-healed to normal
	unmounting; "all" affected starting after 5 hr 53 mins, i.e.
	just after the hung filesys, and probably never unmounted after
	that.

When I came in this morning I ran gdb and got a backtrace.  Here are some
notes on the various threads:

Thread 31: /net/gauguin: this host hasn't been up for weeks. The test
program should have tested it once at startup, failed, and never tested
it again.  Nonetheless, from "ps" output I believe that this thread is
going to exit semi-normally -- I only see the 24 hung threads afterward.

Threads 9, 8, 7, 6, 5, 4, 3, 2:
The named hosts (bamboo19, bamboo30, etc.) are affected.  The map file
/etc/auto.net.generic contains one line:

*	${SERVER}:/&

Throughout all of this, there is no output whatsoever to syslog (debug
level) about autofs or NFS.

So I think we're making progress, but there's still likely a race
condition somewhere in there.  In the next set of tests I'll let the
test program do the backtrace as soon as it recognizes something hung.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 520 Portola Plaza; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)

The test log and backtrace follow:

20:51:29 --                   #1, chkd 0, run 0, OK 570, mtd 2, of 570

20:55:27 --                   #2, chkd 568, run 30, OK 244, mtd 244, of 570

20:57:27 --                   #3, chkd 568, run 30, OK 244, mtd 244, of 570

21:06:18 --                   #142, chkd 650, run 0, OK 244, mtd 244, of 570

21:06:27 /net/bamboo31/m1     mtab: /net/bamboo31/m1 <=> mounts: 
21:06:27 /net/bamboo31/h1     mtab: /net/bamboo31/m2 <=> mounts: 
21:06:48 /net/bamboo28/h1     mtab: /net/bamboo08/h1 <=> mounts: 
21:06:48 /net/bamboo08/h1     mtab: /net/bamboo08/m2 <=> mounts: 
21:06:56 /net/bamboo10/h1     mtab: /net/bamboo26/m1 <=> mounts: 
21:07:08 --                   #161, chkd 705, run 0, OK 244, mtd 241, of 570

21:08:48 /net/trejo/m1        mtab: /net/cedar/m1 <=> mounts: 
21:08:48 /net/cedar/m1        mtab: /net/cedar/h2 <=> mounts: 
21:08:54 --                   #204, chkd 800, run 0, OK 244, mtd 244, of 570

21:17:19 /net/daggett/h1      mtab: /net/daggett/h1 <=> mounts: 
21:24:35 --                   #666, chkd 850, run 0, OK 244, mtd 241, of 570

21:27:20 /net/bamboo03/h1     No such file or directory
21:27:20 /net/bamboo03/h1     failed
21:27:22 /net/bamboo06/m1     mtab: /net/allmans/m1 <=> mounts: 
21:27:24 --                   #679, chkd 971, run 0, OK 243, mtd 234, of 570

21:29:44 --                   #681, chkd 1057, run 0, OK 243, mtd 243, of 570

21:40:37 /net/julia/h1        still mounted after 1800 secs, state = success
21:44:07 /net/sassafras/h1    mtab: /net/sassafras/h1 <=> mounts: 
21:44:07 /net/sassafras/m3    mtab: /net/sassafras/h2 <=> mounts: 
21:46:24 /net/bamboo23/m2     mtab: /net/bamboo06/h1 <=> mounts: 
21:46:24 /net/sandimas/m1     mtab: /net/bamboo06/m2 <=> mounts: 
21:46:27 /net/pacifica/m1     mtab: /net/bamboo34/m2 <=> mounts: /net/bamboo29/m2 
21:46:28 /net/bamboo02/m2     mtab: /net/bamboo34/h1 <=> mounts: 
21:46:34 /net/bamboo37/m1     mtab: /net/bamboo04/h1 <=> mounts: 
21:48:35 --                   #993, chkd 1191, run 0, OK 243, mtd 147, of 570

21:50:55 --                   #994, chkd 1287, run 0, OK 243, mtd 220, of 570

21:56:33 /net/bamboo43/h1     mtab: /net/bamboo43/m2 <=> mounts: 
21:58:38 /net/bamboo03/h1     revived
21:58:38 /net/bamboo03/h1     revived
22:00:39 --                   #1159, chkd 1363, run 0, OK 244, mtd 244, of 570

22:05:09 /net/bamboo24/m2     mtab: /net/bamboo47/m1 <=> mounts: 
22:05:17 /net/bamboo27/m2     mtab: /net/bamboo09/h1 <=> mounts: 
22:10:06 --                   #1308, chkd 1513, run 0, OK 244, mtd 200, of 570

22:18:34 --                   #1428, chkd 1655, run 0, OK 244, mtd 201, of 570

22:29:30 --                   #1568, chkd 1752, run 0, OK 244, mtd 187, of 570

22:36:09 /net/bamboo11/m1     mtab: /net/bamboo42/m2 <=> mounts: 
22:36:09 /net/bamboo17/m2     mtab: /net/bamboo42/m1 <=> mounts: 
22:36:21 /net/bamboo34/m2     mtab: <=> mounts: /net/bamboo20/m1 
22:38:22 --                   #1700, chkd 1894, run 0, OK 244, mtd 191, of 570

22:38:30 /net/holly02/h1      mtab: <=> mounts: /net/bamboo05/m2 
22:45:42 --                   #1914, chkd 1950, run 0, OK 244, mtd 241, of 570

22:47:56 /net/bamboo30/h1     mtab: /net/sumac/s1 <=> mounts: 
22:50:10 --                   #1920, chkd 2035, run 0, OK 244, mtd 223, of 570

22:58:42 --                   #2043, chkd 2173, run 0, OK 244, mtd 213, of 570

23:04:47 /net/bamboo37/h1     mtab: /net/bamboo05/m1 <=> mounts: 
23:04:55 /net/bamboo05/m2     mtab: /net/bamboo42/m2 <=> mounts: 
23:09:04 --                   #2225, chkd 2266, run 0, OK 244, mtd 189, of 570

23:14:31 --                   #2379, chkd 2353, run 0, OK 244, mtd 238, of 570

23:19:11 --                   #2389, chkd 2467, run 0, OK 244, mtd 244, of 570

23:24:45 /net/bamboo09/m2     mtab: /net/godzilla/m1 <=> mounts: 
23:26:49 /net/holly01/m1      mtab: /net/heston/m1 <=> mounts: 
23:26:59 /net/bamboo43/h1     mtab: /net/spruce/m1 <=> mounts: 
23:29:02 --                   #2555, chkd 2556, run 0, OK 244, mtd 195, of 570

23:35:29 --                   #2678, chkd 2668, run 0, OK 244, mtd 232, of 570

23:35:50 /net/holly02/m1      mtab: /net/holly02/h1 <=> mounts: 
23:43:50 /net/bamboo33/m2     mtab: /net/godzilla/m1 <=> mounts: 
23:44:48 /net/bamboo05/h1     mtab: /net/bamboo09/m2 <=> mounts: 
23:44:49 --                   #2889, chkd 2752, run 0, OK 244, mtd 241, of 570

23:47:08 /net/hollyfs/h1      mtab: /net/spruce/s3 <=> mounts: 
23:47:13 /net/vallejo/m1      mtab: <=> mounts: /net/ulanda/m2 /net/merced/m1 
23:47:15 /net/harlech/h1      mtab: /net/cedar/h2 <=> mounts: 
23:47:16 /net/bamboo47/m2     mtab: /net/cedar/h1 <=> mounts: 
23:47:16 /net/whittier/m1     mtab: /net/cedar/s3 <=> mounts: 
23:49:24 --                   #2897, chkd 2858, run 0, OK 244, mtd 244, of 570

23:53:09 /net/papyrus70/m1    mtab: /net/sassafras/m2 <=> mounts: 
23:53:47 /net/bamboo08/m2     mtab: /net/bamboo08/h1 <=> mounts: 
23:56:14 /net/bamboo03/m1     mtab: /net/riemann/m1 <=> mounts: 
23:58:14 --                   #3029, chkd 2985, run 0, OK 244, mtd 217, of 570

00:03:13 /net/papyrus70/m1    mtab: /net/papyrus70/h1 <=> mounts: 
00:07:23 --                   #3177, chkd 3056, run 0, OK 244, mtd 168, of 570

00:07:28 /net/trejo/m1        mtab: /net/pong/m1 <=> mounts: 
00:07:35 /net/malibu/m1       mtab: <=> mounts: /net/holly01/m1 /net/nemo08/m1 /net/reedley/m1 /net/holly03/m1 
00:07:35 /net/bamboo19/h1     mtab: <=> mounts: /net/holly02/m1 
00:13:32 /net/bamboo40/h1     mtab: /net/bamboo40/h1 <=> mounts: 
00:13:33 --                   #3293, chkd 3151, run 0, OK 244, mtd 241, of 570

00:14:47 /net/bamboo34/m2     mtab: /net/bamboo42/h1 <=> mounts: 
00:14:52 /net/bamboo42/m2     mtab: /net/bamboo42/m1 <=> mounts: 
00:14:52 /net/bamboo42/h1     mtab: /net/bamboo42/m2 <=> mounts: 
00:19:05 --                   #3328, chkd 3265, run 0, OK 244, mtd 242, of 570

00:25:38 /net/bamboo35/m1     mtab: <=> mounts: /net/bamboo45/m1 
00:25:38 /net/bamboo29/m2     mtab: <=> mounts: /net/bamboo09/m2 
00:25:43 /net/bamboo45/m2     mtab: /net/testudo/m1 <=> mounts: 
00:25:47 /net/bamboo06/m1     mtab: /net/holly03/h1 <=> mounts: 
00:27:49 --                   #3458, chkd 3389, run 0, OK 244, mtd 170, of 570

00:28:04 --                   #3459, chkd 3463, run 0, OK 244, mtd 244, of 570

00:43:23 --                   #3730, chkd 3551, run 0, OK 244, mtd 241, of 570

00:43:34 /net/bamboo41/h1     mtab: /net/bamboo45/m1 <=> mounts: 
00:44:13 /net/bamboo40/h1     mtab: /net/bamboo40/m1 <=> mounts: 
00:46:15 /net/bamboo06/m2     mtab: <=> mounts: /net/holly01/m1 /net/bamboo16/m1 
00:46:21 /net/bamboo16/m2     mtab: <=> mounts: /net/holly02/m1 
00:46:28 --                   #3752, chkd 3663, run 0, OK 244, mtd 229, of 570

00:46:33 /net/spruce/h1       No such file or directory
00:46:33 /net/spruce/h1       failed
00:55:38 /net/bamboo08/m2     mtab: /net/holly04/m2 <=> mounts: 
00:57:54 --                   #3900, chkd 3812, run 0, OK 243, mtd 219, of 570

01:06:04 /net/bamboo23/h1     mtab: /net/mothra/m1 <=> mounts: 
01:08:05 --                   #4075, chkd 3919, run 0, OK 243, mtd 199, of 570

01:14:21 /net/bamboo04/m1     mtab: <=> mounts: /net/papyrus19/m1 
01:14:30 --                   #4197, chkd 4031, run 0, OK 243, mtd 230, of 570

01:16:41 /net/spruce/h1       revived
01:16:41 /net/spruce/h1       revived
01:23:41 /net/bamboo29/h1     mtab: /net/bamboo35/m2 <=> mounts: 
01:25:49 --                   #4409, chkd 4102, run 0, OK 244, mtd 158, of 570

01:25:51 /net/buellton/m1     mtab: <=> mounts: /net/holly01/m1 
01:28:14 --                   #4411, chkd 4218, run 0, OK 244, mtd 244, of 570

01:32:19 /net/bamboo08/h1     mtab: /net/bamboo17/m2 <=> mounts: 
01:32:35 /net/bamboo11/m2     mtab: /net/bamboo11/m1 <=> mounts: 
01:36:54 --                   #4542, chkd 4307, run 0, OK 244, mtd 216, of 570

01:43:52 /net/bamboo41/m1     mtab: /net/bamboo43/m1 <=> mounts: 
01:44:02 /net/bamboo09/m1     mtab: /net/bamboo30/m2 <=> mounts: 
01:46:06 --                   #4687, chkd 4419, run 0, OK 244, mtd 166, of 570

01:46:20 /net/ulanda/m1       No such file or directory
01:46:20 /net/ulanda/m1       failed
01:48:24 --                   #4689, chkd 4508, run 0, OK 243, mtd 243, of 570

01:54:31 /net/daggett/h1      mtab: /net/daggett/h1 <=> mounts: 
02:01:59 --                   #5025, chkd 4602, run 0, OK 243, mtd 239, of 570

02:02:01 /net/palmdale/m1     mtab: /net/bamboo22/h1 <=> mounts: 
02:05:03 /net/bamboo11/m1     mtab: /net/merced/m1 <=> mounts: 
02:07:16 --                   #5053, chkd 4711, run 0, OK 243, mtd 198, of 570

02:16:50 --                   #5205, chkd 4864, run 0, OK 243, mtd 234, of 570

02:16:52 /net/ulanda/m1       revived
02:16:52 /net/ulanda/m1       revived
02:21:05 /net/papyrus19/m1    mtab: /net/sassafras/h1 <=> mounts: 
02:22:03 /net/pacifica/h1     mtab: /net/bamboo20/m2 <=> mounts: 
02:22:11 /net/bamboo11/m1     mtab: /net/bamboo35/m1 <=> mounts: 
02:22:16 /net/bamboo41/m1     mtab: /net/bamboo09/m2 <=> mounts: 
02:24:33 /net/bamboo33/m1     mtab: /net/tupelo/h2 <=> mounts: 
02:26:36 --                   #5368, chkd 4970, run 0, OK 244, mtd 202, of 570

02:26:43 /net/julia/s3        No such file or directory
02:26:44 /net/julia/m1        No such file or directory
02:26:45 /net/julia/s1        No such file or directory
02:28:45 /net/julia/s3        failed
02:28:45 /net/julia/m1        failed
02:28:45 /net/julia/s1        failed
02:34:46 /net/bamboo45/m2     mtab: /net/bamboo30/h1 <=> mounts: 
02:36:52 --                   #5422, chkd 5134, run 0, OK 241, mtd 214, of 570

02:38:58 /net/bamboo23/m2     hung
02:38:58 /net/bamboo23/m1     hung
02:38:58 /net/bamboo26/m1     hung
02:38:58 /net/bamboo31/m2     hung
02:38:58 /net/bamboo40/m2     hung
02:38:58 /net/bamboo28/h1     hung
02:38:58 /net/bamboo40/m1     hung
02:38:58 /net/bamboo19/m2     hung
02:38:58 /net/bamboo40/h1     hung
02:38:58 /net/bamboo32/m2     hung
02:38:58 /net/bamboo30/m2     hung
02:38:58 /net/bamboo26/m2     hung
02:38:58 /net/bamboo28/m2     hung
02:38:58 /net/bamboo30/m1     hung
02:38:58 /net/bamboo32/m1     hung
02:38:58 /net/bamboo31/m1     hung
02:38:58 /net/bamboo26/h1     hung
02:38:58 /net/bamboo19/m1     hung
02:38:58 /net/bamboo28/m1     hung
02:38:58 /net/bamboo31/h1     hung
02:38:58 /net/bamboo23/h1     hung
02:38:58 /net/bamboo19/h1     hung
02:38:58 /net/bamboo30/h1     hung
02:38:58 /net/bamboo32/h1     hung
02:38:58 --                   #5423, chkd 5164, run 24, OK 217, mtd 220, of 570

=----- gdb backtrace of all threads -----
(backtrace disabled) (see end of file)
02:44:34 /net/sunset/h1       still mounted after 1800 secs, state = success
02:46:34 /net/sunset/s3       still mounted after 1800 secs, state = success
02:46:35 /net/sunset/s1       still mounted after 1800 secs, state = success
02:46:35 /net/holly04/m1      still mounted after 1800 secs, state = success
=--snip-- this continues through the night, nothing interesting.
10:08:57 /net/bamboo07/h1     still mounted after 1800 secs, state = success
10:08:57 /net/bamboo42/m1     still mounted after 1800 secs, state = success

=-- This backtrace was taken by hand at about 09:13 ---
GNU gdb 6.6.50.20070726-cvs
Copyright (C) 2007 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i586-suse-linux"...
Using host libthread_db library "/lib/libthread_db.so.1".
Attaching to program: /usr/sbin/automount, process 2784
Loaded symbols for /usr/sbin/automount
Reading symbols from /lib/libpthread.so.0...done.
[Thread debugging using libthread_db enabled]
[New Thread 0xb7e1f6c0 (LWP 2784)]
[New Thread 0xb6bdeb90 (LWP 19862)]
[New Thread 0xb6fdbb90 (LWP 19847)]
[New Thread 0xb2bbdb90 (LWP 19844)]
[New Thread 0xb2dbfb90 (LWP 19838)]
[New Thread 0xb6edab90 (LWP 19836)]
[New Thread 0xb74e0b90 (LWP 19834)]
[New Thread 0xb2abcb90 (LWP 19831)]
[New Thread 0xb77e3b90 (LWP 19824)]
[New Thread 0x89e67b90 (LWP 19760)]
[New Thread 0xa6aa4b90 (LWP 19759)]
[New Thread 0x92f7ab90 (LWP 19585)]
[New Thread 0x95f80b90 (LWP 19584)]
[New Thread 0x99888b90 (LWP 19573)]
[New Thread 0xa149bb90 (LWP 19562)]
[New Thread 0xa249db90 (LWP 19557)]
[New Thread 0xa5aa2b90 (LWP 19554)]
[New Thread 0xa96adb90 (LWP 19553)]
[New Thread 0xab4afb90 (LWP 19552)]
[New Thread 0xacfb5b90 (LWP 19548)]
[New Thread 0xa349fb90 (LWP 19547)]
[New Thread 0xb07bcb90 (LWP 19459)]
[New Thread 0xb1bbbb90 (LWP 19457)]
[New Thread 0x99087b90 (LWP 19456)]
[New Thread 0xb3fc3b90 (LWP 19380)]
[New Thread 0xaf7bab90 (LWP 19329)]
[New Thread 0xa0c9ab90 (LWP 19327)]
[New Thread 0x7c7f8b90 (LWP 19325)]
[New Thread 0x7d7fab90 (LWP 19324)]
[New Thread 0xb4fc5b90 (LWP 18753)]
[New Thread 0xb27b9b90 (LWP 18591)]
[New Thread 0x747e8b90 (LWP 18476)]
[New Thread 0x74fe9b90 (LWP 18409)]
[New Thread 0x757eab90 (LWP 18404)]
[New Thread 0x75febb90 (LWP 18401)]
[New Thread 0x767ecb90 (LWP 18398)]
[New Thread 0x76fedb90 (LWP 18395)]
[New Thread 0x777eeb90 (LWP 18392)]
[New Thread 0x77fefb90 (LWP 18389)]
[New Thread 0x787f0b90 (LWP 18386)]
[New Thread 0x78ff1b90 (LWP 18383)]
[New Thread 0x797f2b90 (LWP 18380)]
[New Thread 0x79ff3b90 (LWP 18377)]
[New Thread 0x7a7f4b90 (LWP 18374)]
[New Thread 0x7aff5b90 (LWP 18371)]
[New Thread 0x7b7f6b90 (LWP 18368)]
[New Thread 0x7bff7b90 (LWP 18365)]
[New Thread 0x8365ab90 (LWP 18101)]
[New Thread 0x83e5bb90 (LWP 18094)]
[New Thread 0x82e59b90 (LWP 18087)]
[New Thread 0x85e5fb90 (LWP 17809)]
[New Thread 0x87e63b90 (LWP 17805)]
[New Thread 0x8ae69b90 (LWP 17804)]
[New Thread 0x98085b90 (LWP 17783)]
[New Thread 0x9a089b90 (LWP 17777)]
[New Thread 0xadfb7b90 (LWP 17775)]
[New Thread 0xb47c4b90 (LWP 17774)]
[New Thread 0x96f82b90 (LWP 17773)]
[New Thread 0x8d763b90 (LWP 17768)]
[New Thread 0x7dffbb90 (LWP 17763)]
[New Thread 0x81d56b90 (LWP 17760)]
[New Thread 0xa0499b90 (LWP 17034)]
[New Thread 0xa52a1b90 (LWP 17017)]
[New Thread 0xae7b8b90 (LWP 17014)]
[New Thread 0x87662b90 (LWP 17009)]
[New Thread 0x8cf62b90 (LWP 17008)]
[New Thread 0x9377bb90 (LWP 17007)]
[New Thread 0x9d493b90 (LWP 17005)]
[New Thread 0xa429fb90 (LWP 16681)]
[New Thread 0x8df64b90 (LWP 16055)]
[New Thread 0x7e7fcb90 (LWP 16024)]
[New Thread 0x80d54b90 (LWP 15912)]
[New Thread 0x8a668b90 (LWP 15911)]
[New Thread 0x8ff74b90 (LWP 15910)]
[New Thread 0x90f76b90 (LWP 15909)]
[New Thread 0x91777b90 (LWP 15908)]
[New Thread 0x9e495b90 (LWP 15905)]
[New Thread 0xa2c9eb90 (LWP 15903)]
[New Thread 0xaa6afb90 (LWP 15901)]
[New Thread 0xabcb0b90 (LWP 15899)]
[New Thread 0xaefb9b90 (LWP 15897)]
[New Thread 0x9fc98b90 (LWP 15895)]
[New Thread 0x7cff9b90 (LWP 15893)]
[New Thread 0x86660b90 (LWP 15891)]
[New Thread 0xb23bcb90 (LWP 15890)]
[New Thread 0xaffbbb90 (LWP 15167)]
[New Thread 0x84e5db90 (LWP 14952)]
[New Thread 0x8565eb90 (LWP 14941)]
[New Thread 0x8e765b90 (LWP 14918)]
[New Thread 0xb37c2b90 (LWP 14884)]
[New Thread 0xb5fc7b90 (LWP 14857)]
[New Thread 0x9a88ab90 (LWP 14834)]
[New Thread 0x9ec96b90 (LWP 14823)]
[New Thread 0x7effdb90 (LWP 14776)]
[New Thread 0x9bbfeb90 (LWP 14761)]
[New Thread 0x8f773b90 (LWP 14504)]
[New Thread 0x91f78b90 (LWP 14492)]
[New Thread 0x92779b90 (LWP 14484)]
[New Thread 0x93f7cb90 (LWP 14481)]
[New Thread 0x9577fb90 (LWP 14480)]
[New Thread 0x96781b90 (LWP 14476)]
[New Thread 0x9f497b90 (LWP 14474)]
[New Thread 0xa62a3b90 (LWP 14470)]
[New Thread 0xa76a9b90 (LWP 14468)]
[New Thread 0xa7eaab90 (LWP 14466)]
[New Thread 0xa8eacb90 (LWP 14465)]
[New Thread 0xad7b6b90 (LWP 14461)]
[New Thread 0xa4aa0b90 (LWP 14457)]
[New Thread 0x94f7eb90 (LWP 14455)]
[New Thread 0xa1c9cb90 (LWP 14452)]
[New Thread 0xac4b1b90 (LWP 13880)]
[New Thread 0x9b08bb90 (LWP 13374)]
[New Thread 0x81555b90 (LWP 13175)]
[New Thread 0x7ffffb90 (LWP 13164)]
[New Thread 0x82557b90 (LWP 13141)]
[New Thread 0x8ef66b90 (LWP 13133)]
[New Thread 0x8465cb90 (LWP 12361)]
[New Thread 0xb67c8b90 (LWP 12084)]
[New Thread 0x86e61b90 (LWP 10794)]
[New Thread 0x88e65b90 (LWP 10787)]
[New Thread 0x9c3ffb90 (LWP 10761)]
[New Thread 0xa9eaeb90 (LWP 10750)]
[New Thread 0x89666b90 (LWP 10723)]
[New Thread 0x9dc94b90 (LWP 6926)]
[New Thread 0xa86abb90 (LWP 2183)]
[New Thread 0x8be6bb90 (LWP 1069)]
[New Thread 0x98886b90 (LWP 17936)]
[New Thread 0x7f7feb90 (LWP 17867)]
[New Thread 0xb57c6b90 (LWP 3196)]
[New Thread 0xb7b3ab90 (LWP 2803)]
[New Thread 0xb7c77b90 (LWP 2795)]
[New Thread 0xb7e1eb90 (LWP 2786)]
[New Thread 0xb7f8cb90 (LWP 2785)]
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
Thread 133 (Thread 0xb7f8cb90 (LWP 2785)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f607ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib/libpthread.so.0
#2  0x8001e1bc in alarm_handler (arg=0x0) at alarm.c:204
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 132 (Thread 0xb7e1eb90 (LWP 2786)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f607ec in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib/libpthread.so.0
#2  0x80018179 in st_queue_handler (arg=0x0) at state.c:966
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 131 (Thread 0xb7c77b90 (LWP 2795)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8004e860) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 130 (Thread 0xb7b3ab90 (LWP 2803)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8004ee80) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 129 (Thread 0xb57c6b90 (LWP 3196)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80068d48) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 128 (Thread 0x7f7feb90 (LWP 17867)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8009fa18) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 127 (Thread 0x98886b90 (LWP 17936)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8006faf0) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 126 (Thread 0x8be6bb90 (LWP 1069)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80079a58) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 125 (Thread 0xa86abb90 (LWP 2183)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800be8d8) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 124 (Thread 0x9dc94b90 (LWP 6926)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800a83c8) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 123 (Thread 0x89666b90 (LWP 10723)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800b39f0) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 122 (Thread 0xa9eaeb90 (LWP 10750)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80099358) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 121 (Thread 0x9c3ffb90 (LWP 10761)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800be010) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 120 (Thread 0x88e65b90 (LWP 10787)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80091638) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 119 (Thread 0x86e61b90 (LWP 10794)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800811f8) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 118 (Thread 0xb67c8b90 (LWP 12084)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8006add0) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 117 (Thread 0x8465cb90 (LWP 12361)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80097378) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 116 (Thread 0x8ef66b90 (LWP 13133)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8007c740) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 115 (Thread 0x82557b90 (LWP 13141)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80081378) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 114 (Thread 0x7ffffb90 (LWP 13164)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8006c0b0) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 113 (Thread 0x81555b90 (LWP 13175)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800742b8) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 112 (Thread 0x9b08bb90 (LWP 13374)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80086bc0) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 111 (Thread 0xac4b1b90 (LWP 13880)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8009d610) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 110 (Thread 0xa1c9cb90 (LWP 14452)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80094290) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 109 (Thread 0x94f7eb90 (LWP 14455)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8006d3c0) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 108 (Thread 0xa4aa0b90 (LWP 14457)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800bd050) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 107 (Thread 0xad7b6b90 (LWP 14461)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80084118) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 106 (Thread 0xa8eacb90 (LWP 14465)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8007b610) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 105 (Thread 0xa7eaab90 (LWP 14466)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800cb4a8) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 104 (Thread 0xa76a9b90 (LWP 14468)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80088ec8) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 103 (Thread 0xa62a3b90 (LWP 14470)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800c2f90) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 102 (Thread 0x9f497b90 (LWP 14474)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800c2060) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 101 (Thread 0x96781b90 (LWP 14476)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80085f70) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 100 (Thread 0x9577fb90 (LWP 14480)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80075658) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 99 (Thread 0x93f7cb90 (LWP 14481)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80083e48) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 98 (Thread 0x92779b90 (LWP 14484)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80099c38) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 97 (Thread 0x91f78b90 (LWP 14492)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800aa038) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 96 (Thread 0x8f773b90 (LWP 14504)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800ada78) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 95 (Thread 0x9bbfeb90 (LWP 14761)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8006b850) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 94 (Thread 0x7effdb90 (LWP 14776)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800acf70) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 93 (Thread 0x9ec96b90 (LWP 14823)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8008add0) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 92 (Thread 0x9a88ab90 (LWP 14834)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80081588) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 91 (Thread 0xb5fc7b90 (LWP 14857)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800c5918) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 90 (Thread 0xb37c2b90 (LWP 14884)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800aa7e0) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 89 (Thread 0x8e765b90 (LWP 14918)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800a9bf0) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 88 (Thread 0x8565eb90 (LWP 14941)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800ac9d8) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 87 (Thread 0x84e5db90 (LWP 14952)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800a98b0) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 86 (Thread 0xaffbbb90 (LWP 15167)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800bac70) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 85 (Thread 0xb23bcb90 (LWP 15890)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8009b8d0) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 84 (Thread 0x86660b90 (LWP 15891)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80074e88) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 83 (Thread 0x7cff9b90 (LWP 15893)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80092220) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 82 (Thread 0x9fc98b90 (LWP 15895)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80067b88) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 81 (Thread 0xaefb9b90 (LWP 15897)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8006f858) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 80 (Thread 0xabcb0b90 (LWP 15899)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8007f728) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 79 (Thread 0xaa6afb90 (LWP 15901)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800866f8) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 78 (Thread 0xa2c9eb90 (LWP 15903)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8006b6c8) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 77 (Thread 0x9e495b90 (LWP 15905)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800c3540) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 76 (Thread 0x91777b90 (LWP 15908)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800a08a8) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 75 (Thread 0x90f76b90 (LWP 15909)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800c3800) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 74 (Thread 0x8ff74b90 (LWP 15910)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800b0030) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 73 (Thread 0x8a668b90 (LWP 15911)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800a00f0) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 72 (Thread 0x80d54b90 (LWP 15912)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8006fc80) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 71 (Thread 0x7e7fcb90 (LWP 16024)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800a1040) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 70 (Thread 0x8df64b90 (LWP 16055)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800bd170) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 69 (Thread 0xa429fb90 (LWP 16681)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8007e200) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 68 (Thread 0x9d493b90 (LWP 17005)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800b7b80) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 67 (Thread 0x9377bb90 (LWP 17007)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800b5258) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 66 (Thread 0x8cf62b90 (LWP 17008)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80098f40) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 65 (Thread 0x87662b90 (LWP 17009)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800a5b68) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 64 (Thread 0xae7b8b90 (LWP 17014)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80093b88) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 63 (Thread 0xa52a1b90 (LWP 17017)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800cbc28) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 62 (Thread 0xa0499b90 (LWP 17034)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800a6138) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 61 (Thread 0x81d56b90 (LWP 17760)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800c29c8) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 60 (Thread 0x7dffbb90 (LWP 17763)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80088cc0) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 59 (Thread 0x8d763b90 (LWP 17768)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80085410) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 58 (Thread 0x96f82b90 (LWP 17773)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8009cb30) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 57 (Thread 0xb47c4b90 (LWP 17774)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800a9a30) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 56 (Thread 0xadfb7b90 (LWP 17775)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800bb980) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 55 (Thread 0x9a089b90 (LWP 17777)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8007fc50) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 54 (Thread 0x98085b90 (LWP 17783)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8006e940) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 53 (Thread 0x8ae69b90 (LWP 17804)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800a7ff0) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 52 (Thread 0x87e63b90 (LWP 17805)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8008a320) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 51 (Thread 0x85e5fb90 (LWP 17809)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80099098) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 50 (Thread 0x82e59b90 (LWP 18087)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800aa468) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 49 (Thread 0x83e5bb90 (LWP 18094)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800c53e8) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 48 (Thread 0x8365ab90 (LWP 18101)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8006cd98) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 47 (Thread 0x7bff7b90 (LWP 18365)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800b3f50) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 46 (Thread 0x7b7f6b90 (LWP 18368)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8009a370) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 45 (Thread 0x7aff5b90 (LWP 18371)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80092ac0) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 44 (Thread 0x7a7f4b90 (LWP 18374)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8007c8d0) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 43 (Thread 0x79ff3b90 (LWP 18377)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800a3a38) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 42 (Thread 0x797f2b90 (LWP 18380)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800ba340) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 41 (Thread 0x78ff1b90 (LWP 18383)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800c5b48) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 40 (Thread 0x787f0b90 (LWP 18386)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80082788) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 39 (Thread 0x77fefb90 (LWP 18389)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800b65b8) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 38 (Thread 0x777eeb90 (LWP 18392)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80090560) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 37 (Thread 0x76fedb90 (LWP 18395)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8006f450) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 36 (Thread 0x767ecb90 (LWP 18398)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8009bc28) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 35 (Thread 0x75febb90 (LWP 18401)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800cb850) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 34 (Thread 0x757eab90 (LWP 18404)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800c3920) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 33 (Thread 0x74fe9b90 (LWP 18409)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800772a8) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 32 (Thread 0x747e8b90 (LWP 18476)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8007e8b8) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 31 (Thread 0xb27b9b90 (LWP 18591)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f60566 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib/libpthread.so.0
#2  0x800218a7 in master_notify_submount (ap=0x8004e860, 
    path=0x800d0870 "/net/gauguin", state=ST_EXPIRE) at master.c:908
#3  0x8000ca7d in expire_proc_indirect (arg=0xa3800538) at indirect.c:468
#4  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#5  0xb7ee302e in clone () from /lib/libc.so.6

Thread 30 (Thread 0xb4fc5b90 (LWP 18753)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80099848) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 29 (Thread 0x7d7fab90 (LWP 19324)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80069ac0) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 28 (Thread 0x7c7f8b90 (LWP 19325)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800ab020) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 27 (Thread 0xa0c9ab90 (LWP 19327)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800a2ff0) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 26 (Thread 0xaf7bab90 (LWP 19329)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80080188) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 25 (Thread 0xb3fc3b90 (LWP 19380)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8007f858) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 24 (Thread 0x99087b90 (LWP 19456)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80069c50) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 23 (Thread 0xb1bbbb90 (LWP 19457)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8007ac10) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 22 (Thread 0xb07bcb90 (LWP 19459)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800b5f58) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 21 (Thread 0xa349fb90 (LWP 19547)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80087580) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 20 (Thread 0xacfb5b90 (LWP 19548)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800a2190) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 19 (Thread 0xab4afb90 (LWP 19552)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800b6838) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 18 (Thread 0xa96adb90 (LWP 19553)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80099478) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 17 (Thread 0xa5aa2b90 (LWP 19554)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800aebb0) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 16 (Thread 0xa249db90 (LWP 19557)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800af490) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 15 (Thread 0xa149bb90 (LWP 19562)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800b03c8) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 14 (Thread 0x99888b90 (LWP 19573)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80092958) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 13 (Thread 0x95f80b90 (LWP 19584)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8006a540) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 12 (Thread 0x92f7ab90 (LWP 19585)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x800bced8) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 11 (Thread 0xa6aa4b90 (LWP 19759)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x80066c48) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 10 (Thread 0x89e67b90 (LWP 19760)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ed9817 in poll () from /lib/libc.so.6
#2  0x8000a333 in handle_mounts (arg=0x8009ec30) at automount.c:909
#3  0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#4  0xb7ee302e in clone () from /lib/libc.so.6

Thread 9 (Thread 0xb77e3b90 (LWP 19824)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f62c1e in __lll_mutex_lock_wait () from /lib/libpthread.so.0
#2  0xb7f5ea58 in _L_mutex_lock_86 () from /lib/libpthread.so.0
#3  0xb7f5e47d in pthread_mutex_lock () from /lib/libpthread.so.0
#4  0xb7a0c60e in mount_mount (ap=0x8004e860, root=0x8004e958 "/net", 
    name=0xb77e1aa0 "bamboo19", name_len=8, what=0xb77e1a70 "file", 
    fstype=0xb77e1ac0 "autofs", 
    c_options=0xb77e1ae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=bamboo19", context=0x18) at mount_autofs.c:217
#5  0x80013c74 in do_mount (ap=0x8004e860, root=0x8004e958 "/net", 
    name=0xb77e1aa0 "bamboo19", name_len=8, what=0xb77e1a70 "file", 
    fstype=0xb77e1ac0 "autofs", 
    options=0xb77e1ae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=bamboo19")
    at mount.c:73
#6  0xb7b60993 in sun_mount (ap=0x8004e860, root=0x8004e958 "/net", 
    name=0xb77e1e10 "bamboo19", namelen=8, 
    loc=0x80081a30 "file:/etc/auto.net.generic", loclen=26, 
    options=0xb77e1ae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=bamboo19", 
    ctxt=0x8003a5b8) at parse_sun.c:657
#7  0xb7b6180a in parse_mount (ap=0x8004e860, name=0xb77e1e10 "bamboo19", 
    name_len=8, 
    mapent=0xb77e1d80 "-rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=&\tfile:/etc/auto.net.generic", context=0x8003a5b8) at parse_sun.c:1458
#8  0xb7df8e70 in lookup_mount (ap=0x8004e860, name=0xb77e31c8 "bamboo19", 
    name_len=8, context=0x8004e7b0) at lookup_file.c:1136
#9  0x8001480c in do_lookup_mount (ap=0x8004e860, map=0x8003a6a0, 
    name=0xb77e31c8 "bamboo19", name_len=8) at lookup.c:668
#10 0x8001499a in lookup_name_file_source_instance (ap=0x8004e860, 
    map=0x8004e968, name=0xb77e31c8 "bamboo19", name_len=8) at lookup.c:708
#11 0x80015569 in lookup_nss_mount (ap=0x8004e860, source=0x0, 
    name=0xb77e31c8 "bamboo19", name_len=8) at lookup.c:856
#12 0x8000bfca in do_mount_indirect (arg=0x800a6ac0) at indirect.c:892
#13 0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#14 0xb7ee302e in clone () from /lib/libc.so.6

Thread 8 (Thread 0xb2abcb90 (LWP 19831)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f62c1e in __lll_mutex_lock_wait () from /lib/libpthread.so.0
#2  0xb7f5ea58 in _L_mutex_lock_86 () from /lib/libpthread.so.0
#3  0xb7f5e47d in pthread_mutex_lock () from /lib/libpthread.so.0
#4  0xb7a0c60e in mount_mount (ap=0x8004e860, root=0x8004e958 "/net", 
    name=0xb2abaaa0 "bamboo30", name_len=8, what=0xb2abaa70 "file", 
    fstype=0xb2abaac0 "autofs", 
    c_options=0xb2abaae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=bamboo30", context=0x18) at mount_autofs.c:217
#5  0x80013c74 in do_mount (ap=0x8004e860, root=0x8004e958 "/net", 
    name=0xb2abaaa0 "bamboo30", name_len=8, what=0xb2abaa70 "file", 
    fstype=0xb2abaac0 "autofs", 
    options=0xb2abaae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=bamboo30")
    at mount.c:73
#6  0xb7b60993 in sun_mount (ap=0x8004e860, root=0x8004e958 "/net", 
    name=0xb2abae10 "bamboo30", namelen=8, 
    loc=0x8008d148 "file:/etc/auto.net.generic", loclen=26, 
    options=0xb2abaae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=bamboo30", 
    ctxt=0x8003a5b8) at parse_sun.c:657
#7  0xb7b6180a in parse_mount (ap=0x8004e860, name=0xb2abae10 "bamboo30", 
    name_len=8, 
    mapent=0xb2abad80 "-rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=&\tfile:/etc/auto.net.generic", context=0x8003a5b8) at parse_sun.c:1458
#8  0xb7df8e70 in lookup_mount (ap=0x8004e860, name=0xb2abc1c8 "bamboo30", 
    name_len=8, context=0x8004e7b0) at lookup_file.c:1136
#9  0x8001480c in do_lookup_mount (ap=0x8004e860, map=0x8003a6a0, 
    name=0xb2abc1c8 "bamboo30", name_len=8) at lookup.c:668
#10 0x8001499a in lookup_name_file_source_instance (ap=0x8004e860, 
    map=0x8004e968, name=0xb2abc1c8 "bamboo30", name_len=8) at lookup.c:708
#11 0x80015569 in lookup_nss_mount (ap=0x8004e860, source=0x0, 
    name=0xb2abc1c8 "bamboo30", name_len=8) at lookup.c:856
#12 0x8000bfca in do_mount_indirect (arg=0x800a6ac0) at indirect.c:892
#13 0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#14 0xb7ee302e in clone () from /lib/libc.so.6

Thread 7 (Thread 0xb74e0b90 (LWP 19834)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f62c1e in __lll_mutex_lock_wait () from /lib/libpthread.so.0
#2  0xb7f5ea58 in _L_mutex_lock_86 () from /lib/libpthread.so.0
#3  0xb7f5e47d in pthread_mutex_lock () from /lib/libpthread.so.0
#4  0xb7a0c60e in mount_mount (ap=0x8004e860, root=0x8004e958 "/net", 
    name=0xb74deaa0 "bamboo26", name_len=8, what=0xb74dea70 "file", 
    fstype=0xb74deac0 "autofs", 
    c_options=0xb74deae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=bamboo26", context=0x18) at mount_autofs.c:217
#5  0x80013c74 in do_mount (ap=0x8004e860, root=0x8004e958 "/net", 
    name=0xb74deaa0 "bamboo26", name_len=8, what=0xb74dea70 "file", 
    fstype=0xb74deac0 "autofs", 
    options=0xb74deae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=bamboo26")
    at mount.c:73
#6  0xb7b60993 in sun_mount (ap=0x8004e860, root=0x8004e958 "/net", 
    name=0xb74dee10 "bamboo26", namelen=8, 
    loc=0x800aae68 "file:/etc/auto.net.generic", loclen=26, 
    options=0xb74deae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=bamboo26", 
    ctxt=0x8003a5b8) at parse_sun.c:657
#7  0xb7b6180a in parse_mount (ap=0x8004e860, name=0xb74dee10 "bamboo26", 
    name_len=8, 
    mapent=0xb74ded80 "-rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=&\tfile:/etc/auto.net.generic", context=0x8003a5b8) at parse_sun.c:1458
#8  0xb7df8e70 in lookup_mount (ap=0x8004e860, name=0xb74e01c8 "bamboo26", 
    name_len=8, context=0x8004e7b0) at lookup_file.c:1136
#9  0x8001480c in do_lookup_mount (ap=0x8004e860, map=0x8003a6a0, 
    name=0xb74e01c8 "bamboo26", name_len=8) at lookup.c:668
#10 0x8001499a in lookup_name_file_source_instance (ap=0x8004e860, 
    map=0x8004e968, name=0xb74e01c8 "bamboo26", name_len=8) at lookup.c:708
#11 0x80015569 in lookup_nss_mount (ap=0x8004e860, source=0x0, 
    name=0xb74e01c8 "bamboo26", name_len=8) at lookup.c:856
#12 0x8000bfca in do_mount_indirect (arg=0x800a6ac0) at indirect.c:892
#13 0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#14 0xb7ee302e in clone () from /lib/libc.so.6

Thread 6 (Thread 0xb6edab90 (LWP 19836)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f62c1e in __lll_mutex_lock_wait () from /lib/libpthread.so.0
#2  0xb7f5ea58 in _L_mutex_lock_86 () from /lib/libpthread.so.0
#3  0xb7f5e47d in pthread_mutex_lock () from /lib/libpthread.so.0
#4  0xb7a0c60e in mount_mount (ap=0x8004e860, root=0x8004e958 "/net", 
    name=0xb6ed8aa0 "bamboo28", name_len=8, what=0xb6ed8a70 "file", 
    fstype=0xb6ed8ac0 "autofs", 
    c_options=0xb6ed8ae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=bamboo28", context=0x18) at mount_autofs.c:217
#5  0x80013c74 in do_mount (ap=0x8004e860, root=0x8004e958 "/net", 
    name=0xb6ed8aa0 "bamboo28", name_len=8, what=0xb6ed8a70 "file", 
    fstype=0xb6ed8ac0 "autofs", 
    options=0xb6ed8ae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=bamboo28")
    at mount.c:73
#6  0xb7b60993 in sun_mount (ap=0x8004e860, root=0x8004e958 "/net", 
    name=0xb6ed8e10 "bamboo28", namelen=8, 
    loc=0x800ace98 "file:/etc/auto.net.generic", loclen=26, 
    options=0xb6ed8ae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=bamboo28", 
    ctxt=0x8003a5b8) at parse_sun.c:657
#7  0xb7b6180a in parse_mount (ap=0x8004e860, name=0xb6ed8e10 "bamboo28", 
    name_len=8, 
    mapent=0xb6ed8d80 "-rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=&\tfile:/etc/auto.net.generic", context=0x8003a5b8) at parse_sun.c:1458
#8  0xb7df8e70 in lookup_mount (ap=0x8004e860, name=0xb6eda1c8 "bamboo28", 
    name_len=8, context=0x8004e7b0) at lookup_file.c:1136
#9  0x8001480c in do_lookup_mount (ap=0x8004e860, map=0x8003a6a0, 
    name=0xb6eda1c8 "bamboo28", name_len=8) at lookup.c:668
#10 0x8001499a in lookup_name_file_source_instance (ap=0x8004e860, 
    map=0x8004e968, name=0xb6eda1c8 "bamboo28", name_len=8) at lookup.c:708
#11 0x80015569 in lookup_nss_mount (ap=0x8004e860, source=0x0, 
    name=0xb6eda1c8 "bamboo28", name_len=8) at lookup.c:856
#12 0x8000bfca in do_mount_indirect (arg=0x800a6ac0) at indirect.c:892
#13 0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#14 0xb7ee302e in clone () from /lib/libc.so.6

Thread 5 (Thread 0xb2dbfb90 (LWP 19838)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f62c1e in __lll_mutex_lock_wait () from /lib/libpthread.so.0
#2  0xb7f5ea58 in _L_mutex_lock_86 () from /lib/libpthread.so.0
#3  0xb7f5e47d in pthread_mutex_lock () from /lib/libpthread.so.0
#4  0xb7a0c60e in mount_mount (ap=0x8004e860, root=0x8004e958 "/net", 
    name=0xb2dbdaa0 "bamboo31", name_len=8, what=0xb2dbda70 "file", 
    fstype=0xb2dbdac0 "autofs", 
    c_options=0xb2dbdae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=bamboo31", context=0x18) at mount_autofs.c:217
#5  0x80013c74 in do_mount (ap=0x8004e860, root=0x8004e958 "/net", 
    name=0xb2dbdaa0 "bamboo31", name_len=8, what=0xb2dbda70 "file", 
    fstype=0xb2dbdac0 "autofs", 
    options=0xb2dbdae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=bamboo31")
    at mount.c:73
#6  0xb7b60993 in sun_mount (ap=0x8004e860, root=0x8004e958 "/net", 
    name=0xb2dbde10 "bamboo31", namelen=8, 
    loc=0x8006cc90 "file:/etc/auto.net.generic", loclen=26, 
    options=0xb2dbdae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=bamboo31", 
    ctxt=0x8003a5b8) at parse_sun.c:657
#7  0xb7b6180a in parse_mount (ap=0x8004e860, name=0xb2dbde10 "bamboo31", 
    name_len=8, 
    mapent=0xb2dbdd80 "-rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=&\tfile:/etc/auto.net.generic", context=0x8003a5b8) at parse_sun.c:1458
#8  0xb7df8e70 in lookup_mount (ap=0x8004e860, name=0xb2dbf1c8 "bamboo31", 
    name_len=8, context=0x8004e7b0) at lookup_file.c:1136
#9  0x8001480c in do_lookup_mount (ap=0x8004e860, map=0x8003a6a0, 
    name=0xb2dbf1c8 "bamboo31", name_len=8) at lookup.c:668
#10 0x8001499a in lookup_name_file_source_instance (ap=0x8004e860, 
    map=0x8004e968, name=0xb2dbf1c8 "bamboo31", name_len=8) at lookup.c:708
#11 0x80015569 in lookup_nss_mount (ap=0x8004e860, source=0x0, 
    name=0xb2dbf1c8 "bamboo31", name_len=8) at lookup.c:856
#12 0x8000bfca in do_mount_indirect (arg=0x80051768) at indirect.c:892
#13 0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#14 0xb7ee302e in clone () from /lib/libc.so.6

Thread 4 (Thread 0xb2bbdb90 (LWP 19844)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f62c1e in __lll_mutex_lock_wait () from /lib/libpthread.so.0
#2  0xb7f5ea58 in _L_mutex_lock_86 () from /lib/libpthread.so.0
#3  0xb7f5e47d in pthread_mutex_lock () from /lib/libpthread.so.0
#4  0xb7a0c60e in mount_mount (ap=0x8004e860, root=0x8004e958 "/net", 
    name=0xb2bbbaa0 "bamboo32", name_len=8, what=0xb2bbba70 "file", 
    fstype=0xb2bbbac0 "autofs", 
    c_options=0xb2bbbae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=bamboo32", context=0x18) at mount_autofs.c:217
#5  0x80013c74 in do_mount (ap=0x8004e860, root=0x8004e958 "/net", 
    name=0xb2bbbaa0 "bamboo32", name_len=8, what=0xb2bbba70 "file", 
    fstype=0xb2bbbac0 "autofs", 
    options=0xb2bbbae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=bamboo32")
    at mount.c:73
#6  0xb7b60993 in sun_mount (ap=0x8004e860, root=0x8004e958 "/net", 
    name=0xb2bbbe10 "bamboo32", namelen=8, 
    loc=0x8008b610 "file:/etc/auto.net.generic", loclen=26, 
    options=0xb2bbbae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=bamboo32", 
    ctxt=0x8003a5b8) at parse_sun.c:657
#7  0xb7b6180a in parse_mount (ap=0x8004e860, name=0xb2bbbe10 "bamboo32", 
    name_len=8, 
    mapent=0xb2bbbd80 "-rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=&\tfile:/etc/auto.net.generic", context=0x8003a5b8) at parse_sun.c:1458
#8  0xb7df8e70 in lookup_mount (ap=0x8004e860, name=0xb2bbd1c8 "bamboo32", 
    name_len=8, context=0x8004e7b0) at lookup_file.c:1136
#9  0x8001480c in do_lookup_mount (ap=0x8004e860, map=0x8003a6a0, 
    name=0xb2bbd1c8 "bamboo32", name_len=8) at lookup.c:668
#10 0x8001499a in lookup_name_file_source_instance (ap=0x8004e860, 
    map=0x8004e968, name=0xb2bbd1c8 "bamboo32", name_len=8) at lookup.c:708
#11 0x80015569 in lookup_nss_mount (ap=0x8004e860, source=0x0, 
    name=0xb2bbd1c8 "bamboo32", name_len=8) at lookup.c:856
#12 0x8000bfca in do_mount_indirect (arg=0x800a8920) at indirect.c:892
#13 0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#14 0xb7ee302e in clone () from /lib/libc.so.6

Thread 3 (Thread 0xb6fdbb90 (LWP 19847)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f62c1e in __lll_mutex_lock_wait () from /lib/libpthread.so.0
#2  0xb7f5ea58 in _L_mutex_lock_86 () from /lib/libpthread.so.0
#3  0xb7f5e47d in pthread_mutex_lock () from /lib/libpthread.so.0
#4  0xb7a0c60e in mount_mount (ap=0x8004e860, root=0x8004e958 "/net", 
    name=0xb6fd9aa0 "bamboo23", name_len=8, what=0xb6fd9a70 "file", 
    fstype=0xb6fd9ac0 "autofs", 
    c_options=0xb6fd9ae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=bamboo23", context=0x18) at mount_autofs.c:217
#5  0x80013c74 in do_mount (ap=0x8004e860, root=0x8004e958 "/net", 
    name=0xb6fd9aa0 "bamboo23", name_len=8, what=0xb6fd9a70 "file", 
    fstype=0xb6fd9ac0 "autofs", 
    options=0xb6fd9ae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=bamboo23")
    at mount.c:73
#6  0xb7b60993 in sun_mount (ap=0x8004e860, root=0x8004e958 "/net", 
    name=0xb6fd9e10 "bamboo23", namelen=8, 
    loc=0x800b6118 "file:/etc/auto.net.generic", loclen=26, 
    options=0xb6fd9ae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=bamboo23", 
    ctxt=0x8003a5b8) at parse_sun.c:657
#7  0xb7b6180a in parse_mount (ap=0x8004e860, name=0xb6fd9e10 "bamboo23", 
    name_len=8, 
    mapent=0xb6fd9d80 "-rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=&\tfile:/etc/auto.net.generic", context=0x8003a5b8) at parse_sun.c:1458
#8  0xb7df8e70 in lookup_mount (ap=0x8004e860, name=0xb6fdb1c8 "bamboo23", 
    name_len=8, context=0x8004e7b0) at lookup_file.c:1136
#9  0x8001480c in do_lookup_mount (ap=0x8004e860, map=0x8003a6a0, 
    name=0xb6fdb1c8 "bamboo23", name_len=8) at lookup.c:668
#10 0x8001499a in lookup_name_file_source_instance (ap=0x8004e860, 
    map=0x8004e968, name=0xb6fdb1c8 "bamboo23", name_len=8) at lookup.c:708
#11 0x80015569 in lookup_nss_mount (ap=0x8004e860, source=0x0, 
    name=0xb6fdb1c8 "bamboo23", name_len=8) at lookup.c:856
#12 0x8000bfca in do_mount_indirect (arg=0x800c2718) at indirect.c:892
#13 0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#14 0xb7ee302e in clone () from /lib/libc.so.6

Thread 2 (Thread 0xb6bdeb90 (LWP 19862)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f62c1e in __lll_mutex_lock_wait () from /lib/libpthread.so.0
#2  0xb7f5ea58 in _L_mutex_lock_86 () from /lib/libpthread.so.0
#3  0xb7f5e47d in pthread_mutex_lock () from /lib/libpthread.so.0
#4  0xb7a0c60e in mount_mount (ap=0x8004e860, root=0x8004e958 "/net", 
    name=0xb6bdcaa0 "bamboo40", name_len=8, what=0xb6bdca70 "file", 
    fstype=0xb6bdcac0 "autofs", 
    c_options=0xb6bdcae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=bamboo40", context=0x6a040020) at mount_autofs.c:217
#5  0x80013c74 in do_mount (ap=0x8004e860, root=0x8004e958 "/net", 
    name=0xb6bdcaa0 "bamboo40", name_len=8, what=0xb6bdca70 "file", 
    fstype=0xb6bdcac0 "autofs", 
    options=0xb6bdcae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=bamboo40")
    at mount.c:73
#6  0xb7b60993 in sun_mount (ap=0x8004e860, root=0x8004e958 "/net", 
    name=0xb6bdce10 "bamboo40", namelen=8, 
    loc=0x80078d18 "file:/etc/auto.net.generic", loclen=26, 
    options=0xb6bdcae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=bamboo40", 
    ctxt=0x8003a5b8) at parse_sun.c:657
#7  0xb7b6180a in parse_mount (ap=0x8004e860, name=0xb6bdce10 "bamboo40", 
    name_len=8, 
    mapent=0xb6bdcd80 "-rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=&\tfile:/etc/auto.net.generic", context=0x8003a5b8) at parse_sun.c:1458
#8  0xb7df8e70 in lookup_mount (ap=0x8004e860, name=0xb6bde1c8 "bamboo40", 
    name_len=8, context=0x8004e7b0) at lookup_file.c:1136
#9  0x8001480c in do_lookup_mount (ap=0x8004e860, map=0x8003a6a0, 
    name=0xb6bde1c8 "bamboo40", name_len=8) at lookup.c:668
#10 0x8001499a in lookup_name_file_source_instance (ap=0x8004e860, 
    map=0x8004e968, name=0xb6bde1c8 "bamboo40", name_len=8) at lookup.c:708
#11 0x80015569 in lookup_nss_mount (ap=0x8004e860, source=0x0, 
    name=0xb6bde1c8 "bamboo40", name_len=8) at lookup.c:856
#12 0x8000bfca in do_mount_indirect (arg=0x800c1df0) at indirect.c:892
#13 0xb7f5c192 in start_thread () from /lib/libpthread.so.0
#14 0xb7ee302e in clone () from /lib/libc.so.6

Thread 1 (Thread 0xb7e1f6c0 (LWP 2784)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f642aa in do_sigwait () from /lib/libpthread.so.0
#2  0xb7f6434f in sigwait () from /lib/libpthread.so.0
#3  0x80008349 in main (argc=0, argv=0xbfe06228) at automount.c:1366
#0  0xffffe410 in __kernel_vsyscall ()
(gdb) The program is running.  Quit anyway (and detach it)? (y or n) [answered Y; input not from terminal]
Detaching from program: /usr/sbin/automount, process 2784
