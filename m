Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB28B3890EE;
	Fri, 25 Sep 2026 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347924; cv=none; b=eYURGSRp4hU0547+CwXC2KiWsiyc4Ubid3JZSEn8r6eFWkl6ZIyjBw8i3FiHDi+P5SRK+NTnoHj70aH0DxKk/gS+4r37vPafPcRV/yb2Z2RbmC49hvgw5v3+IQMEaRdPjgRR0/1Ube//z7aLipbXgha712J8jMyUA8JfXFFJ3Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347924; c=relaxed/simple;
	bh=amCIOTN/yBnnaMw+T35/WSBpUC/rEQtQmsZJ7uZLyPY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E/cMdlkuMFHU5TFLaZJVxy1AhM23+v+lZYzH+Svg4vHHhD5ng0yy+lnOylN0sVIRGx0OT0WcYO5/BiNn0JOjJOdaDhMrOuDnzhS31RpyL1nVWr86TRmh3mGeEOVdkbheA1LkFCHI4GxBbQfPihxoByrXzA7HGLnzXXOCUKQlmxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSWojX+6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSWojX+6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BEA1F000FF;
	Fri, 25 Sep 2026 14:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790347920;
	bh=Vk//Q1XYaIBvLXGbpPu09O1iNPIBtC/5PNIzTNqaBF4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=DSWojX+6uiWMU6oUOCtU2LgyOTTSOwFChEail+5Wn3XFMnvTW7LlwZ0Ik1pDIFr5b
	 TU5+FQFuapbOS+bmdprtyc4G8wtzCym06qEfesRk275A9Nse9m8J/YD20jr5AOaeTw
	 vdW/sSTg3ynCc6lHRYKJrRbFLW8/cNlYlF6QsNnq2m1n+jg08fZkIaIuDM8Uk9RAsj
	 nfJDm5gy1KutqXt4gRZAcMH/lHD6NAOARuI9dXWx2U8D9nmSg66rz4D0vX8rb4k+Ts
	 /54i5YiL+WtNAgbjgOSRRggVClspN/8AHbj9ZVjutjEMo/PQ9Lya4q4WKdR6/2N1nf
	 tyzpZ7nfGeLUQ==
From: Christian Brauner <brauner@kernel.org>
To: Ian Kent <raven@themaw.net>, Hui Peng <benquike@gmail.com>
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260919204808.2812930-1-benquike@gmail.com>
References: <20260919204808.2812930-1-benquike@gmail.com>
Subject: Re: [PATCH] autofs: fix sbi->pipe file reference leak in
 autofs_kill_sb()
Message-Id: <20260925-erdig-morgig-insasse-a8f31ccc49f7@brauner>
Date: Fri, 25 Sep 2026 16:51:55 +0200
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; i=brauner@kernel.org;
 h=from:subject:message-id; bh=amCIOTN/yBnnaMw+T35/WSBpUC/rEQtQmsZJ7uZLyPY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRt6+oJn3znv8f8o6Gv56iUrzogbn3g3yKfVrnnjZ3Ze
 nncT3x3dpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk2yZGhkabro9twiJhe3aH
 6Zpb5tY+8rn0x4dfIaBM58zPROG5fowMGziKdRj9WS7wytiU2c97Otd9zYo+9Y9c4VdOzM7xLuT
 nAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Sat, 19 Sep 2026 20:48:08 +0000, Hui Peng wrote:
> autofs: fix sbi->pipe file reference leak in autofs_kill_sb()

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

[1/1] autofs: fix sbi->pipe file reference leak in autofs_kill_sb()
      https://git.kernel.org/vfs/vfs/c/aa5e44b29ffe

