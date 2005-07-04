From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: Cached NIS map?
Date: Sun, 3 Jul 2005 17:26:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.61.0507031715340.8574@xena.cft.ca.us>
References: <Pine.LNX.4.61.0506301010100.19272@simba.math.ucla.edu>
	<Pine.LNX.4.58.0507011335240.26508@wombat.indigo.net.au>
	<Pine.LNX.4.61.0507011100390.6273@xena.cft.ca.us>
	<Pine.LNX.4.63.0507022037580.3914@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0507022037580.3914@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Sat, 2 Jul 2005, Ian Kent wrote:

> On Fri, 1 Jul 2005, Jim Carter wrote:
> > OK, it's definitely time to upgrade the automounter to 4.1.4.
> 
> Sorry to be a hastle but it might be best to wait for 4.1.5.
> It will be another bug fix release before I start working on enhancements 
> again.
> 
> If you are in a hurry I can give you patches to get you the most important 
> fixes. There are three patches on kernel.org that should be included but 
> there's at least one other that you should have.

We aren't in a real hurry -- given the amount of changes we're making on 
our net, it might actually be prudent to live with the problem and upgrade 
automount later when the dust settles.  There's only one server (the web 
server) that regularly uses auto.home, and restarting the relevant process 
is not a burden once you know what's causing the problem.  

> What kernel version do you use?

Most machines use 2.6.8 from SuSE 9.2.  We're trying out 2.6.11 (SuSE 9.3) 
on a few machines.  

> Do you patch the kernel with the latest revision patches?

If I can get away with using the distro's module, I do, to avoid work and 
screwup exposures when there are kernel upgrades.  This is the autofs 
module in the kernel sources for that version.  SuSE has their kernel 
hacks, but they don't do it gratuitously.

Sorry to be a lazy pig, but I'm frying a lot of fish at once, and if I can 
get SuSE to do an acceptable job on some of them, it really helps.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
