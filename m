Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61A91DF24B
	for <autofs@vger.kernel.org>; Thu,  6 Feb 2025 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738847430; cv=none; b=NiacmCH+SRnfmuylVzxMT5xKijOrn9IklvIJPRQWwBGTBVRJbjD1plU6NceBkAV2sDCn7dph4O+mHI3Ka1czzYbxRBC5ckRbVOEdqOsYcyR7KsUbkGsoNfgE15INQnwy4dkIa8dvPnQ+Hf1PFdx8riXuQlhtsHK8ibWGNbLpjiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738847430; c=relaxed/simple;
	bh=BqKXJw2WMOdZU5iC7tvdyi4IlWJX71D0llklOORJQhk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Z45XQUHoZG9jW1gxcNzfBwnp5uVQJCV90KG7/FugmevTDx0bbqUMoEoI/2FglevcKeBoAhaBbkckMI7CEPhI8HsEEL5yJZlwIxIt14ZV8iWVLQVs76UA210yRBfIuIAn53mVEMRO9VygNHC3gKZyfR9EUehzAHjSL4dJeNXgbJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-851a991cf8bso118526339f.0
        for <autofs@vger.kernel.org>; Thu, 06 Feb 2025 05:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738847427; x=1739452227;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jRvgeGS5Pprhy/uf5aZwgPEgOu/dT8OPUk3PYRcRF4w=;
        b=VtfdLYpiuEwZTpGVImEsakVb6elyWL/x4oyvbvpsCcfJK1DvuEZSKqB9A4QiRaCQFJ
         vkdQ+MNjqOwLIhxOehpiZ73qB4ieeJMO9Xn4N+MKx3ukOGiOra8uCJIs0po2suSJft+W
         CH8ESYIBd1zlpSstKtAre1PYdl40sY5dI1X/ggXZ/lQU+vlaPjgTJ+DrGUgnM1+xoNzV
         xLCPR1el61g1fbPRtPpCdBfHLwdUqevczEAsmzFXLFuNIOqRfmDwWNda8+Pg+US3XmVO
         V4akYVDRDnk7PIyrL7QLogBvqRi/lZm4KkIFs/4okvmIxyfHrQs+cRkrwc7GbKb9Wjeg
         voXw==
X-Gm-Message-State: AOJu0Yys6rjIikCeuSM/UnGN1IU1oKCJSsnoB6pqRS6q8LeqjLXUaoQM
	vN5EX03OGUEQyofh43tNri//nkqixpYQ70AZS5TbhSwT1qpZzzK3TWySdqbiKn4Sj51AmetTjRl
	TZ6cEuXhQ98am1dHQKmT1z7M7oMMo4P5JMef/cdlDZFtzm+Yiewv59kF0CA==
X-Google-Smtp-Source: AGHT+IFDvKdVp2YXYcvK5qDI/DYro+8EdMg3FGp11l6xTT7y7xAFZN2NQki0MqsNFqroD0PSsgEjloncvtlVjXI1bgUCFAsyLsjF
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c10b:0:b0:3ce:3541:d80f with SMTP id
 e9e14a558f8ab-3d05a424d1cmr24481725ab.0.1738847427672; Thu, 06 Feb 2025
 05:10:27 -0800 (PST)
Date: Thu, 06 Feb 2025 05:10:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a4b4c3.050a0220.264083.0007.GAE@google.com>
Subject: [syzbot] [autofs?] possible deadlock in autofs_notify_daemon (2)
From: syzbot <syzbot+8f1c85b6240c665f0c51@syzkaller.appspotmail.com>
To: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, raven@themaw.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    69e858e0b8b2 Merge tag 'uml-for-linus-6.14-rc1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=161f35f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=36c931489897af84
dashboard link: https://syzkaller.appspot.com/bug?extid=8f1c85b6240c665f0c51
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2ed318e5efa5/disk-69e858e0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8002a1e89099/vmlinux-69e858e0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d228768d8514/bzImage-69e858e0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8f1c85b6240c665f0c51@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.13.0-syzkaller-09760-g69e858e0b8b2 #0 Not tainted
------------------------------------------------------
syz.3.973/9608 is trying to acquire lock:
ffff888061861940 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_write fs/autofs/waitq.c:55 [inline]
ffff888061861940 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_notify_daemon+0x499/0xd50 fs/autofs/waitq.c:164

