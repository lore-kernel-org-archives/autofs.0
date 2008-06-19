From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: clients suddenly start hanging (was: (no subject))
Date: Thu, 19 Jun 2008 10:08:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0806191004170.24525@simba.math.ucla.edu>
References: <20080423185018.122C53C3B1@xena.cft.ca.us> 
	<1213414942.18072.26.camel@raven.themaw.net>
	<20080619004048.05EC42111B0@simba.math.ucla.edu>
	<1213845274.2971.11.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1213845274.2971.11.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Thu, 19 Jun 2008, Ian Kent wrote:

> On Wed, 2008-06-18 at 17:40 -0700, Jim Carter wrote:
> > At first I thought it was still failing as before, but on looking more
> > closely at the output I see a new behavior which is much better than 
> > failing.  After 35 minutes and about 1200 mount/unmount cycles, it took
> > over 25 seconds to mount (and readdir) 12 filesystems distributed over
> > 6 machines.  2 minutes later these all had been mounted...
> 
> Sorry, I'm not entirely clear on what you described here.
> Are you saying that there were no hangs but you observed only, what
> appeared to be, significant delays.

Yes, at that point the program was triggering on unexpectedly long delays 
which eventually concluded in mounting the filesystem.  However...  See 
the soon-to-be-posted report (with backtrace).

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 520 Portola Plaza; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
