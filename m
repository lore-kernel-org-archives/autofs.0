From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Slow mounts when using large round robin sets
Date: Fri, 07 Dec 2007 16:22:26 -0500
Message-ID: <x49zlwm5hf1.fsf@segfault.boston.devel.redhat.com>
References: <98E55D6E1B3CFD43BDA59EEB56DD7D72442DF1@sbs01.xiss.private>
	<98E55D6E1B3CFD43BDA59EEB56DD7D724431C0@sbs01.xiss.private>
	<1196921804.3089.28.camel@raven.themaw.net>
	<98E55D6E1B3CFD43BDA59EEB56DD7D724432D5@sbs01.xiss.private>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <98E55D6E1B3CFD43BDA59EEB56DD7D724432D5@sbs01.xiss.private>
	(James Richardson's message of "Fri\,
	7 Dec 2007 13\:33\:25 -0600")
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
To: James Richardson <jrichardson@x-iss.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

"James Richardson" <jrichardson@x-iss.com> writes:

> Ian,
>
> Thanks for the strace tips. By performing an strace on the 4th thread I do see several 'poll' calls:
>
> [pid  3858] 11:38:47.332883 poll([{fd=4, events=POLLIN, revents=POLLIN}], 1, 3000) = 1
> [pid  3858] 11:38:47.335494 poll([{fd=40, events=POLLOUT, revents=POLLOUT}], 1, 0) = 1
> [pid  3858] 11:38:47.335704 poll([{fd=40, events=POLLIN, revents=POLLIN}], 1, 5000) = 1
> [pid  3858] 11:38:47.339133 poll([{fd=40, events=POLLIN, revents=POLLIN}], 1, 5000) = 1
>
>
> I did not see any of the "restart_syscall".
>
> One interesting fact is that it opened /etc/hosts 290 times:
> 	[pid  3858] 11:38:45.008533 open("/etc/hosts", O_RDONLY) = 4
> 	
> 	# cat autofs.debug.out | grep "/etc/hosts" | wc
> 	290    2030   17882
>
> I have determined that this issue started occurring since we
> upgraded to kernel 2.6.21 and autofs5. Using the stock CentOS 4.2
> kernel (2.6.9-22.EL) and autofs-4.1.3-155 this behavior is not
> exhibited.

That's a pretty big difference in code!

Are you comfortable using git and make?  If so, you might try
building and testing the latest git sources.  The reason I say this is
there is a fix in there that avoids calling into the replicated server
code for singleton entries, and that code is the only place I believe
the resolver is consulted.

If that fixes your problem, then I'd be very interested to figure out
exactly why.  I can give you some debug patches if necessary.

Thanks,

Jeff
