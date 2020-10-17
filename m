From: Ian Kent <raven@themaw.net>
Subject: Re: 5.9.0-next-20201015: autofs oops in update-binfmts
Date: Sat, 17 Oct 2020 10:11:05 +0800
Message-ID: <bfac7ed28d79b8696cb8576790b27027a78cd3b7.camel@themaw.net>
References: <20201016123530.GA30444@duo.ucw.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        OZAqIcly2B0iv7D64qcOyBLJ0vCQ0HmNBddZytqUo1U=; b=HrqBbcTljH5GaRwh
        xw+/catH3X/N0TddPpyajQiusA3TUgRcaFkwU2OLvA6Y22rze8aes5gM6qi0wxzr
        xvjkh+kp5mSmtw8+8bYtJ8K9EcpwQKaW9UQpCp2FmGhw23w1XDzQGjUuvG5gVbsc
        V6NumQ46z31NdYgG+mbSJlDKaco7j51o35yMWufPABNARZa89XqUMWCECM3Xnpax
        eRq9Vyms/uoPszgzZaibnIIMFg8dIkzy4MdvTRVjLXohmkJ5f5kooz8uKKikfRhy
        +S0zcT9MjX4vB+zunq15h4XGqQCWZ/Bo5szK0u9dlzxmoJM5IUm2mNrs2Bv/SpQl
        /aJ94Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=OZAqIcly2B0iv7D64qcOyBLJ0vCQ0HmNBddZytqUo
        1U=; b=BIkGj67zbPSkSuSLvEU8uXpvqaT9azvSbmmF/Jpcw175y72chtXJw5aSF
        rdbVfgVu23L23H+gU2lDXapM5U42T3MDmNi5gjM5Yh80nIyuzXf3wpqk14dw0tMl
        fUg+BkBrSyTwYupaIVW0WgnkjXYeEknEzduaTRvUAjG47jD0A+CEfI7co8lo+yXR
        00H+h/LVcLzoPbrl52/J0BRWv3dMfnMSyaewEUSiSMPZs0r/SpcYmPz3a8Cm4nU7
        WDZnVHCLFtipYRBaxWts6Y9CB/1Xq0HOD4YlVz0bOw6vcy4aI6sEiDwhrjU4/5cH
        J9yk1N01+OWEZ3qpgiatdpe1a7Nag==
In-Reply-To: <20201016123530.GA30444@duo.ucw.cz>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, autofs@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com

On Fri, 2020-10-16 at 14:35 +0200, Pavel Machek wrote:
> Hi!
> 
> I'm getting this during boot: 32-bit thinkpad x60.

This is very odd.

The change in next is essentially a revert of a change, maybe I'm
missing something and the revert isn't quite a revert. Although
there was one difference.

I'll check for other revert differences too.

Are you in a position to check a kernel without the 5.9 change
if I send you a patch?

And we should check if that difference to what was originally
there is the source of the problem, so probably two things to
follow up on, reverting that small difference first would be
the way to go.

Are you able to reliably reproduce it?

