From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] fs: autofs: delete repeated words in comments
Date: Tue, 11 Aug 2020 16:36:17 +0800
Message-ID: <75e04b06be0561c3cec936cd3bbc44fe82ca73f4.camel@themaw.net>
References: <20200811021817.24982-1-rdunlap@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        XmkOTDau3GA4XwOfKDAkmAamcy7pGy3Ial0qb8HMlms=; b=vi6BpXWYJtMTm5Hf
        19E7qqoMJs/Q3bfqgUknAH/9oQl/znVXHDO7MjKpqHbnZlFLkdj6B/Eo2QCwa9ve
        cnADb4ttKLgus55JqlPzel2K4v53c6B/9hGLgTdp7Ta5oHTiVpSFOkYi8LvHGL4i
        1uM2PyEQnkgvLEFFP08afRPurP5KfeWJkXduVl9nl0kx6+P73W4G70Bn1AiKQEND
        ZV58w0ALWuUfTxDpza4qnYyA4GdwiyWbT917OjgPyZT/8CvfQ6HEaxZjSZjmr7Tk
        1F8XjXJ94mzIRLqdl1zyFNR53HRnaz6O7oNqLBq0Y3F7CFvRsKqAJ/v77YLEkkY2
        PcEFSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=XmkOTDau3GA4XwOfKDAkmAamcy7pGy3Ial0qb8HMl
        ms=; b=IXJmmNKH0HQPxtPlxpnml0NXFCQHdZ7PlpuDGQS2rCWXceSJWsmGdFLzs
        USoFcpA3r7lwtxDVQMb6Wk3owJdo4ICM2KLKW3QscsqxHiB0RaPik5AwXN8SQU/M
        /UyOher5UPYYyF8gaakROT5Ids1ELU2dl5HXcd1HgYZXnkvoYZ0eNJRNCcNDrRMb
        soj82EXXl8MF87L7rHTtURnEFAM6DbtbgRhgQEbiymhZiVipXd46bbM1n0kboC6A
        veuUtPjzNktHJXzIKkBReq1sowVAcvGRRfyGa/euyRobG1TnBQNtvIhVJRMXJk5F
        lNHkZuftnrSOaFv3CIskZY45kK9SA==
In-Reply-To: <20200811021817.24982-1-rdunlap@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: autofs@vger.kernel.org

On Mon, 2020-08-10 at 19:18 -0700, Randy Dunlap wrote:
> Drop duplicated words {the, at} in comments.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Ian Kent <raven@themaw.net>
> Cc: autofs@vger.kernel.org

Acked-by: Ian Kent <raven@themaw.net>

> ---
>  fs/autofs/dev-ioctl.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-next-20200807.orig/fs/autofs/dev-ioctl.c
> +++ linux-next-20200807/fs/autofs/dev-ioctl.c
> @@ -20,7 +20,7 @@
>   * another mount. This situation arises when starting automount(8)
>   * or other user space daemon which uses direct mounts or offset
>   * mounts (used for autofs lazy mount/umount of nested mount trees),
> - * which have been left busy at at service shutdown.
> + * which have been left busy at service shutdown.
>   */
>  
>  typedef int (*ioctl_fn)(struct file *, struct autofs_sb_info *,
> @@ -496,7 +496,7 @@ static int autofs_dev_ioctl_askumount(st
>   * located path is the root of a mount we return 1 along with
>   * the super magic of the mount or 0 otherwise.
>   *
> - * In both cases the the device number (as returned by
> + * In both cases the device number (as returned by
>   * new_encode_dev()) is also returned.
>   */
>  static int autofs_dev_ioctl_ismountpoint(struct file *fp,

