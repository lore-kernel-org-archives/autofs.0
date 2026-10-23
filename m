Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792780382;
	b=pXutUHV2OnKZOoB/l11GCqDFOJ/vRysRFvX45DclGb4DYI3dd46fLwSCyk9YTnCU9G+U
	 c/4uFmyDl7YM1h7kVycuyzjz6bQceFjuAOYySxfLUwdoPUdCEjoDuQq7JKJBTk35t/pnl
	 3+5HS4QwXOeU1sMXmMHcK8nzKkU7jX4z2mbBQ/wevnMIUP1nyBrHX8PV9LSjUgVcgNQn0
	 guDcV5YAxwsAcg+et/2ye6EBx50BlNO+9uXY0cf0FAB9DB2OO0OpojTnqd6pmlpmuu5ZI
	 wEQsdSyX8HnF8ds9ZxXdXBvAQXnE2ZxUAlU8qtR1eOrZa1k+sgC48swwrkKURW0xFRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792780382;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KAxQFAeQQPQpgLYQtsjV0kUzkeCj3wXnsII0CK5Zrx4=;
	b=40u7sLZZLBoos9Eh8LyVXkZndYGg+7xk0DHNuQEA2pNc7QJ48VvSer4jJhwMroOjKa+m
	 PH0w4taSeUQOefpIKz1tugGiYEvCNfM3W1sUcUFQ8X+Fw5YUig1Z3ZMT33PkeGhmsE/11
	 EvkFiD5LWmIRZB9mlvummMnMZlErLoNAB2la/zdFYELzV3xvXifMRv2IXOI8TydEn/m6g
	 pkbwznBS8ABDPo72k5y1wtK5UXCPWszm3gdDPYY1Lix9F5XL73khKhsi0ICKrz9todLPN
	 t8GhNvZjSttdTppkzh/xMdhgnWXfPvQ3z975jA+XICBWn/0g1gSXasgkADl8YFz+4Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MEKhaFyl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238B1606A31A;
	Fri, 23 Oct 2026 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MEKhaFyl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C0F1F01825;
	Fri, 23 Oct 2026 18:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792780381;
	bh=KAxQFAeQQPQpgLYQtsjV0kUzkeCj3wXnsII0CK5Zrx4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MEKhaFylL2Mm3oqorh1fLNWb5zHAkYoW22VF3+3JTivYNQ0mPy/iPbaUnRz1IqCPQ
	 iad4WCsEAroHopYevsON8Uy42QdWKMIl4B3x8uNON/C7PktgbWetaP+l4QkTWbA1QS
	 5n9/0uP6Qj3WGIBGiAvGve6oPg0gD1+U2tUpbffoJ9ImuwJrRhWOomhLe/J+bUoF+r
	 g4fZxIZFQiVFAsa/b6P5GxXqC5sJdpRBpNy+vvG5D+brBFu6ggxh67texi91Acsa8X
	 Aq1cXxSQZM+wCIwYNdPWoyRJ/VN6fbxbB3ajoSWxHy2SgMhX53pTMkb6Bx+34SthZP
	 UX2vEImHgo/EQ==
Date: Fri, 23 Oct 2026 08:33:00 -1000
Message-ID: <ec0c2add83f18d7a3c726d5d219dfe42@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Cc: Ian Kent <raven@themaw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 driver-core@lists.linux.dev, autofs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Subject: Re: [PATCH 0/2] kernfs, autofs: fix pipe lock cycles through sysfs stores
In-Reply-To: <7a212208-74f2-4d79-8ca2-a1502d0e0a1c@gmail.com>
References: <6aa23178.f81106d8.2ab401.0006.GAE@google.com>
 <cover.1792577179.git.krystianmkaniewski@gmail.com>
 <649966b83b39fcdd25e892fc3c6732a1@kernel.org>
 <22d41f2a5546d3bc90a1b3ad24ed3656588a854f.camel@themaw.net>
 <7a212208-74f2-4d79-8ca2-a1502d0e0a1c@gmail.com>
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

On Fri, Oct 23, 2026 at 04:05:38PM +0200, Krystian Kaniewski wrote:
> Given these two separate paths, did you intend to prevent only direct
> splice operations on /sys/power/resume even though the reported class
> cycle would remain, or should a replacement also eliminate the
> lockdep report?

The lockdep report should go away too.

What about disabling splice only for the files whose ->store() can look
up arbitrary paths, such as /sys/power/resume, and giving their of->mutex
a separate lockdep class? Splice is what nests of->mutex inside
pipe->mutex, so if those files can't be spliced, pipe->mutex never nests
outside the new class and the cycle is gone. Commit 16b52bbee482
("kernfs: annotate different lockdep class for of->mutex of writable
files") did the same kind of split for writable files.

Thanks.

--
tejun
