Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E802248B3;
	Tue, 29 Sep 2026 02:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790649974; cv=none; b=fzCo6Eejwd4I8QDUcxWygEEMsnbSwcqzctOx4m7EdDI1pRHCpLMVwPeHrT3I16E32F/KAwFiUJmo4t7Vu83drpRVhPmQLgCws6NbmzX3cvlygpM6PvvZz0xfFN6RJ32HmjwsCX249gGad12fQe4rMILBJb2jWExO08mtSn+0Tww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790649974; c=relaxed/simple;
	bh=nagI81px4ZFOCjaVdti1fa5fOKTbO3TTElPtw3z4cO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MfmDRy1mASfuxvyW7XWTN3iZm4P5H+PzSh9eDCBQjYxq9nA3jrg0QYonM2PqXH90+bI350InBGFNIef/NA7/Vh9fQHGnUpm2CSkLQXfkEK3lemkAHedB+/dAPPgt4CFmtPtnrMTYYag2+jO9Onlmax0P1ds0+dhkH/63krDgZ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=UQ2bgaMi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JIUp9Z0j; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="UQ2bgaMi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JIUp9Z0j"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DCDAA1400126;
	Mon, 28 Sep 2026 22:46:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 28 Sep 2026 22:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790649970;
	 x=1790736370; bh=VPWinI8ajkVfE9Jg888CCHUHJ4fk8tIbzp8rWBRGZYA=; b=
	UQ2bgaMixMQ2U/Iwyk01Y9RwwRWyqnc882tJVe2F8JLTvDcNnWP2xk2E+3GcG8Wy
	FHG42XFhVVsIfhsY37yFMCtRvL4uVCPDzHmXfmmfs+HMH457PKIe/eBKHre+Lzng
	DdlOSLRFGwM41oF5F39A0SZsKXI6NQklPBP5xwwIaZy7K90KGfpPXwdmhFtpljU0
	zA0WNVId1+sQIcsgWtk2ktcGiLEhzrM8w1M2vEqssLsc6fOwjc5s2V9/mn/D/wJv
	GCyLDBqo5eVfj2fgyG9g0kcgGBKUHU0kQmaQy5ezSMbl3QtnO1TqGfrD4G13cw/P
	s+sh8haPA99k2cppZpQzvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790649970; x=1790736370; bh=V
	PWinI8ajkVfE9Jg888CCHUHJ4fk8tIbzp8rWBRGZYA=; b=JIUp9Z0jnYc78POjx
	A84gTa2D0NDA0Ok65230XQAmFEosxKdr92ny36AZqDo8xpcM1aX47RqRgBnRYUX3
	Bw5h+mo+2IRqUN2wrDzk6vqhF9eXHLQnKo4uKO+PhpCScMrVLraTJFQX4IzGbR9h
	8b5esZd/dnO90rZfcYN/KWto1hOkgaJ4i5wVymplMb1KNvs+MR7jBtouaV3njvuE
	ygPyxffAZz4sfGa/5Od0BpwUR4eykiSDvRIbF1DSfvRi9bsjsGsZV7t6qbKjE0cM
	SMrtXg+bawji9iNakscafpeiN/GQyXj/HpQ8k/SBydzg0LXXRdNcPLVwlrrZG5tC
	t1iJA==
X-ME-Sender: <xms:cia7aq3V1IEtWvrTZqjti2bGdZuz4JT4vh0Z5_kn5sPyOq52fKy9Rw>
    <xme:cia7aoCHRBC9KJE_Ac568-fTpY8VF1jwMJi03n2q4F9wc9-YBZu_NlhUxhioDsO_T
    6h7cGSErHSfqodWEpIdKotBPBz0Z2g7CeMbHjjoSMI20Kyp4w>
