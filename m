From: Michael Loftis <mloftis@wgops.com>
Subject: Re: AutoFS Race Conditions?  Negative Cache?
Date: Mon, 02 Feb 2009 20:55:33 -0700
Message-ID: <36B93B4496845E1C4544EFD9@ZOP-MACTEL.local>
References: <F76FAA9B4E7600AAC1FFA15B@ZOP-MACTEL.local>	
	<1233113406.3005.21.camel@zeus.themaw.net>	
	<E53DDD7AD6715F60A879D415@ZOP-MACTEL.local>	
	<1233621955.2951.18.camel@zeus.themaw.net>	
	<587B15FCE26A5069952E314B@ZOP-MACTEL.local>
	<1233632076.2951.32.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1233632076.2951.32.camel@zeus.themaw.net>
Content-Disposition: inline
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
Cc: autofs@linux.kernel.org



--On February 3, 2009 12:34:36 PM +0900 Ian Kent <raven@themaw.net> wrote:


> Using "-n" is likely a problem for autofs prior to 5.0.4 but would also
> require the 2.6.28 kernel module patch update for the kernel you are
> using and you need to tell autofs to use the newly introduced ioctl
> interface otherwise it will still scan mtab from time to time, expecting
> it to be up to date.
>
> But, once the above is in place it should be possible to use a "-n" on
> the mount commands without affecting autofs function. Not sure the best
> way to provide that though.

hmmm food for thought anyway.  I'm always leery of moving forward to newer 
linux kernels, not much of a problem in Debian since they pick a version 
and keep with it throughout a release.  I may or may not have time to 
dedicated to work with the patch you provided for autofs5 immediately, 
right now our push is to just get this deployed.  I didn't realize the 
automounter scanned mtab though, so that's good to know.

I greatly appreciate your help Ian, and will let you guys know of any 
gotchas we run into.  It's a pretty odd environment, serving jails for ~10k 
domains so when something doesn't work right even 1% of the time it's 
usually pretty obvious.


>
> Ian
>
>



-- 
"Genius might be described as a supreme capacity for getting its possessors
into trouble of all kinds."
-- Samuel Butler
