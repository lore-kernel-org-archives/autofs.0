Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0972C1A7F73;
	Wed, 31 Jul 2024 13:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431475; cv=none; b=UbOVk+jHK9d2BQmKJkBItguE+jFNW8FYljICq7Lhx4Z6bMHP2egRamN1KqcLU3C7KE+9zV9xyHyManN8rcr4z3CDhxeX0DIPVT4D4KczKnLn/s25vOF0UoJIvZkL8tIsNhDTVXCqmoZOJjf8h7fNU0Nj9fy5BXhZjPoq+3TWsFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431475; c=relaxed/simple;
	bh=7wr5lyQ8MOB8ZLoD7O/L7tMEUqp2EeRSmwAzoTuq3BY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZT0BuxQdFpKqYK/KCN9pdEX/o2LXMjR2u5v9GSUC0JmjQemLlLU7jJDI7hhbFQ3tII5Rz7kneEyS0C6MJx2JJYLxbxbSbDsC/9VSZY+djVG+ZyjnN89ipPwd/wdtKJvuTbEd5/WjSURZ8FKjO0o0L9q5yGyRNbeCtyOHb+uYJGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=qKooJRnG; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="qKooJRnG"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WYssy3Rmyz9sly;
	Wed, 31 Jul 2024 15:11:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1722431462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P2Ap0zYgBzE2v8VJI5iw8HpeN4m3eODczA+epRyT8CM=;
	b=qKooJRnG5J1qPMn13j7OOYAmf2APVfwXCrYtSecN76+Ij56JEbbaDtMf5uHkDoNVHpZzMB
	Z7eGuNtVli2Unn0H3NbnPukgzEwnppnUft+8fkB0wsj4IAlrrvQWvc6vib/ZZcTPfc9PiF
	LAb9EoiMa3Ft5vW4OLIOCTVJMv+VrHL0oAT0ntGXOQW4TI/ABoy3ljFWeZ/fMe6kCT7FhB
	avuW/mk1obIxx3Sd6m+AEY8TVdGXqhM+m6GuNoTZPdaS0gAjSfTJJP6uNrCHVSEf7eSiur
	d4TNG76l9Dpqf4prIRPVHH335kR1W2E3/h5VPdiEpmAZ3XWLhG6rWQhLHBWdGg==
From: Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH v2 0/2] fsconfig: minor fsparam_fd fixes
Date: Wed, 31 Jul 2024 23:10:26 +1000
Message-Id: <20240731-fsconfig-fsparam_fd-fixes-v2-0-e7c472224417@cyphar.com>
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMI3qmYC/32NwQrCMBBEf6Xs2UgSI7Ge+h9SJGw2zR7alESKp
 fTfjQWv3ubNMDMbFMpMBe7NBpkWLpymCvrUAEY3DSTYVwYttZFWGREKpinwUMXsshufwYvAbyp
 CtkGTNQr1zUPtz5mOoNYffeXI5ZXyelwt6uv+Vts/q4sSUlhEf1FX1M6bDtc5unzGNEK/7/sHy
 JEwXcMAAAA=
To: Ian Kent <raven@themaw.net>, Bill O'Donnell <bodonnel@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Harkes <jaharkes@cs.cmu.edu>, 
 coda@cs.cmu.edu, Eric Sandeen <sandeen@redhat.com>, 
 David Howells <dhowells@redhat.com>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 codalist@coda.cs.cmu.edu, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1332; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=7wr5lyQ8MOB8ZLoD7O/L7tMEUqp2EeRSmwAzoTuq3BY=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaStMr9tuGpv2ku7lVr/mCd1vvOvdPh6+t+J4PIJEuG5z
 7/WVxY96ShlYRDjYpAVU2TZ5ucZumn+4ivJn1aywcxhZQIZwsDFKQATMVjK8N+zQ048L+DW1UmG
 v+Zrn38Xm6fwaVPe0uDEZfXTudoK2FoY/odVXL7/KTxw1xXdDMn0BUm/Hmx5ypvKq1WdciaL96T
 lJC4A
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

While working on adding an fsparam_fd() argument to cgroupfs, I noticed
that there are only two users of fsparam_fd() and they both seemed to
have minor issues:

* autofs has a missing fput() when using FSCONFIG_SET_FD.
* coda uses fsparam_fd() but it ignores param->file and so ends up
  re-getting the file. This doesn't change the behaviour but it seems
  preferable to have all users of fsparam_fd() have the same logic.

I have tested this logic for the cgroupfs patch but I have only compile
tested the fixes for autofs and coda.

The second patch is not really required, so feel free to drop it if you
feel the original version was cleaner.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
Changes in v2:
- Fix fs/coda/inode.c build errors.
- Link to v1: https://lore.kernel.org/r/20240719-fsconfig-fsparam_fd-fixes-v1-0-7ccd315c2ad4@cyphar.com

---
Aleksa Sarai (2):
      autofs: fix missing fput for FSCONFIG_SET_FD
      coda: use param->file for FSCONFIG_SET_FD

 fs/autofs/inode.c |  3 +--
 fs/coda/inode.c   | 43 ++++++++++++++++++++++++++++++-------------
 2 files changed, 31 insertions(+), 15 deletions(-)
---
base-commit: c7b9563b58a77423d4c6e026ff831a69612b02fc
change-id: 20240714-fsconfig-fsparam_fd-fixes-09f2e741c28d

Best regards,
-- 
Aleksa Sarai <cyphar@cyphar.com>

