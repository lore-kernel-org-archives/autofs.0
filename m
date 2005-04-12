From: Ian Kent <raven@themaw.net>
Subject: Re: Re: autofs>3.9.99-4.0.0pre10-16 doesn't work any more
	for me
Date: Tue, 12 Apr 2005 08:51:44 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0504120847310.6867@wombat.indigo.net.au>
References: <E1DD8yC-0005oi-61@mago.wo.de> <20050409120352.GA12001@uio.no>
	<ifbr8o6m1u.fsf@mago.linux-lounge.it.fh-worms.de>
	<20050409151430.GA4432@uio.no>
	<Pine.LNX.4.62.0504101029160.1694@donald.themaw.net>
	<ifvf6uwqd2.fsf@mago.linux-lounge.it.fh-worms.de>
	<Pine.LNX.4.58.0504110909070.9299@wombat.indigo.net.au>
	<ifr7hhzvoy.fsf@mago.linux-lounge.it.fh-worms.de>
	<Pine.LNX.4.58.0504111630150.18235@wombat.indigo.net.au>
	<ifpsx1is4x.fsf@mago.linux-lounge.it.fh-worms.de>
	<Pine.LNX.4.62.0504112239420.3448@donald.themaw.net>
	<if7jj9unnq.fsf@mago.wo.de>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <if7jj9unnq.fsf@mago.wo.de>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Ruppert <ruppert@Fh-Worms.de>
Cc: autofs@linux.kernel.org, 300648@bugs.debian.org, ruppert@mago.linux-lounge.it.fh-worms.de

On Mon, 11 Apr 2005, Martin Ruppert wrote:

> 
> First part is a screen log installing autofs_4.1.3-9 and trying to
> mount with it and then installing autofs_4.1.3+4.1.4beta2-7 and again
> trying to mount with. I didn't have version 4.1.3+4.1.4beta2-7 before
> today.
> 
> And the good news: version 4.1.3+4.1.4beta2-7 works again, although i
> don't know why.

I've just realised, your using the ":" Sun escape with a multi-mount map.

This problem was fixed during the 4.1.4 development. I'm suprised to hear 
that it worked in 4.0. I must have broken it by accident in 4.1.

Sorry to have missed it before.

Ian
