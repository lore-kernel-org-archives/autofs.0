Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793150521;
	b=e7rAHnCIFqbAhOZ6nSihC70KNKVjq1QgynEpvTYaPNEhzvpAZwUGWooBTilLAOlFdYCu
	 pm60myj1P8TdPDO7/TlpVcIajhIYZgG295eVUUmFIO2cRYF2HuPie2holbADi1pOowTrz
	 aYkpjxZFDHD6oqZR4EipDFn/nSacwXVfHKzFTWWxRlNUu3eyUrP0RU8iz/lmYHmiCevMV
	 6AMo3cCzf6U2HrmSi1JeCF6MaTSz6I+oyJAG+OpvTTEgoQ8oCdJcFUjysM30bomchKOwS
	 BGtAf0F1KsqhlvHPrIZC3Q62FCa2ukGzDyESXlYGA9Qq21baDmfNj0NeTNnHyJBdYsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793150521;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=4cR+Jnw2vZTLedug2NT9bT/PNYuUzdhU9pnjK8Gk3b4=;
	b=cIqUTMbNPUV7prtSTYFMa4LzGvB9WQIK8BgwAcyKdYyE2U3yLWCZoL4eFS/k7WR7dxq+
	 Fyrh/NHmvdyHL4JPVCnwpTFNfIrSaEuOeXVOAr9x6KELC0TnhtOzqJQ3AP5C+XkzP4AKY
	 O1D8t/5QLqOqoyan/oEBhXKzYC+4QRTu4hlrWAreDX2sdZlxfDjc/0gFBuYTZMLErTqy8
	 b87dD3rwrOn53clYt+UhtVpbp9g40fA5cii2IAK7LOtrbU9oEOCYkcTXJPtGMj0Vy0fzx
	 D/RwTR7vkN65s0/E5rKdZ4MokuHEH8sQvPDitId+nNjzCTg+8nYq9lqiV3ci++D5ZKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=themaw.net;
	spf=pass smtp.mailfrom=themaw.net;
	dkim=temperror header.d=themaw.net header.i=@themaw.net header.a=rsa-sha256 header.s=fm1 header.b=IuANCG5d;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ASgV40z7;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00400606A31E
	for <autofs@vger.kernel.org>; Wed, 28 Oct 2026 01:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00400606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=themaw.net header.i=@themaw.net header.a=rsa-sha256 header.s=fm1 header.b=IuANCG5d;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ASgV40z7
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 0DB13EC01BF
	for <autofs@vger.kernel.org>; Tue, 27 Oct 2026 21:21:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 27 Oct 2026 21:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793150518;
	 x=1793236918; bh=4cR+Jnw2vZTLedug2NT9bT/PNYuUzdhU9pnjK8Gk3b4=; b=
	IuANCG5dx2AuLSzGWT1IlW0LpNdHwVHudaxvydOEnc3KSoJ/qoMeuRTBcuHevylW
	xUbQw+3IqU+mSDopyXhKpLMSyZdaIQYBWsp91BtQLJ6ivce7R1cuF7LYQVlluKOM
	55TmLfhzJ/XgFzpWKbku9XBEEHXvbqRJ5vOSHONPiAFeVL8JucBr1JOA/VFwvjKS
	w11r6SsVd0monzWXTSSRu9aCd1MnbVsYTMZQxq4e7JYEQg0XE3VlNJOsuLd4+Ahu
	M2i0unzEJI77CglJFd3yELGpyxcNPO6lBajkV1sZOKnC3Pk/qgxAH53X7FyqVsbo
	jkTWgUXOP8IFrAx0YIZ2Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793150518; x=
	1793236918; bh=4cR+Jnw2vZTLedug2NT9bT/PNYuUzdhU9pnjK8Gk3b4=; b=A
	SgV40z7r6xfOgnty139gvV4mch5EP3LpzWKZnR0DqUM4+khkf+60HFQqKimBZ41O
	GpWenOjpJF06vWXJx6ne53P/sdpYna3Yh9kYveLMWrgn873gdVS2BPYroWQPhcxQ
	j8FQ/TYUcJyq1VEohzGMzcv/D5F9bKLVFzIGeGnwytFhspGcAad8f7oc6bXYjpg3
	1KZoPk5Y3HhjR0aN8sdnG6UAFbI98LFbZxfR31UoaDOWQ8AvKGLa+kRa/mXHpIUp
	RiAUDg4gSiO+zFjhCN9FDe+hrXJ9Cgl3iBmIcbzWpOWfT+LuuadMSvQcN3RGDqus
	BADMJIzTu3vtT/xhem48w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=themaw.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793150518; d=themaw.net;
	mf=PHJhdmVuQHRoZW1hdy5uZXQ+;
	rt=PGF1dG9mc0B2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:XUF2QqTvb5HEBoWUySZYnIhUWVh2097h0iduENHBPSPCAVn
	KFsXU0z3cM8Yh6YW6bpv1SRmpY/crlqjvIgZPbbr2p7zUI7hUQHjatGUeuKWmPwN
	f+ZV+l4RwUXoib/QEnWld5PvnHXlwPmnSYIayHkOqp3CNS0T8l3mju8GzilGkPHB
	kPyBr6v+TXffwuDxaIEc0gO3IrpWUEhnjwlg6u0Ymj+Z4Zl8BrGeJb6pmceA7suj
	C+jeH+4eRfZLWPuWS3lKAVGIxvhEdEmWnmZpT8way7tGLpBni5R6EWWZXCOXecdN
	TqY6e5Kh5V6O1VkiIOdcILW3R5h+YQ6PkIj2PWg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:bLZaW/+c77h1LhtpnAtMkoSIjWiZ2pBNMO0v3iO12fE=:4cR+Jnw2vZTLedug2NT9bT/PNYuUzdhU9pnjK8Gk3b4=;
