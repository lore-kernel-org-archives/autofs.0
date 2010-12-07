From: Ian Kent <ikent@redhat.com>
Subject: Re: Automouter crashed, I have the core
Date: Tue, 07 Dec 2010 20:21:06 +0800
Message-ID: <1291724466.16875.6.camel@perseus>
References: <4CFE0736.8050606@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4CFE0736.8050606@s3group.cz>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ondrej Valousek <webserv@s3group.cz>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Tue, 2010-12-07 at 11:06 +0100, Ondrej Valousek wrote:
> Hi Ian,
> 
> Automouter (autofs-5.0.1-0.rc2.143.el5) crashed on one of my RHEL-5
> machine. I know it is a bit obsolete, but I have the core.
> Backtrace unveiled this:
> 
> (gdb) thr a a bt
> 
> Thread 14 (Thread 16653):
> #0  0x00002ad92c9e0838 in do_sigwait () from /lib64/libpthread.so.0
> #1  0x00002ad92c9e08dd in sigwait () from /lib64/libpthread.so.0
> #2  0x00002ad92c57759d in statemachine (arg=<value optimized out>) at automount.c:1315
> #3  0x00002ad92c57874b in main (argc=1243070480, argv=<value optimized out>) at automount.c:2143
> 
> Thread 13 (Thread 16654):
> #0  0x00002ad92c9dd150 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
> #1  0x00002ad92c58c61c in alarm_handler (arg=<value optimized out>) at alarm.c:226
> #2  0x00002ad92c9d873d in start_thread () from /lib64/libpthread.so.0
> #3  0x00002ad92d8a8d1d in clone () from /lib64/libc.so.6
> 
> Thread 12 (Thread 16655):
> #0  0x00002ad92c9dd150 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
> #1  0x00002ad92c585c48 in st_queue_handler (arg=<value optimized out>) at state.c:1117
> #2  0x00002ad92c9d873d in start_thread () from /lib64/libpthread.so.0
> #3  0x00002ad92d8a8d1d in clone () from /lib64/libc.so.6
> 
> Thread 11 (Thread 16658):
> #0  0x00002ad92d89ff36 in poll () from /lib64/libc.so.6
> #1  0x00002ad92c57a244 in get_pkt (arg=0x7fffc5131930) at automount.c:866
> #2  handle_packet (arg=0x7fffc5131930) at automount.c:1026
> #3  handle_mounts (arg=0x7fffc5131930) at automount.c:1538
> #4  0x00002ad92c9d873d in start_thread () from /lib64/libpthread.so.0
> #5  0x00002ad92d8a8d1d in clone () from /lib64/libc.so.6
> 
> Thread 10 (Thread 16661):
> #0  0x00002ad92d89ff36 in poll () from /lib64/libc.so.6
> #1  0x00002ad92c57a244 in get_pkt (arg=0x7fffc5131930) at automount.c:866
> #2  handle_packet (arg=0x7fffc5131930) at automount.c:1026
> #3  handle_mounts (arg=0x7fffc5131930) at automount.c:1538
> #4  0x00002ad92c9d873d in start_thread () from /lib64/libpthread.so.0
> #5  0x00002ad92d8a8d1d in clone () from /lib64/libc.so.6
> 
> Thread 9 (Thread 16668):
> #0  0x00002ad92d89ff36 in poll () from /lib64/libc.so.6
> #1  0x00002ad92c57a244 in get_pkt (arg=0x7fffc5131930) at automount.c:866
> #2  handle_packet (arg=0x7fffc5131930) at automount.c:1026
> #3  handle_mounts (arg=0x7fffc5131930) at automount.c:1538
> #4  0x00002ad92c9d873d in start_thread () from /lib64/libpthread.so.0
> #5  0x00002ad92d8a8d1d in clone () from /lib64/libc.so.6
> 
> Thread 8 (Thread 16669):
> #0  0x00002ad92d89ff36 in poll () from /lib64/libc.so.6
> #1  0x00002ad92c57a244 in get_pkt (arg=0x7fffc5131930) at automount.c:866
> ---Type <return> to continue, or q <return> to quit---
> #2  handle_packet (arg=0x7fffc5131930) at automount.c:1026
> #3  handle_mounts (arg=0x7fffc5131930) at automount.c:1538
> #4  0x00002ad92c9d873d in start_thread () from /lib64/libpthread.so.0
> #5  0x00002ad92d8a8d1d in clone () from /lib64/libc.so.6
> 
> Thread 7 (Thread 16678):
> #0  0x00002ad92c9df4c4 in __lll_lock_wait () from /lib64/libpthread.so.0
> #1  0x00002ad92c9dd238 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
> #2  0x00002ad92c57ca39 in handle_packet_expire_indirect (ap=<value optimized out>, pkt=<value optimized out>) at indirect.c:678
> #3  0x00002ad92c57a792 in handle_packet (arg=0x7fffc5131930) at automount.c:1039
> #4  handle_mounts (arg=0x7fffc5131930) at automount.c:1538
> #5  0x00002ad92c9d873d in start_thread () from /lib64/libpthread.so.0
> #6  0x00002ad92d8a8d1d in clone () from /lib64/libc.so.6
> 
> Thread 6 (Thread 16687):
> #0  0x00002ad92d89ff36 in poll () from /lib64/libc.so.6
> #1  0x00002ad92c57a244 in get_pkt (arg=0x7fffc5131930) at automount.c:866
> #2  handle_packet (arg=0x7fffc5131930) at automount.c:1026
> #3  handle_mounts (arg=0x7fffc5131930) at automount.c:1538
> #4  0x00002ad92c9d873d in start_thread () from /lib64/libpthread.so.0
> #5  0x00002ad92d8a8d1d in clone () from /lib64/libc.so.6
> 
> Thread 5 (Thread 16688):
> #0  0x00002ad92d89ff36 in poll () from /lib64/libc.so.6
> #1  0x00002ad92c57a244 in get_pkt (arg=0x7fffc5131930) at automount.c:866
> #2  handle_packet (arg=0x7fffc5131930) at automount.c:1026
> #3  handle_mounts (arg=0x7fffc5131930) at automount.c:1538
> #4  0x00002ad92c9d873d in start_thread () from /lib64/libpthread.so.0
> #5  0x00002ad92d8a8d1d in clone () from /lib64/libc.so.6
> 
> Thread 4 (Thread 16689):
> #0  0x00002ad92d89ff36 in poll () from /lib64/libc.so.6
> #1  0x00002ad92c57a244 in get_pkt (arg=0x7fffc5131930) at automount.c:866
> #2  handle_packet (arg=0x7fffc5131930) at automount.c:1026
> #3  handle_mounts (arg=0x7fffc5131930) at automount.c:1538
> #4  0x00002ad92c9d873d in start_thread () from /lib64/libpthread.so.0
> #5  0x00002ad92d8a8d1d in clone () from /lib64/libc.so.6
> 
> Thread 3 (Thread 24338):
> #0  0x00002ad92c9e01c1 in nanosleep () from /lib64/libpthread.so.0
> #1  0x00002ad92c591080 in expire (logopt=0, cmd=<value optimized out>, fd=33, ioctlfd=33, path=<value optimized out>, arg=0x4607b044)
>     at dev-ioctl-lib.c:684
> #2  0x00002ad92c59112e in ioctl_expire (logopt=1174908896, ioctlfd=-1, path=0x2ad94a3959a0 "/appli/local_Linux", when=0) at dev-ioctl-lib.c:713
> #3  0x00002ad92c57bbfd in expire_proc_indirect (arg=<value optimized out>) at indirect.c:483
> #4  0x00002ad92c9d873d in start_thread () from /lib64/libpthread.so.0
> #5  0x00002ad92d8a8d1d in clone () from /lib64/libc.so.6
> ---Type <return> to continue, or q <return> to quit---
> 
> Thread 2 (Thread 24339):
> #0  0x00002ad92d8a1647 in ioctl () from /lib64/libc.so.6
> #1  0x00002ad92c59106e in expire (logopt=0, cmd=<value optimized out>, fd=15, ioctlfd=15, path=0x2ad94a397840 "/home/donnacha", arg=0x4667e044)
>     at dev-ioctl-lib.c:669
> #2  0x00002ad92c59112e in ioctl_expire (logopt=15, ioctlfd=-1, path=0x2ad94a397840 "/home/donnacha", when=0) at dev-ioctl-lib.c:713
> #3  0x00002ad92c57bbfd in expire_proc_indirect (arg=<value optimized out>) at indirect.c:483
> #4  0x00002ad92c9d873d in start_thread () from /lib64/libpthread.so.0
> #5  0x00002ad92d8a8d1d in clone () from /lib64/libc.so.6
> 
> Thread 1 (Thread 24347):
> #0  0x00002ad92d805265 in raise () from /lib64/libc.so.6
> #1  0x00002ad92d806d10 in abort () from /lib64/libc.so.6
> #2  0x00002ad92d83f84b in __libc_message () from /lib64/libc.so.6
> #3  0x00002ad92d84730f in _int_free () from /lib64/libc.so.6
> #4  0x00002ad92d84776b in free () from /lib64/libc.so.6
> #5  0x00002ad92d8431d8 in _IO_free_backup_area_internal () from /lib64/libc.so.6
> #6  0x00002ad92d843825 in __uflow () from /lib64/libc.so.6
> #7  0x00002ad92d8376b4 in _IO_getline_info_internal () from /lib64/libc.so.6
> #8  0x00002ad92d83ffc9 in fgets_unlocked () from /lib64/libc.so.6
> #9  0x00002ad92d8a32da in getmntent_r () from /lib64/libc.so.6
> #10 0x00002ad92c588e98 in table_is_mounted (table=0x405ffee0 "\020\377_@", path=0x406040c0 "/home/janpl", type=2) at mounts.c:419

