From: Ian Kent <raven@themaw.net>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Fri, 08 Apr 2016 18:10:24 +0800
Message-ID: <1460110224.2979.35.camel@themaw.net>
References: <20160407141906.GU15153@bccms.uni-bremen.de>
	 <1460090760.3135.53.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=/idAzC2EFn8XBaj0tXgr4+8MBew=; b=p/Gv15
	bfrmmiO2mJWNBuFa5H5LkHNgYp9moJ1N8F6TjLeS20XEYleQAlAHAvxHFRx2CeoQ
	aF2s7ERezNc4wbepvq39GUOVHpzXdNEEVwC2zh6NEZfRYoWuU9AqLHVAYzgX6dU2
	19hF76/IL7ECMqyTDiLgLwNsLrtULaQTwiu+E=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=/idAzC2EFn8XBaj
	0tXgr4+8MBew=; b=ZFvzsIuq5hTAAU19gWtv5/OXwJb4mpsjxh5GTNoFzoOAHf4
	p1UYksFvY6A8//8gGmsmlTQGbdGHDAfoEw5Yps8sI8KCFXz60xmeSlmmsvYE9hPJ
	NDv3KZzkdfk39i46+u502KC11+Ml/sz+dHmQ6n3W1rmPiNPDcJataOwncVK0=
In-Reply-To: <1460090760.3135.53.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: christof.koehler@bccms.uni-bremen.de, autofs@vger.kernel.org

On Fri, 2016-04-08 at 12:46 +0800, Ian Kent wrote:
> On Thu, 2016-04-07 at 16:19 +0200, Christof Koehler wrote:
> > Hello everybody,
> > 
> > I am on ubuntu 14.04 with autofs 5.0.7 and I observe an (for me)
> > unexpected behaviour as detailed below. Apparently using autofs NFS4
> > mounts fall back to using IPv4 addresses although valid IPv6
> > addresses
> > are available under certain circumstances, while a plain mount works
> > as
> > expected.
> 
> Can you provide a full debug log.
> 
> It might be autofs interfering with the mount but mount.nfs(8) is a
> more
> likely candidate.
> 
> > 
> > Setup:
> > ------
> > Both, NFS server and client, are configured with an IPv4 address and
> > an
> > IPv6 GUA and IPv6 ULA. For brevity I will shorten the IPv4 address
> > to
> > 192, the GUA to 2001 and the ULA to fd5f  below. I will only change
> > the
> > DNS AAAA record in the following, the network configuration on
> > server/client or the A records never change. Server and client have
> > always working IPv4 and IPv6 GUA and ULA.
> > 
> > Test with mount:
> > ----------------
> > Using a plain "mount  -t nfs4 server:/locals /mnt/disk1/" on the
> > client
> > gives depending on the DNS entries for the server the expected
> > source/target selection:
> > 
> > Server DNS entry|	client address used to mount
> > 2001		|	2001
> > fd5f		|	fd5f
> > 2001+fd5f	|	fd5f
> > 
> > So in all cases RFC 6724/3484 is observed selecting the addresses.
> > Please note that the server has two AAAA records (multi-homed) in
> > the
> > last test.
> > 
> > Test with autofs:
> > -----------------
> > A map lookup will yield "-fstype=nfs4,rw,intr,nosuid,soft,nodev
> > server:/locals"
> > for the mount. Now I change again the servers AAAA records with the
> > following result:
> > 
> > Server DNS entry|	client address used to mount
> > 2001		|	2001
> > fd5f		|	fd5f
> > 2001+fd5f	|	192
> > 
> > For a multi-homed NFS4 server autofs apparently falls back to IPv4
> > although valid IPv6 options exist. As shown above just mounting
> > without
> > autofs would stick to RFC 6724/3484 instead. I believe that autofs
> > should 
> > also select fd5f ULAs in the multi-homed case.
> > 
> > Is this a known behaviour ? Do any workarounds exist ? I could not
> > find
> > anything.
> > 
> > I tried to compile autofs 5.1.1 with --with-libtirpc because
> > of https://bugs.launchpad.net/ubuntu/+source/autofs/+bug/1101779 but
> > could not get the binary to work. I filed a bug report for the
> > behaviour
> > described above 
> > https://bugs.launchpad.net/ubuntu/+source/autofs/+bug/1564380
> > but suspect that this is better suited for this list.

I've been thinking about this and I have a couple of thoughts.

As far a IPv6 goes using glibc RPC is, I think, not going to work!

That's the first thing that needs to be sorted out.

I've been using libtirpc in Fedora and RHEL builds for nearly 10 years
so I don't think the library problem is with autofs.

This is an indication someone is doing something a little dumb:

automount[20444]: open_mount:247: parse(sun): cannot open mount module
nfs (/usr/lib/x86_64-linux-gnu/autofs/mount_nfs.so: undefined symbol:
clnt_dg_create)
automount[20444]: lookup(file): failed to open parse context

clnt_dg_create() is an entry point in libtirpc and I'm fairly sure it
has been present in libtirpc from the beginning but maybe not and there
is a very old libtirpc in use, don't know.

Anyway, it looks more like either the matching shared library from the
build is not present on the system or the package was built with a
libtirpc devel package but the runtime library isn't present (and
obviously is not a dependency of the package).

I'm not familiar with the Debian build system so I'm probably not going
to be much help on that.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
