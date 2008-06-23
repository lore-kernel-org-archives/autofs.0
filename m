From: Ian Kent <raven@themaw.net>
Subject: Re: Horrible denial of service bug in autmount 5
Date: Mon, 23 Jun 2008 11:10:25 +0800
Message-ID: <1214190626.3098.25.camel@raven.themaw.net>
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
	<1214188853.3098.19.camel@raven.themaw.net>
	<alpine.LSU.1.10.0806230354360.22566@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <alpine.LSU.1.10.0806230354360.22566@hermes-1.csi.cam.ac.uk>
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


On Mon, 2008-06-23 at 03:55 +0100, J.P. King wrote:
> >> our problem.  You have a bug/DOS which we identified whilst looking for a
> >> reason that something had broken between OpenSUSE 10.2 and OpenSUSE 10.3.
> >> Clearly we are going to hope that when you fix your bug we can backport
> >> the solution and solve our problem.  If we can't we can't, and we will
> >> work around whatever issues we have left.
> >
> > You keep on about this, I've already said I'll fix it, let it go!
> 
> I'm trying to emphasise that we aren't demanding that you make changes to 
> meet our needs!  I don't want anyone reading this thread to think that 
> we're throwing our toys out of the pram demanding that changes be made to 
> suit our needs.

I see, btw, what is the OpenSuSE rpm revision you are working with?
I see an rpm of autofs-5.0.2-30.2.i586.rpm and I'm assuming the
autofs.rpm is the source corresponding to that or am I missing something
about the OpenSuSE packaging.

Ian
