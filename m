Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A37207A18
	for <autofs@vger.kernel.org>; Wed,  5 Feb 2025 22:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738794144; cv=none; b=NvVjEL62L/2JZXyPUB5wWc1OJr5sxM/m7x6yZA/5UqsY7PlJLoKfuDDlOybrKlbT5N8zwKQqA63gqq4193HPzT2XcYLSy52VBR2vgemT8dfue6JzCLV/uZIxuqJeXOU0QNgSh9PbtYiL81ss468zVo7pwieJMNIkJeCaP123yrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738794144; c=relaxed/simple;
	bh=bJFLp0XeWoy0Wbj14E0G32xDLGx8rBdaR0tauL5LNmU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pVlokepGoT+kD4KQNn91BFHqimGlOf63jxbgIItj6w/iSI/HLSo5pMhsndqja491H8H9p4/iFTBH7noGExuRJ85fT2HnHAE6mMpVx2P5zO1LUUVjt+EgUAkna7ok4JjqfuJTU5zkDL0X1hOfhC1RFczHTVT+cNRBZJ7xxmvmS5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d046dc219dso1848205ab.1
        for <autofs@vger.kernel.org>; Wed, 05 Feb 2025 14:22:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738794142; x=1739398942;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=avAw4ndW1Mba+XlAfaMHMADvM10uoCqU4hpvq784fbw=;
        b=glO5XdN2LsgjklCkp8VmcDuupfumNJAta75kW8WbYyadPmjpTmJvcbQDrKpXMlSjUv
         Ee5U1C8fLm3kcgCxliDbIkKFHKTK6eRyLtcWm1iXkyNLmKGpWY5/Y1Krk8t9eBZANv++
         Mk9qagFFdCxjp9ra9JFKOpPkbKSXpLeNpBD3ItPEAg4G8xahueaJrdOPHwuk5vr5VoGf
         c+GtA+gvxbugNZjE1bQm/Qu1gCld1dVWB5HYOhmaITLyDfkCu47agd3SpRZIVBwAnGuF
         PGuWKgtk/yRsqI9h/FfRRerQhSnpQY8pCHpRdGjX7BEH4gWBlyqXjUmZusiu0S6QlQM2
         MHsA==
X-Gm-Message-State: AOJu0YyQUaan474LgRTIri6WMkblUlfSj3tgPk2VqyiXdAIVDXSDUv0L
	oogWnWnIn18xGWgPjxJMo6o4ylaF2l5+TtGn8DNEq6RAEX+X9cPtZsRJggRU9JxbZ866OL94Q1W
	L8QeO+w9bR8My+EDbTdPVReYXFQdEJ946SQuptXb+hkAI+pJ/6SZUWE60gg==
X-Google-Smtp-Source: AGHT+IGwUqYYLWvK4yfvYFIaFjyq97vE5KTxe7rnR/C7y8lPlKntf43pmuN1Gyx2ysJNWfrr8m+Am/QZgN58vRBT3P6GaLEgjl1i
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3309:b0:3cf:fc11:90ca with SMTP id
 e9e14a558f8ab-3d04f42561emr45209305ab.6.1738794141784; Wed, 05 Feb 2025
 14:22:21 -0800 (PST)
Date: Wed, 05 Feb 2025 14:22:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a3e49d.050a0220.19061f.05f0.GAE@google.com>
Subject: [syzbot] [autofs?] possible deadlock in pipe_write (2)
From: syzbot <syzbot+25dd3743576b83be4773@syzkaller.appspotmail.com>
To: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, raven@themaw.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    69e858e0b8b2 Merge tag 'uml-for-linus-6.14-rc1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15d2fddf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57ab43c279fa614d
dashboard link: https://syzkaller.appspot.com/bug?extid=25dd3743576b83be4773
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7b9951b25c33/disk-69e858e0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3814bbc0e86f/vmlinux-69e858e0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/da44e7be7454/bzImage-69e858e0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+25dd3743576b83be4773@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.13.0-syzkaller-09760-g69e858e0b8b2 #0 Not tainted
------------------------------------------------------
syz.1.2997/15256 is trying to acquire lock:
ffff888011f30468 (&pipe->mutex){+.+.}-{4:4}, at: pipe_write+0x1c6/0x1a30 fs/pipe.c:456

