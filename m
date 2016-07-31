From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/3] autofs-5.1.2 - Remove unused local 2KB buffer
Date: Sun, 31 Jul 2016 11:23:49 +0800
Message-ID: <1469935429.14696.6.camel@themaw.net>
References: <1469853339-2291-1-git-send-email-kusumi.tomohiro@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=abfLW7iuRXZZRhhKzaUEw5OqqJE=; b=m3CAUw
	61fO9xszjl2G2luvBZKqke3UNFem0KfzKOvmjbV1qbISBGhlhrBTUCX0/CVYDUxU
	qLm0Krp/mzkgGWweIze3sBk08yg64RmevlK/4vbObVPWpDVAAAfNrNA9MGnc/q+2
	tgoZx7eXl3V1Y4gbNgEWeU2HBEDB85vwxX6qY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=abfLW7iuRXZZRhh
	KzaUEw5OqqJE=; b=f9HSUOH73z5N6H4qjvvBFwr12Xuqcf69jwnJ+M0q/f5TZOg
	ec9iGdUX+8BeEyJd7BgqCTPViseNzXjFMxKWyHRcEiQ3PkDPMt+R1XIPW6XPHuUh
	Rpwo17OaANVMR/tCvCf95zucfGTPeTwX+EWqwVXwhpO4nwUxYTo9GDcHp7i8=
In-Reply-To: <1469853339-2291-1-git-send-email-kusumi.tomohiro@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs@vger.kernel.org

On Sat, 2016-07-30 at 13:35 +0900, Tomohiro Kusumi wrote:
> Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

Thanks for the patches.

They all look fine, they look straight forward, I'll include them in the list of
patches for the next commit.

I thought I'd take this opportunity to let you know what's going on with the
kernel module patches.

I'm having trouble getting time to update and test my module rename patch series
so I'm planning on sending the patches I have, mostly yours and possibly one or
two of mine, as soon as I can get a chance.

Fact is I'm having trouble getting time even to do that but I am trying.

> ---
>  daemon/automount.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/daemon/automount.c b/daemon/automount.c
> index ad5cafd..3afa860 100644
> --- a/daemon/automount.c
> +++ b/daemon/automount.c
> @@ -1901,7 +1901,6 @@ static void usage(void)
>  
>  static void show_build_info(void)
>  {
> -	char buf[2048];
>  	int count = 0;
>  
>  	printf("\nLinux automount version %s\n", version);
> @@ -1913,8 +1912,6 @@ static void show_build_info(void)
>  
>  	printf("\nCompile options:\n  ");
>  
> -	memset(buf, 0, 2048);
> -
>  #ifndef ENABLE_MOUNT_LOCKING
>  	printf("DISABLE_MOUNT_LOCKING ");
>  	count = 22;
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
