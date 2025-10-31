Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE4C221721
	for <autofs@vger.kernel.org>; Fri, 31 Oct 2025 01:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761874693; cv=none; b=mqqBXUR2wK4qB2D3AGi0+mWQjoIaMbmyiHMg7RYDxIeCtKJYXOqCk1hf8k7TPtrvBVSGdX4SXGsN1uSRnpSp0hTvTisWW9iSToBWV7llpEjCBqK0Qs2dVv8ZxJ2us/3HXaKy49JGUZPVkFLKHJcx/f6WFZ2Vgc3ncHzvPzrqY24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761874693; c=relaxed/simple;
	bh=FKVJt+I8DL8oi/m2+/QTrHSYCZRVk6ziYeMWIA7w9vA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DKyjC3PwvCiSozpJrnsG96xA9LaE8TUlT6x24s67Zd4XOX6MCHs5lNb/yHFj17LIMYAXHhjOCRtjyMObKxu3QbQMgNyppcag9DrwlN4NzDmE+RodbZ6gaSfx5daZ3VqMNVuepTuont2Fl3zsx7k6jHTYayIhyUXmXu4V7zm2o3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=GywfDZlf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hS1091Sw; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="GywfDZlf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hS1091Sw"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id ADA3B1D00133;
	Thu, 30 Oct 2025 21:38:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 30 Oct 2025 21:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1761874689; x=1761961089; bh=FKVJt+I8DL8oi/m2+/QTr
	HSYCZRVk6ziYeMWIA7w9vA=; b=GywfDZlf8ngcLcvPMFo1OFk8+jOGqvX3S5udu
	xv/1Y/0lWzqhiDMRfTawNzBkVS08yrGyD63ZMna3GREbeqXQoV/DavvPUdbgyOdf
	PGWDFB0v6gOvCrS0tyAYNd8nPONIhUOKZgad9BUYNAzypqOTCA4t5UaIoAAeTyVR
	Y0puFZx73l37/Qe9FyOJXR2d+NUrIROl91/UKa4TVhNGTBIpFe2UXObcwW4Qez9J
	ep/AJvWA+C9fkKlAwKwjJYctThgwwTVs60C2nFC6my4QeO01eP/xwIv91Ow2wz1w
	3eVH2USdA24SRuyHpZd0U5vJjyyeXerR66ebGcLKAPcZ/VGKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761874689; x=1761961089; bh=FKVJt+I8DL8oi/m2+/QTrHSYCZRVk6ziYeM
	WIA7w9vA=; b=hS1091Sw6DzaC+8+0N8Hp/w77uVhsDFJN9mwimSQjWZnt/k2YA+
	7UrvTK7ZeN0NIZnsgsZa0cF6qAJPI6ID/f2TTAjfv6CyVw8lo+T8plK7/RUpSZG4
	zN7LyZqPu5mEb4RHgOC/mkyYpobUqgNLbtwG7Tb87zc1Hb3BbxWCrwYwQDGcJYFP
	Jr2KDJctySUt4UqjUoQFP79fmvmDTUc/8RAslobNamXNIfutEktFY2t34KBaS0LZ
	c7bnA/mpbvVlNDZ5R6seGtxQSl3tR5vK3tXvhma4wFUI2LuAITz4g5PIjBWURQfl
	cEZ7x6wg9TxVQIzKDYPq3dmep4zBmAOerIg==
X-ME-Sender: <xms:ARMEaQpX3CHqMAcvjIkxgSR_zSCm5HjV_3jDSLPC-LBfqK53j4OwUQ>
    <xme:ARMEaeECDvyAr-08OSCxfSppue4Gn4MTo7rfX8s53HlEpFYQ0NwMsvAlwlZvFu5GK
    0oPR8_bj39R843cBTehBzVBsaSCC7Jvl8ZSnPVp5NgAWy8>
X-ME-Received: <xmr:ARMEaSlod-IVo6YwCjJJ5n5PASlUQCT_aEt7qusNDZ37ocf0vv0LOeVYeo0KXhGBaAKQyh2y7ygkAkwwHRpMaX01f2UOEmB4irdz81kiWRooHCZS_kQPfxVefQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepkfgrnhcumfgvnhht
    uceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpedutdfhve
    ehuefhjefgffegieduhefhtdejkefhvdekteeihfehtddtgffgheduleenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmh
    grfidrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepugguihhsshesshhushgvrdguvgdprhgtphhtthhopehrrghvvghnsehthhgvmh
    grfidrnhgvthdprhgtphhtthhopegruhhtohhfshesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:ARMEaRmzAjHs1q9LItboZXaw-kVyGuUqlt_ObZfrFkt4G9R0iVqK_A>
    <xmx:ARMEaTszfH4JhyrzoE8Wav9fGOfYECPyyFe_RhwJr4k_KqQcCxxWMw>
    <xmx:ARMEaUlT3t-TRPGbqPZOXhOfzWr3pawxzE4mmPunWUb8XIqp5BK24g>
    <xmx:ARMEaesVnJNHwHflszcPsnjFuKGGTBHrghPA0ow7aWdQP_JLSm4mcg>
    <xmx:ARMEaWuf-9Mn_6t95sTafkrjce4g7jhXAdgCkBd67cdl8d4-dMdT9ER->
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 21:38:07 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: David Disseldorp <ddiss@suse.de>
Cc: Ian Kent <raven@themaw.net>,
	autofs mailing list <autofs@vger.kernel.org>
Subject: Recent reports of a failure to find a direct mount map entry on lookup
Date: Fri, 31 Oct 2025 09:31:28 +0800
Message-ID: <20251031013745.11150-1-raven@themaw.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David,

Here is the patch series I currently have for this problem.

I've also tried to describe the cases I think are at play and if they
are resolved by the series as well as the case I think is problematic.

Please feel free to use these in any way that is useful and any thoughts
or improvements are welcome.

The little evidence I have related to this problem indicates it is
related to updating (re-reading) autofs mount maps. Review of the
source code surrounding this map updating shows there are a number
of cases.

Indirect mount map entries are far more tolerant of map updates than
direct mount maps. The reports I have are related to direct mount maps
so that has been the focus of the code review.

An autofs direct mount can have multiple entries in the master map and
therefore can consist of multiple maps. So the same direct map entry
path can be removed from one map and added to another in the same
update.

This is one case that needs to be handled and problems with this case
should be fixed by the patches resulting from the code review.

Another case is where a map entry is removed but has a triggered mount
covering it. Fixes for this case should also be covered buy the patches
here.

The third case is where a map entry is removed from a map, there are no
other instances of it, there's no real mount associated with it, but the
direct mount trigger mount remains mounted following the map update.
This allows the kernel to send a mount request for a map entry that
doesn't exist. It results in a fatal error because automount(8) doesn't
have a way to communicate the failure to the kernel as there's no ioctl
file handle to do so.

This is I think the case that's been seen here and upstream and remains
unresolved.

So far I have been unable to work out how a mount trigger can be left
mounted when a map entry is removed. As a workaround I have improved the
handling of this case in the mount request code. It now uses a method
similar to the that used to reconnect to existing mounts at startup to
open a file handle to send the failure status to the kernel (the last
two patches). While this method should work almost all of the time it
can still fail so I still need to work out why the direct mount trigger
isn't being umounted on map entry removal.

Ian
