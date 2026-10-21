Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792619306;
	b=naWvntd4A3bY6aUBgP3t9O7KRfISRm3UhsVmsyAn9MX1qlexF3kJJTSG9YuCxYubTYs/
	 JILibWnBK5LNF4AKV4l6VfG2le6rjlbf8isEyhu8etV8aiOIPjcN9wKsN/MEgDpT/8Sgr
	 FuK2ELOPrIf0WNLZ0lSw2rYmOjdEmkGMnNfT1HZT/LtARhT4K5/lwo5V5cYN2b0Foqbjd
	 cUfm2pSLbcOq4R50C3VBmDykDEYq/ja7nYSBjMKbWPN7E9MZwPuKa5V68Rnr8jNH2TTdZ
	 ezIqA/4POx0OYaz/kfDrWTBkLaRR2EjmnuPVc3z7Tgi5Uh/2mZC2YBq67avyvOD6pzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792619306;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=R1UQ9FNkc8l5nyatttnspRCQVclcdetrGbMkAG+XPp4=;
	b=KOR3j4NTfGHypUTAnq+a/yVw//Qc9YVFg512M05fwY9QC4wz8fPldPunPgHsvXnS9iAG
	 r7FlKfxAUQCZVGfUZ6x93kNgEBjxCpbFaH0M5n54aM9vhNn651zA25HBJMaDmYzIvA8x+
	 MoYxvMPod9/eVTTjbGlsjh7sKubJsbPbYI6vR9YM+rSA77RGaFMyvPlqMt+OdyefMIyrW
	 mBMUFmAPxvZ/bc9T/YNMbpiLuMC5HLfpHamTG/zn0/yFvwq92L7CRQ18n6fDYwWkgRkQi
	 oGwmQc2+rIkLJcjtZVeTupbpZ9D+52C+YLT5teS8ALVJNWc/65faXzMhqyy3m2PADSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N47QG1bj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3982E606A31A;
	Wed, 21 Oct 2026 21:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N47QG1bj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949B61F000C4;
	Wed, 21 Oct 2026 21:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792619305;
	bh=R1UQ9FNkc8l5nyatttnspRCQVclcdetrGbMkAG+XPp4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N47QG1bjuudhcobU3keo853c+bzAg5T+d+/lpJoagyVzzFNZEqk1sjb5MPt+yF90L
	 GXUBw8zE/7EmUjPZN2evYSV17aUp7PqJaJGLShWb7hXgAJpX3+Zlxmav4kanqnPCUl
	 5vC8mbRbn7YgHr6rHylcBcqgn8U1ZLCEdFTAiLt+gVJpMlvd6FhxP3rSnpuOjfTwsE
	 ikMk9w33nXjmCB5cG3aR7Cd2hBsqN1UYaHsAeSbZhhf63nqq5uQ0A9ad48TSDa8xpa
	 zSTG/x7BjBAgaAqepceMn5aozu30SmHatv/GE5Gy7DU3iIXFa1SiCcm+QcuwVXdc0g
	 oBNnFkSXt/EAA==
Date: Wed, 21 Oct 2026 11:48:24 -1000
Message-ID: <649966b83b39fcdd25e892fc3c6732a1@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ian Kent <raven@themaw.net>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 driver-core@lists.linux.dev, autofs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Subject: Re: [PATCH 0/2] kernfs, autofs: fix pipe lock cycles through sysfs stores
In-Reply-To: <cover.1792577179.git.krystianmkaniewski@gmail.com>
References: <6aa23178.f81106d8.2ab401.0006.GAE@google.com>
 <cover.1792577179.git.krystianmkaniewski@gmail.com>
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

On Wed, Oct 21, 2026 at 02:51:48PM +0200, Krystian Kaniewski wrote:
> syzbot reports a lockdep cycle &pipe->mutex --> &of->mutex -->
> &sbi->pipe_mutex. splice holds a pipe mutex while it calls the write or
> read handler of a kernfs file, kernfs takes of->mutex there, and a write
> to /sys/power/resume looks up a path that can make autofs write a request
> into its daemon pipe and wait for the daemon.

This is an extremely convoluted case that isn't going to happen in any
realistic scenario, and it doesn't make sense to change the locking scheme
for it. Can we just disallow splice on /sys/power/resume instead?

Thanks.

--
tejun
