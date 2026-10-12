Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CFC36C0DC;
	Mon, 12 Oct 2026 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795892; cv=none; b=FIcInFy/2cMO9z0KVCZpRLe0FUNPsvRTV49eBSz6edxiJu9qbKgfjaoZdHQmyzzmHm7bizGVG9vptZkYrwypyj2OFEAMVsGArPfvVJRAlU+Y+22x1+hT53419cj3RHRJM9Q6AVx5400srApQNp1lmpWngswjUKQBhF0LdwRzyS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795892; c=relaxed/simple;
	bh=lLTpIHYpYUa57FBSvGgpqtvhGOIrMfjUlzelti97PcM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f3KO88ChmZMAJZVt7yOLfCoaXL/mDzlO2KVCjseMYjg9iVjDIF1/vv8n8UoJxAKBWI9UerfzQ1yEd7/F1bNDUn4L/YU7+xYcT8pEhPaBH2RtBwTGJkL9mSTviHhTAGmXtnkM9cZYvzgTxbHq3zoC4iLGSgBtSSHulZFJn8a7pY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9B89yWO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9B89yWO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C0B1F0089B;
	Mon, 12 Oct 2026 09:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791795891;
	bh=atWcPEqChcNkQrikQiv9vIO2eUPRsDg6I2Azqhyct0o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=K9B89yWONxOJ0NYr0nOS+pxZ9ncy19H85q63u5tFtFqLCnxiGVb1+XvR4xqw+0uzH
	 Klz5YmUvrEUtWQuGux+VS/GNQci8r5oJhE930jk53f0ei2JdgRMDt4GtsOQ48eYNQG
	 mSuVwu6rswvf1FIj/4FYiNCr7EPTxDYg7gyALi2SYwWkZ2ccvs2QRcHFZku4gY3SAL
	 jUyGGdaWAyzDxDvN8RtBmJGY7i1iosZAvFzFD81R4D9oR1wS5843h3WvNX8Kel9cKQ
	 0KlTSxlIRBV/+GWcC4TohwMDnSM014WHMHYR6L+o6UoOVIgUCYpyWmYKY7ULCqc4J2
	 LcWKTFim79zBQ==
From: Christian Brauner <brauner@kernel.org>
To: Ian Kent <raven@themaw.net>, tjdqudcks0424@naver.com
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261007173542.593624-1-tjdqudcks0424@naver.com>
References: <20261007173542.593624-1-tjdqudcks0424@naver.com>
Subject: Re: [PATCH] autofs: ignore notification errors from a replaced
 pipe
Message-Id: <20261012-erbarmen-freigaben-unausstehlich-50d9737a22be@brauner>
Date: Mon, 12 Oct 2026 11:04:47 +0200
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-3d1b8

On Thu, 08 Oct 2026 02:35:42 +0900, tjdqudcks0424@naver.com wrote:
> autofs_notify_daemon() takes a reference to the current notification
> pipe under wq_mutex, then drops the mutex before writing the request. The
> write can block while the daemon enters catatonic mode and installs a
> replacement pipe.
> 
> If the old pipe's reader is then closed, the delayed write returns -EPIPE
> and the generic error path enters catatonic mode again. That transition
> acts on the current superblock state, closes the replacement pipe, and
> releases the new daemon generation's wait queues.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] autofs: ignore notification errors from a replaced pipe
      https://git.kernel.org/vfs/vfs/c/d4ca8f75bc42

