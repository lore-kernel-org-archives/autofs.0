From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] automount: Fix size arg of fgets(3)
Date: Wed, 06 Jul 2016 18:02:06 +0800
Message-ID: <1467799326.4580.54.camel@themaw.net>
References: <1467642685-2117-1-git-send-email-kusumi.tomohiro@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=IBZBRDad96azqRkV/D7wMwMOlAw=; b=WHhFQ9
	bnLgusbJ23DTRiTXSYN3EoFGfiIldzuxYi58OwTz2xWxpe06FGGqmDEdTKWxVBBS
	0KLL3Ku1s20mIQuJdDr8nzI1c2jQsSpSVAp2r44zXt3Er2Xm0bh7zTTiwjlx41Jr
	PV9f/Zegf9krOI3Can4VLvTXsGcPczWqaijeQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=IBZBRDad96azqRk
	V/D7wMwMOlAw=; b=t+jXk6YqzXiuSxmWtMbvGU2nnfaAl02nnUSHHuDloMdR11a
	ERVdqw8cZKDeWBxEhwWEmuZ3C9JU1HojhNm21hN5vyd5GcahgkXzY9mXg0qpVcWO
	bBcgVPweCOl4AF2jhUi93Uprrl0YKCOelJmGX8upTsLOkZS5gqGqF/lC1Dmg=
In-Reply-To: <1467642685-2117-1-git-send-email-kusumi.tomohiro@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Cc: autofs@vger.kernel.org

On Mon, 2016-07-04 at 23:31 +0900, Tomohiro Kusumi wrote:
> Since fgets(3) reads at most 1 less than size arg, it should
> probably pass MAX_LINE_LEN+1 given that the conditional in the
> next line tests if strlen() exceeds MAX_LINE_LEN.
> (i.e. MAX_LINE_LEN isn't designed to include terminating \0)
> 
> buf has MAX_LINE_LEN+2 bytes, so passing MAX_LINE_LEN+1 is ok.

And also added.

> 
> Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
> ---
>  lib/defaults.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/defaults.c b/lib/defaults.c
> index 0e48a78..ae76513 100644
> --- a/lib/defaults.c
> +++ b/lib/defaults.c
> @@ -879,7 +879,7 @@ static int read_config(unsigned int to_syslog, FILE *f,
> const char *name)
>  	char *res;
>  
>  	new_sec = NULL;
> -	while ((res = fgets(buf, MAX_LINE_LEN, f))) {
> +	while ((res = fgets(buf, MAX_LINE_LEN + 1, f))) {
>  		char *sec, *key, *value;
>  
>  		if (strlen(res) > MAX_LINE_LEN) {
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
