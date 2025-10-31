Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B448E1A0BD6
	for <autofs@vger.kernel.org>; Fri, 31 Oct 2025 01:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761874771; cv=none; b=MT1nl1pxcw8fSW67t0zDAUBK9r30h3DlRrZbspg5kMOzI9qbB2pf0fQwP31Iao+3+XHezABk99EmvDrMA1Ww6oO0c7oOYolbhrZhb8wHN0LLt1H+mCi0kpS+ceZ5JQ6wZXX82te90olyHErj1nAsFTmITh2BaO0EZ8rZSh2MYcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761874771; c=relaxed/simple;
	bh=Jx37GE9I25oSFUXNZJsOw+QA4c9R5/EyFJBP+y8s63w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTB6qxYHWv6qKOAfrgIkJBIMyS8Eq9GQhod4s+Au2W+j+prjpdOk7cN2m5PSvpH9pIDp4ZnFHKNL+3bJqXu+1ySwhBP/MZjVbnNMrzsOcA3CxISPdunwkePe05pOt/TAw+NEJ6GLxrv9KWAhIPHU2ADENCXoyUz3BZwEkUt+pu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=FnZcpV/y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uIzrJRzA; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="FnZcpV/y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uIzrJRzA"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id E61801D00158;
	Thu, 30 Oct 2025 21:39:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 30 Oct 2025 21:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1761874768; x=
	1761961168; bh=tPDw6HmkkI00c6LxMArWNXGeuQFGtC33ypMb6m7Rqa0=; b=F
	nZcpV/y7d5gceUvDAm5bVAbwAPCNpY+4NwBCILkPx+1by8+lKgHCjDOfQ4NejUkK
	oS7YVRqEt1A5u4n37eHGV/UrMfnLVjkaSpsI3qVWoW5dGXZkCTMlu59KdNz8Y/C+
	RMDrqLZVAAzQODQafUDeO5wW5FPjHHrN96cpTOSTNGNBJhK33TURFwuTRSwY9wgP
	2W0nmmCVeuGhhvSjDXC/QYHq9ZpCvCZQcBFDqVMoF2KVk2C4Nfdf/wckjjsqGTbS
	wSTBIqOVtQ1Pz1uP/bBTntzW1gHzn+U/iNTNT5x0XBlezGVdM6onvmdsW25Z8UFZ
	K8dF5JR3bofDO0kme+JrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761874768; x=1761961168; bh=t
	PDw6HmkkI00c6LxMArWNXGeuQFGtC33ypMb6m7Rqa0=; b=uIzrJRzAl2qxNgNZM
	xmCWzxKoG/MemUhNA5Qb7xlCgJGlOJ0LkKfMUB0HHcvojNpLven8ACVMWSqujQrq
	ayg1IB4u4h+zu9ioKL+8g1J0nUYUiS5Lqarv0vrDHPTef/B2KTzUi+ctgNnmej4V
	RKekU0Dj6vLgSQ8ZuxBSYZX8DnPPTh1igbJRvPO5xGgIWdmVOavgSR2GRYCQuPF5
	veosUkCZTAObnwGKXP/+CL6iJBbDInuxgSlN6mRQacfVklENceshuRfdbyyah2v+
	zDHQa6uFoECGaPMOkSzEIjyAjX901ob0HHDathhfcmW/6akWmq0jjulLd7E7+17W
	M8e4g==
X-ME-Sender: <xms:UBMEaUJYVU1qJZuEZBnuv8o3coALj-bG4w9vGAiRfk_-DsHHa7OALw>
    <xme:UBMEabnXS-UzEimSpi6EpFZG9vXjuJzJzIQOBoOiajxBWKO4wXEVaXgcNpQTg9y17
    fFqZeSoNO10-ZnagJZCfg-LMYBCRVpNoXvj2DfBRli6PNLUiA>
X-ME-Received: <xmr:UBMEaSEYJUbW1Xhjpzy4u1M061WvFcoaftbDsMjR53219dTT9YIGEmq1Mm9N4YV8BZ3YMKgdrL2ltTs3hhoI2ObPm1Phc-KtSRXi9Yyx-Hm7FcGFq-CJsqLRdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpedule
    egueffgfehudeufedtffeiudfghfejgeehvdffgefgjeetvdfffeeihfdvveenucevlhhu
    shhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthh
    gvmhgrfidrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepugguihhsshesshhushgvrdguvgdprhgtphhtthhopehrrghvvghnsehthh
    gvmhgrfidrnhgvthdprhgtphhtthhopegruhhtohhfshesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:UBMEabFvr_Yq9b24-dOhe3IFB4iDP1SYN_FpCxQj7jXp7UTS_rsEmw>
    <xmx:UBMEafMPmYa1wycUAogmvvL73px_9Kl51HJL_frf2YE2tcZdbymsXw>
    <xmx:UBMEaaGdFUwjYi-Cn-jKtqqv3JeTf38vzZB0_OEIRnAKhlia53EwYg>
    <xmx:UBMEaWPNES3euqAL8-yWqmn-f89-SR-q5i3OG5fg3TzhY6Y3gQjLXQ>
    <xmx:UBMEacNo4qpVm02W3CgCCdRKFOqELV1_Czyoe_PqFQErQMOFhdRATvUO>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 21:39:26 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: David Disseldorp <ddiss@suse.de>
