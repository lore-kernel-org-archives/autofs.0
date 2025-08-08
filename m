Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5FF7DA6A
	for <autofs@vger.kernel.org>; Fri,  8 Aug 2025 02:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754619458; cv=none; b=WbdxCChQtSQrbaxR+OBhVZWAJ5Vl6hD/fUiZoPuVUiMiQaBUzh0ZbLh5UMtYYh8A5jBZmVwM9XYO5IU2hgILpz2mbaj9zLRh6c5XuclJrfajS48eCxwJG0RO2VQF2YgGYKv/UHqm8Xj/MGeCIAF99W7dhnAN7KdCF96fzb+D1mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754619458; c=relaxed/simple;
	bh=BPWmkr/MDE8sVg4HEZYFptHHkJMT5vd5yWvC42kuhds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTmOvcIpJ4wEfzrXJcjobv6ALJXhFMwPxLlO064XlSW4BTuSLKNqlbMD6F36mOPS67jMAzx//OZFG6vTkhlqEAhancPoBe2cCp6McCGX9bczx9cd4p+9p8QhmDI0sDA2F4GAWLSveUGlPm3J3MJVy+Cfm1aLGMxsIsNkXHBTtG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=iIrK6Wuz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qdfg5QRR; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="iIrK6Wuz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qdfg5QRR"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 116E11D0013A;
	Thu,  7 Aug 2025 22:17:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 07 Aug 2025 22:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754619455; x=
	1754705855; bh=ueD4cBITdTrLUP0YKwSxCUpgALUhmYDB31MZsFPeOTI=; b=i
	IrK6WuzULpQGoO7QAb+SEwwx90E6qAdbSl5Nr9fmwIOEV+rELSl6R7YrpGeaFeiH
	QmzLYQnFULXf+udnvKQ1Y4iNY7CRoeHmMyaoUeAfQD9B5MFu6m9S4KY/ne5Kcbl+
	Gyuy52i7zs0hAlthAAot2hYdxjCloHukUfPne7LR+e6JMPuCXYFwxzTuL4kezA0w
	6olRSoDtwE1bpn/tOnqXCmDmfrZ+w71iFT5h7VdNU4ZvG+Z+P+8IZiVb0HMoCiXp
	QQQVWvtINX0nNGLF+5NOmU1+hwnBlBSLE9hgOs9W+oajYmsqguDCRjFuBGPbbVag
	kyeD0jpoiljvKtFVpCB2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754619455; x=1754705855; bh=u
	eD4cBITdTrLUP0YKwSxCUpgALUhmYDB31MZsFPeOTI=; b=Qdfg5QRRacIIi67hj
	9+7T/GfnrdfDaBrqnTPcbJZYhwAgqVai0/MsqnVsTboecLl7GlqJCTDyVRzVvjxC
	33isqova8BLjiUnDhRgY6nkF6Jjv0ebz3zlLf+r2ddQnip1T4Xb/XE/2yoQXnPDb
	Qtgeji76Z7ugkqAT0dVEJ9FP+ggxbbWgGCIxOaFUJT59NWJoqY33R0gYKHZaPPsS
	rpPodWEemR+krUvW1ZGnXr0rICKOJOfIDtJCyhXYIw60UkUH8ajwwxm5zfiFMDnx
	pI/WdT6miqAZek7GW6vLa/+aO3+V5tCPcuqUOTAGYcRL7AEWZCFWlUIH9SizqwVN
	yheKA==
X-ME-Sender: <xms:P16VaPW8DWWBF_x8IjQS3Ry7XxEyw6MDSpFctpT-i5oZmGqIINVt4g>
    <xme:P16VaK2a9zq0B_nR540JL7GppM8lrUxD04Fa3oV8l9JrI0TiyiCzNtmOO1MY_a9vO
    SiA5TwxwOWc>
X-ME-Received: <xmr:P16VaE3NqhaYbdVh7eKzG6mgud7_H4ULWQ7VW7MpleP-r-bXBobS3UIr3msEE3bl7ddKVYIqy-deVv8kiuzXEfg7UnmZ-aOTs5nOzm70P5SO9J0G__EGl1cCog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddvheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpedule
    egueffgfehudeufedtffeiudfghfejgeehvdffgefgjeetvdfffeeihfdvveenucevlhhu
    shhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthh
    gvmhgrfidrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheprhgrvhgvnhesthhhvghmrgifrdhnvghtpdhrtghpthhtohepugguihhssh
    esshhushgvrdguvgdprhgtphhtthhopegruhhtohhfshesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:P16VaF8Tio7BYZMtiEzbQBNgqmImo4Oib1D069b-mJWf_hUTqEN7VA>
    <xmx:P16VaJ0aVwacrGNJ4eb_nPLnJ91G1gbErRyyEi2yvnomdj5upMdhJQ>
    <xmx:P16VaK9sjhGHET3mLCWIb5u9PmzzQBUggmR-BUd_ueQdm7i6eIt3FQ>
    <xmx:P16VaBtBzMWE7GX5lxURkfzeIHCezBMAE3YVvfPQcRrm1y08LiPb0A>
    <xmx:P16VaNG3Xkl5KEIVn_RReSK2ti5KbkmcU4NVZuMXSjx4RzcpHfgv0S66>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 22:17:34 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: Ian Kent <raven@themaw.net>,
	David Disseldorp <ddiss@suse.de>
Cc: autofs mailing list <autofs@vger.kernel.org>
Subject: [PATCH 7/9] autofs-5.1.9 - fix direct mount trigger umount failure case
Date: Fri,  8 Aug 2025 10:16:53 +0800
Message-ID: <20250808021655.12774-8-raven@themaw.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250808021655.12774-1-raven@themaw.net>
References: <20250808021655.12774-1-raven@themaw.net>
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

