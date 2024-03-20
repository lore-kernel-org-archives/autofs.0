Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB971DA3A
	for <autofs@vger.kernel.org>; Wed, 20 Mar 2024 07:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710921102; cv=none; b=rZfRD3/EYX8PqFk739v5TPd+SpjozmW0Q4CcgsKAdT8NSbU4sfur1ClFRKNhSGRMcm/pEbK3gymYE1uLsVQtNfv3aRbn+oSPE2HnytL4hrBZO9V+xEgV7nvqARoBmm1GPaPvG+V+eZQ9VExiJ/yPszOD5KrIx/axyDgUMn87zaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710921102; c=relaxed/simple;
	bh=hxHISuVcSSgUqHXujv9XidxaJ8sDOSud8vK1ce+XPo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=h4y8dK6wl0uNbFjPIodO9Nr30RnumgEplkCeHCnHQiDduX9PZ1R7hoSa1CGKjPYZ81W1eKlHsqY06956RAmkU29tTVveswSq88XV4Y+htpTXXrjvblNJmobswUVP5K3UlKUkF/RQPkv8Sww75MvdSDA5PY0x22/o9VpauwMFNlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.178.112] (p57b378ee.dip0.t-ipconnect.de [87.179.120.238])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B609061E5FE01;
	Wed, 20 Mar 2024 08:51:31 +0100 (CET)
Message-ID: <fe523469-beb4-493e-b88a-af7242f27714@molgen.mpg.de>
Date: Wed, 20 Mar 2024 08:51:30 +0100
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] autofs-5.1.9 - fix ldap_parse_page_control() check
To: David Disseldorp <ddiss@suse.de>
References: <20240320005949.2661-1-ddiss@suse.de>
Content-Language: en-US
Cc: autofs@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240320005949.2661-1-ddiss@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear David,


Thank you for your patch.

Am 20.03.24 um 01:59 schrieb David Disseldorp:
> The final @cookie parameter should be a struct berval ** type. The
> check currently fails when -Werror=incompatible-pointer-types is set:
> 
> conftest.c: In function 'main':
> conftest.c:54:47: error: passing argument 4 of 'ldap_parse_page_control'
> from incompatible pointer type [-Werror=incompatible-pointer-types]
>     54 |       ret = ldap_parse_page_control(ld,clp,ct,c);
>        |                                               ^
>        |                                               |
>        |                                               struct berval *
> In file included from /usr/include/lber_types.h:24,
>                   from /usr/include/lber.h:29,
>                   from /usr/include/ldap.h:30,
>                   from conftest.c:45:
> /usr/include/ldap.h:2155:25: note: expected 'struct berval **' but
> argument is of type 'struct berval *'
>   2155 | ldap_parse_page_control LDAP_P((

I wouldn’t wrap the lines of the pasted parts, and use a more specific 
commit message summary instead of just *fix … check*. Maybe:

     ldap_parse_page_control(): Use correct type for @cookie

> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>   aclocal.m4 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/aclocal.m4 b/aclocal.m4
> index 1046d72..fa18eb1 100644
> --- a/aclocal.m4
> +++ b/aclocal.m4
> @@ -424,7 +424,7 @@ AC_LINK_IFELSE(
>         #include <ldap.h> ]],
>      [[ LDAP *ld;
>         ber_int_t *ct;
> -      struct berval *c;
> +      struct berval **c;
>         int ret;
>         LDAPControl **clp;
>         ret = ldap_parse_page_control(ld,clp,ct,c); ]])],

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