but task is already holding lock:
ffff888022e95140 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_write fs/autofs/waitq.c:55 [inline]
ffff888022e95140 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_notify_daemon+0x71a/0xf70 fs/autofs/waitq.c:164

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sbi->pipe_mutex){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19c/0x1010 kernel/locking/mutex.c:730
       autofs_write fs/autofs/waitq.c:55 [inline]
       autofs_notify_daemon+0x71a/0xf70 fs/autofs/waitq.c:164
       autofs_wait+0x10b8/0x1b30 fs/autofs/waitq.c:426
       autofs_mount_wait+0x170/0x330 fs/autofs/root.c:255
       autofs_d_automount+0x555/0x710 fs/autofs/root.c:401
       follow_automount fs/namei.c:1454 [inline]
       __traverse_mounts+0x2ba/0x580 fs/namei.c:1499
       traverse_mounts fs/namei.c:1528 [inline]
       handle_mounts fs/namei.c:1631 [inline]
       step_into+0x5e5/0x10b0 fs/namei.c:1952
       lookup_last fs/namei.c:2612 [inline]
       path_lookupat+0x16f/0x450 fs/namei.c:2636
       filename_lookup+0x2a3/0x670 fs/namei.c:2665
       kern_path+0x35/0x50 fs/namei.c:2773
       lookup_bdev+0xc5/0x290 block/bdev.c:1163
       resume_store+0x1a0/0x710 kernel/power/hibernate.c:1247
       kernfs_fop_write_iter+0x3a0/0x500 fs/kernfs/file.c:334
       new_sync_write fs/read_write.c:586 [inline]
       vfs_write+0xacf/0xd10 fs/read_write.c:679
       ksys_write+0x18f/0x2b0 fs/read_write.c:731
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&of->mutex){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19c/0x1010 kernel/locking/mutex.c:730
       kernfs_fop_write_iter+0x1ea/0x500 fs/kernfs/file.c:325
       iter_file_splice_write+0xbfa/0x1510 fs/splice.c:743
       do_splice_from fs/splice.c:941 [inline]
       do_splice+0xd68/0x18b0 fs/splice.c:1354
       __do_splice fs/splice.c:1436 [inline]
       __do_sys_splice fs/splice.c:1639 [inline]
       __se_sys_splice+0x2e0/0x450 fs/splice.c:1621
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&pipe->mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3163 [inline]
       check_prevs_add kernel/locking/lockdep.c:3282 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3906
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5228
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19c/0x1010 kernel/locking/mutex.c:730
       pipe_write+0x1c6/0x1a30 fs/pipe.c:456
       __kernel_write_iter+0x4b3/0x950 fs/read_write.c:612
       __kernel_write+0x120/0x180 fs/read_write.c:632
       autofs_write fs/autofs/waitq.c:57 [inline]
       autofs_notify_daemon+0x72d/0xf70 fs/autofs/waitq.c:164
       autofs_wait+0x10b8/0x1b30 fs/autofs/waitq.c:426
       autofs_mount_wait+0x170/0x330 fs/autofs/root.c:255
       autofs_d_automount+0x555/0x710 fs/autofs/root.c:401
       follow_automount fs/namei.c:1454 [inline]
       __traverse_mounts+0x2ba/0x580 fs/namei.c:1499
       traverse_mounts fs/namei.c:1528 [inline]
       handle_mounts fs/namei.c:1631 [inline]
       step_into+0x5e5/0x10b0 fs/namei.c:1952
       lookup_last fs/namei.c:2612 [inline]
       path_lookupat+0x16f/0x450 fs/namei.c:2636
       filename_lookup+0x2a3/0x670 fs/namei.c:2665
       kern_path+0x35/0x50 fs/namei.c:2773
       lookup_bdev+0xc5/0x290 block/bdev.c:1163
       resume_store+0x1a0/0x710 kernel/power/hibernate.c:1247
       kernfs_fop_write_iter+0x3a0/0x500 fs/kernfs/file.c:334
       new_sync_write fs/read_write.c:586 [inline]
       vfs_write+0xacf/0xd10 fs/read_write.c:679
       ksys_write+0x18f/0x2b0 fs/read_write.c:731
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
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

5 locks held by syz.1.2997/15256:
 #0: ffff888030adcd38 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x254/0x320 fs/file.c:1192
 #1: ffff8880359fa420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3023 [inline]
 #1: ffff8880359fa420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x225/0xd10 fs/read_write.c:675
 #2: ffff88804665a888 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1ea/0x500 fs/kernfs/file.c:325
 #3: ffff8881412ffa58 (kn->active#59){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20e/0x500 fs/kernfs/file.c:326
 #4: ffff888022e95140 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_write fs/autofs/waitq.c:55 [inline]
 #4: ffff888022e95140 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_notify_daemon+0x71a/0xf70 fs/autofs/waitq.c:164

stack backtrace:
CPU: 1 UID: 0 PID: 15256 Comm: syz.1.2997 Not tainted 6.13.0-syzkaller-09760-g69e858e0b8b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2076
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2208
 check_prev_add kernel/locking/lockdep.c:3163 [inline]
 check_prevs_add kernel/locking/lockdep.c:3282 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3906
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5228
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x19c/0x1010 kernel/locking/mutex.c:730
 pipe_write+0x1c6/0x1a30 fs/pipe.c:456
 __kernel_write_iter+0x4b3/0x950 fs/read_write.c:612
 __kernel_write+0x120/0x180 fs/read_write.c:632
 autofs_write fs/autofs/waitq.c:57 [inline]
 autofs_notify_daemon+0x72d/0xf70 fs/autofs/waitq.c:164
 autofs_wait+0x10b8/0x1b30 fs/autofs/waitq.c:426
 autofs_mount_wait+0x170/0x330 fs/autofs/root.c:255
 autofs_d_automount+0x555/0x710 fs/autofs/root.c:401
 follow_automount fs/namei.c:1454 [inline]
 __traverse_mounts+0x2ba/0x580 fs/namei.c:1499
 traverse_mounts fs/namei.c:1528 [inline]
 handle_mounts fs/namei.c:1631 [inline]
 step_into+0x5e5/0x10b0 fs/namei.c:1952
 lookup_last fs/namei.c:2612 [inline]
 path_lookupat+0x16f/0x450 fs/namei.c:2636
 filename_lookup+0x2a3/0x670 fs/namei.c:2665
 kern_path+0x35/0x50 fs/namei.c:2773
 lookup_bdev+0xc5/0x290 block/bdev.c:1163
 resume_store+0x1a0/0x710 kernel/power/hibernate.c:1247
 kernfs_fop_write_iter+0x3a0/0x500 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xacf/0xd10 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f504898cda9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f50498d2038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f5048ba5fa0 RCX: 00007f504898cda9
RDX: 0000000000000012 RSI: 0000000020000000 RDI: 0000000000000008
RBP: 00007f5048a0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f5048ba5fa0 R15: 00007ffe28e15a78
 </TASK>
PM: Image not found (code -6)


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
