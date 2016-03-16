From: Ian Kent <raven@themaw.net>
Subject: Re: "Too many levels of symbolic links"
Date: Wed, 16 Mar 2016 09:58:55 +0800
Message-ID: <1458093535.2967.65.camel@themaw.net>
References: <1391145206.2486.25.camel@perseus.fritz.box>
		 <52EB7694.20707@molgen.mpg.de> <52EB7B07.2070707@molgen.mpg.de>
		 <530484B7.6030305@molgen.mpg.de>
		 <1392896501.2508.16.camel@perseus.fritz.box>
		 <1392898704.2508.26.camel@perseus.fritz.box>
		 <530625D0.7020808@molgen.mpg.de>
		 <1392946952.2495.3.camel@perseus.fritz.box>
		 <53076D91.7050703@molgen.mpg.de> <53107D4A.90904@molgen.mpg.de>
		 <20140228132906.GM15017@sh-el6.eng.rdu2.redhat.com>
		 <1393726942.9725.5.camel@perseus.fritz.box>
		 <1393744241.9725.16.camel@perseus.fritz.box>
		 <5313467C.9080102@molgen.mpg.de>
		 <1393814402.2787.19.camel@perseus.fritz.box>
	 <1393913207.2781.20.camel@perseus.fritz.box>
	 <56E0610F.9020704@molgen.mpg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=VbrNZ4cDLqSv10kNa+wXpPE5QaQ=; b=DT8tMT
	sqhmpZaT5jCH0kB3WqSYALgJIDcjAiRRD3hgE3oF04vaoRn/W2xFphAao3RVbEqm
	RyyM1sXS3D5cU4dv5YQOKjzpTSm4ATgUtReIZkWi7myf90S9DY5WwTPdveSvw8Eh
	8Xw/FzkkLhkyx+5uIzjywiMRe+q08WkHd9iaU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=VbrNZ4cDLqSv10k
	Na+wXpPE5QaQ=; b=cWPP1+MulZzU7x11O8CKZVxsva3mQryJ2I6B9y9KmlWVcSm
	Owgas/JxX8Gx4qtzG1YZfCLerocNkmTYjdTY3qrpeRg00rN0ORw3kEvAUgLs4OYK
	Nz7V7VwaiZnkuWKOJUXBFHKAeGIJDbKi3bLsgnLB3cU62VBHr5fRtDyrQhaM=
In-Reply-To: <56E0610F.9020704@molgen.mpg.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: autofs <autofs@vger.kernel.org>

On Wed, 2016-03-09 at 18:44 +0100, Donald Buczek wrote:
> 
> As a reminder, here is the script we used to demonstrate the problem (
> assuming /project/mariux32 is served by autofs) :
> 
> ===
> #! /bin/sh
> 
> ls -ld /project/mariux32/.
> unshare -m -- bash -c "sleep 6;ls -ld /project/mariux32/.;echo
> exit..." &
> kill -USR1  `cat /var/run/autofs-running`
> sleep 3
> ls -ld /project/mariux32/.
> wait
> ===
> 
> In your mail quoted below you wrote, the error would be avoided if "/"
> was set to shared before automount is started, but I can't confirm
> this.
> 
> ===
> root:nsa:/scratch/local/# systemctl stop automount.service
> root:nsa:/scratch/local/# mount --make-rshared /
> root:nsa:/scratch/local/# systemctl start automount.service
> root:nsa:/scratch/local/# ./test.sh
> drwxrwsr-x 6 mx32prj mx32grp 56 Feb 24  2011 /project/mariux32/.
> ls: cannot access /project/mariux32/.: Too many levels of symbolic
> links
> drwxrwsr-x 6 mx32prj mx32grp 56 Feb 24  2011 /project/mariux32/.
> exit...
> root:nsa:/scratch/local/#

And, sadly, it's not that simple as I tried to describe with the cases
of the previous mail.

One thing that occurred to me long ago was setting the autofs mounts
propagation private at mount so they wouldn't be cloned to namespaces.

So you'd think, problem solved for some selected cases, but other cases,
such as container implementations that need mounts to be propagation
slave, broken.

But setting the autofs mounts themselves propagation private doesn't
stop them being cloned, it only prevents the child mount from
propagating which would just force the ELOOP behaviour regardless of the
namespace mount propagation status.

And, as I found out, it isn't possible to set a mount so it doesn't
propagate, it can only be done by setting the parent to not propagate
(all of) it's children. So there's no way to selectively set individual
mounts to not propagate at mount time, so they don't show up in a
created namespace.

So it is quite a difficult problem.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
