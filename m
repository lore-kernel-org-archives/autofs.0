From: Ian Kent <raven@themaw.net>
Subject: RE: [ANNOUNCE] autofs v4 releases, at last
Date: Wed, 8 Oct 2003 15:30:55 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0310081522540.29153-100000@wombat.indigo.net.au>
References: <BA0E4392AD99D040885C414D992C24BE0526D0AD@us-bv-m11.bv.tek.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <BA0E4392AD99D040885C414D992C24BE0526D0AD@us-bv-m11.bv.tek.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peter.a.harris@exgate.tek.com
Cc: autofs@linux.kernel.org


OK, I have found that the a RH 2.4.20-19.7 kernel on 7.3 does not modify
the signal handler stuff in the task structure. This is a real delima for
me as I cannot reliably identify the needed changes, bummer.

The REDHAT_KERNEL define is used specifically for this, so setting
REDHAT = no in Makefile.conf should be fine.

On Tue, 7 Oct 2003 peter.a.harris@exgate.tek.com wrote:

> Ian,
>
> Here is what is installed:
>
> [ZEPHYR:root] rpm -qa | egrep kernel
> kernel-doc-2.4.20-20.7
> kernel-bigmem-2.4.20-20.7
> kernel-smp-2.4.20-20.7
> kernel-source-2.4.20-20.7
> kernel-2.4.20-20.7
>
> This machine started out as vanilla 7.3, which is 2.4.18-3.  It has then
> been updated with subsequent kernel patches.  It is running the bigmem SMP
> kernel.  Unfortunately, there does not seem to be any revision information
> in sched.h, but here is what I think is the section of interest in the
> declaration of task_sched:
>
> /* signal handlers */
>         spinlock_t sigmask_lock;        /* Protects signal and blocked */
>         struct signal_struct *sig;
>
>         sigset_t blocked;
>         struct sigpending pending;
>
>         unsigned long sas_ss_sp;
>         size_t sas_ss_size;
>         int (*notifier)(void *priv);
>         void *notifier_data;
>         sigset_t *notifier_mask;
>
> The information on the file is:
>
> -rw-r--r--    1 root     root        28220 Aug 18 12:01 sched.h
>
> The version.h information is:
>
> #include <linux/rhconfig.h>
> #if defined(__module__smp)
> #define UTS_RELEASE "2.4.20-20.7smp"
> #elif defined(__module__BOOT)
> #define UTS_RELEASE "2.4.20-20.7BOOT"
> #elif defined(__module__bigmem)
> #define UTS_RELEASE "2.4.20-20.7bigmem"
> #else
> #define UTS_RELEASE "2.4.20-20.7"
> #endif
> #define LINUX_VERSION_CODE 132116
> #define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))
>
> I uninstalled (and made sure all the files and directories were really gone)
> and re-installed the kernel-source-2.4.20-20.7 rpm on 10/2 when I first ran
> into the problem.
>
> We are using the 7.3 kernel for testing and have just ordered Enterprise ES
> 2.1 which should be in today.  As soon as we can we will go to 3.0.  I am
> suspecting that things will work better with those versions of Red Hat.
>
> Until then, do you think it would work if I changed the file to use the
> "else" section of that macro?
>
> And I do **GREATLY** appreciate the ability to build the kernel module
> without having to deal with building the entire kernel.  That will make my
> management feel so much better! :)
>
>
> Pete Harris
> Central Engineering / Technical Computing
> Phone:	1-503-627-3989
> Fax:	1-503-627-5587
>
>    __++__            ---------  ___,--. --+_._._:_
>   _|____|_ _________ |__|_|__| |_SP&S_| |_|_===__|
>    oo  oo ~ oo   oo ~ oo   oo ~ ooo ooo~ o OOOO =o\
> ============================================================
> Perform random acts of kindness and senseless beauty...
>
>
> -----Original Message-----
> From: Ian Kent [mailto:raven@themaw.net]
> Sent: Tuesday, October 07, 2003 05:33
> To: Harris, Peter A
> Subject: RE: [autofs] [ANNOUNCE] autofs v4 releases, at last
>
>
> Iv'e tried to several ways to duplicate this without success. I am not
> sure why it is happening.
>
> Do you have the packages kernel-2.4.20-20.7.<your arch>.rpm and
> kernel-source-2.4.20-20.7.i386.rpm installed with the kernel-source
> package in a pristeen condition?
>
> Perhaps removing and reinstalling the kernel-source package will help.
>
> As you observed the macro should select the correct code but it is not
> for some unknown reason. This message suggests the source you are
> compiling against is vinilla source but the compile line looks correct
> for RedHat source. Puzzling.
>
> I had you in mind when I set this stuff up. I was hoping it would work
> for you without problem.
>
> On Tue, 2003-10-07 at 03:19, peter.a.harris@exgate.tek.com wrote:
> > Ian,
> >
> > I am having problems with the 2.4 module compile.  I am running Red Hat
> 7.3,
> > 2.4.20-20.7 kernel and I get:
> >
> > gcc -I. -I./include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
> -pipe
> > -mpreferred-stack-boundary=2 -march=i686 -D__KERNEL__ -DMODULE
> > -I/usr/src/linux-2.4.20-20.7/include -DMODVERSIONS -include
> > /usr/src/linux-2.4.20-20.7/include/linux/modversions.h -DREDHAT_KERNEL
> -c
> > -o waitq.o waitq.c
> > waitq.c: In function `autofs4_write':
> > waitq.c:81: structure has no member named `sighand'
> > waitq.c:83: too few arguments to function
> `recalc_sigpending_Rsmp_e98ecd0c'
> > waitq.c:84: structure has no member named `sighand'
> > waitq.c: In function `autofs4_wait':
> > waitq.c:254: structure has no member named `sighand'
> > waitq.c:257: too few arguments to function
> `recalc_sigpending_Rsmp_e98ecd0c'
> > waitq.c:258: structure has no member named `sighand'
> > waitq.c:275: structure has no member named `sighand'
> > waitq.c:277: too few arguments to function
> `recalc_sigpending_Rsmp_e98ecd0c'
> > waitq.c:278: structure has no member named `sighand'
> > make: *** [waitq.o] Error 1
> >
> > I see you test for 2.4.19+ before using this code, so I am at loss.
> >
> > Any ideas?  Thanks.
> >
> >
> > Pete Harris
> > Tektronix, Inc. / Technical Computing
> > MS 39-325 / PO BOX 500 / BEAVERTON OR 97077-0500
> > Ph: 1-503-627-3989 / Fax: 1-503-627-5587
> > PGP:	0xD1F493F6
> > 	EA9E 25B8 EF02 3EBD 26CB 7E28 026E 74DB D1F4 93F6
> >
> > -- Any opinions expressed are those of the author and
> >    may not represent Tektronix, Inc. --
> >
> > _______________________________________________
> > autofs mailing list
> > autofs@linux.kernel.org
> > http://linux.kernel.org/mailman/listinfo/autofs
>

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
