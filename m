Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794861832;
	b=kkXjvb2zDPbzO64ytCp+AKImuDBG/1gkTuZ/n5vWtwAdtTaeEdH8salm20de47+ZhVzN
	 2WQ7/EW04Yrwt8ZZww7hXcUevatWUeTzi9PFNT/txdtt9FjQim8M8djmYHm5KnFK+Prtg
	 hbXu5SX2SILGfp+JJu+Y0izH4yLDc4S37Da9LVlXGZ7+QCEoQCNIoL/2toRA7a1V10lLv
	 p+5tKLzNdFnfkxQYjy9RuM2fMbgq5iXylWAsUWxtyKWncLJuYlEvYIJ033++6F0HqG8uF
	 /2at9yyAqAmx8uSvIB8O+23DCkD6xhS8VcalrReYDtg20sIAG+8rX8mWIADXO8lwJWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794861832;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BxNFQbTamgc7alF+rPcrzpTgPxts8CviBsaz5BE8TK0=;
	b=m/T6Nhi3XQHDT4QnTnsp0DT9w4wwI7RKZVzd99GDVu9BXVrKxBeSEav7kiMch2DaRdNh
	 yORE8QEQmRb+jI94nZr7aLp/zJoX26zL4m0YQETApW2VwdThMIHgimFUW9N/xKlGmbzyh
	 mJe9wnDkys14go7OMkKvV9hcTeaDd9WdDvcrBm8ndL/XufhUWMJwmVB5/1NAcqzDgn+ee
	 HnCRfLuEuRSe8I/Cxa5UiDHxS6wS0sXyNngg9fWJ8cTtX9zpwqex1dshtDTsk2FskTe9D
	 QN0+BUsbZZIr/XOXYYAVCLBoRH011k/ALnGAGECIXxAXjey3MkaNH9dlWiPOg/PAz/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HKjqeqQW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17984606A33D;
	Mon, 16 Nov 2026 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HKjqeqQW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E811F000CA;
	Mon, 16 Nov 2026 20:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794861831;
	bh=BxNFQbTamgc7alF+rPcrzpTgPxts8CviBsaz5BE8TK0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HKjqeqQWFxGwj7EDg/ni0jdWrbNwpo79l38NwFVywziERT6YIO/+lvbteFewAqmcl
	 5inoyYjw8RNYvhY395lk2dLjaz9wcP8R37/kENWttRgVACBkRUQFRlo+evW3iixTYQ
	 is6fchW2m4vMMokmzmZCvbkX0549nPqRVNU+dpziKYSrKrfjRYIED66vzb6rbIGGlO
	 DuAxep+L6nLjV7OgHFenDw1ARSiqD14gbKtF2J7npLIu99pL56VxPbW5M/z903AxBK
	 HOh7JPKe0IPNqUsiCP2XIEkPDsZm+Ce0OiZf2XVQKqbxbAeZGJtZKs5R4ah36ECpDM
	 T6GJngPCyeM6Q==
Date: Mon, 16 Nov 2026 10:43:50 -1000
Message-ID: <205dcc9b8e4926d9ae447ded1a452330@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Ian Kent <raven@themaw.net>, Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, driver-core@lists.linux.dev, linux-pm@vger.kernel.org, autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 0/2] kernfs, sysfs: refuse splice on /sys/power/resume
In-Reply-To: <20261116133903.400202-1-krystianmkaniewski@gmail.com>
References: <20261116133903.400202-1-krystianmkaniewski@gmail.com>
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

On Mon, Nov 16, 2026 at 02:39:01PM +0100, Krystian Kaniewski wrote:
> This series refuses splice on /sys/power/resume and gives writable
> opens of that file separate lockdep classes, as Tejun suggested in the
> v1 discussion.

For the series,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

--
tejun
