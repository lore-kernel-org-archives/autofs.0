Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794371594;
	b=ew1sIoU8/JPTEOmgGN6UYWnGn+5IggnjzjoGAvIOQqiYtXXCIss5y/dALEETvxeX4icq
	 FjDBVPGb6MkMIhXSePOne+Tad56T+bLrd8kEfer+wXIaTzEyLMyIDkPtoQtLdBCiKTCcl
	 iYUOE0h4Aw4C5hY+h0PsHaTPayUEUO2w2DylQ7Td2q683441EhazXwYOeaMN68d1VSxkj
	 dzmnOGj2mb74vLOJFCycFrueUflk5DbLLqf2thtX0+68NtCgOsyt2rBFfzgMiIq7ikhcN
	 fPq/jrJFhpLH6RVvT7rL9ESnel5F/v5JDpEXWI+Auoa30tPGxbt3IZCmQbbhTQGdTzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794371594;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Autocrypt:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version;
	bh=KMUzsxkq63JqPiyHGK1lz9dIxsB5lBy8/utrr4GnuhI=;
	b=pBQEdLTCavmRVBuQmZesywBWfk6GP3ZMFYQ2dHNPX12Qy2EwhlslLczeY13YpoiqNpyr
	 UV4UjYB+1UNPNdWwfFU2jwckoDZNbxNMH75iUIK9TH5cIHSgYhDlrcANyrf1i3cpPNgjU
	 VDhPZUxtwL/ueGM3krMd2H+IFd2988Gf2CSo2sAmZmfmssHZjFcLBMKQ9Q8VDIQVrkFQp
	 kMw5OWtLheaFyNHUJISzhoV4rd+4zpKqgayNA9zWI8/ZqEHQ31Qb4WRR3OzJqfDx/uQ6H
	 9ZLVrj34st9GX5G10Yrtq0ShkMOJhLXEdrnPKC7Ou1du4Mbh7Tlbo4hH4fH6O8ig3dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=themaw.net;
	spf=pass smtp.mailfrom=themaw.net;
	dkim=pass header.d=themaw.net header.i=@themaw.net header.a=rsa-sha256 header.s=fm2 header.b=iP+jdNnj;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=wEYwaRFA;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15CB606A321
	for <autofs@vger.kernel.org>; Wed, 11 Nov 2026 04:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A15CB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=themaw.net header.i=@themaw.net header.a=rsa-sha256 header.s=fm2 header.b=iP+jdNnj;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=wEYwaRFA
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5C8DA7A01D1
	for <autofs@vger.kernel.org>; Tue, 10 Nov 2026 23:33:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 10 Nov 2026 23:33:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794371592;
	 x=1794457992; bh=KMUzsxkq63JqPiyHGK1lz9dIxsB5lBy8/utrr4GnuhI=; b=
	iP+jdNnjW8WIFH2RlqNvadzjK0vxB8k8a7QhG4xnpeFkTBImRRNdqYhyrHQhQBWX
	1EGWqtLEGPJ/plJmobCv+GzB5QMXq/puOgslzipz+VMktGD80r3TaEroTlkAgLTR
	atdffHMesZ+bKs4BUURgD0rUr2LzeRjacew+hbCXDYh5W3PaxsR6sRdr13ssuY4L
	ySScG5suuQ9A4aG9yencnD+Olt2ujLq/IIwxXCKjLCNGZq8oQYsg67aiU/GADw8Z
	c0kdtZPssortBwEszD6fqrjr2aLwocAaeXQdvdg/HhrG7K4xpcCHUuwQnK5+s+Dc
	JrO0z//rn3JZnISatZS9YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794371592; x=
	1794457992; bh=KMUzsxkq63JqPiyHGK1lz9dIxsB5lBy8/utrr4GnuhI=; b=w
	EYwaRFAN4LqDVxXtuC62SReV6iR85phBLBIMXwVkXIDs+hGebHczVMkt1tw9ST6y
	EO+MXwxXM4JSCTjS0xbb6wVgI1KWkUIKe9HTxbKFImzT0jk5kpIRCExR7TvJBY6Q
	k//+Lkb8Fn2h1G4jEEP/r+ED76T9PryyUcK0p3XvdmFfF+5S+18dAyB3Whm9Fjl+
	Ag5cx1/RU16nzLkthvnFbg1JXPk3j+zQdmS60nHsreMqNtd0DMB+3YJvVhRe8+VM
	koUXD+m6wV5d9JGHH6uLtraIEwNV9gQuV/aJyg7Erh8Suap4YK+AuqdoX7PZjHnf
	Z3sNeCGOWzY0F4rLUXIJg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=themaw.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794371592; d=themaw.net;
	mf=PHJhdmVuQHRoZW1hdy5uZXQ+;
	rt=PGF1dG9mc0B2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:jQ8S52Y+DKbOaGPr72VQxZ9cIuY5I08kDH7cS/IhfdndX9A
	L/a9pXx0PQL2p/Z/t1gU+XBLE8SrFxCKbywhA+8qbxi+9qhoruxBNXiJTaHS3UKF
	owPYSDa3Q2wG2Wrto53/T0oFFN1zT15gkp+aHhgm5wabfUvdlcB/HxrdfwWy8yyL
	ST4O0QF1v3NohqqXDYth63bi5rf+PhdKzo2/Y1GTpFvZPkD6eEM8HBWHjwD9L7AM
	g50XGHPDyHgKuCLwYRwkctWXP5GX3zstCgCDSfKHsSJlzpe+XR4ajBoKCu0/NJQU
	TkRcFbgNVar2V5ejzmAWFmWyoI8iIqX9wo1oH+Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=autocrypt,cc,content-transfer-encoding,content-type,date,
	feedback-id,from,in-reply-to,message-id,mime-version,references,
	subject,to,user-agent;
