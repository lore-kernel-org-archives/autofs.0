From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs: don't stuck in a loop if vfs_write returns an
 error
Date: Fri, 01 Apr 2016 15:37:46 +0800
Message-ID: <1459496266.2974.1.camel@themaw.net>
References: <1459487558-21258-1-git-send-email-avagin@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=lga6mCCuDUDkp+8goPtaFTY4VQs=; b=Yn3uDN
	/4gOY/2wC5NmfS8c8tU52/ctzTJrmb6MX2uJAiJEQCepLGHqVPWNPIiq3q2FKM78
	3Ehz2w/azbyQ+QHTeexAVT1/PYpyORw8FsRvbFTESZmuZHAQGC0zeRigfWrgqgLC
	b3rvNUve6IKHqNjKSm3S08jpMJh+MjmnD/Wpk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=lga6mCCuDUDkp+8
	goPtaFTY4VQs=; b=mES2krxwHRMFkEFO0CqqW4qY/48tQSaW2j38bFhBikgo1La
	3LYtBOyQxzmCvpZfbd5tlcvB2CzzMlAnUQG+1cuhdj48seTe08mkEVZnJv9cfyLF
	Jt4JccpyUFieMODVVI5byQnc4OOWSDTFY4QAO3tTPMnT6Fmpdiyod8WQJbXs=
In-Reply-To: <1459487558-21258-1-git-send-email-avagin@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrey Vagin <avagin@gmail.com>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Andrey Vagin <avagin@openvz.org>

On Thu, 2016-03-31 at 22:12 -0700, Andrey Vagin wrote:
> From: Andrey Vagin <avagin@openvz.org>
> 
> __vfs_write() returns a negative value in a error case.

Ha, right, I'll send this along to Andrew with my next series which
should be soon.

> 
> Cc: Ian Kent <raven@themaw.net>
> Signed-off-by: Andrey Vagin <avagin@openvz.org>
> ---
>  fs/autofs4/waitq.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
> index 0146d91..631f155 100644
> --- a/fs/autofs4/waitq.c
> +++ b/fs/autofs4/waitq.c
> @@ -66,11 +66,12 @@ static int autofs4_write(struct autofs_sb_info
> *sbi,
>  	set_fs(KERNEL_DS);
>  
>  	mutex_lock(&sbi->pipe_mutex);
> -	wr = __vfs_write(file, data, bytes, &file->f_pos);
> -	while (bytes && wr) {
> +	while (bytes) {
> +		wr = __vfs_write(file, data, bytes, &file->f_pos);
> +		if (wr <= 0)
> +			break;
>  		data += wr;
>  		bytes -= wr;
> -		wr = __vfs_write(file, data, bytes, &file->f_pos);
>  	}
>  	mutex_unlock(&sbi->pipe_mutex);
>  
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
