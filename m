From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: ENOENT on first reference to an automounted file
Date: Mon, 08 Oct 2007 12:29:36 -0400
Message-ID: <x497ilxpo27.fsf@segfault.boston.devel.redhat.com>
References: <4706A926.8090503@everyzing.com>
	<1191646125.3060.7.camel@raven.themaw.net>
	<47081453.7000709@everyzing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <47081453.7000709@everyzing.com> (Dan Halbert's message of "Sat\,
	06 Oct 2007 19\:03\:47 -0400")
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

Dan Halbert <halbert@everyzing.com> writes:

> Ian Kent wrote:
>  > On Fri, 2007-10-05 at 17:14 -0400, Dan Halbert wrote:
>  >> I have what looks like an automount race condition, and am very puzzled...
>  >>
>  >> The first time I reference an automounted file, it is not there
>  >> (ENOENT). On the second and later try, the file is there...
>  >
>  > We really must have a debug log, include everything and give some
>  > indication of when the problem occurred....
>
> Details you requested follow.

> 	autofs-4.1.3-199.3
> (I also reproduced the problem with autofs-4.1.3-214, the latest version
>   at jmoyer's webpage.)

> kernel:
> 	2.6.9-55.0.9.ELsmp x86_64

I can't reproduce the problem.  Would you be willing to enable
debugging in the kernel module.  This will generate oodles of output.
Alternatively, I could try to come up with some pointed kprobes to get
the information we most likely need.  The first option will definitely
be quicker.

Cheers,

Jeff
