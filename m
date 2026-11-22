Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795321605;
	b=GxCQKfzLsU4MCjOMxdG/WV0TNposcsrIGan+/O25wq7bEjSs2VWdJ7th0gpfjtouYCFz
	 GR1D/5mOv08tU6oOjlE+IF78KkGjvie+Y3KTlWOUoX02nz9KxknSENRiIgJxPas7C17NF
	 AOuOv4mn10hKc/l5TPFYqjzNxlBGkMhh59dw1Ogc6rD9rzKChF+zkjDtt4K+XQ/tyqFJl
	 uTRShfn1RWnKBQ20ycc85Gr+0EP9rY3Nwgw1Irladpy+QjEA95phxQtcVdLsjztbCokSp
	 glMFgWT8zH6WsfcRNZWPUp5UVlj0+J3pHKmBfRyKXLZHc8VLMbhNECVVDG29YZHYKDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795321605;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Autocrypt:Content-Type:User-Agent:MIME-Version;
	bh=M3nwgkTec3UmUZI1xi2Kt1tydn2sJlagl4pPPUUeQME=;
	b=CpiAVIxLKiIwk7f+tBAsdlHf8AtGytXGyuE4mwqZ2BCy0J62bLHnJcwBN7SKu61QOPa0
	 6uGEjvzOndmsQLzUz9WiweGjC7vkY/Mztk2+np9OAw8QAU0N5xedgbZgvFv5RiEY/GPwU
	 u6pUkgl8Vq9Gh327gmpnKv+bMUc4FxiWPHLGxuZVTqtKDDnAQTIXW/ddCHbaVPcvvXQH9
	 H4MltOl5Um2GmbseTCmjR4bd6gcjg8Z5L6im74raC41x+xB7S3+GG1UvgdJCWDyI0Vg+g
	 hF4TxSv7P5clRJmDNoun+wr6YCFvqRFuz6j6swPN5LwpXSdVz8VPSHdMttOz3KTcMyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=themaw.net;
	spf=pass smtp.mailfrom=themaw.net;
	dkim=pass header.d=themaw.net header.i=@themaw.net header.a=rsa-sha256 header.s=fm2 header.b=Ou+TqHVn;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KehGsXzH;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E939606A32A
	for <autofs@vger.kernel.org>; Sun, 22 Nov 2026 04:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E939606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=themaw.net header.i=@themaw.net header.a=rsa-sha256 header.s=fm2 header.b=Ou+TqHVn;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KehGsXzH
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 789BCEC07E2
	for <autofs@vger.kernel.org>; Sat, 21 Nov 2026 23:26:43 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sat, 21 Nov 2026 23:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795321603; x=1795408003; bh=M3nwgkTec3
	UmUZI1xi2Kt1tydn2sJlagl4pPPUUeQME=; b=Ou+TqHVnx3M/2ASGDohF22Wbws
	UK5efZPyzQYu6gg6NEXWLzbeDiTPswkiIE0o4M1h5YzpaT2ZCcuZVafzNNSwo+1A
	Sc52ZcWmLsHhH14b64LmcFKWEhcenIDMDvoqwmCthgE3AJ2KQPiZ2Y5Zm5iFxir6
	ekb7ORnTYnBBSCj2q4Lnwmj8y2CYWr7poa20mhvquPRdHQaaSUbiuOUHxgWKAk9W
	Yu5cJS3RMmrRtIH137acCEZPP5XGFbX1+fWHPp4nEoCrOViv/OT2xAt8/QpgVmd+
	aUPN+3aKmBI7usK+1o3x18nEYIBzql+WVKaaErIzH/YKYFz+k7BL+tKEj+nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795321603; x=1795408003; bh=M3nwgkTec3UmUZI1xi2Kt1tydn2sJlagl4p
	PPUUeQME=; b=KehGsXzHCTS/lEqdygIECnw1y2xanT7YWYlwW5qlJ6sMK0wEddQ
	W13zspJFkyxPg1iLxRmqHe1uUyruDfQQHdylENK/ckoL5F0MmHg1uil8RCQrXA96
	FxdxYFHXs+rtaeRP/GEye37yc8I2A3iy6oYcAIELGh1WzTacRCJrGoicOUiT2FqI
	Vn+l1LPBeTYGB7LX7dJ2x4TxKHe5UKmtD4d2KZAknMrMob3fodnVteJreksUnCb5
	r0Aed2uDtoIz/E5gr3hQEdYnpSc6FasFG5vnGxRmFITy6mA21bCWi6yyik0ivuWt
	DCz4j+WIa+J956LKQF2xEj1Kozrs+4kmUzg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=themaw.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795321603; d=themaw.net;
	mf=PHJhdmVuQHRoZW1hdy5uZXQ+;
	rt=PGF1dG9mc0B2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:lRspt+GBprQ8ta/AhJg9CG6krFmwApQUNLFDBTeUR6UEylu
	OaJg9DiywDA8iXfzLz93UAAkAS+U7VptJXazPxkjumITFWqZUDhxZesY6sz/d/NQ
	DLdRweg2xn4NojTFXD9BrhZ0XfCb0PmcmjxszSn+DVkeLLsAvzMiTsxBrgpKXbqK
	H5MftMZbGhEajRPLDSmUbqb/FLesh3BQztTet1gXb0otvQANnhYzV0QKpDZfcHwc
	R0jtAUdfADKJne6zAUs/itGzoVnRgjXiV3V2ItfRxxY+gpGaNZ3SYTmNja0WfGnC
	4wQT63katf1kiBvx1xUZdsmzvkDS1m1PvtQFArQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=autocrypt,cc,content-type,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:wnHKnY90jJLU4nxR5UbAlUpLGG4wE1KaiAKFUQqKP6o=:zN80Jn4YkHSGN3mul063lZyLulAkD2/kvb3YDI1zz1s=;
