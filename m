From: Ian Kent <raven@themaw.net>
Subject: Re: Horrible denial of service bug in autmount 5
Date: Mon, 23 Jun 2008 09:53:22 +0800
Message-ID: <1214186003.3098.10.camel@raven.themaw.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <alpine.LSU.1.10.0806211007570.22566@hermes-1.csi.cam.ac.uk>
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
To: "J.P. King" <jpk28@cam.ac.uk>
Cc: autofs@linux.kernel.org, Anton Altaparmakov <aia21@cam.ac.uk>, Unix Support <unix-support@ucs.cam.ac.uk>, "H. Peter Anvin" <hpa@zytor.com>


On Sat, 2008-06-21 at 10:18 +0100, J.P. King wrote:
> > To support multiple instances I will need to check in a few places that
> > I don't interfere with other process mounts. I suspect the Cambridge
> > guys have either been lucky so far and possibly not properly
> > investigated the issue.
> 
> The Cambridge guys have been using earlier versions of autofs which didn't 
> have this restriction (currently 4.1).  Whether there was a bug that we 
> were sometimes triggering is a different matter.  I am not aware of the 
> potential issue that you think we could be hitting, and I am unclear how 
> it could be something that was automount's problem, as opposed to a 
> general mounting filesystems race condition.

Sure, but version 5 is very different from version 4 and because it is
meant to run as a single instance there is potential for conflict.

It may well be the case that indirect maps are fine as they generally
restrict themselves to within their mount point but I'm fairly sure that
direct maps won't be OK.

> 
> > They don't seem to want to discuss it either so
> > I fear their in for an unpleasant surprise at some point.
> 
> Not only do we want to discuss it, we have been.  We are also happy to put 
> work into resolving the issue.  However we have identified a trivial DOS
> and some, frankly, poor code, and there seems to be some reluctance in 
> accepting that this is an issue, regardless of any specific problems we're 
> having.

No, I'm not reluctant to accept that it is an issue but you need to
consider that running multiple instances may not be the right way to
achieve what you need with this version of autofs.

Is there some reason you can't update the master map and send a HUP
signal to the daemon?

Ian
