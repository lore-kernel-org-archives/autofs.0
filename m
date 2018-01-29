From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 2/3] Fix monotonic_elapsed.
Date: Mon, 29 Jan 2018 16:31:15 +0800
Message-ID: <01c5cfdd-afbe-979e-d190-39f393d1d901@themaw.net>
References: <151721021295.27355.1968703903360394469.stgit@noble>
 <151721039460.27355.12976027743239873668.stgit@noble>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=3Ke7nw3K6c7DQq3RvKisW3ZAm4Y1z
        Xn89LcIFORdi2k=; b=PQ4xL5EEo9Tb+Fg82tbY4IxJGo43HHNCbsLkX5eOLP/QP
        1Qrb9xhzMNApDEDQupLpwFeJN5p7+p+L5mcto/nyVFlG47PzmMvZFMQa03fjqsIJ
        xMPMFqF8g3i4AytsM6LNwogYRoDTtnpGBK5G3oO9KguxfCw1bTiXiaPyCvF/tIYO
        rt3zkBvY1i+eVUzoGoVY/gXKlKPgS3uQjyMzhH/x5L01fR2Ot+nhu2K14+6QWXth
        6jb2GiLCJioa+Hoy4IRqTz9kaXeDpQPWG7t4F+MiHoUAG7xd4qW6KOlio7mCa/yf
        KnnSfmuP4rnLkPnBwPIcCfyYZO7ZwgnvTlHGMG3Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=3Ke7nw
        3K6c7DQq3RvKisW3ZAm4Y1zXn89LcIFORdi2k=; b=L0n4Womd4JiK2m3//K0Wo2
        9g4FN+kek2O6wLxMdRF0NnQMUHOWrQkM1Ew4bPq1TWWopE/FOpSes5frU1Sb8mtt
        JzGXA0OV8q+xZFJ0Vh3JFe//EIkD3rO5d3seaXG6yiVlKQqfnFdIGjXjjuqedKgl
        Dt0WICfdFGrI1J0bh8lag9aQhezPvMKdJQFwYPhb3NPNixdwwqariNLDGk69Sz1c
        pYCRjqUPWxid6MGlACmMBoiv9QlyMBPZT+lGhcikCy3ZGNyho0ZaNFuf7MRjgaKW
        aSPpS/w2PlJOOrGlNPrtg/OV9w8zeJucqZjj2z5OQgh9Y6jKlLcfp3GAFp3wIMEA
        ==
In-Reply-To: <151721039460.27355.12976027743239873668.stgit@noble>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.com>
Cc: autofs@vger.kernel.org

On 29/01/18 15:19, NeilBrown wrote:
> When automount probes multiple hosts to find the one which
> responds most quickly, it currently ignores the nanoseconds.
> This often makes the cost "0", which makes weights ineffective.
> 
> The cause is that monotonic_elapsed() casts tv_nsec to a
> double *after* dividing by 1 billion, rather than before.
> 
> With this change, weights become effective for choosing
> between hosts which respond in under one second.

Yes, when I looked I saw this was part of the series to change
to using the monotonic clock in order to avoid problems with
discontinuous jumps in system time.

I completely missed this when I reviewed the series.

Thanks Neil.

Umm ... I don't see patches 1 and 3, maybe they got lost in the
ether or they'll arrive later .... 
 
> 
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  lib/rpc_subs.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c
> index 73097c9d4238..60ede9f8c085 100644
> --- a/lib/rpc_subs.c
> +++ b/lib/rpc_subs.c
> @@ -1093,9 +1093,9 @@ double monotonic_elapsed(struct timespec start, struct timespec end)
>  	double t1, t2;
>  
>  	t1 =  (double) start.tv_sec +
> -		(double) (start.tv_nsec/(1000*1000*1000));
> +		((double) start.tv_nsec/(1000*1000*1000));
>  	t2 =  (double) end.tv_sec +
> -		(double) (end.tv_nsec/(1000*1000*1000));
> +		((double) end.tv_nsec/(1000*1000*1000));
>  	return t2 - t1;
>  }
>  
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
> 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
