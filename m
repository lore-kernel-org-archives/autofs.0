From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: ENOENT on first reference to an automounted file
Date: Mon, 08 Oct 2007 13:20:36 -0400
Message-ID: <x49tzp1o74r.fsf@segfault.boston.devel.redhat.com>
References: <4706A926.8090503@everyzing.com>
	<1191646125.3060.7.camel@raven.themaw.net>
	<47081453.7000709@everyzing.com>
	<x497ilxpo27.fsf@segfault.boston.devel.redhat.com>
	<470A5C6B.9000104@everyzing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <470A5C6B.9000104@everyzing.com> (Dan Halbert's message of "Mon\,
	08 Oct 2007 12\:35\:55 -0400")
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
Cc: ikent@redhat.com, autofs@kernel.org

Dan Halbert <halbert@everyzing.com> writes:

> Jeff Moyer wrote:
>> I can't reproduce the problem.  Would you be willing to enable
>> debugging in the kernel module.
>>   
> Sure, happy to do this, though you'll need to tell me how to turn that 
> on. I'm testing on a machine I have complete control over.

I was able to reproduce it.  It turns out that I had a kernel
installed that had a fix for the following bug:
  Bugzilla Bug 248126: autofs problem with symbolic links

When I moved to the exact kernel you were running, I hit the problem.
So, it's a known issue, and it had better be addressed in the next
update (kernel 2.6.9-61.EL).

Cheers,

Jeff
