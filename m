Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83BD13AC0
	for <autofs@vger.kernel.org>; Wed, 20 Mar 2024 03:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710906209; cv=none; b=g2wVO6rlAriu6ZEYP5aAW/wtUF0DI6rzW82x78hFrkn5tLWsn1sAY5CaAQz4kJJSatDJ/vCTOvqs0UVtEq4nmwYrFjBXkrcPZg+jPdWqAlyrlcRdWNc8tHher7zrUwLrzi6KcMrID89H0tT4rZCj40vxPiMaEPVjPukE6EL5JAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710906209; c=relaxed/simple;
	bh=asHXdRlv//kgp9ZCc66d7tmRiRuQCNJQ2eRh8U7P0S8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DhnI6qdyYrr2MfLI6TnfUTSzxBqq4zX3qpWYEG06wK14aGAaB7VgM9rTnATVVCGk8J9mD5V8zVs8CF5BGjWdFL05FCUnfmKnorFP5/4yitKkf4+07wtc3LXrsLscbPATdN/bGqjHnA1DR+SeJEcjE3PPPvSilaxTqWTNK3DunJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=none smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=0xSXBXfd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ETkjin0Y; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="0xSXBXfd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ETkjin0Y"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 94BA732002E2;
	Tue, 19 Mar 2024 23:43:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 19 Mar 2024 23:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1710906205;
	 x=1710992605; bh=B5/Vs4bwthmejiCBL6vPTBYPjQIr5dRayyqbR1HHejo=; b=
	0xSXBXfdl6mg1mLxDWYlrlSBMEYQonVY7gnrIqbYvoewPb6kTB5l7Znc1zcT523C
	qumi2zv65dxLgyDm/DDN77CTQ/OdgQw0+DpYnOY/SfcQjfvJvucPj+mIWbJKGuIv
	lMzm3Njs+O0QEoBAytQeGtY50iAmolwHL5+qJoms90kyB+C2lSGeAi/USrV9+zIg
	/Xs0TQij+QOunfObjlsGtuVgBmAyQn60QuswcnRrAunGx5pGSBQuoUZFYAeIQad6
	RSrQ6rh+FaEs8LwV9Zl6rkRXz5S7zwl04Dp8pMKBTak46VDwVszwFX7Wbql6tQyE
	OXRVfWJhrpRiYqvaV2ih+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1710906205; x=
	1710992605; bh=B5/Vs4bwthmejiCBL6vPTBYPjQIr5dRayyqbR1HHejo=; b=E
	Tkjin0Y5W83wrSDMusLhMFsOsjCYMBJ26ujHCXeveIF1svOfWSJiAvIKfNTX288V
	7nJdd3ca2tAvcnLWPYMqekdLT81urKEwozN2UhGAOgF5S/gL24mFjpd2KiyZ1JOT
	sJMeU0l8Ftc+YJ18T29nHgTpamJD7Vtb806pSjk/XSaxNKTToHJxGJc59bZF34Tr
	HTHbjM2GL0IfI8QKOFzJqIPrq3vHSLXE233SzKcNYCYsWgJPfmFYUHhXznfJGFUJ
	Y5YqjM77EDOsI89pTqtuyqRIvbvRuYi80pUychZBA6ZvAcIEawQXXiAp39ntPwX6
	crkCc11KXeoILcOMnL6Fw==
X-ME-Sender: <xms:XFv6ZQN-0e1aly2BJ_9wZwPyVslQR78I-RM5qgzzJvdHOws053vGBw>
    <xme:XFv6ZW91I4ax-iyAz6vQ0MdMLrqz0twpVjIy6nff4b_yCvoR1r_MtLIV4QcxMQ8CJ
    lyFeJa4i57D>
X-ME-Received: <xmr:XFv6ZXQST3SuRPtK8BCRQmDWh_vAChvD9ykdlqZqjxdbo-HPa9nzccgdJue_AEf4feO-bKPiqrzcjyxCu1vQ-Ti6jOKxjsMlDnlPF37-Bv26ZkMOeghoXZjd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleefgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepje
    euueetffeugeejheekteeiudefhedvheetjedtjeetleelheekgfeffeeutdfgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesth
    hhvghmrgifrdhnvght
X-ME-Proxy: <xmx:XFv6ZYt_EnBZh5TDJ5iv_s9ii3g0hNjVcMcJbZLVjCDUt58YhXctrw>
    <xmx:XFv6ZYf03rCyVLgAtnAKA-W0XsMnn3axSVr_jbFw1OTywEbdDyJ1FA>
    <xmx:XFv6Zc0D-p17M0p8JUCwIVvuwa-iTHEsIwcMlVsRJmH8XMcKcq1eNQ>
    <xmx:XFv6Zc9dd5xLvOzfJtQnB41fYzCab4cNL1apMxlEAayizxhAMJ3QMw>
    <xmx:XVv6ZUHRB8_DzmM4W6wpbfWzsbCADskYaLlzvq5dRrR1GUf7SlDfXQ>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Mar 2024 23:43:23 -0400 (EDT)
Message-ID: <02526a0f-5f6c-43e1-9a3b-15d7f0a72e18@themaw.net>
Date: Wed, 20 Mar 2024 11:43:19 +0800
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] autofs-5.1.9 - fix ldap_parse_page_control() check
Content-Language: en-US
To: David Disseldorp <ddiss@suse.de>, autofs@vger.kernel.org
References: <20240320005949.2661-1-ddiss@suse.de>
From: Ian Kent <raven@themaw.net>
In-Reply-To: <20240320005949.2661-1-ddiss@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/3/24 08:59, David Disseldorp wrote:
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
>
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


Thanks David, looks ok to me, will have a closer look and (I expect) 
will apply it.


Ian

