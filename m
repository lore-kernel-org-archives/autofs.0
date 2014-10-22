From: Ian Kent <raven@themaw.net>
Subject: Re: Problem with autofs and ldap
Date: Wed, 22 Oct 2014 10:25:13 +0800
Message-ID: <1413944713.2504.32.camel@perseus.themaw.net>
References: <543E6912.8050109@tudelft.nl> <5440D89C.6040001@themaw.net>
	 <54465F56.8060701@tudelft.nl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	x-sasl-enc:message-id:subject:from:to:cc:date:in-reply-to
	:references:content-type:mime-version:content-transfer-encoding;
	 s=mesmtp; bh=Z8ApFfdKwsXnIVfpAWcNVOxkfmA=; b=KVP40aumiUtj6B+9Ip
	FbeC7DoLaaOCFtH0GUzjZaemZuMydw9StLeT3P6xfPY1akrHittyPUUyo5UXE2UQ
	Tmxdn/tvM+Vyp9L838m8spvbDFhgKkVFyLQbnSPDMe98edwRPqv2v8EUXJVfdYL0
	3xtymGDO6ZW9sydk1C5nuLvCU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:subject:from:to:cc
	:date:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=Z8ApFfdKwsXnIVfpAWcNVO
	xkfmA=; b=t/qhb6pL+VMdO6E+3WP+OjvftegW5cA2tIcFLN/3xUtOCHNRik92FZ
	KHENJJVMo9WeyNJP0FF52fW02Vo10r8/v73xIAJlAkl4yd1NkVtPn/Iy4VO5ldV6
	7yWSgw1yu1MmiAkoDMA5kK9+6PEbquJR8jTtHAI3upOiN3jRofwws=
In-Reply-To: <54465F56.8060701@tudelft.nl>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: rsmits-l <rsmits-l@tudelft.nl>
Cc: autofs@vger.kernel.org

On Tue, 2014-10-21 at 15:27 +0200, rsmits-l wrote:
> >
> > What about logging a bug against rhel-6 and working on it there.
> >
> > Ian
> 
> That's what I was thinking. This really looks like a bug. I will post my 
> finding to you and the list when this is solved.

If you have a subscription then I'd recommend going via GSS since
Bugzilla bugs have the lowest priority for Engineering, bugs that come
via GSS and other support folks using the recommended process get first
priority. But of course you need to convince GSS the problem should be
escalated.

Ian

