From: Vincent Liggio <vince@blueskystudios.com>
Subject: Re: Before I start carving wheels....
Date: Sun, 27 Feb 2011 00:01:01 -0500 (EST)
Message-ID: <alpine.LFD.1.10.1102262335210.21420@gardencity.blueskystudios.com>
References: <mj849qulir49bmajiif61sp3.1298416168018@email.android.com>
	<alpine.LFD.1.10.1102222203150.7886@gardencity.blueskystudios.com>
	<x497hcqj0jg.fsf@segfault.boston.devel.redhat.com>
	<4D6521B0.2050608@blueskystudios.com>
	<1298517415.2916.27.camel@perseus>
	<alpine.LFD.1.10.1102232319330.12273@gardencity.blueskystudios.com>
	<1298529776.2916.96.camel@perseus>
	<1298544135.3058.63.camel@perseus>
	<alpine.LRH.2.00.1102251234570.14837@ionlinux.tower-research.com>
	<4D696187.4050004@blueskystudios.com>
	<1298780885.3293.3.camel@perseus>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1298780885.3293.3.camel@perseus>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: Ion Badulescu <ionut@badula.org>, autofs@linux.kernel.org, Lee Damon <nomad@ee.washington.edu>, am-utils@fsl.cs.sunysb.edu

On Sun, 27 Feb 2011, Ian Kent wrote:

> You didn't look:
> * Mon Feb 07 2011 Fedora Release Engineering
> <rel-eng@lists.fedoraproject.org> - 5:6.1.5-18
> - Rebuilt for https://fedoraproject.org/wiki/Fedora_15_Mass_Rebuild
>
> Standard practice when branching a release, to ensure packages that may
> not have been re-built don't have broken dependencies.

I did look and saw that. I guess I always considered those as code version 
numbers, not compilation version numbers, my bad. Good to know.

> What are you saying?
> If you add this patch to Fedora am-utils it then works?

Yes. I downloaded the F14 SRPM for am-utils, changed that one line, did 
an rpmbuild, and it works with the default F14 kernel.

The F14 supplied amd from am-utils-6.1.5-17 does NOT work at all with 
autofs - we compiled a kernel with autofs3 enabled, amd would not load. We 
tried our F12 kernel (which we compiled with autofs3 enabled and which 
worked on our F12 machines), along with the amd from F14 and amd wouldn't 
load. We copied over the F12 amd binaries, and the F12 amd loaded fine 
with both of our F14 and F12 kernels that we modified for autofs3.
