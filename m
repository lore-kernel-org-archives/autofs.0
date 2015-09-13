From: Ian Kent <raven@themaw.net>
Subject: Re: automount subprocesses accumulate
Date: Sun, 13 Sep 2015 19:09:59 +0800
Message-ID: <1442142599.2902.13.camel@themaw.net>
References: <55F1971B.1050301@excellency.fr>
	 <1441949699.5198.6.camel@themaw.net> <55F2EFBD.2020104@excellency.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=9ryL1Fn8Ym7QCNubRFJHQAoaS18=; b=MGr+mq
	Qxz+5RecsPdq8nhllkWm1YUMODhHFTaak3QbWirCjFP9WgNysxgTmq5xpdOQ6hFi
	x+RpWfhtbSIGGnAFoDYQu8PftAEtazRvoJkYpF4jFTiuKNtIT2IfI5xLO+mPJY7Q
	uXo4bekNB/kS1ZC77rS9+Z6ok0Z2z7HqA91HI=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=9ryL1Fn8Ym7QCNu
	bRFJHQAoaS18=; b=ZZV5Ic3Emh5uxu3j6EoqqsBd7s8jFEt3wIUn0SzzhR07i36
	cRiKbvyLVf+XmxxNblJFhxagPE8kX1/kAOhOgTjRHQD0LUzP8m8UYaCGN+yom7+B
	V6yqmjwEDzSQevERYJB++HGm9tznJ5RLP4kU538BAcR0IMSZls05/RF6ghrA=
In-Reply-To: <55F2EFBD.2020104@excellency.fr>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: cbay@excellency.fr
Cc: autofs@vger.kernel.org

On Fri, 2015-09-11 at 17:14 +0200, Cyril B. wrote:
> Hello Ian,
> 
> Thanks for the quick response. I was able to reliably reproduce the 
> deadlock on a test server with a test script that triggers many 
> simultaneous mounts. On this setup /home is replaced with /mnt.

Yes, it's a puzzle.

The default.c module looks like there's no possibility of a deadlock.
It's fairly simple and there is no place where the mutex isn't released
before return and there are no other calls are made that could take
other locks that could introduce a deadlock.

It occurred to me that the call to force_standard_program_map_env() is
out probably out of order.

It's made after the fork() that's used to exec the program map code.

I think the child is seeing the state of the mutex at the time of the
fork and if the mutex was locked at that time the child process will
never see it unlocked since the forked process copy will not see that
change.

That's just a guess, so let me put together a patch for you to try.
Are you in a position to be able to apply and build autofs to test?

> 
> Ian Kent wrote:
> > Can you get a meaningful (that is with symbols, line numbers etc.) of
> > each of these processes and post it.
> 
> root     17937  0.5  0.0 1068324 3172 pts/0    Sl+  17:04   0:00  | 
>    \_ /root/autofs/install/usr/sbin/automount -f -d
> root     18503  0.0  0.0 1068308 1688 pts/0    S+   17:04   0:00  | 
>        \_ /root/autofs/install/usr/sbin/automount -f -d
> 
> PID 17937:
> 
> #0  do_sigwait (set=<optimized out>, sig=0x7ffdf4e414fc) at 
> ../nptl/sysdeps/unix/sysv/linux/../../../../../sysdeps/unix/sysv/linux/sigwait.c:63
> #1  0x00007fda9c209693 in __sigwait (set=0x7ffdf4e41500, sig=0x0) at 
> ../nptl/sysdeps/unix/sysv/linux/../../../../../sysdeps/unix/sysv/linux/sigwait.c:97
> #2  0x00007fda9c6478a9 in statemachine (arg=0x0) at automount.c:1430
> #3  0x00007fda9c6499d4 in main (argc=0, argv=0x7ffdf4e41750) at 
> automount.c:2419
> 
> PID 18503:
> 
> #0  __lll_lock_wait () at 
> ../nptl/sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:135
> #1  0x00007fda9c2044b9 in _L_lock_909 () from 
> /lib/x86_64-linux-gnu/libpthread.so.0
> #2  0x00007fda9c2042e0 in __GI___pthread_mutex_lock 
> (mutex=0x7fda9c88d8e0 <conf_mutex>) at ../nptl/pthread_mutex_lock.c:79
> #3  0x00007fda9c66dfb0 in defaults_mutex_lock () at defaults.c:178
> #4  0x00007fda9c670442 in conf_get_yesno (section=0x7fda9c67f454 
> "autofs", name=0x7fda9c67fba0 "force_standard_program_map_env") at 
> defaults.c:1202
> #5  0x00007fda9c6706fa in defaults_force_std_prog_map_env () at 
> defaults.c:1598
> #6  0x00007fda9b00a4e6 in lookup_one (ap=0x7fda9d547790, 
> name=0x7fda60000b00 "agloper", name_len=7, ctxt=0x7fda8c000950) at 
> lookup_program.c:184
> #7  0x00007fda9b00adce in match_key (ap=0x7fda9d547790, 
> source=0x7fda9d5478a0, name=0x7fda98b59ef0 "agloper", name_len=7, 
> mapent=0x7fda98b58b58,
>      ctxt=0x7fda8c000950) at lookup_program.c:432
> #8  0x00007fda9b00b672 in lookup_mount (ap=0x7fda9d547790, 
> name=0x7fda98b59ef0 "agloper", name_len=7, context=0x7fda8c000950) at 
> lookup_program.c:621
> #9  0x00007fda9c656101 in do_lookup_mount (ap=0x7fda9d547790, 
> map=0x7fda9d5478a0, name=0x7fda98b59ef0 "agloper", name_len=7) at 
> lookup.c:800
> #10 0x00007fda9c656800 in do_name_lookup_mount (ap=0x7fda9d547790, 
> map=0x7fda9d5478a0, name=0x7fda98b59ef0 "agloper", name_len=7) at 
> lookup.c:960
> #11 0x00007fda9c656e8a in lookup_nss_mount (ap=0x7fda9d547790, 
> source=0x0, name=0x7fda98b59ef0 "agloper", name_len=7) at lookup.c:1136
> #12 0x00007fda9c64bf1e in do_mount_indirect (arg=0x7fda8c003ce0) at 
> indirect.c:772
> #13 0x00007fda9c2020a4 in start_thread (arg=0x7fda98b5b700) at 
> pthread_create.c:309
> #14 0x00007fda9bb1b04d in clone () at 
> ../sysdeps/unix/sysv/linux/x86_64/clone.S:111
> 
> I can still mount new user directories at this point (cd /mnt/foo works 
> fine).
> 
> > Do you have reports from users of mounts hanging on access?
> 
> At one point trying to mount any new user directory would just freeze. 
> I'm not sure that's related.
> 
> 
> > I guess we need to look at the full debug log.
> > Can you post it somewhere or mail it to me privately please.
> 
> I'll send you a link privately.
> 
> Thanks again.
> 


--
To unsubscribe from this list: send the line "unsubscribe autofs" in
