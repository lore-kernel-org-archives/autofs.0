Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0E444160C
	for <autofs@vger.kernel.org>; Tue, 11 Aug 2026 12:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450476; cv=pass; b=I7hz6ZPSjQDq7YRVepKwkf/weX5drD+OKWKml7YHg+JJiiDkILzMI57Gp0vKEjXMKRfPn1S7i2qJff93tjWlyqoYLuIyiQ5/u3qprRmWOhTejXGUi0PRVGdEfG1Qnywhjlf/wBocLLXgXr3ijpKMCt5nUBXjx3/q7iSC30rsAqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450476; c=relaxed/simple;
	bh=uKswzyf3oANr0x5zb0bJBPrPAkNK77rK/33VzGVtg1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTB0XQltlm2V69SBshH54dPWc2Kvu4p7ryju7VMp4kEO2cAl5JUymPksY0ZBsEdAMgwY84G708nouMCf5kNL7at2cW4NtdR8DiqDYjUhcRan8gL3WRbRq7D7ypDt9oTC+0S5bbpaYiDkFGpUiUsvLtvqRQCBX4mRw9TZUiO4Whs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=LYhhybqo; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LYhhybqo"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c0c45c580so4403931cf.0
        for <autofs@vger.kernel.org>; Tue, 11 Aug 2026 05:14:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786450473; cv=none;
        d=google.com; s=arc-20260327;
        b=jcLAUsH4eWa8BvIggALlLWn2J6CoW6EZDNAmubNRIKbybmDxajruySHyjtQh/zg5th
         hf0V7hLUrwM020EFOYg1O1yyb4qgZCANbRXoPMa+XsQtxbeo2/mWSehXM5fbytOneXPO
         8cnA/Ekrfmuk8eI9KE49hxFaAGVpLZDXTZsA7QebvPUjMAF6HiNyIuzdX3Kc4YAvRMWK
         GJPkHUNfmuOrzlJH3GE1f2g49VlZIrOF9YJ3QfuiNC5H7r06AJugGKeqDhMhWGwU+1IU
         RP1wxbOaZE4sOgszatARxpVHWN/Q51uZa3S8jiSlaLPfqcDS/Yv6q/G17g9W2TJ2pjwY
         rXNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NrfMxAmOI1dOmAoAUYNtBxs6J6vBQ4QSPSkOCCv87C8=;
        fh=fPxg4EIZK3zotYoDmgRc6j9pDDjM3Fw3M54EC7g+Li4=;
        b=KLKa3fjwl8oJJRHlIVcHiRl2R+bPj40Vg3e/GiWu/i049a3INNpQ0MNuCwSo9ubuU6
         Q9ghiJOouWw8+n+LsgmeQlXOMIXj3foXtXj3fniN17+CEtXSf0vIwo63Oxl2+pg2qDvV
         acQp1haFjBmF5feBJQbvuVif0byOSczk59F/Yg7YwQ3dugxwvrL1zJ8NwjIbCafhDxxh
         +7TaUc+4sn3/Rh6Y9LxlYAt8GSp3FbacOSu0h4VCGeNoTFw6t8KzBfdUrfW/F6+4vO6D
         IqhKu/7qwnKRRuVOsdk5NvifELZ0x5E03M2qiTtf3fA5m4UJ5zgucmb7DXOC54GF/Ojt
         w+dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1786450473; x=1787055273; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NrfMxAmOI1dOmAoAUYNtBxs6J6vBQ4QSPSkOCCv87C8=;
        b=LYhhybqowWX6ZR+Nf5Xxsft7xXDxdFX3reI2VxNHFPBCKIsh8yC66ANIAQgBMBikIZ
         99mOfXZFzwE+fla4yJjoCv1zBbfR1iPecQ7opVFYRx2aUa01sY/qYo/E7B2JCkdw3MWb
         feyvqbpjBXul4yjwwI3Ksk3aN7ddKGi7W+kCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786450473; x=1787055273;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NrfMxAmOI1dOmAoAUYNtBxs6J6vBQ4QSPSkOCCv87C8=;
        b=IwMKcZx45HOSRvz+dyHLqgmeFO8paMhNyLZnWIJ5NSqpCnUUIOYnc5+g7yBjH+vmDX
         E5JCp35BS4OnJxn/zRUMlDc/5XXJmZqwKjGwd5pHhcnmsT1tDCyLJyJA1H5kFU1tq0au
         UZCk6h0Y/a73r6vzKGBt5jiwldMPtbop2po/crwDbyWP+gyr1UckjLYuOxh+pKmAbVO/
         LZjroIs1VoJCIZCKz6aw18bZY5ttlKAYhueDUPrIU1Hmdhs4T5jGwgd2I6u+BJx5BwCj
         BfefNN3RY/BsMvxEARBiVmIxTM/mL8SIUjgXl06DQol8ay/4BWp1N+ZY/TJGuadb9Ii0
         iDXQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpg0bh6RwSih8QDu98B7w3bgaVeHcFLKheQIy5WURc9U79O+GVxw13WfyJk3dMFuxGTljZyz5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgfi3DifhEpjJsr/Hstij0em0Cy7R08x8BfVblT3sNuL0OcSwc
	cCZloM3z+nuaNyVwBwJzyuWjgOXjoL4cJk+Mx8eK5qjtaLIyTvgME/ozAUfBdQciehR0niDSjI3
	McZiFbv1XA3xnsSi2AZ9ZWGI+Gjz64U3B5dcg1iSpxw==
