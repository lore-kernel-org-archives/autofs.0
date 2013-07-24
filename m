From: Ian Kent <raven@themaw.net>
Subject: [PATCH 0/9] Gentoo related patches
Date: Wed, 24 Jul 2013 16:52:58 +0800
Message-ID: <20130724084903.3884.13354.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=mesmtp; bh=yE6/O9he3NkYKZhSHZRqaEa
	HViY=; b=dhP0nanb21L1z7PLvm+uEnBBrsqhxIaKHHtgqfVBYbw4drPkNL18Eui
	MLNOiowWZd5lWe3VqmqN4YQchS9tr4WoJO4Pd/vrDQign3y4QCnzJvUFewCgA8jM
	Gf3ao7ldyu3lpD9vFcq9+/ths1LiCWhh153h5h9cpodfGREdhHoY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=smtpout;
	 bh=yE6/O9he3NkYKZhSHZRqaEaHViY=; b=mGpKOaCQConl8R5ZHY3YUEGeJ8Zd
	z0qI4J+tFaRDvJJft3MDOmuMgoXgE4Nc7OVymQMUmGq7zcuPeKcOOHC2xx+l/6pz
	iAVHrl7xcHAuv/7kjGB1jSnpKKGFRMAw1OH6wLHi+zlB9MPvilNXh/Ro9tC7Fvqp
	wjTj7mXjxcKrQvg=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

Here is what I have so far for the recently posted Gentoo related
patches and the older patch posted by Dustin.

Have a look and check I haven't made any stupid mistakes and that
I've covered everything.

The patches not present should be covered by the unfinished patch,
originally from Dustin.

---

Dustin Polke (1):
      autofs-5.0.7 - fix compilation of lookup_ldap.c without sasl

Lan Yixun (dlan) (8):
      autofs-5.0.7 - fix typo forced-shutdown should be force-shutdown
      autofs-5.0.7 - fix hesiod check error and use correct $(LIBS) setting
      autofs-5.0.7 - fix dead LDAP symbolic link when LDAP support is disabled
      autofs-5.0.7 - add missing libtirpc lib to mount_nfs.so when TIRPC enabled
      autofs-5.0.7 - use compiler determined by configure instead of hard-coded ones
      autofs-5.0.7 - remove hard-coded STRIP variable
      autofs-5.0.7 - use LIBS for link libraries
      autofs-5.0.7 - unbundle NOTSTRIP from DEBUG so they dont depend on each other


 CHANGELOG             |    9 +++++++++
 Makefile.conf.in      |    3 +++
 Makefile.rules        |   30 +++++++++++++++---------------
 aclocal.m4            |   12 ++++++------
 configure             |   20 ++++++++++----------
 configure.in          |    2 +-
 daemon/Makefile       |    2 +-
 include/lookup_ldap.h |    4 ++--
 lib/Makefile          |    4 ++++
 modules/Makefile      |   20 ++++++++++++--------
 modules/lookup_ldap.c |   14 ++++++++++++--
 11 files changed, 75 insertions(+), 45 deletions(-)

-- 
Ian