Message-Instance: m=1; h=sha256:H9VyCrvnt/nKEhmMCUA+deFPnOiqbKsv03FYn32wtlo=:KMUzsxkq63JqPiyHGK1lz9dIxsB5lBy8/utrr4GnuhI=;
X-ME-Sender: <xms:BvDzar3yxAFyolBbZlLujwoJ_i8qmFrQ5El9jcDeaHfApT8r6gODVA>
    <xme:BvDzag8PWnqZgOjZXxDocu2od7hJ42FBWx7URhZjiZBZCK0AKFfRJGfXqExBec72c
    pCf1X5W42ZVzx4s7dMk_4e9QNg5S8c1fn5iPRox7OAmYk92TQ>
X-ME-Received: <xmr:BvDzakN2xogztGWQ6ywqS4Y5V-lFfSwf7nrPf9kSiErtTOpLaSwWz4x0aCBc57ua3qLMoKhBVS4ExGhi96ZBgI0Ak2XiK3p2E5EIQA9dId9KuYa-8y4w7c5jnw>
X-ME-Proxy-Cause: dmFkZTF+oQVf0JnUxi4gzWy8isi3VafZx2u0urWwh2RbXFSiUO21Wx5z7YwCLS+GogJz4l
    CNVucRoD6y/4mwU3HcF8k1ii+MR61/75LkgDFwOs6gaO5QXAt7hFqxqIP6YYwiiyKf0m8j
    7z8jJ/skSoatEGD5rNMlRupJKoMCJSkeDRgoXlIjvSC8shAvZEqGsEaJBAbSqq40nAz3qR
    NkYVLArKXVqqlWZqi/rKvJW+pwFC5d0JpEfCPuHnnFnKi84DBfnqAjYAsX0R+Zfzxgl91f
    5QWoNhpfoCzfqT2tg5WboXjlD1hABNPpS34kEtrQblStaimbTeRYOdJ8NUgl55XWnN3CMB
    31M7egBGEUt2k5Rs5PCVH6jcVIJ6pjFFzfI8nb30XGZMPNiHN9mTTbGkk7KNz/NYmmTkyA
    ueGLE0Op7uJfOCxSXgp0FO5/T7BW+e3PGBgiytqIm0+LzONMp8pYYQqocnU7Jvfrg2hLUK
    oy24lam3ToC/Kxy8L9qqurKxic0DkMpYYtddg/SB7XU/J75VOkC4GVmULbp2iEUgfhlFHE
    y49Vt9r76yRGmsuELPUQSFRN9dsuXDXSiWsWl8hEeQL0bbM9FCYkUFT/mooRFbzJmpAYhp
    bRnP8wnEIy8gZgrC6YbamCGQYWHFuqggPsg0NcWqbdYd8w5s1/xjlQuI88WQ
