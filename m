From: Ian Kent <raven@themaw.net>
Subject: Re: Commit 13c164b1a186 - regression for LSMs/SELinux?
Date: Wed, 23 Sep 2020 09:55:07 +0800
Message-ID: <0764629d33d151aee743d0429ac87a5b0c300235.camel@themaw.net>
References: <CAFqZXNsoXr1eA4C8==Nvujs5ONpRnuSqaOQQ0n78R=Dbm-EFGA@mail.gmail.com>
         <20200921160922.GA23870@lst.de>
         <20200921163011.GZ3421308@ZenIV.linux.org.uk>
         <CAFqZXNsBqvCj0NjEd9+C0H1EPjz7Fst296AA5eOFSVx=SKjfOg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-security-module-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        upiM+ps2iylCJwR0Y5k0EaubVoVcvjREARfubzQL5PE=; b=au8olLs0jmhkc5PY
        ldppotT1EOXipsk1kR+s+IO4jj8r685ipoVWLUz47rMQzzVKEz87oZNfCEh13bdf
        g4jl6jDvun+dllI35EHg0QbZLsaAccBxkmT1dPEHZ/p+6REGyARGj0dSIl2VTMjz
        P2GcP1OUw9sRQ8oU38L2Twt6Dwt97eiqv/rYPz34TQOYanVPpy8g+04ajcexX2Hp
        rrHMqLpjd4FnXsZFUg9lh09Cd0kbd6ow0MhXiNtrcSmOlX7lwtWGOnxrQT3/Louz
        x5XEyQmB2xuf4s6w+9gA+pdzvSa4PpuYd5sIdtarVOlYkY0e5qj9yRo228RoqXB6
        DZLnIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=upiM+ps2iylCJwR0Y5k0EaubVoVcvjREARfubzQL5
        PE=; b=Z3VxcDFzyxLcnpMPp7Z9ARxuFT3j4H/7vb4aeaiWMYT/6yeHQoyvQnRS4
        N5aAupvWVXTLFbLX2DaK8DcBhCfRnTKEW23DjxjF/V7tWLujWY7NHeJz93CLFV+6
        kfnilsneen8NpCtGwC9t/jAKy/6Ntslp6fioeAmAo5HEo36uLnD3BxxcXK/3v4U8
        VLXlqr+61n5Tpqll6HBlgWejvJrYB63ph1UMgGIEuj2C7BiWMaH1rc+FIm4FJWSB
        SeiIc7+rwrVXLdLp/1xm1l6PaBAbxGDJizd3JIreDaXMSQzR1/+Ji3Pg9bwzaEYD
        1hzhGf7RBlBLxqNrk+NromXHiTRmw==
In-Reply-To: <CAFqZXNsBqvCj0NjEd9+C0H1EPjz7Fst296AA5eOFSVx=SKjfOg@mail.gmail.com>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ondrej Mosnacek <omosnace@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, autofs@vger.kernel.org, Linux Security Module list <linux-security-module@vger.kernel.org>, SElinux list <selinux@vger.kernel.org>, Zdenek Pytela <zpytela@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>

On Tue, 2020-09-22 at 09:33 +0200, Ondrej Mosnacek wrote:
> On Mon, Sep 21, 2020 at 6:30 PM Al Viro <viro@zeniv.linux.org.uk>
> wrote:
> > On Mon, Sep 21, 2020 at 06:09:22PM +0200, Christoph Hellwig wrote:
> > > [adding Linus and Al]
> > > 
> > > On Mon, Sep 21, 2020 at 04:51:35PM +0200, Ondrej Mosnacek wrote:
> > > > Hi folks,
> > > > 
> > > > It seems that after commit 13c164b1a186 ("autofs: switch to
> > > > kernel_write") there is now an extra LSM permission required
> > > > (for the
> > > > current task to write to the automount pipe) for processes
> > > > accessing
> > > > some yet-to-to-be mounted directory on which an autofs mount is
> > > > set
> > > > up. The call chain is:
> > > > [...]
> > > > autofs_wait() ->
> > > > autofs_notify_daemon() ->
> > > > autofs_write() ->
> > > > kernel_write() ->
> > > > rw_verify_area() ->
> > > > security_file_permission()
> > > > 
> > > > The bug report that led me to this commit is at [1].
> > > > 
> > > > Technically, this is a regression for LSM users, since this is
> > > > a
> > > > kernel-internal operation and an LSM permission for the current
> > > > task
> > > > shouldn't be required. Can this patch be reverted? Perhaps
> > > > __kernel_{read|write}() could instead be renamed to
> > > > kernel_*_nocheck()
> > > > so that the name is more descriptive?
> > > 
> > > So we obviously should not break existing user space and need to
> > > fix
> > > this ASAP.  The trivial "fix" would be to export __kernel_write
> > > again
> > > and switch autofs to use it.  The other option would be a FMODE
> > > flag
> > > to bypass security checks, only to be set if the callers ensures
> > > they've been valided (i.e. in autofs_prepare_pipe).
> 
> IMHO that sounds like an overkill in this scenario. I don't think it
> makes sense to do the LSM check here (or at least not against the
> current task's creds), because it is not the current task that wants
> to communicate with the daemon, it just wants to to access some
> directory on the system that just happens to be special to the
> kernel,
> which needs to do some communication on the side to service this
> request. So if we do want to do any LSM check here, there should at
> least be some "bool internal" flag passed to the LSM, signalizing
> that
> this is an internal read/write operation that wasn't directly
> initiated/requested by the current process. SELinux could then either
> use the kernel secid instead of the current task's secid or skip the
> check completely in such case.

Perhaps, but see below.

> 
> I'd like Stephen to weigh in on this, but it looks he might be on
> vacation right now...
> 
> > > Any opinions?
> > 
> > Reexport for now.  Incidentally, what is LSM doing rejecting writes
> > into a pipe?
> 
> With SELinux at least, what is allowed or denied is defined in the
> policy. And the policy usually defaults to everything denied and then
> you add rules to allow what needs (and makes sense) to be allowed.
> Since until kernel 5.8 random processes didn't need to write to pipes
> created by the automount daemon, it has never been explicitly allowed
> and so the automounting now fails. It is in no way obvious that all
> processes should have the permission to talk to the automount daemon
> just to traverse the filesystem...

I think you might have misunderstood what lead to this, just a bit.

Previously the __kern_write() function was used for this communication
and Christoph's patch changed that to use kern_write() instead.

In theory that's a good idea because kern_write() adds some additional
sanity checks, one being a call to rw_verify_area() which is where the
security_file_permission() call fails.

So previously any random process could avoid these checks by calling
__kern_write() so the change to kern_write() is, in theory, that's a
good thing and simply reverting that hunk in Christoph's patch
probably isn't the best thing to do.

But any random process does need to be able to write to the automount
daemon pipe for trailing path components and the root dentry of autofs
mounts, depending on case.

So it's true that any write to any autofs dentry probably doesn't
need to be allowed but I question what that gets us in terms of
security improvement over allowing pipe writes for automount_t
labelled pipes in selinux policy since they must be within an autofs
mounted file system.

But Stephen has a different recommendation (and that appears to
consider the cause I outlined above) so I'll wait to see what others
think about the recommendations.

Ian

