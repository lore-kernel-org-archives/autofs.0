From: "Ogden, Aaron A." <aogden@unocal.com>
Subject: RE: multiple servers per automount
Date: Thu, 9 Oct 2003 17:07:36 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <6AB920CC10586340BE1674976E0A991D0C6B7B@slexch2.sugarland.unocal.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
content-class: urn:content-classes:message
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: autofs mailing list <autofs@linux.kernel.org>, Ian Kent <raven@themaw.net>



-----Original Message-----
From: Mike Waychison [mailto:Michael.Waychison@Sun.COM] 
Sent: Thursday, October 09, 2003 4:37 PM
To: Ogden, Aaron A.
Cc: autofs mailing list; Ian Kent
Subject: Re: [autofs] multiple servers per automount


> I don't see how the autofs code would cause such a problem...

I don't either.  There are a lot of variables at work though...

> 2.6 mainline still has the 256 pseudo-block device limit.
Fortunately, 
> the patches used in distros should still apply with minimal fuzz.
Devfs 
> probably won't help matters here.  

That is depressing... here I was thinking that 2.6 would be some kind of
utopian wonderland free of problems.  :-(

> I think the next step in 2.6 is to change the bitmap used to grow as 
> needed..  especially now that minors are 20 bits, or 1048576 minors
:))

Yes that is what I was thinking about, unfortunately I don't know the
details, I'm working off of a hazy memory.  I thought devfs didn't use
the major/minor concept anymore?  I'm curious to see how it will work
with storage devices, esp. hot-pluggable devices like SCSI and USB
drives.  Right now their device names change depending on the order that
they are connected, it's quite confusing.  Someone at Dell wrote
software to keep the device names constant by using aliases for them.
It's a nice concept but it's just a hack, the real problem is that we
don't have /dev/c0t0d0s0 as in Solaris.
