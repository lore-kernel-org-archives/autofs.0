From: Ian Kent <raven@themaw.net>
Subject: [PATCH 0/2] A couple of maintenance fixes for autofs
Date: Tue, 03 Dec 2013 13:11:29 +0800
Message-ID: <20131203050323.15048.52933.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=mesmtp; bh=lBSZ8zFQhiJCpLI6i7z7a/m
	kdgI=; b=u+yNh/QjLCKX4karf+ngrGkz2vbniwKVEXPQf51LL9epFdUsvm2f+qV
	Uj7CFxmU5vhQImaMR+zCuddaSaCj9ptRGUduivtrYOZVsptUeH0Cn/PX6/dNNlPt
	4rHJxoJ6f6zuAPMtfBBATJE8N72VXL+9tn77hWdc51fMRQI+X/dQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=smtpout;
	 bh=lBSZ8zFQhiJCpLI6i7z7a/mkdgI=; b=nsjrfUqCiKbjWmGlgyPkFTybt/1A
	795Is7fyY1lYMhRdyZX4QFnCicbMgF/EoNMTb5ytmP6MDDrOaLjUJBQ4GiDK3iv2
	7CwHNtOt4KH6IK0NxMKPnIxqIL+5PLGkAVt6m5pjK3NzZ8TOhiW9BhTOQBbkPLTg
	a9RlqKrYG4LQKG8=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Rui Xiang <rui.xiang@huawei.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Andrew,

Here are a couple of fixes for autofs.

The first patch fixes a couple of potential incorrect error returns
from autofs4_fill_super() so it's probably worthwhile to mege this
sooner rather than later.

The later is purely an improvement to using the IS_ROOT() macro.

---

Rui Xiang (2):
      autofs: fix the return value of autofs4_fill_super
      autofs: use IS_ROOT to replace root dentry checks


 fs/autofs4/inode.c |   13 ++++++++-----
 fs/autofs4/root.c  |    6 +++---
 2 files changed, 11 insertions(+), 8 deletions(-)

-- 
Ian
