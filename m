From: Omar Sandoval <osandov@osandov.com>
Subject: Re: Autofs and mount namespaces
Date: Tue, 13 Sep 2016 18:25:33 -0700
Message-ID: <20160914012533.GA27760@vader.dhcp.thefacebook.com>
References: <20160407181911.GA9018@vader>
 <1460076663.3135.37.camel@themaw.net>
 <20160705184754.GA28931@vader.DHCP.thefacebook.com>
 <1467761756.4580.1.camel@themaw.net>
 <20160913181921.GA4124@vader.dhcp.thefacebook.com>
 <1473814617.3333.11.camel@themaw.net>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jc8bWRw82xbhb+bGXqx8vGyBFx0HNjw2l/Ypu1m6cQ4=;
        b=yeUY+wPFH5th4FVY44gZWBuChPkiuPQlVU8r6dJWLiaBl74drVTMPr84+UpaViwA8A
         GUxvtOIaxGGJo5HqoqERHO5jYbFMtf8qw/3vkBtK+5aXa79sbkYugOsJXFi6/RSgOKt6
         jQ8+tBCz11JUfYMds4dxQbtNqcLtjJ1oz2y6JVnrkT2PE4Z/LFVLxczeQ0RqVS5g0U/9
         zHVn6JYlYyNLPKOeFWYPxZ13U9KKQAzpRLMcb29EVtV1f1xI53Nhyt6q5s9du09MwyAe
         Rn0Qicil6MZHot656VxhmoUCHV65rje9oNkbaMhXf/hu1WKJJc2rAJIwiUV4aXH43YH4
         CTiQ==
Content-Disposition: inline
In-Reply-To: <1473814617.3333.11.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@fb.com, Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@ZenIV.linux.org.uk>

On Wed, Sep 14, 2016 at 08:56:57AM +0800, Ian Kent wrote:

[snip]

> > > > Hi, Ian,
> > > > 
> > > > Just wanted to check on the status of this fix. Is this still the
> > > > approach you wanted to take/is there anything else you wanted to do with
> > > > this?
> > > 
> > > The problem is that someone tested this back ported to an older kernel and
> > > claimed it caused file system corruption.
> > > 
> > > That leaves me in a bad place indeed.
> > > 
> > > Ian
> > 
> > Hi, Ian,
> > 
> > Dredging this up again because I forgot to reply in a timely manner last
> > time. Do you have more details on that report? I'm having a hard time
> > seeing how this change would cause filesystem corruption, and I still
> > think a fix for this really needs to go in.
> 
> You and me both.
> 
> I recently re-factored the patch a bit and I'm thinking the best thing to do is
> to send it to Andrew Morton so it can get plenty of testing before being
> considered for mainline.
> 
> I ran the kernel with the patches for several days without problem but didn't do
> a lot with autofs during that time.
> 
> I'll also have another look at it based on a comment from All Viro but I
> couldn't see anything wrong with it myself, perhaps he will comment further when
> I send it over to Andrew.
> 
> Ian

Awesome, please Cc me on the patch and I'll take it for a spin on some
of our servers.

-- 
Omar
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
