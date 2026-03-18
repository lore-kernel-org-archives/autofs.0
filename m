Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C833A9DA9;
	Wed, 18 Mar 2026 09:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773827775; cv=none; b=ONMfgLOqtNsVIKf17xlzTuiLy9DreBPDujYPxtiIlwt9sdTcnTXPl+LNkDzm4P9ZBbJoFCFj2zrLqM48Nv8+2plFopnd2DZFohdUN5XFim0vezwIStC5gLBUHhRlIEcSzlL3qpzk7qxUwIoWuhO4X2rltrQOEuMGCfhlrLzh/h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773827775; c=relaxed/simple;
	bh=jFdRfPzfHT75INiQ+8okLRwrLfZNDZdKNlgjWUDuiQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mHM5m+1gye2uXFmqDgBsgU3MlzeY+roD+Zsq191G+4JWtaR48rvRAEYbQ0EvWL8smKEZNH8rtELlNRG2axAjqTmlMKgN/8EPWShgP+m9NbDniDkrEP5wgYtA1gmnpKqUazIylNaYRxwaHXpz8zYCCoJgd+l2BmfUCEsTYIOU76M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nf+heqJX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nf+heqJX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571E8C19421;
	Wed, 18 Mar 2026 09:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773827774;
	bh=jFdRfPzfHT75INiQ+8okLRwrLfZNDZdKNlgjWUDuiQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nf+heqJXZ39z4eizVGHtV6CZ91P4BSd6UvFk/SBTZOrZ0OarfAfovl1wAxinbU3pm
	 wmKD/isePWhC2gT97aasBJ6IQq+GRe2wMA8N9fh9V0mZiMI+LOR9WeneQW9aem5UXB
	 oxkoIJSGb4b9jPpUxm4vcMuHGeviLRmoYctlHCgOS44zyUubpWcmu3tUYnGNOT8Vbd
	 cz4OpRQkOmNOPMWyeHLkbYdxSLxNWr8TAGjk6Huwx3J+jwcDl0gWWr4HEIgy+34Aby
	 2vrDRXxLizI0AjPzO/qZAvuFy/daV0e/7nm3uJu7fyHi6OhGE8m3t4HkaX4sGZUwHA
	 YMPDMX7wnWIjQ==
From: Christian Brauner <brauner@kernel.org>
To: Ian Kent <raven@themaw.net>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	autofs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] autofs: replace manual symlink buffer allocation in autofs_dir_symlink
Date: Wed, 18 Mar 2026 10:56:09 +0100
Message-ID: <20260318-wertigkeit-erzittern-cccf276ea8fa@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260318001219.2354-3-thorsten.blum@linux.dev>
References: <20260318001219.2354-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1269; i=brauner@kernel.org; h=from:subject:message-id; bh=jFdRfPzfHT75INiQ+8okLRwrLfZNDZdKNlgjWUDuiQ8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTuKtt1ZfrkLVt8Jy9ftqJhoyhnVPX7X+tEcz785Or3N psx4fzfjR2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATYTnC8L+ocPmHibmsMo5y +u1pDhusg+/W8FxbWn0psjzDZ8qMpC5GhutdB5Pq4xoNp1hONpIzO9rDmiOkydy9P6ZPb/b3o3e Y+AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 18 Mar 2026 01:12:21 +0100, Thorsten Blum wrote:
> The symlink name was previously duplicated using an explicit kmalloc()
> followed by strcpy(), which is deprecated [1]. Replace this open-coded
> string duplication with kstrdup(), which allocates and copies the
> symlink name with a single helper function.
> 
> Remove the local variable 'size' and set 'i_size' directly using
> strlen(cp), which is equivalent to the previous value of 'size'.
> 
> [...]

Applied to the vfs-7.1.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.1.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.1.misc

[1/1] autofs: replace manual symlink buffer allocation in autofs_dir_symlink
      https://git.kernel.org/vfs/vfs/c/f8909447894a
