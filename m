Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460E312D760;
	Thu,  1 Aug 2024 07:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722495914; cv=none; b=NRtv7xEC0DlYvnUmTOyJJvOi5SqenlFu94PFHRtETo8bcD4dwQ2IFkQS6fhxNwzoAlVLoCnsm/etSDdi2D3i4NTmmmx9oZbcWGcwmTVIUpDD6BZhWz895C90MMBWkDcHveYufzwk/9O+ZZagQtk3DYQxyoIjMfSZTEiwEpPJoiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722495914; c=relaxed/simple;
	bh=j06nuYW6Hn4VDKy7aV1Z3+6YOJDjitJhHC4LJCFXWUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S/gRakpZW7KF8ciD2FGSts4SOb8Ep4jnAH3ywPvxmrihl9mNJg5FaLN1xBHT7TfbjqXTcrp8xVqSDcwnUF9dc/d6yAPGY4y1bla1AQjEJZKR2yHHR9OI8rAdI4iJvO7U9o9Xgz4M1UQLSvjEHcncLw1UNsw5vVHo12IFNftAosA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epWODFgi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epWODFgi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264CCC4AF0A;
	Thu,  1 Aug 2024 07:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722495913;
	bh=j06nuYW6Hn4VDKy7aV1Z3+6YOJDjitJhHC4LJCFXWUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=epWODFgim0/CHf3FaNDcH6hHK8TngLvDg97yCQqVI4eZAkcxgtEeSE7RBh/ZyiiYp
	 fwHbQeW/wEvO1S4reZy30lCr0QKoNBv3kYIReH05h2S7ngzbYeJSNUBJ74D4Jgh7DZ
	 nRqQTmN0sMIDZHsmVjfKUUYXDQgJ8lgEeqVy8LpqY+nWwMBcqK5kfRFEPo/4ARJz0f
	 AZvQxl660hoHNCgVEkRWdqR5Y+Y1j3/iyjRxrTMJLvqcKyD2e+3eC0kr33awjU0G4F
	 CKhPk7vwgaqxjziDgjIla30zxFoZbiGp/rR8twpK9ZjaSABIbcoRHCUnarSJZdd0Pe
	 0bqDEaxus1L/A==
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <brauner@kernel.org>,
	autofs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	codalist@coda.cs.cmu.edu,
	Ian Kent <raven@themaw.net>,
	Bill O'Donnell <bodonnel@redhat.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	coda@cs.cmu.edu,
	Eric Sandeen <sandeen@redhat.com>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2 0/2] fsconfig: minor fsparam_fd fixes
Date: Thu,  1 Aug 2024 09:04:54 +0200
Message-ID: <20240801-manchmal-produkt-16d3e590cfb1@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731-fsconfig-fsparam_fd-fixes-v2-0-e7c472224417@cyphar.com>
References: <20240731-fsconfig-fsparam_fd-fixes-v2-0-e7c472224417@cyphar.com>
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1377; i=brauner@kernel.org; h=from:subject:message-id; bh=j06nuYW6Hn4VDKy7aV1Z3+6YOJDjitJhHC4LJCFXWUQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaStNl7In2OwZdq7L6EWv8Vutbes2iZyuW3rjF83o63+b +Rd4WrzrqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAis54wMizVt741qzLPyM3m 1YmM9W4f5GN58w4Xc/peXL9ndWhsyVSGvwLZW6cd3P295Vvi5C/dBkkdeTFP5Hf2OiYd5Ds3b+v cRUwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 31 Jul 2024 23:10:26 +1000, Aleksa Sarai wrote:
> While working on adding an fsparam_fd() argument to cgroupfs, I noticed
> that there are only two users of fsparam_fd() and they both seemed to
> have minor issues:
> 
> * autofs has a missing fput() when using FSCONFIG_SET_FD.
> * coda uses fsparam_fd() but it ignores param->file and so ends up
>   re-getting the file. This doesn't change the behaviour but it seems
>   preferable to have all users of fsparam_fd() have the same logic.
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/2] autofs: fix missing fput for FSCONFIG_SET_FD
      https://git.kernel.org/vfs/vfs/c/9f6b314ecc8b
[2/2] coda: use param->file for FSCONFIG_SET_FD
      https://git.kernel.org/vfs/vfs/c/b0839e9bbc5b
