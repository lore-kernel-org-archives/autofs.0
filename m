From: Ian Kent <raven@themaw.net>
Subject: Re: Not correctly mount SMB shares ending in $
Date: Tue, 16 Sep 2008 12:48:33 +0800
Message-ID: <1221540513.3084.16.camel@raven.themaw.net>
References: <48C5F518.9010800@edcint.co.nz>
	<1221018586.3030.63.camel@raven.themaw.net>
	<48C8D7FE.9000501@edcint.co.nz>
	<1221142584.28271.15.camel@raven.themaw.net>
	<48CB1F71.50407@edcint.co.nz>
	<1221539403.15861.108.camel@homebase.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1221539403.15861.108.camel@homebase.localnet>
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
To: psmith@netezza.com
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Tue, 2008-09-16 at 00:30 -0400, Paul Smith wrote:
> On Sat, 2008-09-13 at 12:03 +1000, Matthew Jurgens wrote:
> > Ok, so I updated the script to the RPM version and added the
> > authentication parts:
> > 
> > #!/bin/bash
> 
> I guess maybe it's my pet peeve (like people who write "loose" when they
> mean "lose", and vice versa), but I'd really, really love it if we could
> avoid using bash in shell scripts, especially where (as in this case)
> it's completely unnecessary.
> 
> Can't we write our scripts in /bin/sh?
> 
> I have some embedded systems that use autofs and I surely don't want to
> have to build and install bash in my nice, small, busybox-based RAMDISK
> just to run a few support scripts.  And it would be nice if I didn't
> have to gin up custom patches for them either.  It's very, very simple
> in virtually all cases to write your script in POSIX-standard sh rather
> than bash... it just requires a bit of diligence.

I admit I don't usually think of embedded systems.
I'll have to get onto that but I don't think version 5 is appropriate
for an embedded system (maybe too big) and version 4 hasn't seen much
love for a good while now.

Anyway, I expect you have more than enough trouble setting up working
tool chains than to have to worry about this sort of thing, ;)

Ian
