Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795392084;
	b=Hyz393WAmHiAaX6LcWGh4/ucsZyPGL9Fk1vk17KArOLQpUEvTdm36tGWDCYoycbWQ55L
	 KlQABr07RywNDbw2pZ3h3mEBW8Nsak0+rRmd8zf0XEewmTSnYgaqg96h6ZRqSJ5VGHJyL
	 TV1g478rECyswgGKWzu4bvaw9Bc6RqCnC4T1MK+CV3q58M+h3JrHlJWxD6Lks5K+YNVK2
	 QqEL56qBX2wUQqaPaBYEzwOt4kHr3hlATa6KvbvZyaLYggC31jXbmPqHPrY6oDHBYivr3
	 XPYeh/H7QFsE/NQ/uhxbSxkoOmgpR+C5ajW93Ag6/BTBLJqkD7I67eX4bazbRLPML7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795392084;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Autocrypt:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version;
	bh=NsU8S25WYE8UtJMOtwZ8kYjXiSr0SQrEMevqcLIRN+I=;
	b=Gef6acoFQ4JOkjbTXoIKLJ0YDOV4vPJsIcphbegwewHuSB0J/2MoNPGprINvmP4fjN/i
	 6bxBlF2lG5+8nZ93ugZNv8Rdinjh8Phgij/M+LW8MNNbEL8AZv6Twyk+31GV6kxkN2cjO
	 i7sOOM4lUAi/E1HHYfq6PZQCKZgqGOrIXydjV4udpqG4aubd7TbtHM30ZkFN3gfiQ1Ctr
	 hXMQNT/qt2X72zexuWi4lvwx9X1GDrK9eI39XPxrkC+SL/ZXeTUUi1qojySTnKzqogdnP
	 MBzurGnDb7UP2Jif5iPK7zjnrzJEkwsOvx4TznxWxLG+w1+hNF02ySMwZdcDzyx2H0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=themaw.net;
	spf=pass smtp.mailfrom=themaw.net;
	dkim=pass header.d=themaw.net header.i=@themaw.net header.a=rsa-sha256 header.s=fm2 header.b=pEABzcCq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=PHxTBtS7;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71766606A320
	for <autofs@vger.kernel.org>; Mon, 23 Nov 2026 00:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71766606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=themaw.net header.i=@themaw.net header.a=rsa-sha256 header.s=fm2 header.b=pEABzcCq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=PHxTBtS7
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id CB5161D0042D
	for <autofs@vger.kernel.org>; Sun, 22 Nov 2026 19:01:22 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sun, 22 Nov 2026 19:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795392080;
	 x=1795478480; bh=NsU8S25WYE8UtJMOtwZ8kYjXiSr0SQrEMevqcLIRN+I=; b=
	pEABzcCqEMrWBZK/MGW+JXE1SF4llxtz6K0WFTaVf7lBeEST1WqKP4viBrZ+FBQ5
	OoGbU3uFg71YRHlqR8nlpdyymtnqRmdpbd41v0R/RC/s9qAWmh/Sz6SK3Zyt1xu+
	num0kOFdus1LCt/Qz6d3xKnamBs8dAL4YJTxcOpOA0jfBWvlDtyy+ijC9Am9NGl2
	ftSbTtsQAx/mjsEwKene6BYZxbp1fCGySpSg737Ct1AXpKl8V7ExKaLqqHc4Vqhq
	RZjBX2CqvTAni8Px6XSPGqoECwIRYa+XcSkcd1jCx1Q3VGwVKKiZszfL7CsOxA1y
	AMxsopm0fZzR1pg1umfARA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795392080; x=
	1795478480; bh=NsU8S25WYE8UtJMOtwZ8kYjXiSr0SQrEMevqcLIRN+I=; b=P
	HxTBtS7+r1ZjM97+76OUoaYV4QECjjdf074151OScNkam4wyWMw8j3E0qeD0kngH
	oRoUrx4hPN691Ms5uVPx5eIfJ46PZt829HkY/vtQ/hCZuPyRWX25MODy3oJhlvvI
	JX+e+lUnjBvUZZUJ/pdOKLeZX/UevF4/zMZcCAef4MJzcsZ9wIGxkHly0wp1R8Na
	lz7eEDYq9AErvlSnlKIJp3mx4wPTAsv/pWyutSnCn8dRmiUHb4mDXG+zU7a72x/g
	GXoWAyp5PYfQ1JKHLoKq8tl0OZ7BWTvBIzGUcMvj3nb1kcjJZC8+IMJSoXGVD9Bd
	U113JnCLN9HOyogYni2OA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=themaw.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795392080; d=themaw.net;
	mf=PHJhdmVuQHRoZW1hdy5uZXQ+;
	rt=PGF1dG9mc0B2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:VoPA2jvp1VoLBAuuoxTUk2dkCQXAp+ZHR2nB6yljl6s6GGA
	ula1nGYaubMjEfA+3BWLELPZ4x1ftga9N0jDKRsUbdtOP8VW0vNr/Ubt4E12fPSN
	vBjVd7SQI9pFiytyOP7pqtRwujmvILWu+2AhfHBfR5bs26RIh48OomiZmeWOQ0m7
	8B4gYjiN1cx28yxr0dYDOhmZ2Syh7rLcSophnOfjQKSuTjLxa2Gyx9Lv6lZs/wgx
	AtN3jrlAB5gxj5fKPc2cqLno8C/56ibHL7Ya/xl/BsYPebnYZQ4cG2kWStbJbWOC
	5yU2fTczJLTTWFC6Hd21VvhbLNpdzZq8o0sh5UA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=autocrypt,cc,content-transfer-encoding,content-type,date,
	feedback-id,from,in-reply-to,message-id,mime-version,references,
	subject,to,user-agent;
