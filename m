From: Ian Kent <raven@themaw.net>
Subject: Re: a couple of bugs in autofs
Date: Sat, 01 Nov 2008 17:59:56 +0900
Message-ID: <1225529996.3718.31.camel@zeus.themaw.net>
References: <510ca9b40810302235v6ab05c8bk117d4991bb70f198@mail.gmail.com>
	<510ca9b40810310011o458ff36ftbcce12c850ae172e@mail.gmail.com>
	<1225438359.2946.82.camel@zeus.themaw.net>
	<510ca9b40810310052o2c418ec5sd47c9d3b056a894d@mail.gmail.com>
	<1225440162.2946.93.camel@zeus.themaw.net>
	<510ca9b40810310110s34cfab9cie464a259d9dd92a0@mail.gmail.com>
	<1225442150.2946.105.camel@zeus.themaw.net>
	<510ca9b40810310415l667b803bya357f07f11312ff3@mail.gmail.com>
	<510ca9b40810312050m4b181de1p2de40e3f2389da7a@mail.gmail.com>
	<1225516095.3718.29.camel@zeus.themaw.net>
	<510ca9b40811010008y6c368fc5y5a574c16b8a65412@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <510ca9b40811010008y6c368fc5y5a574c16b8a65412@mail.gmail.com>
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
To: Paul Wankadia <junyer@gmail.com>
Cc: autofs@linux.kernel.org

On Sat, 2008-11-01 at 18:08 +1100, Paul Wankadia wrote:
> On Sat, Nov 1, 2008 at 4:08 PM, Ian Kent <raven@themaw.net> wrote:
> 
> > Get gdb output with "thr a a bt"
> 
> gdb does not give me any useful output even when I make with DEBUG=1,
> so I used valgrind's memcheck instead.
> 
> ==32474== Process terminating with default action of signal 11
> (SIGSEGV): dumping core
> ==32474==  Bad permissions for mapped region at address 0xFE2FFFFC
> ==32474==    at 0x4C95507: __errno_location (errno-loc.c:36)
> ==32474==    by 0x4CBAC2A: vfprintf (vfprintf.c:222)
> ==32474==    by 0x4CD5EB7: vsprintf (iovsprintf.c:46)
> ==32474==    by 0x4CC37AA: sprintf (sprintf.c:34)
> ==32474==    by 0x157E6: lookup_ghost (lookup.c:616)
> ==32474==    by 0xB74C: mount_autofs_indirect (indirect.c:215)
> ==32474==    by 0x8718: mount_autofs (automount.c:1068)
> ==32474==    by 0x9FA7: handle_mounts (automount.c:1556)
> ==32474==    by 0x4BE7CAB: pthread_start_thread (manager.c:310)
> ==32474==    by 0x4D39129: clone (clone.S:119)
> 
> daemon/lookup.c:
> 
>     598                 me = cache_enumerate(mc, NULL);
>     599                 while (me) {
> ...
>     611                         fullpath = alloca(strlen(me->key) +
> strlen(root) + 3);
>     612                         if (!fullpath) {
>     613                                 warn(ap->logopt, "failed to
> allocate full path");
>     614                                 goto next;
>     615                         }
>     616                         sprintf(fullpath, "%s/%s", root, me->key);
> ...
>     637 next:
>     638                         me = cache_enumerate(mc, me);
>     639                 }
> 
> alloca(3) does not return NULL. After some number of iterations, you
> overflow the stack.

Yeah, that's not good use of alloca, I'll fix it.

Ian
