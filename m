From: Ian Kent <raven@themaw.net>
Subject: Re: autofs4 bug fix - 1st attempt
Date: Thu, 25 Mar 2004 22:28:40 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403252218360.8946@raven.themaw.net>
References: <Pine.LNX.4.58.0403232330230.4953@raven.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0403232330230.4953@raven.themaw.net>
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
To: autofs mailing list <autofs@linux.kernel.org>, Michael Blandford <mlblandf@sedona.ch.intel.com>

On Tue, 23 Mar 2004, Ian Kent wrote:

> 
> Hi Michael and autofs list,
> 
> I have a first attempt at a patch for the autofs4 kernel module to fix the 
> problem you reported regarding the cd -> touch problem. Could you please 
> test when you get a chance.
> 
> I need some other people to test it as well. Anyone who does give it a 
> try, please let me know, successful or otherwise.
> 
> The patch(s) can be found at:
> 
> http://www.kernel.org/pub/linux/kernel/people/raven/autofs4-2.4-testing

Anyone who tested a chrooted autofs mount should have found that it didn't 
work. An additional patch named autofs4-2.4.20-chroot-20040317.patch is 
included in the above directory to fix this. Please only apply it after 
the old patch if you already have a patched kernel as change is already 
included in the updated patches there.

Now there are 2.6 patches as well, They are located at:

http://www.kernel.org/pub/linux/kernel/people/raven/autofs4-2.6/2.6.4

There's also a revised set for pre 2.6.4 at:

http://www.kernel.org/pub/linux/kernel/people/raven/autofs4-2.6/2.6.0

which should apply to kernels prior to 2.6.4.

I would greatly appreciate anyone who is in a possition to test them to do 
so and let me know the result.

Ian
