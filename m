From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: Horrible denial of service bug in autmount 5
Date: Sun, 22 Jun 2008 22:33:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0806222230010.18218@xena.cft.ca.us>
References: <8332BEF1-7FA5-434F-B444-9F8820A61B83@cam.ac.uk>
	<1213969464.2971.107.camel@raven.themaw.net>
	<5A1DEB9E-FD94-455E-AB89-05D9E74084B5@cam.ac.uk>
	<1213974299.4975.15.camel@raven.themaw.net>
	<095037D1-F2F1-4A08-A6D2-841C22D8BC5C@cam.ac.uk>
	<1213975734.4975.17.camel@raven.themaw.net>
	<485BE2E6.9080509@zytor.com>
	<1213986137.4975.39.camel@raven.themaw.net>
	<485BFF00.7020205@zytor.com>
	<1214016215.4975.50.camel@raven.themaw.net>
	<485C834C.6010507@zytor.com>
	<1214023459.4975.90.camel@raven.themaw.net>
	<alpine.LSU.1.10.0806211007570.22566@hermes-1.csi.cam.ac.uk>
	<1214186003.3098.10.camel@raven.themaw.net>
	<alpine.LSU.1.10.0806230318150.22566@hermes-1.csi.cam.ac.uk>
	<485EF785.3020308@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <485EF785.3020308@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: autofs@linux.kernel.org, Anton Altaparmakov <aia21@cam.ac.uk>, "J.P. King" <jpk28@cam.ac.uk>, Unix Support <unix-support@ucs.cam.ac.uk>, Ian Kent <raven@themaw.net>

On Sun, 22 Jun 2008, H. Peter Anvin wrote:

> J.P. King wrote:
> > Ideally we would do something like include all the files from a 
> > configuration directory and have a HUP get it to re-read all these 
> > configuration snippets.  This would be a relatively involved change 
> > however.
> > 
> 
> This sounds like a perfect use of an executable map to me.  I don't know 
> exactly what your maps look like, but it seems to me that since you have 
> an unusual local requirement it would make sense to deal with it in a 
> manner external to autofs itself.

That's an excellent suggestion!  At my site we used an executable map to 
get the effect of submounts, before I figured out how to do the job with 
submounts.  It was reliable and reasonably efficient.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
