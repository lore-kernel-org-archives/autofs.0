Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419EB10A1F
	for <autofs@vger.kernel.org>; Sun, 21 Jul 2024 23:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721606243; cv=none; b=DQenI4mqT3P+CSHtGELCwCKuuCBr5icFQNGfLXI7F88jzsJUplRm0Ym0uKaruBRjdO/enNgIbSqkwAGEN1hTmWpn2fs3IOA/cCKnKs4rZ2WyRKSQQFpXA48qghMDklAHMq0hsizFyzEO82OKGJobW2WG43tbQiRe3Kt25y5wi1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721606243; c=relaxed/simple;
	bh=INHtNTzNMzH/2JVhoP4a39XiQc+0TPE56n8FibHeFRo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=o9stgOHkqz3vkZtpmA9SRgclN6DAx9674FLB/2Leig1vEbq5aQuJ1De4IRJ42WdsFIatXpJBBROtQQQ0HfUUjRiSj5E7bMp5sHVu/S2nxVNqjwlCM9ICIGE+BIVR14XdZlEtG8OXGSIk54bpqGBLaqMrRHEDGUIAWgLVWBkwY2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-398a01542e2so25755375ab.3
        for <autofs@vger.kernel.org>; Sun, 21 Jul 2024 16:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721606241; x=1722211041;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8XfRfjBg0+bRQqFFfQqkJw4fwE58QxAQkhxaV98l3QQ=;
        b=GNGb6x7d26hi0FweQTHDaa5ZsWhnBSk//HVmrMdBm/FakAM7+2V+tq3DmwaktDJTm7
         XwhQv64Jil5yyf99IRlo2GZTxhXT+nz/gZT7qRo14zSJrx275nUJ03KD08+jJw3UFb4a
         ibbIjCzZRurUC2+p0lEU4M/tRG/Ql805SrcvCXAOjKgUj+A6d6KyZ0U+O4xKMXRSQMW8
         om1lNlmRvDTOgJhlNCL5DolpWjEoKX/FHk6KhFleBplXOhjIjYG2cOrqNb+7HBQ7KXTv
         +LUB9iJTDkWqIJwJ1MhG7GP0bwApY0EcP+mNXHZOYHZahc8LBh+rGvbOiOVeo5VJNAv9
         LmtQ==
X-Gm-Message-State: AOJu0YzWOUPZAkwic/W6kn2Lv2kZD3Ue7HZM5Lzj4YM/Oa+qVJUvPXkY
	SABhjad/WNqTz9gbR2WxaprGEl4lV+CgUQStHS8D9at9hyMQd+nF1OO4WhmtKrQ1bD7YhtSzqSr
	KA0dn/lE2EI0c9J8x2jBpAHSiMv+QdoWelx4VWy4eaSDrOOfU9KhiFuE=
X-Google-Smtp-Source: AGHT+IGSmeSFQnUw+NrbBPzRahpDTiGiio1NujP6AaeDe/CozQM5OnCuFbpkUdnuTGlK26+eGILHJ6xZJl28cCjA2cXNpSyZLKPW
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cf:b0:396:ec3b:df63 with SMTP id
 e9e14a558f8ab-398e782180cmr3003405ab.4.1721606241363; Sun, 21 Jul 2024
 16:57:21 -0700 (PDT)
Date: Sun, 21 Jul 2024 16:57:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000075b674061dcab0d5@google.com>
Subject: [syzbot] [autofs?] possible deadlock in autofs_notify_daemon
From: syzbot <syzbot+0d4e0978aa13f9e1db55@syzkaller.appspotmail.com>
To: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, raven@themaw.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d7e78951a8b8 Merge tag 'net-6.11-rc0' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1642f7a5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2602dfd9213d734c
dashboard link: https://syzkaller.appspot.com/bug?extid=0d4e0978aa13f9e1db55
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cdd2c14644df/disk-d7e78951.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7f9c9ab39b87/vmlinux-d7e78951.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1fc3658770e2/bzImage-d7e78951.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0d4e0978aa13f9e1db55@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.10.0-syzkaller-09703-gd7e78951a8b8 #0 Not tainted
------------------------------------------------------
syz.3.4748/19551 is trying to acquire lock:
ffff888059b0d940 (&sbi->pipe_mutex){+.+.}-{3:3}, at: autofs_write fs/autofs/waitq.c:55 [inline]
ffff888059b0d940 (&sbi->pipe_mutex){+.+.}-{3:3}, at: autofs_notify_daemon+0x71f/0xf80 fs/autofs/waitq.c:164

