Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E178F33120C
	for <autofs@vger.kernel.org>; Fri, 17 Apr 2026 15:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776440853; cv=none; b=bJwCR1Af/S4qk4WDHqwZrYDuhTw5XsaldooXX/5NAm/rD41coit+YrsNFMsYlmDQWGx2NObqf+IJsQQbOH3rdMBE1YYLGmudFFuZuMU1bkxsl2NLZcPBGqyuxGfTahYmTRlypwYVj4VnrMWi4Q3L7ihZkMA2pDPDzX2PO5aBRS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776440853; c=relaxed/simple;
	bh=Nvrxc4jmEEXRGllkTSF9qjZx+a6uDxAOHtMTwgzSbaE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EoNs341d32g3Bq4XJn7+EqbPWfoeqBqRe7FyLLtQHPByjCHwWmNh0CJr1F4EJ8A/XQ1XINqyJbhabcDIjBz9oQ+Yh5tFh8Un7eUYY9vuq3mpn7Tc/gkBYWd+RMvYqr3R0927JxIzYDRIaKcLEjP/UL1mheEDZs6AzaSzSeBM/3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-688c232dd72so1215817eaf.1
        for <autofs@vger.kernel.org>; Fri, 17 Apr 2026 08:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776440851; x=1777045651;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cUt4GZQrLq2oUt8/SIsFIwmSMFLUamz2oX3iNG2Nn20=;
        b=kh610wmvlIqcB7tTsnbw8QXRJSDwo8L5mClWndtXXNlCGY0hGdbw6k5y31J/VfJcd4
         XuQ9xCLlHdCPCL5k3vuLENWmuABmEAYcTVeczn0abUsMdHxt5C+/jpykWFQ7fYYIdjH7
         7qzUX7eDCnJcVLWoC1Gg7Cpa+FIbZcXK4Y55m9s9Eb0vPTtsl9BysacKEW7pmulPXJyZ
         86pvA9Mco2km4Elwif7ZKsCwVpB6g01Kj9aeT0cZBK1Evm3m5ZK0NZ/sgy3F4+R554c8
         TQw9kZRXggO0DSTLUKyjvLx7S1aqvr/21WdhWwE94qLp2q+SO3I1Gpy4LCCMwteQIbxh
         fJtg==
X-Gm-Message-State: AOJu0YwyEuutr0hweZUDWVtrXojGpmDnTTIcxL/VR2RRnouObi3Eb37o
	e6nxtCq9wwS8TPUNdTt5Wi/S40RI6jR2ZeqrptU8ZEYNLG66xTRPo4pRrOsVYWs4mRWHser+UgO
	UEOlZXcBWj4od8uqdk6woe5sujbZeT6KQ2Vy+pAabEOIPED2lHFRV7kSHwma20w==
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:221c:b0:683:260d:afc0 with SMTP id
 006d021491bc7-69462ee702fmr1672418eaf.35.1776440850914; Fri, 17 Apr 2026
 08:47:30 -0700 (PDT)
Date: Fri, 17 Apr 2026 08:47:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e25612.a00a0220.1bd0ca.0005.GAE@google.com>
Subject: [syzbot] [autofs?] possible deadlock in anon_pipe_write (2)
From: syzbot <syzbot+459d8d87e3c2a46d4102@syzkaller.appspotmail.com>
To: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, raven@themaw.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    028ef9c96e96 Linux 7.0
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=147210ce580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a3e5e8c17cc174e
dashboard link: https://syzkaller.appspot.com/bug?extid=459d8d87e3c2a46d4102
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ec3fc4ab21e9/disk-028ef9c9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/edc0fd5a0fd3/vmlinux-028ef9c9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7c5a57bcdac7/bzImage-028ef9c9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+459d8d87e3c2a46d4102@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz-executor/5806 is trying to acquire lock:
ffff88807ab04868 (&pipe->mutex){+.+.}-{4:4}, at: anon_pipe_write+0x163/0x1d40 fs/pipe.c:458

