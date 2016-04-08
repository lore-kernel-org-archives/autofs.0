From: Ian Kent <raven@themaw.net>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Fri, 08 Apr 2016 12:46:00 +0800
Message-ID: <1460090760.3135.53.camel@themaw.net>
References: <20160407141906.GU15153@bccms.uni-bremen.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=akioTcdtb3EnhFKpWyjtoiWc7J4=; b=vfOKCP
	MZzTbSd4IQmsucdmYbsKkBlKIfD/+XN8HcXrd7GIBvmO/3S2f1fEi6KMBH83EqqZ
	3mYnqwIizWYS1Z6bT+zG1PBgFdWyewPpOvL0VnRl49odDxuogvSjMcrySkHBUaOg
	wBf+cMuXp8bMypVHu00eyl+8JnF9o78t1VdBY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=akioTcdtb3EnhFK
	pWyjtoiWc7J4=; b=qpPf0nsutPOeJQGlqAW0H7DszcwhZ8yYrrsW2tQ2KhEnO7Y
	1ta13yUX/XW/FcbyFs/C5uRCiMJok+jr6AKqgca+EDo70Im22HbGi8aYCoxKiwV5
	0utDQNnIBgXAPbMU887UMPMPy38JI7GyLsolHgDDO8Urn5Fg3KfKPEabzVK4=
In-Reply-To: <20160407141906.GU15153@bccms.uni-bremen.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: christof.koehler@bccms.uni-bremen.de, autofs@vger.kernel.org

On Thu, 2016-04-07 at 16:19 +0200, Christof Koehler wrote:
> Hello everybody,
> 
> I am on ubuntu 14.04 with autofs 5.0.7 and I observe an (for me)
> unexpected behaviour as detailed below. Apparently using autofs NFS4
> mounts fall back to using IPv4 addresses although valid IPv6 addresses
> are available under certain circumstances, while a plain mount works
> as
> expected.

Can you provide a full debug log.

It might be autofs interfering with the mount but mount.nfs(8) is a more
likely candidate.

> 
> Setup:
> ------
> Both, NFS server and client, are configured with an IPv4 address and
> an
> IPv6 GUA and IPv6 ULA. For brevity I will shorten the IPv4 address to
> 192, the GUA to 2001 and the ULA to fd5f  below. I will only change
> the
> DNS AAAA record in the following, the network configuration on
> server/client or the A records never change. Server and client have
> always working IPv4 and IPv6 GUA and ULA.
> 
> Test with mount:
> ----------------
> Using a plain "mount  -t nfs4 server:/locals /mnt/disk1/" on the
> client
> gives depending on the DNS entries for the server the expected
> source/target selection:
> 
> Server DNS entry|	client address used to mount
> 2001		|	2001
> fd5f		|	fd5f
> 2001+fd5f	|	fd5f
> 
> So in all cases RFC 6724/3484 is observed selecting the addresses.
> Please note that the server has two AAAA records (multi-homed) in the
> last test.
> 
> Test with autofs:
> -----------------
> A map lookup will yield "-fstype=nfs4,rw,intr,nosuid,soft,nodev
> server:/locals"
> for the mount. Now I change again the servers AAAA records with the
> following result:
> 
> Server DNS entry|	client address used to mount
> 2001		|	2001
> fd5f		|	fd5f
> 2001+fd5f	|	192
> 
> For a multi-homed NFS4 server autofs apparently falls back to IPv4
> although valid IPv6 options exist. As shown above just mounting
> without
> autofs would stick to RFC 6724/3484 instead. I believe that autofs
> should 
> also select fd5f ULAs in the multi-homed case.
> 
> Is this a known behaviour ? Do any workarounds exist ? I could not
> find
> anything.
> 
> I tried to compile autofs 5.1.1 with --with-libtirpc because
> of https://bugs.launchpad.net/ubuntu/+source/autofs/+bug/1101779 but
> could not get the binary to work. I filed a bug report for the
> behaviour
> described above 
> https://bugs.launchpad.net/ubuntu/+source/autofs/+bug/1564380
> but suspect that this is better suited for this list.
> 
> Best Regards
> 
> Christof
> 
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
