From: David Miller <davem@davemloft.net>
Subject: Re: compat: autofs v5 packet size ambiguity - update
Date: Tue, 21 Feb 2012 22:16:09 -0500 (EST)
Message-ID: <20120221.221609.218135609185671883.davem@davemloft.net>
References: <CA+55aFzhS69QSoN1j+Z2md116u+3OfniAoE0QMo6xyBjDyjbEw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFzhS69QSoN1j+Z2md116u+3OfniAoE0QMo6xyBjDyjbEw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, autofs@linux.kernel.org, thomas@m3y3r.de, viro@zeniv.linux.org.uk

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 Feb 2012 18:24:10 -0800

> No, the problem is that "is_compat_task()" is not the right check.
> It's not the task that *waits* for autofs that matters, it's that damn
> autofs daemon task.
> 
> IOW, what we actually want to test is whether the other end of that
> autofs sbi->pipe is a compat task or not.
> 
> And I have no idea how to do that.

It's just a real fd, and there is no way to tell the compat'ness for
that.  The mount operation literally passes in an integer attribute as
the pipefd mount option, and that's what it seems to use to send these
events.

And that fd can be dup()'d, exec()'d into compat and non-compat tasks,
passed around as SCM credentials between arbitrary processes, etc.

It's a real mess.

The only way to fix this cess pool completely is to override the
read() fop on that pipe, and translate the event stream in-situ.

What we could do is just manage the autofs messages as a linked list
of events, f.e. the packets in native format, then in the overridden
read() handler we either pass it along as is (for non-compat tasks) or
translate to compat format and copy that to userspace instead.
