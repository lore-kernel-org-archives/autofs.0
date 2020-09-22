From: Ian Kent <raven@themaw.net>
Subject: Re: Commit 13c164b1a186 - regression for LSMs/SELinux?
Date: Tue, 22 Sep 2020 08:30:31 +0800
Message-ID: <0c966f624c22fef7e641f9520b85152ede3dd371.camel@themaw.net>
References: <CAFqZXNsoXr1eA4C8==Nvujs5ONpRnuSqaOQQ0n78R=Dbm-EFGA@mail.gmail.com>
         <20200921160922.GA23870@lst.de>
         <20200921163011.GZ3421308@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-security-module-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        /TBmWUlwG0EUyxkJ3YhTS5vlwG38Wpg66NogD/xSEuc=; b=jWr/6YjlySqXxom7
        kbekEpNztcasla3E5DKgrSJrEG8yQl6qzSsWMMtjOGXX4sonmWns+riZ8+kAbmRs
        dGVauyITEciLGui669a5dFZieScnp4Ih4fpYaqmLnWZyyyv4AaUcPa3fu/jmD7RM
        E74sL6tWdHeNaij+gf8ndBMu0XYbi9brc5tmO2zXOaNvWAX+ranZnRYFpAsvNL5m
        KQRYMZX1HQbCw+FsSw33k3F42R9uw6+4hO3yP/rLDm+tnNRqszBC8XgUDIHM6CID
        C+iHTuFYGVdmwUQQ9rDWzTYZy3ZC+hNGlnhGPBBVaJxxSDQ4Bx6KmZpeZ1TxTtHH
        w3dnOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=/TBmWUlwG0EUyxkJ3YhTS5vlwG38Wpg66NogD/xSE
        uc=; b=NWnoQvSnwW7141IFoXAITtniYxmYi516g8t8H8DIWqQ/eq9PEQrPNY2FY
        PgMULasv49ofCtwnOEQr018Im2Bkx0rKqBW/rqcHg0xA0tm+gZQrs5jDhnx1IKX2
        XP1n2V3znLduEWV9VozQ4Ye0vP0f4VrdXk2sNUOZpHK6xUpJLF0gph/v5NccZQBi
        DMMjXEALgs5iUt2vlFXLrwJ0OEvLq/+qy43G132mdZh43O42QvJ05VXhjgl08Qe0
        MR/TfF8YiJypldVb8Ib2972C7TOBkQ7jli6/nSDb2M0VM5c2s3LWAehfUhDzionK
        R1ZDeh5gnoOhz4zB46nD+IiArmr7w==
In-Reply-To: <20200921163011.GZ3421308@ZenIV.linux.org.uk>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, autofs@vger.kernel.org, Linux Security Module list <linux-security-module@vger.kernel.org>, SElinux list <selinux@vger.kernel.org>, Zdenek Pytela <zpytela@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, 2020-09-21 at 17:30 +0100, Al Viro wrote:
> On Mon, Sep 21, 2020 at 06:09:22PM +0200, Christoph Hellwig wrote:
> > [adding Linus and Al]
> > 
> > On Mon, Sep 21, 2020 at 04:51:35PM +0200, Ondrej Mosnacek wrote:
> > > Hi folks,
> > > 
> > > It seems that after commit 13c164b1a186 ("autofs: switch to
> > > kernel_write") there is now an extra LSM permission required (for
> > > the
> > > current task to write to the automount pipe) for processes
> > > accessing
> > > some yet-to-to-be mounted directory on which an autofs mount is
> > > set
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
> > > kernel-internal operation and an LSM permission for the current
> > > task
> > > shouldn't be required. Can this patch be reverted? Perhaps
> > > __kernel_{read|write}() could instead be renamed to
> > > kernel_*_nocheck()
> > > so that the name is more descriptive?
> > 
> > So we obviously should not break existing user space and need to
> > fix
> > this ASAP.  The trivial "fix" would be to export __kernel_write
> > again
> > and switch autofs to use it.  The other option would be a FMODE
> > flag
> > to bypass security checks, only to be set if the callers ensures
> > they've been valided (i.e. in autofs_prepare_pipe).
> > 
> > Any opinions?
> 
> Reexport for now.  Incidentally, what is LSM doing rejecting writes
> into a pipe?

I had seen this too but thought it was due to selinux policy changes
but the previously linked bug shows the rejection is more widespread
than I thought.

A revert seems sensible for now but I'd like to understand why the
writes are being rejected too, I'll have a look around.

Ian

