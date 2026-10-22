Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792637207;
	b=rjI6TxSHQj66AmDdcX+/EH+jSYPzfioq5BqZEaWU4vSKevs7vOoEOJBTUpGO0Kf6nQ05
	 MKD5GyXXQjYdt0ZO6PEwMoiLvOD+Xuqc1PGuNQC9aA2uwYxh2FumvszWChAtxR6/0UQOQ
	 enYxFl99jOy2KcoKk6mC+35d0wopLVQR1gOdyKy1A0XKOAn8wefCEAV3P5cpoLjsYLw2g
	 t5IU9BM74FO5iV8UiL9QWgJMWWvblL2lx7e88ra91g4og83UVuUlsdVBx+Y7CRpaOsKcu
	 d3QLlAHhvW2IBviIte05QIsQpiGmGeDwV/RhKksQWPqe+AOsAtE/dMUjx3OPHZh63lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792637207;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=b8JrLeZmohBXZxoZ8hIHhxCw9MvjJJNFtjwd/KPNiN4=;
	b=L9+r38WkV7suM9NmnpHc/zosjbxk912AqwY4z8lfPr5cBI4iv4BOAWJLPOaBsxj3TpjY
	 pJRvuN5dkMaAFnJMG7zNOxCiekZBFMJCRyiE1neUnHBIS0CwpTqQtA3O45juOPbUPv054
	 hV8VmLHwXNpBmP7y6TdhnSTq6pj/ImZ+9g4AW3tuJVnf4LY0IQTjz8zQ9iS78mUxYpchT
	 1/ilJCESilAqKP/uajSnI+M1QDPoowF85/amX+30jYk5Tn6NjQRVO0e02pajTAdBfqmOz
	 NUoyCijynRytuhj4rkg/nCViuTY7scBfm4DYbOTCzVCeoXWbbFcS2Q8NlElHnWEoMaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=themaw.net;
	spf=pass smtp.mailfrom=themaw.net;
	dkim=pass header.d=themaw.net header.i=@themaw.net header.a=rsa-sha256 header.s=fm1 header.b=SlzWuXRT;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=vcwJoROo;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8727606A31A
	for <autofs@vger.kernel.org>; Thu, 22 Oct 2026 02:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8727606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=themaw.net header.i=@themaw.net header.a=rsa-sha256 header.s=fm1 header.b=SlzWuXRT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=vcwJoROo
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D4BC814001C7
	for <autofs@vger.kernel.org>; Wed, 21 Oct 2026 22:46:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 21 Oct 2026 22:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792637200;
	 x=1792723600; bh=b8JrLeZmohBXZxoZ8hIHhxCw9MvjJJNFtjwd/KPNiN4=; b=
	SlzWuXRTtBF2qXe9jA6lVX3HJSnkinOlCatePQkTUUTQmyOpN6ZrpISLmgygl0Xe
	Cc81PlfuVQ5J6LAm5cZgQNj9+765p4wfd3ua4iqIaNYC9dhjs7ATJn27lFXZLC/l
	Vvy4qc6aoJKcQPUYoPgLJmhnZiYSx5Q/co/pEXf5/J/mFYrSk/D+T2A/K4ZyM8ev
	WuVpJdkFbpbZHHCI6imGoWGp4HBDlGgOHBTgsCBKACPSVO7go1iqlhs8JUfle+Bp
	66ruuiDLVU3oBtj351ArawJOSrWG40DTygF2Qd1BXE16XRqWLWSiel2q8ZHfGrUF
	W+qIlmdg7QYnDBaCIO1Snw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792637200; x=
	1792723600; bh=b8JrLeZmohBXZxoZ8hIHhxCw9MvjJJNFtjwd/KPNiN4=; b=v
	cwJoROojIG7D8Yiyo6V0wr9zJ2pRVIh71PjrTRn4b+6YL5sSTwTY+7P7EB9lwh+/
	DgH1RyTg6cKTNYtiCzaE0wI9A8W6AgLUJlSEbk/fTD7zU/ZhLFKcyrIUauUH1y2A
	QYZEiekK3gSDR90Ln0u6yMi+ZBrfsn7f0S9Tf2ywJHki9gbE14mIuX/gzivUAOdS
	Cma0bCSSOLlye+1WSmxdjF1tiiG4XwCFqwaspRg21z7djT/2sh/3+f4JTt5+M8Kk
	7NLNa4Qd2Imv5mq7Hteo5kGIGgnEE3sT/Kfi1+q9zWSBPXL8j1/3mZNR194Dwsrj
	Gd2lcQjDOCSHGyYklAHJA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=themaw.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792637200; d=themaw.net;
	mf=PHJhdmVuQHRoZW1hdy5uZXQ+;
	rt=PGF1dG9mc0B2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ZtgQ2+F7iTog84e+t8QXV6QTp/5ghWq/dKk7AbY52WDIQE6
	dOLGwnb6q+8VPPVm6e6cYc1ZVGa2D5OgK9U1gvzaCV+RSv6UxINoApNeEX1Lm0t+
	OKZga98pnY+8gGM0dHl/SSbHlxdrgYSEs3tDloUs9VlcoerzK0NLA6kp2chFNqtj
	YF7sfrIqPKZ7ZtC+Q7WSDMKJZH9Xi+gpH6wLjrQKriOkA5OuFOAsxTV5HOARkB4D
	aJnrbb3Io4WT1wVRIbussVwAU0ghGwvfik/s95OoLyRdch/zsG2/Ee2DVpPp7W3K
	pY9xIyjGBiqCl6JSi+TEL8dazmz0dMaF/Qr62mA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:sdIH6ghOfrgTjW7puJZHRJZvIDPGFStH0tPZPwlN6IY=:b8JrLeZmohBXZxoZ8hIHhxCw9MvjJJNFtjwd/KPNiN4=;
