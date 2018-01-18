From: Ian Kent <raven@themaw.net>
Subject: Re: [ANNOUNCE] autofs 5.1.2 release
Date: Thu, 18 Jan 2018 10:19:57 +0800
Message-ID: <0db6bdd1-d096-ceeb-9f81-779af13a3c0d@themaw.net>
References: <1465960537.3164.1.camel@themaw.net>
 <876092krew.fsf@notabene.neil.brown.name>
 <5aee2303-d1c3-49fd-0ef9-362fb0256fd5@themaw.net>
 <be60384c-8d76-b384-3fdd-5f9f2f21a8e2@themaw.net>
 <87po78khtj.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=r8fZ9GMy/tlxzTewixqdXSP039Hvn
        nQ8T9aUQS+YCWg=; b=a5OxwVQHeVm/2nqUi07Uz0ZhU3DKehIDWky2BMu+xFuit
        YxvTfcjToLqqZjB9EYnrXEqqI6ULVIU/sdw1FkQB3CUlQHbziKVbU7IENzUk/WGm
        bOE1mlr0VmnaEHaB/dTjsmBTbvO2xkdDl3uWFrK7+oz/WwNT2xyBOtbofDPi7vCv
        g48KIiv2pK42L3AxSDPADHK0m2xfgWedFVyZkN0H/W9RCKeG2w5S/OBwDIvbTHb1
        BJxgwfakwwryDncZdp2UO8ihQA3d6YBrexH9PGodpac7P4KIKB6DZY+LYmGNVWTy
        Tp08npyiCuatoGn6zlBcJ6Cu5d4/Eyt+nW/4bGVTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=r8fZ9G
        My/tlxzTewixqdXSP039HvnnQ8T9aUQS+YCWg=; b=raPPIDzNAqqFFYSdPC6Aye
        obPRGgQinIHVeZBkJbtDbgEaTbk+g15R6sLWPEh+b1ZFrynm5qD9ugDu9RtLfZoR
        bYAwbn6fic3IajD/x0/bLcH+hhsZSogJpWdyDtm+v1Om9STLn/A+QWUDuQLKlDvE
        YVpBkJAQXR/rOyghHkKogjIY4MN7OLcFL8vi0aeE9mAyP8Or2zsAb8q4XGwQjllu
        mSXX2OdbynR0hnWcOuymn9IB04EieFdLdGcATEOskhQ+7VCFLT/Opn21JlTt3UR5
        8Sdandcm8dHBctfMxhbuB9mlSEDMMVuty4C8kvBBIvugoYpBkRUXZCE6nCePrScA
        ==
In-Reply-To: <87po78khtj.fsf@notabene.neil.brown.name>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.com>, autofs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

On 21/12/17 09:09, NeilBrown wrote:
> --------8<---------------
> Subject: use_hostname_for_mounts shouldn't prevent selection among replica
> 
> If several replicas have been specified for a mount point, and
> use_hostname_for_mount is set to "yes", the selection between
> these replicas is currently disabled and the last in the list is always
> chosen.
> 
> There is little point selecting between different interfaces on the one
> host in this case, but it is still worth selecting between different
> hosts, particularly if different weights have been specified.
> 
> This patch restores the "prune_host_list()" functionality when
> use_hostname_for_mount is set, and modifies it slightly so that once
> an IP address with a given proximity has been successfully probed,
> other IP address for the same host(weight):/path and proximity are ignored.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>
> 
> diff --git a/modules/replicated.c b/modules/replicated.c
> index 3ac4c70f4062..16cf873513ff 100644
> --- a/modules/replicated.c
> +++ b/modules/replicated.c
> @@ -714,7 +714,7 @@ done:
>  int prune_host_list(unsigned logopt, struct host **list,
>  		    unsigned int vers, int port)
>  {
> -	struct host *this, *last, *first;
> +	struct host *this, *last, *first, *prev;
>  	struct host *new = NULL;
>  	unsigned int proximity, selected_version = 0;
>  	unsigned int v2_tcp_count, v3_tcp_count, v4_tcp_count;
> @@ -726,12 +726,6 @@ int prune_host_list(unsigned logopt, struct host **list,
>  	if (!*list)
>  		return 0;
>  
> -	/* If we're using the host name then there's no point probing
> -	 * avialability and respose time.
> -	 */
> -	if (defaults_use_hostname_for_mounts())
> -		return 1;
> -
>  	/* Use closest hosts to choose NFS version */
>  
>  	first = *list;
> @@ -877,11 +871,18 @@ int prune_host_list(unsigned logopt, struct host **list,
>  
>  	first = last;
>  	this = first;
> +	prev = NULL;
>  	while (this) {
>  		struct host *next = this->next;
>  		if (!this->name) {
>  			remove_host(list, this);
>  			add_host(&new, this);
> +		} else if (defaults_use_hostname_for_mounts() && prev &&
> +			   prev->proximity == this->proximity &&
> +			   strcmp(prev->name, this->name) == 0 &&
> +			   strcmp(prev->path, this->path) == 0 &&
> +			   prev->weight == this->weight) {
> +			/* No need to probe same host(weight):/path again */

Mmm ... so maybe I'm the one that's missing the point.

You are trying to eliminate multiple occurrences of list entries that
correspond to a specific host name entry from probing.

It might be sensible to add a "this->rr" following the
defaults_use_hostname_for_mounts() check to avoid the additional
checks when the host doesn't have additional addresses, particularly
the string comparison.

There's nothing stopping people from adding this same host name with a
different weight, even though that doesn't seem like a sensible thing
to do.

I'm not sure if this exposes mounting to problems that aren't already
present with the current implementation.

I'll think a little more about that case but at first glance the DNS
round robin problem of addresses referring to different devices is
still present, a possible false negative.

But that problem exits in the current implementation too as a round
robin lookup can just as easily return an address of a host that isn't
responding at mount time.....

>  		} else {
>  			status = get_supported_ver_and_cost(logopt, this,
>  						selected_version, port);
> @@ -889,6 +890,7 @@ int prune_host_list(unsigned logopt, struct host **list,
>  				this->version = selected_version;
>  				remove_host(list, this);
>  				add_host(&new, this);
> +				prev = this;
>  			}
>  		}
>  		this = next;
> 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
