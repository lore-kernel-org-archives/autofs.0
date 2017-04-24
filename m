From: Ian Kent <raven@themaw.net>
Subject: [PATCH 33/34] autofs-5.1.2 - fix offset mount location multiple
 expansion
Date: Mon, 24 Apr 2017 09:03:02 +0800
Message-ID: <149299578281.23475.8735804636555980330.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=G/m2K/0D8vzQgDXl0O
        UJqEyeZp365UW2XUaKTuUGKcs=; b=eJEQZtYa9aOMxbTZeugLmPBnvbGi1Om3rm
        wEuHhtv4zZWWXDhiwA+MGpDv1m7pscI0xFt0WADSzd68/54F/HV+z84wu54WRXqv
        FZWGu+54xnv2B2JbnYnZmRJWDzwHBysTsg+DPF+ZxWL8I6sgEnT+FIEC+mpfhtEs
        gFXIfzmrOq2gJ1pHMnMtKauy+tGJwS2F3KTuXkFknEL5UzVfGdlAPa4hFixgaANQ
        3//Z3wm5aIaDNFChDUlFmEmp5Ef00jJZmBGRcGX4S9/495pqmm1B7KURcPOUjnq5
        W41Q6/BrfPl/Q/Yv6paA3/f7avT0K1n1WIEt5HbT1ZkcmGUFoMXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=G/m2K/0D8vzQgDXl0OUJqEyeZp365UW2XUaKTuUGKcs=; b=hZ451kJq
        bBgnmbs7+SZA3p9/fp/8+87Up7SOw+7ptXhrw84ZBGtIymm25jnOP2t4lnvCDukL
        Jiw0EIuIOdLR1tnXQvM54N60MfqN7q8KQe/RgrIWTRmsPgTX49Rql23pdx4lR4G0
        Ags3cSuOo3aGQ9qm6xzRUrgyTuLceMhe3RL+2VpZqXKrwOqq5HkXBaNSVVGpgN5a
        LUXBHxovh7gtk6m1nl2N6PpjkWuUcFthCfpNO4jU4zhEjefg9OXqOkPyVbwV+sIe
        +3Byjy/b8tYQp5441excgUDaziGAysT79xrlOyhPg4A45fWLeokoTbgiWayJPPKQ
        FkLz/gQEZV/Opw==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

When parsing an offset map entry mount location it shouldn't be
expanded because it will have already been dequoted before being
added to the map entry cache when it was first parsed.

Expanding it again can lead to inconsistent behaviour between
the expansion of simple map entry locations and offset locations
that have had quoting removed as part of the initial parse.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |    1 +
 modules/parse_sun.c |   25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/CHANGELOG b/CHANGELOG
index 1ea69d5..46487f1 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -59,6 +59,7 @@ xx/xx/2016 autofs-5.1.3
 - fix work around sss startup delay.
 - fix invalid reference in remount_active_mount().
 - use malloc for expanded map location.
+- fix offset mount location multiple expansion.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/modules/parse_sun.c b/modules/parse_sun.c
index 8955c84..536a9bc 100644
--- a/modules/parse_sun.c
+++ b/modules/parse_sun.c
@@ -1297,6 +1297,30 @@ int parse_mount(struct autofs_point *ap, const char *name,
 
 	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &cur_state);
 
+	/* Offset map entries have been expanded already, avoid expanding
+	 * them again so that the quote handling is consistent between map
+	 * entry locations and (previously expanded) offset map entry
+	 * locations.
+	 */
+	if (*name == '/') {
+		cache_readlock(mc);
+		me = cache_lookup_distinct(mc, name);
+		if (me && me->multi && me->multi != me) {
+			cache_unlock(mc);
+			mapent_len = strlen(mapent) + 1;
+			pmapent = malloc(mapent_len + 1);
+			if (!pmapent) {
+				char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
+				logerr(MODPREFIX "malloc: %s", estr);
+				return 1;
+			}
+			memset(pmapent, 0, mapent_len + 1);
+			strcpy(pmapent, mapent);
+			goto dont_expand;
+		}
+		cache_unlock(mc);
+	}
+
 	macro_lock();
 	ctxt->subst = addstdenv(ctxt->subst, NULL);
 
@@ -1313,6 +1337,7 @@ int parse_mount(struct autofs_point *ap, const char *name,
 	ctxt->subst = removestdenv(ctxt->subst, NULL);
 	macro_unlock();
 
+dont_expand:
 	pthread_setcancelstate(cur_state, NULL);
 
 	debug(ap->logopt, MODPREFIX "expanded entry: %s", pmapent);

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
