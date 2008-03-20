From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: Long timeout on broken DNS server
Date: Thu, 20 Mar 2008 08:51:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0803200846190.16309@simba.math.ucla.edu>
References: <20080320050635.E2FA33C3B0@xena.cft.ca.us>
	<1205995564.30292.10.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1205995564.30292.10.camel@raven.themaw.net>
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

On Thu, 20 Mar 2008, Ian Kent wrote:
> On Wed, 2008-03-19 at 22:06 -0700, Jim Carter wrote:
> > Today I upgraded one of my three DNS servers, the first listed in
> > /etc/resolv.conf, and until I got it back on the air, autofs mounting
> > was glacial...
> 
> Not sure about the 5 seconds, I thought the timeout was longer, but I
> think autofs is doing DNS lookus for the same name more often than it
> needs to.

The current man page for resolv.conf(5) says the default timeout is 5 secs, 
and the apps behave as if that were true.  There's an option to tweak the 
timeout, and it's been suggested to shorten the time, since on a local 
lookup if you don't get an answer in 1 sec you're never going to get it -- 
but the timeout applies to global lookups too, which can take longer 
legitimately, if several stages of forwarders and recursion are involved.

> I'll have a look and see if I can put something together for you to
> test.

Thanks for looking into this -- I'll test the package on one of the 
machines running 5.0.2 presently.  

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 520 Portola Plaza; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
