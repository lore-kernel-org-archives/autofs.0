From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs: clear O_NONBLOCK on the pipe.
Date: Mon, 11 Feb 2019 13:31:43 +0800
Message-ID: <dddb59ed3d0bc790bea9424784998e2ab264d75b.camel@themaw.net>
References: <871s4fi5b5.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        iQrzwT+3QN8OUTCOoToNX4n1hFuDq3qOqpp6KL+nwZY=; b=lUhDym1HMoqCNJPi
        xCyFrZpv6PaNcQ4gs4ZXXfOfr4S7BMK37QWzblmbxMHUaLTMnqHGzJtLZ3O5I9dr
        QY+tpF62PAIetVWu61jLAT6pcIwYwqKihFu3zwzWigGKENei5AL3+9r9/BPLPMqm
        Q4Kl2oyggmZSeZFSb9AD4VgV4k/qjTSFm7s7lssilFsDmsSVAm3C2uD5C9OkYBPC
        sJDukrVkTXicINLU9OkDFKQjhuZUUyo7z5YT3o35De0voHJJKzp2HKPm6YfHV1+M
        TNqYwPx5ZI5SX1C3/GL7BxxbHTc1gGKX3AO/TRukjCiHvlJJGSeDeJnmGAO7hhyz
        BCZdEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=iQrzwT+3QN8OUTCOoToNX4n1hFuDq3qOqpp6KL+nw
        ZY=; b=5tRK88u9ZdPsaLQqGUASQJOhI0tl3A9RPfW5DmYFV3vI259u/FjnfmkK1
        MrjTGR+euxa9JVWul2uCuS8Jw/kfNIqtNNYCM9D/XKD81aMEIi1dAwwF1D3nzIL+
        1PQFLDHM6LMrvs0sDB83M4l5ORhn6OGG0B6G2x0UJVpuOPxnzsSbsPNre5g8Ku7h
        XdgOOfTqI8DICNXVww90B1ZbpVUwlNdqQz2kd+yM2UcBEJ44emxwipyKL2qEFsml
        kpt+qdZ8AGdR+x3wAO4LcHdUV9BVltbjcaW0Apgr29g8Gjn76aguaJhNpqHGxt9L
        /BAsQGnlIiSkKhLvT25cVmFYftzjQ==
In-Reply-To: <871s4fi5b5.fsf@notabene.neil.brown.name>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2019-02-11 at 10:37 +1100, NeilBrown wrote:
> autofs does not expect the pipe it is given
> to have O_NONBLOCK set - specifically if __kernel_write()
> in autofs_write() returns -EAGAIN, this is treated
> as a fatal error and the pipe is closed.
> 
> For safety autofs should, therefore, clear the O_NONBLOCK flag.
> 
> Releases of systemd prior to 8th February 2019 used
>   pipe2(p, O_NONBLOCK|O_CLOEXEC)
> and thus (inadvertently) set this flag.

Thanks Neil, this does look like an obvious problem.

> 
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  fs/autofs/autofs_i.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
> index 3e59f0ed777b..331192bed0d5 100644
> --- a/fs/autofs/autofs_i.h
> +++ b/fs/autofs/autofs_i.h
> @@ -215,6 +215,8 @@ static inline int autofs_prepare_pipe(struct file *pipe)
>  		return -EINVAL;
>  	/* We want a packet pipe */
>  	pipe->f_flags |= O_DIRECT;
> +	/* We don't expect -EAGAIN */
> +	pipe->f_flags &= ~O_NONBLOCK;
>  	return 0;
>  }
>  

