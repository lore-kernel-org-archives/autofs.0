From: Ian Kent <raven@themaw.net>
Subject: [PATCH 04/37] autofs-5.1.2 - Drop redundant \n in logerr()
Date: Tue, 25 Oct 2016 09:17:46 +0800
Message-ID: <20161025011746.7778.75284.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=Jg3OrfcBDssjg2ML+fCgxF4hHq4=; b=n/grPFnwbPc9dKma8L
        pALFxL+93UjfcxbB2/y20YiXIGqIQqH/yAgVohqBNI0O15uV7rxlxkbmAfypYuUn
        /r84P/gHkRyhAJ8ZEm8WZg4QbDOHeLFjX8L7SSQvD56ku2tm9CG+drjvlHyfuy3w
        e8WifRMiYTCxWSk82bDCskfok=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=Jg3OrfcBDssjg2ML+fCgxF
        4hHq4=; b=MMSNGN/5RgJdIZyVLJ4YoZTOC1KJcBoQG5+L7VNywEkEuwEBFkT8Xp
        K4/f34CrMgc0s9SlNFI4/9LQNGL089Dniax0Y1+MtPN/TCY4c00ibcwREjpkR2Wc
        HNMrRut4Rt/bBh/rpakjdNi9scSckZA5NhZvqKF0wDy97wTZwAGWI=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

Line break isn't necessary from the way logerr (and logmsg) is implemented,
and these two probably aren't intentional.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG       |    1 +
 daemon/module.c |    2 +-
 lib/nss_parse.y |    2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 288d175..99dc245 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -3,6 +3,7 @@ xx/xx/2016 autofs-5.1.3
 - fix release date in CHANGELOG.
 - build: check for clock_gettime in librt.
 - fix compiler warning in try_remount().
+- drop redundant \n in logerr().
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/daemon/module.c b/daemon/module.c
index bed8f7a..db01db8 100644
--- a/daemon/module.c
+++ b/daemon/module.c
@@ -34,7 +34,7 @@ int load_autofs4_module(void)
 	 */
 	fp = open_fopen_r("/proc/filesystems");
 	if (!fp) {
-		logerr("cannot open /proc/filesystems\n");
+		logerr("cannot open /proc/filesystems");
 		return 0;
 	}
 
diff --git a/lib/nss_parse.y b/lib/nss_parse.y
index 055e9d7..0721ba1 100644
--- a/lib/nss_parse.y
+++ b/lib/nss_parse.y
@@ -169,7 +169,7 @@ int nsswitch_parse(struct list_head *list)
 
 	nsswitch = open_fopen_r(NSSWITCH_FILE);
 	if (!nsswitch) {
-		logerr("couldn't open %s\n", NSSWITCH_FILE);
+		logerr("couldn't open %s", NSSWITCH_FILE);
 		return 1;
 	}
 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
