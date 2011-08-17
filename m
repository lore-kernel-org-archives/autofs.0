From: Ian Kent <raven@themaw.net>
Subject: Re: autofs4 past 2.6.38: how to make it work?
Date: Wed, 17 Aug 2011 11:07:39 +0800
Message-ID: <1313550460.4418.5.camel@perseus.themaw.net>
References: <4E4975AB.4050201@msgid.tls.msk.ru>
 <4E497B43.4010600@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
 messagingengine.com; h=subject:from:to:cc:in-reply-to:references
 :content-type:date:message-id:mime-version
 :content-transfer-encoding; s=smtpout; bh=idaLZMs3CZdPsXWm8KFLpU
 egh8k=; b=SWdXS3JJ85NghS6BXMi5HDbTRZrh7EhGa8dSUr93Mz4oE5ZLB7kx0q
 kt5UXyaDrRp0J7dz0SOjgHrboVgwiZUR6e4laWSVMJOHAzLRHpFdZqPfKr6qS/Y8
 7qzT+TqhuQjAVNSHQpwpm3AM9QLwn9YZ0biw5BcWso6dolpj+6Nxk=
In-Reply-To: <4E497B43.4010600@msgid.tls.msk.ru>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
 <mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
 <mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: autofs@linux.kernel.org

On Tue, 2011-08-16 at 00:02 +0400, Michael Tokarev wrote:
> After searching a bit more, especially after realizing
> it's not 2.6.37+ but 2.6.38+ (so I corrected $subject),
> I found a few references to this, especially
> https://bugzilla.redhat.com/show_bug.cgi?id=719607
> and a few more (most of which are without answers).
> 
> I tested the patch proposed in RH#719607 (attachtment
> #512209) - it restores functionality of automounter,
> at least as far as I can see.
> 
> I think it should go to -stable, too... ;)

That path (actually a different equivalent patch) is included in 3.1-rc.

There were major changes to the kernel automount code in the 2.6.38 and
there have been a number of corrections along the way, with this patch
being the last one for known problems.

I recommend staying with 2.6.37 until 3.1 is available.

