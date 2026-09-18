Received: from mail-oi2-f9.google.com (mail-oi2-f9.google.com [74.125.231.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B13C4C77BC
	for <autofs@vger.kernel.org>; Fri, 18 Sep 2026 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789728409; cv=none; b=cmHsvmCu8rz8IXU9NaZOmOWlRpzOOwUSegMKp/n+XC4+78nh5Q85ThZWy/IRTtrXaA5OtmiXAwAkyC4uFpEJBiJTb5EmeCBJngJIQT9B9tAkJYeF0WioUThLhjikY0ITMldHmYHU8TTgGqtcgs6zoihfGO8rdWlGL5DQLv7EYCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789728409; c=relaxed/simple;
	bh=v6ZjnE5aXq+bFmD7qgTJhMUvz1j3HEa+ayxBOgyb3PU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=enFarq54NZ30FT29k5DrAtw84LYSJxnssuFiQ/VV8eM7xUpGtM+iu46J00ezPBq5MWV+Df9jT0lYJWgdElNWYABTJRHfrFyVkV7zf1mYH4ISfkjI9UIrNIVxDuJZSdAeyNK7rCKuUzQxWYNbsNeXmJ943DJA2VPzucunhrIdAOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f9.google.com with SMTP id 46e09a7af769-7f9cc0e524aso165182a34.1
        for <autofs@vger.kernel.org>; Fri, 18 Sep 2026 03:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789728402; x=1790333202;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wgLrJIgNG/4SuAWNKOls2c1x79XnfTe3dhYkLnd80Nw=;
        b=0HmOKVaKya+pNiDuS7+vxbXTlhaDY5M0F2X7f6Ez6TO8yv9vczjWPe3cVn3FuXZoG/
         ASbnVzSVJXaVVQ3Za0pC+0MCyHN9kdK5IQyiouTwzcvDaoU/fiaEm0SoPBMppEAwEIA0
         +d2TrfuFUFpwyKJXXYnWwQw8C5XEYp+DkwqSGJ7BUaRk1IAiFYC8HoZfr+P6NiwitAZ+
         WzZXvGY2dnHY0Fs1MOFpJLkYjTrvJS7SB3dHhgzjTlCa/VpnNz0xw3u6ZzVOHxu1W422
         hTvJhxw0th1CPFVvLF4fYxFMzS1rocX6uZUXBwxJPEoN7ba2kf2vBFq6mbVfjI77sy+u
         jYLQ==
X-Gm-Message-State: AFuF++nIi5tavNEGI0qNKQiYgKhw+z1AS0892ieMcmob+Quem4txQ2cG
	xA0V4ax1YDvB7xGzekMGLfXYsu/wiNGAph1Wj0Px0I1oxIQdBi5yEzvZAip1UWBsti6Ke4KHzkN
	4v4x4z6C7qihnbhTmE0E28PcMbIIp32wes6DaaiFl0+VahSrbeH7YIx7OhOiB/A==
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:995:b0:6c7:1e67:852 with SMTP id
 006d021491bc7-6ca9d55d758mr1826226eaf.67.1789728402330; Fri, 18 Sep 2026
 03:46:42 -0700 (PDT)
Date: Fri, 18 Sep 2026 03:46:42 -0700
In-Reply-To: <6aa23178.f81106d8.2ab401.0006.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aad1692.87c06881.1db2b3.0022.GAE@google.com>
Subject: Re: [syzbot] [autofs?] possible deadlock in anon_pipe_prefill_and_lock
From: syzbot <syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com>
To: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, raven@themaw.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    4982d3552a3b Merge tag 'sound-7.3-rc4' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=176da915580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84649d3ff8d550cb
dashboard link: https://syzkaller.appspot.com/bug?extid=002fb7b2d0bc53bf7e75
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10eda915580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-4982d355.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d2afaea1fac3/vmlinux-4982d355.xz
kernel image: https://storage.googleapis.com/syzbot-assets/06e82fadea82/bzImage-4982d355.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.17/5928 is trying to acquire lock:
ffff88802d512c60 (&pipe->mutex){+.+.}-{4:4}, at: anon_pipe_prefill_and_lock+0x16c/0x580 fs/pipe.c:165

but task is already holding lock:
ffff888036200938 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_write fs/autofs/waitq.c:55 [inline]
ffff888036200938 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_notify_daemon+0x4f8/0xd90 fs/autofs/waitq.c:164

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&sbi->pipe_mutex){+.+.}-{4:4}:
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

-> #2 (&of->mutex){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       kernfs_seq_start+0x4f/0x2a0 fs/kernfs/file.c:165
       seq_read_iter+0x2c1/0x1270 fs/seq_file.c:226
       kernfs_fop_read_iter+0x46c/0x610 fs/kernfs/file.c:290
       copy_splice_read+0x4ba/0xbb0 fs/splice.c:362
       do_splice_read fs/splice.c:980 [inline]
       do_splice_read+0x285/0x370 fs/splice.c:954
       splice_file_to_pipe+0x82/0x120 fs/splice.c:1290
       do_sendfile+0x366/0xe20 fs/read_write.c:1377
       __do_sys_sendfile64 fs/read_write.c:1432 [inline]
       __se_sys_sendfile64 fs/read_write.c:1418 [inline]
       __x64_sys_sendfile64+0x1d8/0x220 fs/read_write.c:1418
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&p->lock){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       seq_read_iter+0xe1/0x1270 fs/seq_file.c:183
       kernfs_fop_read_iter+0x46c/0x610 fs/kernfs/file.c:290
       copy_splice_read+0x4ba/0xbb0 fs/splice.c:362
       do_splice_read fs/splice.c:980 [inline]
       do_splice_read+0x285/0x370 fs/splice.c:954
       splice_file_to_pipe+0x82/0x120 fs/splice.c:1290
       do_sendfile+0x366/0xe20 fs/read_write.c:1377
       __do_sys_sendfile64 fs/read_write.c:1432 [inline]
       __se_sys_sendfile64 fs/read_write.c:1418 [inline]
       __x64_sys_sendfile64+0x1d8/0x220 fs/read_write.c:1418
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

locks held by syz.0.17/5928: 4, last CPU#3:
 #0: ffff88802c2fc460 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #1: ffff88802be9e080 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
 #2: ffff88801d344878 (kn->active#67){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #2: ffff88801d344878 (kn->active#67){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x332/0x5f0 fs/kernfs/file.c:337
 #3: ffff888036200938 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_write fs/autofs/waitq.c:55 [inline]
 #3: ffff888036200938 (&sbi->pipe_mutex){+.+.}-{4:4}, at: autofs_notify_daemon+0x4f8/0xd90 fs/autofs/waitq.c:164

stack backtrace:
CPU: 3 UID: 0 PID: 5928 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
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
RIP: 0033:0x7f00df39e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeff202ac8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f00df625fa0 RCX: 00007f00df39e159
RDX: 0000000000000012 RSI: 0000200000000040 RDI: 0000000000000008
RBP: 00007f00df43506b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f00df625fac R14: 00007f00df625fa0 R15: 00007f00df625fa0
 </TASK>
PM: Image not found (code -6)


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
