From: Ian Kent <raven@themaw.net>
Subject: [PATCH 10/37] autofs-5.1.2 - Remove unused local 2KB buffer
Date: Tue, 25 Oct 2016 09:18:19 +0800
Message-ID: <20161025011818.7778.26674.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=MSeF+m0oPNIbugbciC703gpu5c0=; b=NMKAGb0aUMw3Uviu5M
        nAVDoyHtsOzIesz2o+8BE8q8C8iEOluxKfqEBBtoF+2UcyBsF43MnL6vy4HplrLZ
        1Y5f19dLSjRLZUbORbkXlsLCqbEn1B4bGqsIZJwPCGTC94IoBqaYwAXTt7mdk8Ao
        FJE+QPcHHrNbByu86gnQZA5oA=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=MSeF+m0oPNIbugbciC703g
        pu5c0=; b=HCTGbMMecXC35BIMyUkyJWv39P1DplWsuVXpl60mIOGkrgA5RQjfB3
        Q5dI+IPMOOSNFf10KOHDRDsOsiBgwXitx4Wn6RuPMgEKpucDemZAFlmaAezpDLz1
        cXrg2UuheXbtSuKB16t+iw8slZjiFirnqNz/OfVLy0hLVk5sYXg3k=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG          |    1 +
 daemon/automount.c |    3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 837debd..7aa7b4a 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -9,6 +9,7 @@ xx/xx/2016 autofs-5.1.3
 - Fix a typo in CREDITS.
 - Change .requestor to .requester for consistency.
 - fix file map changed check.
+- Remove unused local 2KB buffer.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/daemon/automount.c b/daemon/automount.c
index fee93cc..1bdc3aa 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -1901,7 +1901,6 @@ static void usage(void)
 
 static void show_build_info(void)
 {
-	char buf[2048];
 	int count = 0;
 
 	printf("\nLinux automount version %s\n", version);
@@ -1913,8 +1912,6 @@ static void show_build_info(void)
 
 	printf("\nCompile options:\n  ");
 
-	memset(buf, 0, 2048);
-
 #ifndef ENABLE_MOUNT_LOCKING
 	printf("DISABLE_MOUNT_LOCKING ");
 	count = 22;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
