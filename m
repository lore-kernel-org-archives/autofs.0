From: Ian Kent <raven@themaw.net>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Sat, 09 Apr 2016 09:35:28 +0800
Message-ID: <1460165728.3073.17.camel@themaw.net>
References: <20160407141906.GU15153@bccms.uni-bremen.de>
	 <1460090760.3135.53.camel@themaw.net> <1460110224.2979.35.camel@themaw.net>
	 <20160408122552.GW15153@bccms.uni-bremen.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=vcnuzvWV0Hi9vBR6DeF/vJPrqlg=; b=UPKhLB
	YKnkYotUPTwO6zCH3Cige/mkInM45sgj+HV5B4Lcdrj6TvjEmA7C9LNBugSuTqGn
	xsGY/kVz+uotECuH6Lx4i8TQsMZMUnjR3u9ZG7LDeVSQzSL7RxHWmSq9W9rGofQA
	rvn2o8y7MFIMmFDzNI1QDY847ErCKmUuWZdnc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=vcnuzvWV0Hi9vBR
	6DeF/vJPrqlg=; b=QygDD2tVygJw3SBpVZbOc6nTlKpFmHgyJh1roTmAU70QrOk
	AqASXWG49YwO4EEfDcKD/v+Mzsxh2Qv+PBxDO0IuxT6ABRsqIn4fZs/mL4V++IHy
	aDLz7JrVB7GxmBaOVeoSx5mOfXd7/DrOQihjU/wP2hRvtztJbysc4nVp/oMo=
In-Reply-To: <20160408122552.GW15153@bccms.uni-bremen.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: christof.koehler@bccms.uni-bremen.de, autofs@vger.kernel.org

On Fri, 2016-04-08 at 14:25 +0200, Christof Koehler wrote:
> Hello again,
> > I've been thinking about this and I have a couple of thoughts.
> > 
> > As far a IPv6 goes using glibc RPC is, I think, not going to work!
> > 
> > That's the first thing that needs to be sorted out.
> > 
> > I've been using libtirpc in Fedora and RHEL builds for nearly 10
> > years
> > so I don't think the library problem is with autofs.
> > 
> > This is an indication someone is doing something a little dumb:
> > 
> > automount[20444]: open_mount:247: parse(sun): cannot open mount
> > module
> > nfs (/usr/lib/x86_64-linux-gnu/autofs/mount_nfs.so: undefined
> > symbol:
> > clnt_dg_create)
> 
> concerning my failures to build autofs. First the client has all
> libtirpc packages I think are necessary:
> # dpkg -l libtirpc\*|grep ii
> ii  libtirpc-dev                                   0.2.2-5ubuntu2
> ii  libtirpc1:amd64                                0.2.2-5ubuntu2
> 
> We have libtirpc1 on the machines by default and I had to
> install libtirpc-dev so that ./configure would conclude that
> --with-libtirpc should do anything. 
> 
> Actually I tried to compile autofs 5.1.1 from source and a new 5.0.7
> package from ubuntu's source deb.
> 
> Using the sources at 
> https://www.kernel.org/pub/linux/daemons/autofs/v5/
> I was basically confused what to do about the patches. Do I have to
> apply everything in patches-5.1.2 to autofs-5.1.1.tar.gz to get 5.1.2
> ? 

That's entirely up to you.
Those patches are the patches that have been committed to the repo. so
far toward the unreleased 5.1.2.

> How do I do that automatically ? I noticed that autofs-5.1.1.tar.gz

I don't know what you mean.

If your talking about building a deb then there's a place in the build
tree for patches where each patch usually has a number prefix to
establish order. They are then applied prior to the configure step I
think.

If your talking about the autofs source then you could try quilt.
I pretty sure the patch order file will work with it.

> misses the patch mentioned in message 15 of
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=737679
> but contained in autofs-5.1.1-revert-fix-libtirpc-name-clash.patch.

Whether that patch is needed or not depends on the version of libtirpc.

At one point it had a define in one of the header files that clashed
with an internal name in autofs.

That's been removed in later versions of libtirpc (and I think wasn't
present in earlier versions, don't know the specifics).

> 
> So to make it short I certainly messed something up
> somewhere, the final binary and libs were no success . Additionally
> installation did not play nice, although --prefix= was set it
> overwrote
> configuration files in /etc.  But I think I
> cleaned everything up afterwards.

Again, not clear if your talking deb or source install.

I'm pretty sure the make install will copy existing configs to a backup,
not sure what happens in a Debian type environment.

The deb install should certainly consider existing configuration.

Not sure what you mean about the prefix.
The prefix is meant to alter the default install directories.
If your using a package build system then typically you install to some
other directory by using DESTDIR (IIRC) during the package build and the
build system packages the installed files from DESTDIR down.

> 
> If someone can provide some hints I would try it again.
> 
> After that I rebuild the 5.0.7 package from source deb after adding
> --with-libtirpc to debian/rules as suggested in the bug reports. I
> installed from that package.  I checked with ldd after installing
> that ldd /usr/lib/x86_64-linux-gnu/autofs/mount_nfs.so was build with
> a
> reference to libtirpc. 

I looked at a log you provided and the build does appear to use libtirpc
and version 0.2.2 of libtirpc certainly has clnt_dg_create().

So not sure about that.

TBH I really don't want to construct a Ubuntu VM and struggle with the
Debian build system. I really don't like it and its been so long since I
used it, it would takes ages to work out what I need to do, again.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