X-ME-Sender: <xms:NU7havTQm7CONmk_vTIxyQr2bggizao4KrnCTHOZ-DkioGzPn_0_Cg>
    <xme:NU7hanuN5n0amtHDXTfCLVNahO5-mo9vXcMLvteA_LdixJ2JqjfE2OXpSqZAoRDw9
    9zB2o5kCwdI5nC3rzACzyLVfBUMdUUkzLm9ZMp9wz4XqggaUQ>
X-ME-Received: <xmr:NU7hap4Rmoc1y1NiVdhky5AhS2soreP5Mn4L00ThsQUenIhtq7rJNcu1pb49HmmEVaVYZMSVJiGWZtrqfBzV2zNcfOaCUTc66JS2LcokcUPuk2veGHDtkWAnPBE>
X-ME-Proxy-Cause: dmFkZTExjEu5Z4ShUEEPbIUBi9jvlntQl3xywqhol0VilT1H3riwx+R5F5xJP13Eevy37Q
    0i2tM3JNLjjIE4RnafdrKckgTZgF7WVXIi2BOm3qqKixBS/Irug73Tiau0YR/vN5tre4hn
    maQ7bdbQdERoqsBHTuky/6kPN1uRRdMEQp7qfaGblPSG+4EBzlUBu4KVifRQGZl+JiSvgw
    9mSbn8dIqXi2WXNiWFaTJHHZ4Jih2f4J8Zf8XQJs9Or+djBfP7qo+n/CcBwnndgEEsWDvn
    dde2XKLK1ANi3gu15BOxuI5tGRXcf4I/n59a/Jk8KMuRhC+UWXSiv/46euNQ6JSTIIAimv
    7jcAW/tdVBGXJXklC1RRPUglHq4hH5Bc64PIl28tFEzC6NIzPjSltWekhutJo/tT2majGT
    sswf9kF/mQ7bfD6GGD2BLOWWsUXcYZgnu4j4D7tHPb/zynsKGK6m+AhMOPYjmUzMOzh5dT
    b4rWxbMHiL5nnjAdO5ldN4zD++TlD1rdyXqAHwBHPTOIS8FN/SKiiEb38SpBdbZorRtZ3g
    6HKFrjuDJITZTWSsi/aiCUAXSktyenMIc8kN6yeNsZHz8HdWRAJlXYnV78lUl5wNp4dJzJ
    K2wtUluCHNuU9Ak5O20DPSdgweZAMliMgfRfP/R4THeQWT2Cq5n/XeaklCLw
X-ME-Proxy: <xmx:NU7hamKsy46mFaILnzutP5LNXCeEcEkH7ASldNGwyMSr1vsmEA_XLQ>
    <xmx:NU7hajRmT8qLJPv58aR7XoaIN4e0ZQloPg1Re3nCph4Fgy5gL4tmng>
    <xmx:NU7hapoTY0a-MqM5sQVzrhTvHncNfTKm3VeNlXgeqpDve-iSMPWQrg>
    <xmx:NU7hahb9D81m8XEdG4qqwPK-ysKtigp5k8VzEshrenjpsUJ67MPPlQ>
    <xmx:Nk7hairIFIEEI4qphXaATaK3ls9tH3EoMbCthRQcYtN9uyTpEesD-K0G>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 21:21:52 -0400 (EDT)
