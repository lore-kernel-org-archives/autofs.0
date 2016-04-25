From: Ian Kent <raven@themaw.net>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Mon, 25 Apr 2016 12:40:48 +0800
Message-ID: <1461559248.3012.24.camel@themaw.net>
References: <20160407141906.GU15153@bccms.uni-bremen.de>
	 <1460090760.3135.53.camel@themaw.net> <1460110224.2979.35.camel@themaw.net>
	 <20160408122552.GW15153@bccms.uni-bremen.de>
	 <20160408142907.GX15153@bccms.uni-bremen.de>
	 <1460166126.3073.20.camel@themaw.net>
	 <20160409095659.GB15153@bccms.uni-bremen.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=CEq8+LocjYQsMLDzHT4O2qvbjhs=; b=OfzwEc
	s89vZ8rG3Sc34soLvfwjGODMqbDX0pjlTy+6bMDwo5TjGDT9ufxcx7L1tS+maiNy
	7UiQ6kFReMHXCVE9l0ZpfHqLNfep/9lrxI06eBKPV737H0SksCUBvqLhYRsAkfwZ
	I4SjGcVShIWPlzyUe8r4z/XrNn2yO5rccYptU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=CEq8+LocjYQsMLD
	zHT4O2qvbjhs=; b=tq4oOJB4hrDPqV9zc/DqWjtP6JXizrZ7AEqw7DevetIK8g4
	n3R/hRVtn+t9QFKGw5VHOkPwNzgwiNNhaX1kRcx5qePbVyFTQmGA7kmX+68OmS8u
	2ENOSU1WnpCO7kpqjgN1rF1Gm14xW/8H3OQDwULVtNpaLD/XeDdKPvW3qYTs=
In-Reply-To: <20160409095659.GB15153@bccms.uni-bremen.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: christof.koehler@bccms.uni-bremen.de, autofs@vger.kernel.org

On Sat, 2016-04-09 at 11:56 +0200, Christof Koehler wrote:
> Hello,
> 
> yes, indeed the 5.0.7 source deb rebuild is very strange. I also
> checked
> the libraries under debian/usr/lib/... in the build directory and they
> do not contain a libtirpc reference.

I had a look at this and found a few things.

The 5.0.7 Ubuntu build is sensitive to the library link order, seems
sensible enough, although I don't understand why I don't see this
problem with Fedora.

Adding the dependency to the build and adding a patch to fix the
Makefiles link order gets binaries with the libtirpc dependency.

The clean target of the Makefile in the modules directory doesn't remove
the yacc generated files and causes the Ubuntu build system to complain
on a second an subsequent runs of the build.

The autofs-5.0.6-fix-libtirpc-name-clash.patch of 5.0.7 needs to be
reverted in 14.04.4 for both the 5.0.7 and 5.1.1 builds to get rid of
the get_auth problem. That's due to the old libtirpc.

Once built the resulting package always fails when probing proximity and
availability (ie. calling into libtirpc).

The same thing happens with the 5.1.1 built on 14.04.4 with the above
changes.

I added the Makefile link order change, the Makefile clean change, and
added the libtirpc dependency to a Ubuntu 16.04 install and built the
package.

I tried a couple of simple indirect mounts and it was able to mount
them, so it seems the 14.04.4 problem is due to the old libtirpc
version.

But it SEGVed in libtirpc when using a -hosts mount.
I had a look at that and can't see any reason for the SEGV so that's a
puzzle.

I use standard tirpc calls and they function fine in Fedora, so the
seemingly innocent calls where it crashes are very strange.

If there was something that looked remotely like it could cause a
problem at least I'd have something to follow up on.

This isn't good and I'm not sure where to go from here.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
