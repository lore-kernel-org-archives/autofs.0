From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH v2 1/5] autofs - improve ioctl sbi checks
Date: Mon, 26 Nov 2018 06:57:40 +0800
Message-ID: <1550e021bf61b0f3d6d91f342e4546320f385bd5.camel@themaw.net>
References: <154296962626.9889.644199825100770992.stgit@pluto-themaw-net>
         <154296970987.9889.1597442413573683096.stgit@pluto-themaw-net>
         <20181123152922.de3ed41c5b97ac84eaa22846@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        0fRQlfy9jPRt2U3ba3ZoWMzPERVH4t84BYRp/3qP9iM=; b=nSeO3fqgWdelbS32
        NVHv++5P2FLUE6kFvVQ27N7d7h4VqIt8QfpqZjNimQq7gzEE2yt9jTRVaQ8WIKgm
        pEQaOFBLYK3MG2fbqPpa2NnJRkxYYNvY6k6/OmaeoEyyfh/2Bn+EWX44BmANe4m6
        wpBUYnXLxYe2q2Wh7ULKpXIEZm0yphsJ2ZrcIhKob3kiNW5lwxG54QyuRFcXaN7a
        Z2q1Fv7w0EIjDve9h9sOLYFQI41XsgHBaPCXnTcks/DHjd3Sv+S0hFNKybGf3q5V
        aoclTfHIuywesNPd470hG8RsCVSKD5YRxI/EeTSKEpObVC8ocqK0OVqNSIYLxd2h
        d3QmAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=0fRQlfy9jPRt2U3ba3ZoWMzPERVH4t84BYRp/3qP9
        iM=; b=E/Zl1GBpITQc1ltnn1zbRdzdUgPAQ01fqg9crrer2MQOQxhyrqAVMvTT+
        EtGq7Zvypopxl+kyV5btP6l6Dhczq2KSSiz4pS+770nHpFftO8TUABq/XX65N85R
        4Kx1s0dAgWMoHmJXNzorj/kCbLYWeffNLKACLdyNwvmhrThGWZRlrOyCnLrAjPsM
        1NOYjaUrSgnUUO+rNSCLa9u6LkSg52S23I1ouZSi37fgKqmls1Gx/dP8EtEHFD/l
        sN0Fd3w6D0ZT83SxTfzIfzEuI2z9R3thUiPtC0LumAMDR4/3q2ue7OpH5wWKoV9O
        96bjiDC5dC353kMyoT0clX0VUhPyw==
In-Reply-To: <20181123152922.de3ed41c5b97ac84eaa22846@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, 2018-11-23 at 15:29 -0800, Andrew Morton wrote:
> On Fri, 23 Nov 2018 18:41:50 +0800 Ian Kent <raven@themaw.net> wrote:
> 
> > Al Viro made some suggestions to improve the implementation
> > of commit 0633da48f0 "fix autofs_sbi() does not check super
> > block type".
> > 
> > The check is unnessesary in all cases except for ioctl usage
> > so placing the check in the super block accessor function
> > adds a small overhead to the common case where it isn't
> > needed.
> > 
> > So it's sufficient to do this in the ioctl code only.
> > 
> > Also the check in the ioctl code is needlessly complex.
> > 
> > ...
> > 
> > --- a/fs/autofs/dev-ioctl.c
> > +++ b/fs/autofs/dev-ioctl.c
> > @@ -14,6 +14,8 @@
> >  
> >  #include "autofs_i.h"
> >  
> > +extern struct file_system_type autofs_fs_type;
> > +
> >  /*
> >   * This module implements an interface for routing autofs ioctl control
> >   * commands via a miscellaneous device file.
> 
> It's naughty to declare externs in C files, for various reasons.  Is
> this OK?

OK, I understand the reasoning I guess.

The change below is fine.

Thanks, Ian.

> 
> --- a/fs/autofs/autofs_i.h~autofs-improve-ioctl-sbi-checks-fix
> +++ a/fs/autofs/autofs_i.h
> @@ -42,6 +42,8 @@
>  #endif
>  #define pr_fmt(fmt) KBUILD_MODNAME ":pid:%d:%s: " fmt, current->pid, __func__
>  
> +extern struct file_system_type autofs_fs_type;
> +
>  /*
>   * Unified info structure.  This is pointed to by both the dentry and
>   * inode structures.  Each file in the filesystem has an instance of this
> --- a/fs/autofs/dev-ioctl.c~autofs-improve-ioctl-sbi-checks-fix
> +++ a/fs/autofs/dev-ioctl.c
> @@ -14,8 +14,6 @@
>  
>  #include "autofs_i.h"
>  
> -extern struct file_system_type autofs_fs_type;
> -
>  /*
>   * This module implements an interface for routing autofs ioctl control
>   * commands via a miscellaneous device file.
> _
> 

