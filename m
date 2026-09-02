Received: from mail-oo2-f7.google.com (mail-oo2-f7.google.com [74.125.231.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278113AA4F8
	for <autofs@vger.kernel.org>; Wed,  2 Sep 2026 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366814; cv=none; b=pWmyvIAQSK3D+koaC4vOaFQOVkE82Oc7PqRpx9KL3E8jJ4tVLF05lFCuCEPNppGSipeNCBlnBIhwCBJY7eorCbFS1fW5ahdfWPcAW91ommG7f9DtYTJT6guIvKm2OfQ7V6acAgMxQWFAO9S1BvOxM1CCMIfaBPuS1vF44QmYHuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366814; c=relaxed/simple;
	bh=MkkTiAfIa+S9u79RbxCV3aOQkSt/YQ+M7pZsqqSd4b4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=G7gQIGp2ZiWCOH1fZo1JYa/UJGE5IyMdZZAJvbucIep5mht/V3cWxjXcJp3cI8PAG3w5qr1nD6/pdiuGgyrWbCOh28DhClHxRXWIPrEHkS3jqlnAKjl+KzvpBY/I9g2VgsejMSROgMmxee1aiooVbz9O4J9qAjWfzSwwjBZOXsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f7.google.com with SMTP id 006d021491bc7-6b1bebb3ae8so355447eaf.1
        for <autofs@vger.kernel.org>; Wed, 02 Sep 2026 09:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788366811; x=1788971611;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YUicN5rnINFHNGdnOsZGp7jfpCrpIV80y457DhVxQPM=;
        b=IWzcGCT2u5JbhsYIHlwYgYpGEGHeiYJUYv5BfCULgb44t8sb/2C6BvKbowUULQJRxM
         blOMKsKztvfB6DShmG3Cqk9QHit8vAD9L/STz2zyLYybZitNBKmhkWbGyrFXyGZ3+JW1
         bq1W1iVKbGElVIF9URne+BpKq9MTzL0lYOWu5P7THAXNipLPzzUvp4fBCcjv3l14v+pC
         cr5qTMv5cegErkHcOTteiKYprmqq8KOcWSbRD5ij33Q/Hlbw3cYvWK2jEs0bBLea2q6k
         HfF9iPoIgBQYjgNENV6fjUaEsOTI80ChYeMZAJYPx6l/48ZoUiLpAXeDRhzrkBA7akc8
         1v+w==
X-Gm-Message-State: AFuF++nec0r60YMAhFw5qVjWJLuNrcZIXDCKSYTVRNJ9EwmzFrbDLSNs
	v4WAe+GOi5KTnfnl3zGB5o/F5XQO0NOA5D475jjw0izpEsFGpmFqGmFTUFj0Bd2AbqH2BdkEIXB
	ik3me/2+F0/OnXRqNh1nazSOO2Hl1IVXjq5U0K6BMtpFKEJ94DSjHrkAt3v82FA==
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c9d:b0:6b1:7ee2:da31 with SMTP id
 006d021491bc7-6b47f51cb13mr3937048eaf.11.1788366810974; Wed, 02 Sep 2026
 09:33:30 -0700 (PDT)
Date: Wed, 02 Sep 2026 09:33:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a984fda.27a413cd.1e878c.000a.GAE@google.com>
Subject: [syzbot] [autofs?] memory leak in autofs_new_ino
From: syzbot <syzbot+df1db6e034b3953e19f5@syzkaller.appspotmail.com>
To: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, raven@themaw.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8d3ae59288f1 Linux 7.2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1784b6c6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11ad91fcc8fa7933
dashboard link: https://syzkaller.appspot.com/bug?extid=df1db6e034b3953e19f5
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11dc9a25580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1670b949580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/735a458674ac/disk-8d3ae592.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fbf50adb0745/vmlinux-8d3ae592.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6effa5f7f690/bzImage-8d3ae592.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+df1db6e034b3953e19f5@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff8881146ebc00 (size 192):
  comm "syz.0.20", pid 5969, jiffies 4294943196
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 55e8e63e):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4597 [inline]
    slab_alloc_node mm/slub.c:4917 [inline]
    __kmalloc_cache_noprof+0x356/0x440 mm/slub.c:5485
    _kmalloc_noprof include/linux/slab.h:988 [inline]
    _kzalloc_noprof include/linux/slab.h:1309 [inline]
    autofs_new_ino+0x24/0x80 fs/autofs/inode.c:16
    autofs_fill_super+0x66/0x1d0 fs/autofs/inode.c:321
    vfs_get_super fs/super.c:1273 [inline]
    get_tree_nodev+0x91/0xf0 fs/super.c:1292
    autofs_get_tree+0xbc/0x120 fs/autofs/inode.c:378
    vfs_get_tree+0x30/0x120 fs/super.c:1700
    vfs_cmd_create+0x7d/0x120 fs/fsopen.c:231
    vfs_fsconfig_locked fs/fsopen.c:295 [inline]
    __do_sys_fsconfig+0x492/0x9e0 fs/fsopen.c:463
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xf8/0x610 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
