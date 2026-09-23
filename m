Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0B4495050
	for <autofs@vger.kernel.org>; Wed, 23 Sep 2026 11:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161593; cv=none; b=UCqoLZRay2IEWEo3MnmVWh1bxjfaYqUX/SE+eGVGZPMDrDa2C6agujEI7WOLyqKQ8wQcc0QOVTimliDC8XHoxOKVoKRPcC7JxOI+sf01Y2UR/HUezPfAki1+YmlAgMtOVsYGDq0BUqGNh0eqOzILdpmWV0E1F7L8SxIYJRyJD2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161593; c=relaxed/simple;
	bh=A81CnD//LelK+rpDTgG70N+3T49ZnBLB+VHdPi3TpwM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S+MAh54bl91M3FrMG185Fmc6Pkg3XfXLm4QLmgeLKkKIXb5nwDH7i3ITPy9+M8EViJcbLp9J8i/m+4/4p5EYM3Cgzut6jslWIbIAKqfZKWb4xs+wDuql4BaXKtHSIfVo2Rz9dJ76v42EaI85RED3oXhZTC6ToSJxsQ0cKc2N0yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f10.google.com with SMTP id 5614622812f47-4c9a4910efeso164598b6e.0
        for <autofs@vger.kernel.org>; Wed, 23 Sep 2026 04:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790161591; x=1790766391;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JZG5zIGQty22IAFkW8fqWEpwWaN0Bixa8GTPSWd2FpA=;
        b=xRRqJKqeCyQYw45JiSZZZz9IBDfQ6zTAozHpodxXbrb6OsHCSlyYleoo1uV18cSiv1
         +FcFjcw7FVYK3FDNi3UBowxI9EEUYitBMN+wIymyDjO7zn/OmFeyb9/Eva4N4xa1xppm
         ggCj47xfFTZqKQy6UYaIspowr283DqBbYObiMxDJ+gEierdM79Y4oQ68xslrCopFDw7u
         PKd+1SJAwsDhqnrWrMFxRirDTGZpiYLPJmctTXvCYulqCU+jbtkSJyxDp8Kb8n1W9n6L
         BdJK2sM+eotaAyc4PokjeWKAlX2vr2ZiIhTwz5gWwBXgD34bJOleWC6tNtj3P7+hUZ5H
         +yJg==
X-Gm-Message-State: AFuF++nE0A6ldxhmCFZDd4AodZ0l9wNlfG97xeV4WaVESfWJCZHdHkE6
	g5BVKjcB3l1eY6yt+lNg3KDQCsMnDIFJjomCLvcqg9qqyAnDuG6L2jtspLViXG7zDSjt07JmZ6C
	pqeftZD64js2wzuseVhhpLtsVlRHsnfF1WeKH9Vej5MtIHBb6hu7S3XuS81mK/w==
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:ee0c:0:b0:6c9:e0a0:af1b with SMTP id
 006d021491bc7-6d2d034451bmr1816366eaf.27.1790161591082; Wed, 23 Sep 2026
 04:06:31 -0700 (PDT)
Date: Wed, 23 Sep 2026 04:06:31 -0700
In-Reply-To: <6aa23178.f81106d8.2ab401.0006.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab3b2b7.a6af0033.177e91.0026.GAE@google.com>
Subject: Re: [syzbot] [autofs?] possible deadlock in anon_pipe_prefill_and_lock
From: syzbot <syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com>
To: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, raven@themaw.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    fe2ec83746e5 Merge tag 'hid-for-linus-2026092202' of git:/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16b78d25580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d012d9c67977ee4
dashboard link: https://syzkaller.appspot.com/bug?extid=002fb7b2d0bc53bf7e75
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14854405580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c0f4c9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cd25f1c33d2a/disk-fe2ec837.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2c35e3694ae6/vmlinux-fe2ec837.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1ff8b2a62fde/bzImage-fe2ec837.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz-executor105/5614 is trying to acquire lock:
ffff888037550c60 (&pipe->mutex){+.+.}-{4:4}, at: anon_pipe_prefill_and_lock+0x16c/0x580 fs/pipe.c:165

