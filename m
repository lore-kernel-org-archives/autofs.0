From: Pavel Machek <pavel@ucw.cz>
Subject: autofs: use __kernel_write() for the autofs pipe writing causes
 regression in -next was Re: 5.9.0-next-20201015: autofs oops in
 update-binfmts
Date: Sat, 17 Oct 2020 12:02:34 +0200
Message-ID: <20201017100234.GA3797@amd>
References: <20201016123530.GA30444@duo.ucw.cz>
 <bfac7ed28d79b8696cb8576790b27027a78cd3b7.camel@themaw.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bfac7ed28d79b8696cb8576790b27027a78cd3b7.camel@themaw.net>
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>, torvalds@linux-foundation.org, omosnace@redhat.com, hch@lst.de
Cc: kernel list <linux-kernel@vger.kernel.org>, autofs@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I'm getting this during boot: 32-bit thinkpad x60.
>=20
> This is very odd.
>=20
> The change in next is essentially a revert of a change, maybe I'm
> missing something and the revert isn't quite a revert. Although
> there was one difference.
>=20
> I'll check for other revert differences too.
>=20
> Are you in a position to check a kernel without the 5.9 change
> if I send you a patch?

I think I can revert changes myself.

pavel@amd:/data/l/linux-next-32$ git show
90fb702791bf99b959006972e8ee7bb4609f441b | git apply -R
pavel@amd:/data/l/linux-next-32$
pavel@amd:/data/l/linux-next-32$ git show
d7a8c5c78d37500346c25cc8887ed2c3fda8ed4d | git apply -R

=2E..and it boots up without a warning. Let me re-apply Linus' patch:

pavel@amd:/data/l/linux-next-32$ git show
90fb702791bf99b959006972e8ee7bb4609f441b | git apply
pavel@amd:/data/l/linux-next-32$

=2E..and the oops is back:

Bad Linus!

