From: Ian Kent <raven@themaw.net>
Subject: Re: clients suddenly start hanging (was: (no subject))
Date: Fri, 16 May 2008 11:00:04 +0800
Message-ID: <1210906804.3151.24.camel@raven.themaw.net>
References: <20080423185018.122C53C3B1@xena.cft.ca.us>
	<1210492627.3006.57.camel@raven.themaw.net>
	<20080515215941.6221B21124E@simba.math.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080515215941.6221B21124E@simba.math.ucla.edu>
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs@linux.kernel.org


On Thu, 2008-05-15 at 14:59 -0700, Jim Carter wrote:
> Unfortunately the last set of patches (1-8 for module and 1-3 for daemon)
> did not stop the hanging.  
> 
> Source: 5.0.3 with SuSE patches.
> http://download.opensuse.org/repositories/home:/makoenig/openSUSE_10.3/src/autofs-5.0.3-6.1.src.rpm
> 
> Addtional module patches:
> PATCH 1/8] autofs4 - check for invalid dentry in getpath
> PATCH 2/8] autofs4 - fix sparse warning in waitq.c:autofs4_expire_indirect()
> PATCH 3/8] autofs4 - fix execution order race in mount request code
> PATCH 4/8] autofs4 - fix incorrect return from root.c:try_to_fill_dentry()
> PATCH 5/8] autofs4 - fix mntput, dput order bug
> PATCH 6/8] autofs4 - use struct qstr in waitq.c
> PATCH 7/8] autofs4 - don't release directory mutex if called in oz_mode
> PATCH 8/8] autofs4 - fix pending mount race.
> 
> Additional daemon patches:
> Patch17:        autofs-5.0.2-dns-name-lookup.patch
> Patch28:        autofs-5.0.3-dont-fail-on-empty-master-fix-2.patch
> Patch29:        autofs-5.0.3-mount-thread-create-cond-handling.patch
> Patch30:        autofs-5.0.3-submount-shutdown-recovery-5.patch
> 
> (All patches went on cleanly.)

At least I got that right, ;)


> Thread 3 (Thread 0x78ee9b90 (LWP 11528)):
> #0  0xffffe410 in __kernel_vsyscall ()
> #1  0xb7f52566 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib/libpthread.so.0
> #2  0x800215b7 in master_notify_submount (ap=0x8004e8a8, 
>     path=0x800a9630 "/net/bamboo45", state=ST_EXPIRE) at master.c:908
> #3  0x8000c90d in expire_proc_indirect (arg=0x800825e8) at indirect.c:468
> #4  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
> #5  0xb7ed502e in clone () from /lib/libc.so.6

I'm still missing the signal.
I'll have to take a long hard look at this code.

> 
> Thread 2 (Thread 0x78feab90 (LWP 12138)):
> #0  0xffffe410 in __kernel_vsyscall ()
> #1  0xb7f54c1e in __lll_mutex_lock_wait () from /lib/libpthread.so.0
> #2  0xb7f50a58 in _L_mutex_lock_86 () from /lib/libpthread.so.0
> #3  0xb7f5047d in pthread_mutex_lock () from /lib/libpthread.so.0
> #4  0xb79fe60e in mount_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
>     name=0x78fe8aa0 "bamboo14", name_len=8, what=0x78fe8a70 "file", 
>     fstype=0x78fe8ac0 "autofs", 
>     c_options=0x78fe8ae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=bamboo14", context=0x18) at mount_autofs.c:217
> #5  0x80013984 in do_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
>     name=0x78fe8aa0 "bamboo14", name_len=8, what=0x78fe8a70 "file", 
>     fstype=0x78fe8ac0 "autofs", 
>     options=0x78fe8ae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=bamboo14")
>     at mount.c:73
> #6  0xb7b52993 in sun_mount (ap=0x8004e8a8, root=0x8004e9a0 "/net", 
>     name=0x78fe8e10 "bamboo14", namelen=8, 
>     loc=0x80091e18 "file:/etc/auto.net.generic", loclen=26, 
>     options=0x78fe8ae0 "rsize=8192,wsize=8192,retry=1,soft,-DSERVER=bamboo14", 
>     ctxt=0x8003a600) at parse_sun.c:657
> #7  0xb7b5380a in parse_mount (ap=0x8004e8a8, name=0x78fe8e10 "bamboo14", 
>     name_len=8, 
>     mapent=0x78fe8d80 "-rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=&\tfile:/etc/auto.net.generic", context=0x8003a600) at parse_sun.c:1458
> #8  0xb7deae70 in lookup_mount (ap=0x8004e8a8, name=0x78fea1c8 "bamboo14", 
>     name_len=8, context=0x8004e7f8) at lookup_file.c:1136
> #9  0x8001451c in do_lookup_mount (ap=0x8004e8a8, map=0x8003a6e8, 
>     name=0x78fea1c8 "bamboo14", name_len=8) at lookup.c:668
> #10 0x800146aa in lookup_name_file_source_instance (ap=0x8004e8a8, 
>     map=0x8004e9b0, name=0x78fea1c8 "bamboo14", name_len=8) at lookup.c:708
> #11 0x80015279 in lookup_nss_mount (ap=0x8004e8a8, source=0x0, 
>     name=0x78fea1c8 "bamboo14", name_len=8) at lookup.c:856
> #12 0x8000be7a in do_mount_indirect (arg=0x800928f8) at indirect.c:883
> #13 0xb7f4e192 in start_thread () from /lib/libpthread.so.0
> #14 0xb7ed502e in clone () from /lib/libc.so.6

And this is excepted as it's waiting for the mutex taken in
master_notify_submount(), as it should, but master_notify_submount()
can't complete its task because it is waiting for a thread to tell it it
has finished or continued.

*sigh*
Ian
