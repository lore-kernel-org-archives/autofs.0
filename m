From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Horrible denial of service bug in autmount 5
Date: Fri, 20 Jun 2008 21:54:02 -0700
Message-ID: <485C896A.6050701@zytor.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1214023459.4975.90.camel@raven.themaw.net>
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
Cc: autofs@linux.kernel.org, Anton Altaparmakov <aia21@cam.ac.uk>, Unix Support <unix-support@ucs.cam.ac.uk>

Ian Kent wrote:
> 
> True and I very nearly wrote back and said that but then I started to
> remember the painful issues of SIGKILL and trying to work out if the
> flag file is really valid and the issues of mount(8) using a lock file
> with flock() and stopped myself.
> 

I think the issues with mount(8) had to do with backwards compatibility; 
after all, it's one of the very first Linux utilities at all.

> But, yes, I could do that.
> 
> To support multiple instances I will need to check in a few places that
> I don't interfere with other process mounts. I suspect the Cambridge
> guys have either been lucky so far and possibly not properly
> investigated the issue. They don't seem to want to discuss it either so
> I fear their in for an unpleasant surprise at some point.

Yeah, that's another ball of wax entirely.

	-hpa
