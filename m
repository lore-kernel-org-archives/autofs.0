Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AB528E5E4
	for <autofs@vger.kernel.org>; Fri,  9 May 2025 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746785428; cv=none; b=m26HieTLCETCga33cCSDwmLbzXdh2KHw4PHvHP3rqcXcsmyOkLgIKeTaSU1Pl2uv6IV+/qXPLY6LJcEA3lRUBd0mR6zpmPcI4EvYgABNQDCBXBa6S59A2lsiQP4E1zuAKihzHQCATnxuo59iEsHck+fDt4JUvH7+158ezIpzQoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746785428; c=relaxed/simple;
	bh=MWcHZN4Tnpd9NleOwcRsf738CIl68RyshheujKhARZ8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aB2vxF4rbSHTqzz0+270rEMwLW8vHvvJEfvBBb1LNMzqOv4Gg+WsJF+24vxE8sD2MzMmxFx4MH4XKCBnLRPteBHm0ofLgvf8mACp15rY+THmoROQcbZ4p/GPZ/fQkElP8JN7OFnisl930Oc3pESEivoJKy1O4YRyg04MLGEuA8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d922570570so22906205ab.3
        for <autofs@vger.kernel.org>; Fri, 09 May 2025 03:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746785425; x=1747390225;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n0lKQms4WA2Vd3mIlqw0q0UZ+Q2kxi4T8Yoi1K/CTqE=;
        b=I8FNICX7OS/TuWboxDyzhVR5T1EvhAL8fU+wTqUhhH3K4I2p3jRTC4cjLhGVkhUyow
         G0bEXL15X4T7GtN/cKbWvI3Ud/14tBH63dvoyQo9wfHcDonZlBuejTDh245cyWGvDnHl
         Rm4RlPUYf/qVSIjmZlJBrHASDTIMgB5/oER3AhRUljBM9M++mkxmaBI3qNPzYx/WE+jL
         sokX115UVIdbs2lffwkWgwM/hN9dgMvlWmQnWicd6Eqa53XDC2iQcM7ROY2YyrK27l6p
         yStXY8+HdUHiKhTjv82qFARubr8JkEjTNUcKvqhdFqsfHCxH8JLU9duxxaa4vkCiT/z9
         CQUQ==
X-Gm-Message-State: AOJu0YxCH6F4bw53R/JIanuJw2QLtb4kyYMVIktLdoHp/YB1hyV3CqlL
	JtBTlWReuFWb27STxRSperU8WU1Wt//bgsI4Kj01oM1soIjWtpf+nRp4IKevaCsP3GhLkq3/i6D
	jVbbCJsFeiGCtdd5VDfBw9lApLAqa1HVWcdT/FtHPKuKiID/C9hQ7Zx6Yyg==
X-Google-Smtp-Source: AGHT+IFrGPfr3JTIgZMK3aCNi4zdxIKNNyTklGUFCf3wg1uunylqBYOOdK4kZwhRoiWpsQZVSuQH6W+KA5lsaBwC+1bBGpxiR/sC
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2a:b0:3d6:d162:be12 with SMTP id
 e9e14a558f8ab-3da7e213504mr38059075ab.21.1746785425253; Fri, 09 May 2025
 03:10:25 -0700 (PDT)
Date: Fri, 09 May 2025 03:10:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <681dd491.050a0220.a19a9.012b.GAE@google.com>
Subject: [syzbot] [autofs?] possible deadlock in anon_pipe_write
From: syzbot <syzbot+247d7a192c296bf9769c@syzkaller.appspotmail.com>
To: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, raven@themaw.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0d8d44db295c Merge tag 'for-6.15-rc5-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1236fb68580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b39cb28b0a399ed3
dashboard link: https://syzkaller.appspot.com/bug?extid=247d7a192c296bf9769c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5536cda9f25f/disk-0d8d44db.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/92d52f7afb23/vmlinux-0d8d44db.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a31f0b2e7b87/bzImage-0d8d44db.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+247d7a192c296bf9769c@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.15.0-rc5-syzkaller-00032-g0d8d44db295c #0 Not tainted
------------------------------------------------------
syz.4.1562/14048 is trying to acquire lock:
ffff88807af9fc68 (&pipe->mutex){+.+.}-{4:4}, at: anon_pipe_write+0x15d/0x1a70 fs/pipe.c:459

