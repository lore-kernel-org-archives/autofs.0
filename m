Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793056308;
	b=C9Wjtx4w+KQ/kdWcma549v5qE+27h7OhEgBRuoe/2twqZfgWV3sBlpGD3SJpI4Qoch1G
	 B5Ul5lko5Dfu6uJ9Uv6dJvj812jJ0AH2bc5xwq4ux1iPZrLFRhhNgQ5nzoLO3ZhPmolUJ
	 JtlcYIs+iyu6CrTqok9VP6zUg5inj+JU1AXV1YoUdEGtis0bsWiCftIoGyx7EIvfRWbvL
	 K7SPuziTfzPFutcyPqOXW3RppXyoHlKEbal58fA2S61f68nty9dF7IpOrofK+1pNgUP3f
	 G5PsZEkYI4ncfiwY+3Xgoe07NaoMZL/jO0bgzsJVuwrmxvhdvyRGjNX+jLbm8OXFJ8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793056308;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=dvML+/R4qQbTxhU2z6PfyaJFwg8cDUrAEKJw4xPVIt0=;
	b=pFDl989Y5X/EV9RQm5AjUzkcf6oQbYF2NdKMc55X+U2BKCz9BjE5QtCmtsmU0SGPFEfi
	 fjUarmvx40L1fYEGQRgngA2LLBY7KsmmsE+ZplOmhxuS2802dE9lYVLNcDNwqEpN3c87N
	 y/zwLNXiCwGxC4DXlDqTsU2Zw5QLEv1mOb9n/03Y7EL+N0Ozr+nSIZW/4g2MmgXQMz5DE
	 ZaAudCbqaUx52NSiaitURMJudIBorjViqc65denM9fmyyqAYT5djBkQ1rKDhuLWg6T0ei
	 WTc+s8ukSpVwsJxMPwp5/0DTOy0BwfCEPPZwKyU4+3/5WJQI2RWnEyTS7TeXpZN1/Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=themaw.net;
	spf=pass smtp.mailfrom=themaw.net;
	dkim=pass header.d=themaw.net header.i=@themaw.net header.a=rsa-sha256 header.s=fm1 header.b=eF47GSn9;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=n8Dv85jI;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15994606A31A
	for <autofs@vger.kernel.org>; Mon, 26 Oct 2026 23:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15994606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=themaw.net header.i=@themaw.net header.a=rsa-sha256 header.s=fm1 header.b=eF47GSn9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=n8Dv85jI
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 688B81D0040D
	for <autofs@vger.kernel.org>; Mon, 26 Oct 2026 19:11:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 26 Oct 2026 19:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793056305;
	 x=1793142705; bh=dvML+/R4qQbTxhU2z6PfyaJFwg8cDUrAEKJw4xPVIt0=; b=
	eF47GSn9FIOirROKVFcXBmktSKnI31tpcGER4Q9xGqhk39aCWQfoZa3Lm7CACJYw
	fVHcnPwYX2ma0tfoOMkmLYMRzYcAoNxr+pNmWMouR4bYMWO9oqDwyn283q9XpWJ6
	4MNKxnJKzbEDUkilxZXsp1VXYkgjE4IjdYT/uyA4FSWOo96tWJtdZyihCUZys3hK
	2QDeL3Uhdyu7d4ZAsewtPPXCpXcEIdpeHNcnTKBr5P7owpj1DZkLUfKn7lnZB4Rf
	ZicwkQJ7zMGYvvA4VDdMwVobSkSHhRIHM9BZlBAGW1hjIz1Tor4ZB19pTxajuQLa
	47YbAXhNaWBieUr1bTo8ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793056305; x=
	1793142705; bh=dvML+/R4qQbTxhU2z6PfyaJFwg8cDUrAEKJw4xPVIt0=; b=n
	8Dv85jI+8C/MNhFNCCIXYqCcshAF8dbb9g/N0GwJRSFhwYCD+zXrCBBsURU3bTSk
	8jlrC1pX8a68+fxFVH0CWRNoBSjs8JOKpk1xWAXPHEb5naBjxJIZI4kVX1GJoYeX
	IxgGlH0agkPMHbpGKXeFzLkzdFu8O4pckeySBCMTR8H6mu2Y4gnBELiKh07d1nYx
	Ryw5XfJMpIuQVQfizYzQbKQqLIY3gUmTHeWl74FcYc7mIqmY+3rNyLieXBuWm6Dw
	5d251R+UHyuWseBz5NtjXxPa8UXJiXiiVnkfbqpphxx3aTvhK4smWyXPcfAFqrm6
	EdRcHt9nU0LfHQxRC2zAw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=themaw.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793056305; d=themaw.net;
	mf=PHJhdmVuQHRoZW1hdy5uZXQ+;
	rt=PGF1dG9mc0B2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:AZcAZsusGVSwrZLXoBRK9Q1YptNnsceL0N3rsfRorQTd+Ta
	+4FQN2ByI2TrqQDrLtIS5SQiHP+d3vnpBViTcATfqtxQStCmhfiUJmvNDhmVs2TC
	VnnPtLJeu5brIM4ouIqQvvG6gwk2oFfUYKt3FyFg5L7b7r0NBIq/mVMJVHsPXVs9
	M+cPFPTO2/tMHu9asUyJTBPM/MtwqXey3VDAyKJd9RsclNKDzAUX2ONbZ/9L6KjA
	DvFTvuvmbXnJP/rptka8Av+RApaDsWgzXcdw7Keh2wLrVEqr70ytzF8ROUY39K2T
	euGtGHWnJ0AHiWfxj7sEPwtUbtDQjHEa1SkWwwA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:vPusySQWVNzJFF54CdHHDfiPLt7mpt6sO2TlTCCEQWI=:dvML+/R4qQbTxhU2z6PfyaJFwg8cDUrAEKJw4xPVIt0=;
