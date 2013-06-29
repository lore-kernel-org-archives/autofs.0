From: Ian Kent <raven@themaw.net>
Subject: Re: autofs-5.0.7-add-null-check-in-read_one.patch
Date: Sat, 29 Jun 2013 10:03:22 +0800
Message-ID: <1372471402.2362.7.camel@perseus.fritz.box>
References: <CAEySpB7LaQ4S=LD=CAAQK6ap3acULM05D=23=XOOAOLNr_uw4Q@mail.gmail.com>
	 <1372470789.2362.2.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=8FrnHQAD4p56scPhTosCI5kLGDc=; b=wOUKzizTD/bRXLPzvIanOUd14M1l
	AibgEEuASbDw7khEIoLnAjXabsxlhOdJcjqHhTvBSUMHCtyNiL8m54hocNX1rsur
	Y+QTKFu9N3gKRJo0I9qnECzIktklAOf2CRvca/4GQTSemwwsI0Y+D4lyjL/6cpeH
	7+zg339HQGwLxiM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=8FrnHQAD4p56scPhTosCI5
	kLGDc=; b=R/6sLEch7x7wdhPSrucFgDcGFiBPC+EOTTSjxjDcpeoyK7Kd1NtYnQ
	WYVyD2ZF3MXKHPZf2oUEIhXZUzakHHzs5JDKUfxo3er3/CV8LMkfv8X4b3Sin6nh
	TtmbY5PFG6KyN0H1juS3ndxATgeWekl896BqfDWbx8d27i7EnyllQ=
In-Reply-To: <1372470789.2362.2.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs <autofs@vger.kernel.org>

On Sat, 2013-06-29 at 09:53 +0800, Ian Kent wrote:
> On Fri, 2013-06-28 at 08:47 -0300, Leonardo Chiquitto wrote:
> > Hi Ian,
> > 
> > Patch "autofs-5.0.7-add-null-check-in-read_one.patch" is listed
> > in v5/patches-5.0.8/patch_order-5.0.7 but the file is not available
> > in v5/patches-5.0.8.
> 
> Sorry, I'll fix that.
> There's also a bug fix patch for
> autofs-5.0.7-fix-add-null-check-in-parse_server_string.patch I need to
> upload, probably this weekend.

Umm .. that's autofs-5.0.7-add-null-check-in-parse_server_string.patch
and the fix patch has "fix" in the name.

> 
> Ian
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


