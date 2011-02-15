From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: 5.0.5 non-expiring mounts
Date: Tue, 15 Feb 2011 16:11:22 -0200
Message-ID: <AANLkTi=fSs58yKLnWFLLDk-ep+wDbqNLpj0r9AZUjZ+Y@mail.gmail.com>
References: <4D510D53.7010507@gmail.com>
	<20110215011037.GT27735@sunapee.qualcomm.com>
	<1297739464.13007.8.camel@perseus>
	<1297741021.13007.12.camel@perseus>
	<20110215052857.GV27735@sunapee.qualcomm.com>
	<1297772933.13007.28.camel@perseus>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-type
	:content-transfer-encoding;
	bh=L0FS+/0WWCi6Pc1iXpyXpJROLNalmdNRiVVFWN/DFmA=;
	b=LWok3VE2r7NdpDAhVgu0z2Ug1koWkPjkItu+Hie/jyMDcoRhlo+rToHt7GtaSqh8tl
	kK7m95iTovs0jh50YTo3K0xt+NUtL07mYwmcGmQyjwsSxRx4vC8+XiUVBv3JBEbpH9pE
	s+YumMmKmX/bxWsVVpzxBFzrvysaR/sSza3uk=
In-Reply-To: <1297772933.13007.28.camel@perseus>
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
To: Ian Kent <raven@themaw.net>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>, Mike Marion <mmarion@qualcomm.com>

On Tue, Feb 15, 2011 at 10:28 AM, Ian Kent <raven@themaw.net> wrote:
> On Mon, 2011-02-14 at 21:28 -0800, Mike Marion wrote:
>> On Mon, Feb 14, 2011 at 07:37:01PM -0800, Ian Kent wrote:
>>
>> > That is kernel revision and autofs revision?
>>
>> 2.6.16.60-0.59.1 (Sles10 sp3 with an updated, but not bleeding edge, pat=
ch).
>> autofs 5.0.5 with most of the patches up to a couple months ago. =A0It's=
 hard to
>> get exacts because it's a PTF from Novell (we really pushed them to upgr=
ade to
>> 5.0.5) but it should be pretty much equal to the patch they just release=
d for
>> sle 11 sp1 that they're recommending as they default going forward.
>
> That make it hard, as you know.
>
> But I wouldn't mind spending a bit of time on it, if you can also.
>
> Let's assume that it's a user space problem for now.

Here are the call traces for all automount processes on the kernel side:

PID: 4017   TASK: ffff8104202a9080  CPU: 4   COMMAND: "automount"
 #0 [ffff81040426fc58] schedule at ffffffff802efc13
 #1 [ffff81040426fd30] schedule_timeout at ffffffff802f0748
 #2 [ffff81040426fd80] futex_wait_abstime at ffffffff8014b703
 #3 [ffff81040426fe60] do_futex at ffffffff8014bb33
 #4 [ffff81040426ff20] sys_futex at ffffffff8014c2ed
 #5 [ffff81040426ff80] system_call at ffffffff8010ae16

PID: 4018   TASK: ffff81041cefd810  CPU: 2   COMMAND: "automount"
 #0 [ffff810404211d68] schedule at ffffffff802efc13
 #1 [ffff810404211e40] schedule_timeout at ffffffff802f07b4
 #2 [ffff810404211e90] futex_wait_abstime at ffffffff8014b703
 #3 [ffff810404211f70] futex_wait_restart at ffffffff8014b7d2
 #4 [ffff810404211f80] system_call at ffffffff8010ae16

PID: 4019   TASK: ffff810420ab8080  CPU: 5   COMMAND: "automount"
 #0 [ffff810404213c58] schedule at ffffffff802efc13
 #1 [ffff810404213d30] schedule_timeout at ffffffff802f0748
 #2 [ffff810404213d80] futex_wait_abstime at ffffffff8014b703
 #3 [ffff810404213e60] do_futex at ffffffff8014bb33
 #4 [ffff810404213f20] sys_futex at ffffffff8014c2ed
 #5 [ffff810404213f80] system_call at ffffffff8010ae16

