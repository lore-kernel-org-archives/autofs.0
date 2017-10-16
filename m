From: Ian Kent <raven@themaw.net>
Subject: [PATCH 29/35] autofs-5.1.3 - fix nisplus lookup init not configured
 check
Date: Mon, 16 Oct 2017 13:08:59 +0800
Message-ID: <150813053935.25695.8650716604303497204.stgit@pluto.themaw.net>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

If nisplus is not configured nis_local_directory() can return the domain
name "(none).".

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG                |    1 +
 modules/lookup_nisplus.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index 6ac29220..5a2bf171 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -27,6 +27,7 @@ xx/xx/2017 autofs-5.1.4
 - document ghost option in auto.master man page.
 - only take master map mutex for master map update.
 - revert fix argc off by one in mount_autofs.c.
+- fix nisplus lookup init not configured check.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/modules/lookup_nisplus.c b/modules/lookup_nisplus.c
index 6430b890..5e80bfe1 100644
--- a/modules/lookup_nisplus.c
+++ b/modules/lookup_nisplus.c
@@ -48,7 +48,7 @@ static int do_init(const char *mapfmt,
 	 * We don't need to copy or free it.
 	 */
 	ctxt->domainname = nis_local_directory();
-	if (!ctxt->domainname) {
+	if (!ctxt->domainname || !strcmp(ctxt->domainname, "(none).")) {
 		logmsg(MODPREFIX "NIS+ domain not set");
 		ret = 1;
 		goto out;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