but task is already holding lock:
ffff8880588b8140 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_write fs/autofs/waitq.c:55 [inline]
ffff8880588b8140 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_notify_daemon+0x4a6/0xd60 fs/autofs/waitq.c:164

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sbi->pipe_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:746
       autofs_write fs/autofs/waitq.c:55 [inline]
       autofs_notify_daemon+0x4a6/0xd60 fs/autofs/waitq.c:164
       autofs_wait+0x10ca/0x1a70 fs/autofs/waitq.c:426
       autofs_mount_wait+0x132/0x380 fs/autofs/root.c:255
       autofs_d_automount+0x390/0x7f0 fs/autofs/root.c:401
       follow_automount fs/namei.c:1455 [inline]
       __traverse_mounts+0x192/0x790 fs/namei.c:1500
       traverse_mounts fs/namei.c:1529 [inline]
       handle_mounts fs/namei.c:1632 [inline]
       step_into+0x5aa/0x2270 fs/namei.c:1976
       walk_component+0xfc/0x5b0 fs/namei.c:2144
       lookup_last fs/namei.c:2636 [inline]
       path_lookupat+0x17e/0x780 fs/namei.c:2660
       filename_lookup+0x224/0x5f0 fs/namei.c:2689
       kern_path+0x35/0x50 fs/namei.c:2822
       lookup_bdev+0xd8/0x280 block/bdev.c:1205
       resume_store+0x1d6/0x460 kernel/power/hibernate.c:1248
       kobj_attr_store+0x55/0x80 lib/kobject.c:840
       sysfs_kf_write+0xef/0x150 fs/sysfs/file.c:145
       kernfs_fop_write_iter+0x351/0x510 fs/kernfs/file.c:334
       new_sync_write fs/read_write.c:591 [inline]
       vfs_write+0x5ba/0x1180 fs/read_write.c:684
       ksys_write+0x12a/0x240 fs/read_write.c:736
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&of->mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:746
       kernfs_fop_write_iter+0x28f/0x510 fs/kernfs/file.c:325
       iter_file_splice_write+0x91c/0x1150 fs/splice.c:738
       do_splice_from fs/splice.c:935 [inline]
       do_splice+0x1475/0x1fc0 fs/splice.c:1348
       __do_splice+0x32a/0x360 fs/splice.c:1430
       __do_sys_splice fs/splice.c:1633 [inline]
       __se_sys_splice fs/splice.c:1615 [inline]
       __x64_sys_splice+0x187/0x250 fs/splice.c:1615
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&pipe->mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3166 [inline]
       check_prevs_add kernel/locking/lockdep.c:3285 [inline]
       validate_chain kernel/locking/lockdep.c:3909 [inline]
       __lock_acquire+0x1173/0x1ba0 kernel/locking/lockdep.c:5235
       lock_acquire kernel/locking/lockdep.c:5866 [inline]
       lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5823
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:746
       anon_pipe_write+0x15d/0x1a70 fs/pipe.c:459
       __kernel_write_iter+0x71d/0xa90 fs/read_write.c:617
       __kernel_write+0xf5/0x140 fs/read_write.c:637
       autofs_write fs/autofs/waitq.c:57 [inline]
       autofs_notify_daemon+0x4db/0xd60 fs/autofs/waitq.c:164
       autofs_wait+0x10ca/0x1a70 fs/autofs/waitq.c:426
       autofs_mount_wait+0x132/0x380 fs/autofs/root.c:255
       autofs_d_automount+0x390/0x7f0 fs/autofs/root.c:401
       follow_automount fs/namei.c:1455 [inline]
       __traverse_mounts+0x192/0x790 fs/namei.c:1500
       traverse_mounts fs/namei.c:1529 [inline]
       handle_mounts fs/namei.c:1632 [inline]
       step_into+0x5aa/0x2270 fs/namei.c:1976
       walk_component+0xfc/0x5b0 fs/namei.c:2144
       lookup_last fs/namei.c:2636 [inline]
       path_lookupat+0x17e/0x780 fs/namei.c:2660
       filename_lookup+0x224/0x5f0 fs/namei.c:2689
       user_path_at+0x3a/0x60 fs/namei.c:3120
       do_mount fs/namespace.c:4221 [inline]
       __do_sys_mount fs/namespace.c:4435 [inline]
       __se_sys_mount fs/namespace.c:4412 [inline]
       __x64_sys_mount+0x1fc/0x310 fs/namespace.c:4412
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
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

