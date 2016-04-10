From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs and mount namespaces
Date: Sun, 10 Apr 2016 10:53:22 +0800
Message-ID: <1460256802.3508.39.camel@themaw.net>
References: <20160407181911.GA9018@vader>
	 <1460076663.3135.37.camel@themaw.net>
	 <20160408202123.GA12948@vader.dhcp.thefacebook.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=w1BygN/LOZNE3BeA73M7XhSJVQM=; b=ytEgIf
	csXX07YB/JZjwrYQ4WjJc2yjsRZthqcop6gWg3WU8hngd1g8O+5yNUhRrClq7zom
	KDubWxALGPFDVreKCD08kkZH8HlGjhDAwqVllXzrouQJg/GeI/cD8kCDx98ldifa
	U7vDN8p05OaEP7NORbfgo770El/wWpm9EO79g=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=w1BygN/LOZNE3Be
	A73M7XhSJVQM=; b=IU1Pdkn2cxBowJ2yAQSPV7cKN/MHNVec2KMZ9y9QDNSOHZ6
	GBd8dcpStfB+5aj0M4GOxPx6vZ5VOA3sLhk+nb02vbsOrbiSQhztJNQgIYzvHmUN
	9gktMlqwZRpeTAwU2joSXeaFvdcFQW7iJYN5BKNVCaGJd+X+nXJh1bw4XyR8=
In-Reply-To: <20160408202123.GA12948@vader.dhcp.thefacebook.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Omar Sandoval <osandov@osandov.com>
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@fb.com

On Fri, 2016-04-08 at 13:21 -0700, Omar Sandoval wrote:
> On Fri, Apr 08, 2016 at 08:51:03AM +0800, Ian Kent wrote:
> > On Thu, 2016-04-07 at 11:19 -0700, Omar Sandoval wrote:
> > > Hi, Ian,
> > > 
> > > I wanted to bring up the issue of autofs and mount namespaces
> > > again,
> > > which recently resurfaced in the thread here [1]. In that thread,
> > > you
> > > mentioned that you had some patches to make autofs namespace-aware
> > > that
> > > you were holding on to. Do you think you could put those up so we
> > > can
> > > all work out the issues you mentioned?
> > 
> > I can but I haven't tested them at all.
> > 
> > Possibly I could post them to the autofs list if you want to test
> > and
> > probably make changes to get them working.
> > 
> > Would that be ok .... umm, I think I need to post the patch now
> > anyway
> > as it's the easiest way to demonstrate what I think is a better
> > approach
> > than the patch below ....
> > 
> > I'm struggling to get back to work on this but I'm getting there and
> > hope to return to it soon.
> 
> Thanks for taking a look. Your patch fixes the case I provided, and it
> does look much better than my hack :) Like you said in your other
> email,
> there are more cases, but this fix is a good start independent of
> those
> cases. Were there any other patches that needed testing?

It changed a few times since I first looked at it and there were other
approaches that had more patches but this single patch is what I have
come up with most recently.

One problem is that with any change that I can come up with the limit on
request call backs (the ELOOP return that's seen) is removed and that
means it's possible to get a tight call back loop with no exit
condition.

For a long time I was most concerned about this but now I'm thinking
this is a sufficient improvement, at least for the most common use case
and I think a couple of not so common cases, to go ahead with it anyway
as a similar call back problem is possible when not using namespaces any
way. The daemon does handle that sufficiently well now so .....

Ian

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