Cc: Ian Kent <raven@themaw.net>,
	autofs mailing list <autofs@vger.kernel.org>
Subject: [PATCH 11/11] autofs-5.1.9 - improve handling of missing map entry for mount request
Date: Fri, 31 Oct 2025 09:31:39 +0800
Message-ID: <20251031013745.11150-12-raven@themaw.net>
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

If the map entry isn't found it must have been deleted from the map but
a trigger mount is still mounted because it has sent us this request.
Use the mount table for a brute force lookup to get the path and open a
file handle for it so we can send a failure status to the kernel.

Also remove the crit() log message following open_ioctlfd() as it already
issues an appropriate error message on failure.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG       |  1 +
 daemon/direct.c | 49 +++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 4514e70f9..bc8c9bd72 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -78,6 +78,7 @@
 - refactor do_umount_autofs_direct().
 - fix stale direct mount trigger not umounted on expire.
 - add function table_lookup_ino().
+- improve handling of missing map entry for mount request.
 
 02/11/2023 autofs-5.1.9
 - fix kernel mount status notification.
diff --git a/daemon/direct.c b/daemon/direct.c
index b8e5bb6ec..f01ed8833 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -1374,12 +1374,50 @@ int handle_packet_missing_direct(struct autofs_point *ap, autofs_packet_missing_
 	}
 
 	if (!me) {
-		/*
-		 * Shouldn't happen as the kernel is telling us
-		 * someone has walked on our mount point.
+		char tmp[PATH_MAX + 1];
+		char *path;
+
+		/* If the map entry wasn't found it must have been deleted
+		 * from the map but a trigger mount is still mounted because
+		 * it has sent us this request. So use the mount table for a
+		 * brute force lookup to get the path and open a file handle
+		 * for it so we can return a not found status to the kernel.
 		 */
-		logerr("can't find map entry for (%lu,%lu)",
-		    (unsigned long) pkt->dev, (unsigned long) pkt->ino);
+		path = table_lookup_ino(ap, pkt->dev, pkt->ino, tmp, PATH_MAX + 1, &ioctlfd);
+		if (!path) {
+			/* This could be cuased by an inability to open a file
+			 * handle but generally that doesn't happen. The mount
+			 * has to exist and be pinned becuase we got this request
+			 * so it can't be umounted. Therefore it's very unlikely
+			 * this case will happen. If it does happen it's fatal,
+			 * the waiter will hang and there's nothing we can do
+			 * about it.
+			 */
+			logerr("can't find mount for (%lu,%lu)",
+			    (unsigned long) pkt->dev, (unsigned long) pkt->ino);
+			/* TODO:  how do we clear wait q in kernel ?? */
+		} else {
+			int rv;
+
+			/* Try and recover from this unexpecyedly missing map
+			 * entry by detaching the direct mount trigger that
+			 * sent the request so it's no longer visible to the
+			 * VFS.
+			 */
+			info(ap->logopt, "forcing umount of direct mount %s", path);
+			rv = umount2(path, MNT_DETACH);
+			if  (rmdir(path) == -1) {
+				char buf[MAX_ERR_BUF];
+				char *estr;
+
+				estr = strerror_r(errno, buf, MAX_ERR_BUF);
+				warn(ap->logopt,
+				     "failed to remove dir %s: %s", path, estr);
+			}
+			ops->send_fail(ap->logopt,
+				       ioctlfd, pkt->wait_queue_token, -EINVAL);
+			ops->close(ap->logopt, ioctlfd);
+		}
 		master_source_unlock(ap->entry);
 		master_mutex_unlock();
 		pthread_setcancelstate(state, NULL);
@@ -1398,7 +1436,6 @@ int handle_packet_missing_direct(struct autofs_point *ap, autofs_packet_missing_
 		master_source_unlock(ap->entry);
 		master_mutex_unlock();
 		pthread_setcancelstate(state, NULL);
-		crit(ap->logopt, "failed to create ioctl fd for %s", me->key);
 		/* TODO:  how do we clear wait q in kernel ?? */
 		return 1;
 	}
-- 
2.51.0