but task is already holding lock:
ffff8880247ac938 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_write fs/autofs/waitq.c:55 [inline]
ffff8880247ac938 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_notify_daemon+0x4f8/0xd90 fs/autofs/waitq.c:164

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sbi->pipe_mutex){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       autofs_write fs/autofs/waitq.c:55 [inline]
       autofs_notify_daemon+0x4f8/0xd90 fs/autofs/waitq.c:164
       autofs_wait+0x10fd/0x1b50 fs/autofs/waitq.c:426
       autofs_mount_wait+0x132/0x3b0 fs/autofs/root.c:256
       autofs_d_automount+0x490/0x950 fs/autofs/root.c:410
       follow_automount fs/namei.c:1565 [inline]
       __traverse_mounts+0x1b9/0x8a0 fs/namei.c:1618
       traverse_mounts fs/namei.c:1647 [inline]
       handle_mounts fs/namei.c:1749 [inline]
       step_into_slowpath+0xb7e/0xf90 fs/namei.c:2104
       step_into fs/namei.c:2152 [inline]
       walk_component fs/namei.c:2288 [inline]
       lookup_last fs/namei.c:2789 [inline]
       path_lookupat+0x58b/0xc40 fs/namei.c:2813
       filename_lookup+0x202/0x590 fs/namei.c:2842
       kern_path+0x37/0x50 fs/namei.c:3036
       lookup_bdev+0xd8/0x2a0 block/bdev.c:1268
       resume_store+0x1d6/0x460 kernel/power/hibernate.c:1278
       kobj_attr_store+0x58/0x80 lib/kobject.c:842
       sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
       kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6af/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&of->mutex){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
       iter_file_splice_write+0x830/0x10b0 fs/splice.c:736
       do_splice_from fs/splice.c:936 [inline]
       do_splice+0x109c/0x1fa0 fs/splice.c:1349
       __do_splice+0x33b/0x370 fs/splice.c:1431
       __do_sys_splice fs/splice.c:1634 [inline]
       __se_sys_splice fs/splice.c:1616 [inline]
       __x64_sys_splice+0x187/0x250 fs/splice.c:1616
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&pipe->mutex){+.+.}-{4:4}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3209
       check_prevs_add kernel/locking/lockdep.c:3328 [inline]
       validate_chain kernel/locking/lockdep.c:3952 [inline]
       __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       anon_pipe_prefill_and_lock+0x16c/0x580 fs/pipe.c:165
       anon_pipe_write+0x164/0x1b50 fs/pipe.c:534
       __kernel_write_iter+0x6bb/0x930 fs/read_write.c:621
       __kernel_write+0xf6/0x140 fs/read_write.c:641
       autofs_write fs/autofs/waitq.c:57 [inline]
       autofs_notify_daemon+0x50d/0xd90 fs/autofs/waitq.c:164
       autofs_wait+0x10fd/0x1b50 fs/autofs/waitq.c:426
       autofs_mount_wait+0x132/0x3b0 fs/autofs/root.c:256
       autofs_d_automount+0x490/0x950 fs/autofs/root.c:410
       follow_automount fs/namei.c:1565 [inline]
       __traverse_mounts+0x1b9/0x8a0 fs/namei.c:1618
       traverse_mounts fs/namei.c:1647 [inline]
       handle_mounts fs/namei.c:1749 [inline]
       step_into_slowpath+0xb7e/0xf90 fs/namei.c:2104
       step_into fs/namei.c:2152 [inline]
       walk_component fs/namei.c:2288 [inline]
       lookup_last fs/namei.c:2789 [inline]
       path_lookupat+0x58b/0xc40 fs/namei.c:2813
       filename_lookup+0x202/0x590 fs/namei.c:2842
       kern_path+0x37/0x50 fs/namei.c:3036
       lookup_bdev+0xd8/0x2a0 block/bdev.c:1268
       resume_store+0x1d6/0x460 kernel/power/hibernate.c:1278
       kobj_attr_store+0x58/0x80 lib/kobject.c:842
       sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
       kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6af/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
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

locks held by syz-executor105/5614: 4, last CPU#0:
 #0: ffff888037ff0460 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #1: ffff8880781ea480 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
 #2: ffff888020adbe18 (kn->active#57){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #2: ffff888020adbe18 (kn->active#57){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x332/0x5f0 fs/kernfs/file.c:337
 #3: ffff8880247ac938 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_write fs/autofs/waitq.c:55 [inline]
 #3: ffff8880247ac938 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_notify_daemon+0x4f8/0xd90 fs/autofs/waitq.c:164

stack backtrace:
CPU: 0 UID: 0 PID: 5614 Comm: syz-executor105 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/05/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1be kernel/locking/lockdep.c:2087
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2219
 check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3209
 check_prevs_add kernel/locking/lockdep.c:3328 [inline]
 validate_chain kernel/locking/lockdep.c:3952 [inline]
 __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
 lock_acquire kernel/locking/lockdep.c:5942 [inline]
 lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
 anon_pipe_prefill_and_lock+0x16c/0x580 fs/pipe.c:165
 anon_pipe_write+0x164/0x1b50 fs/pipe.c:534
 __kernel_write_iter+0x6bb/0x930 fs/read_write.c:621
 __kernel_write+0xf6/0x140 fs/read_write.c:641
 autofs_write fs/autofs/waitq.c:57 [inline]
 autofs_notify_daemon+0x50d/0xd90 fs/autofs/waitq.c:164
 autofs_wait+0x10fd/0x1b50 fs/autofs/waitq.c:426
 autofs_mount_wait+0x132/0x3b0 fs/autofs/root.c:256
 autofs_d_automount+0x490/0x950 fs/autofs/root.c:410
 follow_automount fs/namei.c:1565 [inline]
 __traverse_mounts+0x1b9/0x8a0 fs/namei.c:1618
 traverse_mounts fs/namei.c:1647 [inline]
 handle_mounts fs/namei.c:1749 [inline]
 step_into_slowpath+0xb7e/0xf90 fs/namei.c:2104
 step_into fs/namei.c:2152 [inline]
 walk_component fs/namei.c:2288 [inline]
 lookup_last fs/namei.c:2789 [inline]
 path_lookupat+0x58b/0xc40 fs/namei.c:2813
 filename_lookup+0x202/0x590 fs/namei.c:2842
 kern_path+0x37/0x50 fs/namei.c:3036
 lookup_bdev+0xd8/0x2a0 block/bdev.c:1268
 resume_store+0x1d6/0x460 kernel/power/hibernate.c:1278
 kobj_attr_store+0x58/0x80 lib/kobject.c:842
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6af/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f02d5f9ea29
Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffe4dfde98 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f02d5f9ea29
RDX: 0000000000000012 RSI: 0000200000000040 RDI: 000000000000000b
RBP: 0000000000000000 R08: 0000000000000009 R09: 0000000000000000
R10: 0000000000000007 R11: 0000000000000246 R12: 00007f02d6006042
R13: 00007fffe4dfded0 R14: 00007fffe4dfdf10 R15: 0000000000000000
 </TASK>
PM: Image not found (code -6)


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