but task is already holding lock:
ffff88803370f488 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x27b/0x500 fs/kernfs/file.c:325

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&of->mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
       kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
       seq_read_iter+0x2ab/0x12b0 fs/seq_file.c:225
       kernfs_fop_read_iter+0x414/0x580 fs/kernfs/file.c:279
       new_sync_read fs/read_write.c:484 [inline]
       vfs_read+0x886/0xbf0 fs/read_write.c:565
       ksys_read+0x12b/0x250 fs/read_write.c:708
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&p->lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
       seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
       proc_reg_read_iter+0x118/0x310 fs/proc/inode.c:295
       copy_splice_read+0x61d/0xb80 fs/splice.c:365
       do_splice_read fs/splice.c:985 [inline]
       do_splice_read+0x282/0x370 fs/splice.c:959
       splice_file_to_pipe+0x109/0x120 fs/splice.c:1295
       do_sendfile+0x3fd/0xe40 fs/read_write.c:1369
       __do_sys_sendfile64 fs/read_write.c:1418 [inline]
       __se_sys_sendfile64 fs/read_write.c:1410 [inline]
       __x64_sys_sendfile64+0x155/0x220 fs/read_write.c:1410
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&pipe->mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
       pipe_write+0x166/0x1b30 fs/pipe.c:456
       __kernel_write_iter+0x71f/0xa90 fs/read_write.c:612
       __kernel_write+0xf6/0x140 fs/read_write.c:632
       autofs_write fs/autofs/waitq.c:57 [inline]
       autofs_notify_daemon+0x4ce/0xd50 fs/autofs/waitq.c:164
       autofs_wait+0x10b5/0x1a30 fs/autofs/waitq.c:426
       autofs_mount_wait+0x132/0x380 fs/autofs/root.c:255
       autofs_d_automount+0x390/0x7f0 fs/autofs/root.c:401
       follow_automount fs/namei.c:1454 [inline]
       __traverse_mounts+0x192/0x760 fs/namei.c:1499
       traverse_mounts fs/namei.c:1528 [inline]
       handle_mounts fs/namei.c:1631 [inline]
       step_into+0x593/0x2220 fs/namei.c:1952
       walk_component+0xfc/0x5b0 fs/namei.c:2120
       link_path_walk.part.0.constprop.0+0x669/0xd40 fs/namei.c:2479
       link_path_walk fs/namei.c:2410 [inline]
       path_lookupat+0x93/0x770 fs/namei.c:2635
       do_o_path fs/namei.c:3960 [inline]
       path_openat+0x1754/0x2d80 fs/namei.c:3982
       do_filp_open+0x20c/0x470 fs/namei.c:4016
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1427
       do_sys_open fs/open.c:1442 [inline]
       __do_sys_openat fs/open.c:1458 [inline]
       __se_sys_openat fs/open.c:1453 [inline]
       __x64_sys_openat+0x175/0x210 fs/open.c:1453
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&sbi->pipe_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3163 [inline]
       check_prevs_add kernel/locking/lockdep.c:3282 [inline]
       validate_chain kernel/locking/lockdep.c:3906 [inline]
       __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5228
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5851
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
       autofs_write fs/autofs/waitq.c:55 [inline]
       autofs_notify_daemon+0x499/0xd50 fs/autofs/waitq.c:164
       autofs_wait+0x10b5/0x1a30 fs/autofs/waitq.c:426
       autofs_mount_wait+0x132/0x380 fs/autofs/root.c:255
       autofs_d_automount+0x390/0x7f0 fs/autofs/root.c:401
       follow_automount fs/namei.c:1454 [inline]
       __traverse_mounts+0x192/0x760 fs/namei.c:1499
       traverse_mounts fs/namei.c:1528 [inline]
       handle_mounts fs/namei.c:1631 [inline]
       step_into+0x593/0x2220 fs/namei.c:1952
       walk_component+0xfc/0x5b0 fs/namei.c:2120
       lookup_last fs/namei.c:2612 [inline]
       path_lookupat+0x17f/0x770 fs/namei.c:2636
       filename_lookup+0x221/0x5f0 fs/namei.c:2665
       kern_path+0x35/0x50 fs/namei.c:2773
       lookup_bdev+0xd9/0x280 block/bdev.c:1163
       resume_store+0x1d8/0x460 kernel/power/hibernate.c:1247
       kobj_attr_store+0x55/0x80 lib/kobject.c:840
       sysfs_kf_write+0x117/0x170 fs/sysfs/file.c:139
       kernfs_fop_write_iter+0x33d/0x500 fs/kernfs/file.c:334
       new_sync_write fs/read_write.c:586 [inline]
       vfs_write+0x5ae/0x1150 fs/read_write.c:679
       ksys_write+0x12b/0x250 fs/read_write.c:731
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &sbi->pipe_mutex --> &p->lock --> &of->mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&of->mutex);
                               lock(&p->lock);
                               lock(&of->mutex);
  lock(&sbi->pipe_mutex);

 *** DEADLOCK ***

