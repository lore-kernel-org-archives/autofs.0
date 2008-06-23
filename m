From: Ian Kent <raven@themaw.net>
Subject: Re: Horrible denial of service bug in autmount 5
Date: Mon, 23 Jun 2008 17:18:38 +0800
Message-ID: <1214212719.12623.71.camel@raven.themaw.net>
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
	<8109C868-FFB0-4AF3-A667-FEA9F6693558@cam.ac.uk>
	<1214211791.12623.58.camel@raven.themaw.net>
	<1214212340.12623.67.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1214212340.12623.67.camel@raven.themaw.net>
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
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: autofs@linux.kernel.org, "J.P. King" <jpk28@cam.ac.uk>, Unix Support <unix-support@ucs.cam.ac.uk>, "H. Peter Anvin" <hpa@zytor.com>


On Mon, 2008-06-23 at 17:12 +0800, Ian Kent wrote:
> On Mon, 2008-06-23 at 17:03 +0800, Ian Kent wrote:
> > > 
> > > /servers/aia21 file:/var/run/pwfautomount/auto.aia21
> > 
> > Here we might use:
> > /servers	file:/<any dir you want>/auto.user
> > 
> > For the map entries below this might be something like:
> > * -fstype=autofs file:/var/run/pwfautomount/auto.&
> > 
> 
> Clearly this could well be "program:/var/run/pwfautomount/auto.&" and
> contain the logic to generate the mount location. But it would be called
> to lookup the mount location whenever a request to mount a given <key>
> comes in (eg. /devsers/<user>/<key>) which may introduce unacceptable
> overhead.
> 
> If this was used then the program map would return:
> 
> -fstype=autofs file:/var/run/pwfautomount/auto.&

Oops, that's not right.
It would return the location corresponding to the passed in key.

Ignore my comment about a program map, it's not right, I'll need to
re-think that.

Ian
