From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Horrible denial of service bug in autmount 5
Date: Fri, 20 Jun 2008 21:27:56 -0700
Message-ID: <485C834C.6010507@zytor.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1214016215.4975.50.camel@raven.themaw.net>
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
>> But it is an utterly daft way to implement something like that.  If you 
>> want a lock, create an explicit lock, but doing string-matching on 
>> command lines is idiotic.
> 
> This isn't a lock or anything remotely like it.

It is a lock, or at least something remotely like it.

> And, yes, if run together closely enough the check could easily fail to
> work but that isn't what the check is about.

What is it about, then?

> Put another way, running multiple instances of the autofs version 5
> daemon isn't supported at the moment.
> 
> For the common case usage multiple instances of the daemon aren't
> needed.

Pardon my earlier abrasiveness (I'm having a horrible day), but why not 
simply have /var/lock/automount and flock() it?

That way there is a sane workaround if the special cases, too.

	-hpa
