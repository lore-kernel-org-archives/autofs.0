From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] autofs - make autofs4 Kconfig depend on AUTOFS_FS
Date: Sun, 20 May 2018 19:08:41 -0700
Message-ID: <c0eb4d04-9d75-7fc2-0bce-f2caac9d2056@infradead.org>
References: <152686465885.5980.4013776735694914550.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6CF1cmzQaO5wjSV9g2Tl5ZJBx8TfwpMc3Au1wQRL6Jw=; b=KO103m+blIEaoYDGCKdT/irKY
        8QsFChvzmByKSwSrs+xKVazX+AWKjNxaQRC+GOONj/N4j20+6HHFHbSGwqOe7n5dbmorwEDRf9wou
        nVyLRom40OGy8JL/+fkN7ODXO3fkDnoxlgeAUJyQS7RuqBxAw/fEzOF+niW2YWV+apOcGmvASb2Vw
        /qkPkKUhCe0qRjwnCNFqhpk3XI7bWECx7cXFgnklO8EBS2DjGLsV+zG8x1INGeH54Y+VWE9eNaNUP
        AMFipL7CpRLn4s/xEaA2Y3iAELddXCQyMbO6gINo/piQ0RFY6oEE9mFTjscvCBldM0qdECm/JnS+O
    
In-Reply-To: <152686465885.5980.4013776735694914550.stgit@pluto.themaw.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On 05/20/2018 06:04 PM, Ian Kent wrote:
> Setting AUTOFS_FS and AUTOFS4_FS to y or m results in a compile
> failure.
> 
> It isn't possible to unset one if the other is set because it
> introduces a circular dependency.
> 
> But adding "depends on AUTOFS_FS = n && AUTOFS_FS != m" will make
> autofs4 appear under the autofs entry which should call attention
> to it. It also results in AUTOFS4_FS being removed from .config
> for any setting of AUTOFS_FS except n.
> 
> Adding a "NOTE" to the AUTOFS4_FS help text will hopefully raise
> awareness of the change to smooth the transition.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>
> Cc: Randy Dunlap <rdunlap@infradead.org>

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  fs/autofs4/Kconfig |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/autofs4/Kconfig b/fs/autofs4/Kconfig
> index 53bc592a250d..2c2fdf989f90 100644
> --- a/fs/autofs4/Kconfig
> +++ b/fs/autofs4/Kconfig
> @@ -1,6 +1,7 @@
>  config AUTOFS4_FS
>  	tristate "Kernel automounter version 4 support (also supports v3 and v5)"
>  	default n
> +	depends on AUTOFS_FS = n
>  	help
>  	  The automounter is a tool to automatically mount remote file systems
>  	  on demand. This implementation is partially kernel-based to reduce
> @@ -30,3 +31,10 @@ config AUTOFS4_FS
>  	  - any "alias autofs autofs4" will need to be removed.
>  
>  	  Please configure AUTOFS_FS instead of AUTOFS4_FS from now on.
> +
> +	  NOTE: Since the modules autofs and autofs4 use the same file system
> +		type name of "autofs" only one can be built. The "depends"
> +		above will result in AUTOFS4_FS not appearing in .config for
> +		any setting of AUTOFS_FS other than n and AUTOFS4_FS will
> +		appear under the AUTOFS_FS entry otherwise which is intended
> +		to draw attention to the module rename change.
> 


-- 
~Randy
