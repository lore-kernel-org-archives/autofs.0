From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 4/6 v2] autofs4: factor should_expire() out of
 autofs4_expire_indirect.
Date: Tue, 15 Jul 2014 15:44:11 +0800
Message-ID: <1405410251.3219.4.camel@perseus.fritz.box>
References: <20140709233541.4525.25151.stgit@notabene.brown>
	 <20140709234114.4525.25725.stgit@notabene.brown>
	 <20140714105359.4415aab4@notabene.brown>
	 <1405396113.3112.17.camel@perseus.fritz.box>
	 <20140715140502.5e7f1da0@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=uhND+F6QXjXw/UPfKokFw9gBYuo=; b=LJgXpiWu9x+r70j/Fwl4M0WOk5t/
	INXHQmI5Kb9EpukxnrKWSzOyANEq+C9PeI+cbTppJEk29fcMsjLMnnenWJ0rn3cX
	JbVtUNNTr1A+upBUh46HkEDKtlCaPID72o7b5Rbhaog+F9BMTXRCHXYRijuqitsq
	RHEs7l4EYAIdH7A=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=uhND+F6QXjXw/UPfKokFw9
	gBYuo=; b=It1xbhAzzXu1EPc9hHm5qX1FXzUZz44VYgdIXSiCtaVOkjlwdWaDW2
	x0EcEdJMaLpMwDMWFpdc8mBEl4hn671vY71g1mtKjMyurwppu0dIq2E+0bUo5TLL
	9zu9BCm1gQtbxUJF4Jh4ceOuuPDcgPlSD6rTCcQlv/iRayLjpFC2M=
In-Reply-To: <20140715140502.5e7f1da0@notabene.brown>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.de>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2014-07-15 at 14:05 +1000, NeilBrown wrote:
> On Tue, 15 Jul 2014 11:48:33 +0800 Ian Kent <raven@themaw.net> wrote:
> ...
> > So far I've tracked this to something that was introduced between 3.11
> > and 3.12. One change that went into 3.12 was Jeff Laytons' umount
> > specific path resolution for umount. I've found this is also broken on
> > recent RHEL-6 kernels and that change is present in them too so the
> > evidence is leaning toward that being the problem. Just how could happen
> > with this change I have no clue so far, it just doesn't make sense.
> 
> Such a familiar story!  I've not yet failed to find bugs like that, but
> sometimes it takes a looooong time.  Good luck!
> 
> > 
> > Anyway that's going to make testing these patches impossible until I can
> > work out what the problem is and fix it.
> > 
> > Very sorry to hold you up on this but it can't be avoided. 
> 
> Thanks a lot for letting me know the situation!
> While I always appreciate upstream review I've learnt not to depend on it.
> I'll proceed with my customers based on my judgement and look forward to any
> input you can provide whenever you are able to provide it.

Yeah, I planed to spend some time to have a look on Wednesday and still
will but, as I say, testing is going to take more time than I have just
now.

Usual autofs usage rarely, if ever, uses symlinks so your customers
should be fine but be aware of the difficulty if you run into people
that want to use amd maps.

> 
> Thanks,
> NeilBrown


