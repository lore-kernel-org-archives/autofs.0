Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35A63B14AA
	for <autofs@vger.kernel.org>; Sun, 27 Sep 2026 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790522367; cv=none; b=qNzGcfK0IKkYar/wI8OPqYVuw0gB50t6AcQN5VCejBu7zOoo0nwQCJoXu82Qou0NW0pRqyXUQs19OO+d6pl+K8gONI1irxXl6yMYPv7jst6wN/ZQousORRpSq/kxRooQ0ws/nDKgiwfDsfV5qNjSV8u9TwjaIWRfG/Dl0+ItAkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790522367; c=relaxed/simple;
	bh=IcGYiHdGfHAakSGNBy8LgEwmCRWVVJjlwkaCFyvcSgA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VCll5YLQv77esNXxpht53LRyLjrd5cCjbTYRkpLYj1x1Uli93hL5Ga2L5Hp1ByFgYKafk5ciBNBeTrNTRoZFbevei/xJiquzVL0+ePUvo26mdQaU1z35ThnrEVaU0uDsKPiyONAeEzyHRe0vGORGE/yMywHulr6OwNW+V0JMQGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4b5bfffcc2dso2325325b6e.0
        for <autofs@vger.kernel.org>; Sun, 27 Sep 2026 08:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790522364; x=1791127164;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3Ei5dNIIKR4rC7Cm5c+B+fnAtoZCP/bdgTGVjZs7GWQ=;
        b=GRKT3p8VY2CQpOMZ7ztoI43iCw4/1+O/qdcaHm8ot37hqesWEbIyjQGVwiSt5LBsWa
         znAaP2gU7/vXBiwocFxH7wCftlRJewh76AqimDaMNE7UbXsS31RtdFjpfn6svN04m+rf
         PelQKYedWbhxgnLEBTKrB3eHjqkIt1rJc7S+QPLwVr+QMbSzpcL1L8Y8eRbQhbyRaErb
         Ec0I0M3ZXe75F6aACT8W7ljQsYcDNt1BVLuiPtMAhJb9hs7xtqdjJuGj8S6J9alezNlZ
         4N/ccxhNH/rXzwuezPM4w/erpOo8ZtOuGq3lrjpQojpBrv8JInuLA7FD9MoFYoMeGxWy
         rVMw==
X-Gm-Message-State: AFuF++mh00KpGgBRhwa0SCjEjqyUZiOtS60reI078Ptpnweh+VW68cFT
	jFrxKP3l8c/HjCyjQlio8xV7zjryOfLTJ+lh3pyRj9CZ+JsbyTNEZiDITRNetjqOPMtqqUFeT/H
	GNuzfPJyqAvUH4vWX050nGycdAZQkFlvo9S2/tIRAshjQN4ndnaPa5/xBtBA=
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2219:b0:4ca:9850:4dd8 with SMTP id
 5614622812f47-4d72a34ca3dmr9034358b6e.10.1790522364646; Sun, 27 Sep 2026
 08:19:24 -0700 (PDT)
Date: Sun, 27 Sep 2026 08:19:24 -0700
In-Reply-To: <6a73d1a8.b50370da.49fe0.0009.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab933fc.80e1c6cc.1e8e5f.005e.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in autofs_notify_daemon (3)
From: syzbot <syzbot+2b1c8c58f62458852a54@syzkaller.appspotmail.com>
To: autofs@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, raven@themaw.net, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    fd179f8a05be Merge tag 'ata-7.3-rc5' of git://git.kernel.o..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12416605580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d012d9c67977ee4
dashboard link: https://syzkaller.appspot.com/bug?extid=2b1c8c58f62458852a54
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15870ac9580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2b1c8c58f62458852a54@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz-executor419/5954 is trying to acquire lock:
ffff8880349c0938 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_write fs/autofs/waitq.c:55 [inline]
ffff8880349c0938 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_notify_daemon+0x4f8/0xd90 fs/autofs/waitq.c:164

but task is already holding lock:
ffff888037e1c880 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&of->mutex){+.+.}-{4:4}:
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

-> #1 (&pipe->mutex){+.+.}-{4:4}:
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
       vfs_statx+0xff/0x3f0 fs/stat.c:353
       vfs_fstatat+0x77/0xe0 fs/stat.c:373
       __do_sys_newfstatat+0x9d/0x120 fs/stat.c:538
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&sbi->pipe_mutex){+.+.}-{4:4}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3209
       check_prevs_add kernel/locking/lockdep.c:3328 [inline]
       validate_chain kernel/locking/lockdep.c:3952 [inline]
       __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
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
       resume_store+0x1d6/0x460 kernel/power/hibernate.c:1280
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
  &sbi->pipe_mutex --> &pipe->mutex --> &of->mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&of->mutex);
                               lock(&pipe->mutex);
                               lock(&of->mutex);
  lock(&sbi->pipe_mutex);

 *** DEADLOCK ***

locks held by syz-executor419/5954: 4, last CPU#0:
 #0: ffff88807a6735f0 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x2aa/0x380 fs/file.c:1259
 #1: ffff888037bc2460 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #2: ffff888037e1c880 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
 #3: ffff888020adbe18 (kn->active#59){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #3: ffff888020adbe18 (kn->active#59){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x332/0x5f0 fs/kernfs/file.c:337

stack backtrace:
CPU: 0 UID: 0 PID: 5954 Comm: syz-executor419 Not tainted syzkaller #0 PREEMPT(full) 
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
 resume_store+0x1d6/0x460 kernel/power/hibernate.c:1280
 kobj_attr_store+0x58/0x80 lib/kobject.c:842
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6af/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fab79cd6b77
Code: 48 89 fa 4c 89 df e8 98 1e 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffcb4ea4ee0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000055556184c400 RCX: 00007fab79cd6b77
RDX: 0000000000000016 RSI: 00007fab79d14c00 RDI: 0000000000000005
RBP: 0000000000001733 R08: 0000000000000000 R09: 0000000000000000


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
