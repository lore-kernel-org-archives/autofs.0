From: Ian Kent <raven@themaw.net>
Subject: [PATCH] Current patch to fix autofs symlink expiry
Date: Fri, 27 Dec 2013 12:32:11 +0800
Message-ID: <20131227042828.3519.11223.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=mesmtp; bh=MbowbtuoFmtisJQJitifSlx
	Oi1Y=; b=h3SNLPh8bZo/HYFJCytpg8Z1uYh7dxZRjBs0/QcvDU7WkpwMdIGUVIZ
	gA1kwJ7OAzLtBGpu7BUf2rkmMzv4VNOVyh3DwqLrsCwih3SrsdyFW+j7NQL4bdAK
	5lWTvjp/ZQc5Y+n99aUk1VijubGkoDUcZZ5HimXnHIgu/m1K9A8s=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=smtpout;
	 bh=MbowbtuoFmtisJQJitifSlxOi1Y=; b=i00rhWre9dgKJGat/VNvmhoOLYTG
	CmVdhlUvmSzVzjMXk1nE6RUDKSP0UIObLs2p97rkkiIFvQhFCXX+3E8DRIc8XAGn
	TwTQYGSR8tVO1NYB4DKF9rN/ngBAokBcMyoaSVBCukah1nICabPZ4aNzX61IGNo4
	/ie/cJ/WTyT2Y6c=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

This patch obsoletes both the current patches:
autofs-fix-symlinks-arent-checked-for-expiry.patch
autofs-fix-fix-symlinks-arent-checked-for-expiry.patch

It's a merge of both of these patches with an updated description.

---

Ian Kent (1):
      autofs - fix symlinks aren't checked for expiry


 fs/autofs4/expire.c  |   14 ++++++++++++++
 fs/autofs4/symlink.c |    4 ++++
 2 files changed, 18 insertions(+)

-- 
Ian
