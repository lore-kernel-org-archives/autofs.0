Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FBF3F660F
	for <autofs@vger.kernel.org>; Mon, 10 Aug 2026 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786372647; cv=pass; b=gOtnCCTuUNYhEbNTEtwPlsBp5CYXNMP0158Uw+EPb9eiFpV0vJfBlkWVDTwCUIACMaZQ5UPxWHy4HEvr8ICvWVB9yGwTcP9cYe7L6FhrTJrhqHsTPJ3+ZDP5sYwFp7xikySB+v1CdE42WcMJUbSJovKd34fxbztOLfbgKVu0TsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786372647; c=relaxed/simple;
	bh=1TOh47GuX2DYZgrLBuHx9ZqIJlL5qlbKX0nFvU4QG8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/XYqpreRUN89ktFZMScO17pLVh7rqAGIUB4h/Ja35iDJGiWrVx0yIHflgi331R2mA0kMxlFWLZKIPH+KGKtJQpWMNWfYmll9dMRDr7Sh+hEAdw9gJvmOPX8uSYspNlmKxMwT+XVIxW3rOFRSMvaJPCz7F3WM1Qn84OHEno4EsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=BnjWOSSE; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="BnjWOSSE"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8ff88549786so16968236d6.3
        for <autofs@vger.kernel.org>; Mon, 10 Aug 2026 07:37:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786372644; cv=none;
        d=google.com; s=arc-20260327;
        b=rCs/jM0Lc4R7TNTzMx7QI7xfpVSNCWGgQDSuzaZbxzhMYPxXZTiIXaO7oFSFcPit3o
         KM2sjfstDXX0nn4yaoWarejXibtQOia8XVUQwfJC0Czxfdfzd5wJH2xJqblRCCATac23
         sP7lYzIo26YQpin7A3NrDq8NnK4nMIk0CrkZSaVBFI1kQ9qMUKqALi5RRLzq9kObqkHW
         rEk2i7NNfMAcjqpaAmhq5fIe4iMFW60Ty6BSwk5jXS2QaPMLk7IzC4ziR8CJ0WoRw+SM
         4/bFmf+qd9RAd1WM4bmxXKJfdIxfmKm45nZThHQLjfUGr8n18EnUcffGFfOnkEClQz5d
         HgXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=N9K6RvXQXpCBgnaYxLabarFuImKKDVr9pRNexvL1dnw=;
        fh=94SgFuhrTuHCYRoVk9K59qzBSMjrQ/czhfr0U9CPn7Y=;
        b=IYa8ErIAYzh3HFRl/OzkNUNLDX0pk1qeBipTV0qgQ3DFRK42cXZhG0+qz9kbJqJ3sk
         LojmLw1EWzIi5XilzGAQjwa8htewAtsZkdxRlq45okItMciJngi3pd+FThL267leoGf7
         ws/dY4KCg1efUqL0rt+LQXQuHJhJEaqUfS8dU48rUA08FWcPP830qGZ26psuuoVlno9W
         rSkqkHw/qK/T7BuTgjSTYuBqs2UkETBKCMOobvEDCfGzu/NqorK3bsVewmMrmXql0Sda
         1w2h0mLCeNUbfH3X8Sczjdkx05I9ucAxYya29HFyK9gEzNcs/m+6BYbPLYNRoSJ3rQ+q
         hw3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1786372644; x=1786977444; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N9K6RvXQXpCBgnaYxLabarFuImKKDVr9pRNexvL1dnw=;
        b=BnjWOSSEvEzWJR5J14cWubjkTZghiLwSDr8kJW4rvp0BwKy+nI2ukNW8e93CAslQWz
         oCQhP/5/uCvPqx210NpA5dAr7YKD1Po/1H7JGoWx0owTdLfkUjN6DLKhHhLpSAH2I+iI
         vgQcsTPjEjbabHAo6lj8yF/WExkf+DhpOI64s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786372644; x=1786977444;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N9K6RvXQXpCBgnaYxLabarFuImKKDVr9pRNexvL1dnw=;
        b=i49HuQPVADDrHhWIoGHWBePyIZxIoCfo2NENlK8XuqAokuKxS+VpXIGZobq5a5Tofj
         kxIWYcsrpzE7+E94iA/zP2fk2ZhTkCyNBpnqQf1Ui0yjDC9zfRiVjN1x6WoBy49XYu1Q
         mtvvC9WP1IT8pISrD2bB2hB1w8DVAroWB1z8YAby7qot6uwi+FqleMzlsO+/+BwMA+rS
         RL9WA+c7s1pxLCTIqnpTXFQfUJs57v2UXDjX73EGiNomtYy9S80LjT+ybccL4kXK6X97
         fiCW2MWrxxiMgEsI6Ncks+HnNm0hGUwo8qguBtpS26EXMl37IK8WYOOVeW7qclC/+c9P
         kUGg==
