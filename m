From: Ian Kent <raven@themaw.net>
Subject: [PATCH 14/37] autofs-5.1.2 - fix count_mounts() function
Date: Tue, 25 Oct 2016 09:18:40 +0800
Message-ID: <20161025011840.7778.12233.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=ZvNJJmXCo4YdfybN0o8VrrAvsZI=; b=WMsGY5aVH07UbOsPHa
        tWOeq5q9o+sTKvNZ9ewzCnw5Ma3h/YYZSo3XMigujbIXEuJMvCsB7NakIa80jV2C
        +HtjBTfD9isasLU4if3KsOg2GaQeps6VvQDDY12PLrLm0OprQeqUK2MMbq5CtB/p
        qjlFXcU877aPs6x4458riCkMg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=ZvNJJmXCo4YdfybN0o8Vrr
        AvsZI=; b=KOLxTN8AOcCYCPh3PIpQ6RXsCiGZxaE37myJ0atRu2+2/JMUKFbjGB
        zcgCUUls0HmfwoaqRIlkRyw1y6JwRrvcos7Wi0QGfK0M8GTKZabDN/bx833j1d4c
        oFL8fP9GqYamc1maJq4TDUFmRyR+ej9k7doZdREOhVCgFLV8XELAo=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

count_mounts() gets the number of mounts wrong, make it include the
base directory also.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG          |    1 +
 daemon/automount.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index 551443a..5fcd123 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -13,6 +13,7 @@ xx/xx/2016 autofs-5.1.3
 - Fix typos in error messages.
 - Fix fgets(3) size argument (another one).
 - fix short memory allocation in lookup_amd_instance().
+- fix count_mounts() function.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/daemon/automount.c b/daemon/automount.c
index e51909c..8d98054 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -420,7 +420,7 @@ int count_mounts(struct autofs_point *ap, const char *path, dev_t dev)
 	counter.count = 0;
 	counter.dev = dev;
 	
-	if (walk_tree(path, counter_fn, 0, ap, &counter) == -1)
+	if (walk_tree(path, counter_fn, 1, ap, &counter) == -1)
 		return -1;
 
 	return counter.count;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