X-ME-Received: <xmr:cia7ah4o83bovHnUiU3xx9DG4zDEwYJzqlyJzMbvy6b6kM1tiK2jkpOFpAxFg_YvzMHhW9wg-Yux81kC5oRrGvIqUd_uGBZ_cBoetY09B4JdYy5zBxujRrGv>
X-ME-Proxy-Cause: dmFkZTGBsQAph6/yu52cEzltwBl/NSOJh7mPyWlHerec/vR6Cr3fhy4+Okw17g8HnaQ/Z1
    iQT60XRgzJiI77ERtEgmCkH7t6NJD/cGS95Nefc1jhzM+0bAKI2CBH7LvKtWswb2oG4Xnr
    qDhTJqx9q21RM1UKeAjBpj9Ke5YIjf18E4OrUOCkZ0AzoA4lwqxtF4etFDFqBH9dDinBLQ
    ujUo7bHiDLbWCdErXRncieLNOyFtBzLLrRaNe+RVFBEfMz53DOBsvW1BTulwIRNTZ4zIj8
    6loLTlkoft7cAF82dQZNJYmDckXcCZrcqqqF7lBQXN79buZvgjx3ZBI7qSZs5wD+MLBFaa
    pkqX1csUkZLdcSaUzpdcEjFLrE8T7DER0l6aYwmED66IKwn0urUqSoC8dnTstEytkIgs85
    7bR0q+hKRo56Z52H4sTZ/5wvpffXH2GjT1or7ok8oXTxNYeZH9fpDiE+ZBIvsvM9j+ASqP
    1HD/lDMGZSIKQvpq8SDr/at1Q8IO5LidYc/FcCMNH/IG/jdFxorFu1JV+bbdkQayTjoUM1
    XpOtvX4SOiOw1wis3ut30NEXk5JwGLWC7agmHJhnv38fqsA3v2ibFVIbaeWMtCPKB8Hdkx
    PFppebNP58eoHoEtTv6I7xVatvC858192eFzW7KhAiwvAo3a6fu3vHqAWpKw
X-ME-Proxy: <xmx:cia7ahINCRom1Ys-umBVnTlpO3xV8pkpb1acYT83tZ1f7Lmd5ksgOQ>
    <xmx:cia7aquYdMuNkw66r0aNaEwnMasxz9OW0ChBqrCbR73uoUIGEbVvUw>
    <xmx:cia7agIRIvip4kLC0tx_U3jCelt2Yxv-qejzZyXFFj3Xq09TF3J8Mg>
    <xmx:cia7aj_eVfOiLoVSG-D4azq3moeyou91JzENrpTPYjxydMrEe1ESXg>
    <xmx:cia7aiG4_Zo9zHKUpUJUrg4WbDzJ4eHzFYkBAujHIka60DFy9-6r1ma3>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 22:46:07 -0400 (EDT)
Message-ID: <add02708-b7de-4aa6-93eb-f2c53be52be4@themaw.net>
Date: Tue, 29 Sep 2026 10:46:04 +0800
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernfs?] possible deadlock in autofs_notify_daemon (3)
To: syzbot <syzbot+2b1c8c58f62458852a54@syzkaller.appspotmail.com>,
 autofs@vger.kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
References: <6ab933fc.80e1c6cc.1e8e5f.005e.GAE@google.com>
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <6ab933fc.80e1c6cc.1e8e5f.005e.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/9/26 23:19, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    fd179f8a05be Merge tag 'ata-7.3-rc5' of git://git.kernel.o..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=12416605580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7d012d9c67977ee4
> dashboard link: https://syzkaller.appspot.com/bug?extid=2b1c8c58f62458852a54
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15870ac9580000

What's your point here?

Are you saying that I need to explicitly check and reject obviously 
bad/stupid requests.

Oh wait, I never see the request because there is no daemon involved.

Not sure how or where I can add a sanity check in this lot ...

Perhaps at mount, reject a list of known pseudo-fs file systems that 
make no sense to

automount.


Ian

