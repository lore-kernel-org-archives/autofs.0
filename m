From: Ian Kent <raven@themaw.net>
Subject: Re: clients suddenly start hanging (was: (no subject))
Date: Wed, 25 Jun 2008 13:00:11 +0800
Message-ID: <1214370012.12623.155.camel@raven.themaw.net>
References: <20080423185018.122C53C3B1@xena.cft.ca.us>
	<1213414942.18072.26.camel@raven.themaw.net>
	<1213845274.2971.11.camel@raven.themaw.net>
	<20080619183446.532D82111B1@simba.math.ucla.edu>
	<1213934961.2971.69.camel@raven.themaw.net>
	<Pine.LNX.4.64.0806201713350.13828@xena.cft.ca.us>
	<1214017944.4975.60.camel@raven.themaw.net>
	<Pine.LNX.4.64.0806222024150.18218@xena.cft.ca.us>
	<1214196368.3098.41.camel@raven.themaw.net>
	<1214276906.12623.88.camel@raven.themaw.net>
	<Pine.LNX.4.64.0806241634330.17807@xena.cft.ca.us>
	<1214364822.12623.152.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1214364822.12623.152.camel@raven.themaw.net>
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs@linux.kernel.org


On Wed, 2008-06-25 at 11:33 +0800, Ian Kent wrote:
> On Tue, 2008-06-24 at 16:39 -0700, Jim Carter wrote:
> > On Tue, 24 Jun 2008, Ian Kent wrote:
> > 
> > > > > There is a pattern of failure that may not be automount's fault.  On 
> > > > > almost exactly 0.1% of the attempted mounts, the readdir eventually fails 
> > > > > with ENOENT....
> > > 
> > > This could be related to the expire issue I saw in my tests so we need
> > > to test my slightly updated patch and see before we go into this.
> > > Hopefully I haven't regressed from the last test.
> > > 
> > > So here is my updated revision 8 of the patch against the SuSE package
> > > as usual.
> > 
> > OK, I ran it for 4 hrs 19 mins, doing 5900 mount-expire cycles.  No threads 
> > hung.  There were 5 ENOENT events -- the rate was not statistically 
> > different from the previous long test.  
> 
> Would it be to difficult to get a debug log for this.
> I need to find out whether this is happening in the kernel or in the
> daemon.

And if possible an indication of when a couple of these events occurred
would be really useful, so I can locate them in the log.

Ian