X-ME-Sender: <xms:MN7fagMmxjqXRUL9aqo6FPAmYSgnud9gkzoDPwcZyYx6L6C4U0X2Ng>
    <xme:MN7fat4-LMa6NTmzFI3l_ucCq-9QCy9WAgqm9KF0q1MtPcamV2J2q7fiCmWYDHDhN
    xDis-1IXreWyODvEAKvpiLeyxzt-xzqNlovPKQoV35HMhnI>
X-ME-Received: <xmr:MN7fasWK6Ut_3eAGiLn98SEo8l_L8nO_K1LpvsziKTeuNJAhMgcxEV1argJv9YhJrTZ6PmLhAzc9UqLrs_IUAYtxd1dTfjQ8uy0ggQ1NXFsX6qFFKwHoG9gpdxI>
X-ME-Proxy-Cause: dmFkZTEyzjjaeQZJI/HSd3tpXSqYi01yU3P3/gK5SMN8wdEOWguYY1wXiE1GG6AojV+QZn
    Rrd8nivv5YeCrOrqBgj9sZ6l7GKzSUoNcbhot48nAQcX6YMBwJLeRLJ4VkXadZFqyn07ur
    D1aOfKyqkboA+Ewom2Ofk/Nj8VjAohFzhpDY/z5kDx9YPFVYvkz6kOssnxzL1PL/K63CX3
    e4JAWbp5m8M+8yTCemGdtASRGGm5koyhSvgfTarM2LSLutLrM7kZ6nJhhe6uO17RCILbvp
    CYu1T0dF1FXTF+J4vT72krSyimQh/BjxPUMLaVaS55ARGYeANDrleXwwXWliq4KhS26/hj
    kyK4x8Ih3ZqS+refPXHiSfHJRqyv6h5huOtmYa6DxgvQ8tZix32SxngBS5UAnfAgg4aFei
    qiyJ/RYrf40f3iwCK3ypCEJHC+OJVRcrpygmffiY3epFoK3ixNQqcVhqC56sjf9HWKpau5
    OF49zxfozS/+m7Xv2M4/Epvq4Dl8cggFLk9hBvzqd5Uw2FMSU3kDL2l/CQxBYdpDoNlx99
    0s+P7E+sr2dUQb2wjKmmkK9uvhgpo1D0iiknUP2sf2/vSAfpN+0/fNa3GO/YomQEo/bcNs
    OiHdHE86XF6h+0S6s2YYoWYkdxAl9JGAjcBnC9XeBOadE9JUdGIQgKyP2J8Q