4 locks held by syz.3.973/9608:
 #0: ffff88807d610638 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1192
 #1: ffff888030718420 (sb_writers#9){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff88803370f488 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x27b/0x500 fs/kernfs/file.c:325
 #3: ffff888140ebd788 (kn->active#76){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x29e/0x500 fs/kernfs/file.c:326

stack backtrace:
CPU: 1 UID: 0 PID: 9608 Comm: syz.3.973 Not tainted 6.13.0-syzkaller-09760-g69e858e0b8b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x490/0x760 kernel/locking/lockdep.c:2076
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2208
 check_prev_add kernel/locking/lockdep.c:3163 [inline]
 check_prevs_add kernel/locking/lockdep.c:3282 [inline]
 validate_chain kernel/locking/lockdep.c:3906 [inline]
 __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5228
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5851
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
 autofs_write fs/autofs/waitq.c:55 [inline]
 autofs_notify_daemon+0x499/0xd50 fs/autofs/waitq.c:164
 autofs_wait+0x10b5/0x1a30 fs/autofs/waitq.c:426
 autofs_mount_wait+0x132/0x380 fs/autofs/root.c:255
 autofs_d_automount+0x390/0x7f0 fs/autofs/root.c:401
 follow_automount fs/namei.c:1454 [inline]
 __traverse_mounts+0x192/0x760 fs/namei.c:1499
 traverse_mounts fs/namei.c:1528 [inline]
 handle_mounts fs/namei.c:1631 [inline]
 step_into+0x593/0x2220 fs/namei.c:1952
 walk_component+0xfc/0x5b0 fs/namei.c:2120
 lookup_last fs/namei.c:2612 [inline]
 path_lookupat+0x17f/0x770 fs/namei.c:2636
 filename_lookup+0x221/0x5f0 fs/namei.c:2665
 kern_path+0x35/0x50 fs/namei.c:2773
 lookup_bdev+0xd9/0x280 block/bdev.c:1163
 resume_store+0x1d8/0x460 kernel/power/hibernate.c:1247
 kobj_attr_store+0x55/0x80 lib/kobject.c:840
 sysfs_kf_write+0x117/0x170 fs/sysfs/file.c:139
 kernfs_fop_write_iter+0x33d/0x500 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x5ae/0x1150 fs/read_write.c:679
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6d40f8cda9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6d41def038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f6d411a6160 RCX: 00007f6d40f8cda9
RDX: 0000000000000012 RSI: 00000000200000c0 RDI: 0000000000000006
RBP: 00007f6d4100e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f6d411a6160 R15: 00007ffd50927f88
 </TASK>
block device autoloading is deprecated and will be removed.
PM: Image not found (code -22)


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
