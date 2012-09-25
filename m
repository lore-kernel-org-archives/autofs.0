From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/2] struct pid-ify autofs4
Date: Tue, 25 Sep 2012 09:46:44 +0800
Message-ID: <1348537604.2307.8.camel@perseus.themaw.net>
References: <1348068576-21363-1-git-send-email-miklos@szeredi.hu>
	 <87haqrwfbj.fsf@tucsk.pomaz.szeredi.hu>
	 <1348447130.2318.1.camel@perseus.themaw.net>
	 <87d31bczo7.fsf@tucsk.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=mesmtp;
	 bh=eJhuBwah9my5QotweuUgTAgOx4c=; b=l0+kenoJQqvNF5t/h3BbLYoP8Gc8
	3nQvhX8QSO1qGKxMvZMnHR73kAepp+D3MZh7EeKN9VVSssgPinUEoO+hwfRR/iG3
	3kJYNKEZjhfqm90aMXMHIg0iUlxX6EJn+3I3UFj43rz+JSV1XypDkYZEBNf5+NdT
	LhQ26z4f/MzzFhU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:content-transfer-encoding
	:mime-version; s=smtpout; bh=eJhuBwah9my5QotweuUgTAgOx4c=; b=PPB
	vWXJ1/qi16filsY7ft2H4YCw7akRQtGonCxg9mg1THa/qyZO/AeUIRBHQf0gT/wk
	yw5QkiN0k0IUiaYy9enItlJLL0bMsBRxdGRu2kvDJzlxdCd+SRIXsVWJ2tnkOAEo
	1kFCxbH/uXNrDpv44FpnCS1XOw4dXs3ZirbZJy8Q=
In-Reply-To: <87d31bczo7.fsf@tucsk.pomaz.szeredi.hu>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, sukadev@linux.vnet.ibm.com, serge.hallyn@canonical.com, ebiederm@xmission.com

On Mon, 2012-09-24 at 15:34 +0200, Miklos Szeredi wrote:
> Ian Kent <raven@themaw.net> writes:
> 
> > On Fri, 2012-09-21 at 17:44 +0200, Miklos Szeredi wrote:
> >> Miklos Szeredi <miklos@szeredi.hu> writes:
> >> 
> >> > These two patches change autofs4 to store struct pid pointers instead of pid_t
> >> > values.
> >> >
> >> > Fixed various issues with the previous post.  Not tested, handle with
> >> > care!
> >> 
> >> Customer gave positive test results.
> >
> > For what exactly, there's no problem description in these patches?
> 
> From what I understand (and I'm not an expert by any means) is that
> autofs doesn't work if containers are used.  The first patch fixes this.

Yeah, the problem with that is that "autofs doesn't work if containers
are used" is ill defined since there are use cases where it does, I
believe. At the very least, ill defined in my view of things.

But I can't even sensibly discuss it because of the lack of specified
use cases and requirements for each. So, there's a chance this will
break another case that does work.

All I can do is ask annoying questions each time time I see related
patches.

> 
> Both the patches replace pid_t with a refcounted struct pid object,
> which has better lifetime properties: you don't know whether a pid_t is
> valid, because pid numbers are reused, while pid objects remain valid
> until there are no more references to them.

Yep, at least I got that.

> 
> Thanks,
> Miklos


