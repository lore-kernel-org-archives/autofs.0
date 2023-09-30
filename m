Return-Path: <autofs-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D654E7734E
	for <autofs@archiver.kernel.org>; Sat, 30 Sep 2023 01:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjI3BeC (ORCPT <rfc822;autofs@archiver.kernel.org>);
        Fri, 29 Sep 2023 21:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjI3BeC (ORCPT
        <rfc822;autofs@vger.kernel.org>); Fri, 29 Sep 2023 21:34:02 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735F5F3
        for <autofs@vger.kernel.org>; Fri, 29 Sep 2023 18:34:00 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 7BCB23200904;
        Fri, 29 Sep 2023 21:33:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 29 Sep 2023 21:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1696037638; x=1696124038; bh=9qKqtCNALmJNysz25qZ7VS6I2Y7XClOkbOX
        /ojoGafo=; b=JsoZPN+eis/IxaPNBmpeGVlDeI9HMzUnbskEcxAbSHneG6fT/Gy
        5iQxHhhjoxp5pXN+CvZOnnQVWPFqWXJnU5t4mhRtkEo9NGKb0XPrBP7EQjJFlvrq
        CJbdYW8WFR3c2oi4wTFLu1DZNe8bfZJZSLvxoTutJfZE+cvmahARNNMjNaKAQrbX
        UQ9T1OoLLiXTPLhGlESb8u9TIoaTywAqPKXmHDco4f+GTWNO3Hhw2SyhDGUL2b5C
        5E7e6nPGCCQ0ZMdXtJFkFOVhSE+6nuRUpoYmwcrRXKHydw93roXUeZ1B70sZkL4x
        f6iZiYXJg1iCEvf83KKuRWutdyvCtxo3Npg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696037638; x=1696124038; bh=9qKqtCNALmJNysz25qZ7VS6I2Y7XClOkbOX
        /ojoGafo=; b=LQ2jg9474V1OppC72yK23rOsjIROsssHQmpHzAYOEXJAzJNOQxh
        MReor7KdpvDEi1bTYgpdCWqgybzHZHmHUb+qBvYSnZXk5kzj3Cy94QBEiHTwjkI3
        8dLk/KQkXT90ywIQsftk41+EIXa582IFv4NhzoyTaCDzEKFf94V6F55vM0Cr6UK6
        tHEYUIke9aK74Ta1lRmytPZr81NJ6HsTw0s1fuN4q7zOOytuetYP3uyL+qpRTEZm
        +S1BbAnF5sciYOrzDxvqiL+jG7mvhPuqHlo+FiLkx0ZoRyb3rNTeAp3hFD2hYDqk
        wbG8npiqdpIJBpVe/YeS6NMC3xsJEFFCWiw==
X-ME-Sender: <xms:BnsXZf-SyRJg85e91mIlbw4Ptu4uEorxnnFFhYY7rx5Ccm0ybYUqKg>
    <xme:BnsXZbvM7ga5XGvU2xLx04sRRpUrCLyzbsmTnNGSz_o-ZeV_UuHxD3l4AyfvLzURu
    sXjyiOiyQRq>
X-ME-Received: <xmr:BnsXZdCFYV1qXgWS4i1JyIBEM8QxbNrVPt9e6nXjnZS3I3J2HPOIVmQ6OCPHJFtsPhsQKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtdehgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    euhfeuieeijeeuveekgfeitdethefguddtleffhfelfeelhfduuedvfefhgefhheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:BnsXZbdFYmGfuukPEkcFhZndHIrKzlOrmJfILUJQVIgdwgqlIdumUw>
    <xmx:BnsXZUPdcfRvAYiDKygPUD2bti0jicTcZIM0wVI5hywDRJcuSv5Aiw>
    <xmx:BnsXZdkD8PWVmsZv9by_M9XfM4vmhfXOBSQRyBSK07yNfZ_eL8SWEw>
    <xmx:BnsXZeWMC0tLV-dxxjbtVW4gdhzao0BdWqFeg160BjsjsWU3GdugWQ>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Sep 2023 21:33:57 -0400 (EDT)
Message-ID: <4e1cfb77-0839-3a57-0c44-c33e49659129@themaw.net>
Date:   Sat, 30 Sep 2023 09:33:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: autofs-5.1.8 - define LDAP_DEPRECATED during LDAP configure check
Content-Language: en-US
To:     Florian Weimer <fweimer@redhat.com>, autofs@vger.kernel.org
Cc:     Arjun Shankar <ashankar@redhat.com>
References: <87v8bt1eph.fsf@oldenburg.str.redhat.com>
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <87v8bt1eph.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <autofs.vger.kernel.org>
X-Mailing-List: autofs@vger.kernel.org

