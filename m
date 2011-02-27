From: Ian Kent <raven@themaw.net>
Subject: Re: Before I start carving wheels....
Date: Sun, 27 Feb 2011 12:28:05 +0800
Message-ID: <1298780885.3293.3.camel@perseus>
References: <mj849qulir49bmajiif61sp3.1298416168018@email.android.com>
	<alpine.LFD.1.10.1102222203150.7886@gardencity.blueskystudios.com>
	<x497hcqj0jg.fsf@segfault.boston.devel.redhat.com>
	<4D6521B0.2050608@blueskystudios.com>
	<1298517415.2916.27.camel@perseus>
	<alpine.LFD.1.10.1102232319330.12273@gardencity.blueskystudios.com>
	<1298529776.2916.96.camel@perseus> <1298544135.3058.63.camel@perseus>
	<alpine.LRH.2.00.1102251234570.14837@ionlinux.tower-research.com>
	<4D696187.4050004@blueskystudios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=wRQisCK7k6TOgv3vyY+CircnT1E=;
	b=akay8DVPaWR1GIHlgfEpQbDWbUEYfk80igPU8TT735eF7F+Xmab62G7oEyBwewIKpBdFdDX+0177ItuECrDGYqjr1V9UOHOYQLEyGJRhfMZY+p4X6nvtMSCEx835sPmuFxBi4LyfL85+Pz1Gf0O1Q1BWswos/wEp9kdJgGU5NHw=
In-Reply-To: <4D696187.4050004@blueskystudios.com>
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
To: Vincent Liggio <vince@blueskystudios.com>
Cc: Ion Badulescu <ionut@badula.org>, autofs@linux.kernel.org, Lee Damon <nomad@ee.washington.edu>, am-utils@fsl.cs.sunysb.edu

On Sat, 2011-02-26 at 15:24 -0500, Vincent Liggio wrote:
> Ok, that works. I will put a bug report into redhat so they hopefully 
> will integrate that into the latest code. Why they are releasing a -18 
> for F15 I don't get, when it doesn't even have any code changes.

You didn't look:
* Mon Feb 07 2011 Fedora Release Engineering
<rel-eng@lists.fedoraproject.org> - 5:6.1.5-18
- Rebuilt for https://fedoraproject.org/wiki/Fedora_15_Mass_Rebuild

Standard practice when branching a release, to ensure packages that may
not have been re-built don't have broken dependencies.

> 
> So to sum up, amd 6.1.5 patched as below works fine on F14 kernel's with 
> autofs4.
> 
> The amd redhat supplies does NOT work, in fact, it doesn't even load 
> properly with autofs enabled.

What are you saying?
If you add this patch to Fedora am-utils it then works?

If that's not the case then there is more work to do!

> 
> Vince
> 
> On 02/25/2011 12:39 PM, Ion Badulescu wrote:
> > On Thu, 24 Feb 2011, Ian Kent wrote:
> >
> >>>>> But the autofs4 module should be able to be used for autofs kernel
> >>>>> protocol version 3. It may require some changes in user space and,
> >>>>> since
> >>>>> the v3 protocol in autofs4 hasn't been tested for so long, there
> >>>>> may be
> >>>>> some other bugs that need fixing.
> >>>>
> >>>> Problem is that amd I believe specifically looks for autofs3 (even
> >>>> though
> >>>> the code says minimum autofs version 3, it fails to work with autofs4).
> >>>> And since no one is responding to the bug I put in about that, and the
> >>>> last time code was released for amd was in 2005, amd using autofs on
> >>>> the
> >>>> current F14 kernel seems to dead.
> >>>
> >>> I'll grab the amd source and have a quick look.
> >>> Where is the right place to get it?
> >>
> >> It looks like amd should work with autofs protocol version v4.
> >> You should also try "modprobe autofs4" before starting amd and see what
> >> happens.
> >
> > No, amd will happily work with either autofs3 or autofs4.
> >
> > The problem is that it (optimistically) tries to use the highest version
> > that the kernel supports, which is autofs5 these days. But it itself
> > doesn't have support for autofs5, so it fails miserably.
> >
> > The patch (copy/pasted so it might not apply cleanly) fixes autofs:
> >
> > commit 5cefcd3e1c7cb4943697e48996b8b1cbc7a9e7de
> > Author: Ion Badulescu <ionut@buggy.badula.org>
> > Date: Tue Nov 30 07:14:23 2010 -0500
> >
> > max supported autofs version is 4
> >
> > diff --git a/conf/autofs/autofs_linux.c b/conf/autofs/autofs_linux.c
> > index af61804..e901da7 100644
> > --- a/conf/autofs/autofs_linux.c
> > +++ b/conf/autofs/autofs_linux.c
> > @@ -59,7 +59,7 @@
> > */
> >
> > #define AUTOFS_MIN_VERSION 3
> > -#define AUTOFS_MAX_VERSION AUTOFS_MAX_PROTO_VERSION
> > +#define AUTOFS_MAX_VERSION 4
> >
> >
> > /*
> >
> >
> > -Ion