Message-Instance: m=1; h=sha256:HN0TNUhNHfvQfbmlovvFKc8QDMVm8T2xc/uo0DLTnWI=:NsU8S25WYE8UtJMOtwZ8kYjXiSr0SQrEMevqcLIRN+I=;
X-ME-Sender: <xms:T4IDa2XLxWFD_1spg5-d4KD5EBIuwEtwk8KQpqgezZR7TucnVBP54g>
    <xme:T4IDax2QxpGipkCxQUxPTt3NEwdI3FZGydU08OYkWrQx0nkDbnTDMg6_GUaxzlGf0
    6g4WVnoBpLNolXfskh1PLtNxTOL6vA4urFdObJlIU6hdKmk>
X-ME-Received: <xmr:T4IDa9NeIJKFip508O05LD8faRHLrMvNmDEllOC291AfbCrVqG-FJ_PeJNIwUVejfjSZHmF942BuURT1qI6n2q9WxL6yjAvTfYXHsORfEpRzbqQqwLgQSWb1yw>
X-ME-Proxy-Cause: dmFkZTF2FkGarwOb/nDN7Rnysdykp1lrHgw162faknfs/tNImeRS1gkhQZyov4XYlf7hh6
    c0w6e1pKIosLehMvew8IDIOz9iRftFmwEj+qXLcWf8eTAxmoYs2SVWpz8dwwE5G0Ln/4g4
    zl33SIR03GzRdXyl5LAq2UHl4cXkanTwnZwNcQ9JLiHVlVKkACqY5xHVnioqoGtpIldTm2
    DBsnSvJlKm2QWxrXGHvb3w6PbRu5pwSQ8OkifTSLSaIJ5IgyVzeFJZ92MMq2lywVPtz1fJ
    J2pSIsKEv0EUmNNG/HzUBNlvhcakynGTbkbsDRB+SXHpTmqScy7sdDQI+/eKwrsegUOkuB
    mh/VtQHf/30vuifAFYZ56WRhoyZG9lG+3wuGCOZjIqkEu1pSPY5sESizWeA6KatDjnBFlt
    Ffa7752mB1KSgxDwMi/NftI6rwPf2LbDPARKFx8/eBfIMSmKZwfTo2BpVsngpt8QngT16T
    8pqeQDVPbtLxfn/L8pPFjo1zCif60Gsb67f8VnEP/sPzBW0TtOAALliGfXTohja5Q1MmLF
    QmfkvwdMptjoerBR/S3xjsIKjNVaVvsP7KajkWGl3qXggNVlFmqW0vf1QT4KWG3/P/cEG2
    OCR/UXIIk6y5+mvbxPSAAtnmbETRjq6nMxFY2HeU7iW2cwTVapdtkYuSTw/w
X-ME-Proxy: <xmx:T4IDa03JTy7IBZf1kMGkujmlGI3FHLF_aNVGMOTKbkYwlWDkhiypdg>
    <xmx:T4IDa00sHPPQ4tHxwuzUM79FLIJVsQ1GUfwxQkRWocxb8nvuLxKCKQ>
    <xmx:T4IDa69Zy0sYW71SFqZyYU4mcjNSk67Y8fArtRS7NkD0AH5f-ImZYA>
    <xmx:T4IDa4ZQkHD3cIhxf4LsW73cW0z9ikCHBxN5OESD4QelyGrII2s9GA>
    <xmx:UIIDa-37mw4VmeqRzglfHBdLqZ2BeSRGXRDgVb9QViddTjnz74sKHdfC>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Nov 2026 19:01:13 -0500 (EST)
