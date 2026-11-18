Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795008601;
	b=RpfTWRVHGc8ucaLG5dKIG5E3hvohyVIV+n5XR3bnGyUeZ22RyiXP4KAD23sAlBP6SQ7/
	 2Jima9s7PGzCDJq5LkU4xJ8s2FegH0GnpumRNYdpGZBHxu8lAJUA/j4pch1Ywyz3n2qw6
	 1ZBydK+I0XxjWgFRpixRxm2lFJVMW7YBax6R1pPIDxItshCVrw8JS0845E/NLER4dZC8g
	 bz7JfpFv1Ta/e3LcmmVSTq2o3cL4TYaN7BCsByi2JP1dHfVtjcR145y+85VcCMg+1Y4U1
	 /lxsBunWUBvhgK24XVSI/nFtgE3YpcJP0bku9EHpREtcvHvI4LV4qdiwJvgLXmb5LYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795008601;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=DoOBTy4Tk4KM1tk2NwfW3r2DE81cjIG/a8hAQ7rYZRU=;
	b=kVhl/nEXWTqp+takqGe9wPN0HTKXGFqN2jrzkHpTrBz2x+sNkO+S/wuVUZ5h5aFN7WiT
	 pg60kbKQfy999MZDihGYTgk1H3CFrzMMyemV7HMFE6GISCELMC9jgahmz+JMUoiV1WqMY
	 AfgXSzFTqTfDza1W6alDnhv3ESVbDc2+1AjGcb+XpTaaJs8Jf69wW8XZbeQxhWye8e3CB
	 n7AJ3bGGha9Hu6wFvuG+JISSDrza/Q06DMfpiq/VSoS8Iu5zAQY+eS4laUU+3JgjhTQ7I
	 RyHNu0VslalCgoXhvXMKujRPFJ0AUgi0/ulGrD5CIomt9YIOmHofDQ3ZSTYdQsG+0BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=epv2KiF2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C03606A320;
	Wed, 18 Nov 2026 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=epv2KiF2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F45E1F000C4;
	Wed, 18 Nov 2026 13:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795008600;
	bh=DoOBTy4Tk4KM1tk2NwfW3r2DE81cjIG/a8hAQ7rYZRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=epv2KiF2Rq5l53Ltl8HexVQ5cyr3TPjxn18/fKXQfq4N1tK6JOwxWOVBQtzdHI2IM
	 V6WBYmhX63bYjVcLwyQ6druZZ4WzlkRV7G/BRPDvM8xQLtRV7FYG0S0fIsVZhnZCNI
	 UOPUbGhtU1x3a3d+WOBOIDjLluVYV6VecfLMUGwKojwtTvEyuXzGCOQFJjktoqdhkG
	 5vDL37pvBhp+wnymdzHQHbBYWemqiBohmPc8XSasJy6UFR8bKWsyEbFJ7/AMCsPyUs
	 sqmxksd+SKAWPXgDr9JnWl0u9d5azGFNCzNG6TXPHOFu6/pjvrHjhHtyS7xwIRHIOI
	 PQuuBNXdOdTcA==
From: Christian Brauner <brauner@kernel.org>
To: Tejun Heo <tj@kernel.org>,
	Krystian Kaniewski <krystianmkaniewski@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ian Kent <raven@themaw.net>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	autofs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 0/2] kernfs, sysfs: refuse splice on /sys/power/resume
Date: Wed, 18 Nov 2026 14:27:20 +0100
Message-ID: <20261118-verknallen-ungnade-kurven-9f83ec75cb88@brauner>
X-Mailer: git-send-email 2.53.0
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
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1410; i=brauner@kernel.org; h=from:subject:message-id; bh=7YVp2rjs4Iw1cumttAP8imErlAFVjA2olxiCGh9aAJk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9XWHhk30rSdaKNarpQf2xb0e0V3W6fTHnPj5xrvANN s9+dsljHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNJ7GP4n/Cs6GLPLZecfK2F rf2uKxxbyzZz1uy7cXFS9L/kY3ZaPxkZFmhNCrWNE37bejFJ/4Zg1yWJXxkc/zeZpciumjO5x3c FFwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 16 Nov 2026 14:39:01 +0100, Krystian Kaniewski wrote:
> This series refuses splice on /sys/power/resume and gives writable
> opens of that file separate lockdep classes, as Tejun suggested in the
> v1 discussion.
> 
> The reported cycle is assembled from two operations. Splice into an
> ordinary writable kernfs file records pipe->mutex before of->mutex. A
> normal write to /sys/power/resume records of->mutex before the autofs
> pipe locks when resume_store() resolves a relative path.
> 
> [...]

Applied to the vfs-7.5.kernfs branch of the vfs/vfs.git tree.
Patches in the vfs-7.5.kernfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.5.kernfs

[1/2] kernfs, sysfs: add SYSFS_NO_SPLICE to refuse splice
      https://git.kernel.org/vfs/vfs/c/0df09178ae40
[2/2] PM: hibernate: refuse splice on /sys/power/resume
      https://git.kernel.org/vfs/vfs/c/af5f879f9d4e
