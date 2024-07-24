Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3DD211C;
	Wed, 24 Jul 2024 00:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721782082; cv=none; b=F7tk+9oAjpO9ODAhQlr9gzEoLTAr63Aaoq7WK5O2OlGnddNMitMtwinSZSEUdOHrUQPnW89cgHNA2/ZBC5dptDbg+o5bYGrLnMXQJSlG2hszm/qk2fxQedqYJHZ3nKidUNV6rpG9fMDZVOxWzsoYPsORxxxWHIvYqUEY4XecmLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721782082; c=relaxed/simple;
	bh=78/f5dWSmUQ/rtSXStEYj4jE3hgvKpcr0sI+Bnfo0OQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gaon19cwntENLRQYRgEA8wAQHhwOuItxmuN9MtoXTpJLM2cVckTJXON0hyFQVWHSo1MvA5i1FM1+vlCflVNlT7l+pR/xW1duqBGwpYmA1X8INqqNy4kb+XPPYzQ1jeuC0G+7ibyQmWG85UeW9iMo0/5l1Zc2COtR99hTNBiNlaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=none smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=KbKqth+G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m98InaQT; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="KbKqth+G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m98InaQT"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id EF5FE138021E;
	Tue, 23 Jul 2024 20:47:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 23 Jul 2024 20:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1721782077;
	 x=1721868477; bh=uqyDXpK3sKKlZlu0i6c4iIuAA4SG0W5AUsIzs1v4zfw=; b=
	KbKqth+GqWR1lElqbG/545JoxMBPcX54ofyqXQneSlDkwwXNj0KjVhfCF+ChR4g8
	Y+RslX394c9kUQ8pe2TrAgbV4BEgwHnQn4NjnoLRsR/q2w1hkPYFZmlxS4WJjAcJ
	Deesec33bTssdkONfazGxgFFxCGFlXCGohELeegGEvhVo3OAjf/+daitJ/Gh+VMc
	IpjKb93yvX3w+Kg5CZ7sk9IL6G5lL7FcKBEoF/WKhcxOi7u1FLNo49LeMgI6pU+H
	aNkYHlQqO/wMsFJu6z7NdbQh0Zd+Ti1lTZqJ85rLWsI6ReMDOeVfrCxL0BILRnAW
	zdpdZAHbu3YzjP0mN44nEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1721782077; x=
	1721868477; bh=uqyDXpK3sKKlZlu0i6c4iIuAA4SG0W5AUsIzs1v4zfw=; b=m
	98InaQTauUy8eK806RUNCp9qa7u++Fn9uhEbhx+SIZYpxA5FrRs4NnzAIDNolQAy
	VCo+d0X+ALzn7zOj2lpLBWuR4qb5Aykp6VXTv/XkA89oep/xwOy3LoZBo67Si8MM
	27asilWhxH+Mu6fItVxEopu1pjyYpKWSDe1kAj17CD+C3HaWJkNUd2blx4jdq0dr
	2m8mu1dRuagksy1VoVwguBu9ungFJXwanonZxSGpNkYWnceYdPQvg2id2W4O1gKY
	EVlbHq/uQCO0f8jWpcmzutT6/23m6IpSU5yx4jdfGfUStOk2A9cdECZIX14GOgFG
	XyG/kxdcDIQQBAhpuYTdw==
X-ME-Sender: <xms:PU-gZoim4ycwZHiM_yGfVLI3AaEpzAD3BvdCOh2LbAcxzUIA9ntiVg>
    <xme:PU-gZhA04kAVkXH1vHAEvn4eSdzNXtpHr7QgXa1BbTBhasoecb7mWTziaIqkPtbVk
    lGUzTayY4mw>
X-ME-Received: <xmr:PU-gZgHjNrHg6JRr01iB43SYxR6fzJKcmTnst2_yv1pGQrHLyB9fy-muTXRYF9CXa91_X9YmhR7K7Ime01Q_m5XuYF22_nj-3DGPy-D-lS3GqbpQAkBpFTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedtgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecuogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenuc
    fjughrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepie
    ekgeffudeukeelffeitdfgjeegveegvdduveetgfefvdejjeeigfdugeefveeknecuffho
    mhgrihhnpehshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmpdhgohhoghhlvggrph
    hishdrtghomhdpghhoohdrghhlnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvghtpdhnsggprhgtphhtth
    hopedt
X-ME-Proxy: <xmx:PU-gZpT5ICzdtmS_l89f-hc3fcHvKzX9ISBbv-FzXHbO9qf9ZHnQug>
    <xmx:PU-gZlwA-RJIGgji3vOPEATGVMmjQx1srWlgFRT1EfthjBd361Hu5A>
    <xmx:PU-gZn5rDmgOh7ZlGqu2l3e-WS2GzEKUxaa962eJRrrkLJ-0UQ8oBg>
    <xmx:PU-gZiyKfBHDsSrKgIKE4b1e7ZmOuLg_bi_8RyHpxMN2v_E9mQmY_w>
    <xmx:PU-gZt-CfQ9WSL0Sxsh70eG4KPmWFqZANHyh2Tjtzb9HlSvW14jt8U7C>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jul 2024 20:47:55 -0400 (EDT)
