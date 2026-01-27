Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA14F1F5858;
	Tue, 27 Jan 2026 02:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769480055; cv=none; b=Rhf3gR3NtriQdW7d3BjqHEhANlBGIDLJkPMgw3dk0ZL0eLs0HOHejlkujYpJLs7KTfeldoVft0sTXhAtAc+uAFI4neDqNSDkfxJFpWuQY1YdMQbKBhqeDohrKu1OTJIGPuctPjb+KNSsLJqevUQ1LRl8qsBGPE+emBZ0PV8CG+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769480055; c=relaxed/simple;
	bh=LF3fmEg5BBne0cAMjnLD6ahAoMcmw67gqegQmf1RSYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gM5Dy54Ag3tfsTmNe3lQcIRDhBXPXtf9mWTIY8sK9/LJkbb8QZUTb5tV/8Z09pX4IyNV/bbblvX4IGtV5ZxhrZhzuyqYLSmoSctiljPe7mj6IvlmmzT2UwYrcgrxf9UodciOO8Yz1nmQwrgHeSVSJzw00bKZFxcqWx++lqzuVnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=Y7X1Vcis; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ejTvo/9C; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="Y7X1Vcis";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ejTvo/9C"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id C14CCEC048D;
	Mon, 26 Jan 2026 21:14:11 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 26 Jan 2026 21:14:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1769480051;
	 x=1769566451; bh=UOzj83Jj9IXn4r/XzO2jdyAKfk4sGLEWvTN77eUd4Xg=; b=
	Y7X1VcisVbr/GP+fZ1p0zjNpNA7GHry+S2Zi8OJwK4hgIFK5xYOXAEY1S7IqzAeM
	4J47OM+gHpuCInqoX+VWCRobHDyKSACthfAXOg7TyQmCiCIQDcWkuRleYcJxtT/H
	zetoZ1CuKODroKwlzogMGB8N9U3ocC5iE3BED2R4OwSuasIu9YlffDUJzvjO8eXK
	8t31Ygf4vXGJoO75oWJijqV2qsZtCg/WoqmQ9FzgN/HVn4UmzhnR6R9FE43vOivK
	AEkGxOTAXXv1xsVbi+pRs+S0qBKi9PL0uJEuTWYC+zoxRD82uFth+R6fC4p6UVMk
	2hnIiywyN5knJfyCZ8j5mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769480051; x=
	1769566451; bh=UOzj83Jj9IXn4r/XzO2jdyAKfk4sGLEWvTN77eUd4Xg=; b=e
	jTvo/9Cyv1wDDMAGE/oADoo1JS3liqIULLGZearTyDNEIDJNYi6LpcJwRzPKFtEI
	VdH/7NS0UCIU29eTYtTxmxaW4NilEdkmjreMC4A7CG/PIKvCovDulbKWafds+nmE
	cq6SiXbTNMQmvjhDU9yIRAD4uVn0n68IULvtIAFRpEk1GilwDIsrrUpwvwJegTla
	3nWcH2I3QvaeALcnz4dKdGVJ2jDANW5mrCCxPCpafpu0eNk9srcy01XpDIZZRKp9
	5xjNBGhSQMW/ntyTBeIvW/M1UFKwU3qTtzZe0F2oaetEIy665zYfOWa8wqmwXeOA
	fmzox9z8VV/AG2LWloPpg==
X-ME-Sender: <xms:cx94aYSlYyQ1CpRpSzSGYsa2gpyZ-c0oWSWfQ9aHsAvwCmfVAPTp-A>
    <xme:cx94aTkf8uteEwXRsT90pxrYBOid_cF3TuBN2EstUEYuBBA-OOjS3ukJYU5LS3RMQ
    qw-8ZNCOeNFKJ1GpEm1ynyl0DWr0ufBDMKI1sHt9wUaISbC>
