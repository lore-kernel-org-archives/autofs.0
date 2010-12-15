From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] [PATCH][RFC] autofs4: Do not potentially dereference
 null pointer returned by fget() in autofs_dev_ioctl_setpipefd()
Date: Wed, 15 Dec 2010 11:03:15 +0800
Message-ID: <1292382195.2979.17.camel@perseus>
References: <alpine.LNX.2.00.1012122357570.9206@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding; s=smtpout; bh=1qZAU8XxE0u5nNdIQoCvfW4V3FQ=; b=fuJuvL9rycC3I2UD4dqYtNND7m9lWej5dzRzdHoIQ7+d3e6Zpihdl6dwq3Xe36NrQPrgtZtrxWVgB1zCKMlp2XskxMbc1B9atbAkg95U+REQvivOW5cYcKXs/MCjeikov/yiiMPHuiHj+ierClyUW7c2iqn7e9ZVczR50DlvdWA=
In-Reply-To: <alpine.LNX.2.00.1012122357570.9206@swampdragon.chaosbits.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jesper Juhl <jj@chaosbits.net>
Cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2010-12-13 at 00:02 +0100, Jesper Juhl wrote:
> Hi,
> 
> In fs/autofs4/dev-ioctl.c::autofs_dev_ioctl_setpipefd() we call fget(), 
> which may return NULL, but we do not explicitly test for that NULL return 
> so we may end up dereferencing a NULL pointer - bad.

Oops, thanks for this.

> 
> A comment in fget() says "File object ref couldn't be taken" when that 
> function returns NULL, so I guess EBUSY is the proper error to return from 
> autofs_dev_ioctl_setpipefd() when this happens, but I'm far from sure 
> about this, so I'd like some feedback before this patch is merged.

Not sure EBUSY is the one to use.

What is happening here is that user space has opened a file handle it
thinks is against an autofs mount point (which may actually be covered
by another mount, hence the need for an ioctl) and is asking the kernel
to set it in the super block info struct so it can be used for control
operations. By the look of fget() a NULL return would happen if the file
table was full (ENFILE) or the file handle had already been closed
(probably EBADF) so perhaps EBADF would be a better choice.

> 
> 
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> ---
>  dev-ioctl.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
>  compile tested only.
> 
> diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
> index eff9a41..ab551ee 100644
> --- a/fs/autofs4/dev-ioctl.c
> +++ b/fs/autofs4/dev-ioctl.c
> @@ -372,6 +372,10 @@ static int autofs_dev_ioctl_setpipefd(struct file *fp,
>  		return -EBUSY;
>  	} else {
>  		struct file *pipe = fget(pipefd);
> +		if (!pipe) {
> +			err = -EBUSY;
> +			goto out;
> +		}
>  		if (!pipe->f_op || !pipe->f_op->write) {
>  			err = -EPIPE;
>  			fput(pipe);
> 
> 
> 

