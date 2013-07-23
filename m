From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 2/6] fix dead LDAP symbol link with LDAP support disabled
Date: Tue, 23 Jul 2013 17:50:38 +0800
Message-ID: <1374573038.3418.3.camel@perseus.fritz.box>
References: <dennis.yxun@gmail.com>
	 <1374505194-22668-1-git-send-email-dennis.yxun@gmail.com>
	 <1374505194-22668-3-git-send-email-dennis.yxun@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=ta8QIH2SsqIzoCPxK8c76mA31O8=; b=ia+VJogCEtfssy5Gyz++D0AqZP6J
	5e1hhZVIMleVKjgcyfOxbrTfDfX5t8wbkwpdBWFE0dKtc28ZYARbnL13CAT8/WQP
	qrQvMToNnVRP4W4714Jff9Rujusu9/FmGGPfFd8VCSFTtYzOYvJv080UTzRUWspW
	uoSTXWiFd1tZDv8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=ta8QIH2SsqIzoCPxK8c76m
	A31O8=; b=oUsXYxTOSFEckUsrBo6CD1VctKQPaW83S4/KLmtNG1Rc0aDStBzJgc
	RV/pflhR2FiRxD+811ITUmUMZjy72fk6gXhVGLiXpwmLynrUiipfO0KsUlIDMI2y
	Po/7t+p2LFj1pJHyew+nMNwq7O0R0icIylS/2ICbxHWUOrzGT0z6A=
In-Reply-To: <1374505194-22668-3-git-send-email-dennis.yxun@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Cc: autofs@vger.kernel.org

On Mon, 2013-07-22 at 22:59 +0800, Lan Yixun (dlan) wrote:
> From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
> 
> autofs will create symbol link mandatory no matter ldap support
> is enabled or not. so, without this patch, lookup_ldaps.so will become
> a dead link.

I have added this to my patch queue.
It will be committed next time I push patches to the repo.
Thanks

> 
> ---
> Upstream Discussion:
>   http://thread.gmane.org/gmane.linux.kernel.autofs/5371
> 
> Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
> ---
>  modules/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/modules/Makefile b/modules/Makefile
> index c5deb24..4bb1096 100644
> --- a/modules/Makefile
> +++ b/modules/Makefile
> @@ -74,7 +74,9 @@ install: all
>  	-rm -f $(INSTALLROOT)$(autofslibdir)/mount_smbfs.so
>  	ln -fs lookup_file.so $(INSTALLROOT)$(autofslibdir)/lookup_files.so
>  	ln -fs lookup_yp.so $(INSTALLROOT)$(autofslibdir)/lookup_nis.so
> +ifeq ($(SASL), 1)
>  	ln -fs lookup_ldap.so $(INSTALLROOT)$(autofslibdir)/lookup_ldaps.so
> +endif
>  	ln -fs mount_nfs.so $(INSTALLROOT)$(autofslibdir)/mount_nfs4.so
>  ifeq ($(EXT2FS), 1)
>   ifeq ($(EXT3FS), 1)


