From: Ian Kent <raven@themaw.net>
Subject: Re: "Too many levels of symbolic links"
Date: Wed, 16 Mar 2016 09:32:14 +0800
Message-ID: <1458091934.2967.45.camel@themaw.net>
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
	:x-sasl-enc; s=mesmtp; bh=NNk4ILnrs86/g6Wufq3OrselTQo=; b=hnk477
	XLT2QZe6BDVui8MN/Iut65M34xjLiiHWECqEm3GQBF4D7V5tEUmTsgt8x/2mRTNF
	NCl/2/kukpg3u7wsjRxOigJA/8ty5UvZg40sFGF8mt2hqeqSm0X3/bdkKyf2se+D
	UHQMHuzqQ/0hMO3z3pTFHKA9dNbblR/NG1w3E=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=NNk4ILnrs86/g6W
	ufq3OrselTQo=; b=bcA6JWPJkB+VopV1d8xwC9BWkgBw76+jgTLtXrnj7gG+MYg
	FU1MJjxHMamcYqYZVbf9+04StdU8i2XQkEzWKO8kq5CZdilkJKjL4h/W0lHXXRFs
	KD4UV4Hi69m2Lq0g1rhM6NEPEL1h6u9MLdzfWE9PiXP+hk7k7XMlqFtNvdeE=
In-Reply-To: <56E0610F.9020704@molgen.mpg.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: autofs <autofs@vger.kernel.org>

On Wed, 2016-03-09 at 18:44 +0100, Donald Buczek wrote:
> Hi, Kent,
> 
> in 2014 we analyzed and discussed a problem which in my view boiled
> down 
> to "autofs refuses to mount on a path (dentry) which already is
> mounted 
> in another namespace." This is because it uses d_mountpoint ( = 
> DCACHE_MOUNTED) to decide whether a mount should be attempted or not.
> At 
> that point I selfishly changed our setting to avoid use of mount 
> namespaces and left you alone with the problem.
> 
> But now we need mount namespaces ourselves using kernel 4.4.2 and the 
> old problem reoccurred
> 
> So my questions:
> 
> * am I right, that this problem is still unresolved?
> * is this considered a bug?

I originally made a couple of patches to make autofs namespace aware for
this case but I'm still holding on to them because, as I did them, I
realized there's quite a bit more going on with this.

For example, suppose autofs is namespace aware, the autofs file system
has been cloned as part of the namespace creation, the filesystem in the
new namespace is propagation private and the automount daemon is running
in the root namespace.

In this case there's no limit on the number of times the namespace can
attempt to trigger a mount which is possibly open to be used as a denial
of service attack. So the current ELOOP behaviour is probably needed in
this case.

Another example, assume the automount daemon is running in the root
namespace, there are multiple containers where an indirect mount map has
been passed as a volume and the container implementation sets it's
mounts as propagation slave.

In this case the mounts are mounted in the root namespace and propagated
to the containers. And similarly, if there's a bad mount the containers
are capped on the number of mount attempts by the current ELOOP
behaviour. But ELOOP probably isn't the error return the containers
should be getting either and allowing unabated callbacks is probably not
good either.

There are more cases, some of which I haven't properly investigated.

So I ended up holding onto the patches.

What exactly is your usage need?

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