> 
> Thanks,
> 
> /mjt
> 
> 
> 15.08.2011 23:38, Michael Tokarev wrote:
> > Hello.
> > 
> > I found out that since 2.6.37 kernel, my automount (neither
> > debian version 5.0.4-3.2 nor the latest 5.0.6) does not work
> > anymore.
> > 
> > Automounter starts correctly, mounts - say - /misc, and stays
> > there listening for events.
> > 
> > But the problem is that no events gets delivered to it no
> > matter how I try.  Accesses to /misc/foo always returns
> > immediately with ENOENT error, and automount (all threads
> > of it) is sleeping without any activity whatsoever.
> > 
> > I tried to bisect this issue, but faced some problems --
> > most kernels around the bad commit OOPSes while accessing
> > /misc/foo.  Here's the bisect log:
> > 
> > # good: [22763c5cf3690a681551162c15d34d935308c8d7] Linux 2.6.32
> > git bisect good 22763c5cf3690a681551162c15d34d935308c8d7
> > # bad: [521cb40b0c44418a4fd36dc633f575813d59a43d] Linux 2.6.38
> > git bisect bad 521cb40b0c44418a4fd36dc633f575813d59a43d
> > # skip: [b7ab39f631f505edc2bbdb86620d5493f995c9da] fs: dcache scale dentry refcount
> > git bisect skip b7ab39f631f505edc2bbdb86620d5493f995c9da
> > # good: [cb4b492ac7595aad10756fe0b04691f0965e0cfc] autofs4: rename dentry to expiring in autofs4_lookup_expiring()
> > git bisect good cb4b492ac7595aad10756fe0b04691f0965e0cfc
> > # good: [5f57cbcc02cf18f6b22ef4066bb10afeb8f930ff] fs: dcache remove d_mounted
> > git bisect good 5f57cbcc02cf18f6b22ef4066bb10afeb8f930ff
> > # skip: [ab90911ff90cdab59b31c045c3f0ae480d14f29d] Allow d_manage() to be used in RCU-walk mode
> > git bisect skip ab90911ff90cdab59b31c045c3f0ae480d14f29d
> > # skip: [cc53ce53c86924bfe98a12ea20b7465038a08792] Add a dentry op to allow processes to be held during pathwalk transit
> > git bisect skip cc53ce53c86924bfe98a12ea20b7465038a08792
> > # skip: [6651149371b842715906311b4631b8489cebf7e8] autofs4: Clean up autofs4_free_ino()
> > git bisect skip 6651149371b842715906311b4631b8489cebf7e8
> > # bad: [726a5e0688fd344110d8f2979d87f243a4ba1a48] autofs4: autofs4_get_inode() doesn't need autofs_info * argument anymore
> > git bisect bad 726a5e0688fd344110d8f2979d87f243a4ba1a48
> > # skip: [9e3fea16ba386fa549a0b2de8a203e5d412997a0] autofs4: Fix wait validation
> > git bisect skip 9e3fea16ba386fa549a0b2de8a203e5d412997a0
> > # bad: [14a2f00bde7668fe18d1c8355d26c7c96961e1f7] autofs4: autofs4_mkroot() is not different from autofs4_init_ino()
> > git bisect bad 14a2f00bde7668fe18d1c8355d26c7c96961e1f7
> > # skip: [71e469db242c2eeb00faf9caf7d9e00150c00a6e] autofs4: Clean up dentry operations
> > git bisect skip 71e469db242c2eeb00faf9caf7d9e00150c00a6e
> > # bad: [c14cc63a63e94d490ac6517a555113c30d420db4] autofs4 - fix get_next_positive_dentry()
> > git bisect bad c14cc63a63e94d490ac6517a555113c30d420db4
> > # skip: [e61da20a50d21725ff27571a6dff9468e4fb7146] autofs4: Clean up inode operations
> > git bisect skip e61da20a50d21725ff27571a6dff9468e4fb7146
> > # skip: [dd89f90d2deb9aa5bc8e1b15d726ff5c0bb2b623] autofs4: Add v4 pseudo direct mount support
> > git bisect skip dd89f90d2deb9aa5bc8e1b15d726ff5c0bb2b623
> > # skip: [8c13a676d5a56495c350f3141824a5ef6c6b4606] autofs4: Remove unused code
> > git bisect skip 8c13a676d5a56495c350f3141824a5ef6c6b4606
> > # bad: [b650c858c26bd9ba29ebc82d30f09355845a294a] autofs4: Merge the remaining dentry ops tables
> > git bisect bad b650c858c26bd9ba29ebc82d30f09355845a294a
> > # skip: [b5b801779d59165c4ecf1009009109545bd1f642] autofs4: Add d_manage() dentry operation
> > git bisect skip b5b801779d59165c4ecf1009009109545bd1f642
> > # skip: [b5b801779d59165c4ecf1009009109545bd1f642] autofs4: Add d_manage() dentry operation
> > git bisect skip b5b801779d59165c4ecf1009009109545bd1f642
> > # skip: [b5b801779d59165c4ecf1009009109545bd1f642] autofs4: Add d_manage() dentry operation
> > git bisect skip b5b801779d59165c4ecf1009009109545bd1f642
> > 
> > Kernel b5b801779d59165c4ecf1009009109545bd1f642 shows this OOPS:
> > 
> > [   11.700752] ------------[ cut here ]------------
> > [   11.703371] kernel BUG at fs/dcache.c:1304!
> > [   11.703371] invalid opcode: 0000 [#1] SMP
> > [   11.703371] last sysfs file: /sys/devices/virtual/vc/vcsa6/dev
> > [   11.703371] CPU 0
> > [   11.703371] Modules linked in: ext4 mbcache jbd2 crc16 virtio_net virtio_pci virtio_blk virtio virtio_ring nfs lockd nfs_acl auth_rpcgss sunrpc autofs4
> > [   11.703371]
> > [   11.703371] Pid: 599, comm: automount Not tainted 2.6.37+ #36 /Bochs
> > [   11.703371] RIP: 0010:[<ffffffff810c290c>]  [<ffffffff810c290c>] d_set_d_op+0x4c/0x60
> > [   11.703371] RSP: 0018:ffff88000794be70  EFLAGS: 00010286
> > [   11.703371] RAX: ffff8800070d7380 RBX: ffff88000794fe00 RCX: 000000000000000e
> > [   11.703371] RDX: 0000000000000000 RSI: ffffffffa0004500 RDI: ffff8800070ea080
> > [   11.703371] RBP: ffff8800070ea080 R08: 0000000000000002 R09: 0000000000000000
> > [   11.703371] R10: ffff88000794bdc8 R11: 0000000000000001 R12: ffff8800070056f0
> > [   11.703371] R13: ffff88000719b090 R14: ffff880006d8b840 R15: 0000000000000000
> > [   11.703371] FS:  0000000000000000(0000) GS:ffff880007c00000(0063) knlGS:00000000f6d00b70
> > [   11.703371] CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
> > [   11.703371] CR2: 00000000f6bff000 CR3: 0000000007be1000 CR4: 00000000000006b0
> > [   11.703371] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [   11.703371] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> > [   11.703371] Process automount (pid: 599, threadinfo ffff88000794a000, task ffff880006860290)
> > [   11.703371] Stack:
> > [   11.703371]  ffffffffa000124a 00000000f6cfa8ac 000000000000016d ffff8800070ea080
> > [   11.703371]  0000000000000000 0000000000000000 ffffffff810bdcf3 ffff880006e986c0
> > [   11.703371]  ffff8800070d7380 000000051192d652 ffff880007901006 0000000000000000
> > [   11.703371] Call Trace:
> > [   11.703371]  [<ffffffffa000124a>] ? autofs4_dir_mkdir+0x1ba/0x1e0 [autofs4]
> > [   11.703371]  [<ffffffff810bdcf3>] ? sys_mkdirat+0x113/0x130
> > [   11.703371]  [<ffffffff8102787c>] ? cstar_dispatch+0x7/0x32
> > [   11.703371] Code: 10 00 00 48 83 7e 10 00 74 06 81 0f 00 20 00 00 48 83 3e 00 74 06 81 0f 00 40 00 00 48 83 7e 18 00 74 06 81 0f 00 80 00 00 f3 c3 <0f> 0b eb fe 0f 0b eb fe 66 66 66 2e 0f 1f 84 00 00 00 00 00 48
> > [   11.703371] RIP  [<ffffffff810c290c>] d_set_d_op+0x4c/0x60
> > [   11.703371]  RSP <ffff88000794be70>
> > [   11.754054] ---[ end trace 1c0705f21da3ac3a ]---
> > 
> > As far as I can see, there are users who successfully used autofs
> > with kernels >= 2.6.37, so I'm really curious how they did that.
> > No kernel since 2.6.37 and up to current 3.0 works for me.
> > 
> > Any hints?
> > 
> > Thank you!
> > 
> > /mjt
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