X-Forwarded-Encrypted: i=1; AHgh+Rr/+DbVratnaY2h6CXIMP+fxQAK/u0Y1C50NSIg8sD4NSxVKmVKPBaVrnAKfzlck01MQBiJc24=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrEAUI5UPm97f0jUYndBZl8l/OTzPfkVHfc7FK1rtK+veVkwv2
	UwFzZbnbab+E1wcLgbronDoIDGWxYVE09XT8+SbmQSbqybel+alz+FFg9xBzBe+jRV1km+5LgmF
	/bMZAaAs/Xw5FFqS2t7bT9wVCV1y0D4iUvizKNQE43w==
X-Gm-Gg: AR+sD12Ghxhk7RltJpPKKMgPBB1BuDny0pXbSp0yXpIOO9RgPgGccCEw4eesYpyzy4R
	HmqfQ5gDXGCH2+gE3hsvnGIx26D7E6YETFaUkFGbI/2+iLv8CP95A2rzR+W+JOb5fbiUsyPAqiW
	cF690S9XAj+UV4QSWcebT8K8W++p2lomlJlO1JEwHw05cFT4IY1TIkSyid3BtUAC0n3f2EWtFl7
	82jcI2q52gYmT1/FRKBTJZ74LfPYGykZzpa/A9APasUOPrcQMoeMIP0gGBqJf1WUSRlLhNt87P4
	TLpFPiaukDXr5Y2Jltev1w8uAOTMEdm9KJkAGktx7Jqwjr41ZfYMhm46AB4wub09fAC9T6D8J2X
	Xl/JOCTmavg==
X-Received: by 2002:a05:6214:20ef:b0:8ee:f531:4de4 with SMTP id
 6a1803df08f44-90a5dfa37c0mr27777156d6.13.1786372644393; Mon, 10 Aug 2026
 07:37:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803012648.2195405-1-neilb@ownmail.net> <20260803012648.2195405-5-neilb@ownmail.net>
In-Reply-To: <20260803012648.2195405-5-neilb@ownmail.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 10 Aug 2026 16:37:13 +0200
X-Gm-Features: AUfX_mwDV5L6hLfp08WK2RA4_U7t0g-kBuPpgpA2dBgLwUCWyqeJ369EboEHc-4
Message-ID: <CAJfpegv2TTEGgfFBvAB1j2ixyEMXruG0AhL=R9iMC-LMJToiAg@mail.gmail.com>
Subject: Re: [PATCH v1 04/12] fsnotify: reduce i_lock hold time in fsnotify_set_children_dentry_flags()
To: NeilBrown <neil@brown.name>
Cc: Ian Kent <raven@themaw.net>, Chuck Lever <cel@kernel.org>, Jake Edge <jake@lwn.net>, 
	Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, autofs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Aug 2026 at 03:39, NeilBrown <neilb@ownmail.net> wrote:

> +       /* Find the dentry for inode - there can only be one */
> +       for_each_alias(alias, inode)
> +               break;
> +       dget(alias);

This is __d_find_dir_alias().

Could add a get_dir_alias() primitive that does the i_lock locking as well?

Thanks,
Miklos
