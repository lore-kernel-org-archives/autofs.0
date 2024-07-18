Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995DF13F45F;
	Thu, 18 Jul 2024 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721313307; cv=none; b=mPxClu05PfhDwyCic0OVTnAyxuA/Y62TCmVvYbU+sK2Zebj0Wl2qE4hWzCfnN5VFMqn89dy+l61mgDZKUcpXNVZ1WNjn2ABSjpMXpi78tkKe59XV+ZEO30WknJF8/fEv+acOuUkUyDj+YeAJQ0K0GP17Xpa1v03mHsW8+jTfuBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721313307; c=relaxed/simple;
	bh=MCsPXzdXBB//fp8rS3L36UAxJTYpPOR31bP14wJgSng=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DkgjXeU0JGeJQIxu/SHlqq86I+j46DhaTX3iHuaThIhNbp8qSk1yaeVezWTBG9qpVwvSEVjYNeQQfuFbKAElF+Htci4NwH/OIZQzGea6OAnFVmU0DKl8RfigOL44K3DBiX7+3r4/aOvwMjsupDLyPTouyJitgPl9W6V6XEC6uGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=U4cugL9u; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="U4cugL9u"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WPwLl3ZFWz9t74;
	Thu, 18 Jul 2024 16:34:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1721313295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TVkv/vfbp7AlQp8D3khEqjLK92JEHWJeEzKgrhYydq8=;
	b=U4cugL9ufLk2tPzZyEeUHf1Ye8ycj+gmt2XD4nAqZn019b/lCoyeIhd33LHtqNS3e0X8eR
	hsrw6V+5tWGykF2ZThJtWEnfkkQL3h/P27S95Sg2GE+UcckLwppEeNzl0aYH3rum7hrS5B
	W49TRUMpfGimX0w6IBFlVOkANJHLTObqsnjFNrUczImfiRxyCKxRRxb0CRN6s0d/5z/sD9
	J8v2ad9UE1q/8fFTo2aFil7wprwtEZcfqAOL2P+kfR5EsSrc6V4puiIxP7xZ7ytI/4byZ5
	XEFcC1L9ivh7aHpV8Rs89hlegr5jpAXQH0SLfrsTQxnB4UQXKJinRP0EAbvRiA==
From: Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH 0/2] fsconfig: minor fsparam_fd fixes
Date: Fri, 19 Jul 2024 00:34:21 +1000
Message-Id: <20240719-fsconfig-fsparam_fd-fixes-v1-0-7ccd315c2ad4@cyphar.com>
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO0nmWYC/x2LSQqAMAwAvyI5W2hLweUrIlLaRHOwSgMiiH83e
 JthmAcEK6PA2DxQ8WLho6i4toG0xbKi4awO3vpgOxcMSToK8apwxhr3hbIhvlGMHchjF1zyfQb
 9z4p/0H2a3/cDaMtFt2sAAAA=
To: Ian Kent <raven@themaw.net>, Bill O'Donnell <bodonnel@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Harkes <jaharkes@cs.cmu.edu>, 
 coda@cs.cmu.edu, Eric Sandeen <sandeen@redhat.com>, 
 David Howells <dhowells@redhat.com>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 codalist@coda.cs.cmu.edu, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=956; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=MCsPXzdXBB//fp8rS3L36UAxJTYpPOR31bP14wJgSng=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaTN1GDy+SdVlDkl0X2iEFt0QPFKpx1nC032fdoi/9pd8
 kRjjsvLjlIWBjEuBlkxRZZtfp6hm+YvvpL8aSUbzBxWJpAhDFycAjAR/psMf4WnnwvJWb/y6+Xa
 zfse6098IR74/cfTP2JGJ73VhFuPKPIy/K+6vvXdBPNfs/dOcCuUZTOqtI+VPTPRnif+veiMHfn
 td3gB
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4WPwLl3ZFWz9t74

While working on adding an fsparam_fd() argument to cgroupfs, I noticed
that there are only two users of fsparam_fd() and they both seemed to
have minor issues:

* autofs has a missing fput() when using FSCONFIG_SET_FD.
* coda uses fsparam_fd() but only supports string-based fds but
  FSCONFIG_SET_FD is more ergonomic when using the new mount API.

I have tested this logic for the cgroupfs patch but I have only compile
tested the fixes for autofs and coda.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
Aleksa Sarai (2):
      autofs: fix missing fput for FSCONFIG_SET_FD
      coda: support FSCONFIG_SET_FD for fd mount flag

 fs/autofs/inode.c |  3 +--
 fs/coda/inode.c   | 18 ++++++++++++------
 2 files changed, 13 insertions(+), 8 deletions(-)
---
base-commit: b80cc4df1124702c600fd43b784e423a30919204
change-id: 20240714-fsconfig-fsparam_fd-fixes-09f2e741c28d

Best regards,
-- 
Aleksa Sarai <cyphar@cyphar.com>