X-ME-Proxy: <xmx:BvDzase2JTA1zJ9Wd_GhXwMDbbBdmmhGzP6YWwTntWnbq5BlSMZwHQ>
    <xmx:B_DzarVZz6iLIwlrc4LdRy6oEIPKBPYPgCuKux7d3UXVeFp_u9Zgmw>
    <xmx:B_DzasgputdnA6ALIF1m4h9GHGMZQ_A0VlcrhB7o4Z0TVrJBT924Uw>
    <xmx:B_Dzai_CZmaiPsWW8_PRFbG7C7AbE-SLKCevvcCnOPXFucRFHgs4Rg>
    <xmx:CPDzasJWGralz-r08_aFLThDsmvB8_uZiJZXTGrLmikxCEkTwT2WXC8v>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 23:33:09 -0500 (EST)
Message-ID: <5a3c91335fad00a6fa9d0667d6377a4da482533f.camel@themaw.net>
Subject: Re: [PATCH] autofs: serialize allocation of global wait queue tokens
From: Ian Kent <raven@themaw.net>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+c6d286fd51860df64d9a@syzkaller.appspotmail.com
Date: Wed, 11 Nov 2026 12:33:05 +0800
In-Reply-To: <20261111034050.12573-1-zhujun2@cmss.chinamobile.com>
References: <20261111034050.12573-1-zhujun2@cmss.chinamobile.com>
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

On Wed, 2026-11-11 at 11:40 +0800, Zhu Jun wrote:
> autofs_next_wait_queue is shared by all autofs superblocks, while
> sbi->wq_mutex only serializes requests on one superblock. Concurrent
> requests on different mounts can therefore lose updates to the global
> counter. A delayed update can also move it backwards, allowing an
> outstanding token to be reused on a mount.
>=20
> Protect token allocation with a global spinlock. Keep the existing
> token
> type and the wraparound rule that reserves zero.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Yeah, good catch ...

Acked-by: Ian Kent <raven@themaw.net>

> ---
> =C2=A0fs/autofs/waitq.c | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>=20
> diff --git a/fs/autofs/waitq.c b/fs/autofs/waitq.c
> index 92c0bbbf452b..22bc59c2f63e 100644
> --- a/fs/autofs/waitq.c
> +++ b/fs/autofs/waitq.c
> @@ -5,12 +5,14 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#include <linux/sched/signal.h>
> +#include <linux/spinlock.h>
> =C2=A0#include "autofs_i.h"
> =C2=A0
> =C2=A0/* We make this a static variable rather than a part of the
> superblock; it
> =C2=A0 * is better if we don't reassign numbers easily even across
> filesystems
> =C2=A0 */
> =C2=A0static autofs_wqt_t autofs_next_wait_queue =3D 1;
> +static DEFINE_SPINLOCK(autofs_wait_queue_lock);
> =C2=A0
> =C2=A0static void autofs_catatonic_mode_locked(struct autofs_sb_info *sbi=
)
> =C2=A0{
> @@ -396,9 +398,11 @@ int autofs_wait(struct autofs_sb_info *sbi,
> =C2=A0=09=09=09return -ENOMEM;
> =C2=A0=09=09}
> =C2=A0
> +=09=09spin_lock(&autofs_wait_queue_lock);
> =C2=A0=09=09wq->wait_queue_token =3D autofs_next_wait_queue;
> =C2=A0=09=09if (++autofs_next_wait_queue =3D=3D 0)
> =C2=A0=09=09=09autofs_next_wait_queue =3D 1;
> +=09=09spin_unlock(&autofs_wait_queue_lock);
> =C2=A0=09=09wq->next =3D sbi->queues;
> =C2=A0=09=09sbi->queues =3D wq;
> =C2=A0=09=09init_waitqueue_head(&wq->queue);
