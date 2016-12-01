From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/7] vfs - merge path_is_mountpoint() and
 path_is_mountpoint_rcu()
Date: Thu, 01 Dec 2016 08:13:01 +0800
Message-ID: <1480551181.2936.5.camel@themaw.net>
References: <148029910861.27779.4517883721395202453.stgit@pluto.themaw.net>
         <20161130142244.57bc0d853bcb194d2fba3856@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=baoayQX5Yam56H/
        +w56Cv+YhlT0=; b=QgKFM6WNB2+4iH8ltzNAMc0BCswgcjTj9WkXfJ9p+OpCMUH
        YLnBMNDvYqQEKHUfbN/pSM0JVoCS0Al+nD99Kf9nzynyc50qIxm0/bP5QkGW4uqF
        2Eq/9+tFoBTkvCGLZSvIS8JG7xZgLHCfuNGu6ub/MJvCOZDoopYVP73A5oAU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        smtpout; bh=baoayQX5Yam56H/+w56Cv+YhlT0=; b=tvdNIQZ2wHQGweZi9wPQ
        R77kjpwgNcK5X0o/4ZxkHOUHh7TFliuCEso2oUaVtLv7OFoQkbwEc+6cpb3eXY7L
        wAamFUmfgSuv6iQ5zZ1hO4BiFI0PduU+B6+as1PEGnp9Q5s1fBIls5+lZuwc2kn+
        0L+CHurlqMk/zwtqKeVFDwU=
In-Reply-To: <20161130142244.57bc0d853bcb194d2fba3856@linux-foundation.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Al Viro <viro@ZenIV.linux.org.uk>

On Wed, 2016-11-30 at 14:22 -0800, Andrew Morton wrote:
> So a far as I can tell, this patch series is intended to
> address Al's review comments against the
> http://lkml.kernel.org/r/20161011053352.27645.83962.stgit@pluto.themaw.net
> series?

That's right and also to fix an additional problem I found in subsequent testing
(the may_umount_tree() changes).

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