Message-ID: <1f7bba7d478286814d5c5f00c3c14711698e95e4.camel@themaw.net>
Subject: Re: [PATCH v4 0/2] kernfs, sysfs: refuse splice on /sys/power/resume
From: Ian Kent <raven@themaw.net>
To: Krystian Kaniewski <krystianmkaniewski@gmail.com>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, "Rafael J.
 Wysocki"	 <rafael@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, Len
 Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, Jens Axboe
 <axboe@kernel.dk>,  Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org,
 autofs@vger.kernel.org, 	linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
	syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Date: Mon, 23 Nov 2026 08:01:11 +0800
In-Reply-To: <20261116133903.400202-1-krystianmkaniewski@gmail.com>
References: <20261116133903.400202-1-krystianmkaniewski@gmail.com>
Autocrypt: addr=raven@themaw.net; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45app1) 
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Post: <mailto:autofs@vger.kernel.org>
List-Help: <mailto:autofs+help@vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:autofs+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-16 at 14:39 +0100, Krystian Kaniewski wrote:
> This series refuses splice on /sys/power/resume and gives writable
> opens of that file separate lockdep classes, as Tejun suggested in
> the
> v1 discussion.
>=20
> The reported cycle is assembled from two operations. Splice into an
> ordinary writable kernfs file records pipe->mutex before of->mutex. A
> normal write to /sys/power/resume records of->mutex before the autofs
> pipe locks when resume_store() resolves a relative path.
>=20
> Patch 1 adds SYSFS_NO_SPLICE and kernfs_ops->no_splice. Every open of
> a
> marked file refuses splice. Only writable opens use separate of-
> >mutex
> and seq_file lock classes, because only they can reach the store
> callback which creates the reverse dependency.
>=20
> Patch 2 marks /sys/power/resume. Normal reads and writes stay
> unchanged,
> including a write which resolves a relative path through autofs.
> Rafael
> acked it to go together with patch 1.
>=20
> Other stores also look up paths. They remain outside this minimal
> series
> and can be marked in follow-up patches.
>=20
> Tested on v7.4-rc1 with fresh builds of the exact base and the
> patched
> tree. The original C and syz reproducers report the lockdep cycle on
> the
> base and run without a lockdep report with the series. Splice and
> sendfile from an O_RDONLY open of /sys/power/resume return EINVAL
> with
> the series, while read() still works. All 33 QEMU cases booted and
> completed in both phases. The builds, W=3D1 checks and Coccinelle
> checks
> introduced no warning or report.

Just to complete the cycle (although a bit late) I appreciate the
effort to come up with a way to resolve this without adversely
affecting autofs.

And while my knowledge of some of the areas these patches touch
is not so good they look sound, as does the description, and it
tries hard to clarify the case at hand.

So to the that extent:
Acked-by: Ian Kent <raven@themaw.net>

Thanks
Ian

>=20
> v4:
> - Refuse splice for all opens of marked files (Tejun).
> - Keep separate lockdep classes limited to writable opens.
> - Add no-splice operations for read-only regular sysfs attributes.
> - Keep Rafael's Acked-by on patch 2, whose code is unchanged.
>=20
> v3:
> - Rename SYSFS_LOOKUP and ->may_lookup to SYSFS_NO_SPLICE and
> =C2=A0 ->no_splice (Tejun).
> - Drop the mmap, prealloc and binary attribute checks (Tejun).
> - Add Rafael's Acked-by to patch 2.
>=20
> v2:
> - Replace the v1 locking changes with per-attribute splice control.
> - Preserve splice on read-only opens.
> - Split both the open-file mutex and seq_file lock classes.
> - Reject incompatible mmap and preallocated-buffer combinations.
> - Reject SYSFS_LOOKUP on binary attributes.
> - Rebase onto v7.4-rc1.
>=20
> v3:
> https://lore.kernel.org/r/cover.1794479968.git.krystianmkaniewski@gmail.c=
om
> v2:
> https://lore.kernel.org/r/cover.1793715774.git.krystianmkaniewski@gmail.c=
om
> v1:
> https://lore.kernel.org/r/cover.1792577179.git.krystianmkaniewski@gmail.c=
om
>=20
> Krystian Kaniewski (2):
> =C2=A0 kernfs, sysfs: add SYSFS_NO_SPLICE to refuse splice
> =C2=A0 PM: hibernate: refuse splice on /sys/power/resume
>=20
> =C2=A0fs/kernfs/file.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
51 ++++++++++++++++++++++++++++++++++++--
> --
> =C2=A0fs/sysfs/file.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 23 ++++++++++++++++++
> =C2=A0fs/sysfs/group.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 4 ++--
> =C2=A0include/linux/kernfs.h=C2=A0=C2=A0 |=C2=A0 9 +++++++
> =C2=A0include/linux/sysfs.h=C2=A0=C2=A0=C2=A0 | 22 ++++++++++++-----
> =C2=A0kernel/power/hibernate.c |=C2=A0 3 ++-
> =C2=A06 files changed, 99 insertions(+), 13 deletions(-)
>=20
>=20
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
