From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Horrible denial of service bug in autmount 5
Date: Sun, 22 Jun 2008 18:08:21 -0700
Message-ID: <485EF785.3020308@zytor.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <alpine.LSU.1.10.0806230318150.22566@hermes-1.csi.cam.ac.uk>
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
Cc: autofs@linux.kernel.org, Anton Altaparmakov <aia21@cam.ac.uk>, Unix Support <unix-support@ucs.cam.ac.uk>, Ian Kent <raven@themaw.net>

J.P. King wrote:
> 
> As I said previously, because this is quite hard.  The maps need to be 
> changed by the login process.  We currently do this in the PAM 
> configuration.  Given that we can have multiple log in at the same time 
> this means we need to do a lot of careful locking.
> 
> Ideally we would do something like include all the files from a 
> configuration directory and have a HUP get it to re-read all these 
> configuration snippets.  This would be a relatively involved change 
> however.
> 

This sounds like a perfect use of an executable map to me.  I don't know 
exactly what your maps look like, but it seems to me that since you have 
an unusual local requirement it would make sense to deal with it in a 
manner external to autofs itself.

	-hpa
