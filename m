From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Slow mounts when using large round robin sets
Date: Fri, 21 Dec 2007 08:58:24 -0500
Message-ID: <x49odck175r.fsf@segfault.boston.devel.redhat.com>
References: <98E55D6E1B3CFD43BDA59EEB56DD7D72442DF1@sbs01.xiss.private>
	<98E55D6E1B3CFD43BDA59EEB56DD7D724431C0@sbs01.xiss.private>
	<1196921804.3089.28.camel@raven.themaw.net>
	<98E55D6E1B3CFD43BDA59EEB56DD7D724432D5@sbs01.xiss.private>
	<x49zlwm5hf1.fsf@segfault.boston.devel.redhat.com>
	<98E55D6E1B3CFD43BDA59EEB56DD7D7244386E@sbs01.xiss.private>
	<1198241367.3488.26.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1198241367.3488.26.camel@raven.themaw.net> (Ian Kent's message
	of "Fri\, 21 Dec 2007 21\:49\:27 +0900")
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent <raven@themaw.net> writes:

> On Thu, 2007-12-20 at 16:42 -0600, James Richardson wrote:
>> Jeff,
>> 
>> I downloaded the sources via git
>> (git://git.kernel.org/pub/scm/linux/storage/autofs/autofs.git) however
>> when automount starts up I get a floating point exception. I would
>> appreciate those debug patches you mentioned as I'm not sure where the
>> floating point exception is occurring.
>
> I don't remember saying anything about debugging patches?

I mentioned that we could provide targeted debugging patches to
try to figure out the problem.  They do not exist yet, and they
certainly would not point out why he's getting a floating point
exception!  ;)

>> # strace automount -d
>> execve("/usr/sbin/automount", ["automount", "-d"], [/* 24 vars */]) = 0
>> uname({sys="Linux", node="c33n69", ...}) = 0
>> brk(0)                                  = 0x80041000
>> --- SIGFPE (Floating point exception) @ 0 (0) ---
>> +++ killed by SIGFPE +++
>> Process 3702 detached
>> [root@c33n69 ~]# uname -a
>> Linux c33n69 2.6.21-GX #1 SMP Thu Apr 26 14:03:16 CDT 2007 i686 i686
>> i386 GNU/Linux
>
> I really don't know what's happening here.
> There's not enough info.

What Ian means is that you'd have to provide a stack trace from gdb at
the very least.  The output from automount -V wouldn't hurt, either.

-Jeff