> 
> [   10.718377] BUG: kernel NULL pointer dereference, address:
> 00000000
> [   10.721848] #PF: supervisor read access in kernel mode
> [   10.722763] #PF: error_code(0x0000) - not-present page
> [   10.726759] *pdpt = 000000000339e001 *pde = 0000000000000000 
> [   10.730793] Oops: 0000 [#1] PREEMPT SMP PTI
> [   10.736201] CPU: 1 PID: 2762 Comm: update-binfmts Not tainted
> 5.9.0-next-20201015+ #152
> [   10.738769] Hardware name: LENOVO 17097HU/17097HU, BIOS 7BETD8WW
> (2.19 ) 03/31/2011
> [   10.742769] EIP: __kernel_write+0xd4/0x230
> [   10.746769] Code: 89 d6 64 8b 15 b4 77 4c c5 8b 8a 38 0b 00 00 31
> d2 85 c9 74 04 0f b7 51 30 66 89 75 e8 8b 75 ac 8d 4d b0 89 45 e4 66
> 89 55 ea <8b> 06 8b 56 04 57 6a 01 89 45 d4 8d 45 b8 89 55 d8 ba 01
> 00 00 00
> [   10.758762] EAX: 00020000 EBX: c1922a40 ECX: c33cdad0 EDX:
> 00000000
> [   10.762791] ESI: 00000000 EDI: 0000012c EBP: c33cdb20 ESP:
> c33cdacc
> [   10.766766] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS:
> 00010286
> [   10.770762] CR0: 80050033 CR2: 00000000 CR3: 033d0000 CR4:
> 000006b0
> [   10.770762] Call Trace:
> [   10.770762]  ? __mutex_unlock_slowpath+0x2b/0x2c0
> [   10.770762]  ? dma_direct_map_sg+0x13a/0x320
> [   10.770762]  autofs_notify_daemon+0x14d/0x2b0
> [   10.770762]  autofs_wait+0x4cd/0x770
> [   10.793051]  ? autofs_d_automount+0xd6/0x1e0
> [   10.793051]  autofs_mount_wait+0x43/0xe0
> [   10.797808]  autofs_d_automount+0xdf/0x1e0
> [   10.797808]  __traverse_mounts+0x85/0x200
> [   10.797808]  step_into+0x368/0x620
> [   10.797808]  ? proc_setup_thread_self+0x110/0x110
> [   10.797808]  walk_component+0x58/0x190
> [   10.811838]  link_path_walk.part.0+0x245/0x360
> [   10.811838]  path_lookupat.isra.0+0x31/0x130
> [   10.811838]  filename_lookup+0x8d/0x130
> [   10.818749]  ? cache_alloc_debugcheck_after+0x151/0x180
> [   10.818749]  ? getname_flags+0x1f/0x160
> [   10.818749]  ? kmem_cache_alloc+0x75/0x100
> [   10.818749]  user_path_at_empty+0x25/0x30
> [   10.818749]  vfs_statx+0x63/0x100
> [   10.831022]  ? _raw_spin_unlock+0x18/0x30
> [   10.831022]  ? replace_page_cache_page+0x160/0x160
> [   10.831022]  __do_sys_stat64+0x36/0x60
> [   10.831022]  ? exit_to_user_mode_prepare+0x35/0xe0
> [   10.831022]  ? irqentry_exit_to_user_mode+0x8/0x20
> [   10.838773]  ? irqentry_exit+0x55/0x70
> [   10.838773]  ? exc_page_fault+0x228/0x3c0
> [   10.838773]  __ia32_sys_stat64+0xd/0x10
> [   10.838773]  do_int80_syscall_32+0x2c/0x40
> [   10.848561]  entry_INT80_32+0x111/0x111
> [   10.848561] EIP: 0xb7ee2092
> [   10.848561] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30
> 00 00 00 e9 80 ff ff ff ff a3 e8 ff ff ff 66 90 00 00 00 00 00 00 00
> 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d
> b4 26 00
> [   10.848561] EAX: ffffffda EBX: 00468490 ECX: bfbce6ec EDX:
> 00467348
> [   10.848561] ESI: 00000000 EDI: 00468490 EBP: bfbce6ec ESP:
> bfbce6c4
> [   10.848561] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS:
> 00000292
> [   10.848561] Modules linked in:
> [   10.848561] CR2: 0000000000000000
> [   10.851552] ---[ end trace d01bd7323c2317a5 ]---
> [   10.851558] EIP: __kernel_write+0xd4/0x230
> [   10.851561] Code: 89 d6 64 8b 15 b4 77 4c c5 8b 8a 38 0b 00 00 31
> d2 85 c9 74 04 0f b7 51 30 66 89 75 e8 8b 75 ac 8d 4d b0 89 45 e4 66
> 89 55 ea <8b> 06 8b 56 04 57 6a 01 89 45 d4 8d 45 b8 89 55 d8 ba 01
> 00 00 00
> [   10.851563] EAX: 00020000 EBX: c1922a40 ECX: c33cdad0 EDX:
> 00000000
> [   10.851565] ESI: 00000000 EDI: 0000012c EBP: c33cdb20 ESP:
> c33cdacc
> [   10.851568] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS:
> 00010286
> [   10.851570] CR0: 80050033 CR2: 004a700e CR3: 033d0000 CR4:
> 000006b0
> [   11.803128] systemd-journald[2514]: Received request to flush
> runtime journal from PID 1
> [   26.113941] iwl3945 0000:03:00.0: loaded firmware version
> 15.32.2.9
> [   59.809322] traps: clock-applet[3636] trap int3 ip:b724ffc0
> sp:bf879b90 error:0 in libglib-2.0.so.0.5000.3[b7203000+12a000]
> [   59.812036] traps: mateweather-app[3638] trap int3 ip:b7283fc0
> sp:bfb65760 error:0 in libglib-2.0.so.0.5000.3[b7237000+12a000]
> [   64.628401] wlan0: authenticate with 5c:f4:ab:10:d2:bb
> 
-- 
Ian Kent <raven@themaw.net>

