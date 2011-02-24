From: Ian Kent <raven@themaw.net>
Subject: Re: Before I start carving wheels....
Date: Thu, 24 Feb 2011 14:42:56 +0800
Message-ID: <1298529776.2916.96.camel@perseus>
References: <mj849qulir49bmajiif61sp3.1298416168018@email.android.com>
	<alpine.LFD.1.10.1102222203150.7886@gardencity.blueskystudios.com>
	<x497hcqj0jg.fsf@segfault.boston.devel.redhat.com>
	<4D6521B0.2050608@blueskystudios.com>
	<1298517415.2916.27.camel@perseus>
	<alpine.LFD.1.10.1102232319330.12273@gardencity.blueskystudios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=onEFcnIiQ0HrDyhSvK3f4xcXKVw=;
	b=W9nwt/QoBiewXwNIozIbtQAY4Bti2lgeP+g09P5dkA/d/KXKNLnNMUjnI8+ulbpkygJzvkmv+Fd5WPPWyO1PIPFFvbdCkizqA/nByYdnUUmJEelgJHsRNnpVCvNe8DcLAD+ohhFDdbh66/DhM8l7/r72NZ2bLlpQIRJMZ4Y7kqc=
In-Reply-To: <alpine.LFD.1.10.1102232319330.12273@gardencity.blueskystudios.com>
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
Cc: autofs@linux.kernel.org, Lee Damon <nomad@ee.washington.edu>, am-utils@fsl.cs.sunysb.edu

On Wed, 2011-02-23 at 23:35 -0500, Vincent Liggio wrote:
> On Thu, 24 Feb 2011, Ian Kent wrote:
> 
> >> I reported on both kernel.org and on am-utils.org that autofs and amd do
> >> not work with F12's kernel in March/April of 2010 (kernel.org bug 15878
> >> and am-utils bug 639). No one has acknowledged or worked on the bug, as
> >> far as I can tell on the respective bugzillas.
> >
> > I don't remember seeing any mail on that bug even though I'm on the cc
> > list for it.
> >
> > In any case, it's asking for the autofs module to be built as default
> > which isn't likely to happen since, even at that time, the autofs module
> > was going to be removed from the kernel.
> 
> It (autofs3) still exists as an option in F14 (if we build our own 
> kernel), but doesn't seem to work either as a module or compiled into the 
> kernel (it did work in F12). If there were a way for amd to work with 
> autofs4, that'd be great, but it doesn't.
> 
> > But the autofs4 module should be able to be used for autofs kernel
> > protocol version 3. It may require some changes in user space and, since
> > the v3 protocol in autofs4 hasn't been tested for so long, there may be
> > some other bugs that need fixing.
> 
> Problem is that amd I believe specifically looks for autofs3 (even though 
> the code says minimum autofs version 3, it fails to work with autofs4). 
> And since no one is responding to the bug I put in about that, and the 
> last time code was released for amd was in 2005, amd using autofs on the 
> current F14 kernel seems to dead.

I'll grab the amd source and have a quick look.
Where is the right place to get it?

What exactly are the error messages you get when trying to use autofs4?
When you have tried this have you added an alias to the modprobe config
so that autofs4 will be loaded instead of autofs (although compiling in
autofs4 only, not autofs, should also work)?

Ian
