From: Ian Kent <raven@themaw.net>
Subject: Re: Regular deadlocks
Date: Sun, 26 Jun 2016 09:59:49 +0800
Message-ID: <1466906389.739.25.camel@themaw.net>
References: <3eece3d9-ea5a-ee47-100d-6fccf58f5356@excellency.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=FSVS6CSQJ1LZsy8+dthsQx3kbtU=; b=GAhvtK
	N9JtePs9yPuS8mJ0PbJPw6tEpG9Ad/H67jE7GyhESeH2DHa5D6gGvTtuuqlsIAJW
	bB9Fg2G5jgiM/8y8GTPf2qHIxsU0MNj76ac8RddNjBb37ba43EJcrE/dozBISaiG
	jarmXmDCmAUetF5KoX4RMm73k+Kt8Rv8Q4gF4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=FSVS6CSQJ1LZsy8
	+dthsQx3kbtU=; b=V+fg5DCPma0JObiIG1HqcMPQHeWrr/04uWKwwUJRRn//wyr
	XKgEiIg0esHwsEqWamwFiE6MwvS/CWeYBhSBiMqaxkEl+ppNqRSvMN4LlY9PYUDe
	xdMulnd5IeYtovE5qXqZM6Kopp8JoikeymqUP9pLTuC9f5meYeomakwANliQ=
In-Reply-To: <3eece3d9-ea5a-ee47-100d-6fccf58f5356@excellency.fr>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Cyril B." <cbay@excellency.fr>, autofs@vger.kernel.org

On Sun, 2016-06-26 at 01:41 +0200, Cyril B. wrote:
> Hello,
> 
> I have occasional deadlocks using autofs 4.1.2 (but it happened on 4.1.1 
> as well) on my servers, typically about once every 2 or 3 days.
> 
> I already posted on this mailing-list back in 2015 for a bug that also 
> triggered deadlocks (which was fixed), so I'll copy/paste parts of my 
> original message as my config hasn't changed.
> 
> /etc/auto.master:
> --
> /nfs program:/etc/auto.nfs
> /home program:/etc/auto.home
> --
> 
> /etc/auto.nfs is basically returning:
> 
> -fstype=nfs4,noatime,nosuid,_netdev,soft,intr,timeo=1000 $1:/
> 
> /etc/auto.home:
> --
> #!/bin/sh
> 
> if [ ! -h /var/home/$1 ]
> then
>     exit 1
> fi
> 
> echo -fstype=bind :$(readlink --no-newline /var/home/$1)
> --
> 
> So for instance, /var/home/foo would be a symlink pointing to
> /nfs/serverX/foo.
> 
> Kernel: Linux 4.4.7.
> 
> My servers have cronjobs that trigger /home/userX mounts basically at 
> the same time (when the jobs do start). I have 2 servers with the same 
> config, but one of them has MANY more users/cronjobs and oddly enough, 
> the deadlock happens much more infrequently.
> 
> Anyway, here's a 'ps faux' a few hours after the deadlock started:

Looks like these aren't showing a deadlock.

I think I've been seeing the same thing during testing and I can see it's
mount.nfs(8) that is not returning when it should.

I initially thought it was may environment but I've swapped several devices and
used different servers so I'm beginning to think mount.nfs(8) has grown a
problem but still not sure.

So far I've been thinking this was a problem with my environemtso didn't worry
too much about it.

snip ...


> 
> I cannot attach gdb on subprocesses: gdb just hangs after:
> Attaching to program: /usr/sbin/automount, process 1269869
> 
> Kernel trace:
> 
> # cat /proc/1269869/stack
> [<ffffffffc052f3bf>] autofs4_wait+0x3df/0xb60 [autofs4]
> [<ffffffffc052e0a5>] autofs4_d_automount+0x235/0x270 [autofs4]
> [<ffffffff921cbb8f>] follow_managed+0x1ff/0x2d0
> [<ffffffff921cccb3>] walk_component+0x263/0x300
> [<ffffffff921cdded>] link_path_walk+0x18d/0x5a0
> [<ffffffff921cf48e>] path_openat+0xbe/0x1070
> [<ffffffff921d04c5>] do_filp_open+0x85/0xe0
> [<ffffffff921bed96>] do_sys_open+0x146/0x220
> [<ffffffff921beeae>] SyS_open+0x1e/0x20
> [<ffffffff927685b2>] entry_SYSCALL_64_fastpath+0x12/0x71
> [<ffffffffffffffff>] 0xffffffffffffffff

The autofs4_d_automount() entry here indicates this is the one that triggered
the mount.

If you are seeing a problem with mount, looking for the blocked process and
killing it should clear the rest of these up.

You would think that, even if mount.nfs(8) was losing network packets, it would
timeout after about 3 minutes. I must admit I haven't waited long enough to find
out if that's the case so far.

If you find you are actually seeing this, setting the configuration option
mount_wait to some sensible value sufficient for a mount to complete might help.

The problem with that is it's hard to locate the actual blocked child process
from automount to kill it once the timeout has expired. Only the process spawned
by automount itself is killed so sub processes will probably accumulate.

Normally that process would go away after the usual lengthy timeout and was
commonly due to a server not responding or something like that so not locating
the process and killing it wasn't a big problem.

If this really is what's happening then I will need to fix that so that
automount can work around it. Not sure it will really help that much though
......

snip ...

> When the deadlock happens, I have to kill -9 subprocesses one by one. 
> One specific subprocess finally unlocks the deadlock and everything goes 
> back to normal (remaining subprocesses disappear as well).

Right, you might need to do that on the blocked mount process, NFS hangs on
pretty strongly when mounting.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
