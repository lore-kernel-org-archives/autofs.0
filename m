From: Ian Kent <raven@themaw.net>
Subject: Re: clients suddenly start hanging (was: (no subject))
Date: Mon, 23 Jun 2008 12:15:50 +0800
Message-ID: <1214194551.3098.28.camel@raven.themaw.net>
References: <20080423185018.122C53C3B1@xena.cft.ca.us>
	<1213414942.18072.26.camel@raven.themaw.net>
	<1213845274.2971.11.camel@raven.themaw.net>
	<20080619183446.532D82111B1@simba.math.ucla.edu>
	<1213934961.2971.69.camel@raven.themaw.net>
	<Pine.LNX.4.64.0806201713350.13828@xena.cft.ca.us>
	<1214017944.4975.60.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1214017944.4975.60.camel@raven.themaw.net>
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


On Sat, 2008-06-21 at 11:12 +0800, Ian Kent wrote:
> On Fri, 2008-06-20 at 18:02 -0700, Jim Carter wrote:
> > On Fri, 20 Jun 2008, Ian Kent wrote:
> > 
> > > So here is autofs-5.0.3-submount-shutdown-recovery-8.patch.
> > > Please try it instead of revision 7.
> > 
> > The patch went on cleanly.  However, there was a problem in execution.
> > The output was:
> > 
> > 17:00:14 --                   #1, chkd 0, run 0, OK 570, mtd 2, of 570
> > 
> > Jun 20 17:00:22 serval automount[2799]: unexpected pthreads error: -1 at 
> > 901 in master.c
> 
> Ooops, I didn't pay enough attention when I read the pthread barrier man
> page. That isn't actually an error return but now I'm wondering why I
> haven't seen it in my test, very odd.
> 
> Let me fix it and we'll try again.
> 
> There are other problems but I need to know if this is a viable approach
> before going further with it.
> 
> Try this instead.
> 
> autofs-5.0.3 - fix submount shutdown handling.

Actually it might be better to wait for a little and give me a chance to
try and fix the expiration.

Ian
