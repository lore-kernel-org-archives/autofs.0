From: Chris Walker <cwalker@pixar.com>
Subject: Re: statfs() and autofs
Date: Tue, 22 Jul 2008 09:39:00 -0700
Message-ID: <20080722163900.GB6362@pixar.com>
References: <20080715204839.GU5858@pixar.com>
	<1216179794.22783.46.camel@raven.themaw.net>
	<487D855B.8000405@loran.name>
	<Pine.LNX.4.64.0807201441330.3491@simba.math.ucla.edu>
	<20080721034112.GU5858@pixar.com>
	<1216615194.3093.8.camel@raven.themaw.net>
	<488419CB.6090108@loran.name> <20080721055040.GX5858@pixar.com>
	<1216625736.3093.33.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <1216625736.3093.33.camel@raven.themaw.net>
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

From raven [07/21 00:39]:
> 
> On Sun, 2008-07-20 at 22:50 -0700, Chris Walker wrote:
> > From jonathan [07/20 22:08]:
> > > P.S. Chris, can you reliably demonstrate the not waiting for the mount 
> > > problem?
> > 
> > I can, but I'm a few revs back. I'll see if I can replicate on current
> > revs of linux and autofs.
> 
> It should be reproducible on any version of autofs and any kernel, if I
> understand correctly what is causing it. But, the real gotcha is stat(2)
> or statfs(2) are often accompanied by other system calls that will wait
> for the mount to complete. The mount can complete sometimes before but
> also sometimes after, and possibly independent of system call order (due
> to scheduling) so the problem should be intermittent and appear
> unpredictable.

I cannot reproduce this on fedora 9 (kernel: 2.6.25.6, autofs: autofs-5.0.3).
Maybe I'll do some git bisecting to see where it got fixed.

-- 
Chris Walker -- cwalker@pixar.com
