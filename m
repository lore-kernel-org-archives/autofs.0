From: Bill O'Donnell <bodonnel@redhat.com>
Subject: Re: [PATCH 0/8] autofs - convert to to use mount api
Date: Fri, 22 Sep 2023 08:25:39 -0500
Message-ID: <ZQ2V0wa6Hia9xbWS@redhat.com>
References: <20230922041215.13675-1-raven@themaw.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695389147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZOSEgdaNayKQCj0Rd2l3QVa88rL7jTEBUClTXsv6/B0=;
        b=IPqjX/86ROqU43p11Lyu1RaCzAXf2GLMTLtyoFZKYzOOSiPE5xNolEzNiP4p5QxZk+Jp/2
        WbRbvFRXBNiA1fxzl5TnPcAhiCxOTn4KJ3ODsemcBqOckoBOJd6e6E6ftO+muw4hZvm6tX
        wpycElvFn8KQotIqYqDVlejh/p9RoBE=
Content-Disposition: inline
In-Reply-To: <20230922041215.13675-1-raven@themaw.net>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Bill O'Donnell <billodo@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, David Howells <dhowells@redhat.com>

On Fri, Sep 22, 2023 at 12:12:07PM +0800, Ian Kent wrote:
> There was a patch from David Howells to convert autofs to use the mount
> api but it was never merged.
> 
> I have taken David's patch and refactored it to make the change easier
> to review in the hope of having it merged.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>

for the series...
Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>


> 
> Ian Kent (8):
>   autofs: refactor autofs_prepare_pipe()
>   autofs: add autofs_parse_fd()
>   autofs: refactor super block info init
>   autofs: reformat 0pt enum declaration
>   autofs: refactor parse_options()
>   autofs: validate protocol version
>   autofs: convert autofs to use the new mount api
>   autofs: fix protocol sub version setting
> 
>  fs/autofs/autofs_i.h |  15 +-
>  fs/autofs/init.c     |   9 +-
>  fs/autofs/inode.c    | 423 +++++++++++++++++++++++++------------------
>  3 files changed, 266 insertions(+), 181 deletions(-)
> 
> -- 
> 2.41.0
> 