PID: 4022   TASK: ffff81042055b7d0  CPU: 5   COMMAND: "automount"
 #0 [ffff810404c71c58] schedule at ffffffff802efc13
 #1 [ffff810404c71d30] schedule_timeout at ffffffff802f0748
 #2 [ffff810404c71d80] futex_wait_abstime at ffffffff8014b703
 #3 [ffff810404c71e60] do_futex at ffffffff8014bb33
 #4 [ffff810404c71f20] sys_futex at ffffffff8014c2ed
 #5 [ffff810404c71f80] system_call at ffffffff8010ae16

PID: 4025   TASK: ffff81041cefd080  CPU: 2   COMMAND: "automount"
 #0 [ffff8104001d7da8] schedule at ffffffff802efc13
 #1 [ffff8104001d7e80] schedule_timeout at ffffffff802f07b4
 #2 [ffff8104001d7ed0] do_sys_poll at ffffffff80199526
 #3 [ffff8104001d7f60] sys_poll at ffffffff80199640
 #4 [ffff8104001d7f80] system_call at ffffffff8010ae16

PID: 4026   TASK: ffff81041e1bd080  CPU: 7   COMMAND: "automount"
 #0 [ffff8104001f7c58] schedule at ffffffff802efc13
 #1 [ffff8104001f7d30] schedule_timeout at ffffffff802f0748
 #2 [ffff8104001f7d80] futex_wait_abstime at ffffffff8014b703
 #3 [ffff8104001f7e60] do_futex at ffffffff8014bb33
 #4 [ffff8104001f7f20] sys_futex at ffffffff8014c2ed
 #5 [ffff8104001f7f80] system_call at ffffffff8010ae16

PID: 6851   TASK: ffff81013c9187d0  CPU: 6   COMMAND: "automount"
 #0 [ffff810304f97c58] schedule at ffffffff802efc13
 #1 [ffff810304f97d30] schedule_timeout at ffffffff802f0748
 #2 [ffff810304f97d80] futex_wait_abstime at ffffffff8014b703
 #3 [ffff810304f97e60] do_futex at ffffffff8014bb33
 #4 [ffff810304f97f20] sys_futex at ffffffff8014c2ed
 #5 [ffff810304f97f80] system_call at ffffffff8010ae16

PID: 7060   TASK: ffff810188ef5080  CPU: 4   COMMAND: "automount"
 #0 [ffff810319ebdc58] schedule at ffffffff802efc13
 #1 [ffff810319ebdd30] schedule_timeout at ffffffff802f0748
 #2 [ffff810319ebdd80] futex_wait_abstime at ffffffff8014b703
 #3 [ffff810319ebde60] do_futex at ffffffff8014bb33
 #4 [ffff810319ebdf20] sys_futex at ffffffff8014c2ed
 #5 [ffff810319ebdf80] system_call at ffffffff8010ae16

PID: 20702  TASK: ffff810230be5080  CPU: 7   COMMAND: "automount"
 #0 [ffff81026c80dc18] schedule at ffffffff802efc13
 #1 [ffff81026c80dcf0] autofs4_wait at ffffffff8831e5b2 [autofs4]
 #2 [ffff81026c80deb0] autofs4_expire_multi at ffffffff8831ed06 [autofs4]
 #3 [ffff81026c80dee0] do_ioctl at ffffffff80198acd
 #4 [ffff81026c80df00] vfs_ioctl at ffffffff80198d2b
 #5 [ffff81026c80df40] sys_ioctl at ffffffff80198da5
 #6 [ffff81026c80df80] system_call at ffffffff8010ae16

They look regular to me, do you see something suspect?

And here are the call traces from the user land daemon:

