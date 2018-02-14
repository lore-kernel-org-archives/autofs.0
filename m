From: Vincent McIntyre <vincent.mcintyre@csiro.au>
Subject: Re: [PATCH 20/20] autofs-5.1.4 - add an example fedfs master map
 entry to the installed master map
Date: Thu, 15 Feb 2018 10:47:34 +1100
Message-ID: <20180214234734.GC15525@mayhem.atnf.CSIRO.AU>
References: <151859051902.8026.13693256398323544616.stgit@pluto.themaw.net>
 <151859068445.8026.13141630121236897160.stgit@pluto.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=csiro.au; i=@csiro.au; q=dns/txt; s=dkim;
  t=1518652652; x=1550188652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0ELoCrncpwH/nQtByjyuWyU+/1w2EJvOnCkq7EI7wMM=;
  b=WVRdakncz0pXhoOKGm52EZeMuOM6RJYLj6Px6dyyRbevkqCbZy3sHDX+
   vmOPjEq9PXH8eomKo+MzN3PzL4rixIrjNr+72PPT/s2YaNtlpJOXte7/p
   sALBCqzjvQUDBzt/v5GG9uFp9sndGs7sn8sPMRYucJR70UR/SSKrmro+H
   E=;
Content-Disposition: inline
In-Reply-To: <151859068445.8026.13141630121236897160.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Wed, Feb 14, 2018 at 02:44:44PM +0800, Ian Kent wrote:
> Add an example of using the fedfs program map (to facilitate access
> to fedfs domain mounts) to the installed master map.
> ---
>  CHANGELOG           |    1 +
>  samples/auto.master |    6 ++++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/CHANGELOG b/CHANGELOG
> index bbe8019e..f771a433 100644
> --- a/CHANGELOG
> +++ b/CHANGELOG
> @@ -18,6 +18,7 @@ xx/xx/2018 autofs-5.1.5
>  - add mount.fedfs.c.
>  - add fedfs-map-nfs4.c.
>  - add conditional inclusion of fedfs binaries.
> +- add an example fedfs master map entry to the installed master map.
>  
>  19/12/2017 autofs-5.1.4
>  - fix spec file url.
> diff --git a/samples/auto.master b/samples/auto.master
> index 0f2c8ab0..6c95fadf 100644
> --- a/samples/auto.master
> +++ b/samples/auto.master
> @@ -17,6 +17,12 @@
>  #
>  +dir:/etc/auto.master.d
>  #
> +# If you have fedfs setup and the realted binaries, either

s/setup/set up/     (?)
s/realted/related/

Regards
Vince
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
