From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 04/13] autofs4 - change printks AUTOFS defined prints
Date: Thu, 06 Nov 2014 07:02:53 +0800
Message-ID: <1415228573.2365.24.camel@perseus.themaw.net>
References: <20141103081218.6215.85903.stgit@perseus.themaw.net>
	 <20141103081234.6215.82821.stgit@perseus.themaw.net>
	 <1415003136.17743.9.camel@perches.com>
	 <1415006418.6573.6.camel@perseus.themaw.net>
	 <1415025215.17743.12.camel@perches.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	x-sasl-enc:message-id:subject:from:to:cc:date:in-reply-to
	:references:content-type:mime-version:content-transfer-encoding;
	 s=mesmtp; bh=E+aZOeiqj381SjX6myMni6CRLzg=; b=STjsex0k0DA4Wcaepc
	OSBg9OSA34pw+lwg4q8jFWUaiQhwCATo0yKKLPZRBWK8SDKtfTx5SEDXhPi3HjPO
	V+huH+fyOg/ej9B+EhJ3DCMqBDT9YTj306p3UbLIpKG6batr4330GJi8oksvwjbk
	PIB2Zq9IPxAKFSOs2p4Nv/g/s=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:subject:from:to:cc
	:date:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=E+aZOeiqj381SjX6myMni6
	CRLzg=; b=Qf96JNJ5KXhnC6g5JZQuqB51o/ajitQQQXLAnWbJfp/ddE7Fc8yKZJ
	4HUK8+wcTgMKItmgUdgMQ762q8T+b/+cErk45RvnZ5cF/72XqD6mPBVZb4HmWOWt
	A6Kub0S8lapPVBMuYLSjKnaEjTpT8xVLYCpIeNU2NxVupIHbxQ3qU=
In-Reply-To: <1415025215.17743.12.camel@perches.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, 2014-11-03 at 06:33 -0800, Joe Perches wrote:
> 
> That's fine.  I left out the trailing semicolon/space.
> The pr_fmt could be something like:
> #define pr_fmt(fmt) KBUILD_MODNAME ":%d:%s: " fmt, current->pid, __func__
> or add a "pid:" descriptor prefix if you like too:
> #define pr_fmt(fmt) KBUILD_MODNAME ":pid:%d:%s: " fmt, current->pid, __func__
> 
> > > it's better to use a consistent style for
> > > these logging functions ideally with terminating
> > > newlines so there isn't a mix of code with
> > > and without those newlines.  That inconsistency
> > > leads to unintended defects.
> > 
> > The idea here was to make the logging consistent throughout.
> 
> Mine too.
> 
> > I have become used of not using the new-line terminator in logging over
> > the years and tend to favour that myself. You recommend not doing that
> > probably from a kernel wide consistency perspective? Maybe that is
> > better ...
> 
> Yes, kernel style consistency is the rationale.
> 
> Over time, people come along and add messages
> while not reading the code very closely so using
> the kernel style with newlines can help avoid
> these trivial defects.

I can see how not including the trailing newline in the macros is a good
thing and I'll forward a couple more patches to Andrew for this and fix
the inconsistencies.

But idea of using pr_xxx() and pr_fmt() (actually that's too open to
name clashes so it would need to be named something like autofs_pr_fmt()
anyway) looks like it results in less readable code so I'd really prefer
not to do that.

But thanks for pointing out the problems with the logging calls and for
you constructive suggestions.

Ian

