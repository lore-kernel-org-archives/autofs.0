From: Ian Kent <raven@themaw.net>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Sat, 09 Apr 2016 09:42:06 +0800
Message-ID: <1460166126.3073.20.camel@themaw.net>
References: <20160407141906.GU15153@bccms.uni-bremen.de>
	 <1460090760.3135.53.camel@themaw.net> <1460110224.2979.35.camel@themaw.net>
	 <20160408122552.GW15153@bccms.uni-bremen.de>
	 <20160408142907.GX15153@bccms.uni-bremen.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=zWCukqoKk3icideDHzkzTtAKCQc=; b=umoije
	iyneAL39oBzVp77mDrnVOSQfZQQ30VrP5sOXuwOzWLsWPUS3nQey/Lips0u2t+AP
	YBVVinwkIVoGzZjfs6Vxl2kjqgMbnpCE5qMvFGqxcig4l099otaCiWNHu/FVfhK1
	7K9S/sadSfxrBjO3o6VNvVW95QYKxTX79iLRE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=zWCukqoKk3icide
	DHzkzTtAKCQc=; b=HKiiWoLwjrfp2yi5099G2jvO1tDz94/mTGvk+InipWkLGj3
	1ayl7ZG9Of807tBL2m7Mq/H7gbJYj4LVSFanyLPqI9r8EU2maB8RartS/+FcaY8A
	wOHyPj3GRm5ee/Sdxil76vjwexUYtG+W9XdIDalgnKacCgLqFRa3U/YUUMIg=
In-Reply-To: <20160408142907.GX15153@bccms.uni-bremen.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: christof.koehler@bccms.uni-bremen.de, autofs@vger.kernel.org

On Fri, 2016-04-08 at 16:29 +0200, Christof Koehler wrote:
> Hello,
> 
> apparently I confused my 5.1.1 source built experiment and my debian
> package rebuild experiment when I reported that libtirpc was used in
> my
> last email. So here is a new try to rebuild the deb source with
> --with-libtirpc.
> 
> I did a apt-get source autofs and added --with-libtirpc to debian
> rules.
> After that it would of course not allow me to build a package,
> "aborting
> due to unexpected upstream changes". So I just did a "dpkg
> -buildpackage
> -b" and then dpkg -i autofs... . Attached is the file build.out.gz
> which
> contains the stdout output. Clearly libtirpc is used somehow in the
> build.
> 
> After restoring maps in /etc I did a service restart autofs and with
> debug loglevel I get 
> 
> Apr  8 16:20:33 core324 automount[14615]: open_mount:247: parse(sun):
> cannot open mount module nfs
> (/usr/lib/x86_64-linux-gnu/autofs/mount_nfs.so: undefined symbol:
> clnt_dg_create)
> 
> as reported. I then double checked and actually
> 
> root@core324:~# ldd /usr/lib/x86_64-linux-gnu/autofs/mount_nfs.so
>         linux-vdso.so.1 =>  (0x00007ffff7ffd000)
>         libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6
> (0x00007ffff79f3000)
>         /lib64/ld-linux-x86-64.so.2 (0x0000555555554000)
> 
> no libtirpc. 

And yet the build from the log looks ok....
There's no even a link entry there which implies it hasn't been built
using libtirpc but the build looks like it is using it... puzzling.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