X-ME-Sender: <xms:A28Ca28V5_QAEIjIlKgCcekbIfDCd-mhrY-hM-tR3-CARW6QcqcBgQ>
    <xme:A28Ca8t5jcDgxFw6YHp61pU4gcVNsNKCrBZKt7EoVMp95kc9urC5SO_4lhtMBaLxB
    d_NAJmj6P5Gbv-uXzdRXK1wKduRpaRHAAfLpr2LjxEdVALL>
X-ME-Received: <xmr:A28Ca5ozFp3oZc7tdCH_7eVeu23owwR5injjhVMlu8MBsy0eWlDuS70QP8KYpsvLntKMOfiZP1wUPx7hhKDoj-tNtAZiEW3CyJYOjcO08lnA2EEWN2ZTG23wNg>
X-ME-Proxy-Cause: dmFkZTF7kvsvNmoPnXvyX8cfQ7587tpimHxzHIhjNkh+7hBUTJJlRMnFGB2Y0SRqXJyf4p
    yp3UxPkncrVAgxl/RrulGrTx/l/gyY8NSUZhEbp+dnEqaTwOZcdopZ96Bfd5/07wHvQCem
    tkj/4PBURafZyTGmX+ZhOMIjgWRbsXSDS3K6qcqesypMU90Kt45qf1JdgU/PIbYJ/Jmobs
    UVkN6lytcchew1iEJqXguGy0AzvJf0djfc9KxSZLy1Gu++aL8rXqCCduzhMpTmSDBEeR2P
    2mFCWmCwLFEhOIt5LHgGGC4F+DPHXgiuF5BYiQM5qY+5ojmQG4tkiK1oFgWZfRVHhvbWD8
    AlO0ItfShBheLC3WJJs+AXQnkRlLgu1JakTRFm5ixu24pttDR5gfC7lsP5ytD3YnXESddp
    LvcubUAKnVmy8/o5RyjVk8ReqJtDjVMCKhOXcQnzW/m0K1B6zdYXNCOOAWVPUjPK1K+8mc
    NS0fdN9QPXh7AoguNQRqjO/erfOK8B2A4m8F7lEPSRgqa1mB9wNaVrV+gFNVO+tSYIi6dP
    h2yUqzIwsi19eWiEuwvlyAp0CGwWRSuts8cxib9hpOHT60BVAQjfX8zsf+ZnDHooOJtOB7
    6Yx0ZB7jw6N6O0fjqq9pER2qk+AQSllwUVbuPu5J5PcW/OvdE/nOgZAf9bew
