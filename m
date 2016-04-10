From: Ian Kent <raven@themaw.net>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Sun, 10 Apr 2016 10:09:02 +0800
Message-ID: <1460254142.3508.6.camel@themaw.net>
References: <20160407141906.GU15153@bccms.uni-bremen.de>
	 <1460090760.3135.53.camel@themaw.net> <1460110224.2979.35.camel@themaw.net>
	 <20160408122552.GW15153@bccms.uni-bremen.de>
	 <20160408142907.GX15153@bccms.uni-bremen.de>
	 <20160408153224.GY15153@bccms.uni-bremen.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=iSA3dP+dIWpj5iS/nXd/vBvfRz8=; b=sdsrhw
	wxzCVjuwVi+n5e1IZxvoHbIhJ7VG+2c4PB/XbGWlMRJKpfEuXGrRevlWa2m27tmw
	ooutIRFMXvJaoZjXys5iuoZBBiRHi0xBARWO0UYAqEbock0NXVXQXUyJYo70pD/v
	9bATBRlemfcTl4lAls+/eRf91vLDFs3pO8C6Y=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=iSA3dP+dIWpj5iS
	/nXd/vBvfRz8=; b=g2HcrLwV+W0IIGkXTTmjOZDPTvrtjeh5xKGF1RZKPiMyM1k
	8cdq689MMFp60WHkKBtUfBxiYq0ozwBz5VJmZPp8glmTxLCLtna5Et/VwXEVc068
	oCvBNaG/SEm74nkGeo4FXp6EPU9iuwwA91rM67IttPR2cF132uG7Mr/T+KhE=
In-Reply-To: <20160408153224.GY15153@bccms.uni-bremen.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: christof.koehler@bccms.uni-bremen.de, autofs@vger.kernel.org

On Fri, 2016-04-08 at 17:32 +0200, Christof Koehler wrote:
> Hello,
> 
> I might add that using an IPv6 address, i.e.
> [2001:638:708:1261:2000::118]:/locals, in the automounter map does not
> work either while an IPv4 address, i.e. 192.168.220.118:/locals, works
> without a hitch. Is it desirable to be able to specify IPv6 addresses 
>  ?
> I am just noting the inconsistency.

It's not entirely straight forward to answer that due to the way autofs
will probe availability and proximity to work out which server to use.

That's possibly part of the multi-homed problem your seeing and whether
autofs should restrict itself to only IPv6 addresses is, I suspect, a
question we will end up asking.

But there seems to be more to this at the moment so that needs to be
resolved first.

The short answer is that IPv6 addresses should be usable but there have 
been changes along the way to how autofs uses libtirpc.

> 
> Have a nice weekend !
> 
> Apr  8 17:25:24 core324 automount[24310]: attempting to mount entry
> /local/core330
> Apr  8 17:25:24 core324 automount[24310]: lookup_mount:
> lookup(program): core330 -> -fstype=nfs4,rw,intr,nosuid,soft,nodev
> 192.168.220.118:/locals
> Apr  8 17:25:24 core324 automount[24310]: lookup_mount:
> lookup(program): looking up core330
> Apr  8 17:25:24 core324 automount[24310]: lookup_mount:
> lookup(program): core330 -> -fstype=nfs4,rw,intr,nosuid,soft,nodev
> [2001:638:708:1261:2000::118]:/locals
> Apr  8 17:25:24 core324 automount[24310]: parse_mount: parse(sun):
> expanded entry: -fstype=nfs4,rw,intr,nosuid,soft,nodev
> [2001:638:708:1261:2000::118]:/locals
> Apr  8 17:25:24 core324 automount[24310]: parse_mount: parse(sun):
> gathered options: fstype=nfs4,rw,intr,nosuid,soft,nodev
> Apr  8 17:25:24 core324 automount[24310]: parse_mount: parse(sun):
> dequote("[2001:638:708:1261:2000::118]:/locals") ->
> [2001:638:708:1261:2000::118]:/locals
> Apr  8 17:25:24 core324 automount[24310]: parse_mount: parse(sun):
> core of entry:
> options=fstype=nfs4,rw,intr,nosuid,soft,nodev,loc=[2001:638:708:1261:2
> 000::118]:/locals
> Apr  8 17:25:24 core324 automount[24310]: sun_mount: parse(sun):
> mounting root /local, mountpoint core330, what
> [2001:638:708:1261:2000::118]:/locals, fstype nfs4, options
> rw,intr,nosuid,soft,nodev
> Apr  8 17:25:24 core324 automount[24310]: mount_mount: mount(nfs):
> root=/local name=core33
> 0 what=[2001:638:708:1261:2000::118]:/locals, fstype=nfs4,
> options=rw,intr,nosuid,soft,nod
> ev
> Apr  8 17:25:24 core324 automount[24310]: mount_mount: mount(nfs): nfs
> options="rw,intr,no
> suid,soft,nodev", nobind=0, nosymlink=0, ro=0
> Apr  8 17:25:24 core324 automount[24310]: mount(nfs): no hosts
> available
> Apr  8 17:25:24 core324 automount[24310]: dev_ioctl_send_fail: token =
> 1923
> Apr  8 17:25:24 core324 automount[24310]: failed to mount
> /local/core330
> Apr  8 17:25:24 core324 automount[24310]: handle_packet: type = 3
> Apr  8 17:25:24 core324 automount[24310]:
> handle_packet_missing_indirect: token 1924, name core330, request pid
> 24519
> Apr  8 17:25:24 core324 automount[24310]: dev_ioctl_send_fail: token =
> 1924
> 
> Best Regards
> 
> Christof
> 
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
