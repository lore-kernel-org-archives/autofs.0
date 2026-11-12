Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794496287;
	b=U4BQWeLjjMn+KM5n5aCQFGiZ819UHM2a5bKpRo7JovpJ0ZRnVXIsf+BUB74n83qxgV6V
	 tnX2zyaeIYZDQCU8lj7MnYUFfypx23SYAhFL9SZjmYc/pv/rZFLBGfkM8l0oP31HqHj8v
	 xOH0JH0LnC5BmCGiOJi9HOiSXQwSZOdFFIHVe4Nl+xl+g6kD8Hp404vyJaM/3OsJuUP2n
	 uA4CyAWjLHeWiX30EGqpjcmypusIAAdVq0Fxn5c10rPi2PnjveGvlvpTVdHwX+YFI1jgh
	 yhgo5pxJUlNKrgTefcdjN1ec4CsEYoRM61scRo7mb/J5cRxbiJlNjwu6WOq9hAxPIiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794496287;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pOPUMS1h+yW9+Q5c6aClYkFvTD4eoG+32Raw8LpRQxc=;
	b=fHt40/vJxCfrCuNqLEdbYdXrosNUeWsmwlO1bXaX6mGBO1jAaUXO3ZAsVsNgXn2lD4Gj
	 j9CBFiFV1a/nUB+Bz1hM3jgMqSnt02TLxohjETp1NCqETGRyMeZpvnqV/gezXmWkxikXd
	 DscxS5EFsE95xg0vvyTcfs01pqY9tRrnJ3sWeMjuED+Z2L0KcqbmiK+nZa1OE6K+KBBMa
	 ol9X6EkgWd9r0srfWsCDrWuAr6pKwfUMkr0MvoDb3glYHSVyphpN4MfU9FkwpJ3H783Hy
	 WggjLqBJAxjgD8mUlEnM50swEZhgAmDlCAVgW7xVG2Xdzncjn36ICedNNVOqXLk7ljQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JSAUGzyE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1843606A323;
	Thu, 12 Nov 2026 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JSAUGzyE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665EB1F00A05;
	Thu, 12 Nov 2026 15:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794496287;
	bh=pOPUMS1h+yW9+Q5c6aClYkFvTD4eoG+32Raw8LpRQxc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JSAUGzyE7QbNMXTzQkx3wbfn1l6eP4DyrrbcIGYYG73188OznI9AFrCfXf2WpaLXs
	 beGesy/cnPPXqaHEDO4586sbHZyiX4NKky7+fXZ4gbQ9f1TTIPk10L5TBSUxnnouFi
	 nWrT3IFhNL1NG8NfYlhvb3sYc591FkhDPoVsqfUVBUtx6SlKYoGZ3StwcW8xRK/3Qu
	 9kk6inbYUUbdpvnWZNaww3tHbbNWd+mAhjLOWt/CwRePwxmr2rgHAAnvT/R85eL7rq
	 4PgmAuJjIC8j4FbYTZjLv9m3zVKwNA+58CgZEFXkz4U4Wq8zVPL3M38pLito2Lz9+t
	 e8HROA+MZJ8MQ==
Date: Thu, 12 Nov 2026 05:11:26 -1000
Message-ID: <07d063ef8ebcfc7f4e05c7318a423728@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Ian Kent <raven@themaw.net>, Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, driver-core@lists.linux.dev, linux-pm@vger.kernel.org, autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 1/2] kernfs, sysfs: add SYSFS_NO_SPLICE to refuse splice on writable opens
In-Reply-To: <f9f3df7a60ecbbacc3186b700deb947d7dc23e9f.1794479968.git.krystianmkaniewski@gmail.com>
References: <cover.1794479968.git.krystianmkaniewski@gmail.com> <f9f3df7a60ecbbacc3186b700deb947d7dc23e9f.1794479968.git.krystianmkaniewski@gmail.com>
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Post: <mailto:autofs@vger.kernel.org>
List-Help: <mailto:autofs+help@vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:autofs+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello, Krystian.

On Thu, Nov 12, 2026 at 03:17:01PM +0100, Krystian Kaniewski wrote:
> Read-only opens keep splice support because they cannot reach
> ->write().

The patch looks fine to me, but I'm not sure whether the read-only
exemption is necessary. Is it addressing an actual problem? busybox, for
example, just falls back to regular reads when sendfile() fails with
-EINVAL, and refusing splice reads on read-write opens while allowing them
on read-only ones seems more confusing than anything else. Would it be
simpler to refuse splice for all opens of the file?

Thanks.

--
tejun