[    9.889419] EXT4-fs (sda2): mounted filesystem with ordered data
mode. Opts: errors=3Dremount-ro
[   10.042221] BUG: kernel NULL pointer dereference, address: 00000000
[   10.045702] #PF: supervisor read access in kernel mode
[   10.048142] #PF: error_code(0x0000) - not-present page
[   10.052172] *pdpt =3D 00000000031ea001 *pde =3D 0000000000000000
[   10.052172] Oops: 0000 [#1] PREEMPT SMP PTI
[   10.052172] CPU: 1 PID: 2764 Comm: update-binfmts Not tainted
5.9.0-next-20201015+ #154
[   10.065205] Hardware name: LENOVO 17097HU/17097HU, BIOS 7BETD8WW
(2.19 ) 03/31/2011
[   10.065205] EIP: __kernel_write+0xd4/0x230
[   10.065205] Code: 89 d6 64 8b 15 b4 77 4c c5 8b 8a 38 0b 00 00 31
d2 85 c9 74 04 0f b7 51 30 66 89 75 e8 8b 75 ac 8d 4d b0 89 45 e4 66
89 55 ea <8b> 06 8b 56 04 57 6a 01 89 45 d4 8d 45 b8 89 55 d8 ba 01 00
00 00
[   10.065205] EAX: 00020000 EBX: c192d640 ECX: c2b89ad0 EDX: 00000000
[   10.065205] ESI: 00000000 EDI: 0000012c EBP: c2b89b20 ESP: c2b89acc
[   10.065205] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS:
00010282
[   10.065205] CR0: 80050033 CR2: 00000000 CR3: 03414000 CR4: 000006b0
[   10.065205] Call Trace:
[   10.065205]  ? __mutex_unlock_slowpath+0x2b/0x2c0
[   10.065205]  ? dma_direct_map_sg+0x13a/0x320
[   10.065205]  autofs_notify_daemon+0x14d/0x2b0
[   10.065205]  autofs_wait+0x4cd/0x770
[   10.065205]  ? autofs_d_automount+0xd6/0x1e0
[   10.065205]  autofs_mount_wait+0x43/0xe0
[   10.065205]  autofs_d_automount+0xdf/0x1e0
[   10.065205]  __traverse_mounts+0x85/0x200
[   10.065205]  step_into+0x368/0x620
[   10.065205]  ? proc_setup_thread_self+0x110/0x110
[   10.065205]  walk_component+0x58/0x190
[   10.065205]  link_path_walk.part.0+0x245/0x360
[   10.065205]  path_lookupat.isra.0+0x31/0x130
[   10.065205]  filename_lookup+0x8d/0x130
[   10.065205]  ? cache_alloc_debugcheck_after+0x151/0x180
[   10.065205]  ? getname_flags+0x1f/0x160
[   10.065205]  ? kmem_cache_alloc+0x75/0x100
[   10.065205]  user_path_at_empty+0x25/0x30
[   10.065205]  vfs_statx+0x63/0x100
[   10.065205]  ? _raw_spin_unlock+0x18/0x30
[   10.065205]  ? replace_page_cache_page+0x160/0x160
[   10.065205]  __do_sys_stat64+0x36/0x60
[   10.065205]  ? exit_to_user_mode_prepare+0x35/0xe0
[   10.065205]  ? irqentry_exit_to_user_mode+0x8/0x20
[   10.065205]  ? irqentry_exit+0x55/0x70
[   10.065205]  ? exc_page_fault+0x228/0x3c0
[   10.065205]  __ia32_sys_stat64+0xd/0x10
[   10.065205]  do_int80_syscall_32+0x2c/0x40
[   10.065205]  entry_INT80_32+0x111/0x111
[   10.065205] EIP: 0xb7f03092
[   10.065205] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30
00 00 00 e9 80 ff ff ff ff a3 e8 ff ff ff 66 90 00 00 00 00 00 00 00
00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4
26 00
[   10.065205] EAX: ffffffda EBX: 004fa490 ECX: bfaf7e6c EDX: 004f9348
[   10.065205] ESI: 00000000 EDI: 004fa490 EBP: bfaf7e6c ESP: bfaf7e44
[   10.065205] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS:
00000296
[   10.065205] Modules linked in:
[   10.065205] CR2: 0000000000000000
[   10.073216] ---[ end trace 13a709ba02b08366 ]---
[   10.073221] EIP: __kernel_write+0xd4/0x230
[   10.073224] Code: 89 d6 64 8b 15 b4 77 4c c5 8b 8a 38 0b 00 00 31
d2 85 c9 74 04 0f b7 51 30 66 89 75 e8 8b 75 ac 8d 4d b0 89 45 e4 66
89 55 ea <8b> 06 8b 56 04 57 6a 01 89 45 d4 8d 45 b8 89 55 d8 ba 01 00
00 00
[   10.073226] EAX: 00020000 EBX: c192d640 ECX: c2b89ad0 EDX: 00000000
[   10.073228] ESI: 00000000 EDI: 0000012c EBP: c2b89b20 ESP: c2b89acc
[   10.073230] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS:
00010282
[   10.073232] CR0: 80050033 CR2: b7e10020 CR3: 03414000 CR4: 000006b0
[   10.453818] systemd-journald[2512]: Received request to flush
runtime journal from PID 1
[   24.752167] iwl3945 0000:03:00.0: loaded firmware version 15.32.2.9

> And we should check if that difference to what was originally
> there is the source of the problem, so probably two things to
> follow up on, reverting that small difference first would be
> the way to go.
>=20
> Are you able to reliably reproduce it?

Looks so, yes.

Best regards,
								Pavel

--=20
http://www.livejournal.com/~pavelmachek

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl+KwToACgkQMOfwapXb+vIIvgCfdMHvaaR45ZlAc3B4KuEcsU2l
ih4Anjqtvg4aK6pE84L1NWwoLKcLj4U5
=rzWF
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