X-ME-Proxy: <xmx:A28Ca5mdohqKXsnNinguVfC2Rb3DqXpb-YUgkQ3swzQWcPOy4Fyh4g>
    <xmx:A28Ca9wNp1EoRq1B7eLhFTIESJh-Yjx8KMu88n1532QtcUCOi2DuUg>
    <xmx:A28Caxl6_AYI5Sxhn0EVjeb46XlEhgEVaG_RNYT_oxfD6GWWS1ETAA>
    <xmx:A28Ca2cl0-eRM-86lPjkXk9M7qweTciLuLAWQoTY8htqAsVjnkw8DQ>
    <xmx:A28CawRSqljUFpQMymw5086pPZxd7GRatF-y-Sr0QpwTnjofG--pcPXx>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Nov 2026 23:26:41 -0500 (EST)
Message-ID: <d078dbfaebb342300ee8d89526afdb81b28c1197.camel@themaw.net>
Subject: Re: Regression in 5.2.0, SIGSEGV in master.c line 619
From: Ian Kent <raven@themaw.net>
To: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>
Cc: autofs@vger.kernel.org
Date: Sun, 22 Nov 2026 12:26:39 +0800
In-Reply-To: <4c791661-cdaf-45fc-8c1d-1a2d8a9b48ae@moonlit-rail.com>
References: <4c791661-cdaf-45fc-8c1d-1a2d8a9b48ae@moonlit-rail.com>
Autocrypt: addr=raven@themaw.net; prefer-encrypt=mutual;
 keydata=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
Content-Type: multipart/mixed; boundary="=-8U5pwtwvy7CixQS0TVco"
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

