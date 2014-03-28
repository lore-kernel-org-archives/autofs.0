From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] Fixes for samples/auto.master
Date: Fri, 28 Mar 2014 08:20:02 +0800
Message-ID: <1395966002.2704.0.camel@perseus.fritz.box>
References: <20140327063059.GG19822@mayhem.atnf.CSIRO.AU>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=QNV2BG/JtopIRbH3/3n2tiG90Sg=; b=XtfBRjpFCH1yt5IqrQss0QIhAswt
	qeqQg6OnBOqEqRhYC6EP0513ziTIiVu90bZDLuRNmxdqGGB97uv+1reIC+jFo2mp
	MVJgufFXx3+HejLkGQjbcmAcOb7ethQNjUwWTPEjSc9dc2KD/B/4mxOk6J+7IOrE
	PJGdV5EwoH8gbD8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=QNV2BG/JtopIRbH3/3n2ti
	G90Sg=; b=tlWEIPke/Q/meW0OeMiU5j3hQM0oV2oU4C3Swf57mfH5W29ZgBMZQh
	6I1qQIzGJ9PYvxT8QCf0FkyyWMdW+DCDu4Jn2MV/sQucG4AKvLbXyRuxXWyFJzc3
	ZwQ+MoT/DxWFOcSqB1P37LeN5psDSH6NMNi114xDGU9KIM+n1xaFw=
In-Reply-To: <20140327063059.GG19822@mayhem.atnf.CSIRO.AU>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vincent McIntyre <vincent.mcintyre@csiro.au>
Cc: autofs@vger.kernel.org

On Thu, 2014-03-27 at 17:31 +1100, Vincent McIntyre wrote:
> Hi,
> 
> I noticed that the preamble in samples/auto.master seemed to be
> referring to a regular autofs map, not a 'master' map.
> Perhaps this patch would clear that up?

Thanks, I'll add that to my patch queue for the next push.

> 
> Kind regards,
> Vince
> 
> Signed-off-by: <vincent.mcintyre@csiro.au>
> 
>   Vincent McIntyre (2):
> ---
>   Replace description that described regular automount maps, not master
>     maps.     Add a note about the format of included files.
>   Clarify what happens to master map options not consumed by 'mount'.
> 
>  man/auto.master.5.in |    2 +-
>  samples/auto.master  |    7 ++++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> 
> diff --git a/samples/auto.master b/samples/auto.master
> index 72f086c..0f2c8ab 100644
> --- a/samples/auto.master
> +++ b/samples/auto.master
> @@ -1,8 +1,8 @@
>  #
>  # Sample auto.master file
> -# This is an automounter map and it has the following format
> -# key [ -mount-options-separated-by-comma ] location
> -# For details of the format look at autofs(5).
> +# This is a 'master' automounter map and it has the following format:
> +# mount-point [map-type[,format]:]map [options]
> +# For details of the format look at auto.master(5).
>  #
>  /misc	/etc/auto.misc
>  #
> @@ -13,6 +13,7 @@
>  /net	-hosts
>  #
>  # Include /etc/auto.master.d/*.autofs
> +# The included files must conform to the format of this file.
>  #
>  +dir:/etc/auto.master.d
>  #
> -- 
> 1.7.2.5
> 
> 
> diff --git a/man/auto.master.5.in b/man/auto.master.5.in
> index 1d96d7e..1095406 100644
> --- a/man/auto.master.5.in
> +++ b/man/auto.master.5.in
> @@ -139,7 +139,7 @@ the \fBdn\fP of an LDAP entry for maps of type \fBldap\fP.
>  .br
>  Any remaining command line arguments without leading dashes (\-) are
>  taken as options (\fI\-o\fP) to \fBmount\fP.  Arguments with leading
> -dashes are considered options for the maps.
> +dashes are considered options for the maps and are passed to automount (8).
>  .sp
>  The \fBsun\fP format supports the following options:
>  .RS