X-ME-Sender: <xms:D3nZanyYcTuh1SY80zX_Z3VtYIcnX1BBY-veSqerCBSt1doqa07t-g>
    <xme:D3nZamOykI2EFyFkWfEQmZBOI0PChO7v-hJGRuVXaGDdRxXTVwMYKBZ7a3UWWH1ie
    0wFBf-nNgac8cM40_1LQq8MsCTxPG02K1VsP2AXBzRBHIBmRQ>
X-ME-Received: <xmr:D3nZamY4FEZChR6xmOHcfGReLpYofWK_kp1dlI4Zr0JZdcyX4NIsDRciIpTIpQMClhpxXEvmjwj0sZwKY-PCB50KB4IQmiDvalX4Nn6fX_Quu4q5gHoPw9a8dVE>
X-ME-Proxy-Cause: dmFkZTFJl80OlkxtKrmLpLry8SB+s8EoAdfs4E9kpHOA5dqijSHh+7H/6Ivwl3c5UQ6DPU
    41bDxgYzHplpsNoe8kwgDj4e1PKdBedBJV72Q4qA5wkBs8ODrr/9rPxc2zUUd+tnYjIwoT
    ny8AmIaquX3FxGlVZ0wxUuvq9UzFvwMAZ6TafguFw1d36OZgJRVxv2eQRkdEHm1vVeHXFF
    enmny/KR7qloN3pF57Mt7BDSlLtYw5ioXv2HFdYDF3laRnOa69O9gEnqzvDWKnOWL+0mIp
    HHUGTUNCYNktwxR355RyWy/dARgku5E1Vam+5YCKNnxnJoQuSH4/+wb6ScnHEQ3FIY85MV
    AAKXP32OP+0nQTkUZkb3NJlSRBIDpgT3rTLeB7cgMiC4kZHDuhR4f2GzJiGfZSvkpaVFOP
    cdlLoxz0KKAOhQPEgAUXJIN8/Uf8MWooH7GFvNoWioufSIH7cfK76aZxRoHTb5pIC3fKB9
    IrXPlTrMZ0z5RGiu/PDUyXn43KzDEn8Gye3Vf1cyrB0QyRIer9FCFe7jiOgcbOZGbFwpih
    OXLMN/2oBAih4161kXuTVBxcIypuUYKmasZEXorhy9h6zgyfGvDLpZ909if6Ry7f6MKQQx
    9xmQ6YWBNfFkmT4h1lMILcX2FXpoU1mRB3zuEOk4y7LUlL26+NtemFD+R7/Q
