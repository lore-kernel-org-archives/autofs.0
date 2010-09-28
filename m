From: Ian Kent <raven@themaw.net>
Subject: Re: autmount hangs occasionally on bind-mounts
Date: Tue, 28 Sep 2010 11:30:55 +0800
Message-ID: <1285644655.3189.15.camel@localhost>
References: <20100927055516.493C39802E@mail.linux-ag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=n/4OKiQNQWR//XA57t1SXOYV7p8=;
	b=pu7S0Y2Om1TGAGs77/jVzTKi8vDmi/6gEm+2vajm3YmxEHElw5rrQpMJgzTElb3pQzXO50wL1+Gz7nkMH06IsfWCXxEDf7TL83M4IEX2DlCxq0U9t1gwYj+/6puUOmfGJjpq3ndmbFk5oaKTRl5upqjR6bM9S8l+M3zoO+zsYro=
In-Reply-To: <20100927055516.493C39802E@mail.linux-ag.de>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Sebastian Hetze <s.hetze@linux-ag.com>
Cc: autofs@linux.kernel.org

On Mon, 2010-09-27 at 07:55 +0200, Sebastian Hetze wrote:
> Hi *,
> 
> we are suffering from some sort of race condition that causes
> automount to hang:
> 
> [351841.568061] INFO: task automount:22055 blocked for more than 120 seconds.
> [351841.568689] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [351841.569717] automount     D b983e7f6     0 22055      1 0x00000000
> [351841.570252]  e0ca7ef4 00000082 f3c38000 b983e7f6 00013fde eaed6000 f63af880 f5037c00
> [351841.571308]  c0863320 c0863320 f30de480 f30de718 c5589320 00000002 b9841648 00013fde
> [351841.572316]  f30de718 f72ceff4 f72ceff0 ffffffff e0ca7f20 c059fd3e e0ca7f14 f30de480
> [351841.573364] Call Trace:
> [351841.573686]  [<c059fd3e>] __mutex_lock_slowpath+0xbe/0x120
> [351841.574130]  [<c059fc60>] mutex_lock+0x20/0x40
> [351841.574496]  [<c0202732>] do_rmdir+0x52/0xe0
> [351841.574878]  [<c04b67ad>] ? sys_socketcall+0x1cd/0x2a0
> [351841.575266]  [<c0202820>] sys_rmdir+0x10/0x20
> [351841.575781]  [<c010968c>] syscall_call+0x7/0xb

This is only half the story.

I think you'll find another process that is waiting on the expire via
autofs4_revalidate() and holds the mutex that the above process is
waiting on.

This is a known problem and has been present for years and cannot be
resolved using the current automount framwork.

I don't know why we're suddenly seeing people get caught by it recently
but we are.

Assuming you are seeing the problem I think you are you should be able
to work around it by using the "browse" option on your autofs mounts.
This should work OK as long as your maps are not too large.

> 
> The error occurs occasionally, sometimes after one day, sometimes after
> one week. It occurs with all kind of kernel versions and with all kind
> of automount. Currently we are running autofs 5.0.4 and kernel
> 2.6.31-22-generic-pae from ubuntu.
> 
> I have tried to find out whats going wrong and have come
> to the suspicion, that this might be a systematic problem
> with automount.
> 
> In the failing system we are running automount locally, so automount
> uses bind-mounts to make file system branches accessable somewhere
> else.
> 
> The blocking sys_rmdir happens on such an bind-mount. 
> 
> It appears that the bind-mount can be unmounted regardless how
> many open files there are. Since the open files live on the
> "real file system" there seems to be no notion of usage for
> the bind mountpoint neither in automount nor in the kernel.

Rubbish, open files elevate the reference count on certain kernel
objects within the mounted file system. If there is an open file within
a mounted filesystem the kernel knows about it.

> 
> So what i suspect to happen is the automount tries to umount
> the branch after the timeout has passed, the umount succeeds
> although there are open files, automount proceeds with
> removing the directory but before the sys_rmdir succeeds
> occasionally one of the processes having open files on
> the branch accesses this file/directory causing the kernel
> to hang.

No, this is a deadlock within the VFS which is caused by autofs being
sensitive to the VFS locking requirements of certain system calls.

> 
> Is this a valid explanation? Can you accept this as an bug
> and do something about it...

I have tried to resolve this several times over the last few years
without success. But there is an effort underway now to implement new
VFS automounting support and I'm working on the autofs pert of that.

Ian
