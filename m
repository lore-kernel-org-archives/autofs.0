From: Ian Kent <raven@themaw.net>
Subject: Re: clients suddenly start hanging (was: (no subject))
Date: Thu, 12 Jun 2008 11:20:29 +0800
Message-ID: <1213240830.4994.82.camel@raven.themaw.net>
References: <20080423185018.122C53C3B1@xena.cft.ca.us>
	<1211510100.15090.27.camel@raven.themaw.net>
	<20080526003442.F3E27211250@simba.math.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080526003442.F3E27211250@simba.math.ucla.edu>
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


On Sun, 2008-05-25 at 17:34 -0700, Jim Carter wrote:
> I applied autofs-5.0.3-expire-thread-create-cond-handling.patch.  There
> is still hanging, but I have the impression that it may be a bit less 
> than before: 4 hangs in 3+ hours, having mounted 247 filesystems.  Below 
> I've included backtraces from all 4 hangs (oink, oink).  
> 
> There was one confusing incident in this test run: after one of the
> filesystems was automounted, the host machine crashed (or more likely,
> the owner pulled the Ethernet cable so he could plug in his laptop).
> This caused every access to that machine to be very slow, which the test
> program interpreted as hung automount processes.  I snipped those out.
> Likely you won't see any evidence -- I don't see the string
> /net/rangers/m1 in any argument list -- but if you notice a thread
> working on that filesystem, ignore it.
> 
> (Re. Heads Up: I'm using the SuSE copy of the source, not GIT.  The 
> patch went on with no complaints.)

Hi Jim,

I've been working on this.

I believe there is still a problem somewhere but I'm going to send over
another test snapshot for testing.

Ian
