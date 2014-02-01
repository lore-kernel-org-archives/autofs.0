From: Ian Kent <raven@themaw.net>
Subject: Re: autofs linux 3.8.13 and "Too many levels of symbolic links"
Date: Sat, 01 Feb 2014 10:57:16 +0800
Message-ID: <1391223436.2501.39.camel@perseus.fritz.box>
References: <52E92627.9050801@molgen.mpg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=Z7tlxnOhFX/x9M2i0bmc9GpiDyc=; b=WPjuuoY/s0mA4ccJL5lyC+5j+T1d
	xBz2SM2RQ3Q0OBtU0lb1xe92AoCNrwQM7XUVYZbIuToGNRjjNBbX1hfhvvrSKx23
	wfKgleHJzSWRz9rQrCcaGdNq07Iti92HvjtGgjqXV5Coe9OjSX3q2Iy6K4rZ/gvi
	QRMQOw8w6lNsPkc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=Z7tlxnOhFX/x9M2i0bmc9G
	piDyc=; b=MyhjuSUbMuFFbI+32quhJxgnClWHFUqcUX0ht0puiLIo9IXL9NiJUL
	yjwN6AzDDq+K80u/SWfyqPgW4ww+2kh4L4gPAmKsr2tNEddiYrCfqmKLLMbY5hFu
	tJJcfg+7owtOAdBtEAUPCAsSUlroPt5Fhdv9a0BNejAIz/l5b8qUU=
In-Reply-To: <52E92627.9050801@molgen.mpg.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: autofs <autofs@vger.kernel.org>

On Wed, 2014-01-29 at 17:02 +0100, Donald Buczek wrote:
> Hello,
> 
> we are trying to switch from amd to autofs. After successfully testing 

I didn't notice this before, so as an aside from our discussion

You were (perhaps are) an amd user.

As it happens I'm working on adding an amd map parser to autofs,
probably for similar reasons to you needing to switch away from using
it. I guess it won't make much difference to you since many people use
amd for its cross platform abilities. And, well, there's that bug we're
discussing ....

But, fyi, let me tell you where it's at.

I'm not sure how much of the functionality will end up in autofs quite
yet but so far the things that likely won't be available are:

- type program mounts
  - needed in autofs too.
  - but can't be done without significant autofs infrastructure
    change (or they would have been done in autofs ages ago).
  - would like to add this, probably some time later.

- type nfsx mounts
  - might (but probably not) get done for the initial commit.
  - a bit hard to do within autofs.

- type lustre mounts
  - would like to do for initial commit but ....

- type direct mounts
  - I think I understand how these are supposed to work.
  - don't work in amd on linux so can't check.
  - can't find any references to users of them either.
  - a bit difficult to do in autofs.
  - undecided as yet, at best will do some time later.

- map type passwd
  - seems to prescriptive to be useful.
  - unlikely to be implemented.

- map type ndbm
  - may implement later if people use it.
  - would need to add to autofs as well for sane implementation.

- configuration options not yet implemented
  - fully_qualified_hosts
  - unmount_on_exit
  - browsable_dirs
  - probably a couple of others I've missed.
  - many of the configuration options aren't used or aren't
    sensible within autofs.

- man page for amd options
  - autofs(5) will need to be updated before initial commit.


I've probably missed a few things but this will give you an idea.
My plan is to commit initial changes, announce this to try and get some
testers and continue to work on it after that. Eventually the amd map
changes will be autofs-5.1.0.

Any interest in this?
Ian

