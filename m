From: "Cyril B." <cbay@excellency.fr>
Subject: Re: automount subprocesses accumulate
Date: Fri, 11 Sep 2015 17:14:05 +0200
Message-ID: <55F2EFBD.2020104@excellency.fr>
References: <55F1971B.1050301@excellency.fr> <1441949699.5198.6.camel@themaw.net>
Reply-To: cbay@excellency.fr
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=excellency.fr; s=default;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:Reply-To:From:Date:Message-ID; bh=mYjKo5cQX+iVkvs6j0MC4wUrMPSgdAvMs8bS5EIkeoI=;
	b=Xpna/rjM9mUTeASL8DEREHh1FPTgkdr6lC1ybynJjiIsRqHg0gZowaeOpcdhBBuVWMzGkeyT0++dhPu+I9sJOXCE6xphBPVWeFD1C47D3GvaqpVDUofE/ci1zzpUEqrXLKZn+j5k/r5Ca57yePro/FaAvMB+ffQCWzm0HksgECc/bT+QGlJ4yuowk2KsGLG9tLWtNLiqaXpP6PYKeipbB/zLJwMn2yeP/OFEPpMACax2uc6hdoHKwYTCWS69DsHlZVYl7I5pf6v3X9/ap8CsGwU3yZYoPgIwl/FRCB24VMiISCg/wwVaDr0nMvN/w/dK+owWsWoSqv+NkohrtEaupg==;
In-Reply-To: <1441949699.5198.6.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

Hello Ian,

Thanks for the quick response. I was able to reliably reproduce the 
deadlock on a test server with a test script that triggers many 
simultaneous mounts. On this setup /home is replaced with /mnt.

Ian Kent wrote:
> Can you get a meaningful (that is with symbols, line numbers etc.) of
> each of these processes and post it.

root     17937  0.5  0.0 1068324 3172 pts/0    Sl+  17:04   0:00  | 
   \_ /root/autofs/install/usr/sbin/automount -f -d
root     18503  0.0  0.0 1068308 1688 pts/0    S+   17:04   0:00  | 
       \_ /root/autofs/install/usr/sbin/automount -f -d

PID 17937:

#0  do_sigwait (set=<optimized out>, sig=0x7ffdf4e414fc) at 
../nptl/sysdeps/unix/sysv/linux/../../../../../sysdeps/unix/sysv/linux/sigwait.c:63
#1  0x00007fda9c209693 in __sigwait (set=0x7ffdf4e41500, sig=0x0) at 
../nptl/sysdeps/unix/sysv/linux/../../../../../sysdeps/unix/sysv/linux/sigwait.c:97
#2  0x00007fda9c6478a9 in statemachine (arg=0x0) at automount.c:1430
#3  0x00007fda9c6499d4 in main (argc=0, argv=0x7ffdf4e41750) at 
automount.c:2419

PID 18503:

#0  __lll_lock_wait () at 
../nptl/sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:135
#1  0x00007fda9c2044b9 in _L_lock_909 () from 
/lib/x86_64-linux-gnu/libpthread.so.0
#2  0x00007fda9c2042e0 in __GI___pthread_mutex_lock 
(mutex=0x7fda9c88d8e0 <conf_mutex>) at ../nptl/pthread_mutex_lock.c:79
#3  0x00007fda9c66dfb0 in defaults_mutex_lock () at defaults.c:178
#4  0x00007fda9c670442 in conf_get_yesno (section=0x7fda9c67f454 
"autofs", name=0x7fda9c67fba0 "force_standard_program_map_env") at 
defaults.c:1202
#5  0x00007fda9c6706fa in defaults_force_std_prog_map_env () at 
defaults.c:1598
#6  0x00007fda9b00a4e6 in lookup_one (ap=0x7fda9d547790, 
name=0x7fda60000b00 "agloper", name_len=7, ctxt=0x7fda8c000950) at 
lookup_program.c:184
#7  0x00007fda9b00adce in match_key (ap=0x7fda9d547790, 
source=0x7fda9d5478a0, name=0x7fda98b59ef0 "agloper", name_len=7, 
mapent=0x7fda98b58b58,
     ctxt=0x7fda8c000950) at lookup_program.c:432
#8  0x00007fda9b00b672 in lookup_mount (ap=0x7fda9d547790, 
name=0x7fda98b59ef0 "agloper", name_len=7, context=0x7fda8c000950) at 
lookup_program.c:621
#9  0x00007fda9c656101 in do_lookup_mount (ap=0x7fda9d547790, 
map=0x7fda9d5478a0, name=0x7fda98b59ef0 "agloper", name_len=7) at 
lookup.c:800
#10 0x00007fda9c656800 in do_name_lookup_mount (ap=0x7fda9d547790, 
map=0x7fda9d5478a0, name=0x7fda98b59ef0 "agloper", name_len=7) at 
lookup.c:960
#11 0x00007fda9c656e8a in lookup_nss_mount (ap=0x7fda9d547790, 
source=0x0, name=0x7fda98b59ef0 "agloper", name_len=7) at lookup.c:1136
#12 0x00007fda9c64bf1e in do_mount_indirect (arg=0x7fda8c003ce0) at 
indirect.c:772
#13 0x00007fda9c2020a4 in start_thread (arg=0x7fda98b5b700) at 
pthread_create.c:309
#14 0x00007fda9bb1b04d in clone () at 
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

I can still mount new user directories at this point (cd /mnt/foo works 
fine).

> Do you have reports from users of mounts hanging on access?

At one point trying to mount any new user directory would just freeze. 
I'm not sure that's related.


> I guess we need to look at the full debug log.
> Can you post it somewhere or mail it to me privately please.

I'll send you a link privately.

Thanks again.

-- 
Cyril B.
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
