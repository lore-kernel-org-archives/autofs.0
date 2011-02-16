From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: 5.0.5 non-expiring mounts
Date: Wed, 16 Feb 2011 10:58:55 -0200
Message-ID: <AANLkTim7MQKcdrPXZEs4UCX5B6vxRRANLoTuLJfT+CBh@mail.gmail.com>
References: <4D510D53.7010507@gmail.com>
	<20110215011037.GT27735@sunapee.qualcomm.com>
	<1297739464.13007.8.camel@perseus>
	<1297741021.13007.12.camel@perseus>
	<20110215052857.GV27735@sunapee.qualcomm.com>
	<1297772933.13007.28.camel@perseus>
	<AANLkTi=fSs58yKLnWFLLDk-ep+wDbqNLpj0r9AZUjZ+Y@mail.gmail.com>
	<1297840085.2825.8.camel@perseus>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-type
	:content-transfer-encoding;
	bh=Xz1NQcM94hnq28K2N6mFxTbNdSWYyhSVTISO7IKhMbs=;
	b=LtK3MstUUx1A28GT85sDES9/xc+Zs6QHfWtZ7KVPJRcqOp9+pBRbf0Mz4c/5yimBpM
	jZZaSeM9iK0dThvalxe2IbYHz5H3zawaVH9Qt/DIuPifEbqtfbL2QM6QmHWSEu+XsqpS
	uaMCxgSvN04f/JsdFUvU89leQ9H/D9e2ThazI=
In-Reply-To: <1297840085.2825.8.camel@perseus>
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

On Wed, Feb 16, 2011 at 5:08 AM, Ian Kent <raven@themaw.net> wrote:
> On Tue, 2011-02-15 at 16:11 -0200, Leonardo Chiquitto wrote:
>> On Tue, Feb 15, 2011 at 10:28 AM, Ian Kent <raven@themaw.net> wrote:
>> > On Mon, 2011-02-14 at 21:28 -0800, Mike Marion wrote:
>> >> On Mon, Feb 14, 2011 at 07:37:01PM -0800, Ian Kent wrote:
>> >>
>> >> > That is kernel revision and autofs revision?
>> >>
>> >> 2.6.16.60-0.59.1 (Sles10 sp3 with an updated, but not bleeding edge, =
patch).
>> >> autofs 5.0.5 with most of the patches up to a couple months ago. =A0I=
t's hard to
>> >> get exacts because it's a PTF from Novell (we really pushed them to u=
pgrade to
>> >> 5.0.5) but it should be pretty much equal to the patch they just rele=
ased for
>> >> sle 11 sp1 that they're recommending as they default going forward.
>> >
>> > That make it hard, as you know.
>> >
>> > But I wouldn't mind spending a bit of time on it, if you can also.
>> >
>> > Let's assume that it's a user space problem for now.
>>
>> Here are the call traces for all automount processes on the kernel side:
>
> I think it's a user space problem.
>
> snip ...
>
>> And here are the call traces from the user land daemon:
>>
>> Thread 9 (Thread 4017):
>> #0 =A00x00002b56e465d6a8 in __lll_mutex_lock_wait () from /lib64/libpthr=
ead.so.0
>> #1 =A00x00002b56e46599fb in _L_mutex_lock_92 () from /lib64/libpthread.s=
o.0
>> #2 =A00x00002b56e4659455 in pthread_mutex_lock () from /lib64/libpthread=
.so.0
>> #3 =A00x00005555555746cd in master_mutex_lock () at master.c:49
>> #4 =A00x000055555555d260 in do_hup_signal (master=3D0x55555568d010, age=
=3D1296063258)
>> =A0 =A0 at automount.c:1276
>> #5 =A00x0000555555560bd3 in statemachine (arg=3D<value optimized out>)
>> =A0 =A0 at automount.c:1354
>> #6 =A0main (arg=3D<value optimized out>) at automount.c:2142
>>
>> Thread 8 (Thread 20702):
>> #0 =A00x00002b56e4dd62a7 in brk () from /lib64/libc.so.6
>> #1 =A00x0000555555577dfe in expire (logopt=3D2, cmd=3D<value optimized o=
ut>, fd=3D21,
>> =A0 =A0 ioctlfd=3D21, path=3D0x55555569ca20 "/usr2", arg=3D0x41c27ef4)
>> =A0 =A0 at dev-ioctl-lib.c:657
>> #2 =A00x0000555555577ebe in ioctl_expire (logopt=3D21, ioctlfd=3D-1,
>> =A0 =A0 path=3D0x55555569ca20 "/usr2", when=3D0) at dev-ioctl-lib.c:701
>> #3 =A00x0000555555561e4e in expire_proc_indirect (arg=3D<value optimized=
 out>)
