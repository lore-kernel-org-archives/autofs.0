Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D926409623
	for <autofs@vger.kernel.org>; Mon, 10 Aug 2026 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786372098; cv=pass; b=hsOJhVmf+lyY6iFuW0eXniVeq3yRCVnGO1jtx0pVNBe80mOH7f1jmF26zn4hOYUbH12xDPICqj5lWHDW3wbF30zBK0KZ575zhhQIVPW4dtEX78FZJXwME3LUPiEUay8hLFygklt1VQIMKWMBPcsi5cFYv7/RUtYsZm/Fcua3CJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786372098; c=relaxed/simple;
	bh=pnDzUOaejzbZKnGiFAwhq774ZLfxQebZ6F3KHCN/tGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0vOJn0dJgz955aHs8MM608KcSb5a/5nvWCR5Wa6wHXKm6qGAQw54LkMJdZOrTcg9WWuALMgucWCLxhUtjb+z9wqkl37aV/Uyf8iaaXkhdFw12NB3pzO01CJ11dahSPAMrqt4bfhBXKw3pC8lS9P0uvhoxmWHzkxSqw6qgD7bbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=eYi5XFBL; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="eYi5XFBL"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-52b6543169fso12245831cf.2
        for <autofs@vger.kernel.org>; Mon, 10 Aug 2026 07:28:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786372094; cv=none;
        d=google.com; s=arc-20260327;
        b=jLBYKCHkD3gu93UIiHtVQDX9irypjoKKIC33JYbqFQ34kzHblWD+nVbom0cy+K56o1
         sTtimal3jj/6DET80mt4xCcW7RQD7Oeh4z9KZ4rLa/CuC1mLEsaX46tXD/Ea9+oefiH/
         /41SN93q/I5MMA+g1RZZBrspFDLYjHpbTXlCDGXycjHDfydQlX2/Kh1j64VTTcsvV6B4
         K2yAz8Dho4ekDe/pIfIll2ihaOPoJHVi4BE88mXNusNBgEvVvmpSQLyJZcQOnuJXJnlf
         vzyceB/SRoQrYlVtIa7L28aHeWiMdb7ExuzmO06iqdRsR6mKo55sKsjwY3fvb4WAjT0i
         M4MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HfZtRdoG1wYrWSHQiZIrbu1I5YDILrACp6t1fSS5v/s=;
        fh=w8E86BxNNAiDBOMYY3NGCQn4Ka5xBAbv8N0lbX3xyr4=;
        b=esMkJRdc6SSNdkVMkcZ8WgxYDZXg1RCm92cyO0ln2O1c6AI3d5lYT11veVCTJd6hOl
         t/T1bpeeomUVFYQA9aNCGtLJdTlNY3cqXEOqRGSxYPtka3q8GEfgekwtUDQNBmbk8m+5
         9sy8mIps3zuEqhZLNrk5V0KSIcdEzjZJFufovioaVzP5INelKI50lxPCN+kiWY2N+SKD
         1egAViw6xseK58zdvjG8y3IFCi4oQL41KCAzqIO3lgfYTkCk+l/TiFAXoXAZexgfgk/P
         EXEqL6wbevCWF34qC7N9m9JGCpnAIKf/bNG1opaPIqWe/9h0FWHPx65pWgQSWhw6VH3l
         SGXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1786372094; x=1786976894; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HfZtRdoG1wYrWSHQiZIrbu1I5YDILrACp6t1fSS5v/s=;
        b=eYi5XFBL4lOLQZHq370I9VsIpsf0Hgt0nVSXeSEb+mmlrKHaJI4QsZSEEiTfiAJQOI
         BtwL1guQfj4kSPT3K1/+8ZmOHuVonXv7JrNDZggKxBZHRcaY43DswgZKTCHAkwJm+/CR
         LPGeYPx1WltgV1D0yMRC7WESmzvvQ0ZMDGIic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786372094; x=1786976894;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HfZtRdoG1wYrWSHQiZIrbu1I5YDILrACp6t1fSS5v/s=;
        b=Dg47DXhD5phBhFHPWGZRBxjmBKeXrowYoGivAm+mThb4EmrYaPI1IQqJWpFiN8rR0O
         RlCw8Qewst1uyxaUExKX9dwKZvckpOZvXJl1y0VuoKExKHWQhuYYMSrUDdZVJZb5VZjG
         HfJ8MFEY1gj6H8E/nl7HeaybbVNfii9ksc8rOH8fT9ZeZI+hvKYo4KKfMxWK/OaN/YCU
         GBzYo4FXYk5QCILbfMDnqjvy1u3M7/MR6c4mxnw2mU9XA59UarfYVkbnumPPA1oIhRUs
         +HByirSlU1ew/HMEgUpkHwo+mIPVpYSHOvx663qI46W4Xk5BPDUwpDCwKfN/1FKXdwPN
         u5Ag==
