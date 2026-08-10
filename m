Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB2B3E3145
	for <autofs@vger.kernel.org>; Mon, 10 Aug 2026 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786370714; cv=pass; b=MCN5LKWY9sZm9wADYuYGsds2duxEJpb5+heaxMVUWiMGYkeJf0uFj9B1gbhf0fT5vjc8203DPNZQeRAFIehOoF9xoJRToYBbj510+7S6tpgPUg6LuqDSjOsW+YGP/jg6T51aUEgZIS3odzIx97ybqDy2HasseZM5D/xmfuuLRhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786370714; c=relaxed/simple;
	bh=wQK4iC+iVboZVQ0TbBvuUd5c8pU8uXP8R69wO9Cbm1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0yDhDbJ0vzHZ5sRrtBmU5LVYSgAkzSq2F9+E/4kt0WgI9/bG4JBEcjknEILWC6nHM15Iq6uMdjuEIqdKcVZkwC/DV7vBVClVsllgnkmHQZYFPCo0Jr3O5hZfEJJ/5geXAlhAI6qBv8ppzljRXnhHh8Z3A6H1ppMw4Jux/w4Viw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=myhmKgHT; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="myhmKgHT"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c08df8513so11615491cf.3
        for <autofs@vger.kernel.org>; Mon, 10 Aug 2026 07:05:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786370710; cv=none;
        d=google.com; s=arc-20260327;
        b=boFsp9DWkJhDMZvzacvtWYusTENA+d+juNMH0I0dw1FyTQJb9O3zPEGLyBXAPtiDe5
         IBxmgQY2E2r/zU24Y0VBrq7eudK5/jdVLwl3fZoJPsw9yH/ah6Q3qlk0k+AtS8Go1MEo
         o6Jo5yRrYomPFLJst51G8VS4dXkzhiWrsnfiFlSGr9VezZZoqj4atqPwlLiL+lgosXNK
         bbdjKZFqS9mKaRltKKC0vfjQkzh5hbZc2coraILIZkSNyi3bnFinvHqXz3JiAI8ZD9U2
         re6z1YkY6UoPIb0jEYmbECJBGTIf6iMJ3Us6BluICglxZjtbGjv+f7SD7nwAVvPCyBMD
         9c9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NV+45oOv6d8nxP4iat2b7fdyPFUDUzYrSvuxe5NbF8Q=;
        fh=OwpwEXJWoM6jhtcN1JtXeGddyt2X8a9GCwLaCKbHjdE=;
        b=lM+am8IBr60ffgx/bLY/CGrW45xn4cGiuCmBHGCZ9NrN0K+ZuYEp9lUo/s0yy6GCt9
         LtKiAKJ4/Wy2CNlMTFrc39ckk3ZRNb14iUb/NQTbt7+n1A7sZfP8qQeaYqbRWd4uSI3n
         VFBIImCYV6SHH4vBCK1RYJFLpX7BPUuUbiKhq4kg3h3FLaxwPyD3fSDQmmtQzpfbmLcg
         K0nJZyDmLWqfxVHbXLm1wM/l0Reyh22Tg+5SDOYjNqXzOtZ9NGjPzokZi+ivRrcviTw4
         vOqM5U5RGBh5076RYg3v0/gn70qsBWIWiIM+gNCtTUb5YPBmWLp0VZe3609WZWqxip4c
         Iatg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1786370710; x=1786975510; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NV+45oOv6d8nxP4iat2b7fdyPFUDUzYrSvuxe5NbF8Q=;
        b=myhmKgHTG1hXWp+ZWdXS/rOTTX/n2t2qUF8gwZnkEQrZniSCmin6lDe/80YepezVa6
         121u1I/avdUEU9WLXbOvUTKTDZnRMENu9eDMm34cdrmTSuVA63UMoNjjk1PYE/pAvemd
         YBbtcfpvyQ4CvlD5YmCvZn51m6vllAzMISc9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786370710; x=1786975510;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NV+45oOv6d8nxP4iat2b7fdyPFUDUzYrSvuxe5NbF8Q=;
        b=qIPBIcvmMTLsL3X9P5VkyJg1LhpbvAJsOyLxv4ZnuEHbwHfXDNirVdME45wrhFf7aZ
         ZFh7i9aTcUHyPlHlHzr4Cv8ZGicF3He6ZDctnEcvv2gHDn5k4GYqI+T8GdUsQIB/1OX+
         WnhDYKoRpQUKny0BFSwii8430CnknHUzUQU8Y4MxMJm3tL41sBxKi94AhFlD1OeXEWMD
         D8EHbHbHel9P9Yq39/No5AZjkl/qQXBSiNyxVWpcgeppCWXIo+wCWfYFd0llwmahHbHO
         xiOr8id/oGP++WUqBg1fhpkkXf2GJI4et3kvaa7bbYIX8s74Ha6e42vQmg5rj69FfEDA
         X8IQ==
