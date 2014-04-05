From: Sasha Levin <sasha.levin@oracle.com>
Subject: Re: [PATCH] autofs4: check dev ioctl size before allocating
Date: Sat, 05 Apr 2014 11:06:57 -0400
Message-ID: <53401C11.7010601@oracle.com>
References: <1394934021-16965-1-git-send-email-sasha.levin@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1394934021-16965-1-git-send-email-sasha.levin@oracle.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

Ping? Anyone wants to take this?

On 03/15/2014 09:40 PM, Sasha Levin wrote:
> There wasn't any check of the size passed from userspace before
> trying to allocate the memory required.
> 
> This meant that userspace might request more space than allowed,
> triggering an OOM.
> 
> Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
> ---
>  fs/autofs4/dev-ioctl.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
> index 3182c0e..86fa7af 100644
> --- a/fs/autofs4/dev-ioctl.c
> +++ b/fs/autofs4/dev-ioctl.c
> @@ -103,6 +103,9 @@ static struct autofs_dev_ioctl *copy_dev_ioctl(struct autofs_dev_ioctl __user *i
>  	if (tmp.size < sizeof(tmp))
>  		return ERR_PTR(-EINVAL);
>  
> +	if (tmp.size > (PATH_MAX + sizeof(tmp)))
> +		return ERR_PTR(-E2BIG);
> +
>  	return memdup_user(in, tmp.size);
>  }
>  
> 