>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2b1c8c58f62458852a54@syzkaller.appspotmail.com
>
> ======================================================
> WARNING: possible circular locking dependency detected
> syzkaller #0 Not tainted
> ------------------------------------------------------
> syz-executor419/5954 is trying to acquire lock:
> ffff8880349c0938 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_write fs/autofs/waitq.c:55 [inline]
> ffff8880349c0938 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_notify_daemon+0x4f8/0xd90 fs/autofs/waitq.c:164
>
> but task is already holding lock:
> ffff888037e1c880 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #2 (&of->mutex){+.+.}-{4:4}:
>         lock_acquire kernel/locking/lockdep.c:5942 [inline]
>         lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
>         __mutex_lock_common kernel/locking/mutex.c:646 [inline]
>         __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
>         kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
>         iter_file_splice_write+0x830/0x10b0 fs/splice.c:736
>         do_splice_from fs/splice.c:936 [inline]
>         do_splice+0x109c/0x1fa0 fs/splice.c:1349
>         __do_splice+0x33b/0x370 fs/splice.c:1431
>         __do_sys_splice fs/splice.c:1634 [inline]
>         __se_sys_splice fs/splice.c:1616 [inline]
>         __x64_sys_splice+0x187/0x250 fs/splice.c:1616
>         do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>         do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
>         entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> -> #1 (&pipe->mutex){+.+.}-{4:4}:
>         lock_acquire kernel/locking/lockdep.c:5942 [inline]
>         lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
>         __mutex_lock_common kernel/locking/mutex.c:646 [inline]
>         __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
>         anon_pipe_prefill_and_lock+0x16c/0x580 fs/pipe.c:165
>         anon_pipe_write+0x164/0x1b50 fs/pipe.c:534
>         __kernel_write_iter+0x6bb/0x930 fs/read_write.c:621
>         __kernel_write+0xf6/0x140 fs/read_write.c:641
>         autofs_write fs/autofs/waitq.c:57 [inline]
>         autofs_notify_daemon+0x50d/0xd90 fs/autofs/waitq.c:164
>         autofs_wait+0x10fd/0x1b50 fs/autofs/waitq.c:426
>         autofs_mount_wait+0x132/0x3b0 fs/autofs/root.c:256
>         autofs_d_automount+0x490/0x950 fs/autofs/root.c:410
>         follow_automount fs/namei.c:1565 [inline]
>         __traverse_mounts+0x1b9/0x8a0 fs/namei.c:1618
>         traverse_mounts fs/namei.c:1647 [inline]
>         handle_mounts fs/namei.c:1749 [inline]
>         step_into_slowpath+0xb7e/0xf90 fs/namei.c:2104
>         step_into fs/namei.c:2152 [inline]
>         walk_component fs/namei.c:2288 [inline]
>         lookup_last fs/namei.c:2789 [inline]
>         path_lookupat+0x58b/0xc40 fs/namei.c:2813
>         filename_lookup+0x202/0x590 fs/namei.c:2842
>         vfs_statx+0xff/0x3f0 fs/stat.c:353
>         vfs_fstatat+0x77/0xe0 fs/stat.c:373
>         __do_sys_newfstatat+0x9d/0x120 fs/stat.c:538
>         do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>         do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
>         entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> -> #0 (&sbi->pipe_mutex){+.+.}-{4:4}:
>         check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3209
>         check_prevs_add kernel/locking/lockdep.c:3328 [inline]
>         validate_chain kernel/locking/lockdep.c:3952 [inline]
>         __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
>         lock_acquire kernel/locking/lockdep.c:5942 [inline]
>         lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
>         __mutex_lock_common kernel/locking/mutex.c:646 [inline]
>         __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
>         autofs_write fs/autofs/waitq.c:55 [inline]
>         autofs_notify_daemon+0x4f8/0xd90 fs/autofs/waitq.c:164
>         autofs_wait+0x10fd/0x1b50 fs/autofs/waitq.c:426
>         autofs_mount_wait+0x132/0x3b0 fs/autofs/root.c:256
>         autofs_d_automount+0x490/0x950 fs/autofs/root.c:410
>         follow_automount fs/namei.c:1565 [inline]
>         __traverse_mounts+0x1b9/0x8a0 fs/namei.c:1618
>         traverse_mounts fs/namei.c:1647 [inline]
>         handle_mounts fs/namei.c:1749 [inline]
>         step_into_slowpath+0xb7e/0xf90 fs/namei.c:2104
>         step_into fs/namei.c:2152 [inline]
>         walk_component fs/namei.c:2288 [inline]
>         lookup_last fs/namei.c:2789 [inline]
>         path_lookupat+0x58b/0xc40 fs/namei.c:2813
>         filename_lookup+0x202/0x590 fs/namei.c:2842
>         kern_path+0x37/0x50 fs/namei.c:3036
>         lookup_bdev+0xd8/0x2a0 block/bdev.c:1268
>         resume_store+0x1d6/0x460 kernel/power/hibernate.c:1280
>         kobj_attr_store+0x58/0x80 lib/kobject.c:842
>         sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
>         kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
>         new_sync_write fs/read_write.c:595 [inline]
>         vfs_write+0x6af/0x1050 fs/read_write.c:687
>         ksys_write+0x12a/0x250 fs/read_write.c:739
>         do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>         do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
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
> locks held by syz-executor419/5954: 4, last CPU#0:
>   #0: ffff88807a6735f0 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x2aa/0x380 fs/file.c:1259
>   #1: ffff888037bc2460 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
>   #2: ffff888037e1c880 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
>   #3: ffff888020adbe18 (kn->active#59){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
>   #3: ffff888020adbe18 (kn->active#59){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x332/0x5f0 fs/kernfs/file.c:337
>
> stack backtrace:
> CPU: 0 UID: 0 PID: 5954 Comm: syz-executor419 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/05/2026
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
>   print_circular_bug.cold+0x178/0x1be kernel/locking/lockdep.c:2087
>   check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2219
>   check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3209
>   check_prevs_add kernel/locking/lockdep.c:3328 [inline]
>   validate_chain kernel/locking/lockdep.c:3952 [inline]
>   __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
>   lock_acquire kernel/locking/lockdep.c:5942 [inline]
>   lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
>   __mutex_lock_common kernel/locking/mutex.c:646 [inline]
>   __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
>   autofs_write fs/autofs/waitq.c:55 [inline]
>   autofs_notify_daemon+0x4f8/0xd90 fs/autofs/waitq.c:164
>   autofs_wait+0x10fd/0x1b50 fs/autofs/waitq.c:426
>   autofs_mount_wait+0x132/0x3b0 fs/autofs/root.c:256
>   autofs_d_automount+0x490/0x950 fs/autofs/root.c:410
>   follow_automount fs/namei.c:1565 [inline]
>   __traverse_mounts+0x1b9/0x8a0 fs/namei.c:1618
>   traverse_mounts fs/namei.c:1647 [inline]
>   handle_mounts fs/namei.c:1749 [inline]
>   step_into_slowpath+0xb7e/0xf90 fs/namei.c:2104
>   step_into fs/namei.c:2152 [inline]
>   walk_component fs/namei.c:2288 [inline]
>   lookup_last fs/namei.c:2789 [inline]
>   path_lookupat+0x58b/0xc40 fs/namei.c:2813
>   filename_lookup+0x202/0x590 fs/namei.c:2842
>   kern_path+0x37/0x50 fs/namei.c:3036
>   lookup_bdev+0xd8/0x2a0 block/bdev.c:1268
>   resume_store+0x1d6/0x460 kernel/power/hibernate.c:1280
>   kobj_attr_store+0x58/0x80 lib/kobject.c:842
>   sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
>   kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
>   new_sync_write fs/read_write.c:595 [inline]
>   vfs_write+0x6af/0x1050 fs/read_write.c:687
>   ksys_write+0x12a/0x250 fs/read_write.c:739
>   do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>   do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fab79cd6b77
> Code: 48 89 fa 4c 89 df e8 98 1e 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
> RSP: 002b:00007ffcb4ea4ee0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 000055556184c400 RCX: 00007fab79cd6b77
> RDX: 0000000000000016 RSI: 00007fab79d14c00 RDI: 0000000000000005
> RBP: 0000000000001733 R08: 0000000000000000 R09: 0000000000000000
>
>
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