X-ME-Proxy: <xmx:D3nZaorfBZiF8DSOEZG9VScubghi4xX2nS4sv7IJtC3MTIqGtPOUuw>
    <xmx:D3nZajwe7dqGiUq7V8x9yzWXpiTmXTyOtphxRL3efFi5e2Oux14WPA>
    <xmx:D3nZagKfQaQFfha9UVcQtj1T_EGDbTHRmsjFyN5gd1dg44283zuzVQ>
    <xmx:D3nZal7I8GnVfCh0yAw6Y7uSPUxVAHpDmybX3LJZ4_ChcJOfw3cg5g>
    <xmx:EHnZarKh3r5ZAsnP8-S-yuCxUC58gm0culffZA-oAHtI_8qarITqTtyZ>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 22:46:34 -0400 (EDT)
Message-ID: <22d41f2a5546d3bc90a1b3ad24ed3656588a854f.camel@themaw.net>
Subject: Re: [PATCH 0/2] kernfs, autofs: fix pipe lock cycles through sysfs
 stores
From: Ian Kent <raven@themaw.net>
To: Tejun Heo <tj@kernel.org>, Krystian Kaniewski
 <krystianmkaniewski@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"	
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Alexander Viro	
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	 <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra	
 <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Jens
 Axboe	 <axboe@kernel.dk>, driver-core@lists.linux.dev,
 autofs@vger.kernel.org, 	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, 
	syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Date: Thu, 22 Oct 2026 10:46:30 +0800
In-Reply-To: <649966b83b39fcdd25e892fc3c6732a1@kernel.org>
References: <6aa23178.f81106d8.2ab401.0006.GAE@google.com>
	 <cover.1792577179.git.krystianmkaniewski@gmail.com>
	 <649966b83b39fcdd25e892fc3c6732a1@kernel.org>
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

On Wed, 2026-10-21 at 11:48 -1000, Tejun Heo wrote:
> Hello, Krystian.
>=20
> On Wed, Oct 21, 2026 at 02:51:48PM +0200, Krystian Kaniewski wrote:
> > syzbot reports a lockdep cycle &pipe->mutex --> &of->mutex -->
> > &sbi->pipe_mutex. splice holds a pipe mutex while it calls the
> > write or
> > read handler of a kernfs file, kernfs takes of->mutex there, and a
> > write
> > to /sys/power/resume looks up a path that can make autofs write a
> > request
> > into its daemon pipe and wait for the daemon.
>=20
> This is an extremely convoluted case that isn't going to happen in
> any
> realistic scenario, and it doesn't make sense to change the locking
> scheme
> for it. Can we just disallow splice on /sys/power/resume instead?

I agree but it might not be as simple as disallowing that path.

Not only is the description hard to follow the example is flawed
because there should not be a mount callback on anything that's
not an empty directory or an autofs trigger mount (and the above
should be able to be either (systemd's /proc/sys/fs/binfmt_misc
is an example of an autofs trigger mount).

I mostly can't grok the reproducers for things like this so a
complicated description makes it so much harder to come up with
a sensible solution.

The other possibility I was thinking about when I saw that report
is to disallow file systems that don't make sense for automount.

That would take some thought though and isn't entirely clear for
kernfs since it's used by other file systems that may occasionally
need to automount something at some point.

OTOH, if the problem description could be cleaned up, and
simplified, I wouldn't be entirely against the change but still
wouldn't much like it. That's purely because I've always been in
favor of defensing programming even for cases that are unlikely.

Ian
