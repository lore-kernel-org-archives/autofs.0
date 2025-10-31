Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F2B24DD09
	for <autofs@vger.kernel.org>; Fri, 31 Oct 2025 01:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761874761; cv=none; b=OyL1rZKpAHx6GSGxrZ1OqdmDJwDypSysGSi2uY3lW21OyzynexMC/0c5qorJUjNDPFK+HXCuMfe4Euaq9oa0AJ18CCxKBJTNMXW+t2TDKXzusO8M9Rns6x01spkSTuCCytvew/dpa8/y7fhh3TowCE5gQfIEUhCa9L7sDJ/BKDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761874761; c=relaxed/simple;
	bh=tB0ktYZr43KCzurLOhN+01y2wbPl64JZp8R3zPMCm+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4YyY9BJaCs3IA4Ome6iegzeDodnexCFSp50gXP4CtZRyRPYBH9jA1KV8IJIkqd42pLMM+preRRpA7Vv8oU251OxraHaXJW//xYFy0xLZDcODfF/uqaMixw9n3ggYKzHnyANKQIOtU0K4TaMQLlAgcn4yZA7SaIbs/eWv8QNxhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=Ipe5oc+k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QH34aLs0; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="Ipe5oc+k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QH34aLs0"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E56227A00EF;
	Thu, 30 Oct 2025 21:39:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 30 Oct 2025 21:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1761874758; x=
	1761961158; bh=I1cd28WPwMtKFNYPauWH7CwuiUlQTtXGa4tqQjYBRHk=; b=I
	pe5oc+k6VeKiK2fXUjUDG7kvoHND66eGaePX7TD+9qlnceOd3gGcj3dxara55Axb
	PITlWC8tgWsHCAB+EjQ587jttpMe/izY5is6fE5T4jFFSRPPepie6DK9Sv1FUaCj
	wng362AxHh5IlK73aNFFLB9KykB2Ixc9jVmE7d3AsEwl3VLoKirYA2xX6o+TiE4i
	NQNLdqzfcvfIb4KelapJ0jsgFR8Mzz1B5yeG14mMR2fjN8YlS30Qmju1fG99GTEj
	tWQbnH0E38CMiRXgNPMc4MLuvMf4JX/ONT9sqYjMaVLSnr74+T7wT4sTOd8AI8bO
	TvakguAvd+9WFRKrPiW8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761874758; x=1761961158; bh=I
	1cd28WPwMtKFNYPauWH7CwuiUlQTtXGa4tqQjYBRHk=; b=QH34aLs0JqosToQLI
	9AhTy04JvJ4+fnUh4t8nba8EcdYxQiZNEOv6yhnP9gXAdEz8SSOsvqlT77Styx7T
	OHfdbgDuGXAwss92xeHDbeq0t47u1+5x+dObAl4oKgJDAYUBaWvp0aetSixJIkzx
	BsvFfnVNQHKXXMehcpzwnWm9BeAYEOWpBX4HBzNyyqfCtErIL6u4oCOmQx67Y2T0
	/d3uj8m6PTbw/cN9OtPFpd/NZVeKXnb4XnpUyYLP3mUX3VSjNEJrO+sNgBeS9TTB
	UjSKGxiqumSd75DLj2y56iajO7dxL+iGUpn1Bz3xR8vya8ZAFJBfxUNUYEtJM2EH
	WerBg==
X-ME-Sender: <xms:RhMEaV20wmtN9-UBlDw3qiIBCT2osOrLMBdI2v7Y3WnYzIJ3Uy8vPQ>
    <xme:RhMEaThRgG0Wgl-1SKRBtOC3vq88ILw1SVxxTjx-y1pzggjVipNbZ8hKPuWQHMVMa
    9jq9PktjtbahXYNlTlMc6Afj3BkWN--NwRdB2_v6Q39mEwG>
X-ME-Received: <xmr:RhMEaTTtuIy1nUJi-kV3qN0r6HOnjn7Ba9_J4rq0lOSdvGNDBxu84i0Rb5xqMXEfZCX3ZKsYjp7kaFGohtQcg0vurC7p6GdLpf2KfAdc6vfn5IMwUfOgbwycwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpedule
    egueffgfehudeufedtffeiudfghfejgeehvdffgefgjeetvdfffeeihfdvveenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthh
    gvmhgrfidrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepugguihhsshesshhushgvrdguvgdprhgtphhtthhopehrrghvvghnsehthh
    gvmhgrfidrnhgvthdprhgtphhtthhopegruhhtohhfshesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:RhMEacg6lLwJizzCVL-o5UIqNgOJbvHjqVKLPUwCgyvPQTF02mQXiw>
    <xmx:RhMEab4yroKqzyo7yaqf--64qBMc8x5Jz2hzEPArhenxEvMz2I7sEQ>
    <xmx:RhMEaRDQe7vpeJsQTSyJ18u8XzWZhog359I87Pd0oJjmefOTYshDAQ>
    <xmx:RhMEaaYAOS2UUeASa1lM6jomY0Y7P9DLe8xoXRjmgkPZlvFOQ5ZTsg>
    <xmx:RhMEaZKtog1Z3j-jXwbZgZrjiNI7FYeY-bmLIgNq9zOVtNM19yJ55LTA>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 21:39:16 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: David Disseldorp <ddiss@suse.de>
Cc: Ian Kent <raven@themaw.net>,
	autofs mailing list <autofs@vger.kernel.org>
Subject: [PATCH 07/11] autofs-5.1.9 - fix direct mount trigger umount failure case
Date: Fri, 31 Oct 2025 09:31:35 +0800
Message-ID: <20251031013745.11150-8-raven@themaw.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031013745.11150-1-raven@themaw.net>
References: <20251031013745.11150-1-raven@themaw.net>
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
entry is removed from a map or automount(8) is shutdown which in both
cases the trigger mount needs to go away.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG       | 1 +
 daemon/direct.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/CHANGELOG b/CHANGELOG
index a8aabe797..60fd2554c 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -74,6 +74,7 @@
 - fix skip valid map entries on expire cleanup.
 - remove unnecessary call to set_direct_mount_tree_catatonic().
 - remove unnecessary assignment in umount_multi().
+- fix direct mount trigger umount failure case.
 
 02/11/2023 autofs-5.1.9
 - fix kernel mount status notification.
diff --git a/daemon/direct.c b/daemon/direct.c
index a97d18348..97d64bc69 100644
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
2.51.0

