From: Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH 1/4] fs/autofs: Use time_before, time_before_eq, etc.
Date: Fri, 28 Dec 2007 10:27:06 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712281016290.15274@ask.diku.dk>
References: <Pine.LNX.4.58.0712261621000.1185@pc-041.diku.dk>
 <2c0942db0712261158q34cddebeifceef6ceda683320@mail.gmail.com>
 <4772BD6C.1010502@zytor.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753332AbXL1J2s@vger.kernel.org>
In-Reply-To: <4772BD6C.1010502@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ray Lee <ray-lk@madrabbit.org>, autofs@linux.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, yoshfuji@linux-ipv6.org

On Wed, 26 Dec 2007, H. Peter Anvin wrote:

> Ray Lee wrote:
> > On Dec 26, 2007 7:21 AM, Julia Lawall <julia@diku.dk> wrote:
> > > -               if (jiffies - ent->last_usage < timeout)
> > > +               if (time_before(jiffies, ent->last_usage + timeout))
> > 
> > I don't think this is a safe change? subtraction is always safe (if
> > you think about it as 'distance'), addition isn't always safe unless
> > you know the range. The time_before macro will expand that out to
> > (effectively):
> > 
> >   if ( (long)(ent->last_usage + timeout) - (long)(jiffies) < 0 )
> > 
> > which seems to introduce an overflow condition in the first term.
> > 
> > Dunno, I may be wrong (happens often), but at the very least what
> > you've transformed it into is no longer obviously correct, and so it's
> > not a great change.
> 
> Indeed.  The bottom form will have overflow issues at time
> jiffies_wraparound/2, whereas the top form will have overflow issues only near
> jiffies_wraparound/1.

Isn't this only the case if timeout is a potentially large number? In this 
case, timeout may ultimately depend on a value that come from the user 
level, so I don't know what ranges are expected, but in many other cases 
one of the summands is a constant multiplied by HZ.  If the constant is 
small, then I guess that the likelihood that jiffies overflows and the 
likelihood that the sum overflows are essentially the same.  One then has 
to consider whether:

overflowed - correct </>/<=/>= small constant

is more or less desirable than

time_before/after/before_eq/after_eq(correct, overflowed_by_small_constant)

julia

