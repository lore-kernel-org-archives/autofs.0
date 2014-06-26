From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs4 - fix false positive compile error
Date: Thu, 26 Jun 2014 10:28:55 +0800
Message-ID: <1403749735.2969.25.camel@perseus.fritz.box>
References: <20140625124939.31035.84884.stgit@perseus.fritz.box>
	 <20140625130648.1e3cd0e578602918dc38bb6a@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=m0iJwrg5nlmJFzbnRRYM6t5RZRc=; b=gj07Zp5p7pzaaqcZByqdYSQ1y5Un
	ozKPcD93/seMBX5r2cFWhxc25QKEJTlF9oReBlLSHsLJhBI7hsl/ulxpCkzLcZJ4
	+P+8pQ2kk7rDOMoz1p873rk6Z1cXcbuX+nmdzwfZfih5WfqpcLvHMPtq4IOUD9Vj
	Er5MY/kSn92k6bE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=m0iJwrg5nlmJFzbnRRYM6t
	5RZRc=; b=Rv4pKakWjbG89jIyRELNnp7cXgqfgDkijlYNxR96hXrHO5UCdsAPQ+
	HBjElhjudeIDvrDmYGslDPazqA2tyQ76EwH2HJBvEy2dLNL2AVFRA13xkb09KIth
	owIzoNkOxsjsAh4Fsy33rKHD5p2S1YngWurkVEv7wnVmHs19CvJr0=
In-Reply-To: <20140625130648.1e3cd0e578602918dc38bb6a@linux-foundation.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, 2014-06-25 at 13:06 -0700, Andrew Morton wrote:
> On Wed, 25 Jun 2014 20:49:39 +0800 Ian Kent <raven@themaw.net> wrote:
> 
> > On strict build environments we can see:
> > 
> > fs/autofs4/inode.c: In function 'autofs4_fill_super':
> > fs/autofs4/inode.c:312: error: 'pgrp' may be used uninitialized in this
> > function
> > make[2]: *** [fs/autofs4/inode.o] Error 1
> > make[1]: *** [fs/autofs4] Error 2
> > make: *** [fs] Error 2
> > make: *** Waiting for unfinished jobs....
> > 
> > This is due to the use of pgrp_set being used to indicate pgrp has
> > has been set rather than initializing pgrp itself.
> > 
> 
> Yes, that code seems to be explicitly designed to trigger a gcc warning ;)
> 
> What is a "strict build environment"?  Someone's using -Werror for the
> entire kernel?  That must make for a miserable life.

Yes, TBH I was a bit surprised myself.
It resulted from a RHEL-6.6 patch submission.

I didn't notice it and ended up missing an internal (RedHat) patch
submission deadline as my original interest in these was the result of
an upstream discussion and I stupidly relied on my upstream testing.

It might just be that our internal up and coming file system tree is
specifically more fussy but never the less I got caught out.

Ian

