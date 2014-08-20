From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/5] RCU-walk support for autofs
Date: Wed, 20 Aug 2014 17:52:47 +0800
Message-ID: <1408528367.11028.44.camel@perseus.themaw.net>
References: <20140818062844.9860.43007.stgit@notabene.brown>
	 <1408350340.2533.3.camel@perseus.fritz.box>
	 <1408442547.11314.9.camel@perseus.themaw.net>
	 <20140819211654.5ec3853a@notabene.brown>
	 <1408451815.11314.15.camel@perseus.themaw.net>
	 <20140820131352.2aad3ca5@notabene.brown>
	 <1408506167.11028.32.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=KzggeGkN4B5JGRcQcgULJNZefHw=; b=Mec5Zvs5OVx191Hr6Ic/9qp9ehD6
	Ze/55fNzg5xPGUmqv+mOAxQta7rDDAI/uB0dlO5bALsQQ5MxbA7MqY7OxrNfiFRc
	4S/lwKsugapjRr6ONH3JD/zOqzTm8WBktkeBd3eAQkxzqWniqLIHz/MjMtYtaHEd
	zl7SxcftxNT1GNs=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=KzggeGkN4B5JGRcQcgULJN
	ZefHw=; b=lxJDG3gc9YEClPN+aX1SXS8ajoKRHLqE9PQN6HhHohJ4wFdE0mjqZ5
	FqMib8PBtWOwXljz2XY3dYo0MAPofqUtCo3L/1CgJdsiTiFwj14eT1PgcAdvLKMT
	fkU63G5J+1ih5ESH4vRpASXoxb7YZy3Iz95v1zMB9ym/d7AyMxoX4=
In-Reply-To: <1408506167.11028.32.camel@perseus.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.de>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2014-08-20 at 11:42 +0800, Ian Kent wrote:
> Great minds think alike.
> I have basically the exact same patch and I'm testing now.
> It probably should be folded into "autofs4: avoid taking fs_lock during
> rcu-walk".
> 
> It takes ages though, the test has two configurations to test and each
> one takes about 70 minutes.
> 
> fyi, my criteria for the test is if it runs through to completion once
> then that's essentially a pass. If not then there is a race that needs
> to be fixed before merge. If it fails on runs two or three then there's
> a hard to find race that needs attention but is not serious enough to
> block merging. I usually stop after three runs but if fails are seen
> later then, they too need to be resolved in the fullness of time.
> 
> The reason for this is that in heavy use sites we rarely see more than
> about three processes concurrently accessing mount points and the test
> run uses 10 client instances (currently on a 6 CPU machine) that all
> access the mount tree at the same time so that should be somewhat more
> pressure than is seen under heavy use.
> 
> And indeed this rule of has proven reliable so far.

I've run my test three times now.

The first time I had debug logging enabled. I disabled it for the second
and third runs as that sometimes makes a difference.

All three runs went through fine.

The only thing I noticed was that the test took a little longer (two and
a half to three minutes longer, of 70) to complete than without the
patch series but I've seen that sort of variation in kernels at
different times in the past.

So I think the series is fine and should be merged.
Please feel free to add any of my acked, reviewed and tested by to them.

Ian