On 29/9/23 18:00, Florian Weimer wrote:
> From: Arjun Shankar <arjun@redhat.com>
>
> This commit defines LDAP_DEPRECATED as 1 during a configure check for
> ldap_parse_page_control.  This is in line with how lookup_ldap.c is
> compiled at build time.  Also tweak the type of ct to avoid an
> -Wint-conversion warning.
>
> The configure script is regenerated with autoconf 2.69.
>
> The regeneration of the configure script also includes changes due to
> commit 69fda4f090e3.  That commit intended to run checks with implicit
> function declaration warnings enabled in order to recognize missing
> libldap functions.  However, the in-tree copy of the configure script
> was not regenerated at that time.
>
> Signed-off-by: Arjun Shankar <arjun@redhat.com>
> Signed-off-by: Florian Weimer <fweimer@redhat.com>
>
> ---
> Resubmitting because apparently this got never merged, also added
> the -Wint-conversion fix.

Umm, ok, I admit I don't remember this.


I'll have a look at it and include it in my next commit.

I need to start working on a release, it's way overdue, so this should

be generally available fairly soon.


Ian

>
>   aclocal.m4 |  5 +++--
>   configure  | 11 +++++++++--
>   2 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/aclocal.m4 b/aclocal.m4
> index 33561aaeb9f5eaa4..1920672d37d25a27 100644
> --- a/aclocal.m4
> +++ b/aclocal.m4
> @@ -368,9 +368,10 @@ af_check_ldap_parse_page_control_save_libs="$LIBS"
>   LIBS="$LIBS -lldap"
>   
>   AC_TRY_LINK(
> -  [ #include <ldap.h> ],
> +  [ #define LDAP_DEPRECATED 1
> +    #include <ldap.h> ],
>     [ LDAP *ld;
> -    ber_int_t ct;
> +    ber_int_t *ct;
>       struct berval *c;
>       int ret;
>       LDAPControl **clp;
> diff --git a/configure b/configure
> index 394a8d55121c12ed..c84ef2a94d1df1b4 100755
> --- a/configure
> +++ b/configure
> @@ -5407,6 +5407,8 @@ $as_echo_n "checking for ldap_create_page_control in -lldap... " >&6; }
>   # save current libs
>   af_check_ldap_create_page_control_save_libs="$LIBS"
>   LIBS="$LIBS -lldap"
> +af_check_ldap_create_page_control_save_cflags="$CFLAGS"
> +CFLAGS="$CFLAGS -Werror=implicit-function-declaration"
>   
>   cat confdefs.h - <<_ACEOF >conftest.$ac_ext
>   /* end confdefs.h.  */
> @@ -5443,6 +5445,7 @@ fi
>   
>   # restore libs
>   LIBS="$af_check_ldap_create_page_control_save_libs"
> +CFLAGS="$af_check_ldap_create_page_control_save_cflags"
>   
>   	{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for ldap_parse_page_control in -lldap" >&5
>   $as_echo_n "checking for ldap_parse_page_control in -lldap... " >&6; }
> @@ -5450,15 +5453,18 @@ $as_echo_n "checking for ldap_parse_page_control in -lldap... " >&6; }
>   # save current libs
>   af_check_ldap_parse_page_control_save_libs="$LIBS"
>   LIBS="$LIBS -lldap"
> +af_check_ldap_parse_page_control_save_cflags="$CFLAGS"
> +CFLAGS="$CFLAGS -Werror=implicit-function-declaration"
>   
>   cat confdefs.h - <<_ACEOF >conftest.$ac_ext
>   /* end confdefs.h.  */
> - #include <ldap.h>
> + #define LDAP_DEPRECATED 1
> +    #include <ldap.h>
>   int
>   main ()
>   {
>    LDAP *ld;
> -    ber_int_t ct;
> +    ber_int_t *ct;
>       struct berval *c;
>       int ret;
>       LDAPControl **clp;
> @@ -5486,6 +5492,7 @@ fi
>   
>   # restore libs
>   LIBS="$af_check_ldap_parse_page_control_save_libs"
> +CFLAGS="$af_check_ldap_parse_page_control_save_cflags"
>   
>   fi
>   
>
> base-commit: ab70c4c070d8e21cd51df93f7a603788aa50dd5f
>
