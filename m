From: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Subject: Re: [PATCH 5/9] autofs-5.0.7 - use compiler determined by configure
 instead of hard-coded ones
Date: Wed, 24 Jul 2013 17:45:04 +0800
Message-ID: <CAF1ZMEdzNbVwtxiq0ViOk4pkU7AcgLxA+yfFYp_AzhvxbRFAww@mail.gmail.com>
References: <20130724084903.3884.13354.stgit@perseus.fritz.box>
	<20130724085333.3884.30723.stgit@perseus.fritz.box>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LewjRGR10ijLP4f72YVNN7wU4Vq0Yip07snbobVl7p4=;
        b=wPLgyHX5wjpViWm4ztxnoLIoBPla8LSYUsniXzwpL+BERx7CFyCJxl9pK0lWfEAJWh
         Sy6NC4i83wBEClxDIKorozYxhYMTtvwOYOd1SsS5hHqraGdqY9F5GErjnaXwWAN8CJ7u
         UcpRkTkPhFRWBvUq+RLxu3YJikB/89rD3EiK9B5ftBNqFfLT55LjlIu7OQsUr5CgIzQH
         86zeNojscK5wpQNUX0rfFATjKi1BwaIydQa7BPmAtrUgXiVkS/JCb+Ia1CJFJbhJx7p2
         YMS9yss8xzw+S1RGdk6Ot54kYKIs3aCR2PemgrOD1k9GaAfSkTdTjSs1eQH2Ngo6XtZs
         bngA==
In-Reply-To: <20130724085333.3884.30723.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Wed, Jul 24, 2013 at 4:53 PM, Ian Kent <raven@themaw.net> wrote:
> From: Lan Yixun (dlan) <dennis.yxun@gmail.com>
>
> the logic here is:
>  if user pass compiler variable, then use it, otherwise fallback to default value
>
> this will provide most flexibility, so user can set this variable
> it would be even useful for cross-compile environment.
>
> Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
> ---
>  CHANGELOG        |    1 +
>  Makefile.conf.in |    3 +++
>  Makefile.rules   |    8 ++++----
>  3 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/CHANGELOG b/CHANGELOG
> index 72d9135..ebabf21 100644
> --- a/CHANGELOG
> +++ b/CHANGELOG
> @@ -61,6 +61,7 @@
>  - fix hesiod check error and use correct $(LIBS) setting.
>  - fix dead LDAP symbolic link when LDAP support is disabled.
>  - add missing libtirpc lib to mount_nfs.so when TIRPC enabled.
> +- use compiler determined by configure instead of hard-coded ones.
>
>  25/07/2012 autofs-5.0.7
>  =======================
> diff --git a/Makefile.conf.in b/Makefile.conf.in
> index 3766d45..cb53e66 100644
> --- a/Makefile.conf.in
> +++ b/Makefile.conf.in
> @@ -109,3 +109,6 @@ initdir = @initdir@
>
>  # Location of systemd unit files
>  systemddir = @systemddir@
> +
> +# Use the compiler determined by configure instead of hard-coded ones
> +CC := @CC@
> diff --git a/Makefile.rules b/Makefile.rules
> index 6b5b2bd..9aebd19 100644
> --- a/Makefile.rules
> +++ b/Makefile.rules
> @@ -38,10 +38,10 @@ STRIP     = strip --strip-debug
>  endif
>  endif
>
> -CC        = gcc
> -CXX       = g++
> -CXXFLAGS  = $(CFLAGS)
> -LD        = ld
> +CC        ?= gcc
> +CXX       ?= g++
> +CXXFLAGS  ?= $(CFLAGS)
> +LD        ?= ld
>  SOLDFLAGS = -shared
>
>  CFLAGS += -D_REENTRANT -D_FILE_OFFSET_BITS=64
>

HI Ian:
  Missed the changes for "LDFLAGS"?also need to change from " =" to " ?= "

but it's strange that you seems correct in
[PATCH 6/9] autofs-5.0.7 - remove hard-coded STRIP variable

 LDFLAGS   ?= -g      --> correct
-STRIP     = :
+STRIP     ?= :
 else
 ifdef DONTSTRIP
 CFLAGS    ?= -O2 -g
 LDFLAGS   ?= -g        --> correct
-STRIP     = :
+STRIP     ?= :
 else
 CFLAGS    ?= -O2 -Wall
 LDFLAGS   ?= -s       --> correct
