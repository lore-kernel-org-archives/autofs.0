From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs-5.1.3 - fix ordering of seteuid/setegid in
 do_spawn
Date: Thu, 19 Oct 2017 09:59:31 +0800
Message-ID: <30506064-571f-20fc-d591-013ebbd88f43@themaw.net>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
 <150813043348.25695.10697953082315362911.stgit@pluto.themaw.net>
 <cf4f19a9-cbf4-2077-a26a-922268c80507@suse.com>
 <28261d95-ead4-3566-d035-624cdbdafbbe@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=MwVyaqBP0E+2Pymcdc7A4slGNRiuA
        fszrQSpQwDYPUY=; b=fVwOTiyxOEmcc/Mjy9a56Iq+Ow1HUpkAzkUvHRMYpvJWg
        PaZPLeaMmUUbpdrb0XdYAHf2isS9ESAZHx5APTadVktA6B2626gbGE7UJfx3hxMm
        N+F3TSGD8o3a9iwqCrNDhJNk6cPkT10h6hNkjG+QvI0HOFiLZU2hncFDk7kgBTDX
        pJy5vHqfjv5lV2YSHKlwyUR5WPnrhE2+5YHQkkcNvK7gL1Kzuhf4CY+VUQzUnI6k
        tR1kw7brGzFY+tsgUI5Tzyxt2+c3g0DduA9LeEYip93echugFOIWHnKrFhPTdwoZ
        VxVCZyEzHvN5ATapap6JdbP5Pmkfq6IjQHYpfzhCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=MwVyaq
        BP0E+2Pymcdc7A4slGNRiuAfszrQSpQwDYPUY=; b=N1erwynIxn1sFq7/dW7k3F
        bkDfO1+ROF2M2v7FUKR1H3JOdLuosFcArSZYay4HGnXe9eGM+1oP1Uea7d61DUZy
        oVL7LAYQjGfSNZQDpifcpKL7GWaKQd6t8ySVruSkeziDIY9sN4bPbPyo3myW7+X0
        pZNYg19otSNNtVcOihrA9ESExW4qKzbmyNtunj+fh+Yf0NSh1832cNrBh8ss61sf
        scy+0hV5dw/0785cvuJVwghh7Z67gzZNMwALtFEoLE9BNAIo9KJjKOnps6Y3QM1X
        9PeH9gvaqYUQUvrqz7EQ8URMLRKnqVL1bwMNJFRZwrX9yxwwtYvTqZaYI/Z6XBqg
        ==
In-Reply-To: <28261d95-ead4-3566-d035-624cdbdafbbe@suse.com>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jeff Mahoney <jeffm@suse.com>, autofs mailing list <autofs@vger.kernel.org>

On 19/10/17 04:57, Jeff Mahoney wrote:
> In do_spawn, We call seteuid() prior to calling setegid() which means
> that, when we're using an unprivileged uid, we won't have permissions
> to set the effective group anymore.
> 
> We also don't touch the group memberships so the permissions used to
> open the directory will will include all of root's supplementary groups
> and none of the user's.
> 
> This patch reverses the ordering and uses initgroups() to reset the
> supplementary groups to the unprivileged user's groups.
> 
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> ---
>  daemon/spawn.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/daemon/spawn.c b/daemon/spawn.c
> index c640d97..62e9f02 100644
> --- a/daemon/spawn.c
> +++ b/daemon/spawn.c
> @@ -20,6 +20,7 @@
>  #include <string.h>
>  #include <sys/types.h>
>  #include <dirent.h>
> +#include <grp.h>
>  #include <time.h>
>  #include <poll.h>
>  #include <sys/wait.h>
> @@ -195,8 +196,18 @@ static int do_spawn(unsigned logopt, unsigned int wait,
>  			 * program group to trigger mount
>  			 */
>  			if (euid) {
> -				seteuid(euid);
> -				setegid(egid);
> +				if (initgroups(rsv->user, egid) == -1)

I've changed this to use tsv as that's what it is in my source.
Also I added a NULL check on tsv->user, it should be set but you never know.

Other than that, thanks Jeff.

> +					fprintf(stderr,
> +						"warning: initgroups: %s\n",
> +						strerror(errno));
> +				if (setegid(egid) == -1)
> +					fprintf(stderr,
> +						"warning: setegid: %s\n",
> +						strerror(errno));
> +				if (seteuid(euid) == -1)
> +					fprintf(stderr,
> +						"warning: seteuid: %s\n",
> +						strerror(errno));
>  			}
>  			setpgrp();
>  
> 
> 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