X-Gm-Gg: AR+sD12hMTqqZKLNPdoGX4E6vn+Y1UHEXYYcI2fge6HSP2AEIVJ7j4MFU+PMq/njkaV
	zMjH2XvkrFRs/hCxOqsveZ3Pai6eCTnhnxjqOqim2H67im88iXQjPCs/CKlkkfehMOKzwF9dn01
	r0wOxBz9KFSJHM+DZaaUDX4prdux7bUEjebzd/GTuLVAdAGx46DISz/CD8IQUBD+TOnIP/ZmuXQ
	I6A85XertNZfJWb4NngpL9qU/EJiuzDsWMEo3Wr3Q+HrrftbDsV0rkB+niBJW47ZGCoHEORudKX
	axbg+0YoBLyPWOdpWVaP/cDDt5dYUUoODwbajxt6iPMmiyhZBjaE5OnwN6o84XRNojOkPHJ7yoG
	4xA==
X-Received: by 2002:a05:622a:1389:b0:517:906b:c043 with SMTP id
 d75a77b69052e-52d5869769dmr20988111cf.36.1786450473109; Tue, 11 Aug 2026
 05:14:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803012648.2195405-1-neilb@ownmail.net> <20260803012648.2195405-2-neilb@ownmail.net>
 <CAJfpegt1wHngLs9uR943gT6zxV67D53k3n4GiFKowsAb3C6LJw@mail.gmail.com> <178641431036.2852630.14175693646176331672@noble.neil.brown.name>
In-Reply-To: <178641431036.2852630.14175693646176331672@noble.neil.brown.name>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Aug 2026 14:14:13 +0200
X-Gm-Features: AUfX_mx5_QZpyNyj5Ni2I_IHkZVhUDCHgR5x1MospzmB8YaToZll8PeS64_iAm0
Message-ID: <CAJfpeguZh6Bo7hxVW5f-OvKJ3UazJTn26Wkba8+rXY-LC-QNWA@mail.gmail.com>
Subject: Re: [PATCH v1 01/12] VFS: don't count references through ->d_parent
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

On Tue, 11 Aug 2026 at 04:12, NeilBrown <neilb@ownmail.net> wrote:

> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -169,6 +169,8 @@ loff_t dcache_dir_lseek(struct file *file, loff_t offset, int whence)
>                 hlist_del_init(&cursor->d_sib);
>                 if (to)
>                         hlist_add_behind(&cursor->d_sib, &to->d_sib);
> +               else if (hlist_empty(&dentry->d_children)
> +                       dput_dlock(dentry);

you mean dput_dlock(cursor)?

But that's no good, since the directory could be repopulated and the
cursor needed again.

Thanks,
Miklos
