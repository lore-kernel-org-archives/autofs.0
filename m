From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [autofs] Lockdep splat in autofs with 2.6.39-rc2
Date: Mon, 25 Jul 2011 08:33:55 -0400
Message-ID: <1311597236.3526.3.camel@gandalf.stny.rr.com>
References: <20110407194403.GA29404@elliptictech.com>
	 <20110421212537.GC24898@home.goodmis.org>
	 <1311562011.3401.13.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1311562011.3401.13.camel@perseus.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>

On Mon, 2011-07-25 at 10:46 +0800, Ian Kent wrote:
> On Thu, 2011-04-21 at 17:25 -0400, Steven Rostedt wrote:
> > On Thu, Apr 07, 2011 at 03:44:03PM -0400, Nick Bowler wrote:
> > > Just saw this on 2.6.39-rc2 after half a day or so of uptime.  I've
> > > never seen it before today so it may be a regression from 2.6.38.
> > > Nothing seems have failed as a result.  Please let me know if you
> > > need any more info.
> > >
> > 
> > Could you try this patch. I know it may be hard to reproduce, but the
> > issue is that we are recursing down the locks in a tree/list and we changed a
> > lock from being nested to being a parent. This patch tells lockdep about
> > what we did.
> > 
> > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> 
> Hi Steven,
> 
> It appears this is not included in current mainline yet so I'm guessing
> it is still a problem.
> 
> Is this the correct way to handle the problem?

Yes this is the correct way to handle the issue. There is no deadlock
because the locks are taken and released as it walks the list that
should always be ordered. This is the way to tell lockdep what it is
doing.

> Do you want me to forward the patch to Al Viro for inclusion in his tree
> and subsequent inclusion in mainline or would you like to do that?

Sure, go ahead.

Thanks,

-- Steve

