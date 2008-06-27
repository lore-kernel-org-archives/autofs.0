From: Ian Kent <raven@themaw.net>
Subject: Re: automount in status D
Date: Fri, 27 Jun 2008 20:45:25 +0800
Message-ID: <1214570726.3084.139.camel@raven.themaw.net>
References: <48649F59.2050206@aei.mpg.de>
	<1214564777.3084.134.camel@raven.themaw.net>
	<4864D086.3000609@aei.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4864D086.3000609@aei.mpg.de>
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
To: Carsten Aulbert <carsten.aulbert@aei.mpg.de>
Cc: autofs@linux.kernel.org


On Fri, 2008-06-27 at 13:35 +0200, Carsten Aulbert wrote:
> 
> Ian Kent wrote:
> 
> >> Any idea how this happened?
> > 
> > It's been a long time since I've seen this reported.
> > What distro and kernel?
> > 
> 
> Sorry, Debian Etch with self compiled kernel:
> h2:~# uname -a
> Linux h2 2.6.24.4-storage #1 SMP Sun Apr 20 09:33:42 CEST 2008 x86_64
> x86_64 x86_64 GNU/Linux
> h2:~# apt-cache show autofs|grep Version
> Version: 4.1.4-13
> 
> >> Any idea how to get this resolved (possibly without a reboot)?
> > 
> > There is nothing you can do if the process is stuck in an
> > uninterruptible state in the kernel.
> 
> Well, as bad as I feared it to be :(
> 
> Thanks already, reboot is already announced to the users. Anything I
> might help you with to corner that bug?

Aggh .. it's been soooo long since I've heard of this happening I can't
remember.

One thing that is interesting is that the autofs4 kernel module doesn't
do an uninterruptible sleep "anywhere". It hasn't since long before
2.6.24. So if user space can't recover by doing a control-c (maybe even
a couple of times) then it's possibly not actually autofs.

Ian
