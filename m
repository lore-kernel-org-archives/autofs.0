From: Ian Kent <raven@themaw.net>
Subject: Re: autofs not mounting directories
Date: Thu, 18 Mar 2004 09:30:39 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403180924490.28728@wombat.indigo.net.au>
References: <200403160358.MAA25667@tk3p108pos.tky.swissbank.com>
 <Pine.LNX.4.58.0403171118120.6566@wombat.indigo.net.au>
 <20040317204829.GD12204@vprau.lsil.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040317204829.GD12204@vprau.lsil.com>
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
To: Robert Au <rau@lsil.com>
Cc: autofs@linux.kernel.org

On Wed, 17 Mar 2004, Robert Au wrote:

> > 
> > Sounds like you may be suffering from the same problem that was reported 
> > by Michael Blandford. I'm mystified I haven't seen the problem before as 
> > it is so fundamental to proper operation.
> 
> I don't see Michael's original report in the list archives. Did he send it
> to the list?

No.

It was reported when he was testing changes he had requested for 4.1.1. 

>  
> > I'll be looking to get a test group together from the list in a couple of 
> > days.
> 
> I think we are seeing something similar here; sporadically, listing a file
> with ls will fail until a process changes working directory to that file's
> directory. I'd like to help out in the testing. We are seeing this problem
> with Red Hat 7.2 (kernel 2.4.7-10), autofs 4.1.0, and kernel module
> autofs4-2.4-module-20031201.

2.4.7. I wonder if the patch I'm creating against 2.4.20 will work for 
you.

Strange this has gone un-noticed for over 18 months and then suddenly 
reports are popping up everywhere. Maybe it's just the focus at the moment 
so everything seems to be caused by it.

Ian
