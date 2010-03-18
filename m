From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: Automount daemon getting killed by SIGBUS
Date: Wed, 17 Mar 2010 21:07:59 -0300
Message-ID: <20100318000758.GA9422@libre.l.ngdn.org>
References: <20100222194830.GA11730@libre.l.ngdn.org>
	<4B85EB53.7010907@themaw.net>
	<20100225111509.GA22789@libre.l.ngdn.org>
	<1267151409.2116.22.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:date:from:to:cc:subject
	:message-id:references:mime-version:content-type:content-disposition
	:in-reply-to:user-agent;
	bh=W3rnf1NlNRFguwthDhBV1aY3cWFusxPtql3ItRS3KDA=;
	b=PMxJw/7i5/bSbDDRj/X8807ShIxZ2R5u4n8pE80UkSJx5iBmHaKbfyGvdAVeLOyXe/
	tXNIMFzHp2bTgixE8UOai/7eSl962lxS1HpQdtw40/+jhSYXvCpDRnwkRed1EE/ePIP4
	10S40SwiNg3yNhfcIbFL04pc9p8QjlO3Qbgmw=
Content-Disposition: inline
In-Reply-To: <1267151409.2116.22.camel@localhost>
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
Cc: autofs@linux.kernel.org

> > > What is the version in use and what additional patches have been applied?
> > 
> > They are running 5.0.3 plus all the patches in patch_order-5.0.3 and
> > autofs-5.0.4-fix_negative_cache_non-existent_key.patch, meaning that we
> > don't have the other alloca() replacements that went in after 5.0.4.
> 
> OK.
> 
> I had a bug report where the customer believed that the max open file
> limit and stack size was a problem. It turned out that increasing them,
> for some unknown reason reduced the likelihood of the problem occurring,
> but actually had nothing to to with the problem.

Increasing the stack size definitelly helped here too. Customer is not
seeing the problem anymore and now that we have a workaround, it's
more complicated to keep asking for more tests. I spent a lot of time
trying to reproduce the problem in house to make testing easier, but
even with a very similar setup (LDAP plus thousands of mount points)
I was not able to make it crash.

> If automount crashes then you need to look at the gdb backtrace of the
> running threads at the time of the crash with "thr a a bt" to get more
> info. I don't know how you provide debug symbols for your packages but
> you will need them if you want to make any sens at all of the backtrace.

All threads look allright, except for thread 1 that apparently has a
corrupted stack (and hence caused the SIGBUS):

(gdb) thr a a bt
Thread 7 (Thread 3577):
#0  0x00002b39dd901a48 in do_sigwait () from /lib64/libpthread.so.0
#1  0x00002b39dd901aed in sigwait () from /lib64/libpthread.so.0
#2  0x000055555555d6aa in statemachine (arg=<value optimized out>)
    at automount.c:1382
#3  main (arg=<value optimized out>) at automount.c:2105

Thread 6 (Thread 3578):
#0  0x00002b39dd8fe517 in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib64/libpthread.so.0
#1  0x0000555555571802 in alarm_handler (arg=<value optimized out>)
    at alarm.c:203
#2  0x00002b39dd8fa193 in start_thread () from /lib64/libpthread.so.0
#3  0x00002b39ddbd1dfd in clone () from /lib64/libc.so.6

Thread 5 (Thread 3579):
#0  0x00002b39dd8fe517 in pthread_cond_timedwait@@GLIBC_2.3.2 ()
   from /lib64/libpthread.so.0
#1  0x000055555556b72d in st_queue_handler (arg=<value optimized out>)
    at state.c:1022
#2  0x00002b39dd8fa193 in start_thread () from /lib64/libpthread.so.0
#3  0x00002b39ddbd1dfd in clone () from /lib64/libc.so.6

Thread 4 (Thread 3582):
#0  0x00002b39ddbc9b26 in poll () from /lib64/libc.so.6
#1  0x000055555555f2f7 in get_pkt (pkt=<value optimized out>, 
    ap=<value optimized out>) at automount.c:925
#2  handle_packet (pkt=<value optimized out>, ap=<value optimized out>)
    at automount.c:1082
#3  handle_mounts (pkt=<value optimized out>, ap=<value optimized out>)
    at automount.c:1581
#4  0x00002b39dd8fa193 in start_thread () from /lib64/libpthread.so.0
#5  0x00002b39ddbd1dfd in clone () from /lib64/libc.so.6

Thread 3 (Thread 3585):
#0  0x00002b39ddbc9b26 in poll () from /lib64/libc.so.6
#1  0x000055555555f2f7 in get_pkt (pkt=<value optimized out>, 
    ap=<value optimized out>) at automount.c:925
#2  handle_packet (pkt=<value optimized out>, ap=<value optimized out>)
    at automount.c:1082
#3  handle_mounts (pkt=<value optimized out>, ap=<value optimized out>)
    at automount.c:1581
#4  0x00002b39dd8fa193 in start_thread () from /lib64/libpthread.so.0
#5  0x00002b39ddbd1dfd in clone () from /lib64/libc.so.6

Thread 2 (Thread 3586):
#0  0x00002b39ddbc9b26 in poll () from /lib64/libc.so.6
#1  0x000055555555f2f7 in get_pkt (pkt=<value optimized out>, 
    ap=<value optimized out>) at automount.c:925
#2  handle_packet (pkt=<value optimized out>, ap=<value optimized out>)
    at automount.c:1082
#3  handle_mounts (pkt=<value optimized out>, ap=<value optimized out>)
    at automount.c:1581
#4  0x00002b39dd8fa193 in start_thread () from /lib64/libpthread.so.0
#5  0x00002b39ddbd1dfd in clone () from /lib64/libc.so.6

Thread 1 (Thread 11657):
Cannot access memory at address 0x800040623598

(gdb) thr 1
[Switching to thread 1 (Thread 11657)]#0  0x0000555555566bd0 in
spawn_mount (
    logopt=Cannot access memory at address 0x80004062242c
) at spawn.c:412
412	}

(gdb) info registers
rax            0x0	0
rbx            0x406223f0	1080173552
rcx            0x1	1
rdx            0x0	0
rsi            0x0	0
rdi            0x1	1
rbp            0x800040623590	0x800040623590
rsp            0x800040623568	0x800040623568
r8             0x1	1
r9             0x2d89	11657
r10            0x8	8
r11            0x246	582
r12            0x0	0
r13            0x0	0
r14            0x2	2
r15            0x406223b0	1080173488
rip            0x555555566bd0	0x555555566bd0 <spawn_mount+832>
eflags         0x10287	[ CF PF SF IF RF ]
cs             0x33	51
ss             0x2b	43
ds             0x0	0
es             0x0	0
fs             0x63	99
gs             0x0	0
fctrl          0x37f	895
fstat          0x0	0
ftag           0xffff	65535
fiseg          0x0	0
fioff          0x0	0
foseg          0x0	0
fooff          0x0	0
fop            0x0	0
mxcsr          0x1f80	[ IM DM ZM OM UM PM ]

> Is your customer using direct mounts?

Yes, lots of direct mounts (more than 9000).

> Is your customer using LDAP?

Yes, all maps are retrieved from LDAP.

> Have a look at the patches below and try and work out if they are
> relevant to the code base you are working with:

Thanks a lot for the useful comments and for listing the patches. I'll
try to merge them in our package.

Kind regards,
Leonardo
