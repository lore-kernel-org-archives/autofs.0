From: Ian Kent <raven@themaw.net>
Subject: Re: Before I start carving wheels....
Date: Sat, 26 Feb 2011 10:28:25 +0800
Message-ID: <1298687305.15220.9.camel@perseus>
References: <mj849qulir49bmajiif61sp3.1298416168018@email.android.com>
	<alpine.LFD.1.10.1102222203150.7886@gardencity.blueskystudios.com>
	<x497hcqj0jg.fsf@segfault.boston.devel.redhat.com>
	<4D6521B0.2050608@blueskystudios.com>
	<1298517415.2916.27.camel@perseus>
	<alpine.LFD.1.10.1102232319330.12273@gardencity.blueskystudios.com>
	<1298529776.2916.96.camel@perseus> <1298544135.3058.63.camel@perseus>
	<alpine.LRH.2.00.1102251234570.14837@ionlinux.tower-research.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=hZVVCeWor1Ayb2Z9UhZS74Y1IQ4=;
	b=SzOOCndYwYY363zqpsxrLDWoLwyXV+qhTwKZqGaoFxoL07y6QjZ2xOcaq9o/lzplVXl+ccWf3JWuLgrQ4i/B+OV+c06Kp3V+Riq4QpW799hmificWR4fc2kjE0yJqrNZMCFetRM4KLfbD1rfPFpROqW/48X9JbFfQfXF4pwa/c4=
In-Reply-To: <alpine.LRH.2.00.1102251234570.14837@ionlinux.tower-research.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ion Badulescu <ionut@badula.org>
Cc: Vincent Liggio <vince@blueskystudios.com>, autofs@linux.kernel.org, Lee Damon <nomad@ee.washington.edu>, am-utils@fsl.cs.sunysb.edu

On Fri, 2011-02-25 at 12:39 -0500, Ion Badulescu wrote:
> On Thu, 24 Feb 2011, Ian Kent wrote:
> 
> >>>> But the autofs4 module should be able to be used for autofs kernel
> >>>> protocol version 3. It may require some changes in user space and, since
> >>>> the v3 protocol in autofs4 hasn't been tested for so long, there may be
> >>>> some other bugs that need fixing.
> >>>
> >>> Problem is that amd I believe specifically looks for autofs3 (even though
> >>> the code says minimum autofs version 3, it fails to work with autofs4).
> >>> And since no one is responding to the bug I put in about that, and the
> >>> last time code was released for amd was in 2005, amd using autofs on the
> >>> current F14 kernel seems to dead.
> >>
> >> I'll grab the amd source and have a quick look.
> >> Where is the right place to get it?
> >
> > It looks like amd should work with autofs protocol version v4.
> > You should also try "modprobe autofs4" before starting amd and see what
> > happens.
> 
> No, amd will happily work with either autofs3 or autofs4.

My point above was that, in the past we've seen the wrong module loaded
or no module loaded because of name match failure. Pre-loading the
module uncovers those sorts of difficulties.

> 
> The problem is that it (optimistically) tries to use the highest version 
> that the kernel supports, which is autofs5 these days. But it itself 
> doesn't have support for autofs5, so it fails miserably.
> 
> The patch (copy/pasted so it might not apply cleanly) fixes autofs:
> 
> commit 5cefcd3e1c7cb4943697e48996b8b1cbc7a9e7de
> Author: Ion Badulescu <ionut@buggy.badula.org>
> Date:   Tue Nov 30 07:14:23 2010 -0500
> 
>      max supported autofs version is 4
> 
> diff --git a/conf/autofs/autofs_linux.c b/conf/autofs/autofs_linux.c
> index af61804..e901da7 100644
> --- a/conf/autofs/autofs_linux.c
> +++ b/conf/autofs/autofs_linux.c
> @@ -59,7 +59,7 @@
>    */
> 
>   #define AUTOFS_MIN_VERSION 3
> -#define AUTOFS_MAX_VERSION AUTOFS_MAX_PROTO_VERSION
> +#define AUTOFS_MAX_VERSION 4
> 
> 
>   /*
> 
> 
> -Ion