The table parameter is a constant string, that proably isn't right but
maybe a clue.

> #11 is_mounted (table=0x405ffee0 "\020\377_@", path=0x406040c0 "/home/janpl", type=2) at mounts.c:472
> #12 0x00002ad92c57940d in walk_tree (base=0x5f1b <Address 0x5f1b out of bounds>, fn=0x2ad92c5796b0 <rm_unwanted_fn>, incl=0, logopt=4294967295,
>     arg=0x80) at automount.c:249
> #13 0x00002ad92c57969f in rm_unwanted (logopt=4294967295, path=0x0, incl=6, dev=25) at automount.c:342

The path argument being null at this point probably isn't true either.

> #14 0x00002ad92c579c82 in check_rm_dirs (ap=0x2ad94a190100, path=0x406040c6 "janpl", incl=1) at automount.c:397
> #15 umount_multi (ap=0x2ad94a190100, path=0x406040c6 "janpl", incl=1) at automount.c:553
> #16 0x00002ad92c579de0 in do_expire (ap=0x2ad94a190100, name=<value optimized out>, namelen=<value optimized out>) at automount.c:931
> #17 0x00002ad92c57bfb4 in do_expire_indirect (arg=0x2aaab0001300) at indirect.c:602
> #18 0x00002ad92c9d873d in start_thread () from /lib64/libpthread.so.0
> #19 0x00002ad92d8a8d1d in clone () from /lib64/libc.so.6
> 
> Is it immediately obvious to you what happened?

Unfortunately not but there certainly is a mistake in this area
somewhere.

I have another report of a hang with very similar symptoms but a thread
that should have existed in the back trace had simply disappeared. That
thread should have been an expire callback just like the one you have
here. So this is really useful to know but I haven't worked it out yet.

 
> 
> Thanks,
> Ondrej
> 
