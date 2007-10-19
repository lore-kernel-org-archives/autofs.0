From: Ian Kent <raven@themaw.net>
Subject: Re: ENOENT on first reference to an automounted file
Date: Sat, 20 Oct 2007 01:21:56 +0800
Message-ID: <1192814519.24353.56.camel@raven.themaw.net>
References: <D31A6D71-AB0C-45C0-A371-66AB549253BE@isolar.dyndns.org>
	<1192780957.24353.10.camel@raven.themaw.net>
	<4718AF15.3090204@everyzing.com>
	<1192804644.24353.32.camel@raven.themaw.net>
	<x49lk9zqgcp.fsf@segfault.boston.devel.redhat.com>
	<4718E3F6.4010606@everyzing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4718E3F6.4010606@everyzing.com>
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

On Fri, 2007-10-19 at 13:05 -0400, Dan Halbert wrote:
> Ian Kent wrote:
> 
>  >Well, to be honest, I had forgotten about that comment, but that's
>  >partly good. The curious thing is, of course, is hitting this problem
>  >is quite odd because it shouldn't be that prone to occur.
> 
> I think the original diagnosis of an umount/mount race is only one 
> possible way to hit the bug. We use very long timeouts and would never 
> have hit that particular race. Since we see it with LDAP but not with a 
> local map, I wonder if it is due to some slight additional delay caused 
> by the LDAP lookup.

We understand what is happening now.

Jeff worked it out.

It is to do with the use of a wildcard entry and interaction of the
daemon with the autofs internal cache and the directory create/remove
done by the daemon. This also explains why the kernel patch prevents the
problem from happening.

> 
>  >To this end I've built a RHEL4 kernel with all the patches that
>  >"should" be included. If your interested in testing it we just need to
>  >find a way to get it to you.
> 
> Jeff Moyer wrote:
> > I verified that the latest release-candidate kernel for RHEL 4 U6
> > fixes the problem.
> > 
> > In the mean time, you can work around the bug by turning off ghosting.
> 
> Ian, should I try your test kernel, or is it moot now, given what Jeff 
> says? I can privately give you an FTP location if you would still like 
> it tested.

We probably still have to make our case for getting this into the
revision 55 series kernel I think, given that the patches have been
reverted. Your not the only one seeing this and I expect not everyone
will be able or comfortable upgrading to a later revision kernel so
perhaps we should.

It's pretty much up to you as anyone who can't go to the U6 kernel and
needs this will have to test it for themselves anyway.

I have the build now anyway.

Ian