--=-8U5pwtwvy7CixQS0TVco
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-11-17 at 00:42 -0500, Kris Karas (Bug Reporting) wrote:
> Greetings,
>=20
> After upgrading autofs-5.1.9 to autofs-5.2.0, automount successfully=20
> shows --ghost subdirectories under a configured indirect map.=C2=A0 But
> any=20
> attempt to view files under one of the mount points crashes automount
> and causes the file access to hang.
>=20
> Interestingly, the mountpoint actually does get mounted, so killing
> the=20
> wedged file access and re-running will show the mounted contents.=C2=A0
> But=20
> the automount daemon is dead at this point.
>=20
> ~# gdb /usr/sbin/automount
> (gdb) set args -f -v
> (gdb) run
> =C2=A0=C2=A0=C2=A0 [boilerplate here trimmed]
> =C2=A0=C2=A0=C2=A0 [doing=C2=A0 <ls /amnt/slack>=C2=A0 in another termina=
l window]
> (gdb)
> Thread 9 "automount" received signal SIGSEGV, Segmentation fault.
> [Switching to thread 9 (Thread 0x7fffe7fff6c0 (LWP 16086))]
> 0x00007ffff7b90c47 in __strcmp_avx2 () from /lib64/libc.so.6
> (gdb) up
> #1=C2=A0 0x00005555555710f4 in send_map_update_request (ap=3D0x5555555bf9=
20)
> at=20
> master.c:619
> 619=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (!strcmp(ap->entry->maps->type, "hosts"))
> (gdb) print ap->entry->maps
> $1 =3D (struct map_source *) 0x5555555bfa20
> (gdb) print ap->entry->maps->type
> $2 =3D 0x0
> (gdb)
>=20
> No changes to config files, using the unaltered ones in
> autofs-5.2.0/samples/* that ship with the package.
>=20
> It's a Slackware64-current distro here.
> The only customizations are these:
>=20
> ---- Start /etc/auto.master.d/amnt.autofs
>=20
> /amnt=C2=A0 /etc/auto.master.d/amnt.map=C2=A0 --timeout=3D60 --ghost
>=20
> ---- End /etc/auto.master.d/amnt.autofs
>=20
> ---- Start /etc/auto.master.d/amnt.map ----
>=20
> slack=C2=A0 -fstype=3Dnfs,nfsvers=3D4.2,ro=C2=A0 fileserver:/srv/slackwar=
e
>=20
> ---- End /etc/auto.master.d/amnt.map ----
>=20
>=20
> Kindly CC me on any replies you wish me to see, as I'm not subbed to
> the=20
> mailing list.
>=20
> Kris

Sorry to be slow to get back to you.

This has been reported a couple of times now and I have a patch I
think resolves it but have not yet uploaded it to kernel.org.

I'm not a Slackware maintainer so I'm not sure what we should do in
that respect.

If you can, please test the attached patch so I can move along the
posting it upstream and committing it to the autofs repo. etc.

Ian Kent

--=-8U5pwtwvy7CixQS0TVco
Content-Disposition: attachment;
	filename="autofs-5.2.0-fix-map-type-check-when-reading-master-map.patch"
Content-Type: text/x-patch;
	name="autofs-5.2.0-fix-map-type-check-when-reading-master-map.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

YXV0b2ZzLTUuMi4wIC0gZml4IG1hcCB0eXBlIGNoZWNrIHdoZW4gcmVhZGluZyBtYXN0ZXIgbWFw
CgpGcm9tOiBJYW4gS2VudCA8cmF2ZW5AdGhlbWF3Lm5ldD4KCkNvbW1pdCA1NjdiNGVhMiAoImRv
bnQgYXV0byByZWFkbWFwIGZvciBob3N0cyBtYXAiKSBhZGRlZCB0d28Kc3RyY21wKGFwLT5lbnRy
eS0+bWFwcy0+dHlwZSwgImhvc3RzIikgY2FsbHMgaW4gZGFlbW9uL21hc3Rlci5jIHdpdGhvdXQK
YSBOVUxMIGNoZWNrLiBJZiBhcC0+bWFwcy0+dHlwZSBpcyBOVUxMIHdoZW4gdGhlIG1hc3RlciBt
YXAgZW50cnkgaGFzCm5vIGV4cGxpY2l0IHR5cGUsIGUuZy4gIi9hdXRvIC9ldGMvYXV0by5hdXRv
IiwgYXV0b21vdW50IHNlZ2ZhdWx0cy4KCkFmdGVyIHRoZSBkYWVtb24gZGllcywgcHJvY2Vzc2Vz
IHRoYXQgYWNjZXNzZWQgdGhlIG1vdW50IHBvaW50IHN0YXkKYmxvY2tlZCBpbiBhdXRvZnNfd2Fp
dCBhbmQgdGhlIHN5c3RlbSBmcmVxdWVudGx5IG5lZWRzIHRvIGJlIHJlYm9vdGVkLgoKVGhhbmtz
IHRvIERlcmVrIFBhcmtzIGZvciB0aGUgaW5pdGlhbCBwYXRjaC4KCkZpeGVzOiA1NjdiNGVhMiAo
ImRvbnQgYXV0byByZWFkbWFwIGZvciBob3N0cyBtYXAiKQpSZXBvcnRlZC1ieTogRGVyZWsgUGFy
a3MgPGRucGFya3NAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBJYW4gS2VudCA8cmF2ZW5AdGhl
bWF3Lm5ldD4KLS0tCiBDSEFOR0VMT0cgICAgICAgfCAgICAyICsrCiBkYWVtb24vbWFzdGVyLmMg
fCAgICA5ICsrKysrKystLQogMiBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvQ0hBTkdFTE9HIGIvQ0hBTkdFTE9HCmluZGV4IGE3Yzdh
YmQ0Zi4uZmRmNDU3MGFkIDEwMDY0NAotLS0gYS9DSEFOR0VMT0cKKysrIGIvQ0hBTkdFTE9HCkBA
IC0xLDMgKzEsNSBAQAorLSBmaXggbWFwIHR5cGUgY2hlY2sgd2hlbiByZWFkaW5nIG1hc3RlciBt
YXAuCisKIDEwLzExLzIwMjYgYXV0b2ZzLTUuMi4wCiAtIFVwZGF0ZSBjb25maWd1cmUgc2NyaXB0
LgogLSBmaXggbGRhcF9wYXJzZV9wYWdlX2NvbnRyb2woKSBjaGVjay4KZGlmZiAtLWdpdCBhL2Rh
ZW1vbi9tYXN0ZXIuYyBiL2RhZW1vbi9tYXN0ZXIuYwppbmRleCBmMWRmODA3MzEuLjk0YjBkOGRi
OCAxMDA2NDQKLS0tIGEvZGFlbW9uL21hc3Rlci5jCisrKyBiL2RhZW1vbi9tYXN0ZXIuYwpAQCAt
NjEzLDEwICs2MTMsMTQgQEAgdm9pZCBzZW5kX21hcF91cGRhdGVfcmVxdWVzdChzdHJ1Y3QgYXV0
b2ZzX3BvaW50ICphcCkKIAlzdHJ1Y3QgbWFwX3NvdXJjZSAqbWFwOwogCWludCBzdGF0dXMsIG5l
ZWRfdXBkYXRlID0gMDsKIAorCS8qIERvbid0IGJvdGhlciBpZiB0aGVyZSBhcmUgbm8gbWFwcy4g
Ki8KKwlpZiAoIWFwLT5lbnRyeS0+bWFwcykKKwkJcmV0dXJuOworCiAJLyogRG9uJ3Qgc2VuZCBh
biB1cGRhdGUgcmVxdWVzdCBpZiB0aGUgcHJpbWFyeSBtYXAgaXMgdGhlCiAJICogImhvc3RzIiBt
YXAuCiAJICovCi0JaWYgKCFzdHJjbXAoYXAtPmVudHJ5LT5tYXBzLT50eXBlLCAiaG9zdHMiKSkK
KwlpZiAoYXAtPmVudHJ5LT5tYXBzLT50eXBlICYmICFzdHJjbXAoYXAtPmVudHJ5LT5tYXBzLT50
eXBlLCAiaG9zdHMiKSkKIAkJcmV0dXJuOwogCiAJc3RhdHVzID0gcHRocmVhZF9tdXRleF9sb2Nr
KCZpbnN0YW5jZV9tdXRleCk7CkBAIC0xNTEzLDcgKzE1MTcsOCBAQCB2b2lkIGNoZWNrX3VwZGF0
ZV9tYXBfc291cmNlcyhzdHJ1Y3QgbWFzdGVyX21hcGVudCAqZW50cnksIGludCByZWFkYWxsKQog
CQkvKiBEb24ndCBzZW5kIGFuIHVwZGF0ZSByZXF1ZXN0IGlmIHRoZSBwcmltYXJ5IG1hcCBpcwog
CQkgKiB0aGUgImhvc3RzIiBtYXAuCiAJCSAqLwotCQlpZiAoc3RyY21wKGFwLT5lbnRyeS0+bWFw
cy0+dHlwZSwgImhvc3RzIikpCisJCWlmIChlbnRyeS0+bWFwcyAmJgorCQkgICAoIWVudHJ5LT5t
YXBzLT50eXBlIHx8IHN0cmNtcChlbnRyeS0+bWFwcy0+dHlwZSwgImhvc3RzIikpKQogCQkJc3Rf
YWRkX3Rhc2soYXAsIFNUX1JFQURNQVApOwogCX0KIAo=


--=-8U5pwtwvy7CixQS0TVco--
