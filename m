From: Michael Blandford <mlblandf@sedona.ch.intel.com>
Subject: Re: autofs not mounting directories
Date: Wed, 17 Mar 2004 22:26:00 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <405932E8.4070804@sedona.intel.com>
References: <200403160358.MAA25667@tk3p108pos.tky.swissbank.com>
	<Pine.LNX.4.58.0403171118120.6566@wombat.indigo.net.au>
	<20040317204829.GD12204@vprau.lsil.com>
	<Pine.LNX.4.58.0403180924490.28728@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0403180924490.28728@wombat.indigo.net.au>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent wrote:

>2.4.7. I wonder if the patch I'm creating against 2.4.20 will work for 
>you.
>
>Strange this has gone un-noticed for over 18 months and then suddenly 
>reports are popping up everywhere. Maybe it's just the focus at the moment 
>so everything seems to be caused by it.
>  
>

After we get it fixed for 2.4.20, I will take a stab at backporting it 
to 2.4.9 which will probably be close enough for 2.4.7

Michael