1 lock held by syz.4.1562/14048:
 #0: ffff8880588b8140 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_write fs/autofs/waitq.c:55 [inline]
 #0: ffff8880588b8140 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_notify_daemon+0x4a6/0xd60 fs/autofs/waitq.c:164

stack backtrace:
CPU: 1 UID: 0 PID: 14048 Comm: syz.4.1562 Not tainted 6.15.0-rc5-syzkaller-00032-g0d8d44db295c #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/29/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x275/0x350 kernel/locking/lockdep.c:2079
 check_noncircular+0x14c/0x170 kernel/locking/lockdep.c:2211
 check_prev_add kernel/locking/lockdep.c:3166 [inline]
 check_prevs_add kernel/locking/lockdep.c:3285 [inline]
 validate_chain kernel/locking/lockdep.c:3909 [inline]
 __lock_acquire+0x1173/0x1ba0 kernel/locking/lockdep.c:5235
 lock_acquire kernel/locking/lockdep.c:5866 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5823
 __mutex_lock_common kernel/locking/mutex.c:601 [inline]
 __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:746
 anon_pipe_write+0x15d/0x1a70 fs/pipe.c:459
 __kernel_write_iter+0x71d/0xa90 fs/read_write.c:617
 __kernel_write+0xf5/0x140 fs/read_write.c:637
 autofs_write fs/autofs/waitq.c:57 [inline]
 autofs_notify_daemon+0x4db/0xd60 fs/autofs/waitq.c:164
 autofs_wait+0x10ca/0x1a70 fs/autofs/waitq.c:426
 autofs_mount_wait+0x132/0x380 fs/autofs/root.c:255
 autofs_d_automount+0x390/0x7f0 fs/autofs/root.c:401
 follow_automount fs/namei.c:1455 [inline]
 __traverse_mounts+0x192/0x790 fs/namei.c:1500
 traverse_mounts fs/namei.c:1529 [inline]
 handle_mounts fs/namei.c:1632 [inline]
 step_into+0x5aa/0x2270 fs/namei.c:1976
 walk_component+0xfc/0x5b0 fs/namei.c:2144
 lookup_last fs/namei.c:2636 [inline]
 path_lookupat+0x17e/0x780 fs/namei.c:2660
 filename_lookup+0x224/0x5f0 fs/namei.c:2689
 user_path_at+0x3a/0x60 fs/namei.c:3120
 do_mount fs/namespace.c:4221 [inline]
 __do_sys_mount fs/namespace.c:4435 [inline]
 __se_sys_mount fs/namespace.c:4412 [inline]
 __x64_sys_mount+0x1fc/0x310 fs/namespace.c:4412
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faef658e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007faef7347038 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007faef67b5fa0 RCX: 00007faef658e969
RDX: 0000000000000000 RSI: 00002000000001c0 RDI: 0000000000000000
RBP: 00007faef6610ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000010000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007faef67b5fa0 R15: 00007ffeefd9fb38
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
