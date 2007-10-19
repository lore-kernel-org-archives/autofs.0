From: Dan Halbert <halbert@everyzing.com>
Subject: Re: ENOENT on first reference to an automounted file
Date: Fri, 19 Oct 2007 13:05:58 -0400
Message-ID: <4718E3F6.4010606@everyzing.com>
References: <D31A6D71-AB0C-45C0-A371-66AB549253BE@isolar.dyndns.org>	<1192780957.24353.10.camel@raven.themaw.net>	<4718AF15.3090204@everyzing.com>	<1192804644.24353.32.camel@raven.themaw.net>
	<x49lk9zqgcp.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49lk9zqgcp.fsf@segfault.boston.devel.redhat.com>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@kernel.org

Ian Kent wrote:

 >Well, to be honest, I had forgotten about that comment, but that's
 >partly good. The curious thing is, of course, is hitting this problem
 >is quite odd because it shouldn't be that prone to occur.

I think the original diagnosis of an umount/mount race is only one 
possible way to hit the bug. We use very long timeouts and would never 
have hit that particular race. Since we see it with LDAP but not with a 
local map, I wonder if it is due to some slight additional delay caused 
by the LDAP lookup.

 >To this end I've built a RHEL4 kernel with all the patches that
 >"should" be included. If your interested in testing it we just need to
 >find a way to get it to you.

Jeff Moyer wrote:
> I verified that the latest release-candidate kernel for RHEL 4 U6
> fixes the problem.
> 
> In the mean time, you can work around the bug by turning off ghosting.

Ian, should I try your test kernel, or is it moot now, given what Jeff 
says? I can privately give you an FTP location if you would still like 
it tested.

Dan
