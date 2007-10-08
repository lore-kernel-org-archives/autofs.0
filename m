From: Dan Halbert <halbert@everyzing.com>
Subject: Re: ENOENT on first reference to an automounted file
Date: Mon, 08 Oct 2007 14:00:57 -0400
Message-ID: <470A7059.8030106@everyzing.com>
References: <4706A926.8090503@everyzing.com>	<1191646125.3060.7.camel@raven.themaw.net>	<47081453.7000709@everyzing.com>	<x497ilxpo27.fsf@segfault.boston.devel.redhat.com>	<470A5C6B.9000104@everyzing.com>
	<x49tzp1o74r.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49tzp1o74r.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: ikent@redhat.com, autofs@kernel.org

Jeff Moyer wrote:
> I was able to reproduce it.  It turns out that I had a kernel
> installed that had a fix for the following bug:
>   Bugzilla Bug 248126: autofs problem with symbolic links
>
> When I moved to the exact kernel you were running, I hit the problem.
> So, it's a known issue, and it had better be addressed in the next
> update (kernel 2.6.9-61.EL).
>   
Thanks! You saved me from a module rebuild, which I have not done in 
quite a few years.

I had searched the existing bugs and seen 248126, but it did not seem to 
me that I could have had a simultaneous expire, since we have such long 
timeouts on the automounts (usually --timeout=86400). But I must have 
misunderstood what "expire" means in this case.

Also, from 248126 and the bug it references, 174821, it appeared  that 
these patches were already incorporated into my kernel 2.6.9-55.0.9-smp 
(248126 comment #24 mentions 55.0.7, for instance). But apparently not!

Is this bug non-existent in the latest updated RHEL5.0? I am trying to 
think of a workaround until 2.6.9-61 comes out. We have a tried cron job 
to provoke the automount more often than its timeout, but I am not sure 
that would solve the problem.

Dan
