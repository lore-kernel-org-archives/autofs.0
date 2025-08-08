Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DDC645
	for <autofs@vger.kernel.org>; Fri,  8 Aug 2025 02:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754619395; cv=none; b=UuxNIdlMF7M+bbQ9SUXfbQKDclE11IvWeOat+HWrmxC+Df5XwM3duT6V86PM9KwI8vdetmntlTg7Us7ybPuUWeCrP6TWbdDp2Io9AxSIaZEf/tqzpgi0OQ7IjiKpImoAnpmaZWMcIU/n3KQnXsOkkkDifnRxatH+cFhKqvcw7v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754619395; c=relaxed/simple;
	bh=6cjXoM6e/ItTcn7cKJpfxKVCdj2ecKaqPmQCQhxL8P8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PsGd1Fvns/wtmiXFac8M1J82Z1qJxrlVEQJRsJUBtk3G2dYVH8gvI12dXxyJLCAlEqlCfkdnsALSdDhuvyqJ8au7M+4ZOsjE8Scf4gPbEk74uH++l6R9H+JNTmRbz3ByBs1BuDUD+bulYzfOPEJUspdZ9tSXWFv1ftbnmmklirw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=Jjsw3Tx5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OQzDpG6I; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="Jjsw3Tx5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OQzDpG6I"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2D60C7A00BD;
	Thu,  7 Aug 2025 22:16:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 07 Aug 2025 22:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1754619391; x=1754705791; bh=Kv8Jqmt1iwtlx72g9qrds
	oLmqds0LF/DjkkdnirZYQc=; b=Jjsw3Tx5bc7iFAoAS2rgShQvs76o7HDDMVxxg
	EY1bVKzMTC9QjR0XVfHGyfNA8zWcboJ/HTlDIWHd71e4Eu2S1D9yuz4Kj/TzTckY
	VrNewHu342hURO1FRYfzidNcBqX+MG8wHnUcppmmFOm0Ou1vCKceiYAqg2bUBlJl
	j3U2S78TZKQ/PpuRckuFMGSs6gRAa5EVOPNvn4ZyquJ3gW3Y0DTB7FWk6BDjh6QC
	ahWr6POTojOjVctKA5I5DwPDjWZtTap/B98JyyAGV4JqnhHzUfxKUkC8ubg7ICjY
	z/za/xqDFPkfqLr2Di4iQvB8VH4VUy6dpV0nj/sQnoAMqthTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754619391; x=1754705791; bh=Kv8Jqmt1iwtlx72g9qrdsoLmqds0LF/Djkk
	dnirZYQc=; b=OQzDpG6IQTiytvNCcUtf0vPQHyUVBoITaTPDAg2QdRzt2mpwi2/
	Qge6oF6pMS6sa0t7ZvHm4hqaeZZD9TL0si+mHFN5VNkdF8HE+x6dAFHQ1yIXjIPd
	ySU9uzpNMdeeItxuvG2rTEOXnY7zPJwqFkyap8hmTx8msA41jkghQl8PnZwdHf5U
	HRStrp7F3etBc0f3QYqD4EKHE5wmJaI6lvLFwcEZgUu9obC6wT4HA7IUJSy/fvzz
	8HaVTR/pa1WBeRIBjueU6fTsmYOGX08ZJCKgDGMiTbuw6Csd7mNS2ZlNLa9TUfnv
	yYa7zFYChs6O28V8jCR2uBaQeJHX8GT91tA==
X-ME-Sender: <xms:_l2VaC6bj0q5XMQj1B6Cuqt3Ahk05unTs0MLy20Yr3gU9zD0J8itBA>
    <xme:_l2VaPJudut8jzh7b_PgWLe714vaGKrd-r30bEXU1ZsFmvIOAaOLXuACeiFnFyju-
    IAAWTbh8PMG>
X-ME-Received: <xmr:_l2VaK4s_bRjgya9iVDNoliKQLsPgE1xOxPKdTJKIGzn7yAg8FL13NiI8rVb1PqP_TZJZjxTQ5AZPfiftxcwUt-Hxmo4iMJ_DKL4Acnv7KOSYHiocRJQHvwZAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddvheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepkfgrnhcumfgvnhht
    uceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpedutdfhve
    ehuefhjefgffegieduhefhtdejkefhvdekteeihfehtddtgffgheduleenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmh
    grfidrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheprhgrvhgvnhesthhhvghmrgifrdhnvghtpdhrtghpthhtohepugguihhsshessh
    hushgvrdguvgdprhgtphhtthhopegruhhtohhfshesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:_l2VaKzVuQQd7ppQF9mnuUFG7iH8fzUZpLLMAS3IFCMuszuhlCzubg>
    <xmx:_l2VaGYDOiYLSot_RkpKvw4qI-JzObrePuzqXBqi697_cVWqvqqxAA>
    <xmx:_l2VaEQgnGl72ngBcp2Z1YHtl3Qr3FhYHE71gdOfKtJe9i657Edwzg>
    <xmx:_l2VaIyVVVagR-Cdi6UAgj3mJKValjLJbUNfjl5jAhAYxPz5pstbkw>
    <xmx:_12VaIYndzZ7tm_r79bhNGd7Lpe6jOcwBTQE4mW_nfUydPzAfWsG4so7>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 22:16:28 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: Ian Kent <raven@themaw.net>,
	David Disseldorp <ddiss@suse.de>
Cc: autofs mailing list <autofs@vger.kernel.org>
Subject: [PATCH 0/9] Patch series for direct map reload bug
Date: Fri,  8 Aug 2025 10:16:06 +0800
Message-ID: <20250808021615.12696-1-raven@themaw.net>
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

