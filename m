From: Ian Kent <raven@themaw.net>
Subject: Re: Commit 13c164b1a186 - regression for LSMs/SELinux?
Date: Thu, 24 Sep 2020 17:47:57 +0800
Message-ID: <cdce427f2a2cde80923ae2608605a1c8cf81b87e.camel@themaw.net>
References: <CAFqZXNsoXr1eA4C8==Nvujs5ONpRnuSqaOQQ0n78R=Dbm-EFGA@mail.gmail.com>
         <20200921160922.GA23870@lst.de>
         <20200921163011.GZ3421308@ZenIV.linux.org.uk>
         <CAFqZXNsBqvCj0NjEd9+C0H1EPjz7Fst296AA5eOFSVx=SKjfOg@mail.gmail.com>
         <0764629d33d151aee743d0429ac87a5b0c300235.camel@themaw.net>
         <CAFqZXNsqD73hptXxBn+g98ngbFd=Sx+CghtwVqM+NC47VFZhVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-security-module-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        7YHXsnpL6KHOY1Czsp2sSjB4pWt0nEHERUAeErRFatg=; b=knpk5rmiJXmMfrkF
        /Qiq4UEv3oMxsqF/QTaI3dTMYyI0Xm2wCOaftlnUFcqj1wr9jmIM4mcFxA1kRmZi
        FmFluQq5SvlTbY/4Xoki7+CWVhmJNIatOWOfYiq4KZFxteNEErGVI2JRutyjO3En
        9V9Zop7GSIuB4rbLO4jaQa+vLrZZ3B7DxZrjtLrJUVYrfhB+wfsrZAf0EHNdbS5m
        eq8rFXogd4WqAKtlCiYlQg+DT5V0vrAKQ8DHxWyqv2EZahJ05M8IOdcG/mMQE1d4
        Mll/qJxpesoutVi849R0muB+ZM9GVjlZLCo3Q6rLePfsWiQ6XPnNTU2ObcK3o3VB
        p/3i7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=7YHXsnpL6KHOY1Czsp2sSjB4pWt0nEHERUAeErRFa
        tg=; b=pwT3yPDkD/Wz9T5Bs/3B0aEbMExL6xbHwTjnAyjYepO/sw6w+dfM4fprV
        s7a+mlhuyCxuEjsUu6H14wSD/iXc6CveM/OcjRlR5lpyEZtiKNbEADUZUpPalZ5V
        4hM+HzgeU88IxsEKWCD5aTi9prIz/xDBiKWg6HPSy5o+nizi/cJoZAAJy6C/OOPr
        yac8Um8oDkK7ib9jhze4ev29MACNvyV9Rxrz1dBbLmMfl2AAk1VT9deHlKlkLWTC
        DbxBZQ0I/AlqCVL58R7nCyOzdYOPJhClr3o0WGAWI5iu80/WOmcLqtODalwf2nPt
        3Syq7QsBcVPHTYdgZIZQqMRguaDYg==
In-Reply-To: <CAFqZXNsqD73hptXxBn+g98ngbFd=Sx+CghtwVqM+NC47VFZhVQ@mail.gmail.com>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, autofs@vger.kernel.org, Linux Security Module list <linux-security-module@vger.kernel.org>, SElinux list <selinux@vger.kernel.org>, Zdenek Pytela <zpytela@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Smalley <stephen.smalley.work@gmail.com>