Thread 9 (Thread 4017):
#0  0x00002b56e465d6a8 in __lll_mutex_lock_wait () from /lib64/libpthread.s=
o.0
#1  0x00002b56e46599fb in _L_mutex_lock_92 () from /lib64/libpthread.so.0
#2  0x00002b56e4659455 in pthread_mutex_lock () from /lib64/libpthread.so.0
#3  0x00005555555746cd in master_mutex_lock () at master.c:49
#4  0x000055555555d260 in do_hup_signal (master=3D0x55555568d010, age=3D129=
6063258)
    at automount.c:1276
#5  0x0000555555560bd3 in statemachine (arg=3D<value optimized out>)
    at automount.c:1354
#6  main (arg=3D<value optimized out>) at automount.c:2142

Thread 8 (Thread 20702):
#0  0x00002b56e4dd62a7 in brk () from /lib64/libc.so.6
#1  0x0000555555577dfe in expire (logopt=3D2, cmd=3D<value optimized out>, =
fd=3D21,
    ioctlfd=3D21, path=3D0x55555569ca20 "/usr2", arg=3D0x41c27ef4)
    at dev-ioctl-lib.c:657
#2  0x0000555555577ebe in ioctl_expire (logopt=3D21, ioctlfd=3D-1,
    path=3D0x55555569ca20 "/usr2", when=3D0) at dev-ioctl-lib.c:701
#3  0x0000555555561e4e in expire_proc_indirect (arg=3D<value optimized out>)
    at indirect.c:545
#4  0x00002b56e4657193 in start_thread () from /lib64/libpthread.so.0
#5  0x00002b56e4ddcdfd in sysctl () from /lib64/libc.so.6
#6  0x0000000000000000 in ?? ()

Thread 7 (Thread 7060):
#0  0x00002b56e465ac77 in pthread_rwlock_wrlock () from /lib64/libpthread.s=
o.0
#1  0x00005555555752ea in master_source_writelock (entry=3D<value optimized=
 out>)
    at master.c:527
#2  0x0000555555575f8f in master_add_map_source (entry=3D0x5555556a10b0,
    type=3D0x0, format=3D0x0, age=3D1296059657, argc=3D1, argv=3D<value opt=
imized out>)
    at master.c:191
#3  0x0000555555579ee3 in master_parse_entry (buffer=3D<value optimized out=
>,
    default_timeout=3D86400, logging=3D<value optimized out>, age=3D1296059=
657)
    at master_parse.y:823
#4  0x00002aaaaaab83fe in lookup_read_master (master=3D<value optimized out=
>,
    age=3D1296059657, context=3D<value optimized out>) at lookup_ldap.c:1625
#5  0x0000555555569052 in do_read_master (master=3D0x55555568d010,
    type=3D<value optimized out>, age=3D1296059657) at lookup.c:96
#6  0x000055555556aa3c in lookup_nss_read_master (master=3D0x55555568d010,
    age=3D1296059657) at lookup.c:229
#7  0x0000555555575c28 in master_read_master (master=3D0x55555568d010,
    age=3D1296059657, readall=3D1) at master.c:831
#8  0x000055555555d844 in do_read_master (arg=3D<value optimized out>)
    at automount.c:1259
#9  0x00002b56e4657193 in start_thread () from /lib64/libpthread.so.0
#10 0x00002b56e4ddcdfd in sysctl () from /lib64/libc.so.6
#11 0x0000000000000000 in ?? ()

Thread 6 (Thread 6851):
#0  0x00002b56e465aa3d in pthread_rwlock_rdlock () from /lib64/libpthread.s=
o.0
#1  0x000055555556deb6 in cache_readlock (mc=3D0x55555568e5b8) at cache.c:60
#2  0x000055555556baff in do_readmap (arg=3D<value optimized out>) at state=
.c:479
#3  0x00002b56e4657193 in start_thread () from /lib64/libpthread.so.0
#4  0x00002b56e4ddcdfd in sysctl () from /lib64/libc.so.6
#5  0x0000000000000000 in ?? ()

