From: Ian Kent <raven@themaw.net>
Subject: Re: Automount crashes due to thread-unsafe use of libldap
Date: Mon, 29 Jul 2013 09:13:59 +0800
Message-ID: <1375060439.2299.6.camel@perseus.fritz.box>
References: <CAEySpB7JfazYbx2DvECohKFTH7ihoH=z0inzxGCpZd1-YxCVRA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=obWUIOAkCqPbCs0Yy0yns6UqObg=; b=pLSJPZCuJGzHp8Tk5VLusVDE9EmB
	kljKKE7xMJl1S/2ql3SryNRdphBfEITASDg9AKK3DMEutmKk1uLjV0wqIOAptTqR
	hQ1phlTsG1rIg/Kn6dRbkSG2hMFnSrghyUh/enG3EGXkUCgQzFNgxGfiRRC7Qu87
	PCM79QmJ7UfCcCY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=obWUIOAkCqPbCs0Yy0yns6
	UqObg=; b=b9aV5VTBjrPJQKtA9n/Q/h3AA7tXyUHGxc6yXxx9zllZ1oK7TtKZ0B
	yp8iRO4XE9DIqd0iXlxmD2RcB14Lsr9Ca8NjVGf3zUI6V9DngiYThD2cT/3SSaB/
	8NPUAlmt//58e/6jhj8jfgpWW2kPL1zsLJAscGIx/WmZYvHDAB7XA=
In-Reply-To: <CAEySpB7JfazYbx2DvECohKFTH7ihoH=z0inzxGCpZd1-YxCVRA@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs <autofs@vger.kernel.org>

On Fri, 2013-07-26 at 14:46 -0300, Leonardo Chiquitto wrote:
> 
> Trying to find similar reports on the web, I found this email from an
> OpenLDAP developer (partial quote, emphasis mine) [1]:
> 
> "As far as I know, libldap is thread safe in the sense that multiple
> threads can use separate LDAP* handles without running into concurrency
> issues; *except for library initialization*, all accesses to common data
> (i.e. global variables) is read-only."
> 
> [1]http://www.openldap.org/cgi-bin/wilma_hiliter/openldap-software/200606/msg00252.html
> 
> AutoFS implements no locking around LDAP initialization libraries and
> it's quite common to see multiple threads executing ldap_initialize()
> or ldap_start_tls_s() at the same time.

Umm .. OK, that's likely the case but I'll check.

> 
> To avoid corruption inside SSL and LDAP libraries, I'd like to propose
> the following patch.

The patch looks straight forward and sensible.

Without having looked around or thought about it sufficiently I'd say
I'll apply this but give me some time to look around.

Thanks
Ian

