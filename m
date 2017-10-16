From: Vincent McIntyre <vincent.mcintyre@csiro.au>
Subject: Re: [PATCH 34/35] autofs-5.1.3 - improve description of
 mount_nfs_default_protocol
Date: Mon, 16 Oct 2017 16:37:57 +1100
Message-ID: <20171016053757.GN15217@mayhem.atnf.CSIRO.AU>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
 <150813057523.25695.3001080814749098407.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=csiro.au; i=@csiro.au; q=dns/txt; s=dkim;
  t=1508132876; x=1539668876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uE9G21DsmNzQdcm1qV5D66zDEgeB4NX6DX6EpHs4UHI=;
  b=LQqgO6+yKJZjr6CTf6t3j7kQHOu/XhsBZCwSmcAHEq3pw2a9CgIz0NHN
   RTn3QTUKZbhzmMA6hFVrlT7/hyzw/ebRGmF6L2qW9e9F5MX71V2lDV91/
   oTtXmU4FRzuW9S2/EO+L1NzLFbC/Z1LsIZzW5IFyf7x7U4J/1CSjxsRJk
   o=;
Content-Disposition: inline
In-Reply-To: <150813057523.25695.3001080814749098407.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Mon, Oct 16, 2017 at 01:09:35PM +0800, Ian Kent wrote:

nitpicking

>  # mount_nfs_default_protocol - specify the default protocol used by
> -# 			       mount.nfs(8). Since we can't identify
> -# 			       the default automatically we need to
> -# 			       set it in our configuration.
> +# 			       mount.nfs(8). Autofs needs to know the
> +# 			       default NFS protocol that mount.nfs(8)
> +# 			       will use so it can do special case handling
> +# 			       for different NFS protocols .Since we can't
I think you want
 +# 			       for different NFS protocols. Since we can't

> +# 			       identify the default automatically we need
> +# 			       to set it in our configuration.
>  #
>  #mount_nfs_default_protocol = 3
>  mount_nfs_default_protocol = 4
> diff --git a/samples/autofs.conf.default.in b/samples/autofs.conf.default.in
> index a04b56f9..4bbecc64 100644
> --- a/samples/autofs.conf.default.in
> +++ b/samples/autofs.conf.default.in
> @@ -45,9 +45,12 @@ timeout = 300
>  browse_mode = no
>  #
>  # mount_nfs_default_protocol - specify the default protocol used by
> -# 			       mount.nfs(8). Since we can't identify
> -# 			       the default automatically we need to
> -# 			       set it in our configuration.
> +# 			       mount.nfs(8). Autofs needs to know the
> +# 			       default NFS protocol that mount.nfs(8)
> +# 			       will use so it can do special case handling
> +# 			       for different NFS protocols .Since we can't

ditto
 +# 			       for different NFS protocols. Since we can't

> +# 			       identify the default automatically we need
> +# 			       to set it in our configuration.
>  #
>  #mount_nfs_default_protocol = 3
>  #

Vince
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