>> =A0 =A0 at indirect.c:545
>> #4 =A00x00002b56e4657193 in start_thread () from /lib64/libpthread.so.0
>> #5 =A00x00002b56e4ddcdfd in sysctl () from /lib64/libc.so.6
>> #6 =A00x0000000000000000 in ?? ()
>>
>> Thread 7 (Thread 7060):
>> #0 =A00x00002b56e465ac77 in pthread_rwlock_wrlock () from /lib64/libpthr=
ead.so.0
>> #1 =A00x00005555555752ea in master_source_writelock (entry=3D<value opti=
mized out>)
>> =A0 =A0 at master.c:527
>> #2 =A00x0000555555575f8f in master_add_map_source (entry=3D0x5555556a10b=
0,
>> =A0 =A0 type=3D0x0, format=3D0x0, age=3D1296059657, argc=3D1, argv=3D<va=
lue optimized out>)
>> =A0 =A0 at master.c:191
>> #3 =A00x0000555555579ee3 in master_parse_entry (buffer=3D<value optimize=
d out>,
>> =A0 =A0 default_timeout=3D86400, logging=3D<value optimized out>, age=3D=
1296059657)
>> =A0 =A0 at master_parse.y:823
>> #4 =A00x00002aaaaaab83fe in lookup_read_master (master=3D<value optimize=
d out>,
>> =A0 =A0 age=3D1296059657, context=3D<value optimized out>) at lookup_lda=
p.c:1625
>> #5 =A00x0000555555569052 in do_read_master (master=3D0x55555568d010,
>> =A0 =A0 type=3D<value optimized out>, age=3D1296059657) at lookup.c:96
>> #6 =A00x000055555556aa3c in lookup_nss_read_master (master=3D0x55555568d=
010,
>> =A0 =A0 age=3D1296059657) at lookup.c:229
>> #7 =A00x0000555555575c28 in master_read_master (master=3D0x55555568d010,
>> =A0 =A0 age=3D1296059657, readall=3D1) at master.c:831
>> #8 =A00x000055555555d844 in do_read_master (arg=3D<value optimized out>)
>> =A0 =A0 at automount.c:1259
>> #9 =A00x00002b56e4657193 in start_thread () from /lib64/libpthread.so.0
>> #10 0x00002b56e4ddcdfd in sysctl () from /lib64/libc.so.6
>> #11 0x0000000000000000 in ?? ()
>>
>> Thread 6 (Thread 6851):
>> #0 =A00x00002b56e465aa3d in pthread_rwlock_rdlock () from /lib64/libpthr=
ead.so.0
>> #1 =A00x000055555556deb6 in cache_readlock (mc=3D0x55555568e5b8) at cach=
e.c:60
>> #2 =A00x000055555556baff in do_readmap (arg=3D<value optimized out>) at =
state.c:479
>> #3 =A00x00002b56e4657193 in start_thread () from /lib64/libpthread.so.0
>> #4 =A00x00002b56e4ddcdfd in sysctl () from /lib64/libc.so.6
>> #5 =A00x0000000000000000 in ?? ()
>>
>> Thread 5 (Thread 4026):
>> #0 =A00x00002b56e465d6a8 in __lll_mutex_lock_wait () from /lib64/libpthr=
ead.so.0
>> #1 =A00x00002b56e46599fb in _L_mutex_lock_92 () from /lib64/libpthread.s=
o.0
>> #2 =A00x00002b56e4659455 in pthread_mutex_lock () from /lib64/libpthread=
.so.0
>> #3 =A00x00005555555746cd in master_mutex_lock () at master.c:49
>> #4 =A00x0000555555560ff9 in handle_packet_missing_indirect (ap=3D0x55555=
569c940,
>> =A0 =A0 pkt=3D0x41823ec0) at indirect.c:808
>> #5 =A00x000055555555fa32 in handle_packet (ap=3D<value optimized out>)
>> =A0 =A0 at automount.c:1026
>> #6 =A0handle_mounts (ap=3D<value optimized out>) at automount.c:1551
>> #7 =A00x00002b56e4657193 in start_thread () from /lib64/libpthread.so.0
>> #8 =A00x00002b56e4ddcdfd in sysctl () from /lib64/libc.so.6
>> #9 =A00x0000000000000000 in ?? ()
>>
>> Thread 4 (Thread 4025):
>> #0 =A00x00002b56e4dd4b26 in fts_read () from /lib64/libc.so.6
>> #1 =A00x00007fff37314e80 in ?? ()
>> #2 =A00x0000000000000000 in ?? ()
>>
>> Thread 3 (Thread 4022):
>> #0 =A00x00002b56e465ac77 in pthread_rwlock_wrlock () from /lib64/libpthr=
ead.so.0
>> #1 =A00x00005555555752ea in master_source_writelock (entry=3D<value opti=
mized out>)
>> =A0 =A0 at master.c:527
>> #2 =A00x00005555555631af in handle_packet_missing_direct (ap=3D0x5555556=
a11c0,
>> =A0 =A0 pkt=3D0x40821ec0) at direct.c:1296
>> #3 =A00x000055555555fa1d in handle_packet (ap=3D<value optimized out>)
>> =A0 =A0 at automount.c:1029
>> #4 =A0handle_mounts (ap=3D<value optimized out>) at automount.c:1551
>> #5 =A00x00002b56e4657193 in start_thread () from /lib64/libpthread.so.0
>> #6 =A00x00002b56e4ddcdfd in sysctl () from /lib64/libc.so.6
>> #7 =A00x0000000000000000 in ?? ()
>>
>> Thread 2 (Thread 4019):
>> #0 =A00x00002b56e465b326 in pthread_cond_wait@@GLIBC_2.3.2 ()
>> =A0 =A0from /lib64/libpthread.so.0
>> #1 =A00x000055555556c8b3 in st_queue_handler (arg=3D<value optimized out=
>)
>> =A0 =A0 at state.c:1104
>> #2 =A00x00002b56e4657193 in start_thread () from /lib64/libpthread.so.0
>> #3 =A00x00002b56e4ddcdfd in sysctl () from /lib64/libc.so.6
>> #4 =A00x0000000000000000 in ?? ()
>>
>> Thread 1 (Thread 4018):
>> #0 =A00x00002b56e465b517 in pthread_cond_timedwait@@GLIBC_2.3.2 ()
>> =A0 =A0from /lib64/libpthread.so.0
>> #1 =A00x0000555555573762 in alarm_handler (arg=3D<value optimized out>)
>> =A0 =A0 at alarm.c:206
>> #2 =A00x00002b56e4657193 in start_thread () from /lib64/libpthread.so.0
>> #3 =A00x00002b56e4ddcdfd in sysctl () from /lib64/libc.so.6
>> #4 =A00x0000000000000000 in ?? ()
>>
>
> It looks like a lock ordering bug to me and I think it's the same hang
> that Steve Thompson reported.
>
> This will be hard to test I think, hopefully Mike or Steve will be able
> to use a couple of machines for testing, even so it may take a while
> before we know.
>
> Could you prepare a test package for Mike using this patch please.
> It should apply OK but of course you'll need to discard or fix the
> CHANGELOG hunk.

Ian, thanks for the patch. I built the test package and forwarded it
to Mike.

> I'll prepare a test package for Steve soon as I get time.

I took the liberty of building a test package for CentOS and RHEL too.
I used autofs-5.0.1-0.rc2.143.el5_5.6.src.rpm as base and added
your patch. The packages are now available at:

http://download.opensuse.org/repositories/home:/leonardocf:/autofs/

Unfortunately I failed to persuade the Build Service to keep the package
release number, so Steve might need to pass --oldpackage to rpm.

Thanks,
Leonardo
