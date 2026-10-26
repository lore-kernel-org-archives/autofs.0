Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793052493;
	b=xUb/GWPqyXiK3XmXMVYaJ6H5hA/v1OiGLsBSkYDdsRqncPq7nPlqkQ+QDXFS1k0vb1+6
	 sZPEyz+Ql82jQzO2LzFdQstX8FJqshWLTGMiA9iUKMi66rzK8ySb78z1j0p3kMOMRk+We
	 6IUMsCqLQOa4I4GNeIG9DbYUOZmBD5vpZfAvRMi5Qt8oXa8i3z9jP7yc7ZkvGVD8darf+
	 e8DXUiXlwpNGbmLvL61z6sCVlskge+LEa2KgRdo+uChwDKTTRgHImIfbsSwxiCxjhF71k
	 AUKMHxIvfd6cb92JZ0b20C04CQva1lJ3hfZyjlpk3pFoVFQjORheuqPACzXwWcCecSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793052493;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=yw8gJOW94fTkjKACtcjzfr/YsSITaXsnUbgsLWBosFE=;
	b=Pm4NLOPBtsWX7ZMX+40OOFteQuXIPGwU/dyyO6sYmHlQbusbDKdm8ADJ94/s1OOvF/Mu
	 nFRh6XRzfl+g9qW4K24Y5/oStj1UpDoDBxnZQej9uVYHdTUkS/I2KNN15VbayfYaSO5dv
	 N16t2o2ymZ0amu5j2VSlSB7V5saN11o8Y7rYUOxp0zfbJuNaCWdzGrHzPqSs3nAnKxOww
	 rVVFm/7y6+jeTD56M81R1kOdJ8T5g/y9wW3Huwq/KBcfP8iw4MnUyHq0HwcfjudtbUpN1
	 8O2/X5yUhEZL4vrxTn1n2rRGnDdGhZJb9rBZ+AHT6zmS6qKz7ChR28SIn+hXfJwBzsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=themaw.net;
	spf=pass smtp.mailfrom=themaw.net;
	dkim=pass header.d=themaw.net header.i=@themaw.net header.a=rsa-sha256 header.s=fm1 header.b=UrEV8CO1;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=avGk9PqI;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0162D606A31D
	for <autofs@vger.kernel.org>; Mon, 26 Oct 2026 22:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0162D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=themaw.net header.i=@themaw.net header.a=rsa-sha256 header.s=fm1 header.b=UrEV8CO1;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=avGk9PqI
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 67F6A1D003CE
	for <autofs@vger.kernel.org>; Mon, 26 Oct 2026 18:08:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 26 Oct 2026 18:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793052490;
	 x=1793138890; bh=yw8gJOW94fTkjKACtcjzfr/YsSITaXsnUbgsLWBosFE=; b=
	UrEV8CO1TUZnK8PJPLQEQ+mBDacfr1ualCI79fofyFxHp/qlH67Qk1zDha6ZDsUD
	FAJJYbbVRZH706lqEQ1NMx+s1EL71CQ+qJsAggeKG0vqBj/xL0+g9/cQe3EmmVdf
	OBP9oeiZdtOdhVjy/9V65hXNxM/X0M6KX3SXFOfk0nMcUaC4TuW9Lzuv2ZezXmX2
	Xm4f4UvRS5LSth3SslZmRV6M1ryJPxSBz8w0BPf9Iigy7LFomt5f2d4ANnD3HKLz
	lcSjcD+UjlJRdGQsr5RE78TsLBdHTwyWipS6UmHptFiSmVIO1/Q2QG9HEyR7jwi2
	EYnYOOJt/YEUKLEp9QlmYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793052490; x=
	1793138890; bh=yw8gJOW94fTkjKACtcjzfr/YsSITaXsnUbgsLWBosFE=; b=a
	vGk9PqIr6hEzkBG77k8GkpXeSQRT+MVDN4DUxSMcA1igxPIR/+ga1iuhPR87rrch
	o39J5JLbaroJv+WocVTRVwIurwoXClx0UWuccJ+RgdT0YRqkRq3PW3yzZKClbwX5
	3PZHhRjN82XGlHlJbp/bOyza6RhwVbJRIEDqU5PO7X908wlAZXc7i09ujPK/uSwP
	maqeWiARyT+wYltmETV8RrnGseapHSWp99e0Cf5kBm0Whh7W7jcTP1gtIbhSpiyR
	0u/vnbhHjLT8RNpOZZfIxnpiwmL5vNgnvKvxOb8zxwiBvIQ76xAQd8Rnn2fR98xe
	yIS/MWt0ERu5CwEw/HwWw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=themaw.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793052490; d=themaw.net;
	mf=PHJhdmVuQHRoZW1hdy5uZXQ+;
	rt=PGF1dG9mc0B2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:dj9y4hs/LXUbKNa5bc/9zmZlUPWw11gBePm4XPKBrTwBW0E
	Vt5Q1g6Uyd7ZslKXXA/JqkbkbBKfEIrkILxnUzdwY5RKJNQLxYb88FwSvfDf+SsE
	9PLSqV1eAp9mmqwmhfL1JBcXQT0ce+MJ/IQk+885xK5s4fSwgoqOzgq4k8MVwXNX
	n+ENMM3Y3z9OdFTgOInws3UNYwNyWun0ELWyKjOAG0r+54ptfBTfvands41K/tB1
	WsHiNfmFq5YoBFKzgqDODB8LVBT4KON+P/GMDyjYn6kW+fzAWdP4YaqqpjmNI3ha
	Z3enTGXQh5QAqXx4R87C1VtF5JkNIK3KMsBswmQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:tdg6ua8/hQS/iYkk+8+1oIbT4XjyplM8CQ3hPjDL8gU=:yw8gJOW94fTkjKACtcjzfr/YsSITaXsnUbgsLWBosFE=;
