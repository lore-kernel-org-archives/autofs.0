From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs4: Do not potentially dereference NULL pointer
 returned by fget() in autofs_dev_ioctl_setpipefd()
Date: Tue, 28 Dec 2010 10:36:13 +0800
Message-ID: <1293503773.5923.3.camel@perseus>
References: <alpine.LNX.2.00.1012182238560.17400@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding; s=smtpout; bh=0JYiRuK7U/c848TtPOuW3K4F1pY=; b=BHySv7tTm0QKGUsujNJ3ylrqMy14xPlMIA1ze4U9CeDCilUS61LHnkm0FqlapX0aPjijsZGkTXYZSUKEYpK1vGZOBfew0AYi7QBB2YiH9mDuTcs9nMKecQoodKSuF9b9llM7aTYYqD/vjUDK623mGgGmEK5ODDWTEGbECaKJqPk=
In-Reply-To: <alpine.LNX.2.00.1012182238560.17400@swampdragon.chaosbits.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jesper Juhl <jj@chaosbits.net>
Cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org

On Sat, 2010-12-18 at 22:43 +0100, Jesper Juhl wrote:
> Hi,
> 
> In fs/autofs4/dev-ioctl.c::autofs_dev_ioctl_setpipefd() we call fget(), 
> which may return NULL, but we do not explicitly test for that NULL return 
> so we may end up dereferencing a NULL pointer - bad.
> 
> When I originally submitted this patch I had chosen EBUSY as the return 
> value to use if this happens. Ian Kent was kind enough to explain why that 
> would most likely be wrong and why EBADF should most likely be used 
> instead. This version of the patch uses EBADF.
> 
> 
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>
Acked-by: Ian Kent <raven@themaw.net>

> ---
>  dev-ioctl.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
> index eff9a41..a650d7e 100644
> --- a/fs/autofs4/dev-ioctl.c
> +++ b/fs/autofs4/dev-ioctl.c
> @@ -372,6 +372,10 @@ static int autofs_dev_ioctl_setpipefd(struct file *fp,
>  		return -EBUSY;
>  	} else {
>  		struct file *pipe = fget(pipefd);
> +		if (!pipe) {
> +			err = -EBADF;
> +			goto out;
> +		}
>  		if (!pipe->f_op || !pipe->f_op->write) {
>  			err = -EPIPE;
>  			fput(pipe);
> 
> 
> 

