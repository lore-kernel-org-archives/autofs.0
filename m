From: Ian Kent <raven@themaw.net>
Subject: [PATCH 05/34] autofs-5.1.2 - make lookup_nss_read_master() return
 nss status
Date: Mon, 24 Apr 2017 09:00:38 +0800
Message-ID: <149299563880.23475.7855459198402153066.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=TVkr56MCnOilfBi7lL
        beXEuPzPKi4syxBfGXpyr5vHU=; b=bHoa45UJutZarT/kVVfmc0yQoQk4ZDZqL0
        s+S4JUsFVXOJaHxWpI4XQNXbXjJyqq29g9Dicf3xtqClYCeGv4e+ND8PQPiHAnEU
        ZmBoAt5lWvc/62ZODYcLL4etuvLPApo3oKueIiBMnYtkSXMmlNuQvkkshYwX7SuS
        0/kYNB3SCNxW4MEqNg9QIN1DiSE7jXNuK+1GK2EYEL6A9j6vubUogBPSX/F9ShAt
        cbCHBYZUq1PgiZPXTJZPa5bGEw8NkffHXOkpLtjUNvJO6yCgCu05c2mN7b05Ro1w
        EvQdoixzNkUMEI4P+KgoR4qdM4fK4xa7KlB2u2HQuPS9D38W5IJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=TVkr56MCnOilfBi7lLbeXEuPzPKi4syxBfGXpyr5vHU=; b=EmXxNFJ2
        Ib3/mwxzeyS9zInMlVshjOPJQehB3HZRkTr+BnZO6HODMnua9YibQNZGeEbQVYwO
        kAQiL6/PqTTN0kWOgBbh0RUesSz0G+KkCUv1K/L1K7TFxLytZofIrOmwnaREK+dU
        ZWqUFfnN4JXGil22Fjzw5ncxAie2arhaox6BYw2C1xOqTvHIkr61GJjdf6/B4Pn9
        gQ+GW1DkQ4WNZg5dXtFv2rTCwGa7HtR76cvGaILZC9VSXwo5PFzB/POZoDhYD86j
        m430+Q5oKllVYhAFgSaX9ytZTAw9UiltwsZiVNxFENMBkz3Spm1SpkhOlYpCFGo5
        vFl1i42N68cZpg==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Currently lookup_nss_read_master() uses a boolean return but in order
for the master map retry read to function properly when trying to read
plus included maps it needs to return an NSS status instead.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG             |    1 +
 daemon/lookup.c       |   14 ++++++++++----
 modules/lookup_dir.c  |    2 +-
 modules/lookup_file.c |    2 +-
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 7337ec6..408edf8 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -31,6 +31,7 @@ xx/xx/2016 autofs-5.1.3
 - dont exit on master map read fail timeout.
 - set sane default master read wait timeout.
 - don't return until after master map retry read.
+- make lookup_nss_read_master() return nss status.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/daemon/lookup.c b/daemon/lookup.c
index a46740e..5ff837d 100644
--- a/daemon/lookup.c
+++ b/daemon/lookup.c
@@ -175,7 +175,7 @@ int lookup_nss_read_master(struct master *master, time_t age)
 		if (result == NSS_STATUS_UNAVAIL)
 			master->read_fail = 1;
 
-		return !result;
+		return result;
 	} else {
 		char *name = master->name;
 		char *tmp;
@@ -225,7 +225,7 @@ int lookup_nss_read_master(struct master *master, time_t age)
 				if (result == NSS_STATUS_UNAVAIL)
 					master->read_fail = 1;
 
-				return !result;
+				return result;
 			}
 		}
 	}
@@ -237,7 +237,7 @@ int lookup_nss_read_master(struct master *master, time_t age)
 		if (!list_empty(&nsslist))
 			free_sources(&nsslist);
 		error(logopt, "can't to read name service switch config.");
-		return 0;
+		return NSS_STATUS_UNAVAIL;
 	}
 
 	/* First one gets it */
@@ -282,6 +282,12 @@ int lookup_nss_read_master(struct master *master, time_t age)
 			}
 		}
 
+		/* We've been instructed to move onto the next source */
+		if (result == NSS_STATUS_TRYAGAIN) {
+			result = NSS_STATUS_SUCCESS;
+			continue;
+		}
+
 		if (result == NSS_STATUS_UNKNOWN ||
 		    result == NSS_STATUS_NOTFOUND) {
 			debug(logopt, "no map - continuing to next source");
@@ -302,7 +308,7 @@ int lookup_nss_read_master(struct master *master, time_t age)
 	if (!list_empty(&nsslist))
 		free_sources(&nsslist);
 
-	return !result;
+	return result;
 }
 
 static int do_read_map(struct autofs_point *ap, struct map_source *map, time_t age)
diff --git a/modules/lookup_dir.c b/modules/lookup_dir.c
index 2880447..ab1d82f 100644
--- a/modules/lookup_dir.c
+++ b/modules/lookup_dir.c
@@ -174,7 +174,7 @@ static int include_file(struct master *master, time_t age, struct lookup_context
 	master->depth++;
 	debug(logopt, MODPREFIX "include: %s", master->name);
 	status = lookup_nss_read_master(master, age);
-	if (!status) {
+	if (status != NSS_STATUS_SUCCESS) {
 		warn(logopt,
 		     MODPREFIX
 		     "failed to read included master map %s",
diff --git a/modules/lookup_file.c b/modules/lookup_file.c
index cb00ee5..36247c5 100644
--- a/modules/lookup_file.c
+++ b/modules/lookup_file.c
@@ -504,7 +504,7 @@ int lookup_read_master(struct master *master, time_t age, void *context)
 				master->recurse = 1;
 			master->depth++;
 			status = lookup_nss_read_master(master, age);
-			if (!status) {
+			if (status != NSS_STATUS_SUCCESS) {
 				warn(logopt,
 				     MODPREFIX
 				     "failed to read included master map %s",

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
