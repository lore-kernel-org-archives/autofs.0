From: Ian Kent <raven@themaw.net>
Subject: Re: clients suddenly start hanging (was: (no subject))
Date: Sun, 11 May 2008 15:57:07 +0800
Message-ID: <1210492627.3006.57.camel@raven.themaw.net>
References: <20080423185018.122C53C3B1@xena.cft.ca.us>
	<1210227208.1392.51.camel@raven.themaw.net>
	<20080511041455.21CB02111B1@simba.math.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080511041455.21CB02111B1@simba.math.ucla.edu>
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


On Sat, 2008-05-10 at 21:14 -0700, Jim Carter wrote:
> On Thu, 08 May 2008 14:13:28 +0800 Ian Kent wrote:
> 
> > But the patch that may make a real difference for your case is for the
> > daemon and hasn't been merged yet because were still testing it. I would
> > have posted it for you to test but I though we were still undecided as
> > to whether you wanted me to attempt a back port to an older SuSE code
> > base or you were happy to use the latest source.
> 
> > Anyway, here it is, against the latest source, for you to test.
> 
> We need the eventual patch, and I think it's probably going to work out
> best if we use a consistent code base, i.e. 5.0.3.  When SuSE eventually 
> catches up, then we'll stop using our private build of autofs.
> 
> I obtained 
> http://download.opensuse.org/repositories/home:/makoenig/openSUSE_10.3/src/autofs-5.0.3-6.1.src.rpm
> and successfully applied the patch to it (I'm provisionally calling
> the patch "submount-A").  Unlike in my previous attempt I could not 
> preserve the symbol table in the RPM file although symbols were present
> in the compiled exe and *.so, so I installed those manually (and the
> debuginfo package in the normal way).  

OK, I'll working with this then.

> 
> Without the submount-A patch in my previous test run (but with the 2
> kernel patches) I had 3 hung client processes in 2.0 hours, and 60
> "failed" tests.  "Failed" means that the test thread gets ENOENT when
> opening the target directory, but if the directory is left alone for 900
> seconds, it often behaves normally after that -- 49 of 60 directories
> revived and the rest might have if the test had run longer.  Expiration
> was hit-or-miss: frequently filesystems stayed mounted for over 900 secs
> (but eventually got expired) even though the expiry time is at the
> default of 300 secs.  (This result is similar to what I see without the
> 2 kernel patches.)

I don't think we should be too concerned about prolonged submount
expires. It is very easy to prevent a submount expiring through any
access, known or unknown. So, lets focus on the failures and hangs and
then look at expiration if we still need to.

> 
> First the good news: with the patch there were no "failed" tests at all
> in 4.5 hours of testing.  Now the bad news: although the rate of hung
> client processes was reduced by 1:3, to 2 hung processes in 4.5 hours,
> they're still hanging.  

If the gdb trace below is the symptom then the current patch doesn't
take that case into account (see below). I have another patch for a
similar problem with mount requests. Although you don't appear to be
seeing this problem I think we should also use it. I'll send it.

> 
> As a clue, I analysed some of the expiration issues in detail.  At one
> point 1/2 hour after starting the test, almost all of the 238
> filesystems had expired and been remounted at least once, but at that
> point the program detected that all but 12 of them had stayed mounted
> for at least 900 secs.  Looking through time at particular machines
> (submounts), two of them had two filesystems each, one of which expired
> and remounted normally through the whole test, and one didn't expire
> when the rest didn't expire.  Another machine that exports 6 filesystems
> had all of them expire properly, or not expire, in synchrony except one
> filesystem missed expiration one extra time when the others did expire. 
> There were three intervals of non-expiration shared by (almost?) all 
> filesystems, lasting about 1/2 hour (2 cases) or 1 hour (once).  
> My conclusion on this is that there is a common cause that omits
> expiration on almost every filesystem but which self-heals eventually.
> 
> See below for one backtrace immediately after the second hung process
> was recognized (25 secs after it started).
> 

snip ...

> Thread 9 (Thread 0x790ebb90 (LWP 32766)):
> #0  0xffffe410 in __kernel_vsyscall ()
> #1  0xb7f6e566 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib/libpthread.so.0
> #2  0x80021545 in master_notify_submount (ap=0x8004e8a8, 
>     path=0x80086570 "/net/bamboo45", state=ST_EXPIRE) at master.c:894
> #3  0x8000c97d in expire_proc_indirect (arg=0x8004fc70) at indirect.c:468
> #4  0xb7f6a192 in start_thread () from /lib/libpthread.so.0
> #5  0xb7ef102e in clone () from /lib/libc.so.6

Bummer, a lost pthreads signal from the submount.
Probably a synchronization problem caused by sharing the mutex for the
list of submounts with the condition.

I've updated the patch to separate these, I'm not sure if this will fix
it but try it please. I haven't sanity tested it yet but when I have
I'll send it over.

Ian
