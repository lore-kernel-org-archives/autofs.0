From: Ian Kent <raven@themaw.net>
Subject: Re: statfs() and autofs
Date: Mon, 21 Jul 2008 15:35:35 +0800
Message-ID: <1216625736.3093.33.camel@raven.themaw.net>
References: <20080715204839.GU5858@pixar.com>
	<1216179794.22783.46.camel@raven.themaw.net>
	<487D855B.8000405@loran.name>
	<Pine.LNX.4.64.0807201441330.3491@simba.math.ucla.edu>
	<20080721034112.GU5858@pixar.com>
	<1216615194.3093.8.camel@raven.themaw.net>
	<488419CB.6090108@loran.name> <20080721055040.GX5858@pixar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080721055040.GX5858@pixar.com>
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
To: Chris Walker <cwalker@pixar.com>
Cc: autofs@linux.kernel.org


On Sun, 2008-07-20 at 22:50 -0700, Chris Walker wrote:
> From jonathan [07/20 22:08]:
> > P.S. Chris, can you reliably demonstrate the not waiting for the mount 
> > problem?
> 
> I can, but I'm a few revs back. I'll see if I can replicate on current
> revs of linux and autofs.

It should be reproducible on any version of autofs and any kernel, if I
understand correctly what is causing it. But, the real gotcha is stat(2)
or statfs(2) are often accompanied by other system calls that will wait
for the mount to complete. The mount can complete sometimes before but
also sometimes after, and possibly independent of system call order (due
to scheduling) so the problem should be intermittent and appear
unpredictable.

Ian
