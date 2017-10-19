From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH v2] autofs-5.1.3 - fix ordering of seteuid/setegid in
 do_spawn
Date: Thu, 19 Oct 2017 10:07:39 +0800
Message-ID: <19a1e4a4-063b-fb9d-eb47-9ac368d53aaf@themaw.net>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
 <150813043348.25695.10697953082315362911.stgit@pluto.themaw.net>
 <cf4f19a9-cbf4-2077-a26a-922268c80507@suse.com>
 <12498ca2-9aae-54ab-832a-0760ba221261@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=j+sf8Gg1zJXCM1e2jPV+2pQ/wEpMe
        BiEqGbPGztFThE=; b=jgIliztZKPrLK/6JK26xS4uoxag/6RlouQ2gEL5dYPPXo
        sBQeabl+WhL75sENt/ceg8MeenYcofipZO3v/jzP7bnLyYkprsMMNEgFsT0z9LMO
        VxxvtDsYNyM081jwOx+9Pt4f+p3UPTrHVCWnJHZPvP8/pqmz4iPzCZ6XQm36ufz7
        nzfwNr3stj6j7MF5z1MRVzBQl8eGR+H4NT4HyLL581c5gZe9s0yJAKI8qr+L9myF
        x0zTLCEV5Jr7Eb/XVWKWHqe3W/nDNPkhLl3u9IA41RD318AulYydD6zQ83P/RrCK
        UMt/PSWaujeeUDzQCa6z4w1tAmnAqopl0oC/gBqpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=j+sf8G
        g1zJXCM1e2jPV+2pQ/wEpMeBiEqGbPGztFThE=; b=Ztlno1MtzMYSZNenlLgkyy
        2b1Mowp5+3XhMNy3agLj9+tqY+MDX9SsGkdxpuIFsJrtlyVRQUIT5D+EqVX+2P91
        sZs8puypm9pX7tvs7XsbVgZ/+QATaJRw7BF/3gz2n7jk/kg25HTmAqREsVS4wU6y
        ZE/GT8cB6AxWneHVr0w3PLrumgl2EYvziPS+C44q+Yc2AxUsTqAMYvu6G0Rz/dz5
        fZvOYbyHoiVeBSdncXwcSZw0s82Z+iZR7FV536vPb1k6eY+ckOx9YKYLbyAC4j3r
        RkwS9Mlgc7RgWA9uZyQVjfdKNbq/Iz7pgGnieszb3RAmATcm5cibdfYjjjlxIDLg
        ==
In-Reply-To: <12498ca2-9aae-54ab-832a-0760ba221261@suse.com>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jeff Mahoney <jeffm@suse.com>, autofs mailing list <autofs@vger.kernel.org>

On 19/10/17 05:12, Jeff Mahoney wrote:
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
> +				if (initgroups(tsv->user, egid) == -1)

LOL, you spotted that one.

I was wondering if the groups need to be restored after the open() ....
before the mount is executed.

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
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
> 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
