From: Ian Kent <raven@themaw.net>
Subject: Re: Horrible denial of service bug in autmount 5
Date: Mon, 23 Jun 2008 15:45:42 +0800
Message-ID: <1214207143.12623.8.camel@raven.themaw.net>
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
	<1214190626.3098.25.camel@raven.themaw.net>
	<26500E84-1F8B-4711-80B7-6A6C5496CCE5@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <26500E84-1F8B-4711-80B7-6A6C5496CCE5@cam.ac.uk>
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


On Mon, 2008-06-23 at 08:15 +0100, Anton Altaparmakov wrote:
> Good morning,
> 
> On 23 Jun 2008, at 04:10, Ian Kent wrote:
> > I see, btw, what is the OpenSuSE rpm revision you are working with?
> > I see an rpm of autofs-5.0.2-30.2.i586.rpm and I'm assuming the
> > autofs.rpm is the source corresponding to that or am I missing  
> > something
> > about the OpenSuSE packaging.
> 
> 
> The one we are using is indeed autofs-5.0.2-30.2.i586.rpm and the  
> corresponding source rpm is autofs-5.0.2-30.2.src.rpm and it can be  
> obtained for example here:
> 
> 	http://www.mirrorservice.org/sites/ftp.opensuse.org/pub/opensuse/update/10.3/rpm/src/autofs-5.0.2-30.2.src.rpm

Got it.
Will check patches against it and make any changes needed.

> 
> Regarding the need to run a single instance: you do realise that init  
> scripts do the exclusion already?  So there should not be any reason  
> to repeat the exclusion in the daemon itself...  At least on SuSE  
> systems this is done by executing daemons using "/sbin/startproc"  
> rather than running the daemons themselves.  So you are basically  
> repeating everything the init script is already doing in the automount  
> daemon which IMHO is rather pointless given I assume all Linux  
> flavours use an analogous init script to launch the automount daemon.

Yeah, not all distributions use a function like this.

The idea here is that, if someone runs the program directly from the
command line, I want the same behavior except for possibly command line
arguments present in the configuration. Such as if someone runs the
program in the foreground maybe with debug enabled. A check to see if it
is already running is just a small part of that.

Ian
