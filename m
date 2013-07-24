From: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Subject: Re: [PATCH 0/9] Series short description
Date: Wed, 24 Jul 2013 16:34:42 +0800
Message-ID: <CAF1ZMEdmTPuUCP2dR-nxBEP+swm0Mqoxw0ve3rJx-9wn12FRXA@mail.gmail.com>
References: <20130724081610.722.84685.stgit@perseus.fritz.box>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QA11y7oNvyOtWCWFtRXqUbPHV4DA/SVaRCvzs3QUT1M=;
        b=w/P24F8VYjFbAVbVDI42ZEoWwj67cRwdqjQR4ntEsOe6LwNQ38JPgNKgd+VW2fMG8v
         SaWkrudgJzpw2BgY9/hzP22yzr3l0A12MnKqrl0p7wa2LAkzU16I/ZPoT6lomfcrTTlS
         YGH8nZFTHZL82vdsZmoFiJiI5RQyXZwPxc4feNQb+Du2D9tZjyENG0s+B+Ymm5ZKzitS
         5M0dSHNgvqWH7XzX+2zbeXOGcgMLv68IbiDpWpDDUmaGrJ1h20Z7wDTx26ysWsrnwHNK
         BrNBTNpeQpsW2hSyQ2rhQshv9W4/LbGXqnGI6Hz6NcdWSAFimuj0a4VbZzpK8raerPkV
         KXXw==
In-Reply-To: <20130724081610.722.84685.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Wed, Jul 24, 2013 at 4:17 PM, Ian Kent <raven@themaw.net> wrote:
> The following series implements...
>
> ---
>
> Dustin Polke (1):
>       autofs-5.0.7 - fix compilation of lookup_ldap.c without sasl
>
> Ian Kent (1):
>       autofs-5.0.7 - use LIBS for link libraries
>
> Lan Yixun (dlan) (7):
>       autofs-5.0.7 - fix typo forced-shutdown should be force-shutdown
>       autofs-5.0.7 - fix hesiod check error and use correct $(LIBS) setting
>       autofs-5.0.7 - fix dead LDAP symbolic link when LDAP support is disabled
>       autofs-5.0.7 add missing libtirpc lib to mount_nfs.so when TIRPC enabled
>       autofs-5.0.7 - use compiler determined by configure instead of hard-coded ones
>       autofs-5.0.7 - remove hard-coded STRIP variable
>       autofs-5.0.7 - unbundle NOTSTRIP from DEBUG so they wont depend on each other
>
>
>  CHANGELOG             |    4 ++++
>  Makefile.conf.in      |    3 +++
>  Makefile.rules        |   30 +++++++++++++++---------------
>  aclocal.m4            |   12 ++++++------
>  configure             |   20 ++++++++++----------
>  configure.in          |    2 +-
>  daemon/Makefile       |    2 +-
>  include/lookup_ldap.h |    4 ++--
>  lib/Makefile          |    4 ++++
>  modules/Makefile      |   20 ++++++++++++--------
>  modules/lookup_ldap.c |   14 ++++++++++++--
>  11 files changed, 70 insertions(+), 45 deletions(-)
>
> --
> Signature

Hi Ian:
  Thanks.
  But I haven't seen the commits published, am I use the wrong repo url? [1]

Dennis Lan (dlan)


[1] git://git.kernel.org/pub/scm/linux/storage/autofs/autofs.git
