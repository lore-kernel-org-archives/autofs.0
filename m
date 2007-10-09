From: Ian Kent <raven@themaw.net>
Subject: Re: Fedora kernel question (was Re: ENOENT on
	first	reference to an automounted file)
Date: Tue, 09 Oct 2007 11:16:10 +0800
Message-ID: <1191899770.3077.12.camel@raven.themaw.net>
References: <4706A926.8090503@everyzing.com>
	<1191646125.3060.7.camel@raven.themaw.net>	<47081453.7000709@everyzing.com>
	<x497ilxpo27.fsf@segfault.boston.devel.redhat.com>
	<470A5C6B.9000104@everyzing.com>
	<x49tzp1o74r.fsf@segfault.boston.devel.redhat.com>
	<470A6FB7.2050802@phy.duke.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <470A6FB7.2050802@phy.duke.edu>
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
To: Jimmy Dorff <jdorff@phy.duke.edu>
Cc: autofs@kernel.org

On Mon, 2007-10-08 at 13:58 -0400, Jimmy Dorff wrote:
> Jeff Moyer wrote:
> > I was able to reproduce it.  It turns out that I had a kernel
> > installed that had a fix for the following bug:
> >   Bugzilla Bug 248126: autofs problem with symbolic links
> > 
> > When I moved to the exact kernel you were running, I hit the problem.
> > So, it's a known issue, and it had better be addressed in the next
> > update (kernel 2.6.9-61.EL).
> > 
> 
> Would you have any info on the status of these fixes into Fedora kernels 
> ?  Everything I read in bugzilla seems specific to RHEL.

I think it was 2.6.21 that got the patch discussed here.
The corrections I mentioned are included in another patch that is in
2.6.23, so obviously not in a Fedora release kernel.

Ian
