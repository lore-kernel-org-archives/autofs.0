From: Ian Kent <raven@themaw.net>
Subject: Re: ENOENT on first reference to an automounted file
Date: Fri, 19 Oct 2007 16:02:31 +0800
Message-ID: <1192780957.24353.10.camel@raven.themaw.net>
References: <D31A6D71-AB0C-45C0-A371-66AB549253BE@isolar.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <D31A6D71-AB0C-45C0-A371-66AB549253BE@isolar.dyndns.org>
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

On Thu, 2007-10-18 at 03:36 -0700, Greg Earle wrote:
> Dan, Ian, Jeff:
> 
> I work at a large U.S. Government Lab and after updating some of our
> Ops systems from RHEL 4 Update 4 to Update 5, all Hell broke loose
> as we have been plagued by this bug ever since - we are a Sun and
> Red Hat shop, and our software architecture is heavily dependent upon
> lots of automounts.  (I can very easily replicate it in our own
> environment with a simple test script that usually provokes the
> race condition in about 10-15 minutes, tops.)
> 
> I am getting the impression from the bug reports (and posts in
> this thread) that this bug is *not* fixed in 2.6.9-55.0.9; and might
> not be until some point in the future when 2.6.9-61 is available via
> "up2date".  Am I correct in that assumption?
> 
> If so, we may have little choice but to rollback to Update 4 by
> doing complete reinstalls from scratch (groan).  Is there any
> info on when this bug first crept in, and is Update 4 - with
> autofs-4.1.3-187 - safe to roll back to?  The natives are restless,
> and they've already shown up outside my office door with torches
> and pitchforks.  I've got a lot of unhappy Flight Projects reps
> on my hands.  We need to make a command decision here Real Soon Now.
> 
> Any illumination much appreciated.

Well, if we can't confirm the problem and resolution then I have no case
to put for an update.

No-one has volunteered to try the patches I referred to in this thread
and that's why I haven't posted them, so how about it, someone?

Ian
