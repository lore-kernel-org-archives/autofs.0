From: raven@themaw.net
Subject: Re: [ANNOUNCE] autofs 4.1.4 beta1 release
Date: Thu, 27 Jan 2005 20:12:49 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0501272002580.8888@donald.themaw.net>
References: <Pine.LNX.4.61.0501262151370.1716@donald.themaw.net>
	<20050126151344.GA841@uio.no>
	<Pine.LNX.4.61.0501262320080.1890@donald.themaw.net>
	<20050126161454.GA9417@uio.no>
	<Pine.LNX.4.58.0501270916190.20105@wombat.indigo.net.au>
	<20050127020231.GB5087@uio.no>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050127020231.GB5087@uio.no>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: autofs@linux.kernel.org

On Thu, 27 Jan 2005, Steinar H. Gunderson wrote:

> (I'm still on the list, no need to Cc me :-) )
>
> On Thu, Jan 27, 2005 at 09:21:10AM +0800, Ian Kent wrote:
>> The Debian side of things really refers to the merging of patches I
>> found in the packages (as best as I could) and some init script changes
>> which you are, no doubt checking.
>
> Well, I'm afraid I can't check that you got all the Debian-specific init
> script changes right, as I don't really know or understand half the problems
> these patches were fixing (and the code they modified seems to have been
> mostly rewritten). As long as you actually reviewed the changes, I guess we
> should be OK. If there'll be a 4.1.4-beta2 (with the missing patches I
> noticed), I'll be happy to put that in experimental and see if people get it
> to work properly without regressions. :-)

I'll put the changes you discussed in.

The main point here is that we really just want a working init script.
The original init script didn't address some problems you were probably
unaware of. Mostly related to master maps with a good number of entries. I 
believe I've delat with much of that within the daemon now so the init 
script is a little simpler and should be OK.

All that really remains then is to ensure that the reported Debian 
problems have also been addressed. Certainly I've tried to include as many 
of the Debian patches as I could, some were catered for in other ways or 
had been applied as part of other patches.

So lets see how we go.

Ian
