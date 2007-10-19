From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: ENOENT on first reference to an automounted file
Date: Fri, 19 Oct 2007 11:22:30 -0400
Message-ID: <x49lk9zqgcp.fsf@segfault.boston.devel.redhat.com>
References: <D31A6D71-AB0C-45C0-A371-66AB549253BE@isolar.dyndns.org>
	<1192780957.24353.10.camel@raven.themaw.net>
	<4718AF15.3090204@everyzing.com>
	<1192804644.24353.32.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1192804644.24353.32.camel@raven.themaw.net> (Ian Kent's message
	of "Fri\, 19 Oct 2007 22\:37\:21 +0800")
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

Ian Kent <raven@themaw.net> writes:

> On Fri, 2007-10-19 at 09:20 -0400, Dan Halbert wrote:
>> Ian Kent wrote:
>> > 
>> > Well, if we can't confirm the problem and resolution then I have no case
>> > to put for an update.
>> > 
>> > No-one has volunteered to try the patches I referred to in this thread
>> > and that's why I haven't posted them, so how about it, someone?
>> 
>> Ian (& Greg & Jeff),
>> 
>> Maybe there's a bit of cross-purpose communication here. In an earlier 
>> message, Jeff said he had reproduced the problem by using exactly our 
>> kernel (2.6.9-55.0.9.ELsmp x86_64), and that the problem did NOT happen 
>> with a later kernel he had (which was the one he originally tried). See 
>> http://linux.kernel.org/pipermail/autofs/2007-October/004133.html.
>> 
>> So I think Jeff has confirmed the problem and resolution. Am I telling 
>> you something you already know?
>
> Well, to be honest, I had forgotten about that comment, but that's
> partly good. The curious thing is, of course, is hitting this problem is
> quite odd because it shouldn't be that prone to occur.

I verified that the latest release-candidate kernel for RHEL 4 U6
fixes the problem.

In the mean time, you can work around the bug by turning off ghosting.

Cheers,

Jeff
