From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Lockdep splat in autofs with 2.6.39-rc2
Date: Mon, 13 Jun 2011 20:43:13 -0400
Message-ID: <1308012193.9218.105.camel@gandalf.stny.rr.com>
References: <20110407194403.GA29404@elliptictech.com>
	 <20110421212537.GC24898@home.goodmis.org>
	 <20110427132219.GA2843@elliptictech.com>
	 <20110511191301.GA18504@elliptictech.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110511191301.GA18504@elliptictech.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Nick Bowler <nbowler@elliptictech.com>
Cc: linux-kernel@vger.kernel.org, autofs@linux.kernel.org, Ian Kent <raven@themaw.net>, Peter Zijlstra <peterz@infradead.org>

On Wed, 2011-05-11 at 15:13 -0400, Nick Bowler wrote:
> On 2011-04-27 09:22 -0400, Nick Bowler wrote:
> > On 2011-04-21 17:25 -0400, Steven Rostedt wrote:
> > > On Thu, Apr 07, 2011 at 03:44:03PM -0400, Nick Bowler wrote:
> > > > Just saw this on 2.6.39-rc2 after half a day or so of uptime.  I've
> > > > never seen it before today so it may be a regression from 2.6.38.
> > > > Nothing seems have failed as a result.  Please let me know if you
> > > > need any more info.
> > > 
> > > Could you try this patch. I know it may be hard to reproduce, but the
> > > issue is that we are recursing down the locks in a tree/list and we changed a
> > > lock from being nested to being a parent. This patch tells lockdep about
> > > what we did.
> > 
> > OK, I've built 2.6.39-rc5 with this patch applied.  However, it took ~5
> > days before I saw any splat with -rc4, thus it's unlikely that I'll be
> > able to say for sure that it works.
> 
> FWIW, haven't had any problems with this kernel (+ patch) during the
> last two weeks.

I'm going to wrap this up and send it out as a proper patch. Can I add
your "Reported-by" and "Tested-by" tags?

Thanks,

-- Steve

