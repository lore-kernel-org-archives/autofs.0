Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562C21A0BD6
	for <autofs@vger.kernel.org>; Fri, 31 Oct 2025 01:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761874769; cv=none; b=dtz1khNGltXpe46xamI7fjOF0mEtw6WKeahazKukZud+aGp2D5FAVmhr4kHSGmsXlTdvTc5IbPsbpVazCRFgYEsJwisetlfGuUBpe75EwgYHpqtLQes6E2R1bH7haK99j9e91MeU7ELwMfTKtQlWu+bxJ2jL/SPLdU+nA/HqlrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761874769; c=relaxed/simple;
	bh=qG4ARtwbFjgsKje2CEQqQl+fWL7YyUfPYZoi+NplE3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1nk9UcOgNdyiNoJAxIFL1l/Ib7SsykUXRd13TMXg1AEmmMjSZ5fC+6GDJ6lS8GTehrno4QdF+B0AZNMa+a8B6mWNx+4k5Bd7eMLbuygI2TGnI/HXN9lNYpLvLZwbcWyVr3UP40PgoKtrdmgHmEoQhVWwr53dnUVQBuE+LuxIyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=XfrpEB0b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nnVvMskJ; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="XfrpEB0b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nnVvMskJ"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 7736D1D0013B;
	Thu, 30 Oct 2025 21:39:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 30 Oct 2025 21:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1761874766; x=
	1761961166; bh=SS003WXOF2/yKykczsvPQMFPYcbTQW7MRHhbXM/tFbM=; b=X
	frpEB0bu510FF4zMjjMiKphjLCay6SNMz6GmkEqQXsU30s9/Mmdgk3yIbypZlAwQ
	IcICa1SY7NwaSBTt3CNLX5mYNwExY6dufzzFPJ+dkoDvqOe1uz15DjhB0qBaXwWj
	tNre5ZtZXoNZGrgXDFT2e1y+6C/93Phytz5+X60XTuKBe+0MEHVKzzOaG+Jo69/C
	I1rz/6U3x21oDnuUnCQwoUSLkXDJ0Vm14pl8T8lZysUmO+cJkJnGqIVzn7+6qFEV
	o/7ZYOa+oyVyFxSQ7iEZ0ufmfYK3aJBNnriGYE1BU8f8gOec8hR+LioD0PXi3HZ1
	bbXsSpT0P44cDbo+6Rk7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761874766; x=1761961166; bh=S
	S003WXOF2/yKykczsvPQMFPYcbTQW7MRHhbXM/tFbM=; b=nnVvMskJCDOnD1LJc
	AgFx+Hf5Qcci+7LNIw7n85A506XOcQDSZ5tlqeXW+doaFx3KWGV6vag/bpTyCg86
	NDDSe9pLX6jskuILCu4MGAcKkSC4ODFGXyARIYis8/Uk0VDEOE/kVAdQh61kiuLL
	DFsmQmtTy4kF1xs+r5XudD7mR5OvBRBppYU2AIecyOId1/EXXPYVnSDFqpYEoakB
	MDXsavHFYpbGiOhq9Weq24fcOKe+gLrUVRfM/MpoOoV3zLRKtWoqaapGAEyK9BH8
	lMrQY5MPQ6j7QoMTHvBERXxulGsmUXkL4Fwk7lM4+YUEiOBHvW9g6XGScyUTQUjb
	g3Tcg==
X-ME-Sender: <xms:ThMEaUaoBisxauWT6Ui0wr5C7rP9nde2L0zZE_WJFmyBiJs2MIQ1Ww>
    <xme:ThMEaW2BXtNKYNO2hzo5fL3q_ZAjlRpowcB9BVkhx4uLRKYypVp0gzox7Gil03KHQ
    ryD5wFzbxD1mqkqfOqyu0SnjzNWH7ciYCH4Yrw3Gemk9POrSA>
X-ME-Received: <xmr:ThMEacURf_JgxzeU4dFqPVREmeEEDlZRjqLNcmZFPtPKe5ZYOOc76AvuGeHUCVfhScWmAldd_kOh_jCbRrguuNhCfN5PG7MG7O7j-F0fyIQQAi5Y3GG9_rV1QQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpedule
    egueffgfehudeufedtffeiudfghfejgeehvdffgefgjeetvdfffeeihfdvveenucevlhhu
    shhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthh
    gvmhgrfidrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepugguihhsshesshhushgvrdguvgdprhgtphhtthhopehrrghvvghnsehthh
    gvmhgrfidrnhgvthdprhgtphhtthhopegruhhtohhfshesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:ThMEaYUSeIoQe4ylZDueuDBiFoeNINBM66QuAUcQ14hpzSiqGhqhXg>
    <xmx:ThMEaTfcwKhb350m-26aH-DbzlCpKOx2Lk5bSr_BMe99d4oJeV2g5A>
    <xmx:ThMEaZWuPN-YftepxAoMV6I0-qzvDQz8qLq4I4P_jAJ2ma3ZHJYP4g>
    <xmx:ThMEaUc93yYMQHwLkn96smYrZBAyZHC5QX2XsmIVdkNKsrMpnUCLjw>
    <xmx:ThMEaTfuHQFYkE5C7J25xX-uk1OE5bGs45aQEDNZY51JvYD__BnDxkue>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 21:39:24 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: David Disseldorp <ddiss@suse.de>
