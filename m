From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH 0/2] struct pid-ify autofs4
Date: Wed, 24 Oct 2012 16:59:36 +0200
Message-ID: <87625z531j.fsf@tucsk.pomaz.szeredi.hu>
References: <1348068576-21363-1-git-send-email-miklos@szeredi.hu>
	<87haqrwfbj.fsf@tucsk.pomaz.szeredi.hu>
	<1348447130.2318.1.camel@perseus.themaw.net>
	<87d31bczo7.fsf@tucsk.pomaz.szeredi.hu>
	<1348537604.2307.8.camel@perseus.themaw.net>
	<87mx0estch.fsf@xmission.com>
	<1349926483.2371.35.camel@perseus.themaw.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=3VZZf+Po4Ku49nJcr2mliwAzJh1BEpgI5IHU7/fYYNE=;
        b=kBwGLcqjvc288EbGCfXtI0qtKfHMtz74mhRQ+yzUWHw3zmBo43K9yFQbLEqQWgLyr+
         MUf/YAvWv4NFmNUnNCVVhPoeVazdvaz8gpbCHLWKAp+StleUz67SXUfScwIrFzC2RRq/
         /x2/M5OsQVXI3O6PsFQVaenGTLgaItrlvjGvg=
In-Reply-To: <1349926483.2371.35.camel@perseus.themaw.net> (Ian Kent's message
	of "Thu, 11 Oct 2012 11:34:43 +0800")
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, sukadev@linux.vnet.ibm.com, serge.hallyn@canonical.com

> Ian Kent <raven@themaw.net> writes:
> 
> > Yeah, the problem with that is that "autofs doesn't work if containers
> > are used" is ill defined since there are use cases where it does, I
> > believe. At the very least, ill defined in my view of things.

Customer says:

 "There is no interaction between host and the conatainer.  The host use
  only his own automount and each containers used automount in their
  container."

I think it's a pretty clearly defined use case.  And one which automount
could easily support since the only requirement is that all namespaces
are treated equally.

But I agree that adding safeguards against cases which don't have such
easily defined semantics (such as triggers from several different
namespaces).

I'll post updated patches.

Thanks,
Miklos
