From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH 00/10] autofs4 - rename autofs4 to autofs
Date: Tue, 03 Sep 2013 15:28:48 +0400
Message-ID: <5225C7F0.10103@msgid.tls.msk.ru>
References: <20130831114133.11807.35953.stgit@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <20130831114133.11807.35953.stgit@perseus.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: linux-next@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

31.08.2013 15:42, Ian Kent wrote:
[...]
> By leaving a Kconfig and Makefile in fs/autofs4 (to build autofs4.ko)
> with a deprication message sub-system maintainers and other users will
> make any needed changes before these are removed after two kernel versions.
> IMHO the presence of the warning is reason enough to leave a build stub
> rather than do a straight out rename.

Why do you want to continue building autofs4.ko? (or allowing to)
What's actually wrong with a stright rename?
If the new module can be auto-loaded by both name (by providing an
alias), there's no need to keep ability to build autofs4.ko, I think.

Well, maybe except of the case when autofs is needed in initramfs (like
for systemd).  For this, indeed, you can keep autofs4.ko which is a
dummy depending on autofs.ko...

> Ian Kent (10):
>       autofs4 - coding style fixes
>       autofs4 - fix string.h include in auto_dev-ioctl.h
>       autofs4 - move linux/auto_dev-ioctl.h to uapi/linux
>       autofs - merge auto_fs.h and auto_fs4.h
>       autofs - use autofs instead of autofs4 everywhere
>       autofs - copy autofs4 to autofs
>       autofs - create autofs Kconfig and Makefile
>       autofs - update fs/autofs4/Kconfig
>       autofs - update fs/autofs4/Makefile
>       autofs - delete fs/autofs4

By doing it this way, you're losing all git history.
If you perform stright rename and git detects it, you
can use, eg, git log --follow to see whole hostory
across rename.  This way you create new files without
history.

So I strongly shuggest actually renaming the subdirectory
(together with appropriate kconfig/makefile changes so
things are bisectable), and creating the stubs after this.

Thanks,

/mjt
