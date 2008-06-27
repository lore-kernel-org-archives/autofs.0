From: Carsten Aulbert <carsten.aulbert@aei.mpg.de>
Subject: Re: automount in status D
Date: Fri, 27 Jun 2008 14:59:32 +0200
Message-ID: <4864E434.9080909@aei.mpg.de>
References: <48649F59.2050206@aei.mpg.de>	
	<1214564777.3084.134.camel@raven.themaw.net>
	<4864D086.3000609@aei.mpg.de>
	<1214570726.3084.139.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1214570726.3084.139.camel@raven.themaw.net>
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
To: autofs@linux.kernel.org

Hi Ian,

Ian Kent wrote:

> One thing that is interesting is that the autofs4 kernel module doesn't
> do an uninterruptible sleep "anywhere". It hasn't since long before
> 2.6.24. So if user space can't recover by doing a control-c (maybe even
> a couple of times) then it's possibly not actually autofs.

Well, when I tried to umount it manually (with options -f -l -i) stopped
indefinitely when doing a readlink on the mount point itself and never
returned from its own account.

I was able to CTRL-C this one but not getting the mount point removed. A
nasty side effect was that df never returned either.

I did a bit more log reading and it seems that the node got a mount as
well as a umount request yesterday evening and from the nodes
perspective everything looked fine.

In the end I guess this falls into the category of: Hopefully it won't
happen again too soon ;)

If you come up with an idea, please let me know. I'll stay on the list,
reading quietly.

Cheers

Carsten
