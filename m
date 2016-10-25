From: Ian Kent <raven@themaw.net>
Subject: [PATCH 19/37] autofs-5.1.2 - fix argc off by one in mount_autofs.c
Date: Tue, 25 Oct 2016 09:19:06 +0800
Message-ID: <20161025011906.7778.45739.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=PHisSIevSPARTmlhjCmJHQeAsBE=; b=oXw2MfwKtTk4YVLdWP
        AMVPA+FBOLuLpvNbZRGMpaxG7sApjUQS3KRaWDJFB5wN4N85bCxgT4z+JnvSORLb
        NXaZDdXVkqWwUW+F9Db6m38L62nlGD2L/zd7Np5KHcTTkrNy74m7mSQTiCFaArOY
        0MnB4S+YMn11eSeOoAZeeKY6Q=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=PHisSIevSPARTmlhjCmJHQ
        eAsBE=; b=VGIyoe4DrhGRyzAkCFXgJXCK5gPLJXB4eexfhMMOuA1KXTByJ50Rm2
        qpYvTOpzGI58ENbv/wP1gPgE4LXgqvZ+khXKjOcSNLQtRXEhhJyuiNay+pTaWVWf
        2iyxxzEpjJJ40Be+tNGrgrOTL79oNXMYvXQA17CLFcXH1+yoRkCls=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

The mount_autofs.c module incorrectly calculates the number of
arguments to its map.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG              |    1 +
 modules/mount_autofs.c |    8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 853d40c..f46428c 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -16,6 +16,7 @@ xx/xx/2016 autofs-5.1.3
 - fix count_mounts() function.
 - configure: add cache variable for Linux proc filesystem check.
 - Avoid local variable name shadowing another.
+- fix argc off by one in mount_autofs.c.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/modules/mount_autofs.c b/modules/mount_autofs.c
index c6a3199..65c0a06 100644
--- a/modules/mount_autofs.c
+++ b/modules/mount_autofs.c
@@ -179,11 +179,11 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name,
 
 	if (options) {
 		char *t = options;
-		do {
+		while ((t = strchr(t, ',')) != NULL) {
 			argc++;
 			if (*t == ',')
 				t++;
-		} while ((t = strchr(t, ',')) != NULL);
+		}
 	}
 	argv = (const char **) alloca((argc + 1) * sizeof(char *));
 
@@ -235,13 +235,13 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name,
 
 	if (options) {
 		p = options;
-		do {
+		while ((p = strchr(p, ',')) != NULL) {
 			if (*p == ',') {
 				*p = '\0';
 				p++;
 			}
 			argv[argc++] = p;
-		} while ((p = strchr(p, ',')) != NULL);
+		}
 	}
 	argv[argc] = NULL;
 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
