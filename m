From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH] automount: Drop redundant \n in logerr()
Date: Mon,  4 Jul 2016 19:48:52 +0900
Message-ID: <1467629332-8581-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/+oMoBl95tfTo16so/KSLwKpgxSbotDheDhbgGVKtI8=;
        b=d85SRjtcgwTI3odUaxbFNQZye+APPKZLAxd3Z1e+uJFsTL1FdswTa1JPAACM0AMfDv
         pUXp0z0lCJzcJc+1cduLdS37W7FVqsdqNztFG6i1mmLaXOkUYPTiX/bAgPARYYwfpcZI
         OHkMsDpGtuFlduSjHkktShQ6Gh7barmZgr6WfQ2c4Yqxon+ddjNvMOhhlMC8wNTZMAe6
         Sev5DZDdmBej14Et7uo5g+SByrQvD2I8ekUVQKDTPBVrqR8JgI1oji3jrFNAYbBkvZln
         T4RN29TxLmVZgCFlIdn+JAlRet1Ld93mJ/bxw9EPQ9Ckw23A/Ij8PWm8kJcpv4T2r7+N
         RwDg==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs@vger.kernel.org, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

Line break isn't necessary from the way logerr (and logmsg) is implemented,
and these two probably aren't intentional.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 daemon/module.c | 2 +-
 lib/nss_parse.y | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