On Thu, 2020-09-24 at 10:36 +0200, Ondrej Mosnacek wrote:
> On Wed, Sep 23, 2020 at 3:55 AM Ian Kent <raven@themaw.net> wrote:
> > On Tue, 2020-09-22 at 09:33 +0200, Ondrej Mosnacek wrote:
> > > On Mon, Sep 21, 2020 at 6:30 PM Al Viro <viro@zeniv.linux.org.uk>
> > > wrote:
> > > > On Mon, Sep 21, 2020 at 06:09:22PM +0200, Christoph Hellwig
> > > > wrote:
> > > > > [adding Linus and Al]
> > > > > 
> > > > > On Mon, Sep 21, 2020 at 04:51:35PM +0200, Ondrej Mosnacek
> > > > > wrote:
> > > > > > Hi folks,
> > > > > > 
> > > > > > It seems that after commit 13c164b1a186 ("autofs: switch to
> > > > > > kernel_write") there is now an extra LSM permission
> > > > > > required
> > > > > > (for the
> > > > > > current task to write to the automount pipe) for processes
> > > > > > accessing
> > > > > > some yet-to-to-be mounted directory on which an autofs
> > > > > > mount is
> > > > > > set
> > > > > > up. The call chain is:
> > > > > > [...]
> > > > > > autofs_wait() ->
> > > > > > autofs_notify_daemon() ->
> > > > > > autofs_write() ->
> > > > > > kernel_write() ->
> > > > > > rw_verify_area() ->
> > > > > > security_file_permission()
> > > > > > 
> > > > > > The bug report that led me to this commit is at [1].
> > > > > > 
> > > > > > Technically, this is a regression for LSM users, since this
> > > > > > is
> > > > > > a
> > > > > > kernel-internal operation and an LSM permission for the
> > > > > > current
> > > > > > task
> > > > > > shouldn't be required. Can this patch be reverted? Perhaps
> > > > > > __kernel_{read|write}() could instead be renamed to
> > > > > > kernel_*_nocheck()
> > > > > > so that the name is more descriptive?
> > > > > 
> > > > > So we obviously should not break existing user space and need
> > > > > to
> > > > > fix
> > > > > this ASAP.  The trivial "fix" would be to export
> > > > > __kernel_write
> > > > > again
> > > > > and switch autofs to use it.  The other option would be a
> > > > > FMODE
> > > > > flag
> > > > > to bypass security checks, only to be set if the callers
> > > > > ensures
> > > > > they've been valided (i.e. in autofs_prepare_pipe).
> > > 
> > > IMHO that sounds like an overkill in this scenario. I don't think
> > > it
> > > makes sense to do the LSM check here (or at least not against the
> > > current task's creds), because it is not the current task that
> > > wants
> > > to communicate with the daemon, it just wants to to access some
> > > directory on the system that just happens to be special to the
> > > kernel,
> > > which needs to do some communication on the side to service this
> > > request. So if we do want to do any LSM check here, there should
> > > at
> > > least be some "bool internal" flag passed to the LSM, signalizing
> > > that
> > > this is an internal read/write operation that wasn't directly
> > > initiated/requested by the current process. SELinux could then
> > > either
> > > use the kernel secid instead of the current task's secid or skip
> > > the
> > > check completely in such case.
> > 
> > Perhaps, but see below.
> > 
> > > I'd like Stephen to weigh in on this, but it looks he might be on
> > > vacation right now...
> > > 
> > > > > Any opinions?
> > > > 
> > > > Reexport for now.  Incidentally, what is LSM doing rejecting
> > > > writes
> > > > into a pipe?
> > > 
> > > With SELinux at least, what is allowed or denied is defined in
> > > the
> > > policy. And the policy usually defaults to everything denied and
> > > then
> > > you add rules to allow what needs (and makes sense) to be
> > > allowed.
> > > Since until kernel 5.8 random processes didn't need to write to
> > > pipes
> > > created by the automount daemon, it has never been explicitly
> > > allowed
> > > and so the automounting now fails. It is in no way obvious that
> > > all
> > > processes should have the permission to talk to the automount
> > > daemon
> > > just to traverse the filesystem...
> > 
> > I think you might have misunderstood what lead to this, just a bit.
> > 
> > Previously the __kern_write() function was used for this
> > communication
> > and Christoph's patch changed that to use kern_write() instead.
> > 
> > In theory that's a good idea because kern_write() adds some
> > additional
> > sanity checks, one being a call to rw_verify_area() which is where
> > the
> > security_file_permission() call fails.
> > 
> > So previously any random process could avoid these checks by
> > calling
> > __kern_write() so the change to kern_write() is, in theory, that's
> > a
> > good thing and simply reverting that hunk in Christoph's patch
> > probably isn't the best thing to do.
> 
> I understand that and I'm not proposing the revert as a long-term
> fix.
> For a long-term solution I propose using kernel_write() and extending
> it to allow the caller to suppress (just) the
> security_file_permission() call. Then each caller would have to
> decide
> whether the LSM check makes sense in that situation or not. It seems
> safer against future mistakes than leaving it up to the caller to
> call
> security_file_permission() explicitly (I predict that no new user
> would even realize that the call might be needed).
> 
> > But any random process does need to be able to write to the
> > automount
> > daemon pipe for trailing path components and the root dentry of
> > autofs
> > mounts, depending on case.
> > 
> > So it's true that any write to any autofs dentry probably doesn't
> > need to be allowed but I question what that gets us in terms of
> > security improvement over allowing pipe writes for automount_t
> > labelled pipes in selinux policy since they must be within an
> > autofs
> > mounted file system.
> 
> The difference is not in security, but in usability. The kernel
> communicating with the autofs daemon is an internal detail that
> shouldn't need special rules in policy. Even if we want to do any LSM
> checking here, the subject should be kernel_t, not the current
> running
> process. The process doesn't have any control on whether the kernel
> does the communication and it doesn't control the content of the
> communication, so the permission check as it is doesn't make any
> sense. People writing the policy should be burdened by low-level
> details about how the kernel works internally as little as possible.

I'm not "that" concerned about how it's done I'd just like to see
it fixed whether it's how I think it should be done or not.

> 
> > But Stephen has a different recommendation (and that appears to
> > consider the cause I outlined above) so I'll wait to see what
> > others
> > think about the recommendations.
> 
> As I said above, I think Stephen's approach is less future-proof. And
> it seems that rw_verify_area() has many other callers, most/all of
> which probably service actual requests from userspace and we'd need
> to
> retain the security_file_permission() call in those cases.
> 
> Let me try to put my proposal into a patch, so we have something
> concrete to talk about...

I think there was a suggestion of using function naming indicate
the different requirement, I think it was along the lines of
kern_write_nosec(), but if that approach is used the nosec is
misleading too, I'd prefer something like kern_write_internal()
to indicate clearly it's meant to cater for internal use.

But whatever, I'm keen to see what you recommend.

Ian

