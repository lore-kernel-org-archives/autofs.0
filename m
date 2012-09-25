From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 0/2] struct pid-ify autofs4
Date: Mon, 24 Sep 2012 19:56:46 -0700
Message-ID: <87mx0estch.fsf@xmission.com>
References: <1348068576-21363-1-git-send-email-miklos@szeredi.hu>
	<87haqrwfbj.fsf@tucsk.pomaz.szeredi.hu>
	<1348447130.2318.1.camel@perseus.themaw.net>
	<87d31bczo7.fsf@tucsk.pomaz.szeredi.hu>
	<1348537604.2307.8.camel@perseus.themaw.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1348537604.2307.8.camel@perseus.themaw.net> (Ian Kent's message
	of "Tue, 25 Sep 2012 09:46:44 +0800")
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Miklos Szeredi <miklos@szeredi.hu>, autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, sukadev@linux.vnet.ibm.com, serge.hallyn@canonical.com

Ian Kent <raven@themaw.net> writes:

> On Mon, 2012-09-24 at 15:34 +0200, Miklos Szeredi wrote:
>> Ian Kent <raven@themaw.net> writes:
>> 
>> > On Fri, 2012-09-21 at 17:44 +0200, Miklos Szeredi wrote:
>> >> Miklos Szeredi <miklos@szeredi.hu> writes:
>> >> 
>> >> > These two patches change autofs4 to store struct pid pointers instead of pid_t
>> >> > values.
>> >> >
>> >> > Fixed various issues with the previous post.  Not tested, handle with
>> >> > care!
>> >> 
>> >> Customer gave positive test results.
>> >
>> > For what exactly, there's no problem description in these patches?
>> 
>> From what I understand (and I'm not an expert by any means) is that
>> autofs doesn't work if containers are used.  The first patch fixes this.
>
> Yeah, the problem with that is that "autofs doesn't work if containers
> are used" is ill defined since there are use cases where it does, I
> believe. At the very least, ill defined in my view of things.

An easy complaint is that task->pid and task->tgid are deprecated fields
in the task structure.  Things that use pids should in use struct pid
values instead.

The trick part of using struct pid values is that there are times when
you need to interact with userspace.  And the question is which pid
namespace is your userspace process in so that you can convert
to and from the proper pid namespace.

The pgrp option on the mount of autofs is buggy because the pid
namespace of the process group is not captured at the time of mount
and so userspace could think it is talking about one process group
while autofs is talking about another process group.  This is a
practical problem if the process that mounts autofs is not running
in the initial pid namespace.

There is a second question.  What happens if the oz_pgrp exists
and then pids wrap around and another process uses the same process
group number.  Currently the autofs code will treat the new proces
group like the old one leading to unexpected behavior.  Which I believe
will be autofs mounts not happening when desired.

Another problem is what happens when a process triggers an automount.
Today we will report the pid and the tgid in the initial pid namespace
of the process that triggered the mount.

So what I can see is that today if the process that mounts autofs
(aka the process at the other end of the autofs pipe) is not in
the initial pid namespace things will go awry, as autofs will report
pid values that make no sense to anyone.

I would like to say the patches fix that problem (and they come close)
however they still translate everything into the initial pid namespace.

> But I can't even sensibly discuss it because of the lack of specified
> use cases and requirements for each. So, there's a chance this will
> break another case that does work.

That seems to be a reasonable concern.  Education so that the
differences in the code are comprehensible.

I am also curious about which case people were seeing problems with as
these patches were reported to be tested and to have fixed a customer
problem.  The only case that is particularly clear to me that these
patches will fix is the case of process group wrap around, but proces
group wrap around should be exceedingly rare.

To handle mounts made outside of the initial pid namespace it appears
that all that is needed is to caputure the pid namespace of the process
that mounts autofs and uses pid_nr_ns to format pids into that
namespace, inside of autofs

It is my feeling that in addition to capture oz_pgrp on mount the
automount and autofs_dev_ioctl_set_pipefd should capture a pid namespace
for formating pids delivered into the pipe.  That would allow the
automount process itself to live outside of the initial pid namespace.

Eric
