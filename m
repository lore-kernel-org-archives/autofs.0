From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] autofs4: Wrong format for printing dentry
Date: Wed, 11 Feb 2015 21:41:37 +0100
Message-ID: <87bnl0w58e.fsf@rasmusvillemoes.dk>
References: <1423236497-28139-1-git-send-email-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        bh=VdDO6+JbNBSnKv9npn+U6h1PwfOq1SJ5gTgOKY6xMbE=;
        b=HXL1wgyMIvHNMGMIheFQ8bMSnrFhz4vhw75V9x1HFXPKUPUjnAbcBJgqORi8toTtQm
         s/laBp09woJ2Pffpo5dclehvMhYZd4ylEEoq6ktXwAsIp9b4mVek3eVMxP3/kefN87oo
         GHcJGM6Je8Odst5VAtftNOXFrsN6JCJWhMEyg=
In-Reply-To: <1423236497-28139-1-git-send-email-linux@rasmusvillemoes.dk>
	(Rasmus Villemoes's message of "Fri, 6 Feb 2015 16:28:17 +0100")
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, autofs@vger.kernel.org, linux-kernel@vger.kernel.org

Ping...

On Fri, Feb 06 2015, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> %pD for struct file*, %pd for struct dentry*.
>
> Fixes: a455589f181e ("assorted conversions to %p[dD]")
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  fs/autofs4/root.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
> index dbb5b7212ce1..7ba355b8d4ac 100644
> --- a/fs/autofs4/root.c
> +++ b/fs/autofs4/root.c
> @@ -108,7 +108,7 @@ static int autofs4_dir_open(struct inode *inode, struct file *file)
>  	struct dentry *dentry = file->f_path.dentry;
>  	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
>  
> -	DPRINTK("file=%p dentry=%p %pD", file, dentry, dentry);
> +	DPRINTK("file=%p dentry=%p %pd", file, dentry, dentry);
>  
>  	if (autofs4_oz_mode(sbi))
>  		goto out;
