From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 2/2] autofs: Fix conditional to kfree dentry data
Date: Thu, 07 Jul 2016 12:14:13 +0800
Message-ID: <1467864853.3206.12.camel@themaw.net>
References: <1467480264-1801-1-git-send-email-kusumi.tomohiro@gmail.com>
	 <1467480264-1801-2-git-send-email-kusumi.tomohiro@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=bDbGsi77ylPGnVc0YOuWAZNHSfM=; b=d6ys2j
	THdCRRaPp5CR6VWCXkcb1n8WZ+xifqkOy+1kzUkQq0EBX4U0EUv9lxmqOcRFgBJI
	vtM/s0SgEQsEAimQHaCHujMX4dgyoHJlgC6gWpctqtbbx1czaCtzjjh6CnMxyoT+
	1Gkyd1UebUFBHpLGDqAq3DMb6gZN9nhc5Zq1k=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=bDbGsi77ylPGnVc
	0YOuWAZNHSfM=; b=CodpwbkgMZB29QbRrADMMej4xemS7OO5RnV4ve/ApVsFERi
	6IiNHu25zfWvqfHJfdWZz75FsibFo0Kas40yn2cO0lhBzXMbdnmil82LmzIHRLtc
	COaebkI7/O3KP8NwFCJO10Iibi30J0b11qbOArxy+6YP/wqVI7gO2EpUv5kg=
In-Reply-To: <1467480264-1801-2-git-send-email-kusumi.tomohiro@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Cc: autofs@vger.kernel.org

On Sun, 2016-07-03 at 02:24 +0900, Tomohiro Kusumi wrote:
> if (!dentry->d_fsdata) should be testing d_fsdata or ino without !.

I've added both of these to the list of kernel patches I have, hopefully I'll be
able to get the needed testing done to send them to Andrew after the next merge
window.

But I need to take a closer look at this one though.

There's another ENOMEM return just above this where ino is not freed.

So I'm wondering if it should be freed here at all.

It belongs to the dentry and would get freed using autofs4_dentry_release() on
final dput() and that takes care of additional house keeping too (although a
symlink dentry is a bit different and shouldn't need that extra cleanup).

What really worries me is that autofs4_free_ino() doesn't set d_fsdata to NULL
so there's a chance of a double free when autofs4_dentry_release() is finally
called.

> 
> Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
> ---
>  fs/autofs4/root.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
> index 93d3232..5a877bf 100644
> --- a/fs/autofs4/root.c
> +++ b/fs/autofs4/root.c
> @@ -577,7 +577,7 @@ static int autofs4_dir_symlink(struct inode *dir,
>  	inode = autofs4_get_inode(dir->i_sb, S_IFLNK | 0555);
>  	if (!inode) {
>  		kfree(cp);
> -		if (!dentry->d_fsdata)
> +		if (ino)
>  			autofs4_free_ino(ino);
>  		return -ENOMEM;
>  	}
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
