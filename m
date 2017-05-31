From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] Fix usage of uninitialized pointer
Date: Wed, 31 May 2017 08:27:14 +0800
Message-ID: <1496190434.3804.1.camel@themaw.net>
References: <1496151337-21367-1-git-send-email-buczek@molgen.mpg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=q1a5mgTwYHFlGCSVh5
        FEe319fV4vo0wWpIVscRI1s0g=; b=V6qXSMatElXdUXFoLutcxnC+wD0wmb0qjh
        AJyLJ1C0yNOTutCrMI/4svTJM/YMC/aW20forGz3JNggmUEprLg5nd7FkqTa/YUh
        SJOGbyDg0s29L+dJ4CwyOtDwVuZfBwGRkE4GBicJNsdi9Pp7jwNtP7Swm4phVxta
        +KI3Dpxh5P/z19BIdrFzcMk2jlM/wMRb4mkj4VRwyF0VC1qFFB0E/5WkJPzrwNV6
        vraPz+aB08mT7dkFypbPavUqio1EA/nTVLm8kA/EL04dTxqgUdaxoshdGQe2nTFG
        T1+gV3PlLZLQR3Qi+aWBNIVfwceVXgD3raEmT1Fc35CWWyAQqEWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=q1a5mgTwYHFlGCSVh5FEe319fV4vo0wWpIVscRI1s0g=; b=HDTtGLUk
        jHi3bCcDwnnxCFAYMIPCYLLw/RKBuOqJp5tj58LS4zKGIvBsF1HbGEfl78pTPO0E
        hHkbNRc9Ml8SH1Ksqc90+rcMy4DdqrITryMjg6Uw+nA2pLYbvZlCL8XHBZ0WyboA
        cwAT5XVculX7ghkEY7wnWbjTj9iRNFRn9zbxn7Dw1lL/X9rW9sR+4D6NH0T3gyBi
        sIifegsSs+J76JPdozbVF7cnrTKyEIiKFDZZiEvW78CQuf0F0newj0spwZRU5oww
        Y4gnOINICT7CoG/Kv/kKeLjWotyM7y+8WypLTAJMjPLxnQ+zSNmfc95crBv0PetT
        7TepgyALVL+DDQ==
In-Reply-To: <1496151337-21367-1-git-send-email-buczek@molgen.mpg.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Donald Buczek <buczek@molgen.mpg.de>, autofs@vger.kernel.org

On Tue, 2017-05-30 at 15:35 +0200, Donald Buczek wrote:
> In the error path after a getgrgid_r failure (e.g. when a unnamed gid
> was used), the pointer tsv->group was left unitialized. Still the tsv
> was given to pthread_setspecific(key_thread_stdenv_vars,...) and the
> consumers used and freed the uninitialized pointer.

Umm ... ok, I'll check ... good catch.

> 
>     2017-05-29T18:16:11+02:00 rofl automount[14749]: attempting to mount entry
> /package/twiki
>     2017-05-29T18:16:11+02:00 rofl automount[14749]: set_tsd_user_vars: failed
> to get group info from getgrgid_r
>     2017-05-29T18:16:11+02:00 rofl automount[14749]: mounted /package/twiki
>     2017-05-29T18:16:11+02:00 rofl systemd[1]: automount.service: main process
> exited, code=dumped, status=6
>     2017-05-29T18:16:12+02:00 rofl systemd[1]: automount.service holdoff time
> over, scheduling restart.
>     2017-05-29T18:16:12+02:00 rofl systemd[1]: Unit automount.service entered
> failed state.
>     2017-05-29T18:16:12+02:00 rofl automount[17936]: Starting automounter
> version 5.1.3, master map auto.master
> 
>     [May29 18:16] traps: automount[18234] general protection ip:7f8b025c324a
> sp:7f8b0049a508 error:0 in libc-2.19.so[7f8b02541000+1a2000]
> 
> Handle the error by not calling pthread_setspecific. Clean up
> and return instead.
> ---
>  lib/mounts.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/lib/mounts.c b/lib/mounts.c
> index ce6a60a..fe1a6cd 100644
> --- a/lib/mounts.c
> +++ b/lib/mounts.c
> @@ -1552,28 +1552,31 @@ void set_tsd_user_vars(unsigned int logopt, uid_t uid,
> gid_t gid)
>  	}
>  
>  no_group:
> -	if (status || !pgr)
> +	if (status || !pgr) {
>  		error(logopt, "failed to get group info from getgrgid_r");
> -	else {

Extra braces, I leave these out (when I can) on single statement clauses
deliberately and always try to put the single statement as the first branch of
the if.

> +		goto free_gr_tmp;
> +	} else {
>  		tsv->group = strdup(gr.gr_name);
> -		if (!tsv->group)
> +		if (!tsv->group) {
>  			error(logopt, "failed to malloc buffer for group");
> +			goto free_gr_tmp;
> +		}
>  	}
>  
> -	if (gr_tmp)
> -		free(gr_tmp);
> -
>  	status = pthread_setspecific(key_thread_stdenv_vars, tsv);
>  	if (status) {
>  		error(logopt, "failed to set stdenv thread var");
>  		goto free_tsv_group;
>  	}
> -
> +	if (gr_tmp)
> +		free(gr_tmp);

But this doesn't do what I intended.

What I want to do is set the thread specific standard variables even if the
group name can't be obtained.

It looks like I've made an assumption elsewhere that if the tsd is set then all
the variables have valid values, I'd rather fix that than do this.

>  	return;
>  
>  free_tsv_group:
> -	if (tsv->group)
> -		free(tsv->group);
> +	free(tsv->group);
> +free_gr_tmp:
> +	if (gr_tmp)
> +		free(gr_tmp);
>  free_tsv_home:
>  	free(tsv->home);
>  free_tsv_user:
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
