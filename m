From: Ian Kent <raven@themaw.net>
Subject: Re: autofs not mounting directories
Date: Thu, 18 Mar 2004 14:47:15 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403181439100.1741@wombat.indigo.net.au>
References: <200403160358.MAA25667@tk3p108pos.tky.swissbank.com>
	<Pine.LNX.4.58.0403171118120.6566@wombat.indigo.net.au>
	<Pine.LNX.4.58.0403180924490.28728@wombat.indigo.net.au>
	<405932E8.4070804@sedona.intel.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <405932E8.4070804@sedona.intel.com>
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
To: Michael Blandford <mlblandf@sedona.ch.intel.com>
Cc: autofs@linux.kernel.org

On Wed, 17 Mar 2004, Michael Blandford wrote:

> Ian Kent wrote:
> 
> >2.4.7. I wonder if the patch I'm creating against 2.4.20 will work for 
> >you.
> >
> >Strange this has gone un-noticed for over 18 months and then suddenly 
> >reports are popping up everywhere. Maybe it's just the focus at the moment 
> >so everything seems to be caused by it.
> >  
> >
> 
> After we get it fixed for 2.4.20, I will take a stab at backporting it 
> to 2.4.9 which will probably be close enough for 2.4.7
> 

Shouldn't be to bad. It needed practically no changes until about 2.4.18 
or 20.

I may have the patch done tonight.

One consequence of this is that when cd'ing to a directory we will have to 
trigger the mount. To do it any other way will mean, essentially, 
rewriting autofs4 from the ground up. Maybe not a bad idea, but not now.
At least that is my impression atm.


Ian
