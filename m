From: "James Richardson" <jrichardson@x-iss.com>
Subject: Re: Slow mounts when using large round robin sets
Date: Thu, 20 Dec 2007 16:42:48 -0600
Message-ID: <98E55D6E1B3CFD43BDA59EEB56DD7D7244386E@sbs01.xiss.private>
References: <98E55D6E1B3CFD43BDA59EEB56DD7D72442DF1@sbs01.xiss.private><98E55D6E1B3CFD43BDA59EEB56DD7D724431C0@sbs01.xiss.private><1196921804.3089.28.camel@raven.themaw.net><98E55D6E1B3CFD43BDA59EEB56DD7D724432D5@sbs01.xiss.private>
	<x49zlwm5hf1.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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
Cc: autofs@linux.kernel.org

Jeff,

I downloaded the sources via git
(git://git.kernel.org/pub/scm/linux/storage/autofs/autofs.git) however
when automount starts up I get a floating point exception. I would
appreciate those debug patches you mentioned as I'm not sure where the
floating point exception is occurring.

# strace automount -d
execve("/usr/sbin/automount", ["automount", "-d"], [/* 24 vars */]) = 0
uname({sys="Linux", node="c33n69", ...}) = 0
brk(0)                                  = 0x80041000
--- SIGFPE (Floating point exception) @ 0 (0) ---
+++ killed by SIGFPE +++
Process 3702 detached
[root@c33n69 ~]# uname -a
Linux c33n69 2.6.21-GX #1 SMP Thu Apr 26 14:03:16 CDT 2007 i686 i686
i386 GNU/Linux

---
James T. Richardson, Jr.
jrichardson@x-iss.com
eXcellence in IS Solutions, Inc.
713-862-9200 x226

Making IT Work for You
HPC & Enterprise IT Solutions
* HPC Application Acceleration
* Cluster Design, Deploy, Manage, Train
* Linux/Windows Integration
* Remote Management, Backup, Anti-Spam/Virus
* Network Assessments, Design
* Security Audits, Design
* Datacenter Design, Relocation
* Messaging and Collaboration


-----Original Message-----
From: Jeff Moyer [mailto:jmoyer@redhat.com] 
Sent: Friday, December 07, 2007 3:22 PM
To: James Richardson
Cc: Ian Kent; autofs@linux.kernel.org
Subject: Re: [autofs] Slow mounts when using large round robin sets

"James Richardson" <jrichardson@x-iss.com> writes:

> Ian,
>
> Thanks for the strace tips. By performing an strace on the 4th thread
I do see several 'poll' calls:
>
> [pid  3858] 11:38:47.332883 poll([{fd=4, events=POLLIN,
revents=POLLIN}], 1, 3000) = 1
> [pid  3858] 11:38:47.335494 poll([{fd=40, events=POLLOUT,
revents=POLLOUT}], 1, 0) = 1
> [pid  3858] 11:38:47.335704 poll([{fd=40, events=POLLIN,
revents=POLLIN}], 1, 5000) = 1
> [pid  3858] 11:38:47.339133 poll([{fd=40, events=POLLIN,
revents=POLLIN}], 1, 5000) = 1
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

NOTICE:
This message may contain privileged or otherwise confidential information.
If you are not the intended recipient, please immediately advise the sender
by reply email and delete the message and any attachments without using,
copying or disclosing the contents.
