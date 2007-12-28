From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/4] fs/autofs: Use time_before, time_before_eq,
	etc.
Date: Fri, 28 Dec 2007 13:34:10 +0900
Message-ID: <1198816450.3089.24.camel@raven.themaw.net>
References: <Pine.LNX.4.58.0712261621000.1185@pc-041.diku.dk>
	<2c0942db0712261158q34cddebeifceef6ceda683320@mail.gmail.com>
	<4772BD6C.1010502@zytor.com>
	<Pine.LNX.4.64.0712270805370.6952@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0712270805370.6952@ask.diku.dk>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: Ray Lee <ray-lk@madrabbit.org>, autofs@linux.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>

On Thu, 2007-12-27 at 08:08 +0100, Julia Lawall wrote:
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

I don't see how subtraction is any different in this case as that could
just as easily underflow leading to the same issue.

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

Including autofs4.

> 
> Perhaps they should be coverted to use a subtraction as well?

Thinking about the cases involved always makes my head ache.

Ian
