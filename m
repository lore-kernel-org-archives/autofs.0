From: Ian Kent <raven@themaw.net>
Subject: Re: Commit 13c164b1a186 - regression for LSMs/SELinux?
Date: Tue, 22 Sep 2020 09:35:28 +0800
Message-ID: <b7e5ceb15392b91b381bb243bd0048d3f185f058.camel@themaw.net>
References: <CAFqZXNsoXr1eA4C8==Nvujs5ONpRnuSqaOQQ0n78R=Dbm-EFGA@mail.gmail.com>
         <20200921160922.GA23870@lst.de>
         <20200921163011.GZ3421308@ZenIV.linux.org.uk>
         <0c966f624c22fef7e641f9520b85152ede3dd371.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-security-module-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        4uiVG7BzAmEnWUqCgJZuJ/14EUyaXVllK0pxOmBeh2c=; b=JjQRb2WyTdJtnIEx
        QDKQFund+y3I3CyHvWp8Ets3vdIA83niG2z+qGkkx2yXLskVvuKEqv7/U2DD8sia
        c9X8uDUasXnwEs/h5ls9ga1LCb4ZqO1KCOGj/UR15njv5prd9ajUTqHjg3P+wxWS
        DXj3Ey5UKv7h5Rbwa1N66GGdJCUfI6Fop0Jx2sFsbRrJQCXvvUu+7c6q5nBn0WgW
        Rs62KPdK34Ae9hLN+iU864GuZpZMfwgm7gl6LTPHxIAVHugJdjqYwDPHVNn0IHAw
        9yffhGPNsQgMIrAHK/eZbTvQzs8k0T8L4ZUAcVT8s69t+EYRx7DmsGaylcZ63Rtu
        0PMCmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=4uiVG7BzAmEnWUqCgJZuJ/14EUyaXVllK0pxOmBeh
        2c=; b=i4hGEUbAB78cauVTYhC9crA+FC0LYx8otXA9XZM/RIVwF9VTDtP6w4/n+
        wn5py47U4WTCWUGhrFfoSVe9g6k3Om739Zvx8fKVcLBX5Y6nEDsUJpykIA27CoOr
        d0JD35vfZ+Rmh+rwh1NCYdlz7BnXeKe9TlrhPCEjP5NHn14GSgU5cPXSQusoME0o
        Jk5gI8ZUi49PPPYMsIqMRX4IqiKmIX+9SwuyfP30R89hhUvaRykXHqN/40KvC5b7
        L9vhHYeZ1optleXEklvsL6SRhMy2PlrYOSDwbFmX//kVVD4SElyFXnoteBM1PIJs
        W5/dZs7m/mC7P3lqNZgqL2Aw5w0ew==
In-Reply-To: <0c966f624c22fef7e641f9520b85152ede3dd371.camel@themaw.net>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, autofs@vger.kernel.org, Linux Security Module list <linux-security-module@vger.kernel.org>, SElinux list <selinux@vger.kernel.org>, Zdenek Pytela <zpytela@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Tue, 2020-09-22 at 08:30 +0800, Ian Kent wrote:
> On Mon, 2020-09-21 at 17:30 +0100, Al Viro wrote:
> > On Mon, Sep 21, 2020 at 06:09:22PM +0200, Christoph Hellwig wrote:
> > > [adding Linus and Al]
> > > 
> > > On Mon, Sep 21, 2020 at 04:51:35PM +0200, Ondrej Mosnacek wrote:
> > > > Hi folks,
> > > > 
> > > > It seems that after commit 13c164b1a186 ("autofs: switch to
> > > > kernel_write") there is now an extra LSM permission required
> > > > (for
> > > > the
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
> > > 
> > > Any opinions?
> > 
> > Reexport for now.  Incidentally, what is LSM doing rejecting writes
> > into a pipe?
> 
> I had seen this too but thought it was due to selinux policy changes
> but the previously linked bug shows the rejection is more widespread
> than I thought.
> 
> A revert seems sensible for now but I'd like to understand why the
> writes are being rejected too, I'll have a look around.

There's not much to see looking around.

Based on the reports it appears that the added security check denies
processes other than the pipe creator write access to the pipe but
in order to trigger an automount pretty much any process needs to be
allowed to write to the automount owned kernel communication pipe.

So I still think it's an selinux policy problem.

Ian