X-ME-Sender: <xms:SM_falmJYKjuMXVHDQt2QQt2e9GRe6P_ZlHx9B0jy3DtnwU-Mhwilw>
    <xme:SM_fanzOb00shgf6BVLGTvm3wWAEqDvLNbmTrEUBM6t2vXp1Jn27RhxW-QSd6_ZcG
    FynuGh_Zd1AH-3TXIyVt0MGvELm2hQ0AdlawiG__NQvzM1M>
X-ME-Received: <xmr:SM_fagulXQAxGdh47J-3Sc9EZB76wUhrIZV1bSoHJVRcNT9CV3-XLvoY5_ae3ExFkPIKFqbwCSLPkds1UqaKAorpiepGRidZUelVzfY9gax3aZgg4D9bQFfcjNM>
X-ME-Proxy-Cause: dmFkZTF5HCOsxN9EPzsQKkgStD/Ff4WaJ8kNbHpSExIutymQMzNLPQM/4D7eFPnNuRZhMM
    yiFZU29YFLK097HXfiVZtxDexZrGtWPk8oIS0KHK9LJ+COj6lx72D3NGicQiveM66XsuuI
    T5hdMIkNOs99rmLKIhonQkKb4GS6BpcgwfRht1cF14LSexGc7Vuh+dOSrMRFPPDR2vDdp+
    I2Kj5kQbVl3rdYwlSzYKD6Ljbc/jI3yCouc8I227ttT1dc69wA3DVKDYh6Dxx4CnJAsGMx
    dRdBm2OsEUCbGYBG+rLKXIe7ZjFMsj4ic7Jo/KwKEtc8FlEvgmpa4M2QKds/GCXUxeH3mV
    hlatiPuA1PlYXizqCztg6HNVhQRmacIaSHc8Qwq2Br5SvRSQdKCk92iWVbYNmY5u7sdCPv
    eI9FmIM1vtGGAJVQBqh7+2hzdk6ENCtM8BtYfw4MCq8+yiVA4HOqdWvKKVC2aMSUyYSNNs
    GjuuWW6QfDWQPLpxyjyyRbSKdpIIyL3Tg4q94xEIkUtYDseeq5zvDy0TxIe/8uq6trsyvq
    12FxalXYe67wUyQOKOMK+vxsxR9oRudyupWfujyodN+jFjBk8gVG3TaBeGM0J1IM+Kt/YQ
    9kpaZYdH824878CQeB9Hov1Tbl+TNTcopCEAWeu9r3TVYfVORKt387XTeRNw
