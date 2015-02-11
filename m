From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] fix map option parsing for 'strictatime'
Date: Wed, 11 Feb 2015 09:19:13 +0800
Message-ID: <1423617553.2599.28.camel@pluto.fritz.box>
References: <DUB122-W3438A418D6CC75FC3C903D8A240@phx.gbl>
	 <DUB122-W513EB1C3223DD0FD66F71A8A240@phx.gbl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	x-sasl-enc:message-id:subject:from:to:cc:date:in-reply-to
	:references:content-type:mime-version:content-transfer-encoding;
	 s=mesmtp; bh=jodLUabsV4XVEXsW0kHxa+H4ghY=; b=yuaFzY4QiGda0IT+N7
	fvcytPAWxxAeMHQDJoH5ksfCdi2ndfZEOtTDoFRv3t2bQcFhfd8pUGFWYjGT5Gq+
	gpQgWn6c19mS99VCkpU8yQHPnr89vop8xgf8gkVwLYNXVCVMFKfRLsIgNpFMGdS0
	H2Qzko7mi+YxDE7jeVVkCOMcQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:subject:from:to:cc
	:date:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=jodLUabsV4XVEXsW0kHxa+
	H4ghY=; b=d9gKTgOz8zcxBUTej/sHHw1g1BDzIhdxlRBkbfyX8aD3D3wwdJcEAb
	ty/cKmBNKL0wI5rUe3eRzSj3SpmSHJ7Bc1ZHg8bOU/Xkaomv4FKQa4F04rC98MzA
	QtSB5acZmujoOHLa5UTucwhEYvzOPIPSJbpUcn1eUZ31gbq+Emfzk=
In-Reply-To: <DUB122-W513EB1C3223DD0FD66F71A8A240@phx.gbl>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Pete Beardmore <pete.beardmore@msn.com>
Cc: "autofs@vger.kernel.org" <autofs@vger.kernel.org>

On Tue, 2015-02-10 at 17:04 +0000, Pete Beardmore wrote:
> 
> 
> Hi,
> 
> I tried adding the 'strictatime' fs option in a map today to no avail.
> It looks like the current logic for the automount 'strict' option is
> erroneously consuming that option. Trivial patch attached.

Yep, I see the problem, the patch looks fine, I'll add it to the queue.
Can't say when I'll commit it upstream, but the next group of patches
should be pushed fairly soon.

Thanks.

Ian


