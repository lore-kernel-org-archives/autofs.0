From: Christoph Hellwig <hch@lst.de>
Subject: Re: Commit 13c164b1a186 - regression for LSMs/SELinux?
Date: Mon, 21 Sep 2020 18:09:22 +0200
Message-ID: <20200921160922.GA23870@lst.de>
References: <CAFqZXNsoXr1eA4C8==Nvujs5ONpRnuSqaOQQ0n78R=Dbm-EFGA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-security-module-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFqZXNsoXr1eA4C8==Nvujs5ONpRnuSqaOQQ0n78R=Dbm-EFGA@mail.gmail.com>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Ian Kent <raven@themaw.net>, autofs@vger.kernel.org, Linux Security Module list <linux-security-module@vger.kernel.org>, SElinux list <selinux@vger.kernel.org>, Zdenek Pytela <zpytela@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>

[adding Linus and Al]

On Mon, Sep 21, 2020 at 04:51:35PM +0200, Ondrej Mosnacek wrote:
> Hi folks,
> 
> It seems that after commit 13c164b1a186 ("autofs: switch to
> kernel_write") there is now an extra LSM permission required (for the
> current task to write to the automount pipe) for processes accessing
> some yet-to-to-be mounted directory on which an autofs mount is set
> up. The call chain is:
> [...]
> autofs_wait() ->
> autofs_notify_daemon() ->
> autofs_write() ->
> kernel_write() ->
> rw_verify_area() ->
> security_file_permission()
> 
> The bug report that led me to this commit is at [1].
> 
> Technically, this is a regression for LSM users, since this is a
> kernel-internal operation and an LSM permission for the current task
> shouldn't be required. Can this patch be reverted? Perhaps
> __kernel_{read|write}() could instead be renamed to kernel_*_nocheck()
> so that the name is more descriptive?

So we obviously should not break existing user space and need to fix
this ASAP.  The trivial "fix" would be to export __kernel_write again
and switch autofs to use it.  The other option would be a FMODE flag
to bypass security checks, only to be set if the callers ensures
they've been valided (i.e. in autofs_prepare_pipe).

Any opinions?