Thread 5 (Thread 4026):
#0  0x00002b56e465d6a8 in __lll_mutex_lock_wait () from /lib64/libpthread.s=
o.0
#1  0x00002b56e46599fb in _L_mutex_lock_92 () from /lib64/libpthread.so.0
#2  0x00002b56e4659455 in pthread_mutex_lock () from /lib64/libpthread.so.0
#3  0x00005555555746cd in master_mutex_lock () at master.c:49
#4  0x0000555555560ff9 in handle_packet_missing_indirect (ap=3D0x55555569c9=
40,
    pkt=3D0x41823ec0) at indirect.c:808
#5  0x000055555555fa32 in handle_packet (ap=3D<value optimized out>)
    at automount.c:1026
#6  handle_mounts (ap=3D<value optimized out>) at automount.c:1551
#7  0x00002b56e4657193 in start_thread () from /lib64/libpthread.so.0
#8  0x00002b56e4ddcdfd in sysctl () from /lib64/libc.so.6
#9  0x0000000000000000 in ?? ()

Thread 4 (Thread 4025):
#0  0x00002b56e4dd4b26 in fts_read () from /lib64/libc.so.6
#1  0x00007fff37314e80 in ?? ()
#2  0x0000000000000000 in ?? ()

Thread 3 (Thread 4022):
#0  0x00002b56e465ac77 in pthread_rwlock_wrlock () from /lib64/libpthread.s=
o.0
#1  0x00005555555752ea in master_source_writelock (entry=3D<value optimized=
 out>)
    at master.c:527
#2  0x00005555555631af in handle_packet_missing_direct (ap=3D0x5555556a11c0,
    pkt=3D0x40821ec0) at direct.c:1296
#3  0x000055555555fa1d in handle_packet (ap=3D<value optimized out>)
    at automount.c:1029
#4  handle_mounts (ap=3D<value optimized out>) at automount.c:1551
#5  0x00002b56e4657193 in start_thread () from /lib64/libpthread.so.0
#6  0x00002b56e4ddcdfd in sysctl () from /lib64/libc.so.6
#7  0x0000000000000000 in ?? ()

Thread 2 (Thread 4019):
#0  0x00002b56e465b326 in pthread_cond_wait@@GLIBC_2.3.2 ()
   from /lib64/libpthread.so.0
#1  0x000055555556c8b3 in st_queue_handler (arg=3D<value optimized out>)
    at state.c:1104
#2  0x00002b56e4657193 in start_thread () from /lib64/libpthread.so.0
#3  0x00002b56e4ddcdfd in sysctl () from /lib64/libc.so.6
#4  0x0000000000000000 in ?? ()

Thread 1 (Thread 4018):
#0  0x00002b56e465b517 in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib64/libpthread.so.0
#1  0x0000555555573762 in alarm_handler (arg=3D<value optimized out>)
    at alarm.c:206
#2  0x00002b56e4657193 in start_thread () from /lib64/libpthread.so.0
#3  0x00002b56e4ddcdfd in sysctl () from /lib64/libc.so.6
#4  0x0000000000000000 in ?? ()

> Could you post a debug log somewhere and the current sles patched source
> somewhere.

Unfortunately I don't have the full debug logs yet, so I'll leave this to
Mike.

> If you could spend a little time trying to compare the
> patches in the sles package to the ones in the Rawhide autofs repo that
> would be a big help too.

The package includes all upstream patches released so far (ie, up to
autofs-5.0.5-fix-submount-shutdown-wait.patch), minus the following ones:

autofs-5.0.4 - use intr option as hosts mount default (configuration change)
autofs-5.0.5 - add dump maps option (recent feature)
autofs-5.0.5 - add external bind method (recent feature)
autofs-5.0.5 - fix ext4 fsck at mount (no ext4 on SLES 10)

Thanks,
Leonardo
