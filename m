Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961551A705C
	for <autofs@vger.kernel.org>; Thu,  7 Aug 2025 06:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754547643; cv=none; b=WSjrZVLOoHnRJWHqOyxiFI/7mhyoayS6vhraWb+af4vxyKlDnisG5CT0rQcg+QOGKblMWzfyT/0x4yz8RF31ZX35Z35Cbtnv3wURcdYCBEVlkknkTqypQ6YU1gvcU/XR5OBQsUktAdzToQqa+EdUhhsTlJ4FF0Ltx2cCJ6R+tKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754547643; c=relaxed/simple;
	bh=6cjXoM6e/ItTcn7cKJpfxKVCdj2ecKaqPmQCQhxL8P8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oCD8zvJC+EmsZ8KFqKSjftkRjoOySd70RfESUBlqgqpk6b9sO3xmWJcYv37LFcoJ7L2dpoo9N+u2ieanXt1MQn2EFgUPFmT35AKUG0CnEG5cCUGbOerwNoi8Mo+Z7Q23QBTzUV7b/MSOIH1VkKtDqG6TiWgX5av9cG5Pbs4gBqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=K+RyP1/8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JG1Mer9p; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="K+RyP1/8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JG1Mer9p"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9CBC91400182;
	Thu,  7 Aug 2025 02:20:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 07 Aug 2025 02:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1754547639; x=1754634039; bh=Kv8Jqmt1iwtlx72g9qrds
	oLmqds0LF/DjkkdnirZYQc=; b=K+RyP1/8GqJZfS7+ov3jGskwIExxs9lYp8YWE
	pCRgS6SRINugvcCcLXYaqcNh/sJIyTk8AppHmt/xeKa8Ki2q6VVt8Yfe/uF34Z/0
	FLM7JXX+DUg2f4IyXfrWnmuTLmwGpFSO/vOEQ9qGAq2FjFI1scgQJq9MKil1e9mr
	2Gxty3Vtt+2npod5WE8yhuWC5wZaG35q8HWLaECRpY6dTVvcjecSzAiQy75qPOFV
	9FMBFzz8IA/A9FwSQMZrkFbGjN32SSfeC/K4m2+Ccf8iATejWDlR7tgKRhxlUVtN
	8i3GQda9iZ89+/OvQ7z5T44Yj5B3XfaJskYG9g84sQmgHyYBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754547639; x=1754634039; bh=Kv8Jqmt1iwtlx72g9qrdsoLmqds0LF/Djkk
	dnirZYQc=; b=JG1Mer9pfEeVU7TqYX2UqseTp+8+EewUOjAXPYFxO9Iia4tge8L
	Vb9NMLowOHG30Co4fRoaQGfioBsSZPpHsSF17Ld+fcm/CQQaIYLtsLpDaDBxkXOQ
	YNsmsVF/pMxAigi37tD2JhP8Vqd+5Gm9jTkDLDpiaiLCSV4rnC9C6jgzmsu2hE9V
	nsMMwXgCh8an09S8Xu8QYKkcSNbZEO7fV3Q5gn+pKTDXhn760tFgpxkgFfYxncm1
	n8QZaKSz3u/mBCVl8xQtVk6A6hHCaKBJmZAOs2YVMsFITMQW0M96Vn9Xm/1s1KGi
	WztOh0aHFBmkZgOzJuRx2PVvUHWHcQP1e3Q==
X-ME-Sender: <xms:t0WUaH0YreCfPJb88TlDWz2Kw8e_1lj3p4e09WzCvKimU6ucW4tSsw>
    <xme:t0WUaJXDbVuP6U2n2V-t-xXoyZcvYTh2mT7MzdYtaTmj7l4DeMPzozEeQjBbaRDxP
    20PGPwCcLab>
