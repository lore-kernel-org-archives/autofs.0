Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86912212FAD
	for <autofs@vger.kernel.org>; Thu,  7 Aug 2025 06:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754547657; cv=none; b=guMx6nKOcPDAqmHhDzIIaeiz25gHggYst/pFKy/kihfkgxcQbN0ujyLRtbMzmNUxgxv3t7ySF14K/WFlwH9vwn0BRBEMi7bwPUxXVr+WW/t74uG2mIWO8R4Am3aiTeKhSlXpO4eFbkRoVpt28Xe8ai0xje6fHc4L9I6VpZ53v3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754547657; c=relaxed/simple;
	bh=BPWmkr/MDE8sVg4HEZYFptHHkJMT5vd5yWvC42kuhds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9TDZ7jSOj+7yn37v0PjfDrvngxuHNzyIA9p4/gnmNu9BzG8U0Hf26noqMZLcTgNS+MYebvuQ2YlAUfaFkIHnrdEdnuNQG+AGovqmnTGP5zauoNKhc/H0JLTFnLKVjdVx7GbRPtUQL1qz4Yh/PJ3XGbf/u5vrHhC5eSqqg7hnPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=bQjPk/74; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dXYWWKnp; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="bQjPk/74";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dXYWWKnp"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B4676EC01A2;
	Thu,  7 Aug 2025 02:20:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 07 Aug 2025 02:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754547654; x=
	1754634054; bh=ueD4cBITdTrLUP0YKwSxCUpgALUhmYDB31MZsFPeOTI=; b=b
	QjPk/74x2duTnFWKCa6dRti2E0ZudOTWjB3eApQQDN2fVY6UTZeT+Seh+wWFlUfY
	djnkh0kQAPiLwt5IdX0n2Ga0VkMPNToZZRO6xY3hWeuvm2taWJsAo5eD3rtxqo9a
	Sc7Eai3fcMW8XMTUCnsvn+kWvAcHBuEKW7k4raKJh39q6vhDPPAfe4h87SkMgn7a
	iu1Dp1dN12wUONSIlqe3551+cu2HH0bMOKTCiRrBY5IaJsO7auFZkdJRpytdrIDe
	0JkGRstFBUKjZueTKifX10Cvhoi2K+6gVSriexCYNiOB60tROBQxqYsstu+ixcCo
	SJFV+SmINW3sb6WD46nUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754547654; x=1754634054; bh=u
	eD4cBITdTrLUP0YKwSxCUpgALUhmYDB31MZsFPeOTI=; b=dXYWWKnpzKY0ggL3l
	5JoRhRNqVrs2NEeZqN1zGDM9dV9tQeto32J6+vdA5KAFGInpF+GHIhaagkfisI7W
	RbfCqWTCivx9W4RBxX95sqo1Qhtpg1wLQ9tuG6WeubB0zkFCpmFa05Y4n5XeG5sK
	yJ936RrdRS1/vnAZrIN17WAyxvxjob5LgIS+VcO5CmWM23qVegft6zjPDzOYa58I
	lHqwMpXYBjte+X2FJJyRxGSTg4z2iFZMVm8UJZg0tFi6cd9WrKzi9lzZPdZuaHDl
	WuvY42sozrX6ELlnuDgYmGGmYjXLCpK1YzZTIoywgsNuxjbxvUpbu3A8JJtCErZB
	uQI+w==
X-ME-Sender: <xms:xkWUaNpnx_X9hj1Abufrf-A38NtLWtMXwb6kBV34deIjS7vKoJx4vw>
    <xme:xkWUaC4cq8qt8guM3CiFPtEXH2n6mjSnzMm3yJ_XTDcYrTaTjBHBDsfGHpXMtCvZy
    FSs5CrEkBMC>
X-ME-Received: <xmr:xkWUaDrXXs0fXY3h8KHX7NuIlHfkt1RyRhVURydizCZ0ZqvBIRAjs-yvn_M1ROGs2NnwPca0_ienkivojp4gkWeNDNrmbNJK1JfaFtf-AYToEgXmPOK254EJNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpedule
    egueffgfehudeufedtffeiudfghfejgeehvdffgefgjeetvdfffeeihfdvveenucevlhhu
    shhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthh
    gvmhgrfidrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepugguihhsshesshhushgvrdguvgdprhgtphhtthhopegruhhtohhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghvvghnsehthhgvmhgrfidr
    nhgvth
X-ME-Proxy: <xmx:xkWUaEg7mcaWIVJpPPaEnRup7LzGaNS3rARvBeQx8kH_hf3cN22BOA>
    <xmx:xkWUaNJucluVII5QQ0gZLr48T7s64Qps1-7QnuwxV4FNAdLPQD3Qyw>
    <xmx:xkWUaEDltHJw5WPlJ04UZzSPHXnXrs2FgxyFub7BsRBvLeFWJQBnHA>
    <xmx:xkWUaNjcK5f6ZV4WWm7rGSbor6gKWhozZL7z9g94Iv67D8wZJ1oYzA>
    <xmx:xkWUaAL-VoWYrS7EfV1lEIJgxDbZ5jQNU_rrR3pb3Cu294QcTh3Zfxeg>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 02:20:52 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: David Disseldorp <ddiss@suse.de>
Cc: autofs mailing list <autofs@vger.kernel.org>,
	Ian Kent <raven@themaw.net>
Subject: [PATCH 7/9] autofs-5.1.9 - fix direct mount trigger umount failure case
Date: Thu,  7 Aug 2025 14:20:05 +0800
Message-ID: <20250807062007.14996-8-raven@themaw.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250807062007.14996-1-raven@themaw.net>
References: <20250807062007.14996-1-raven@themaw.net>
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In function do_umount_autofs_direct() for the case where the trigger
mount is found to be in use we should be detaching the mount so it gets
umounted but the process can continue using it while it has an open file
handle for it.

This is because direct mount triggers are only umounted when the map
entry is removed from a map or automount(8) is shutdown which n both
cases the trigger mount needs to go away.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG       | 1 +
 daemon/direct.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/CHANGELOG b/CHANGELOG
index f92d01b07..ee1d46987 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -38,6 +38,7 @@
 - fix skip valid map entries on expire cleanup.
 - remove unnecessary call to set_direct_mount_tree_catatonic().
 - remove unnecessary assignment in umount_multi().
+- fix direct mount trigger umount failure case.
 
 02/11/2023 autofs-5.1.9
 - fix kernel mount status notification.
diff --git a/daemon/direct.c b/daemon/direct.c
index dcd69254d..7648b301c 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -153,6 +153,7 @@ int do_umount_autofs_direct(struct autofs_point *ap, struct mapent *me)
 			} else {
 				me->ioctlfd = -1;
 				ops->close(ap->logopt, ioctlfd);
+				rv = -1;
 				goto force_umount;
 			}
 		}
-- 
2.50.1

