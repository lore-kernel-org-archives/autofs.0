From: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH] autofs: fix 3.3-rc5 compilation breakage on x86-32
Date: Sun, 26 Feb 2012 11:02:28 -0500
Message-ID: <CA+5PVA4-yj26KVyoTBkP3v3=0ZJ6HLh0aWLaHaXgqn_FMqeaLQ@mail.gmail.com>
References: <20120226151015.GA14324@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=nSyTty+WfuwrJ/tcuhSWobWnXhG+A1wWTTgoyVBLQ8k=;
        b=i4M18nFjCxRJBUQv5E1RK7PiVB6oe3gtfxubbw05jd6jEg5AvTqPaR2CqDJ95QsNwb
         AVwvLPwBv5xsfOZBEUbIiUSY7WuuVoQ0y4SxmiWwV3URaw7ZRqM6piJWaQToN3qujLbv
         NQRaF7+ZcPrBhhu3CojHBIMEwFuDruPRYotMA=
In-Reply-To: <20120226151015.GA14324@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Stanislaw Gruszka <sgruszka@redhat.com>
Cc: Ian Kent <raven@themaw.net>, autofs@linux.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

On Sun, Feb 26, 2012 at 10:10 AM, Stanislaw Gruszka <sgruszka@redhat.co=
m> wrote:
> Recent commit a32744d4abae24572eff7269bc17895c41bd0085 broke autofs
> compilation on x86-32:
>
> fs/autofs4/inode.c: In function =91autofs4_fill_super=92:
> fs/autofs4/inode.c:228: error: implicit declaration of function =91is=
_compat_task=92
>
> This patch fix that by adding #if checks.
>
> Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>

Andreas Schwab submitted an identical patch.  Linus came up with someth=
ing
else:

https://lkml.org/lkml/2012/2/25/84

josh