X-ME-Received: <xmr:cx94aQS38eEeB66LLUzXpHIkCXimaARYNSRPojYTQl1098-mfmfbA2QdJAvEHDgEbqQU4nfKSejEECXvxFtuaBB7npvgwCybN1IcRGwMdf-Wgk7vTZjMOu0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheelfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepie
    fggfevffdvjedttedutdefheehgfejieduueffveelueeffeeuffduffdvkeevnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvthdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhhohhrshhtvghnrd
    gslhhumheslhhinhhugidruggvvhdprhgtphhtthhopegruhhtohhfshesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:cx94aZPSntxJF0KWE12fr0ILcEjb1D2x6b603lLKrOhOpUD1PPWIZA>
    <xmx:cx94aRXOPsK74Kn1aXg8nvKilC9iS6wRHck0fcppiLS61KjDCt4nXw>
    <xmx:cx94aYeDbW501cxZHgIfqraEHaRbTpOi9hz46EP17lrM0FhGSleFlw>
    <xmx:cx94aVvdUl4GcbmcLGJuiQT0bi4uM2mWbaD49ogO8K1VKFbZ4YZq0g>
    <xmx:cx94aTn8dmIqzn9LXcG7KY0d5pwX_rjIAVTzwwz310YYocREbNKTWh0t>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 21:14:09 -0500 (EST)
Message-ID: <6b4c95df-1005-4f8d-a350-c4bf3769228c@themaw.net>
Date: Tue, 27 Jan 2026 10:14:04 +0800
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] autofs: replace manual symlink buffer allocation
 in autofs_dir_symlink
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>
References: <20260127013639.433302-1-thorsten.blum@linux.dev>
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <20260127013639.433302-1-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/1/26 09:36, Thorsten Blum wrote:
> The symlink name was previously duplicated using an explicit kmalloc()
> followed by strcpy(), which is deprecated [1]. Replace this open-coded
> string duplication with kstrdup(), which allocates and copies the
> symlink name with a single helper function.
>
> Remove the local variable 'size' and set 'i_size' directly using
> strlen(cp), which is equivalent to the previous value of 'size'.
>
> This simplifies the code, uses common string-handling helpers, and
> removes the deprecated use of strcpy().
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   fs/autofs/root.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/fs/autofs/root.c b/fs/autofs/root.c
> index 2c31002b314a..186e960f1e23 100644
> --- a/fs/autofs/root.c
> +++ b/fs/autofs/root.c
> @@ -7,6 +7,7 @@
>   
>   #include <linux/capability.h>
>   #include <linux/compat.h>
> +#include <linux/string.h>
>   
>   #include "autofs_i.h"
>   
> @@ -578,7 +579,6 @@ static int autofs_dir_symlink(struct mnt_idmap *idmap,
>   	struct autofs_info *ino = autofs_dentry_ino(dentry);
>   	struct autofs_info *p_ino;
>   	struct inode *inode;
> -	size_t size = strlen(symname);
>   	char *cp;
>   
>   	pr_debug("%s <- %pd\n", symname, dentry);
> @@ -589,19 +589,17 @@ static int autofs_dir_symlink(struct mnt_idmap *idmap,
>   
>   	autofs_del_active(dentry);
>   
> -	cp = kmalloc(size + 1, GFP_KERNEL);
> +	cp = kstrdup(symname, GFP_KERNEL);
>   	if (!cp)
>   		return -ENOMEM;
>   
> -	strcpy(cp, symname);
> -
>   	inode = autofs_get_inode(dir->i_sb, S_IFLNK | 0555);
>   	if (!inode) {
>   		kfree(cp);
>   		return -ENOMEM;
>   	}
>   	inode->i_private = cp;
> -	inode->i_size = size;
> +	inode->i_size = strlen(cp);
>   
>   	d_make_persistent(dentry, inode);
>   	p_ino = autofs_dentry_ino(dentry->d_parent);

Looks fine to me.

Acked by: Ian Kent <raven@themaw.net>

Christian, is there anything else I need to do for this?


Ian

