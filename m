From: Ian Kent <raven@themaw.net>
Subject: Re: lockdep warning from autofs4 when fuzzing with trinity
Date: Wed, 10 Dec 2014 14:56:35 +0800
Message-ID: <1418194595.2859.5.camel@pluto.fritz.box>
References: <AM3PR05MB0935053AB03E0B424C81DD14DC640@AM3PR05MB0935.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	x-sasl-enc:message-id:subject:from:to:cc:date:in-reply-to
	:references:content-type:mime-version:content-transfer-encoding;
	 s=mesmtp; bh=xZqPhgrtzyL4NQnuzZENA8CYmEA=; b=br7V9gbs+4Zw5OxF3C
	vzihF6W1s/TQ/zinmlaN2j+FgcNpwEbwwtBxgE3Uij3+DyDL6gXo1NpyQvsI+tFQ
	MNEDzflYydxdiPWbdKe0UVtpBkJOf62LBOwBvjvdX1/OtTGXwghhO8GnoH7Qvx8m
	WIr8ckvDYF4mnYDYMQY9rhYPo=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:subject:from:to:cc
	:date:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=xZqPhgrtzyL4NQnuzZENA8
	CYmEA=; b=g2G2N5X+uKZFbowF1jX5f+/qmh1NyxYysJH6V3/YChfn/nNkpUlz3N
	nryGNyOPbPKQJcm9wDnc7O9d2xEONZ1sBeAv3IvOZ0WlxDWB1MKd/32cnJDmXb6J
	uYlUxEt3Ur0MA3bVIBI6bPLADeK7G1Vo9hc/nYeo/RCP01mw2JbH0=
In-Reply-To: <AM3PR05MB0935053AB03E0B424C81DD14DC640@AM3PR05MB0935.eurprd05.prod.outlook.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Shachar Raindel <raindel@mellanox.com>
Cc: "autofs@vger.kernel.org" <autofs@vger.kernel.org>

On Mon, 2014-12-08 at 13:44 +0000, Shachar Raindel wrote:
> Hi,
> 
> I was fuzzing linux 3.18 (plus a minor, unrelated patch in the memory
> management subsystem) using trinity. I got the following lock-dep
> splat, which seems to originate from the autofs4 code:

At first glance I don't see how this could occur so I'll need to think
about it.

Could you give me a little more context about what was happening at the
time.

The pipe_mutex here is held only during a write to the autofs mount pipe
and I don't think that will block unless perhaps the daemon hasn't read
the pipe for some time, which is not likely since it reads the pipe,
creates a worker thread and returns to wait on the pipe. So I'm not sure
what's going on here.

