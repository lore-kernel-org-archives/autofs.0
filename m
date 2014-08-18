From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/5] RCU-walk support for autofs
Date: Mon, 18 Aug 2014 16:25:40 +0800
Message-ID: <1408350340.2533.3.camel@perseus.fritz.box>
References: <20140818062844.9860.43007.stgit@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=zTa30W+V8/AG+UDK5XGB/8loYDE=; b=hcXpyqwifg1WbLNesa8ky+vZNdmX
	+fcF7geou0S5+DpKzcnaa/c9+LsF8V5VN1YNphPA6+UiOmXyz4Mma63G1Kpub4w6
	6QjV8h8qQMIrkh25lnt4K40P5WM0JMzov0Fhp8QJ6wpK5yqvfjnZx6SV0wd5lDHW
	Pa82cQ9iL9ZMWxg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=zTa30W+V8/AG+UDK5XGB/8
	loYDE=; b=THeZ2LlFwqwt76T5qygd6MjCbzjKKcnazTi80DiMn+DkAjOuKrC2CS
	quIOdPEW1QIlqAFGSE48hWMS+o7PsgGAcuhcDz9WfXt/EbCrKbRNDodw9INZWlem
	gSRHi5Duk+dXOp9aXbH2IIk71aSa7N10Xc0Arxa7WjyppnUi6lX44=
In-Reply-To: <20140818062844.9860.43007.stgit@notabene.brown>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.de>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2014-08-18 at 16:33 +1000, NeilBrown wrote:
> Hi Ian,
>  Have you had a chance to run your tests in these patches yet?
>  I've done what testing I can think of and cannot fault them.

I haven't, I've been plagued with illness so I'm not getting nearly
enough done. I'll try to put a kernel together and run the test in the
next week or so.

> 
>  This set is against 3.17-rc1 and make use of the new -EISDIR handling
>  for d_manage() and assumes the other patches which already went in
>  through Andrew Morton.
> 
>  I've added a section to autofs4.txt about mount namespaces, but it is
>  otherwise unchanged.
> 
>  If I could get an {Acked,Reviewed,Tested}-By in the next few weeks so
>  I can send them on to Andrew I would really appreciate it.
> 
> Thanks,
> NeilBrown
> 
> 
> 
> ---
> 
> NeilBrown (5):
>       autofs4: allow RCU-walk to walk through autofs4.
>       autofs4: factor should_expire() out of autofs4_expire_indirect.
>       autofs4: avoid taking fs_lock during rcu-walk
>       autofs4: d_manage() should return -EISDIR when appropriate in rcu-walk mode.
>       autofs: the documentation I wanted to read
> 
> 
>  Documentation/filesystems/autofs4.txt |  520 +++++++++++++++++++++++++++++++++
>  fs/autofs4/autofs_i.h                 |    6 
>  fs/autofs4/dev-ioctl.c                |    2 
>  fs/autofs4/expire.c                   |  200 ++++++++-----
>  fs/autofs4/root.c                     |   62 +++-
>  5 files changed, 694 insertions(+), 96 deletions(-)
>  create mode 100644 Documentation/filesystems/autofs4.txt
> 