X-ME-Proxy: <xmx:SM_fastfAR-nbfD779bC72wWAQSNDoTOifg7ia6nkQp1Uu6Wl9JC8w>
    <xmx:SM_faukfKeNv0QfbzQ1Mdz-dRnCEs-2QfPbeNcc7818FyLAicMNf6g>
    <xmx:SM_faqvDy6DYaKkRzWH01Rnp9FtgDFJd7PuUy91kFsJxUMfQVADTGw>
    <xmx:SM_falM6fmdy7zX8HjhUCgmquQTDw-Dbj4SPd2ytgaZzwcTjJj6Log>
    <xmx:Ss_fas8XLcMNaCaKXBRNJwdR2hfN8SrYNk_YE7dtRdyQgT0KrlyGPJI4>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 18:08:03 -0400 (EDT)
Message-ID: <dc65c28e408d6b64d4b13b7ad30e5fe70ddaa441.camel@themaw.net>
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
Date: Tue, 27 Oct 2026 06:07:59 +0800
In-Reply-To: <cover.1792577179.git.krystianmkaniewski@gmail.com>
References: <6aa23178.f81106d8.2ab401.0006.GAE@google.com>
	 <cover.1792577179.git.krystianmkaniewski@gmail.com>
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

On Wed, 2026-10-21 at 14:51 +0200, Krystian Kaniewski wrote:
> syzbot reports a lockdep cycle &pipe->mutex --> &of->mutex -->
> &sbi->pipe_mutex. splice holds a pipe mutex while it calls the write
> or
> read handler of a kernfs file, kernfs takes of->mutex there, and a
> write
> to /sys/power/resume looks up a path that can make autofs write a
> request
> into its daemon pipe and wait for the daemon.
>=20
> Patch 1 stops holding of->mutex around the ->store() callback of
> regular
> sysfs attributes, which do not get the open file and already run
> concurrently for separate opens.
>=20
> Patch 2 handles the case that patch 1 leaves. A store called from
> splice
> still runs with the pipe locked. autofs no longer sends or waits for
> a
> request in that context and returns -EAGAIN instead. A new mount is
> refused before it is marked pending, so no other lookup sends the
> request
> in its place. This also removes a deadlock in which the spliced pipe
> is
> the autofs daemon pipe itself.
>=20
> Patch 2 changes behavior for one narrow case. A lookup from a splice
> callback that needs an automount fails with -EAGAIN instead of
> waiting.
>=20
> The series was tested in QEMU with lockdep using the original C and
> syz
> reproducers and focused splice and autofs cases. The target reports
> were
> not reproduced with the series applied, and the paired functional
> cases
> matched the unpatched baseline.
I can't seem to find a reproducer that reproduces the bug or maybe
I don't know what to expect from running the syzbot reproducer I
did locate.

Can anyone help please.

Ian
>=20
> Krystian Kaniewski (2):
> =C2=A0 kernfs: do not hold of->mutex across sysfs ->store()
> =C2=A0 autofs: do not wait for the daemon while splice holds a pipe
>=20
> =C2=A0fs/autofs/expire.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++++
> =C2=A0fs/autofs/root.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 28 +++++++++=
++++++++++++--
> =C2=A0fs/kernfs/file.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 52 +++++++++=
++++++++++++++++++-------------
> --
> =C2=A0fs/splice.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 13 ++++++++++-
> =C2=A0fs/sysfs/file.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 18 ++++=
++++++++++-
> =C2=A0include/linux/kernfs.h | 11 +++++++++
> =C2=A0include/linux/sched.h=C2=A0 |=C2=A0 2 ++
> =C2=A0kernel/fork.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 1 +
> =C2=A08 files changed, 109 insertions(+), 22 deletions(-)
>=20
>=20
> base-commit: 93f51579e7df248780214094418f205253383cc5
