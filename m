From: Tom Georgoulias <tom.georgoulias@freescale.com>
Subject: Re: mount point created if automount map is empty during
 daemon startup?
Date: Tue, 04 May 2004 15:41:20 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <4097FFF0.5020206@freescale.com>
References: <20040504010928.GL14889@sun.com>
	<Pine.LNX.3.96.1040503181623.4110A-100000@Maggie.Linux-Consulting.com>
	<Pine.LNX.4.58.0405032046130.3257@donald.themaw.net>
	<20040503175506.GA14889@sun.com> <20040504003214.GA31852@neu.nirvana>
	<Pine.LNX.4.58.0405040904450.24480@wombat.indigo.net.au>
	<20040504122536.GK5041@neu.nirvana> <4097AABF.5050709@freescale.com>
	<16535.45364.767370.38110@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0405042317540.17014@donald.themaw.net>
	<4097B8CF.9050104@freescale.com>
	<Pine.LNX.4.58.0405042354490.17014@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405042354490.17014@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: raven@themaw.net
Cc: autofs mailing list <autofs@linux.kernel.org>

raven@themaw.net wrote:
> On Tue, 4 May 2004, Tom Georgoulias wrote:
> 
> 
>>raven@themaw.net wrote:
>>
>>
>>>Saw that patch. Was a bit curious about it. Didn't add it.
>>
>>And it sounds like I ought to remove it, too.  :)
>>
>>Judging by your test results on an empty map, an upgrade to 4.1.2 is in 
>>order.  Thanks for checking in to that, I appreciate it. I'll start 
>>working on getting out a new build of autofs to my systems.  4.1.3 is 
>>just around the corner, right?
>>
> 
> 
> Yes.
> 
> Yet another bug fix release.
> 
> Not much in it.
> 
> CHANGELOG so far:
> 
> xx/xx/2004 autofs-4.1.3
> -----------------------
> - fixed bug processing --verbose option in init scripts.
> - added missing parameter in call to run fsck on ext2 module (from Jeff 
> Moyer).
> - added check for executable existance in getldapmounts in init script.
> - updated comment about option handling in getmounts in init script.
> - updated kernel module patches.
> - fix to init script for reload option.
> - autofs now requires autoconf later than 2.5
> 
> Plus the replicated server patch I'm currently working on and another 
> kernel module patch update.
> 
> I think that will be it for 4.1.3 as the kernel module patches need to be 
> updated due to corrections.

Should I wait for the kernel module patches or just go ahead with testing?

I have set aside a Red Hat 8 system to test out the latest patches you 
have written and want to be sure I make this test as productive as 
possible for all.

I'm looking at either running the autofs 4.1.2 plus patches from 
kernel.org, or Jeff Moyer's latest RPM, 4.1.2-5, and using either the 
04172004 kernel module patch or waiting for a new one.

Tom
-- 
Tom Georgoulias
POPI Classification
[x] General Business Information
[] Freescale Semiconductor Internal Use
[] Freescale Semiconductor Confidential Proprietary
