From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs - fix lockref lookup
Date: Thu, 24 Apr 2014 12:10:38 +0800
Message-ID: <1398312638.2818.4.camel@perseus.fritz.box>
References: <20140423052035.5999.69412.stgit@perseus.fritz.box>
	 <20140423144624.716f325d454f9debd97bef15@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=hNXaoj7zgsWeZUfiZmA9ULzm3E4=; b=uO77SiC8yp81K9niNbFamNiu2bt9
	mWcUr2iZ76Q4m+aU4nD1Lmk85jwukjSV+9SKl2RwwIS8cv/Z5EAvjB29USJoJCCu
	YKpkcYDp2lHVJyLHx4LF8nuMOVYD9O3w2obSoQYpTIPhp3fqMrbu6J7868G53jHq
	sDn6VnKD/2CqnHo=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=hNXaoj7zgsWeZUfiZmA9UL
	zm3E4=; b=YAs4c65OtAfE294Nal3cRATr5oka8r1bTZVKqxItvtppdNwpw1ukm6
	515PtGpJ/Jblc4lNBcu7fGmq6Ut14oeuwXkJz5/pWI8lHgeSxik+8EmBz1ESyR/g
	k+kZXkYnhy9oiVVBwbNKGfNBCaERBLEgZ9tvmwgZ8rYfVZklqSLso=
In-Reply-To: <20140423144624.716f325d454f9debd97bef15@linux-foundation.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, 2014-04-23 at 14:46 -0700, Andrew Morton wrote:
> On Wed, 23 Apr 2014 13:20:36 +0800 Ian Kent <raven@themaw.net> wrote:
> 
> > autofs needs to be able to see private data dentry flags for
> > its dentrys that are being created but not yet hashed and for
> > its dentys that have been rmdir()ed but not yet freed. It
> > needs to do this so it can block processes in these states
> > until a status has been returned to indicate the given
> > operation is complete.
> > 
> > It does this by keeping two lists, active and expring, of
> > dentrys in this state and uses ->d_release() to keep them
> > stable while it checks the reference count to determine
> > if they should be used.
> > 
> > But with the recent lockref changes dentrys being freed
> > sometimes don't transition to a reference count of 0 before
> > being freed so autofs can occassionally use a dentry that
> > is invalid which can lead to a panic.
> 
> What's the value of "recent"?  I assume 3.14 is OK?

I'll need to look again but from memory it's broken from 3.12 onward.

The breakage happened when lockref_mark_dead() was introduced because it
sets lockref->count = -128 instead of reducing count by one as was done
previously.

Ian
  


