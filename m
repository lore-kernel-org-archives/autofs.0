From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] add missing libtirpc lib to mount_nfs.so when TIRPC
 enabled
Date: Wed, 24 Jul 2013 11:31:43 +0800
Message-ID: <1374636703.2358.25.camel@perseus.fritz.box>
References: <1374633420-28235-1-git-send-email-dennis.yxun@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=4U61bd4ZSiDIrz5Y+qZAErkbnzY=; b=QQp+AVgSNDn/PBLRTDw48R6kpJkV
	Uds2/sD0UCTm79McXxpTtNzgTDD5zCkz6BWQnp+dsVdtYt/DguWFOqoTO0WQSLaJ
	KUQrolreAOSoVpYed/AjncZ7Jdx0IqCMZH9POeqFVplk0/1oK/mAD0TkwpM/g5sx
	CC+XbZ++lCepQQ4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=4U61bd4ZSiDIrz5Y+qZAEr
	kbnzY=; b=ATBIZ9gB7sB4PUjxgMZvGP/sl1CYpbIUYqFR9RaL48tAD8tsoQcJxK
	9jh9g37kpO/Ja7Gpj9dWLMt4li4W4o120oGJDpgVwUi5U9ezcx2x4cZzhoHPvLT0
	NBjrT7EDgzdMeztM3GbHERENtr2oK6o2CjVL0i5QNFDsEHKLCY5mw=
In-Reply-To: <1374633420-28235-1-git-send-email-dennis.yxun@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Cc: autofs@vger.kernel.org

On Wed, 2013-07-24 at 10:37 +0800, Lan Yixun (dlan) wrote:
> From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
> 
> this is need when libtirpc is enabled, otherwise autofs fail to start
> due to it can't find symbol clnt_dg_create (which is provided by libtirpc)

Yeah, I use libtirpc all the time but that's something I haven't
noticed, probably because TIRPC_WORKAROUND will cause the library to be
dlopen()ed at start.

So while the change is needed and I'll apply it, I'm not sure why you're
seeing it since the library should be open and loaded already.

> 
> ---
> autofs error log from /var/log/message:
> 
> Jul 23 12:11:58 ofire automount[25699]: open_mount:244: parse(sun): cannot open mount module
> nfs (/usr/lib64/autofs/mount_nfs.so: undefined symbol: clnt_dg_create)
> Jul 23 12:11:58 ofire automount[25699]: lookup(file): failed to open parse context
> 
> without this patch, mount_nfs.so fail link to libtirpc.so
>  # ldd /usr/lib64/autofs/mount_nfs.so |grep tirpc
> 
> with this patch applied:
>  # ldd /usr/lib64/autofs/mount_nfs.so |grep tirpc
>         libtirpc.so.1 => /lib64/libtirpc.so.1 (0x00007f7d94920000)
> 
> Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
> ---
>  modules/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/modules/Makefile b/modules/Makefile
> index 4bb1096..0fe8ae8 100644
> --- a/modules/Makefile
> +++ b/modules/Makefile
> @@ -116,6 +116,6 @@ lookup_ldap.so: lookup_ldap.c dclist.o base64.o $(SASL_OBJ)
>  
>  mount_nfs.so: mount_nfs.c replicated.o
>  	$(CC) $(SOLDFLAGS) $(CFLAGS) -o mount_nfs.so \
> -		mount_nfs.c replicated.o $(AUTOFS_LIB) $(LIBNSL)
> +		mount_nfs.c replicated.o $(AUTOFS_LIB) $(LIBNSL) $(TIRPCLIB)
>  	$(STRIP) mount_nfs.so
>  


