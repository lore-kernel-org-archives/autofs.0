From: Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: Commit 13c164b1a186 - regression for LSMs/SELinux?
Date: Tue, 22 Sep 2020 09:33:50 +0200
Message-ID: <CAFqZXNsBqvCj0NjEd9+C0H1EPjz7Fst296AA5eOFSVx=SKjfOg@mail.gmail.com>
References: <CAFqZXNsoXr1eA4C8==Nvujs5ONpRnuSqaOQQ0n78R=Dbm-EFGA@mail.gmail.com>
 <20200921160922.GA23870@lst.de> <20200921163011.GZ3421308@ZenIV.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-security-module-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600760045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PLNLNqxOlhhIUOsZLkynKysFiUo4YS4/xLJlG3EgM6o=;
        b=LU7NOCbfeaZdGhstszFsvV2zEeOBW+lC0x7W8+HqdI4+MjjT2lzLT7m5ABM5FHy4oLZZXM
        QgDJy0XlvG3ZQILtCtm9Er84ygccZnDlx6s1kbqO+i/9ep4om5n2bwA9ztml3BppGwR1/M
        4GlQ0RW8PRkk0LqLa4qZgyae5sBpuiU=
In-Reply-To: <20200921163011.GZ3421308@ZenIV.linux.org.uk>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, Ian Kent <raven@themaw.net>, autofs@vger.kernel.org, Linux Security Module list <linux-security-module@vger.kernel.org>, SElinux list <selinux@vger.kernel.org>, Zdenek Pytela <zpytela@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Smalley <stephen.smalley.work@gmail.com>

On Mon, Sep 21, 2020 at 6:30 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Mon, Sep 21, 2020 at 06:09:22PM +0200, Christoph Hellwig wrote:
> > [adding Linus and Al]
> >
> > On Mon, Sep 21, 2020 at 04:51:35PM +0200, Ondrej Mosnacek wrote:
> > > Hi folks,
> > >
> > > It seems that after commit 13c164b1a186 ("autofs: switch to
> > > kernel_write") there is now an extra LSM permission required (for the
> > > current task to write to the automount pipe) for processes accessing
> > > some yet-to-to-be mounted directory on which an autofs mount is set
> > > up. The call chain is:
> > > [...]
> > > autofs_wait() ->
> > > autofs_notify_daemon() ->
> > > autofs_write() ->
> > > kernel_write() ->
> > > rw_verify_area() ->
> > > security_file_permission()
> > >
> > > The bug report that led me to this commit is at [1].
> > >
> > > Technically, this is a regression for LSM users, since this is a
> > > kernel-internal operation and an LSM permission for the current task
> > > shouldn't be required. Can this patch be reverted? Perhaps
> > > __kernel_{read|write}() could instead be renamed to kernel_*_nocheck()
> > > so that the name is more descriptive?
> >
> > So we obviously should not break existing user space and need to fix
> > this ASAP.  The trivial "fix" would be to export __kernel_write again
> > and switch autofs to use it.  The other option would be a FMODE flag
> > to bypass security checks, only to be set if the callers ensures
> > they've been valided (i.e. in autofs_prepare_pipe).

IMHO that sounds like an overkill in this scenario. I don't think it
makes sense to do the LSM check here (or at least not against the
current task's creds), because it is not the current task that wants
to communicate with the daemon, it just wants to to access some
directory on the system that just happens to be special to the kernel,
which needs to do some communication on the side to service this
request. So if we do want to do any LSM check here, there should at
least be some "bool internal" flag passed to the LSM, signalizing that
this is an internal read/write operation that wasn't directly
initiated/requested by the current process. SELinux could then either
use the kernel secid instead of the current task's secid or skip the
check completely in such case.

I'd like Stephen to weigh in on this, but it looks he might be on
vacation right now...

> >
> > Any opinions?
>
> Reexport for now.  Incidentally, what is LSM doing rejecting writes
> into a pipe?

With SELinux at least, what is allowed or denied is defined in the
policy. And the policy usually defaults to everything denied and then
you add rules to allow what needs (and makes sense) to be allowed.
Since until kernel 5.8 random processes didn't need to write to pipes
created by the automount daemon, it has never been explicitly allowed
and so the automounting now fails. It is in no way obvious that all
processes should have the permission to talk to the automount daemon
just to traverse the filesystem...

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

