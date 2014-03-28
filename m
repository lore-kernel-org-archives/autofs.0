From: Ian Kent <raven@themaw.net>
Subject: Re: question about master map options
Date: Fri, 28 Mar 2014 08:27:29 +0800
Message-ID: <1395966449.2704.5.camel@perseus.fritz.box>
References: <20140327063454.GH19822@mayhem.atnf.CSIRO.AU>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=LS3AcmjYETzgmX/hZjvJqamrQVQ=; b=spDqLkvNLy0xm1W8rFm20ZuvdKQS
	HVo5Dvfz15BpUIS9jd91OMb+9k5aNjrFHAznCJmfr7AcT6qtRtXLM1RJsoI6JL0I
	NRyL1K7CYJeY0+dyr9QD2nhNwbx/Dw7XNENRV8G+ofK2Kdjndbm+1+ImuID5F6Ez
	eMo/UJbndAL33Iw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=LS3AcmjYETzgmX/hZjvJqa
	mrQVQ=; b=iRCF1PlJB176ozlmo8IKlcX6vEZExRAHEtQVDvSs1WIo+UKTCcYiHN
	8ekbgBCBu0SKTVoRRDzIvMZSYQyw/epSLoEcpT6QYWf+p3kQcKiBrp+prK2GWf46
	nJIf3A99ONtRi+UZwLZSmEr5ZSJRtdldJesec7RCyKGJhAwCHRxW0=
In-Reply-To: <20140327063454.GH19822@mayhem.atnf.CSIRO.AU>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vincent McIntyre <vincent.mcintyre@csiro.au>
Cc: autofs@vger.kernel.org

On Thu, 2014-03-27 at 17:34 +1100, Vincent McIntyre wrote:
> Hi,
> 

It's been a long time since I wrote that.


> in README.v5.release it says
> - mount options present in the master map are now overridden by mount
>   options in map entries instead of being accumulated. This behaviour
>   is in line with other industry automount implementations.

That's not correct by the look of it.

> 
> but other places in the documentation refer to
> mount options in the master map being appended
> to those given to a specific map entry,
> modulo the setting of APPEND_OPTIONS in /etc/defaults/autofs.
> 
> I can't figure it out from the code. Which way round is it, please?
> I'd like to make the documentation consistent with itself
> and the code.

The README was probably correct when it was written, possibly before the
APPEND_OPTIONS configuration option was added.

It ended up that options are appended by default (as they are in
previous versions) and the option was added for those that need it.

> 
> Kind regards,
> Vince


