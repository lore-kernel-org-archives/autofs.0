From: Omar Sandoval <osandov@osandov.com>
Subject: Re: Autofs and mount namespaces
Date: Fri, 8 Apr 2016 13:21:23 -0700
Message-ID: <20160408202123.GA12948@vader.dhcp.thefacebook.com>
References: <20160407181911.GA9018@vader>
 <1460076663.3135.37.camel@themaw.net>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S/QAac0ezotIL+lrm1Yv8XXMeWGGi3VT/L/INlodEF0=;
        b=Fw/LfEnOF2Ec9LZ9kreRhuMjSUnotpTaVwM7IUJ8ZuJp1zGdPS8m01mvF5y8KtfsVJ
         cywk7iCdKzeG0sQ+Un0C39yTMuE8U29JKeP4D/fho5XKGePzuNwPWWVYVqU57FNShW+D
         m0IuBPQ3fHWbBYwz0lN7oucyJHw9HObZ7z+nvd3i1vp7DuTyHwJjhsfHdlsZGIdYjlB0
         oeflfTNwKJ1DKXvsxwvbMIGdtP6+e5+qV/kZ/nzr/6Z8XTCzqd50VuJT5ELNOnVsmdeD
         SV2Xr8FDVkMnfkF0gS0ZXivFikMp+tvr71sosOtfSh/7XDTrU2ayiNbTp+QKJGKqFiOr
         GSqQ==
Content-Disposition: inline
In-Reply-To: <1460076663.3135.37.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@fb.com

On Fri, Apr 08, 2016 at 08:51:03AM +0800, Ian Kent wrote:
> On Thu, 2016-04-07 at 11:19 -0700, Omar Sandoval wrote:
> > Hi, Ian,
> > 
> > I wanted to bring up the issue of autofs and mount namespaces again,
> > which recently resurfaced in the thread here [1]. In that thread, you
> > mentioned that you had some patches to make autofs namespace-aware
> > that
> > you were holding on to. Do you think you could put those up so we can
> > all work out the issues you mentioned?
> 
> I can but I haven't tested them at all.
> 
> Possibly I could post them to the autofs list if you want to test and
> probably make changes to get them working.
> 
> Would that be ok .... umm, I think I need to post the patch now anyway
> as it's the easiest way to demonstrate what I think is a better approach
> than the patch below ....
> 
> I'm struggling to get back to work on this but I'm getting there and
> hope to return to it soon.

Thanks for taking a look. Your patch fixes the case I provided, and it
does look much better than my hack :) Like you said in your other email,
there are more cases, but this fix is a good start independent of those
cases. Were there any other patches that needed testing?

-- 
Omar
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
