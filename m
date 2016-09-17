From: Mateusz Guzik <mguzik@redhat.com>
Subject: Re: [PATCH 3/4] autofs - make mountpoint checks namespace aware
Date: Sat, 17 Sep 2016 22:10:02 +0200
Message-ID: <20160917201000.omswgttgyzcu7jt6@mguzik>
References: <20160914061434.24714.490.stgit@pluto.themaw.net>
 <20160914061445.24714.68331.stgit@pluto.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160914061445.24714.68331.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, "Eric W. Biederman" <ebiederm@xmission.com>

On Wed, Sep 14, 2016 at 02:14:45PM +0800, Ian Kent wrote:
> If an automount mount is clone(2)ed into a file system that is
> propagation private, when it later expires in the originating
> namespace subsequent calls to autofs ->d_automount() for that
> dentry in the original namespace will return ELOOP until the
> mount is manually umounted in the cloned namespace.
> 
> In the same way, if an autofs mount is triggered by automount(8)
> running within a container the dentry will be seen as mounted in
> the root init namespace and calls to ->d_automount() in that namespace
> will return ELOOP until the mount is umounted within the container.
> 
> Also, have_submounts() can return an incorect result when a mount
> exists in a namespace other than the one being checked.
> 
> @@ -460,7 +460,7 @@ static int autofs4_d_manage(struct dentry *dentry, bool rcu_walk)
>  
>  		if (ino->flags & AUTOFS_INF_WANT_EXPIRE)
>  			return 0;
> -		if (d_mountpoint(dentry))
> +		if (is_local_mountpoint(dentry))
>  			return 0;
>  		inode = d_inode_rcu(dentry);
>  		if (inode && S_ISLNK(inode->i_mode))

This change is within RCU lookup.

is_local_mountpoint may end up calling __is_local_mountpoint, which will
optionally take the namespace_sem lock, resulting in a splat:

 #0:  (&(&sbi->fs_lock)->rlock){+.+...}, at: [<ffffffff816a4572>] autofs4_d_manage+0x202/0x290^M
Preemption disabled at:[<ffffffff816a4572>] autofs4_d_manage+0x202/0x290^M
^M
CPU: 1 PID: 1307 Comm: iknowthis Not tainted 4.8.0-rc6-next-20160916dupa #448^M
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011^M
 ffff8800077378f8 ffffffff818eaffc 0000000000000001 0000000000000000^M
 ffff880007737930 ffffffff8110c870 ffff880007588048 ffffffff82483840^M
 0000000000000015 0000000000000000 ffff880007588040 ffff880007737978^M
Call Trace:^M
 [<ffffffff818eaffc>] dump_stack+0x85/0xc9^M
 [<ffffffff8110c870>] ___might_sleep+0x1e0/0x2e0^M
 [<ffffffff8110c9e1>] __might_sleep+0x71/0xe0^M
 [<ffffffff8110d039>] ? preempt_count_sub+0x39/0x80^M
 [<ffffffff8220352a>] down_read+0x2a/0xc0^M
 [<ffffffff813f7ec6>] __is_local_mountpoint+0x66/0xe0^M
 [<ffffffff816a45d3>] autofs4_d_manage+0x263/0x290^M
 [<ffffffff813d1a47>] follow_managed+0x157/0x480^M
 [<ffffffff813d6b5b>] lookup_fast+0x3ab/0x690^M
 [<ffffffff813d67b0>] ? trailing_symlink+0x370/0x370^M
 [<ffffffff813d7757>] ? path_init+0x917/0xa10^M
 [<ffffffff811525e7>] ? __mutex_init+0x77/0x80^M
 [<ffffffff813d910c>] path_openat+0x2bc/0x13e0^M
 [<ffffffff813d8e50>] ? path_lookupat+0x1f0/0x1f0^M
 [<ffffffff8137e48f>] ? __asan_loadN+0xf/0x20^M
 [<ffffffff81088776>] ? pvclock_clocksource_read+0xd6/0x180^M
 [<ffffffff810870d3>] ? kvm_clock_read+0x23/0x40^M
 [<ffffffff813dc3a2>] do_filp_open+0x122/0x1c0^M
 [<ffffffff8110d039>] ? preempt_count_sub+0x39/0x80^M
 [<ffffffff813dc280>] ? may_open_dev+0x50/0x50^M
 [<ffffffff8110cf88>] ? preempt_count_sub.part.67+0x18/0x90^M
 [<ffffffff8110d039>] ? preempt_count_sub+0x39/0x80^M
 [<ffffffff82207c31>] ? _raw_spin_unlock+0x31/0x50^M
 [<ffffffff813f6061>] ? __alloc_fd+0x141/0x2b0^M
 [<ffffffff813bd02c>] do_sys_open+0x17c/0x2c0^M
 [<ffffffff813bceb0>] ? filp_open+0x60/0x60^M
 [<ffffffff8100201a>] ? trace_hardirqs_on_thunk+0x1a/0x1c^M
 [<ffffffff813bd18e>] SyS_open+0x1e/0x20^M
 [<ffffffff82208701>] entry_SYSCALL_64_fastpath+0x1f/0xc2^M
 [<ffffffff811549e5>] ? trace_hardirqs_off_caller+0xc5/0x120^M

I don't know this code. Perhaps it will be perfectly fine performance wise to
just drop out of RCU lookup in this case.

-- 
Mateusz Guzik
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
