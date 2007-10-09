From: Ian Kent <ikent@redhat.com>
Subject: Re: ENOENT on first reference to an automounted file
Date: Tue, 09 Oct 2007 11:11:43 +0800
Message-ID: <1191899503.3077.8.camel@raven.themaw.net>
References: <4706A926.8090503@everyzing.com>
	<1191646125.3060.7.camel@raven.themaw.net>	<47081453.7000709@everyzing.com>
	<x497ilxpo27.fsf@segfault.boston.devel.redhat.com>
	<470A5C6B.9000104@everyzing.com>
	<x49tzp1o74r.fsf@segfault.boston.devel.redhat.com>
	<470A7059.8030106@everyzing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <470A7059.8030106@everyzing.com>
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
To: Dan Halbert <halbert@everyzing.com>
Cc: autofs@kernel.org

On Mon, 2007-10-08 at 14:00 -0400, Dan Halbert wrote:
> Jeff Moyer wrote:
> > I was able to reproduce it.  It turns out that I had a kernel
> > installed that had a fix for the following bug:
> >   Bugzilla Bug 248126: autofs problem with symbolic links
> >
> > When I moved to the exact kernel you were running, I hit the problem.
> > So, it's a known issue, and it had better be addressed in the next
> > update (kernel 2.6.9-61.EL).
> >   
> Thanks! You saved me from a module rebuild, which I have not done in 
> quite a few years.
> 
> I had searched the existing bugs and seen 248126, but it did not seem to 
> me that I could have had a simultaneous expire, since we have such long 
> timeouts on the automounts (usually --timeout=86400). But I must have 
> misunderstood what "expire" means in this case.

Yes, that's a bit puzzling.

> 
> Also, from 248126 and the bug it references, 174821, it appeared  that 
> these patches were already incorporated into my kernel 2.6.9-55.0.9-smp 
> (248126 comment #24 mentions 55.0.7, for instance). But apparently not!

The patch was reverted in this revision. I'm not sure why.

> 
> Is this bug non-existent in the latest updated RHEL5.0? I am trying to 
> think of a workaround until 2.6.9-61 comes out. We have a tried cron job 
> to provoke the automount more often than its timeout, but I am not sure 
> that would solve the problem.

I'd need to check but I believe the patch is present in the RHEL5 kernel
(but I think there are a couple of corrections missing).

You could apply the patch(es) yourself.

Ian
