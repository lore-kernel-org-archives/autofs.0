From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] systemd: allow --with-systemd to take a path arg
Date: Tue, 19 Nov 2013 14:34:07 +0800
Message-ID: <1384842847.2862.2.camel@perseus.fritz.box>
References: <1383329318-23791-1-git-send-email-joe@deserted.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=2fSh5NxklzmdH3KHSAV/tFpCpv0=; b=TcjlRoCCgTzuV9v6COUkfsYom84k
	aB470jyv9JWYWHBdD3C8VNE2TP3146lRm6GnCOvbIOp9evpKOnllne4mggwRST96
	hQvou21lHQH+IsaQMA/UTJ6mO/PGetRWm9PLPEL1z7+xYfaNsoJSMqy2SvTOyVjW
	nZbk5d1iXMnyp4E=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=2fSh5NxklzmdH3KHSAV/tF
	pCpv0=; b=MTGKMQSU1e6OpVXP6RQeUEteikQb8kGkAjb+RRVTJl3NL9ixCpeI1B
	uHjzBbA4lBNSMbh/x6X3So1QRVlVPMhYBomS7B6nKQYzx+tzxTHABTCmSkwv1Yga
	2R+P52hHtwUBEQUDi3guA/UFJ8HAyLhsef+7g+AP9eQlNG9dBU0Qo=
In-Reply-To: <1383329318-23791-1-git-send-email-joe@deserted.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Joe MacDonald <joe@deserted.net>
Cc: autofs@vger.kernel.org

On Fri, 2013-11-01 at 14:08 -0400, Joe MacDonald wrote:
> If building for a cross-compile environment with systemd it is convenient
> to be able to specify a systemd path for the target that may not be the
> same as that on the host.

There was a similar request recently which I didn't act on.
There was a bit more to it than this one.

Hopefully adding this will cover the needs of the other request too.
I've added the patch to my queue of patches and it will get committed
next time I push changes, not sure when that will be though.

> 
> Signed-off-by: Joe MacDonald <joe@deserted.net>
> ---
> 
> I encountered a problem while working with autofs in a cross-compile
> environment where the host and target have either differing systemd paths
> or where one may not have systemd support at all.  The common solution
> I've seen in other projects is to have a --with-systemddir=[path] option,
> but I thought it'd be simpler to add an optional path argument to the
> extant '--with-systemd' configure parameter and leave the default =y+probe
> for path logic in place.
> 
>  aclocal.m4 |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/aclocal.m4 b/aclocal.m4
> index 3e6f223..105e3e9 100644
> --- a/aclocal.m4
> +++ b/aclocal.m4
> @@ -229,8 +229,10 @@ dnl Check the location of the systemd unit files directory
>  dnl --------------------------------------------------------------------------
>  AC_DEFUN([AF_WITH_SYSTEMD],
>  [AC_ARG_WITH(systemd,
> -[  --with-systemd         install systemd unit file if systemd unit directory
> -			  is found on system],
> +[  --with-systemd@<:@=systemddir@:>@  install systemd unit file.  If 'yes'
> +			  probe the system for unit directory.
> +			  If a path is specified, assume that
> +			  is a valid install path.],
>  [if test "$withval" = yes; then
>    if test -z "$systemddir"; then
>      AC_MSG_CHECKING([location of the systemd unit files directory])
> @@ -247,6 +249,10 @@ AC_DEFUN([AF_WITH_SYSTEMD],
>    else
>      AC_MSG_RESULT(not found)
>    fi
> +else
> + if test "$withval" != no; then
> +  systemddir=$withval
> + fi
>  fi])
>  ])
>  


