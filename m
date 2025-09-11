Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com [64.215.233.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2532E401
	for <autofs@vger.kernel.org>; Thu, 11 Sep 2025 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.215.233.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757596979; cv=none; b=rv+MyoLemvbQWwT7sD7oEy/cMER+RhEeD9k+d4Y0nrLDpTQvIanfY4fpyxTRPH+JqEEyO09UfGa6TUrSGwfl4I1OKEmnWsNjVT+49dtm2VlwSg9yEmJNMeKX5bKBEfknZ4zjlCCuYh9nhBMjT8N4/2jSB/7yBZTHfM5bIvEppKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757596979; c=relaxed/simple;
	bh=ZDAgEjXNmbFgo+XRj4yL4FLmiiI+cYawE5CeiO+3mAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pel1y6SUcaSq8PfadEaRYKHRgj/T84XNrPHfFjMn7dLLoNZSsTa1CV/+LnkhwmtVWUV/JVCYTFY9PY4WgyuEgFbhkzC2AQnuHE99HMV1IHvR5Qd1zHGI/oedVGnCSNP4vo3PSwoxFYGQz8Wg3dLl5OmNlQss/lVI77UkVBO9TZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=CyMIWuCu; arc=none smtp.client-ip=64.215.233.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="CyMIWuCu"
From: Jun Eeo <jeeo@janestreet.com>
To: raven@themaw.net
Cc: autofs@vger.kernel.org
Subject: [BUG] deadlocks due to setenv in lookup_program.c
Date: Thu, 11 Sep 2025 14:22:49 +0100
Message-ID: <20250911132249.458873-1-jeeo@janestreet.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1757596970;
  bh=XBoH/xtGelpBDELq9KebuAAvVdTZ9kMIgyNEb6+16ak=;
  h=From:To:Cc:Subject:Date;
  b=CyMIWuCu07imiDXJO493MGFxwa3veAD+8AGuZ7VmCrbUlDsefTfQ5KDV0RebGX/yG
  XCWDVQdna5BdPEpfXwIk1vT31iMyltmcgsJzPTIEA9dvppRoRQM0dVQTNrmuiZKkOX
  2lOgdSpJ0L5uAYHblfWUdOeWZY4GEDpKWWcv1S4MDr9NcSQVWugWWSvL+42Y6JHtA+
  hVzdHyWJXywYSUi/WuP50rwAKMDihT7wD0vcIcqZTEymUbOjzIkPctRVKuKeaj75X+
  7MziQefnqROahbAmVATfVWvnwazKYSxJtwHspISdwpxwsAoso/Lw88mjp7wxXDAheu
  vNAwZXyYndUzQ==

Hi,

When using the lookup_program module, we've seen an issue where the
main automount process waits forever for the forked child to produce
output (and quit). This causes whatever processes that require the
automount to wait on autofs_wait.

Coredump of the forked child showed that it was stuck waiting on a
lock when calling setenv (it never went so far as doing the execl):

#0  __lll_lock_wait_private () at ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:63
#1  0x00007ffff60505ce in __add_to_environ (name=0x55555558b2e0 "autodir", value=0x55555558b300 "/a",
    combined=0x0, replace=1) at setenv.c:133

This seems to be caused by the macro_setenv call in lookup_one in
modules/lookup_program.c -- that calls into glibc's setenv, and
depending on when exactly the process was forked, it could be looking
at a locked envlock.

I guess there are two approaches which to fixing the issue and I'd
like to get some thoughts before sending a patch:

1. Not calling out to any environment-mutating functions (clearenv,
   putenv, setenv) which can hold the envlock after the initial setup.
   In our deployment, the only place this happens is macro_setenv
   and the sd_notify call in daemon/automount.c.

2. Avoiding the use of setenv in the forked child (it is MT-Unsafe
   anyway). We can copy environ and use something like execle.

I tested both patches about a week ago which seemed to fix the
problem; there are no more deadlocks of this shape.