Message-ID: <19ab74d8-06c7-400d-9bbe-2c25a068bb44@themaw.net>
Date: Wed, 24 Jul 2024 08:47:50 +0800
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [autofs?] possible deadlock in autofs_notify_daemon
To: syzbot <syzbot+0d4e0978aa13f9e1db55@syzkaller.appspotmail.com>,
 autofs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <00000000000075b674061dcab0d5@google.com>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <00000000000075b674061dcab0d5@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/7/24 07:57, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:

I'm having trouble understanding this, you'll need to to better at the 
explanation.


>
> HEAD commit:    d7e78951a8b8 Merge tag 'net-6.11-rc0' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1642f7a5980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2602dfd9213d734c
> dashboard link: https://syzkaller.appspot.com/bug?extid=0d4e0978aa13f9e1db55
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.

That might help since what the mounted file system is makes a difference.


Note that this notification is done to a specific user space process, 
and there is only one for a

given autofs file system mount, and all other processes are read-only 
within that autofs file

system. So I don't see how another process writing to a kernfs file can 
play a part in this.


>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/cdd2c14644df/disk-d7e78951.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7f9c9ab39b87/vmlinux-d7e78951.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/1fc3658770e2/bzImage-d7e78951.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0d4e0978aa13f9e1db55@syzkaller.appspotmail.com
>
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.10.0-syzkaller-09703-gd7e78951a8b8 #0 Not tainted
> ------------------------------------------------------
> syz.3.4748/19551 is trying to acquire lock:
> ffff888059b0d940 (&sbi->pipe_mutex){+.+.}-{3:3}, at: autofs_write fs/autofs/waitq.c:55 [inline]
> ffff888059b0d940 (&sbi->pipe_mutex){+.+.}-{3:3}, at: autofs_notify_daemon+0x71f/0xf80 fs/autofs/waitq.c:164
>
> but task is already holding lock:
> ffff8880758e7888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1eb/0x500 fs/kernfs/file.c:325
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #2 (&of->mutex){+.+.}-{3:3}:
>         lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
>         __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>         __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
>         kernfs_fop_write_iter+0x1eb/0x500 fs/kernfs/file.c:325
>         iter_file_splice_write+0xbd7/0x14e0 fs/splice.c:743
>         do_splice_from fs/splice.c:941 [inline]
>         do_splice+0xd77/0x1900 fs/splice.c:1354
>         __do_splice fs/splice.c:1436 [inline]
>         __do_sys_splice fs/splice.c:1652 [inline]
>         __se_sys_splice+0x331/0x4a0 fs/splice.c:1634
>         do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>         do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>         entry_SYSCALL_64_after_hwframe+0x77/0x7f

Is it really possible for some process to try and take lock that 
conflicts with a pipe owned

by a process that doesn't make calls into kernfs and will not open a 
file in kernfs. This pipe

is opened against an autofs file system.


I don't understand the scenario you'll need to help me out with some 
explanation of how such

an interaction can happen!


Ian