X-ME-Received: <xmr:t0WUaBWomvfqmuQQzpvgqVLGZTzosxeSgP6lMPK2SEO9_NbVGthuSl4rrZzWYzQHCcfM0PgaN6og4NAezbsiJh2FpGnSw_7rbZ6yZ0_a-qb8ZB_GNF9fF5w-yg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepkfgrnhcumfgvnhht
    uceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpedutdfhve
    ehuefhjefgffegieduhefhtdejkefhvdekteeihfehtddtgffgheduleenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmh
    grfidrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepugguihhsshesshhushgvrdguvgdprhgtphhtthhopegruhhtohhfshesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghvvghnsehthhgvmhgrfidrnhgv
    th
X-ME-Proxy: <xmx:t0WUaIfqmfPc6GJGAnyWceKEhgvryUZAzwnAJ4-7b8ED-1bW0IvMCA>
    <xmx:t0WUaKWmQ1I1j5KyAb4rExZHaWejpJa8WjNlAiSjG-kXwyuDQlz-5g>
    <xmx:t0WUaBc8dfJYtA5sMxFzBcL29iMmAPVNhgForHOnfANpA-JMDTY4Hw>
    <xmx:t0WUaGMASkpOepmvhZSzcOFSyXCTl-q_GOJBIqXwu2TgK_Dnb-bc3A>
    <xmx:t0WUaDlgA8Rfy6rGaood0XJ4yoFlJBcQRG5lpnTI7_h3404bjSCb4Lnj>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 02:20:37 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: David Disseldorp <ddiss@suse.de>
Cc: autofs mailing list <autofs@vger.kernel.org>,
	Ian Kent <raven@themaw.net>
Subject: [PATCH 0/9] Patch series for direct map reload bug
Date: Thu,  7 Aug 2025 14:19:58 +0800
Message-ID: <20250807062007.14996-1-raven@themaw.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There have been reports of log messages like:
automount[nnnn]: handle_packet_expire_direct: can't find map entry for (1048647,114082)

These messages are fatal because the direct mount path must be known to
lookup the mount. Historically the autofs kernel communication packet
size is fixed and based on the maximum path name component size used by
indirect mounts but direct mounts have a variable length multi-component
path. To solve this while maintaining compatability with indirect mounts,
an index of (device, inode) tuples is maintained to allow lookup of the
direct mount path so the map entry can be located.

Also it's necessary to understand that direct mount maps are always read
fully in order to mount direct mount triggers for all direct mount map
entries so they must exist so this approach should always work.

So the message above only occurs for direct mounts and the ioctl file
handle used by each direct mount is stored in the map entry so it's
not possibile to respond to the kernel at all if the map entry cache
entry can't be found.

Unfortunately map entry cache cleanup on update is complicated and can
lead to problems which (I believe) is what's happening here.

While I suspect your reproducer is a different case to what I've seen
it probably symtomatic of the underlying problem.

Patches "autofs-5.1.9 - fix devid update on reload" and "autofs-5.1.9
- fix stale direct mount trigger not umounted on expire" are the main
fixes I was able to identify working through the code.

Please test them and let me know how it goes.

Note: The CHANGELOG hunks will conflict so you'll need to compensate
for that.

Ian

Ian Kent (9):
  autofs-5.1.9 - quiet possibly noisy log message
  autofs-5.1.9 - fix devid update on reload
  autofs-5.1.9 - fix cache writelock must be taken in update_map_cache()
  autofs-5.1.9 - fix skip valid map entries on expire cleanup
  autofs-5.1.9 - remove unnecessary call to
    set_direct_mount_tree_catatonic()
  autofs-5.1.9 - remove unnecessary assignment in umount_multi()
  autofs-5.1.9 - fix direct mount trigger umount failure case
  autofs-5.1.9 - refactor do_umount_autofs_direct()
  autofs-5.1.9 - fix stale direct mount trigger not umounted on expire

 CHANGELOG           |   9 +++
 daemon/automount.c  |  35 +++++-------
 daemon/direct.c     | 130 ++++++++++++++++++++++++++------------------
 daemon/lookup.c     |  33 ++++-------
 daemon/state.c      |  17 ++----
 include/automount.h |   2 +-
 lib/mounts.c        |   1 -
 7 files changed, 118 insertions(+), 109 deletions(-)

-- 
2.50.1

