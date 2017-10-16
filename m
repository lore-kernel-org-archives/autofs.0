From: Vincent McIntyre <vincent.mcintyre@csiro.au>
Subject: Re: [PATCH 26/35] autofs-5.1.3 - document ghost option in
 auto.master man page
Date: Mon, 16 Oct 2017 17:00:14 +1100
Message-ID: <20171016060014.GP15217@mayhem.atnf.CSIRO.AU>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
 <150813052207.25695.16615651390055095096.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=csiro.au; i=@csiro.au; q=dns/txt; s=dkim;
  t=1508133617; x=1539669617;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sc9NmnpB0h4uwS2Ols9bPufF/vdH+P6l7fMoxyopZoY=;
  b=D486krG8Itoe6d4wx+HPZm1kHNGOV8lRBz8oBALzdxwDg36w1X16sVf0
   nKKFTW+pxDTw7grhR0PbJ8fOWLW5qihN8tnMVz/4xhp0jxEXQrDcEMXQX
   D9ge1TKOf4IhUiRz7GoF/vLuRQJ+yu5DWLEUDX9uHTigRu0nsMkmOrbJB
   U=;
Content-Disposition: inline
In-Reply-To: <150813052207.25695.16615651390055095096.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Mon, Oct 16, 2017 at 01:08:42PM +0800, Ian Kent wrote:
> The --ghost pseudo option has been depricated for quite a while now
> in favour of the browse option as descibed in auto.master(5).
> 
> However it isn't noted in the description of the browse option that
> the --ghost option is the same as the browse option.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---
>  CHANGELOG            |    1 +
>  man/auto.master.5.in |    3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/CHANGELOG b/CHANGELOG
> index 6a18fd15..7457e620 100644
> --- a/CHANGELOG
> +++ b/CHANGELOG
> @@ -24,6 +24,7 @@ xx/xx/2017 autofs-5.1.4
>  - fix autofs_use_lofs description.
>  - fix amd parser error buffer size.
>  - make spawn_bind_mount() use mount_wait as well.
> +- document ghost option in auto.master man page.
>  
>  24/05/2017 autofs-5.1.3
>  =======================
> diff --git a/man/auto.master.5.in b/man/auto.master.5.in
> index c87fb7f4..4475186a 100644
> --- a/man/auto.master.5.in
> +++ b/man/auto.master.5.in
> @@ -168,7 +168,8 @@ can cause performance problem if the indirect map is large so it should
>  be used with caution. The internal program default is to enable browse
>  mode for indirect mounts but the default installed configuration overrides
>  this by setting BROWSE_MODE to "no" because of the potential performance
> -problem.
> +problem. This option does the same as the depricated --ghost option, the

nit:
s/depricated/deprecated/g

> +browse option is preferred because it is used by other autofs implementations.
>  .TP
>  .I "nobind"
>  This is an autofs specific option that is a pseudo mount option and
> 
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
> 

Vince
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
