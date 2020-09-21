From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Commit 13c164b1a186 - regression for LSMs/SELinux?
Date: Mon, 21 Sep 2020 09:27:28 -0700
Message-ID: <CAHk-=wgTz9h-WCtkEcByebaqv3arZWuUQ7TzfHejo10=bztZeA@mail.gmail.com>
References: <CAFqZXNsoXr1eA4C8==Nvujs5ONpRnuSqaOQQ0n78R=Dbm-EFGA@mail.gmail.com>
 <20200921160922.GA23870@lst.de>
Mime-Version: 1.0
Return-path: <linux-security-module-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wkGkb2MrNjid2t2xzsw7KGRSA+5X+/NXfaXYAD63JOQ=;
        b=EbVfWiD/0FwOHmGlMRJzyDefmvEBHwjopQdM0INnp7+G7ymRce/nckc8fZ1BbNObaM
         KYhup5K4TfBuWWI2zp87w7I1NNRFlriw8hPLX5GDXo97vLAs9GvUo9Ux3NCkR0mEYh0d
         B6njjsxpj84PDzjqVDsZyzxBpabTZjipn+vS8=
In-Reply-To: <20200921160922.GA23870@lst.de>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Ian Kent <raven@themaw.net>, autofs@vger.kernel.org, Linux Security Module list <linux-security-module@vger.kernel.org>, SElinux list <selinux@vger.kernel.org>, Zdenek Pytela <zpytela@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>

On Mon, Sep 21, 2020 at 9:09 AM Christoph Hellwig <hch@lst.de> wrote:
>
> So we obviously should not break existing user space and need to fix
> this ASAP.  The trivial "fix" would be to export __kernel_write again
> and switch autofs to use it.  The other option would be a FMODE flag
> to bypass security checks, only to be set if the callers ensures
> they've been valided (i.e. in autofs_prepare_pipe).
>
> Any opinions?

I'd much rather do the former than add a new dynamic flag that we then
have to worry about somebody being able to set thanks to a bug.

Static behavior is a lot easier to verify and document (ie just a
comment in the code explaining why autofs cannot use the regular
kernel_write()). There's no chance of that static behavior then
leaking to other call sites.

                   Linus
