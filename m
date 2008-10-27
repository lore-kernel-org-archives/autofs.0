From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/6] autofs4 - remove string terminator check
Date: Mon, 27 Oct 2008 13:31:31 -0700
Message-ID: <20081027133131.f2011d28.akpm@linux-foundation.org>
References: <20081023023513.4508.54940.stgit@raven.themaw.net>
	<20081023023522.4508.27987.stgit@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20081023023522.4508.27987.stgit@raven.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org

On Thu, 23 Oct 2008 10:35:22 +0800
Ian Kent <raven@themaw.net> wrote:

> Remove unnecessary string terminator check.

Why is it unnecessary?

Does this change alter behaviour in any way?

Does it fix a bug?

Better changelogs, please....

> --- a/fs/autofs4/dev-ioctl.c
> +++ b/fs/autofs4/dev-ioctl.c
> @@ -51,18 +51,6 @@ static int check_name(const char *name)
>  }
>  
>  /*
> - * Check a string doesn't overrun the chunk of
> - * memory we copied from user land.
> - */
> -static int invalid_str(char *str, void *end)
> -{
> -	while ((void *) str <= end)
> -		if (!*str++)
> -			return 0;
> -	return -EINVAL;
> -}
> -
> -/*
>   * Check that the user compiled against correct version of autofs
>   * misc device code.
>   *
> @@ -143,14 +131,6 @@ static int validate_dev_ioctl(int cmd, struct autofs_dev_ioctl *param)
>  				    cmd);
>  			goto out;
>  		}
> -
> -		err = invalid_str(param->path,
> -				 (void *) ((size_t) param + param->size));
> -		if (err) {
> -			AUTOFS_WARN("invalid path supplied for cmd(0x%08x)",
> -				    cmd);
> -			goto out;
> -		}
>  	}
>  
>  	err = 0;
