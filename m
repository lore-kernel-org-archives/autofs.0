From: Ian Kent <raven@themaw.net>
Subject: [PATCH 0/5] fyi, here are the patches that I haven't yet committed
Date: Tue, 24 Dec 2013 16:02:07 +0800
Message-ID: <20131224075909.8321.95699.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=mesmtp; bh=xFEjCisdGOnikzlJ+VWp4+x
	HJ5w=; b=LrFYKhLW9fACy8eB+ixQEo1awG1ek2U4uZKkk3YGA+ALkIjDVn0WhUk
	mySNWxYDq8D72ujwkZhJYKQhfTwtyXQF4QU+VzMPDNHdZ+ipybGdOkYqwuOIcqv4
	X6VE0DMkeNabi8KvfM7rct8zDs0rGrc1KaV3fSHqA2bIpZy+uslI=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=smtpout;
	 bh=xFEjCisdGOnikzlJ+VWp4+xHJ5w=; b=aXuYx6IugZqW4nd4Wq1BKZNuu2ps
	oT7wwfXUNVSTHg6pYT6LvCYx1UH1xxAhROChfMhcafQfEFHWtTBavvuzBcEqRvF7
	C9aQh8+QvLwgWlWgc18QTXGy+y/T3QnyoFIekBxc2cO634E19Pzivg8Uw3zIY0CU
	2a6Hnbh3n6ngy7o=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

Let's try that again.

Not certain yet what the problem is but today I investigated a problem
reported against host map not working and it was something quite different.

There are a couple of patches here that are most likely needed in addition
to the currently committed patches.

In paticualar
autofs-5.0.8 - fix fix ipv6 libtirpc getport
autofs-5.0.8 - fix rpc_portmap_getport() proto not set
and possibly
autofs-5.0.8 - get_nfs_info() should query portmapper if port is not given

might be useful.

---

Ian Kent (4):
      autofs-5.0.8 - fix ipv6 link local address handling
      autofs-5.0.8 - fix fix ipv6 libtirpc getport
      autofs-5.0.8 - fix rpc_portmap_getport() proto not set
      autofs-5.0.8 - fix options compare

Scott Mayhew (1):
      autofs-5.0.8 - get_nfs_info() should query portmapper if port is not given


 include/automount.h    |    1 +
 lib/cat_path.c         |    9 +++++++++
 lib/rpc_subs.c         |   14 +++++++++-----
 modules/mount_autofs.c |   12 ++++++------
 modules/mount_bind.c   |    2 +-
 modules/mount_ext2.c   |    2 +-
 modules/mount_nfs.c    |   34 +++++++++++++++++-----------------
 modules/parse_sun.c    |   22 +++++++++++-----------
 modules/replicated.c   |    9 ++++++---
 9 files changed, 61 insertions(+), 44 deletions(-)

-- 
Ian