but task is already holding lock:
ffff888033264948 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_write fs/autofs/waitq.c:55 [inline]
ffff888033264948 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_notify_daemon+0x4f8/0xd90 fs/autofs/waitq.c:164

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sbi->pipe_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x1a2/0x1b90 kernel/locking/mutex.c:776
       autofs_write fs/autofs/waitq.c:55 [inline]
       autofs_notify_daemon+0x4f8/0xd90 fs/autofs/waitq.c:164
       autofs_wait+0x10fd/0x1b50 fs/autofs/waitq.c:426
       autofs_mount_wait+0x132/0x3b0 fs/autofs/root.c:255
       autofs_d_automount+0x490/0x950 fs/autofs/root.c:409
       follow_automount fs/namei.c:1560 [inline]
       __traverse_mounts+0x1b9/0x8a0 fs/namei.c:1613
       traverse_mounts fs/namei.c:1642 [inline]
       handle_mounts fs/namei.c:1744 [inline]
       step_into_slowpath+0xb7e/0xf90 fs/namei.c:2101
       step_into fs/namei.c:2149 [inline]
       walk_component fs/namei.c:2285 [inline]
       lookup_last fs/namei.c:2786 [inline]
       path_lookupat+0x58b/0xc40 fs/namei.c:2810
       filename_lookup+0x202/0x590 fs/namei.c:2839
       kern_path+0x37/0x50 fs/namei.c:3046
       lookup_bdev+0xd8/0x280 block/bdev.c:1221
       resume_store+0x1d6/0x460 kernel/power/hibernate.c:1306
       kobj_attr_store+0x58/0x80 lib/kobject.c:840
       sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:142
       kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:352
       aio_write+0x3ba/0x920 fs/aio.c:1633
       __io_submit_one fs/aio.c:2005 [inline]
       io_submit_one+0x1142/0x1fb0 fs/aio.c:2052
       __do_sys_io_submit fs/aio.c:2111 [inline]
       __se_sys_io_submit fs/aio.c:2081 [inline]
       __x64_sys_io_submit+0x1b1/0x3a0 fs/aio.c:2081
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&of->mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x1a2/0x1b90 kernel/locking/mutex.c:776
       kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:343
       iter_file_splice_write+0x830/0x10a0 fs/splice.c:736
       do_splice_from fs/splice.c:936 [inline]
       do_splice+0x109c/0x1fd0 fs/splice.c:1349
       __do_splice+0x33b/0x370 fs/splice.c:1431
       __do_sys_splice fs/splice.c:1634 [inline]
       __se_sys_splice fs/splice.c:1616 [inline]
       __x64_sys_splice+0x187/0x250 fs/splice.c:1616
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&pipe->mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x14b8/0x2630 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1cf/0x380 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x1a2/0x1b90 kernel/locking/mutex.c:776
       anon_pipe_write+0x163/0x1d40 fs/pipe.c:458
       __kernel_write_iter+0x6b2/0x920 fs/read_write.c:621
       __kernel_write+0xf6/0x140 fs/read_write.c:641
       autofs_write fs/autofs/waitq.c:57 [inline]
       autofs_notify_daemon+0x50d/0xd90 fs/autofs/waitq.c:164
       autofs_wait+0x10fd/0x1b50 fs/autofs/waitq.c:426
       autofs_mount_wait+0x132/0x3b0 fs/autofs/root.c:255
       autofs_d_automount+0x490/0x950 fs/autofs/root.c:409
       follow_automount fs/namei.c:1560 [inline]
       __traverse_mounts+0x1b9/0x8a0 fs/namei.c:1613
       traverse_mounts fs/namei.c:1642 [inline]
       handle_mounts fs/namei.c:1744 [inline]
       step_into_slowpath+0xb7e/0xf90 fs/namei.c:2101
       step_into fs/namei.c:2149 [inline]
       open_last_lookups fs/namei.c:4624 [inline]
       path_openat+0xf95/0x31a0 fs/namei.c:4833
       do_file_open+0x20e/0x430 fs/namei.c:4865
       do_sys_openat2+0x10d/0x1e0 fs/open.c:1366
       do_sys_open fs/open.c:1372 [inline]
       __do_sys_openat fs/open.c:1388 [inline]
       __se_sys_openat fs/open.c:1383 [inline]
       __x64_sys_openat+0x12d/0x210 fs/open.c:1383
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &pipe->mutex --> &of->mutex --> &sbi->pipe_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sbi->pipe_mutex);
                               lock(&of->mutex);
                               lock(&sbi->pipe_mutex);
  lock(&pipe->mutex);

 *** DEADLOCK ***

1 lock held by syz-executor/5806:
 #0: ffff888033264948 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_write fs/autofs/waitq.c:55 [inline]
 #0: ffff888033264948 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_notify_daemon+0x4f8/0xd90 fs/autofs/waitq.c:164

stack backtrace:
CPU: 0 UID: 0 PID: 5806 Comm: syz-executor Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1c7 kernel/locking/lockdep.c:2043
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x14b8/0x2630 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x1cf/0x380 kernel/locking/lockdep.c:5825
 __mutex_lock_common kernel/locking/mutex.c:614 [inline]
 __mutex_lock+0x1a2/0x1b90 kernel/locking/mutex.c:776
 anon_pipe_write+0x163/0x1d40 fs/pipe.c:458
 __kernel_write_iter+0x6b2/0x920 fs/read_write.c:621
 __kernel_write+0xf6/0x140 fs/read_write.c:641
 autofs_write fs/autofs/waitq.c:57 [inline]
 autofs_notify_daemon+0x50d/0xd90 fs/autofs/waitq.c:164
 autofs_wait+0x10fd/0x1b50 fs/autofs/waitq.c:426
 autofs_mount_wait+0x132/0x3b0 fs/autofs/root.c:255
 autofs_d_automount+0x490/0x950 fs/autofs/root.c:409
 follow_automount fs/namei.c:1560 [inline]
 __traverse_mounts+0x1b9/0x8a0 fs/namei.c:1613
 traverse_mounts fs/namei.c:1642 [inline]
 handle_mounts fs/namei.c:1744 [inline]
 step_into_slowpath+0xb7e/0xf90 fs/namei.c:2101
 step_into fs/namei.c:2149 [inline]
 open_last_lookups fs/namei.c:4624 [inline]
 path_openat+0xf95/0x31a0 fs/namei.c:4833
 do_file_open+0x20e/0x430 fs/namei.c:4865
 do_sys_openat2+0x10d/0x1e0 fs/open.c:1366
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x12d/0x210 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f757039bb3c
Code: 4c 89 54 24 18 41 89 f2 41 83 e2 40 75 40 89 f0 f7 d0 a9 00 00 41 00 74 35 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff ff 0f 05 <48> 3d 00 f0 ff ff 77 44 48 8b 54 24 18 64 48 2b 14 25 28 00 00 00
RSP: 002b:00007ffe92381580 EFLAGS: 00000206 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f7570432048 RCX: 00007f757039bb3c
RDX: 0000000000090800 RSI: 00007ffe92382790 RDI: 00000000ffffff9c
RBP: 00007ffe92382790 R08: 00007ffe92383790 R09: 00000000ffffffff
R10: 0000000000000000 R11: 0000000000000206 R12: 00007ffe92382790
R13: 00007f7570432048 R14: 00000000000d5761 R15: 00007ffe92384950
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