X-Forwarded-Encrypted: i=1; AHgh+RqSaOO19I0XPhIRUyd8t2VlDm1NR6ojn1CX7ElqokSK+mNHv77XHsrAwnumsnZzXl9kIf13my0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOC0rAVfxETFJSxc4MuO5WzVnyCWOcvzwqHB8IBXHnmkqKnZMR
	UOho2pBfvEgRafXNnez4/SX0s/Z4Gc1cPkfn6pVQKFs8F/02WA6IWM2lREPZ4GF3X8Mjnbg2M5I
	ggxDXQbUDioc/iGDp97g7O23mEAG5JSthbRs3FJjLuw==
X-Gm-Gg: AR+sD11Z6YQC0aA5j7+6sAYuo5Gb/vLXljEHcYcRYVveTUQH9k4y4GEYw5UAGm00BjS
	xgyrjPxQil3ElH65IO9iq+zE8tLDHntDQGXmxHaP80ABaJX67KLFTm1O9GCRw2XUa3BeU8X7P4v
	rNqWGsG9wQhjM39DB9l5m2i4QNKnQy4luxlS7/o4JXbbCUGRdSqJdN/CYGM8jJnPXwUsXlz0PJL
	VbJmBm8zrzr8g/Zwo6vg+Ok7QhZvWKMuitulao/JREyoIudFeeFhDe6V/Cw+uV6I/t/aeZnlkFF
	1Ri5RhVKkAF8QacRWwrX9BbkFaezkdCdBFbLLL4h0CXS6dfQmVDQdVtNPEzJ7ntTIeUq0gDr2y0
	=
X-Received: by 2002:ac8:5cc5:0:b0:51c:207f:6524 with SMTP id
 d75a77b69052e-52d1919e59dmr254953691cf.37.1786370709751; Mon, 10 Aug 2026
 07:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803012648.2195405-1-neilb@ownmail.net> <20260803012648.2195405-3-neilb@ownmail.net>
In-Reply-To: <20260803012648.2195405-3-neilb@ownmail.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 10 Aug 2026 16:04:56 +0200
X-Gm-Features: AUfX_mwOr6H9OqGZCernhbLrr_tuorcVZn-K7EOk-lg62vULXKmdHLNqnvpAUNY
Message-ID: <CAJfpegvTXG_kJHyFB115zdQvbyvDNtfqA_Mv9UKiEf9BE5qXwQ@mail.gmail.com>
Subject: Re: [PATCH v1 02/12] Add and use d_for_each_positive_child family of iterators
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

On Mon, 3 Aug 2026 at 03:38, NeilBrown <neilb@ownmail.net> wrote:

> coda_flag_children() doesn't need rcu_read_lock() as holding any
> spinlock prevents an RCU critical section from finishing.

I think prep changes should go in separate patches.

The conversion should be an equivalent transformation.

> nfs_clear_verifier_directory() is changed slightly so the parent lock is
> dropped and retaken between clearing the verifier on the parent and on
> all the children.  I think this is safe.

This can also be a prep patch.

> get_next_postive_dentry() in autofs now holds the parent lock a bit
> less.  The only non-trivial code that is no locked any more is
>    parent = p->d_parent
> This cannot need the lock as autofs doesn't support rename and
> a ref is held on a descendent of parent, so ->d_parent cannot
> change.  And if it could, the lock wouldn't help.

And this too.

> diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
> index 5c2d459e1e48..7b0a22629415 100644
> --- a/fs/autofs/expire.c
> +++ b/fs/autofs/expire.c
> @@ -70,12 +70,9 @@ static int autofs_mount_busy(struct vfsmount *mnt,
>         return status;
>  }
>
> -/* p->d_lock held */
>  static struct dentry *positive_after(struct dentry *p, struct dentry *child)

Move this primitive to libfs.c?

> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2182,14 +2182,10 @@ static bool drop_negative_children(struct dentry *dentry)
>         if (!d_is_dir(dentry))
>                 goto out;
>
> -       spin_lock(&dentry->d_lock);
> -       hlist_for_each_entry(child, &dentry->d_children, d_sib) {
> -               if (d_really_is_positive(child)) {
> -                       all_negative = false;
> -                       break;
> -               }
> +       d_for_each_positive_child(child, dentry) {
> +               all_negative = false;
> +               break;
>         }
> -       spin_unlock(&dentry->d_lock);

simple_empty()?

Thanks,
Miklos
