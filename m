From: Dan Halbert <halbert@everyzing.com>
Subject: Re: ENOENT on first reference to an automounted file
Date: Fri, 19 Oct 2007 09:20:21 -0400
Message-ID: <4718AF15.3090204@everyzing.com>
References: <D31A6D71-AB0C-45C0-A371-66AB549253BE@isolar.dyndns.org>
	<1192780957.24353.10.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1192780957.24353.10.camel@raven.themaw.net>
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
To: autofs@kernel.org

Ian Kent wrote:
> 
> Well, if we can't confirm the problem and resolution then I have no case
> to put for an update.
> 
> No-one has volunteered to try the patches I referred to in this thread
> and that's why I haven't posted them, so how about it, someone?

Ian (& Greg & Jeff),

Maybe there's a bit of cross-purpose communication here. In an earlier 
message, Jeff said he had reproduced the problem by using exactly our 
kernel (2.6.9-55.0.9.ELsmp x86_64), and that the problem did NOT happen 
with a later kernel he had (which was the one he originally tried). See 
http://linux.kernel.org/pipermail/autofs/2007-October/004133.html.

So I think Jeff has confirmed the problem and resolution. Am I telling 
you something you already know?

Jeff said his successful test kernel has patches for bug 248126. Comment 
#24 in that bug says the patch was put in 2.6.9-55.0.7. So I'd expect 
the patch to be in 2.6.9-55.0.9 and for the problem to be fixed already. 
Since it isn't fixed, either the patch was pulled between .7 and .9, or 
the fix is more complicated than that single patch. Also, the bug 
comments refer to several different patch sets and other bugs, so it's 
not clear to me which patches Jeff actually has in his test kernel.

My group has various workarounds, so we're not dead in the water. We are 
also might move up to 5.x, but are waiting for a completely different 
fix as well (kernel.org bug #7768), which is not yet in the released 
upstream kernels.

Dan