but task is already holding lock:
ffff8880758e7888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1eb/0x500 fs/kernfs/file.c:325

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&of->mutex){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       kernfs_fop_write_iter+0x1eb/0x500 fs/kernfs/file.c:325
       iter_file_splice_write+0xbd7/0x14e0 fs/splice.c:743
       do_splice_from fs/splice.c:941 [inline]
       do_splice+0xd77/0x1900 fs/splice.c:1354
       __do_splice fs/splice.c:1436 [inline]
       __do_sys_splice fs/splice.c:1652 [inline]
       __se_sys_splice+0x331/0x4a0 fs/splice.c:1634
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&pipe->mutex){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       pipe_write+0x1c9/0x1a40 fs/pipe.c:455
       __kernel_write_iter+0x47e/0x900 fs/read_write.c:523
       __kernel_write+0x120/0x180 fs/read_write.c:543
       autofs_write fs/autofs/waitq.c:57 [inline]
       autofs_notify_daemon+0x732/0xf80 fs/autofs/waitq.c:164
       autofs_wait+0x10b8/0x1b30 fs/autofs/waitq.c:426
       autofs_do_expire_multi+0x659/0x950 fs/autofs/expire.c:590
       autofs_root_ioctl+0x4c/0x60 fs/autofs/root.c:910
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:907 [inline]
       __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&sbi->pipe_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
       __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       autofs_write fs/autofs/waitq.c:55 [inline]
       autofs_notify_daemon+0x71f/0xf80 fs/autofs/waitq.c:164
       autofs_wait+0x10b8/0x1b30 fs/autofs/waitq.c:426
       autofs_mount_wait+0x170/0x330 fs/autofs/root.c:255
       autofs_d_automount+0x555/0x710 fs/autofs/root.c:401
       follow_automount fs/namei.c:1394 [inline]
       __traverse_mounts+0x2ba/0x580 fs/namei.c:1439
       traverse_mounts fs/namei.c:1468 [inline]
       handle_mounts fs/namei.c:1571 [inline]
       step_into+0x5e5/0x1080 fs/namei.c:1877
       lookup_last fs/namei.c:2542 [inline]
       path_lookupat+0x16f/0x450 fs/namei.c:2566
       filename_lookup+0x256/0x610 fs/namei.c:2595
       kern_path+0x35/0x50 fs/namei.c:2703
       lookup_bdev+0xc5/0x290 block/bdev.c:1157
       resume_store+0x1a0/0x710 kernel/power/hibernate.c:1235
       kernfs_fop_write_iter+0x3a1/0x500 fs/kernfs/file.c:334
       iter_file_splice_write+0xbd7/0x14e0 fs/splice.c:743
       do_splice_from fs/splice.c:941 [inline]
       direct_splice_actor+0x11e/0x220 fs/splice.c:1164
       splice_direct_to_actor+0x58e/0xc90 fs/splice.c:1108
       do_splice_direct_actor fs/splice.c:1207 [inline]
       do_splice_direct+0x28c/0x3e0 fs/splice.c:1233
       do_sendfile+0x56d/0xe20 fs/read_write.c:1295
       __do_sys_sendfile64 fs/read_write.c:1362 [inline]
       __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1348
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &sbi->pipe_mutex --> &pipe->mutex --> &of->mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&of->mutex);
                               lock(&pipe->mutex);
                               lock(&of->mutex);
  lock(&sbi->pipe_mutex);

 *** DEADLOCK ***

3 locks held by syz.3.4748/19551:
 #0: ffff88801e524420 (sb_writers#8){.+.+}-{0:0}, at: direct_splice_actor+0x49/0x220 fs/splice.c:1163
 #1: ffff8880758e7888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1eb/0x500 fs/kernfs/file.c:325
 #2: ffff888017adb4b8 (kn->active#65){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20f/0x500 fs/kernfs/file.c:326

stack backtrace:
CPU: 1 PID: 19551 Comm: syz.3.4748 Not tainted 6.10.0-syzkaller-09703-gd7e78951a8b8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 autofs_write fs/autofs/waitq.c:55 [inline]
 autofs_notify_daemon+0x71f/0xf80 fs/autofs/waitq.c:164
 autofs_wait+0x10b8/0x1b30 fs/autofs/waitq.c:426
 autofs_mount_wait+0x170/0x330 fs/autofs/root.c:255
 autofs_d_automount+0x555/0x710 fs/autofs/root.c:401
 follow_automount fs/namei.c:1394 [inline]
 __traverse_mounts+0x2ba/0x580 fs/namei.c:1439
 traverse_mounts fs/namei.c:1468 [inline]
 handle_mounts fs/namei.c:1571 [inline]
 step_into+0x5e5/0x1080 fs/namei.c:1877
 lookup_last fs/namei.c:2542 [inline]
 path_lookupat+0x16f/0x450 fs/namei.c:2566
 filename_lookup+0x256/0x610 fs/namei.c:2595
 kern_path+0x35/0x50 fs/namei.c:2703
 lookup_bdev+0xc5/0x290 block/bdev.c:1157
 resume_store+0x1a0/0x710 kernel/power/hibernate.c:1235
 kernfs_fop_write_iter+0x3a1/0x500 fs/kernfs/file.c:334
 iter_file_splice_write+0xbd7/0x14e0 fs/splice.c:743
 do_splice_from fs/splice.c:941 [inline]
 direct_splice_actor+0x11e/0x220 fs/splice.c:1164
 splice_direct_to_actor+0x58e/0xc90 fs/splice.c:1108
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x28c/0x3e0 fs/splice.c:1233
 do_sendfile+0x56d/0xe20 fs/read_write.c:1295
 __do_sys_sendfile64 fs/read_write.c:1362 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1348
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f75ec575b59
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f75ebfde048 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f75ec706038 RCX: 00007f75ec575b59
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000004
RBP: 00007f75ec5e4e5d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f75ec706038 R15: 00007ffef2866ed8
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
