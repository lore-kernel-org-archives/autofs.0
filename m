From: raven@themaw.net
Subject: Re: mount point created if automount map is empty during
 daemon startup?
Date: Tue, 4 May 2004 23:57:55 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405042354490.17014@donald.themaw.net>
References: <20040504010928.GL14889@sun.com>
	<Pine.LNX.3.96.1040503181623.4110A-100000@Maggie.Linux-Consulting.com>
	<20040503175506.GA14889@sun.com>
	<Pine.LNX.4.58.0405040904450.24480@wombat.indigo.net.au>
	<20040504122536.GK5041@neu.nirvana> <4097AABF.5050709@freescale.com>
	<16535.45364.767370.38110@segfault.boston.redhat.com>
	<4097B8CF.9050104@freescale.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4097B8CF.9050104@freescale.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tom Georgoulias <tom.georgoulias@freescale.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Tue, 4 May 2004, Tom Georgoulias wrote:

> raven@themaw.net wrote:
> 
> > Saw that patch. Was a bit curious about it. Didn't add it.
> 
> And it sounds like I ought to remove it, too.  :)
> 
> Judging by your test results on an empty map, an upgrade to 4.1.2 is in 
> order.  Thanks for checking in to that, I appreciate it. I'll start 
> working on getting out a new build of autofs to my systems.  4.1.3 is 
> just around the corner, right?
> 

Yes.

Yet another bug fix release.

Not much in it.

CHANGELOG so far:

xx/xx/2004 autofs-4.1.3
-----------------------
- fixed bug processing --verbose option in init scripts.
- added missing parameter in call to run fsck on ext2 module (from Jeff 
Moyer).
- added check for executable existance in getldapmounts in init script.
- updated comment about option handling in getmounts in init script.
- updated kernel module patches.
- fix to init script for reload option.
- autofs now requires autoconf later than 2.5

Plus the replicated server patch I'm currently working on and another 
kernel module patch update.

I think that will be it for 4.1.3 as the kernel module patches need to be 
updated due to corrections.

Ian
