Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174834B04A0
	for <autofs@vger.kernel.org>; Sat, 15 Aug 2026 00:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786752698; cv=none; b=GH3xt6+JZijKDfS2b1S9jS10K0K3qAxdatrtmztupUR2AShS8ulh+MYe7/tSCU9Tdacv5yFtyW4oO05eKWexWCd0ekpJgIVJAejSCSrLfjjoLwcuNdBjaUlfVhVvZ+5lvV12iXaNnNatYZewwLRCuqzfLOd106k8PJ4Vz1qh52s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786752698; c=relaxed/simple;
	bh=Rg0QWmt9FGxH0sq59MVWlgDGyp2/YseKWgNvxL1j5EY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KFq4OfZ/wOgpd551x3zmp5QUVYoTYlp0WmKcSgDhDI/oBh7rhzPf8pUReZXgR8a0VoKXGM07vEjRwTQc3ALDbCceTM/lDdKFz2lo5JLeKPN6JzVf+sTkaVmoGy1BZ8ZD86ugXOJ2akKsblRlceE/WINf98/fqYVLC9MFwcuI184=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-6aae6f87ed7so1530283eaf.0
        for <autofs@vger.kernel.org>; Fri, 14 Aug 2026 17:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786752696; x=1787357496;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0pfHBZkP+bol7AU9NvnslyqRVXphOe4m7EmVJ4GVGq0=;
        b=hzdZ4dYmOE+I2xeOFk4YBaXbfdGIzjrO9ELUSv69yRouePQaUNDIPLJRF5Owa938SO
         KhfBjOPB3DPAT4Wp3bWnz7FS52rR232MeDLuXgDo9Ze6sjW69ypV5AM9pVAQjkA6fAUW
         pT+rk7XRlC8hdJn8a8NtLtCabO5VESA4RW7PGim3UHlffm8XygT+aHqS3lCSCQSeQ9Eg
         2rVTGmriUFG8P9Vy4wI1hP0EDkfL/rVR6SH62D6T2sNeJiDaGrpP1zW/l3kqp4LhV1Zx
         dp2uckfH8VvxqymmjO6la0tNAhg4FMjdOkCJ9CL5nI0Mmf0/6DOUBuyLQiTGDGWY5bKS
         QHhg==
X-Gm-Message-State: AOJu0YyMi2+bmWH4/pGOMKphoRorK4HgykoTPqBvk2AGpKkdrxC2iO47
	ijHE/Cy2ZrijuO/vg5E1mAHfWuTrLP0/p8f8bbaMPPMXLefGD3dl6xGKT2ujRIQ3lb2SN8uZtAh
	G3JLStPr+ntLnaB/03cHx83GM2otno2M127pD5HPHdXaPSfCiA0QBcFMoerk6gw==
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:813:b0:6b0:4fbc:aecf with SMTP id
 006d021491bc7-6b0d68b2455mr7133755eaf.24.1786752695855; Fri, 14 Aug 2026
 17:11:35 -0700 (PDT)
Date: Fri, 14 Aug 2026 17:11:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7faeb7.432fbecc.3db7aa.015d.GAE@google.com>
Subject: [syzbot] [autofs?] possible deadlock in anon_pipe_write (3)
From: syzbot <syzbot+c36cbd4737e4508de101@syzkaller.appspotmail.com>
To: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, raven@themaw.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d58772d8520c Merge tag 'regmap-fix-v7.2-rc7' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=106812c6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a233ed2ce9a8096
dashboard link: https://syzkaller.appspot.com/bug?extid=c36cbd4737e4508de101
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-d58772d8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a4e864f7b043/vmlinux-d58772d8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f485f29307dc/bzImage-d58772d8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c36cbd4737e4508de101@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.0.717/10076 is trying to acquire lock:
ffff8880517dd860 (&pipe->mutex){+.+.}-{4:4}, at: anon_pipe_write+0x25e/0x1d90 fs/pipe.c:553

but task is already holding lock:
ffff88802aeb3938 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_write fs/autofs/waitq.c:55 [inline]
ffff88802aeb3938 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_notify_daemon+0x4f8/0xd90 fs/autofs/waitq.c:164

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sbi->pipe_mutex){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
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
       lookup_bdev+0xd8/0x280 block/bdev.c:1208
       resume_store+0x1d6/0x460 kernel/power/hibernate.c:1278
       kobj_attr_store+0x58/0x80 lib/kobject.c:840
       sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
       kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6ac/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
       __do_fast_syscall_32+0xe7/0x970 arch/x86/entry/syscall_32.c:307
       do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:332
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #1 (&of->mutex){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
       iter_file_splice_write+0x830/0x10b0 fs/splice.c:736
       do_splice_from fs/splice.c:936 [inline]
       do_splice+0x109c/0x1f90 fs/splice.c:1349
       __do_splice+0x33b/0x370 fs/splice.c:1431
       __do_sys_splice fs/splice.c:1634 [inline]
       __se_sys_splice fs/splice.c:1616 [inline]
       __ia32_sys_splice+0x189/0x250 fs/splice.c:1616
       do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
       __do_fast_syscall_32+0xe7/0x970 arch/x86/entry/syscall_32.c:307
       do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:332
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #0 (&pipe->mutex){+.+.}-{4:4}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3165
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x136c/0x1a40 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       anon_pipe_write+0x25e/0x1d90 fs/pipe.c:553
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
       lookup_bdev+0xd8/0x280 block/bdev.c:1208
       resume_store+0x1d6/0x460 kernel/power/hibernate.c:1278
       kobj_attr_store+0x58/0x80 lib/kobject.c:840
       sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
       kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6ac/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
       __do_fast_syscall_32+0xe7/0x970 arch/x86/entry/syscall_32.c:307
       do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:332
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

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

5 locks held by syz.0.717/10076:
 #0: ffff8880275d35f0 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x2aa/0x380 fs/file.c:1259
 #1: ffff88802ac8e450 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #2: ffff8880721bcc80 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
 #3: ffff88801d35e5a8 (kn->active#85){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #3: ffff88801d35e5a8 (kn->active#85){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x332/0x5f0 fs/kernfs/file.c:337
 #4: ffff88802aeb3938 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_write fs/autofs/waitq.c:55 [inline]
 #4: ffff88802aeb3938 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_notify_daemon+0x4f8/0xd90 fs/autofs/waitq.c:164

stack backtrace:
CPU: 2 UID: 0 PID: 10076 Comm: syz.0.717 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1c7 kernel/locking/lockdep.c:2043
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2175
 check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3165
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x136c/0x1a40 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
 anon_pipe_write+0x25e/0x1d90 fs/pipe.c:553
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
 lookup_bdev+0xd8/0x280 block/bdev.c:1208
 resume_store+0x1d6/0x460 kernel/power/hibernate.c:1278
 kobj_attr_store+0x58/0x80 lib/kobject.c:840
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0xe7/0x970 arch/x86/entry/syscall_32.c:307
 do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:332
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf706efec
Code: Unable to access opcode bytes at 0xf706efc2.
RSP: 002b:00000000f543c50c EFLAGS: 00000292 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 000000000000000c RCX: 0000000080000040
RDX: 0000000000000012 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
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