Cc: Ian Kent <raven@themaw.net>,
	autofs mailing list <autofs@vger.kernel.org>
Subject: [PATCH 10/11] autofs-5.1.9 - add function table_lookup_ino()
Date: Fri, 31 Oct 2025 09:31:38 +0800
Message-ID: <20251031013745.11150-11-raven@themaw.net>
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

Add function table_lookup_ino() to try and locate a mount for a given
device, open a file handle for it, and return it's path in the provided
buffer.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG        |  1 +
 include/mounts.h |  1 +
 lib/mounts.c     | 70 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/CHANGELOG b/CHANGELOG
index 630a6d3d2..4514e70f9 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -77,6 +77,7 @@
 - fix direct mount trigger umount failure case.
 - refactor do_umount_autofs_direct().
 - fix stale direct mount trigger not umounted on expire.
+- add function table_lookup_ino().
 
 02/11/2023 autofs-5.1.9
 - fix kernel mount status notification.
diff --git a/include/mounts.h b/include/mounts.h
index 08b3ff424..39ca99965 100644
--- a/include/mounts.h
+++ b/include/mounts.h
@@ -175,6 +175,7 @@ void mnts_remove_amdmounts(struct autofs_point *ap);
 struct mnt_list *mnts_add_mount(struct autofs_point *ap, const char *name, unsigned int flags);
 void mnts_remove_mount(const char *mp, unsigned int flags);
 struct mnt_list *get_mnt_list(const char *path, int include);
+char *table_lookup_ino(struct autofs_point *ap, dev_t dev, ino_t ino, char *buf, size_t len, int *fd);
 unsigned int mnts_has_mounted_mounts(struct autofs_point *ap);
 int tree_traverse_inorder(struct tree_node *n, tree_work_fn_t work, void *ptr);
 void tree_free(struct tree_node *root);
diff --git a/lib/mounts.c b/lib/mounts.c
index 009e11447..242d43da1 100644
--- a/lib/mounts.c
+++ b/lib/mounts.c
@@ -2335,6 +2335,76 @@ void free_mnt_list(struct mnt_list *list)
 	}
 }
 
+char *table_lookup_ino(struct autofs_point *ap,
+		       dev_t dev, ino_t ino,
+		       char *buf, size_t len, int *fd)
+{
+	struct ioctl_ops *ops;
+	struct mntent *mnt;
+	struct mntent mnt_wrk;
+	char tmp[PATH_MAX * 3];
+	char *path = NULL;
+	FILE *tab;
+	int ret = 0;
+
+	ops = get_ioctl_ops();
+	if (!ops) {
+		errno = EINVAL;
+		return NULL;
+	}
+
+	tab = open_fopen_r(_PROC_MOUNTS);
+	if (!tab) {
+		errno = EINVAL;
+		return NULL;
+	}
+
+	while ((mnt = local_getmntent_r(tab, &mnt_wrk, tmp, PATH_MAX * 3))) {
+		unsigned int type;
+		int ioctlfd;
+		dev_t devid;
+
+		if (strcmp(mnt->mnt_type, "autofs"))
+			continue;
+
+		type = t_direct;
+		if (strstr(mnt->mnt_opts, "indirect"))
+			type = t_indirect;
+		else if (strstr(mnt->mnt_opts, "offset"))
+			type = t_offset;
+
+		ret = ops->mount_device(ap->logopt, mnt->mnt_dir, type, &devid);
+		if (ret == -1 || ret == 0)
+			continue;
+
+		ioctlfd = open_ioctlfd(ap, mnt->mnt_dir, devid);
+		if (fd > 0) {
+			struct stat st;
+
+			if (fstat(ioctlfd, &st) == -1) {
+				ops->close(ap->logopt, ioctlfd);
+				continue;
+			}
+
+			if (strlen(mnt->mnt_dir) >= len) {
+				errno = ENAMETOOLONG;
+				break;
+			}
+
+			if (st.st_dev == dev && st.st_ino == ino) {
+				strcpy(buf, mnt->mnt_dir);
+				path = buf;
+				*fd = ioctlfd;
+				break;
+			}
+			ops->close(ap->logopt, ioctlfd);
+		}
+	}
+	fclose(tab);
+
+	return path;
+}
+
 static int table_is_mounted(const char *mp, unsigned int type)
 {
 	struct mntent *mnt;
-- 
2.51.0

