From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: 'browse mode' issue
Date: Mon, 22 Sep 2008 13:11:34 -0400
Message-ID: <x49prmwjebd.fsf@segfault.boston.devel.redhat.com>
References: <48D7BF38.5020709@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <48D7BF38.5020709@inria.fr> (Guillaume Rousse's message of "Mon, 
	22 Sep 2008 17:52:24 +0200")
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
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs@linux.kernel.org

Guillaume Rousse <Guillaume.Rousse@inria.fr> writes:

> Hello list. I've several questions about browse mode option.
>
> First, I have opposite reports about the effects of 'browse mode' option 
> in automount configuration. Some times ago, a user reported than setting 
> it to 'no' was CPU-unfriendly, so we turned it to 'yes' by default in 

That's the first time I've ever heard that!  What data did your user use
to support that conclusion?

> However, I now have another report than allowing browse was harmful on 
> large networks, causing lots of IP collisions.

My knowledge in this area is dated, sadly.  I'll let Ian address the
specific implementation details.

> So, I'm curious at what should be a good default value for this option.
>
> Second, having a look at the code, it seems 'yes' is the default in the 
> binary, but, but default configuration file set it to 'no', which is 
> quite disturbing. If there is a good default value for this option (and 
> even if there was not), I'd rather have consistent default values in 
> both places.

Well, for RHEL at least, we wanted to make things continue to work as
they did before.  That means configuring autofs to default to nobrowse.
I'm not sure why the daemon defaults to browsing.

> Last issue, I can't find a correct description on what this option does 
> exactly anywhere :)

http://docs.sun.com/app/docs/doc/816-0211/6m6nc66nc?a=view

Scroll down to the section entitled, "Browsing."

Cheers,

Jeff
