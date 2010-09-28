From: Ian Kent <raven@themaw.net>
Subject: Re: autmount hangs occasionally on bind-mounts
Date: Tue, 28 Sep 2010 20:50:25 +0800
Message-ID: <1285678225.3189.21.camel@localhost>
References: <20100927055516.493C39802E@mail.linux-ag.de>
	<1285644655.3189.15.camel@localhost>
	<20100928101145.92E17409000B@mail.linux-ag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=4Vpd9mJ6y5aiVbAldyU/gPFeZhs=;
	b=I5FT5x2nTe12DNplXafKttzf09QBn8apcJmwzOeLdta6jjbzjra2tlk7DMtsvX6auwrlb6OoIkANU66GeaZQCHh9BPgBogV4RkyJU2cS3GaWROC9k4kGy7DMQWkAZOcYY24m8m2D/MTok2udbu3HZinwG2zX6nZTI+QcoXgbLr0=
In-Reply-To: <20100928101145.92E17409000B@mail.linux-ag.de>
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

On Tue, 2010-09-28 at 12:11 +0200, Sebastian Hetze wrote:
> On Tue, Sep 28, 2010 at 11:30:55AM +0800, Ian Kent wrote:
> > On Mon, 2010-09-27 at 07:55 +0200, Sebastian Hetze wrote:
> > > Hi *,
> > > 
> > > we are suffering from some sort of race condition that causes
> > > automount to hang:
> > > 
> > > [351841.568061] INFO: task automount:22055 blocked for more than 120 seconds.
> > > [351841.568689] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > [351841.569717] automount     D b983e7f6     0 22055      1 0x00000000
> > > [351841.570252]  e0ca7ef4 00000082 f3c38000 b983e7f6 00013fde eaed6000 f63af880 f5037c00
> > > [351841.571308]  c0863320 c0863320 f30de480 f30de718 c5589320 00000002 b9841648 00013fde
> > > [351841.572316]  f30de718 f72ceff4 f72ceff0 ffffffff e0ca7f20 c059fd3e e0ca7f14 f30de480
> > > [351841.573364] Call Trace:
> > > [351841.573686]  [<c059fd3e>] __mutex_lock_slowpath+0xbe/0x120
> > > [351841.574130]  [<c059fc60>] mutex_lock+0x20/0x40
> > > [351841.574496]  [<c0202732>] do_rmdir+0x52/0xe0
> > > [351841.574878]  [<c04b67ad>] ? sys_socketcall+0x1cd/0x2a0
> > > [351841.575266]  [<c0202820>] sys_rmdir+0x10/0x20
> > > [351841.575781]  [<c010968c>] syscall_call+0x7/0xb
> > 
> > This is only half the story.
> > 
> > I think you'll find another process that is waiting on the expire via
> > autofs4_revalidate() and holds the mutex that the above process is
> > waiting on.
> 
> Actually, there is another blocked process:

While that does look a little like what I'd expect to see I don't think
that is the process your looking for.

> 
> [351961.584408] INFO: task install:22804 blocked for more than 120 seconds.
> [351961.584913] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [351961.585545] install       D e268c4fc     0 22804  22798 0x00000000
> [351961.586100]  f442fed8 00000086 c02000b1 e268c4fc 00013fec f442fee8 e04efc00 00000000
> [351961.587180]  c0863320 c0863320 f3a19920 f3a19bb8 c55a9320 00000004 f442ff30 c1010000
> [351961.588255]  f3a19bb8 f72ceff4 f72ceff0 ffffffff f442ff04 c059fd3e f547be58 f3a19920
> [351961.589550] Call Trace:
> [351961.589864]  [<c02000b1>] ? path_to_nameidata+0x31/0x50
> [351961.590286]  [<c059fd3e>] __mutex_lock_slowpath+0xbe/0x120
> [351961.590793]  [<c059fc60>] mutex_lock+0x20/0x40
> [351961.591140]  [<c01ffc4f>] lookup_create+0x1f/0xa0
> [351961.591569]  [<c020287c>] sys_mkdirat+0x4c/0x100
> [351961.591996]  [<c020e48a>] ? mntput_no_expire+0x1a/0xd0
> [351961.592427]  [<c0202950>] sys_mkdir+0x20/0x30
> [351961.592912]  [<c010968c>] syscall_call+0x7/0xb
> 
> > 
> > This is a known problem and has been present for years and cannot be
> > resolved using the current automount framwork.
> > 
> > I don't know why we're suddenly seeing people get caught by it recently
> > but we are.
> > 
> > Assuming you are seeing the problem I think you are you should be able
> > to work around it by using the "browse" option on your autofs mounts.
> > This should work OK as long as your maps are not too large.
> > 
> 
> We will try this option.
> 
> Thanx for your explanation.
> 
> Can you point me to an kernel bug report number that I can trace for
> further development on that subject?

I don't think there is one.

Keep your eye on either the autofs mailing list or linux-fsdevel or
Linux Kernel Mailing list, the series will be posted in those lists.
It may not mention the deadlock issue since the VFS automount
implementation is mean to address slightly different issues with autofs,
AFS, CIFS and NFS. But for autofs a side effect of the implementation is
the deadlock is gone.

Ian
