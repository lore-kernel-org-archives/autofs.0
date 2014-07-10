From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/6] autofs4: support RCU-walk
Date: Thu, 10 Jul 2014 15:45:09 +0800
Message-ID: <1404978309.2609.27.camel@perseus.fritz.box>
References: <20140709233541.4525.25151.stgit@notabene.brown>
	 <1404978220.2609.25.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=krj5QsKMj9CrW2WedG3HJ5nezU8=; b=KmXSFl+bVElionlszRPwHPGfwiOO
	stAsMRKasus7SxEde2zTx4Gr2K+/rxzMM+3Wfnd/fBjngOYB/yAOAU/PjAfc6JUV
	TWsvanurzbBCX8XERgH223rbrEm0N07aX62xeMdii1nqvbV5A/KxrAkjtj5Wdled
	qojyDzeZsIrxIvM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=krj5QsKMj9CrW2WedG3HJ5
	nezU8=; b=XBIidwRgF9oc7uw8KFT+JIklXeSldFAJQIPh+gKZ3Ip/s90u0ZvZr3
	G+aVY80PZt3lJLWTl7314htjgf7SP+w/VWGkrvfoCatH9mUwpB5/97+Bog2xuCS5
	S6sG8/Yh4MKTkSfxkLlXzzr7G1LL/L6iJ36Br7lDQJ/Kb6cX/PS6U=
In-Reply-To: <1404978220.2609.25.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.de>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2014-07-10 at 15:43 +0800, Ian Kent wrote:
> 
> Thanks for your effort Bruce,

Oh boy, where did that come from, sorry Neil, ;)

> Ian
> 


