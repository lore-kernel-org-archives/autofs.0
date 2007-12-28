From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Subject: Re: [PATCH 1/4] fs/autofs: Use time_before, time_before_eq, etc.
Date: Fri, 28 Dec 2007 10:39:01 +0900 (JST)
Message-ID: <20071228.103901.82434638.yoshfuji@linux-ipv6.org>
References: <2c0942db0712261158q34cddebeifceef6ceda683320@mail.gmail.com>
	<4772BD6C.1010502@zytor.com>
	<Pine.LNX.4.64.0712270805370.6952@ask.diku.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754548AbXL1Bic@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0712270805370.6952@ask.diku.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: julia@diku.dk
Cc: hpa@zytor.com, ray-lk@madrabbit.org, autofs@linux.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, yoshfuji@linux-ipv6.org

In article <Pine.LNX.4.64.0712270805370.6952@ask.diku.dk> (at Thu, 27 Dec 2007 08:08:53 +0100 (CET)), Julia Lawall <julia@diku.dk> says:

> On Wed, 26 Dec 2007, H. Peter Anvin wrote:
> 
> > Ray Lee wrote:
> > > On Dec 26, 2007 7:21 AM, Julia Lawall <julia@diku.dk> wrote:
> > > > -               if (jiffies - ent->last_usage < timeout)
> > > > +               if (time_before(jiffies, ent->last_usage + timeout))
> > > 
> > > I don't think this is a safe change? subtraction is always safe (if
> > > you think about it as 'distance'), addition isn't always safe unless
> > > you know the range. The time_before macro will expand that out to
> > > (effectively):
> > > 
> > >   if ( (long)(ent->last_usage + timeout) - (long)(jiffies) < 0 )
> > > 
> > > which seems to introduce an overflow condition in the first term.
> > > 
> > > Dunno, I may be wrong (happens often), but at the very least what
> > > you've transformed it into is no longer obviously correct, and so it's
> > > not a great change.
> > 
> > Indeed.  The bottom form will have overflow issues at time
> > jiffies_wraparound/2, whereas the top form will have overflow issues only near
> > jiffies_wraparound/1.
> 
> OK, so it seems like it is not such a good idea.
> 
> There are, however, over 200 files that contain calls to the various time 
> functions that follow this pattern, eg:
> 
> arch/arm/kernel/ecard.c:563
> if (!last || time_after(jiffies, last + 5*HZ)) {
> 
> Perhaps they should be coverted to use a subtraction as well?

No, use time_after() etc., unless you have very good reason not using them.
And above is not a good reason at all.
Frequency is not a problem.  If we have longer timeout which could
result in wrap-around, we must use another method, e.g. 64bit jiffies,
anyway.

--yoshfuji
