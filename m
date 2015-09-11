From: Ian Kent <raven@themaw.net>
Subject: Re: automount subprocesses accumulate
Date: Fri, 11 Sep 2015 13:34:59 +0800
Message-ID: <1441949699.5198.6.camel@themaw.net>
References: <55F1971B.1050301@excellency.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=k+oPFBmVNPU6/KLy1I7rjHENSf8=; b=EHhSBp
	qlavogD1Z0Djuo4AyKr5WBJr1FAjXW7y2GyR3++X9FKPdkR0IqhFsEuFehbtXkDs
	DER3Qi17ySkTuM8nBbFHUekiKeiY8w1tQbRRsu5uL/Vke3fQTstzQhJCxfUaJ93X
	jRG1h0TG4YrPGvRXyoRArOepc2mwtY1kzwzVU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=k+oPFBmVNPU6/KL
	y1I7rjHENSf8=; b=dN3cwA6MrqJVLtM2/a49W+4qnT83ESJrNH2fWK7b4EObQLF
	uLf36fAPnns0FY+yGA3u8nn1L3oGJTctFx4w+vE8bF52j/qTrNHUu/zkxKDZtGJF
	VmroHBWs9wZ7IzrofuIauWbTjYOHrNJGlMem/hcxRiTWGZAntr5k+rS7ZqZE=
In-Reply-To: <55F1971B.1050301@excellency.fr>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Cyril B." <cbay@excellency.fr>
Cc: autofs@vger.kernel.org

On Thu, 2015-09-10 at 16:43 +0200, Cyril B. wrote:
> Hello,
> 
> I've been using autofs for a long time to mount NFS servers under /nfs, 
> and recently started using it for mounting /home subdirectories as well 
> (which point on /nfs/).
> 
> Since I've started automounting /home, I have automount subprocesses 
> accumulating and never exiting:
> 
> root 1761264 0.0 0.0 205416 1478 ? Ssl 14:06 0:00 /usr/sbin/automount 
> --pid-file /var/run/autofs.pid
> root 1966587 0.0 0.0 209816 1564 ? S 14:45 0:00 \_ /usr/sbin/automount 
> --pid-file /var/run/autofs.pid
> root 2023507 0.0 0.0 209816 1652 ? S 15:00 0:00 \_ /usr/sbin/automount 
> --pid-file /var/run/autofs.pid
> root 2203212 0.0 0.0 215100 1900 ? S 15:45 0:00 \_ /usr/sbin/automount 
> --pid-file /var/run/autofs.pid

Yeah, that's odd.

> 
> My main automount was started at 14:06, and all subprocesses are stuck in a:
> 
> futex(0x56122035a5a0, FUTEX_WAIT_PRIVATE, 2, NULL
> 
> (same futex address for all of them).

Can you get a meaningful (that is with symbols, line numbers etc.) of
each of these processes and post it.

> 
> There are typically a few new subprocesses each hour. I've already seen 
> up to 20/25 subprocesses before I had to restart automount and kill them 
> manually.
> 
> I have a lot of users on this server, so automount is serving many 
> requests. Especially at round times (14:00, 14:15, 14:30, etc.), when 
> cron starts many user processes. According to automount debug logs, up 
> to 20 new home subdirectories can be mounted every second.

Yeah, that's quite a few, maybe your triggering a race with the thread
creation. I've spent a lot of time on that and thought it worked ok ...

Do you have reports from users of mounts hanging on access?

> 
> I'm using autofs 5.1.1 on Linux 4.1.4. My config:
> 
> /etc/auto.master:
> --
> /nfs program:/etc/auto.nfs
> /home program:/etc/auto.home
> --
> 
> /etc/auto.nfs is pretty standard, has been working fine for ages. It's 
> basically returning:
> 
> -fstype=nfs4,noatime,nosuid,_netdev,soft,intr,timeo=1000 $1:/
> 
> /etc/auto.home:
> --
> #!/bin/sh
> 
> if [ ! -h /var/home/$1 ]
> then
>    exit 1
> fi
> 
> echo -fstype=bind :$(readlink --no-newline /var/home/$1)
> --
> 
> So for instance, /var/home/foo would be a symlink pointing to 
> /nfs/serverX/foo.

So your bind mounting to an automounted nfs mount.
Not sure that's wise but probably should be ok.

I guess we need to look at the full debug log.
Can you post it somewhere or mail it to me privately please.

Ian

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
