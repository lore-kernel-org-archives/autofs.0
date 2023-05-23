From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] autofs: use flexible array in ioctl structure
Date: Tue, 23 May 2023 10:06:10 -0700
Message-ID: <168486156843.2168554.9330529184813281577.b4-ty@chromium.org>
References: <20230523081944.581710-1-arnd@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684861574; x=1687453574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5D4jJBdsw8v5z1Hj7e4NkWHnBQGpeGcsx2kEbP6mIWQ=;
        b=ln4dCoJzG69l0bBJ66KX8uAKPONQc33WsyrsJD2qkfoU+XgCrb4Ky7e2c7ejfR3RfW
         OF/9Ad54Mh6U0/dlwSmvD15AmN5ad11ggoJYfdYnbUxhiAh6J+yB8V92GYw9uJsD9CJT
         GZ8P1zrI7yzwZfchnshDFmU/ZUIQplyuqIV/8=
In-Reply-To: <20230523081944.581710-1-arnd@kernel.org>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net, arnd@kernel.org
Cc: Kees Cook <keescook@chromium.org>, stable@vger.kernel.org, autofs@vger.kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On Tue, 23 May 2023 10:19:35 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3") introduced a warning
> for the autofs_dev_ioctl structure:
> 
> In function 'check_name',
>     inlined from 'validate_dev_ioctl' at fs/autofs/dev-ioctl.c:131:9,
>     inlined from '_autofs_dev_ioctl' at fs/autofs/dev-ioctl.c:624:8:
> fs/autofs/dev-ioctl.c:33:14: error: 'strchr' reading 1 or more bytes from a region of size 0 [-Werror=stringop-overread]
>    33 |         if (!strchr(name, '/'))
>       |              ^~~~~~~~~~~~~~~~~
> In file included from include/linux/auto_dev-ioctl.h:10,
>                  from fs/autofs/autofs_i.h:10,
>                  from fs/autofs/dev-ioctl.c:14:
> include/uapi/linux/auto_dev-ioctl.h: In function '_autofs_dev_ioctl':
> include/uapi/linux/auto_dev-ioctl.h:112:14: note: source object 'path' of size 0
>   112 |         char path[0];
>       |              ^~~~
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] autofs: use flexible array in ioctl structure
      https://git.kernel.org/kees/c/e6d6886d469f

-- 
Kees Cook