Message-ID: <5de6de037706e45ba88939e8f36e7dae48005e6c.camel@themaw.net>
Subject: Re: [PATCH 0/2] kernfs, autofs: fix pipe lock cycles through sysfs
 stores
From: Ian Kent <raven@themaw.net>
To: Krystian Kaniewski <krystianmkaniewski@gmail.com>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>
Cc: Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich	 <dakr@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner	 <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>,  Peter Zijlstra
 <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Jens
 Axboe <axboe@kernel.dk>, 	driver-core@lists.linux.dev,
 autofs@vger.kernel.org, 	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, 
	syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Date: Wed, 28 Oct 2026 09:21:48 +0800
In-Reply-To: <083c2bb0-85b6-480e-afcb-bd2f386f2ddd@gmail.com>
References: <6aa23178.f81106d8.2ab401.0006.GAE@google.com>
	 <cover.1792577179.git.krystianmkaniewski@gmail.com>
	 <dc65c28e408d6b64d4b13b7ad30e5fe70ddaa441.camel@themaw.net>
	 <4f56c93a9fc5fee152364974773df0a319c84af9.camel@themaw.net>
	 <083c2bb0-85b6-480e-afcb-bd2f386f2ddd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44app2) 
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Post: <mailto:autofs@vger.kernel.org>
List-Help: <mailto:autofs+help@vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:autofs+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-10-27 at 01:57 +0100, Krystian Kaniewski wrote:
> Hi Ian,
>=20
Thanks for replying, ;)

> On Tue, 2026-10-27 at 07:11 +0800, Ian Kent wrote:
> > Commit 1e8c813b083c ("PM: hibernate: don't use early_lookup_bdev
> > in resume_store") looks like it's been around for a while so I
> > assume the reproducer should work on 7.2.12?
>=20
> Yes. That commit entered v6.5-rc1, so 7.2.12 contains the relevant
> code.
>=20
> I used the unmodified C reproducer linked from the syzbot report:
>=20
> https://syzkaller.appspot.com/text?tag=3DReproC&x=3D11c0f4c9580000
>=20
> I also used the configuration provided with the report:
>=20
> https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3D7d012d9c67977ee=
4
>=20
> > What should I expect, a hang, it doesn't.
>=20
> A permanent hang is not expected. The result to look for is this
> lockdep warning in dmesg:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARNING: possible circular loc=
king dependency detected
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &pipe->mutex --> &of->mutex --=
> &sbi->pipe_mutex
>=20
> The reproducer records the first dependency by splicing into the
> cgroup v1 devices.deny file. It records the opposite dependencies
> through a normal write to /sys/power/resume. These operations use
> different lock instances, so the exact reproducer reports a possible
> cycle rather than deadlocking.
>=20
> The write waits for an autofs daemon that never replies, but the C
> wrapper kills the blocked child after five seconds and starts another
> iteration. In my test the warning appeared in the first iteration.
>=20
> The test needs lockdep and CONFIG_PROVE_LOCKING, the cgroup v1
> devices
> controller, autofs, and working hibernation support. It must also run
> as root. Without lockdep, the program can appear to do nothing
> useful.

Ok, I'll check on those, not sure about hibernation support in my
VM ...

>=20
> > Also it looks to me like the reproducer is trying exploit an
> > invalid request similar to what I described earlier
>=20
> Whether the string identifies a usable resume device is separate from
> the autofs request. resume_store() first passes it to lookup_bdev(),
> which performs a pathname lookup before the numeric fallback.
>=20
> The reproducer changes its current directory to the root of a
> detached
> indirect autofs mount. It then opens /sys/power/resume using an
> absolute path and writes the relative name
> "0x0000000004000921".
>=20
> The resulting lookup is therefore:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <autofs root>/0x00000000040009=
21
>=20
> For autofs, this is an ordinary lookup of a new immediate child of
> the
> indirect mount root, so it is a normal mount trigger. There is no
> autofs mount under /sys/power.

Right, enabling the autofs pr-debug logging and looking at the
reproducer verified the exection flow for me. I didn't see a
lockdep splat but my environment is probably not quite right.
I'll check what I can and see if I can reproduce.

>=20
> In parallel, I am preparing a revised patch following Tejun's
> suggestion. It disables splice for writable opens of
> /sys/power/resume and gives its of->mutex a separate lockdep class.
>=20
> If you send your autofs change, I can run the same reproducer against
> it and check both the request and the lockdep warning.
>=20
> Thanks,
> Krystian
