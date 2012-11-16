From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] autofs4 - use simple_empty() for empty directory check
Date: Fri, 16 Nov 2012 07:45:29 -0800
Message-ID: <CA+55aFx-9A0xknhX7z9KmLAoGMf5GXhuFgroZUixHtevGAFsOQ@mail.gmail.com>
References: <20121116041523.18624.46918.stgit@perseus.themaw.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=dqurDSTLIIy629XNPwzu+15yr6EcQY4BsFE8j9AdEJI=;
        b=fuSzcuN+RdKWqlV6f0z7mHM4oPy1jNr+GqzEEKb04I8b29AtVdJ5QgsE0uOfUCSePk
         BwH5M4IZUULLoGCh7Vd7lQYZIAx5nhxK73TNy0uTSdTCcKANu8WLbt5VenmgDoSey8RZ
         EPFcubNoVnEcnWFxrtoxv0DdWjSxIfpeJSBKEIR6FcWPiHcA3Qmk4NgJoHU3AHzqRXO7
         Pl+CrAMmtre71huMbjjucLyx7wnMMEYrBKgyMSlG9/9TMPlx/JJ/r4mnDM/3ed0aLooH
         l0R65KmvubRPveT5wH/9p5c5E9OUveTaLvSeJ38gnA0w4RM+swMbvS2vaoRydffNKNf0
         jkEQ==
In-Reply-To: <20121116041523.18624.46918.stgit@perseus.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <ikent@redhat.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>

On Thu, Nov 15, 2012 at 8:15 PM, Ian Kent <ikent@redhat.com> wrote:
>
> +static inline int __simple_empty(struct dentry *dentry)
> +{

This seems completely bogus.

It's a duplicate of the existing fs/libfs.c "simple_empty()" function,
but without taking the outer lock.

That kind of code duplication - and doing it in a totally different
file, and making it look autofs-specific - seems entirely wrong.

                      Linus
