Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721093;
	b=3MaE90RwVZ5w5D2mrZy9NDjcoZ0DuHtcDpLtHPp7K0VFCauzLkYFLvzx5mD9twuXKzys
	 gX1Xl0ktuyVw/DQb/k+O+kmp5NGMLEMVbfU9hxpsiMcNyPID6rcqPOCL7PWO9R+kkKT8K
	 Xklox7h9ZUwQGeoPspCuE4UcJM8oAJO83XEUlxJunys1lcdBnc66vfh/u08h9Un+vm6L2
	 0ongpAPrq95iicBDAHNz9OF6OLxd5I3IUzSeoDYBOY2JM1hBr/Dp7fn1gW+/s9Wkv0Nt2
	 yztscm/xsmw//zqOHLWW5vONm3Y+tfG7uXKBTbmoIEsceMrPJKBew421ld7A9xVh21w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721093;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hIy5SElKPw5XSH5Sr2iM/0a7cChK0BEGncKjDhtCnJM=;
	b=m9dVYUm+RYVSOlXM39s4/XLykDZNpNqAs8OVUbBh4VvbtcbaL9YjEGuxPy1heFkbMVuy
	 B8YAWRtw0ybCzJ8uCwBo8+u1chqGpV30CVSKaAZgnWbonuHUWfMshz/R7z79oKkf2p+Ti
	 tKA1vPGJpt5t4ODF2gbhFKUiSXLzB+g+AruqGAVeoSFE3dVfS+x9PlVVXRd8iJ1mmWgyi
	 3DMdLFIij+rGx+5UGW+kyoqkwBpn4FN0UBLqgl7kXbpZsN72ygQC4HkKdb0vzo114qfde
	 huJl+164Qm3OwI4Q1ENZmEaG6Qg0/JbEYZZ+dZnR1WYROcy8eciRHVszvQtq0ZgZVQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PCF6AChK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DF9606A329;
	Tue,  3 Nov 2026 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PCF6AChK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A541F000C1;
	Tue,  3 Nov 2026 15:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793721092;
	bh=hIy5SElKPw5XSH5Sr2iM/0a7cChK0BEGncKjDhtCnJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PCF6AChKh/uavoDx1vZSgurY7svwGuSb3Bm5UA+17rokVNc+Y5XJVFKLMjxhwWB+5
	 Xr+owJ7OkSj0uLBccwjcVtG6v6ihcvanXIEn3lkkAxYKZMvrkp0/hsGpg5udE0srmi
	 B0jObVqGtRIvS2xIYr12Aww7l7sRVOJxshoaOkUfnO5kiC/F//NapfoM/lZErLWkM5
	 Y0LlJfcQcwFPkS9wOqENAkeauxYDQRbA5izyQll7Ge0JFdwu9aV9tHwZDUVi+h6IIU
	 90MAIzKSFjAQ58JYWKn8hCqSMXlAcWSBonoRuRl0bhvrMuk6RDWA1aNJ/2a5Tx090r
	 oW4s+BBRq3JJQ==
Date: Tue, 03 Nov 2026 05:51:31 -1000
Message-ID: <c943b8e768ef766b0f6563b6085e99fe@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Ian Kent <raven@themaw.net>, Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, driver-core@lists.linux.dev, linux-pm@vger.kernel.org, autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 0/2] kernfs, sysfs: refuse splice on /sys/power/resume
In-Reply-To: <cover.1793715774.git.krystianmkaniewski@gmail.com>
References: <cover.1793715774.git.krystianmkaniewski@gmail.com>
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

On Tue, Nov 03, 2026 at 03:57:41PM +0100, Krystian Kaniewski wrote:
> Patch 1 adds SYSFS_LOOKUP and kernfs_ops->may_lookup. Writable opens of a
> marked file refuse both splice directions. Their of->mutex and seq_file lock
> use separate classes. Read-only opens retain splice support.

Can we be explicit and name the flag after what it does, e.g.
SYSFS_NO_SPLICE and kernfs_ops->no_splice?

> The new property cannot be combined with mmap or preallocated buffers.
> Kernfs rejects those combinations for direct callers, and sysfs rejects
> SYSFS_LOOKUP together with SYSFS_PREALLOC before selecting operations.
> Binary attributes do not support SYSFS_LOOKUP and reject it at creation.

Can we keep the rest minimal? With /sys/power/resume the only user, I don't
think things like the mmap and prealloc combination checks or the binary
attribute rejections are needed.

Thanks.

--
tejun
