From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/2] struct pid-ify autofs4
Date: Thu, 25 Oct 2012 08:25:28 +0800
Message-ID: <1351124728.3116.8.camel@perseus.themaw.net>
References: <1348068576-21363-1-git-send-email-miklos@szeredi.hu>
	 <87haqrwfbj.fsf@tucsk.pomaz.szeredi.hu>
	 <1348447130.2318.1.camel@perseus.themaw.net>
	 <87d31bczo7.fsf@tucsk.pomaz.szeredi.hu>
	 <1348537604.2307.8.camel@perseus.themaw.net> <87mx0estch.fsf@xmission.com>
	 <1349926483.2371.35.camel@perseus.themaw.net>
	 <87625z531j.fsf@tucsk.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=mesmtp;
	 bh=Ft+1hcGfti7TR/VF0JRhoGjoyBw=; b=T+9Zw7ViJnPsbLTEwDskKyWqEOOB
	RC1bTqLAC0oUTA1M9EiDa7XkN68PN94X4m+yqEcO/2AzcLnjgTB1IY6cc/CxPcsL
	Boj9LxEFGjkA1V44sctGvI+VA2DKaYNDFfKULiLTTMRVEbxSjoCqvg7iKzU3xWfr
	i4n8aepaMuuxJrA=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:content-transfer-encoding
	:mime-version; s=smtpout; bh=Ft+1hcGfti7TR/VF0JRhoGjoyBw=; b=LaW
	Csx21/hRIowaqu3zZ+L+VBcSeBwpNM/g/ITNS9rb8MI2GJHXo7iHpkkpqiUpW0hi
	wsb8h1hMy7tvmbIrkqmNu75Ajg1S3NMKIz9BW3Dj6CINkTsyTCtq247PgPN6N/4e
	LwHEwLDdJNb768KJNKL++jwQhT1dxwie7ZsCJFgc=
In-Reply-To: <87625z531j.fsf@tucsk.pomaz.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, sukadev@linux.vnet.ibm.com, serge.hallyn@canonical.com

On Wed, 2012-10-24 at 16:59 +0200, Miklos Szeredi wrote:
> > Ian Kent <raven@themaw.net> writes:
> > 
> > > Yeah, the problem with that is that "autofs doesn't work if containers
> > > are used" is ill defined since there are use cases where it does, I
> > > believe. At the very least, ill defined in my view of things.
> 
> Customer says:
> 
>  "There is no interaction between host and the conatainer.  The host use
>   only his own automount and each containers used automount in their
>   container."

That sounds like a sensible requirement to me.

> 
> I think it's a pretty clearly defined use case.  And one which automount
> could easily support since the only requirement is that all namespaces
> are treated equally.

Yep. A problem might be dealing with mounts cloned from the parent
namespace at container creation. Ideally they wouldn't be duplicated so
they wouldn't need to be cleaned up (perhaps that's justified given the
requirement above).

Another thought is, what would happen on just cloning a namespace, not
necessarily as a container (is that even a sensible question)? The user
may actually want the mounts in this case, and can we even tell the
difference at namespace creation?

> 
> But I agree that adding safeguards against cases which don't have such
> easily defined semantics (such as triggers from several different
> namespaces).

Look forward to it.

> 
> I'll post updated patches.
> 
> Thanks,
> Miklos
> 