X-Forwarded-Encrypted: i=1; AHgh+RrhXgPkipFttEMsVZpaC7N41FlH/TdyDCxurYyq01FAy5mAUStrJVnJhbo0OVGBcITVnBOAaJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEs2gbCdCfe5/H7L1bZGIG7GuqbeFq77h0Lvy1jdAsXhfeZQzq
	4zszagCMxYVg52LW/qqIZLzMgYauqidt0q5oCiwvhlrKUiI4jePhS+XOU5G8Q2NrYccFPTmRAWq
	QYbqF0LWp/1Vkpe8qpG48EIw+4o6TbIY4vlCnzOfrAw==
X-Gm-Gg: AR+sD115mB1Suz0XQnY7WbIAO+ZEB2NfSlM60mu+ChN5c+CcoUQdsY+QZwTmhDCuNOJ
	MT1IToOz8cuubgFIhoLI6EtQyE67tlVRqm9W0NcZsdC60PfRsyUj7ac9+dcfEkgddQCr+0EwwPj
	Nd83mXxMItVj3BtaS63gkPWeeZ7Nt9Z70PgNXjMnoWzfW7Le81xxo303rHoqWxYzGXU8n1alLO5
	cY5btF90A0T5JZIsDQ8BLhFYB2ZUo14SaWmHK2my2eSGxcsFDyekzaVGbmCcDS2c0RcCOvwcz4t
	CIWkD0Ty64rz7pVygU8v6VEQtHWAOqU/2gW2rbYR4ncOfnWqfKnLOJZWMW+ApBD9fljKc9xpcT8
	=
X-Received: by 2002:a05:622a:64e:b0:528:583:a6c6 with SMTP id
 d75a77b69052e-52d18e1b942mr222143421cf.6.1786372093929; Mon, 10 Aug 2026
 07:28:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803012648.2195405-1-neilb@ownmail.net> <20260803012648.2195405-4-neilb@ownmail.net>
In-Reply-To: <20260803012648.2195405-4-neilb@ownmail.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 10 Aug 2026 16:28:01 +0200
X-Gm-Features: AUfX_myUlEzBYTf-8rEmM-ECZTiH7eaZjHfGryDDDQcizrarEk4s5RrECFPlIkk
Message-ID: <CAJfpegs-k3skRGiwZvQLzD7OrAK4KL8zwmpmJKyjRHSQ-rqX+Q@mail.gmail.com>
Subject: Re: [PATCH v1 03/12] fsnotify: don't hold a spin_lock across
 fsnotify_recalc_mask() calls.
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

> @@ -116,11 +117,15 @@ static int dnotify_handle_event(struct fsnotify_mark *inode_mark, u32 mask,
>                 else {
>                         *prev = dn->dn_next;
>                         kmem_cache_free(dnotify_struct_cache, dn);
> -                       dnotify_recalc_inode_mask(inode_mark);
> +                       need_recalc = true;
>                 }
>         }
>
> +       if (need_recalc)
> +               need_recalc = dnotify_recalc_inode_mask(inode_mark);
>         spin_unlock(&inode_mark->lock);
> +       if (need_recalc)
> +               fsnotify_recalc_mask(inode_mark->connector);

Is the fsnotify_group_lock() held in this case?   I don't see it.

Thanks,
Miklos
