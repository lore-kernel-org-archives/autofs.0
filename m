From: Ian Kent <raven@themaw.net>
Subject: Re: Cached NIS map?
Date: Mon, 4 Jul 2005 09:09:40 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0507040901080.20510@wombat.indigo.net.au>
References: <Pine.LNX.4.61.0506301010100.19272@simba.math.ucla.edu>
	<Pine.LNX.4.58.0507011335240.26508@wombat.indigo.net.au>
	<Pine.LNX.4.61.0507011100390.6273@xena.cft.ca.us>
	<Pine.LNX.4.63.0507022037580.3914@donald.themaw.net>
	<Pine.LNX.4.61.0507031715340.8574@xena.cft.ca.us>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0507031715340.8574@xena.cft.ca.us>
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs@linux.kernel.org

On Sun, 3 Jul 2005, Jim Carter wrote:

> On Sat, 2 Jul 2005, Ian Kent wrote:
> 
> > On Fri, 1 Jul 2005, Jim Carter wrote:
> > > OK, it's definitely time to upgrade the automounter to 4.1.4.
> > 
> > Sorry to be a hastle but it might be best to wait for 4.1.5.
> > It will be another bug fix release before I start working on enhancements 
> > again.
> > 
> > If you are in a hurry I can give you patches to get you the most important 
> > fixes. There are three patches on kernel.org that should be included but 
> > there's at least one other that you should have.
> 
> We aren't in a real hurry -- given the amount of changes we're making on 
> our net, it might actually be prudent to live with the problem and upgrade 
> automount later when the dust settles.  There's only one server (the web 
> server) that regularly uses auto.home, and restarting the relevant process 
> is not a burden once you know what's causing the problem.  

Absolutely. I agree with you completely.

> 
> > What kernel version do you use?
> 
> Most machines use 2.6.8 from SuSE 9.2.  We're trying out 2.6.11 (SuSE 9.3) 
> on a few machines.  
> 
> > Do you patch the kernel with the latest revision patches?
> 
> If I can get away with using the distro's module, I do, to avoid work and 
> screwup exposures when there are kernel upgrades.  This is the autofs 
> module in the kernel sources for that version.  SuSE has their kernel 
> hacks, but they don't do it gratuitously.

That's great because we 2.6.11 is pretty much upto date except for a 
couple of patches that are coming through in later versions.

I understand it's best to stick with vendor kernels whereever possible for 
obvious support reasons.

Ian
