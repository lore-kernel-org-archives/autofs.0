From: Ian Kent <raven@themaw.net>
Subject: [PATCH 09/37] autofs-5.1.2 - fix file map changed check
Date: Tue, 25 Oct 2016 09:18:13 +0800
Message-ID: <20161025011812.7778.17776.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=+HwSeTuvIKC9t9giwCauV/D+rAw=; b=Sqhyr068lKMTNRbUPP
        1RrdK8SWVjodVOSGI/2dbPgKJEd7hDDMNnUnNBUue4EGMyJu4zAzReY9vf5SZ1O1
        LiGhx8XbHSpzLPyhomD4aqY1q35ScMxfmroBL3JVcveU6YA4PUu2UW2gSkoU2s8a
        JlgLf2Gyb9c38dptpD9mkRUVQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=+HwSeTuvIKC9t9giwCauV/
        D+rAw=; b=Uncqj5XqQBjBThBCKK9eFhJT7YWd/UUTD4zWALSl5yM1x37N8CxYsK
        Hd5T279VM4YhXSdLZFw3lVpJjB35u2nvwZ7NHxl0Sz1LQuCt73+eSV9cWlUQszv8
        bdFrLPnD7J5/LWFnVd4y8Yh4p9YDafnFqSAIH2yTeFHWNT2u9iJuc=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

The CLOCK_MONOTONIC time cannot be used to file status times, time(2)
must be used instead.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG             |    1 +
 modules/lookup_file.c |    9 ++++-----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 6333959..837debd 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -8,6 +8,7 @@ xx/xx/2016 autofs-5.1.3
 - fix libtirpc detection with -Wl,--as-needed.
 - Fix a typo in CREDITS.
 - Change .requestor to .requester for consistency.
+- fix file map changed check.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/modules/lookup_file.c b/modules/lookup_file.c
index 72444fe..d87ec73 100644
--- a/modules/lookup_file.c
+++ b/modules/lookup_file.c
@@ -45,6 +45,7 @@ struct lookup_context {
 	const char *mapname;
 	int opts_argc;
 	const char **opts_argv;
+	time_t last_read;
 	struct parse_mod *parse;
 };
 
@@ -783,6 +784,7 @@ int lookup_read_map(struct autofs_point *ap, time_t age, void *context)
 	}
 
 	source->age = age;
+	ctxt->last_read = time(NULL);
 
 	fclose(f);
 
@@ -1076,7 +1078,7 @@ static int check_map_indirect(struct autofs_point *ap,
 
 static int map_update_needed(struct autofs_point *ap,
 			     struct map_source *source,
-			     struct lookup_context * ctxt)
+			     struct lookup_context *ctxt)
 {
 	struct mapent_cache *mc;
 	struct mapent *me;
@@ -1097,9 +1099,7 @@ static int map_update_needed(struct autofs_point *ap,
 		return -1;
 	}
 
-	cache_readlock(mc);
-	me = cache_lookup_first(mc);
-	if (me && st.st_mtime <= me->age) {
+	if (st.st_mtime <= ctxt->last_read) {
 		/*
 		 * If any map instances are present for this source
 		 * then either we have plus included entries or we
@@ -1116,7 +1116,6 @@ static int map_update_needed(struct autofs_point *ap,
 			ret = 0;
 	} else
 		source->stale = 1;
-	cache_unlock(mc);
 
 	return ret;
 }

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
