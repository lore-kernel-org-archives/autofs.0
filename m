From: Ian Kent <raven@themaw.net>
Subject: Re: Before I start carving wheels....
Date: Sun, 27 Feb 2011 14:13:04 +0800
Message-ID: <1298787184.3293.20.camel@perseus>
References: <mj849qulir49bmajiif61sp3.1298416168018@email.android.com>
	<alpine.LFD.1.10.1102222203150.7886@gardencity.blueskystudios.com>
	<x497hcqj0jg.fsf@segfault.boston.devel.redhat.com>
	<4D6521B0.2050608@blueskystudios.com>
	<1298517415.2916.27.camel@perseus>
	<alpine.LFD.1.10.1102232319330.12273@gardencity.blueskystudios.com>
	<1298529776.2916.96.camel@perseus> <1298544135.3058.63.camel@perseus>
	<alpine.LRH.2.00.1102251234570.14837@ionlinux.tower-research.com>
	<4D696187.4050004@blueskystudios.com> <1298780885.3293.3.camel@perseus>
	<alpine.LFD.1.10.1102262335210.21420@gardencity.blueskystudios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=n2YmUZVWp3CCHTXw7KV84EEn0q0=;
	b=PrvMgKeoDq7+j5zY7UpBn4cmmohHkAc7VJlN/ykMM75E2RQe/3T8MQGsUOhUE4GX+QKi9kB9xk5awvPdPz0HpG7Dv1N/ACnQeXg33IFVjD2iLHShSWJeUvgn2E0TDJ/tsVFOFt3WQw42vIWRYJ7pyQwSPEJrKMMo+j4XZ8kHYq4=
In-Reply-To: <alpine.LFD.1.10.1102262335210.21420@gardencity.blueskystudios.com>
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

On Sun, 2011-02-27 at 00:01 -0500, Vincent Liggio wrote:
> On Sun, 27 Feb 2011, Ian Kent wrote:
> 
> > What are you saying?
> > If you add this patch to Fedora am-utils it then works?
> 
> Yes. I downloaded the F14 SRPM for am-utils, changed that one line, did 
> an rpmbuild, and it works with the default F14 kernel.

Great, then hopefully Karl will just add the patch and we'll be good.

> 
> The F14 supplied amd from am-utils-6.1.5-17 does NOT work at all with 
> autofs - we compiled a kernel with autofs3 enabled, amd would not load. We 
> tried our F12 kernel (which we compiled with autofs3 enabled and which 
> worked on our F12 machines), along with the amd from F14 and amd wouldn't 
> load. We copied over the F12 amd binaries, and the F12 amd loaded fine 
> with both of our F14 and F12 kernels that we modified for autofs3.
> 

To be honest I don't think trying to work out what VFS change broke this
is worth while (if in fact it was a VFS change, there have been a few
prior to 2.6.38). The fact is that autofs has been removed from 2.6.38
and we need to spend our time making sure the autofs4 module works with
products that use autofs the kernel communication protocols.

The final change needed is for autofs4 to be renamed to autofs to
finally remove that fork in development. I'm looking forward to the
breakage that will cause, ;)

Ian
