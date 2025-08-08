Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49DA645
	for <autofs@vger.kernel.org>; Fri,  8 Aug 2025 02:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754619425; cv=none; b=RBykd6eTS7pl1qzPjhtnF410VIun1Lws3UzDZgu0iUN185YyxCJQZ3cvlr/5Pam4kGaLyzoae/dPliz9cNxJ+7O4cWYQEacQJZqm0Rn2V13eZr1hoZD4tjsdhNAHwUGa+lLSAWNgCR5RDASlbxPZmmZV5/Jx5w+2+l3UkOu3Rgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754619425; c=relaxed/simple;
	bh=6cjXoM6e/ItTcn7cKJpfxKVCdj2ecKaqPmQCQhxL8P8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t4uggkO+CrNrCdn/3/8HCVE6wJWtDnbnrnEXb+RbwwU3hI/jGGoeu7w/rxarwTolr7M/q3KQIXefIc0RK45umiGjxO+PI2JHRTWfQs8ODntDi+KGE+qRy//t6XB5wq0/7kTld5Zq3zQohex0aTeCy4vWVxxIRZoqAtVPrIcR4mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=gEYt4IgQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XjfzVmOi; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="gEYt4IgQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XjfzVmOi"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DD5BB7A00BF;
	Thu,  7 Aug 2025 22:17:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 07 Aug 2025 22:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1754619422; x=1754705822; bh=Kv8Jqmt1iwtlx72g9qrds
	oLmqds0LF/DjkkdnirZYQc=; b=gEYt4IgQN8iAbXM4B5jbAxVjNC/4spzdPZAjd
	bJsahqZtiYF2aStjTzinqvU02lLkTOjR3FYb+HFpn+ykWJXsM2kPTSGbTf6VSyVF
	S6a0ORbwsp9HasdsZ+1C6n9D2JmpCzd4kRLQMyfEf8B9lrHJIAvkAmZUsOHACCnS
	gPdqpCLhEn+Pnno27g9JR6gTMspQEhMS8N/fUDtUFb5zBKlwufFMp5qGIN0xYrdf
	+7vw6sG1kY75oiYyHgkFPX0LdeBbB9r/Fhjh8gzviJFzlwxNUS1vtYWEe+tAN1rq
	pwvyFPcKceziMXXojZp4I3O9FZrn0oQXGbfZCOKq5cj/4KhGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754619422; x=1754705822; bh=Kv8Jqmt1iwtlx72g9qrdsoLmqds0LF/Djkk
	dnirZYQc=; b=XjfzVmOiBDe7tpCY4O9Lw4dGOD6Iwl8ryLJdbbbcaXs0eOXo0s0
	M2eKnu2YUswJ0lS8IgqZqpQh7u6To2Y5aMETUSFxtXh/xVlPBxN2SNKkzgELAKk5
	dcylDCJbnxnC0/lipCdDLhqPuIQ83txVmd8OnD2+yHsRLTNkZ5xfu4F0pD6GmcXk
	QISB5j4XMnBsizU2fKSg+W2rxLug2Zn684JZ9G7dxB72sYf/QFw7gzE5ZqoyoIEu
	M+sy9C96osiGi1m3Z2P5KmtGswH/siQITlX0MVQ42QZqr4c5fNq4yW2xdjIKXvBl
	Mbpo8VrJfn1kzeZaG0a8JBFZBnzALOwQyNA==
X-ME-Sender: <xms:Hl6VaNdjs1pRYI0ef1TeI900z9MARhW9BIuDJ0SnmIn7Cirt7Sy6iA>
    <xme:Hl6VaOe0xnpExlSmD3jR-_Kv3oVVRDILF-3x2C9VL3nJzg8W0AfmaZjF_ahzfL3Kw
    _woHWnEIVex>
X-ME-Received: <xmr:Hl6VaP8T4cxNHnpYbUByAY0_sQIlCEX9WU3FExrvQWuB7oBSAg-L1xFHVLvD9ckk4qzGNYJYiJpqXadJjqQIzY_gzfneeAT4xjQaJgxj8d34EOa1x0rR8R4oNA>
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
X-ME-Proxy: <xmx:Hl6VaCkZQm9vKp8cj8FEHOo8ZQsi9tyojY2AgiYflfYQqQ2ccb1lcw>
    <xmx:Hl6VaJ8NHYzE5YZ6TD0FbIeJizxmHaUyhNhlgJtJ09fG7PBwO889WA>
    <xmx:Hl6VaImwAqE24obKf_sFZblzcCxaVwSkuMOTZT5CYMKEfce38LAUcg>
    <xmx:Hl6VaO0AO-jLxDZrk88PomDqJL2F07ac4K8rh4m0gT-NVt7me5nB8g>
    <xmx:Hl6VaOtxjB_p8Y-iEDe7tqPVfncZyIJapebHAbOscstU5ATWLyj2Tchs>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 22:17:00 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: Ian Kent <raven@themaw.net>,
	David Disseldorp <ddiss@suse.de>
Cc: autofs mailing list <autofs@vger.kernel.org>
Subject: [PATCH 0/9] Patch series for direct map reload bug
Date: Fri,  8 Aug 2025 10:16:46 +0800
Message-ID: <20250808021655.12774-1-raven@themaw.net>
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

