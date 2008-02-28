From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 3/4] autofs4 - track uid and gid of last mount requestor
Date: Thu, 28 Feb 2008 13:33:07 -0700
Message-ID: <m1oda04y9o.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.64.0802261151400.8490@raven.themaw.net>
	<Pine.LNX.4.64.0802261208400.8490@raven.themaw.net>
	<20080227204546.72e16e8d.akpm@linux-foundation.org>
	<1204179747.3501.21.camel@raven.themaw.net>
	<20080227223734.caab0165.akpm@linux-foundation.org>
	<1204182500.3501.49.camel@raven.themaw.net>
	<47C667EC.6060700@openvz.org>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <47C667EC.6060700@openvz.org> (Pavel Emelyanov's message of "Thu,
	28 Feb 2008 10:51:08 +0300")
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Emelyanov <xemul@openvz.org>
Cc: Ian Kent <raven@themaw.net>, Andrew Morton <akpm@linux-foundation.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

Pavel Emelyanov <xemul@openvz.org> writes:

> Why do we need the uid then? Is just pid not enough to uniquely 
> identify a task?
>
> Assuming we can get by with a pid only, this problem can be solved
> by sending a pid_nr() of a task, i.e. the pid by which this task is
> seen from an initial namespace. This pid is unique across the system
> even when pid namespaces are created.

Pavel it is never correct to use a global pid when talking to user space.
In fact the concept is just a bit dubious.  We must always translate
the pid into the pid namespace of the task we are talking to, or at
least into the pid namespace of the process that opened the file
handle, (essentially the same, but does not have races in the corner
cases).

Even in the kernel using global ids is dubious.  When dealing with
user space it is just wrong.  

Speaking of.  I think we still need work on autofs in this regard.
I know last I looked we had some outstanding issues there.

Eric
