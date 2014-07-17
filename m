From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 3/6] autofs4: allow RCU-walk to walk through autofs4.
Date: Thu, 17 Jul 2014 13:00:56 +0800
Message-ID: <1405573256.3002.25.camel@perseus.fritz.box>
References: <20140709233541.4525.25151.stgit@notabene.brown>
	 <20140709234114.4525.46882.stgit@notabene.brown>
	 <1405485857.2527.38.camel@perseus.fritz.box>
	 <20140716155150.044c2ea3@notabene.brown>
	 <1405493777.2527.72.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=NxSTmGN+vLjZxIfpS3LFICf7um4=; b=KFmARQ8MOzmd/vLBM13I6t9Odeg9
	5we7eS+gLJIq2/SfAU8rSJTHTldMp35OpOwZvAHqX/s/I6M1OiQvPi5MDsI+JAQD
	F3zkhX8ixDbpr1c0RfUTT4JSJ9NWSytrQaCce6j+qKWa6bIqv2ywVqBS4/MpNJ6d
	HutICxm9ta7AJIQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=NxSTmGN+vLjZxIfpS3LFIC
	f7um4=; b=LeC+lqHCQRoIq3HJo7SEPM5nkfWDgrMqoXH05pyLIcdmjqcBtfJZ7R
	BkK0KcrPfgAH1gxRpc3bysqVy/OSZVfNfP4KBCKnhDbvp7YNVic2o0jAjG1x/pL2
	bM65U2aeDJ8AWdYbeXQfMR+A0hCRb6eGsQ4ArbvaAYSnt/KS7SM9g=
In-Reply-To: <1405493777.2527.72.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.de>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2014-07-16 at 14:56 +0800, Ian Kent wrote:
> > That looks a bit messy ... I wonder if we could have a new "ino" flag which
> > says "This dentry is mounted-on if it needs to be.  Gets set by ->lookup
> > and cleared by ->d_automount or when ->d_manage returns -EISDIR.
> 
> At one point DCACHE_NEED_AUTOMOUNT and DCACHE_MANAGE_TRANSIT were
> handled separately and DCACHE_NEED_AUTOMOUNT was cleared for rootless
> multi-mount dentrys following a mount and set again at expire. Not
> having to worry about managing that flag was also part of the
> optimization.
> 
> We could go back to managing DCACHE_NEED_AUTOMOUNT or add a new flag.
> I'm not fussy how it's done as long as it works. IIRC there was one
> quite convoluted if check (in the expire code) that was removed due to
> the optimization.

Umm ... using DCACHE_NEED_AUTOMOUNT rather than a new flag means using
an additional lock so perhaps a new flag would be preferred since
reducing lock overhead was the point of this.

Just a thought
Ian

