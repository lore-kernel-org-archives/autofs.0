From: Ian Kent <raven@themaw.net>
Subject: [PATCH 32/35] autofs-5.1.3 - be silent about nis domain not set
Date: Mon, 16 Oct 2017 13:09:17 +0800
Message-ID: <150813055728.25695.979212507236177578.stgit@pluto.themaw.net>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

When initializing the lookup module for NIS or NISPLUS if the domain
is found to be not set then the service is not configured.

So be silent about the failure.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG                |    1 +
 modules/lookup_nisplus.c |    1 -
 modules/lookup_yp.c      |    2 --
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 704f550a..56af6b94 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -30,6 +30,7 @@ xx/xx/2017 autofs-5.1.4
 - fix nisplus lookup init not configured check.
 - make open_lookup() error handling more consistent.
 - be silent about sss library not found.
+- be silent about nis domain not set.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/modules/lookup_nisplus.c b/modules/lookup_nisplus.c
index 5e80bfe1..398e8931 100644
--- a/modules/lookup_nisplus.c
+++ b/modules/lookup_nisplus.c
@@ -49,7 +49,6 @@ static int do_init(const char *mapfmt,
 	 */
 	ctxt->domainname = nis_local_directory();
 	if (!ctxt->domainname || !strcmp(ctxt->domainname, "(none).")) {
-		logmsg(MODPREFIX "NIS+ domain not set");
 		ret = 1;
 		goto out;
 	}
diff --git a/modules/lookup_yp.c b/modules/lookup_yp.c
index b139b287..9f186ac6 100644
--- a/modules/lookup_yp.c
+++ b/modules/lookup_yp.c
@@ -127,8 +127,6 @@ static int do_init(const char *mapfmt,
 		/* This should, but doesn't, take a const char ** */
 		err = yp_get_default_domain(&domainname);
 		if (err) {
-			logerr(MODPREFIX
-			      "map %s: %s", ctxt->mapname, yperr_string(err));
 			ret = 1;
 			goto out;
 		}

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