> 
> 
> [ 8890.416041] ======================================================
> [ 8890.416041] [ INFO: possible circular locking dependency detected ]
> [ 8890.416041] 3.18.0+ #25 Tainted: G        W     
> [ 8890.416041] -------------------------------------------------------
> [ 8890.416041] bash/4644 is trying to acquire lock:
> [ 8890.416041]  (&sbi->pipe_mutex){+.+.+.}, at: [<ffffffff812a25fb>] autofs4_notify_daemon+0x1cb/0x340
> [ 8890.416041] 
> but task is already holding lock:
> [ 8890.416041]  (&sig->cred_guard_mutex){+.+.+.}, at: [<ffffffff8121f1e4>] prepare_bprm_creds+0x34/0x90
> [ 8890.416041] 
> which lock already depends on the new lock.
> 
> [ 8890.416041] 
> the existing dependency chain (in reverse order) is:
> [ 8890.416041] 
> -> #2 (&sig->cred_guard_mutex){+.+.+.}:
> [ 8890.416041]        [<ffffffff810cc5b6>] validate_chain.isra.36+0x486/0x930
> [ 8890.416041]        [<ffffffff810ced48>] __lock_acquire+0x378/0xbe0
> [ 8890.416041]        [<ffffffff810cf677>] lock_acquire+0xc7/0x160
> [ 8890.416041]        [<ffffffff816d15e1>] mutex_lock_interruptible_nested+0x81/0x5c0
> [ 8890.416041]        [<ffffffff8128628d>] proc_pid_attr_write+0xfd/0x150
> [ 8890.416041]        [<ffffffff81216e48>] __kernel_write+0x68/0x160
> [ 8890.416041]        [<ffffffff81249445>] write_pipe_buf+0x85/0xb0
> [ 8890.416041]        [<ffffffff81248f5e>] __splice_from_pipe+0x11e/0x190
> [ 8890.416041]        [<ffffffff8124afde>] splice_from_pipe+0x5e/0x90
> [ 8890.416041]        [<ffffffff8124b04d>] default_file_splice_write+0x1d/0x30
> [ 8890.416041]        [<ffffffff8124b51a>] SyS_splice+0x25a/0x800
> [ 8890.416041]        [<ffffffff816d65e9>] system_call_fastpath+0x12/0x17
> [ 8890.416041] 
> -> #1 (&pipe->mutex/1){+.+.+.}:
> [ 8890.416041]        [<ffffffff810cc5b6>] validate_chain.isra.36+0x486/0x930
> [ 8890.416041]        [<ffffffff810ced48>] __lock_acquire+0x378/0xbe0
> [ 8890.416041]        [<ffffffff810cf677>] lock_acquire+0xc7/0x160
> [ 8890.416041]        [<ffffffff816d20b1>] mutex_lock_nested+0x81/0x510
> [ 8890.416041]        [<ffffffff8122022f>] pipe_write+0x3f/0x490
> [ 8890.416041]        [<ffffffff81216b3e>] new_sync_write+0x8e/0xd0
> [ 8890.416041]        [<ffffffff812a2613>] autofs4_notify_daemon+0x1e3/0x340
> [ 8890.416041]        [<ffffffff812a2f65>] autofs4_wait+0x7f5/0xa20
> [ 8890.416041]        [<ffffffff812a0ce0>] autofs4_mount_wait+0x50/0xf0
> [ 8890.416041]        [<ffffffff812a1609>] autofs4_d_automount+0xe9/0x240
> [ 8890.416041]        [<ffffffff81221f93>] follow_managed+0x143/0x310
> [ 8890.416041]        [<ffffffff816c96e2>] lookup_slow+0x7d/0xad
> [ 8890.416041]        [<ffffffff81226732>] link_path_walk+0x792/0x860
> [ 8890.416041]        [<ffffffff8122740b>] path_openat+0xab/0x640
> [ 8890.416041]        [<ffffffff81229a69>] do_filp_open+0x49/0xc0
> [ 8890.416041]        [<ffffffff81216397>] do_sys_open+0x137/0x240
> [ 8890.416041]        [<ffffffff812164be>] SyS_open+0x1e/0x20
> [ 8890.416041]        [<ffffffff816d65e9>] system_call_fastpath+0x12/0x17
> [ 8890.416041] 
> -> #0 (&sbi->pipe_mutex){+.+.+.}:
> [ 8890.416041]        [<ffffffff810cc10f>] check_prevs_add+0x9af/0x9d0
> [ 8890.416041]        [<ffffffff810cc5b6>] validate_chain.isra.36+0x486/0x930
> [ 8890.416041]        [<ffffffff810ced48>] __lock_acquire+0x378/0xbe0
> [ 8890.416041]        [<ffffffff810cf677>] lock_acquire+0xc7/0x160
> [ 8890.416041]        [<ffffffff816d20b1>] mutex_lock_nested+0x81/0x510
> [ 8890.416041]        [<ffffffff812a25fb>] autofs4_notify_daemon+0x1cb/0x340
> [ 8890.416041]        [<ffffffff812a2f65>] autofs4_wait+0x7f5/0xa20
> [ 8890.416041]        [<ffffffff812a0ce0>] autofs4_mount_wait+0x50/0xf0
> [ 8890.416041]        [<ffffffff812a1609>] autofs4_d_automount+0xe9/0x240
> [ 8890.416041]        [<ffffffff81221f93>] follow_managed+0x143/0x310
> [ 8890.416041]        [<ffffffff816c96e2>] lookup_slow+0x7d/0xad
> [ 8890.416041]        [<ffffffff812266a7>] link_path_walk+0x707/0x860
> [ 8890.416041]        [<ffffffff8122740b>] path_openat+0xab/0x640
> [ 8890.416041]        [<ffffffff81229a69>] do_filp_open+0x49/0xc0
> [ 8890.416041]        [<ffffffff8121e546>] do_open_exec+0x26/0xf0
> [ 8890.416041]        [<ffffffff8121f458>] do_execve_common.isra.24+0x218/0x710
> [ 8890.416041]        [<ffffffff8121fb99>] SyS_execve+0x29/0x30
> [ 8890.416041]        [<ffffffff816d6bf9>] stub_execve+0x69/0xa0
> [ 8890.416041] 
> other info that might help us debug this:
> 
> [ 8890.416041] Chain exists of:
>   &sbi->pipe_mutex --> &pipe->mutex/1 --> &sig->cred_guard_mutex
> 
> [ 8890.416041]  Possible unsafe locking scenario:
> 
> [ 8890.416041]        CPU0                    CPU1
> [ 8890.416041]        ----                    ----
> [ 8890.416041]   lock(&sig->cred_guard_mutex);
> [ 8890.416041]                                lock(&pipe->mutex/1);
> [ 8890.416041]                                lock(&sig->cred_guard_mutex);
> [ 8890.416041]   lock(&sbi->pipe_mutex);
> [ 8890.416041] 
>  *** DEADLOCK ***
> 
> [ 8890.416041] 1 lock held by bash/4644:
> [ 8890.416041]  #0:  (&sig->cred_guard_mutex){+.+.+.}, at: [<ffffffff8121f1e4>] prepare_bprm_creds+0x34/0x90
> [ 8890.416041] 
> stack backtrace:
> [ 8890.416041] CPU: 1 PID: 4644 Comm: bash Tainted: G        W      3.18.0+ #25
> [ 8890.416041] Hardware name: Red Hat KVM, BIOS Bochs 01/01/2007
> [ 8890.416041]  0000000000000000 0000000043c40f29 ffff88004dc775b8 ffffffff816cbade
> [ 8890.416041]  0000000000000000 ffffffff829fc330 ffff88004dc77608 ffffffff816c4bf0
> [ 8890.416041]  ffff88000d401b70 ffff88004dc77648 ffff88004dc77608 0000000000000000
> [ 8890.416041] Call Trace:
> [ 8890.416041]  [<ffffffff816cbade>] dump_stack+0x4e/0x68
> [ 8890.416041]  [<ffffffff816c4bf0>] print_circular_bug+0x1fb/0x20c
> [ 8890.416041]  [<ffffffff810cc10f>] check_prevs_add+0x9af/0x9d0
> [ 8890.416041]  [<ffffffff8105f4d7>] ? kvm_clock_read+0x27/0x40
> [ 8890.416041]  [<ffffffff810cc5b6>] validate_chain.isra.36+0x486/0x930
> [ 8890.416041]  [<ffffffff810ced48>] __lock_acquire+0x378/0xbe0
> [ 8890.416041]  [<ffffffff810b02c6>] ? local_clock+0x16/0x30
> [ 8890.416041]  [<ffffffff810cf677>] lock_acquire+0xc7/0x160
> [ 8890.416041]  [<ffffffff812a25fb>] ? autofs4_notify_daemon+0x1cb/0x340
> [ 8890.416041]  [<ffffffff816d20b1>] mutex_lock_nested+0x81/0x510
> [ 8890.416041]  [<ffffffff812a25fb>] ? autofs4_notify_daemon+0x1cb/0x340
> [ 8890.416041]  [<ffffffff812a25fb>] ? autofs4_notify_daemon+0x1cb/0x340
> [ 8890.416041]  [<ffffffff810cd11d>] ? trace_hardirqs_on+0xd/0x10
> [ 8890.416041]  [<ffffffff812a25fb>] autofs4_notify_daemon+0x1cb/0x340
> [ 8890.416041]  [<ffffffff812a2f65>] autofs4_wait+0x7f5/0xa20
> [ 8890.416041]  [<ffffffff812a28fb>] ? autofs4_wait+0x18b/0xa20
> [ 8890.416041]  [<ffffffff812a15ff>] ? autofs4_d_automount+0xdf/0x240
> [ 8890.416041]  [<ffffffff812a0ce0>] autofs4_mount_wait+0x50/0xf0
> [ 8890.416041]  [<ffffffff812a1609>] autofs4_d_automount+0xe9/0x240
> [ 8890.416041]  [<ffffffff81221f93>] follow_managed+0x143/0x310
> [ 8890.416041]  [<ffffffff816c96e2>] lookup_slow+0x7d/0xad
> [ 8890.416041]  [<ffffffff812266a7>] link_path_walk+0x707/0x860
> [ 8890.416041]  [<ffffffff812242e5>] ? path_init+0x4b5/0x700
> [ 8890.416041]  [<ffffffff8122740b>] path_openat+0xab/0x640
> [ 8890.416041]  [<ffffffff8105f4d7>] ? kvm_clock_read+0x27/0x40
> [ 8890.416041]  [<ffffffff81020009>] ? sched_clock+0x9/0x10
> [ 8890.416041]  [<ffffffff81020009>] ? sched_clock+0x9/0x10
> [ 8890.416041]  [<ffffffff810affc5>] ? sched_clock_local+0x25/0x90
> [ 8890.416041]  [<ffffffff81229a69>] do_filp_open+0x49/0xc0
> [ 8890.416041]  [<ffffffff8121f43c>] ? do_execve_common.isra.24+0x1fc/0x710
> [ 8890.416041]  [<ffffffff8121f3f2>] ? do_execve_common.isra.24+0x1b2/0x710
> [ 8890.416041]  [<ffffffff8121e546>] do_open_exec+0x26/0xf0
> [ 8890.416041]  [<ffffffff8121f458>] do_execve_common.isra.24+0x218/0x710
> [ 8890.416041]  [<ffffffff8121f377>] ? do_execve_common.isra.24+0x137/0x710
> [ 8890.416041]  [<ffffffff8121fb99>] SyS_execve+0x29/0x30
> [ 8890.416041]  [<ffffffff816d6bf9>] stub_execve+0x69/0xa0
> 
> Thanks,
> --Shachar


