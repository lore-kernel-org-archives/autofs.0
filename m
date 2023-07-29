From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] arch/*/configs/*defconfig: Replace AUTOFS4_FS by AUTOFS_FS
Date: Sat, 29 Jul 2023 14:07:41 -0700
Message-ID: <CAHk-=wgK9-Tx4BxYMrc0pg==mcaz3cjWF6-CBwVpM_BZAmf4JQ@mail.gmail.com>
References: <20230727200041.21404-1-svenjoac@gmx.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690664879; x=1691269679;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=df0j41X3vQ99yevuaGGsVtpCGhFPoGbQqptBVGUtLL0=;
        b=JVqw/E6vJ+zeQv2pJYYhFUIjN6uVQiFzEzWWuPj1ht/efyZTykgi0B5qWANXflXubc
         rYuFLs9cRGQ2UUEvRpVI/UJ4DsVy6weySii/nzsOBxh6QVfSVCUBToxR/B4e5C7RD6+1
         VDMi01EcOD+BijeWsjd6meXj/zrosAnsmPhvg=
In-Reply-To: <20230727200041.21404-1-svenjoac@gmx.de>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sven Joachim <svenjoac@gmx.de>
Cc: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 at 13:01, Sven Joachim <svenjoac@gmx.de> wrote:
>
> Commit a2225d931f75 ("autofs: remove left-over autofs4 stubs")
> promised the removal of the fs/autofs/Kconfig fragment for AUTOFS4_FS
> within a couple of releases, but five years later this still has not
> happened yet, and AUTOFS4_FS is still enabled in 63 defconfigs.

Ok, I ran the script, and also decided that we might as well remove
the AUTOFS4 legacy naming stub entry by now.

It has been five years, and people will have either picked up the new
name with 'make oldconfig', or they just don't use 'make oldconfig' at
all.

         Linus
