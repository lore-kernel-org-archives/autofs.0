From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 2/6] fix dead LDAP symbol link with LDAP support disabled
Date: Wed, 24 Jul 2013 10:13:13 +0800
Message-ID: <1374631993.2358.18.camel@perseus.fritz.box>
References: <dennis.yxun@gmail.com>
	 <1374505194-22668-1-git-send-email-dennis.yxun@gmail.com>
	 <1374505194-22668-3-git-send-email-dennis.yxun@gmail.com>
	 <1374573038.3418.3.camel@perseus.fritz.box>
	 <1374574224.3418.5.camel@perseus.fritz.box>
	 <CAF1ZMEdhiNLJdmrETYoQnOFHuFzquVTm1S5yuYFdLC3-7nohCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=otzwSYzWcOF1CTU5h3VeVFp2ZRU=; b=l7ZkFtIvBKJAZjE+U0vTLjlRUlxl
	N1w5Rtk/Dvl7SbUQ5TK/pLhbLauJ5066lWz+rAM3vROKhs/h9U7yckkZvLvUZcEF
	JzXR1aZm/qmfVvbi0wQGMprySeSLbkOlZsu4QuOvL3x2t/6HNzyUXOpfTLjRY5Zy
	rgg1EB0TVvTeKTM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=otzwSYzWcOF1CTU5h3VeVF
	p2ZRU=; b=obot8jNg1HgrF9jKBwSXS/KNMfQx98tJdN/rQqzoln++IAjzW78VHj
	eqdk6XazUO8S7MkQ3dC3yGXMgeP4oh4BkE+yC3QAO78oNOAG6amZeyG9PzvN7QcA
	vSRj1RjPO2s9EZnYuYcwFoz8r69WALWkdBkMcQWsUFZObQnmlqjyo=
In-Reply-To: <CAF1ZMEdhiNLJdmrETYoQnOFHuFzquVTm1S5yuYFdLC3-7nohCQ@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Cc: autofs@vger.kernel.org

On Tue, 2013-07-23 at 18:30 +0800, Dennis Lan (dlan) wrote:
> On Tue, Jul 23, 2013 at 6:10 PM, Ian Kent <raven@themaw.net> wrote:
> > On Tue, 2013-07-23 at 17:50 +0800, Ian Kent wrote:
> >> On Mon, 2013-07-22 at 22:59 +0800, Lan Yixun (dlan) wrote:
> >> > From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
> >> >
> >> > autofs will create symbol link mandatory no matter ldap support
> >> > is enabled or not. so, without this patch, lookup_ldaps.so will become
> >> > a dead link.
> >>
> >> I have added this to my patch queue.
> >> It will be committed next time I push patches to the repo.
> >
> > On second thoughts, what if WITH_LDAP is defined and WITH_SASL is not?
> >
> 
> HI Ian:
>   current logic is: if SASL is not enabled, then the symbol
> lookup_ldaps.so (which link to lookup_ldap.so) will not be created.
>   what are you suggesting here?  should symbol of lookup_ldaps.so be
> controlled by LDAP ?

Yes, I think so.

If lookup_ldap.so has been included in the build then ldaps:// uris
should be able to be used regardless of SASL, as long as the ldap client
library is configured for it, of course.

This is what I believe it should be:

autofs-5.0.7 - fix dead LDAP symbolic link when LDAP support is disabled

From: Lan Yixun (dlan) <dennis.yxun@gmail.com>

autofs will create symbol link mandatory no matter ldap support
is enabled or not. so, without this patch, lookup_ldaps.so will become
a dead link.

Edited by: Ian Kent <raven@themaw.net>
- change check from SASL to LDAP since the ldaps lookup module may
  still be used ldaps:// as long as LDAP support is built.
---
 CHANGELOG        |    1 +
 modules/Makefile |    2 ++
 2 files changed, 3 insertions(+)

diff --git a/CHANGELOG b/CHANGELOG
index 3c829cf..9755e25 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -59,6 +59,7 @@
 - dont start readmap unless ready.
 - fix typo forced-shutdown should be force-shutdown.
 - fix hesiod check error and use correct $(LIBS) setting.
+- fix dead LDAP symbolic link when LDAP support is disabled.
 
 25/07/2012 autofs-5.0.7
 =======================
diff --git a/modules/Makefile b/modules/Makefile
index c5deb24..8c0df18 100644
--- a/modules/Makefile
+++ b/modules/Makefile
@@ -74,7 +74,9 @@ install: all
 	-rm -f $(INSTALLROOT)$(autofslibdir)/mount_smbfs.so
 	ln -fs lookup_file.so $(INSTALLROOT)$(autofslibdir)/lookup_files.so
 	ln -fs lookup_yp.so $(INSTALLROOT)$(autofslibdir)/lookup_nis.so
+ifeq ($(LDAP), 1)
 	ln -fs lookup_ldap.so $(INSTALLROOT)$(autofslibdir)/lookup_ldaps.so
+endif
 	ln -fs mount_nfs.so $(INSTALLROOT)$(autofslibdir)/mount_nfs4.so
 ifeq ($(EXT2FS), 1)
  ifeq ($(EXT3FS), 1)