X-ME-Proxy: <xmx:MN7fav1Lbw2OGyNFnSzlwfOk_8bW3ADI9pxz9x0XLO-PSiZSi9dlxQ>
    <xmx:MN7fajOdQ0SE8DAEIVKT845WJJKd6W3exuyaL-mCVCu6FEXJpCJ6gg>
    <xmx:MN7fai2Y23G0x_9cCtqafEcrIMxHLZ8_IecYpOW_PW5WOpNH2v5KAQ>
    <xmx:MN7faq2BAEidWJUisI6-nzczcPB96Z9UFwXHjor8z9esYIiVudKDWw>
    <xmx:Md7farpABo2w_IxuVO7e3DOz0_2mHDyGyGv7yWm14tpkkdHKxW5DxoYq>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 19:11:38 -0400 (EDT)
Message-ID: <4f56c93a9fc5fee152364974773df0a319c84af9.camel@themaw.net>
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
Date: Tue, 27 Oct 2026 07:11:35 +0800
In-Reply-To: <dc65c28e408d6b64d4b13b7ad30e5fe70ddaa441.camel@themaw.net>
References: <6aa23178.f81106d8.2ab401.0006.GAE@google.com>
		 <cover.1792577179.git.krystianmkaniewski@gmail.com>
	 <dc65c28e408d6b64d4b13b7ad30e5fe70ddaa441.camel@themaw.net>
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

On Tue, 2026-10-27 at 06:07 +0800, Ian Kent wrote:
> On Wed, 2026-10-21 at 14:51 +0200, Krystian Kaniewski wrote:
> > syzbot reports a lockdep cycle &pipe->mutex --> &of->mutex -->
> > &sbi->pipe_mutex. splice holds a pipe mutex while it calls the
> > write
> > or
> > read handler of a kernfs file, kernfs takes of->mutex there, and a
> > write
> > to /sys/power/resume looks up a path that can make autofs write a
> > request
> > into its daemon pipe and wait for the daemon.
> >=20
> > Patch 1 stops holding of->mutex around the ->store() callback of
> > regular
> > sysfs attributes, which do not get the open file and already run
> > concurrently for separate opens.
> >=20
> > Patch 2 handles the case that patch 1 leaves. A store called from
> > splice
> > still runs with the pipe locked. autofs no longer sends or waits
> > for
> > a
> > request in that context and returns -EAGAIN instead. A new mount is
> > refused before it is marked pending, so no other lookup sends the
> > request
> > in its place. This also removes a deadlock in which the spliced
> > pipe
> > is
> > the autofs daemon pipe itself.
> >=20
> > Patch 2 changes behavior for one narrow case. A lookup from a
> > splice
> > callback that needs an automount fails with -EAGAIN instead of
> > waiting.
> >=20
> > The series was tested in QEMU with lockdep using the original C and
> > syz
> > reproducers and focused splice and autofs cases. The target reports
> > were
> > not reproduced with the series applied, and the paired functional
> > cases
> > matched the unpatched baseline.
> I can't seem to find a reproducer that reproduces the bug or maybe
> I don't know what to expect from running the syzbot reproducer I
> did locate.

I think I have found the appropriate reproducer, certainly looks
like it.

Commit 1e8c813b083c ("PM: hibernate: don't use early_lookup_bdev
in resume_store") looks like it's been around for a while so I
assume the reproducer should work on 7.2.12?

What should I expect, a hang, it doesn't.

Also it looks to me like the reproducer is trying exploit an
invalid request similar to what I described earlier but I can't
test to see if my simple autofs resolution fixes it if I don't
know what to expect from the reproducer.

Ian
>=20
> Can anyone help please.
>=20
> Ian
> >=20
> > Krystian Kaniewski (2):
> > =C2=A0 kernfs: do not hold of->mutex across sysfs ->store()
> > =C2=A0 autofs: do not wait for the daemon while splice holds a pipe
> >=20
> > =C2=A0fs/autofs/expire.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++++
> > =C2=A0fs/autofs/root.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 28 +++++++=
++++++++++++++--
> > =C2=A0fs/kernfs/file.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 52 +++++++=
++++++++++++++++++++-----------
> > --
> > --
> > =C2=A0fs/splice.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 13 ++++++++++-
> > =C2=A0fs/sysfs/file.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 18 ++=
++++++++++++-
> > =C2=A0include/linux/kernfs.h | 11 +++++++++
> > =C2=A0include/linux/sched.h=C2=A0 |=C2=A0 2 ++
> > =C2=A0kernel/fork.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 1 +
> > =C2=A08 files changed, 109 insertions(+), 22 deletions(-)
> >=20
> >=20
> > base-commit: 93f51579e7df248780214094418f205253383cc5