>
> -> #1 (&pipe->mutex){+.+.}-{3:3}:
>         lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
>         __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>         __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
>         pipe_write+0x1c9/0x1a40 fs/pipe.c:455
>         __kernel_write_iter+0x47e/0x900 fs/read_write.c:523
>         __kernel_write+0x120/0x180 fs/read_write.c:543
>         autofs_write fs/autofs/waitq.c:57 [inline]
>         autofs_notify_daemon+0x732/0xf80 fs/autofs/waitq.c:164
>         autofs_wait+0x10b8/0x1b30 fs/autofs/waitq.c:426
>         autofs_do_expire_multi+0x659/0x950 fs/autofs/expire.c:590
>         autofs_root_ioctl+0x4c/0x60 fs/autofs/root.c:910
>         vfs_ioctl fs/ioctl.c:51 [inline]
>         __do_sys_ioctl fs/ioctl.c:907 [inline]
>         __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
>         do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>         do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>         entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> -> #0 (&sbi->pipe_mutex){+.+.}-{3:3}:
>         check_prev_add kernel/locking/lockdep.c:3133 [inline]
>         check_prevs_add kernel/locking/lockdep.c:3252 [inline]
>         validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
>         __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
>         lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
>         __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>         __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
>         autofs_write fs/autofs/waitq.c:55 [inline]
>         autofs_notify_daemon+0x71f/0xf80 fs/autofs/waitq.c:164
>         autofs_wait+0x10b8/0x1b30 fs/autofs/waitq.c:426
>         autofs_mount_wait+0x170/0x330 fs/autofs/root.c:255
>         autofs_d_automount+0x555/0x710 fs/autofs/root.c:401
>         follow_automount fs/namei.c:1394 [inline]
>         __traverse_mounts+0x2ba/0x580 fs/namei.c:1439
>         traverse_mounts fs/namei.c:1468 [inline]
>         handle_mounts fs/namei.c:1571 [inline]
>         step_into+0x5e5/0x1080 fs/namei.c:1877
>         lookup_last fs/namei.c:2542 [inline]
>         path_lookupat+0x16f/0x450 fs/namei.c:2566
>         filename_lookup+0x256/0x610 fs/namei.c:2595
>         kern_path+0x35/0x50 fs/namei.c:2703
>         lookup_bdev+0xc5/0x290 block/bdev.c:1157
>         resume_store+0x1a0/0x710 kernel/power/hibernate.c:1235
>         kernfs_fop_write_iter+0x3a1/0x500 fs/kernfs/file.c:334
>         iter_file_splice_write+0xbd7/0x14e0 fs/splice.c:743
>         do_splice_from fs/splice.c:941 [inline]
>         direct_splice_actor+0x11e/0x220 fs/splice.c:1164
>         splice_direct_to_actor+0x58e/0xc90 fs/splice.c:1108
>         do_splice_direct_actor fs/splice.c:1207 [inline]
>         do_splice_direct+0x28c/0x3e0 fs/splice.c:1233
>         do_sendfile+0x56d/0xe20 fs/read_write.c:1295
>         __do_sys_sendfile64 fs/read_write.c:1362 [inline]
>         __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1348
>         do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>         do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>         entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> other info that might help us debug this:
>
> Chain exists of:
>    &sbi->pipe_mutex --> &pipe->mutex --> &of->mutex
>
>   Possible unsafe locking scenario:
>
>         CPU0                    CPU1
>         ----                    ----
>    lock(&of->mutex);
>                                 lock(&pipe->mutex);
>                                 lock(&of->mutex);
>    lock(&sbi->pipe_mutex);
>
>   *** DEADLOCK ***
>
> 3 locks held by syz.3.4748/19551:
>   #0: ffff88801e524420 (sb_writers#8){.+.+}-{0:0}, at: direct_splice_actor+0x49/0x220 fs/splice.c:1163
>   #1: ffff8880758e7888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1eb/0x500 fs/kernfs/file.c:325
>   #2: ffff888017adb4b8 (kn->active#65){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20f/0x500 fs/kernfs/file.c:326
>
> stack backtrace:
> CPU: 1 PID: 19551 Comm: syz.3.4748 Not tainted 6.10.0-syzkaller-09703-gd7e78951a8b8 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>   check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2186
>   check_prev_add kernel/locking/lockdep.c:3133 [inline]
>   check_prevs_add kernel/locking/lockdep.c:3252 [inline]
>   validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
>   __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
>   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
>   __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>   __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
>   autofs_write fs/autofs/waitq.c:55 [inline]
>   autofs_notify_daemon+0x71f/0xf80 fs/autofs/waitq.c:164
>   autofs_wait+0x10b8/0x1b30 fs/autofs/waitq.c:426
>   autofs_mount_wait+0x170/0x330 fs/autofs/root.c:255
>   autofs_d_automount+0x555/0x710 fs/autofs/root.c:401
>   follow_automount fs/namei.c:1394 [inline]
>   __traverse_mounts+0x2ba/0x580 fs/namei.c:1439
>   traverse_mounts fs/namei.c:1468 [inline]
>   handle_mounts fs/namei.c:1571 [inline]
>   step_into+0x5e5/0x1080 fs/namei.c:1877
>   lookup_last fs/namei.c:2542 [inline]
>   path_lookupat+0x16f/0x450 fs/namei.c:2566
>   filename_lookup+0x256/0x610 fs/namei.c:2595
>   kern_path+0x35/0x50 fs/namei.c:2703
>   lookup_bdev+0xc5/0x290 block/bdev.c:1157
>   resume_store+0x1a0/0x710 kernel/power/hibernate.c:1235
>   kernfs_fop_write_iter+0x3a1/0x500 fs/kernfs/file.c:334
>   iter_file_splice_write+0xbd7/0x14e0 fs/splice.c:743
>   do_splice_from fs/splice.c:941 [inline]
>   direct_splice_actor+0x11e/0x220 fs/splice.c:1164
>   splice_direct_to_actor+0x58e/0xc90 fs/splice.c:1108
>   do_splice_direct_actor fs/splice.c:1207 [inline]
>   do_splice_direct+0x28c/0x3e0 fs/splice.c:1233
>   do_sendfile+0x56d/0xe20 fs/read_write.c:1295
>   __do_sys_sendfile64 fs/read_write.c:1362 [inline]
>   __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1348
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f75ec575b59
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f75ebfde048 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 00007f75ec706038 RCX: 00007f75ec575b59
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000004
> RBP: 00007f75ec5e4e5d R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000006e R14: 00007f75ec706038 R15: 00007ffef2866ed8
>   </TASK>
> PM: Image not found (code -6)
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
