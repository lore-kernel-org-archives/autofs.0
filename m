From: Ian Kent <raven@themaw.net>
Subject: Re: clients suddenly start hanging (was: (no subject))
Date: Wed, 21 May 2008 14:58:47 +0800
Message-ID: <1211353127.22177.178.camel@raven.themaw.net>
References: <20080423185018.122C53C3B1@xena.cft.ca.us>
	<1210492627.3006.57.camel@raven.themaw.net>
	<20080515215941.6221B21124E@simba.math.ucla.edu>
	<1211083674.3118.5.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1211083674.3118.5.camel@raven.themaw.net>
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


On Sun, 2008-05-18 at 12:08 +0800, Ian Kent wrote:
> On Thu, 2008-05-15 at 14:59 -0700, Jim Carter wrote:
> > Thread 4 (Thread 0x79aeeb90 (LWP 8592)):
> > #0  0xffffe410 in __kernel_vsyscall ()
> > #1  0xb7ecb817 in poll () from /lib/libc.so.6
> > #2  0x8000a343 in handle_mounts (arg=0x800bd540) at automount.c:909
> > #3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
> > #4  0xb7ed502e in clone () from /lib/libc.so.6
> > 
> > Thread 3 (Thread 0x78ee9b90 (LWP 11528)):
> > #0  0xffffe410 in __kernel_vsyscall ()
> > #1  0xb7f52566 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib/libpthread.so.0
> > #2  0x800215b7 in master_notify_submount (ap=0x8004e8a8, 
> >     path=0x800a9630 "/net/bamboo45", state=ST_EXPIRE) at master.c:908
> > #3  0x8000c90d in expire_proc_indirect (arg=0x800825e8) at indirect.c:468
> > #4  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
> > #5  0xb7ed502e in clone () from /lib/libc.so.6
> 
> This does look like an execution order dependency.
> Please try this patch in addition to the ones you're using.
> 
> autofs-5.0.3 - take submount submount lock before waiting
> 
> From: Ian Kent <raven@themaw.net>
> 
> Take the submount lock before issuing the nextstate() call to ensure
> the child can't signal completion before the parent waits. Also add
> cancellation cleanup for both mutexes.

Jim, did you get a chance to test this yet?
Ian
