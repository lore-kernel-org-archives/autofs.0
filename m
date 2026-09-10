Received: from mail-oa2-f9.google.com (mail-oa2-f9.google.com [74.125.231.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5333AAF68
	for <autofs@vger.kernel.org>; Thu, 10 Sep 2026 04:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789014395; cv=none; b=mCerPhyj3KLvriy6gyYIjH3EotlGfi398dGVzNrlxnknyA9N/gwDcE2t0R1SLA1fo8CLnLZyNfl2ColIiy9qORtRyG7BDoQXKWAbMBKH3j0F3cI6/x6uEB/rfEvOzl/Bpvr96YgKc8Qr16Uz3BfYw7SGbLLGdVNc2UaWG0c/lP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789014395; c=relaxed/simple;
	bh=6nJbo+/WV85aYuUhqCqWM8H58kVaynxLOnyOjDLIdpo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GMYjivb7ziHIqKljvk79ln19AFhEl+IOzgO/5zhnWta3bcA3DbpgiTIWDdSlR4iyNKBXJmWJGUi8rs9nW4Ic3wTFaxDxbDa3yp2otmFJvAOnOtxsrYvkm9lAo/G0HcCF1eMcGTOS3b9TpTlUCSz6g3PxyjPYt+wCt3snadTtG1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa2-f9.google.com with SMTP id 586e51a60fabf-47bb3ddaaf6so408030fac.0
        for <autofs@vger.kernel.org>; Wed, 09 Sep 2026 21:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789014392; x=1789619192;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bGVt+gF9GRzPizZo6YMgPCn1yPvcK2inFU5L1aSoS5M=;
        b=Lp/v3gC1eaMxm82NenecO86HR/KHD+3XK27jbWdOSLbBGlg5zOmwODr5ZD+/hdJujI
         /LaCmjiROZU8EjKINnSKZgVisprrzOH1tz3g9QJDnbqCOl5+X3U57r6ODTHOHNCXKUJP
         4Q+8zzDUQbp70UNLgDhagoIs9XoXlMZc/nGpEFhLEjtDJn00N88XTldm+QzuhOzyh1Mh
         ciWQk+H2LW5NjoFyEYuExMyLw3GV6nITdFH8HYpD00ZYC0Sytth/CXrIrqJqCVv1JyJZ
         BUT8oYPIoe3/nlQmwa77MrFFg8MhyOa1Mrm243izYtKzlkNT0Om+6VQIxeudptr2Ejqg
         Tg9w==
X-Gm-Message-State: AFuF++kO4/Vsh7oSQ4ENDc8d6YrYzcb4TGEAZScvENNwCe9/RE1Z264f
	T/AE3iN3dDZ+yaM5vEL0Uh39B0e29ZGAV4CjSFCErBOFzmsADCv06onEjuKNViVvQPf6IvhmM8M
	J1PFxN0FEisDrSXykjk7DwoCt9r1cMRcqCkkCIb37QcwKWBAaqNBug/KhNT/Xbw==
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2912:b0:6b3:b9d1:f629 with SMTP id
 006d021491bc7-6bee5e98160mr5971530eaf.31.1789014392736; Wed, 09 Sep 2026
 21:26:32 -0700 (PDT)
Date: Wed, 09 Sep 2026 21:26:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa23178.f81106d8.2ab401.0006.GAE@google.com>
Subject: [syzbot] [autofs?] possible deadlock in anon_pipe_prefill_and_lock
From: syzbot <syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com>
To: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, raven@themaw.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1fc5a74b108f Merge tag 'kmalloc_obj-v7.3-rc2' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17aeb2f9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5c3949d762a91f
dashboard link: https://syzkaller.appspot.com/bug?extid=002fb7b2d0bc53bf7e75
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f5473bcef69a/disk-1fc5a74b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fc94ec0cede2/vmlinux-1fc5a74b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1316ecaf7adb/bzImage-1fc5a74b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.3.511/7847 is trying to acquire lock:
ffff88802c68cc60 (&pipe->mutex){+.+.}-{4:4}, at: anon_pipe_prefill_and_lock+0x16c/0x580 fs/pipe.c:165

but task is already holding lock:
ffff88807d378138 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_write fs/autofs/waitq.c:55 [inline]
ffff88807d378138 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_notify_daemon+0x4f8/0xd90 fs/autofs/waitq.c:164

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sbi->pipe_mutex){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5908 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5865
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
       lock_acquire kernel/locking/lockdep.c:5908 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5865
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
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3181
       check_prevs_add kernel/locking/lockdep.c:3300 [inline]
       validate_chain kernel/locking/lockdep.c:3924 [inline]
       __lock_acquire+0x1492/0x1ec0 kernel/locking/lockdep.c:5254
       lock_acquire kernel/locking/lockdep.c:5908 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5865
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

locks held by syz.3.511/7847: 5, last CPU#0:
 #0: ffff88807334f430 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x2aa/0x380 fs/file.c:1259
 #1: ffff8880339b4460 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #2: ffff888056438c80 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
 #3: ffff888020ac5f08 (kn->active#71){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #3: ffff888020ac5f08 (kn->active#71){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x332/0x5f0 fs/kernfs/file.c:337
 #4: ffff88807d378138 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_write fs/autofs/waitq.c:55 [inline]
 #4: ffff88807d378138 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_notify_daemon+0x4f8/0xd90 fs/autofs/waitq.c:164

stack backtrace:
CPU: 0 UID: 0 PID: 7847 Comm: syz.3.511 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/05/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1be kernel/locking/lockdep.c:2059
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2191
 check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3181
 check_prevs_add kernel/locking/lockdep.c:3300 [inline]
 validate_chain kernel/locking/lockdep.c:3924 [inline]
 __lock_acquire+0x1492/0x1ec0 kernel/locking/lockdep.c:5254
 lock_acquire kernel/locking/lockdep.c:5908 [inline]
 lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5865
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
RIP: 0033:0x7eff3b99e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007eff3c78c028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007eff3bc25fa0 RCX: 00007eff3b99e159
RDX: 0000000000000012 RSI: 0000200000000040 RDI: 0000000000000008
RBP: 00007eff3ba35024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007eff3bc26038 R14: 00007eff3bc25fa0 R15: 00007ffdcf0d0ce8
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
