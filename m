From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/6] autofs4: support RCU-walk
Date: Thu, 10 Jul 2014 15:43:40 +0800
Message-ID: <1404978220.2609.25.camel@perseus.fritz.box>
References: <20140709233541.4525.25151.stgit@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=t51l7iYz9X8dvEapCiHDHpqqcA4=; b=OH37URqDRcWBGyGkShO/RfRm6sX2
	bTq8rlEnLhWwI3R5iNgH3q7sK2odQlxK9X4ertVD5QlB0WCANfM0mhN6zJD9ED1W
	od5c3U3X9UQTZ0lV6TlCvLQnx3uDb/i/2CtDsnIBrVYW4wDUnm3YkkscHCs5wBdp
	vxGtS+mdDf2A6ws=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=t51l7iYz9X8dvEapCiHDHp
	qqcA4=; b=TkWd95ZvcBQGbqXAWYPZ4YYszVysoClmwKR/sj+iIrjJJy5eMpxMIl
	P76c7nJpuxf78wES4F/iVkNh1z6r28hRlLbdvbRzK8RJpbiLwA+FSB0FoDXM0IQZ
	DEQiLv2EVfg8IqXkazsspgJyeW8QFErysI9hhy9JzmJcvYbhNPNrk=
In-Reply-To: <20140709233541.4525.25151.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.de>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2014-07-10 at 09:41 +1000, NeilBrown wrote:
> autofs4 currently doesn't support RCU-walk - it immediately
> aborts any attempt at RCU-walk to force REF-walk for path name
> lookup.
> 
> This can cause a significant performance impact on multi-core
> systems.
> I have a client with a test case which spends >80% of its time
> waiting for spinlocks with a "make -j 40" on a 40 core system.

Right, sounds worth the effort.

> 
> This patchset aims to remove most of these spinlocks.  To be fully
> effective in the particular case it needs a second patch set which
> makes NFS RCU-walk friendly, but one thing at a time.
> 
> This has only been lightly tested so far so I'm really after feed-back
> rather than to have the patch set accepted, though the first two
> patches are trivial and could be taken immediately.

I've only scanned the patches so far, I'll need to spend a bit more time
on them before I can comment.

I'm going to be pressed for time for at least several days so I won't be
able to get to this right away.

I expect the submount_test I use to stress path walking and expire to
mount transitions will likely be a good test to use. I haven't used it
in my personal environment for quite a while now so I'll need to have a
look around and see if I can still find a suitable set of scripts.
Otherwise I'll need to decouple it from the RedHat automated test
environment.

> 
> The last two patches are the most interesting so review comments on
> those are particularly welcome.

Again I haven't looked closely at these but don't you mean the last
three patches or am I just fussing over an obviously straight forward
patch 3?

Thanks for your effort Bruce,
Ian

