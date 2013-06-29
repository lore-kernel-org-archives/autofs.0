From: Ian Kent <raven@themaw.net>
Subject: Re: autofs-5.0.7-add-null-check-in-read_one.patch
Date: Sat, 29 Jun 2013 09:53:09 +0800
Message-ID: <1372470789.2362.2.camel@perseus.fritz.box>
References: <CAEySpB7LaQ4S=LD=CAAQK6ap3acULM05D=23=XOOAOLNr_uw4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=ou0FJpA5uGJX4ExrxGu/jK3nTq4=; b=bujCcqL+emXRb/RrbS+IMEoiAGRX
	2F2No4SZJq0rHNVj9qj02aQawKDzh79FLOF3nC4LCT0EjAcL622TxHgngZRXGe/D
	h2+YOyHMQTvGokzPIbH+7P4BugMVnCW1Q78Js44dI5U51ji3bWjyYDt/d21I/92Y
	kK4JZWMhLkarnH8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=ou0FJpA5uGJX4ExrxGu/jK
	3nTq4=; b=qRRxEVU1AA4Dy046gBJefiUZ0xgH3FmtOFB2yUj7pBC770b4t9Ied7
	ZGfJqI7i8pOemW19vm3w1czkMl3Hs+x7jqGZSXdVVSHgbAWRiO5AleyDNYbfotUH
	a8DlmaMImspIIRtCabYkTnpkpss6rQNegRPq24f84j7UwXraEN/Dg=
In-Reply-To: <CAEySpB7LaQ4S=LD=CAAQK6ap3acULM05D=23=XOOAOLNr_uw4Q@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs <autofs@vger.kernel.org>

On Fri, 2013-06-28 at 08:47 -0300, Leonardo Chiquitto wrote:
> Hi Ian,
> 
> Patch "autofs-5.0.7-add-null-check-in-read_one.patch" is listed
> in v5/patches-5.0.8/patch_order-5.0.7 but the file is not available
> in v5/patches-5.0.8.

Sorry, I'll fix that.
There's also a bug fix patch for
autofs-5.0.7-fix-add-null-check-in-parse_server_string.patch I need to
upload, probably this weekend.

Ian


