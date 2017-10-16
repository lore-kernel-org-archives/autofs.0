From: Ian Kent <raven@themaw.net>
Subject: [PATCH 31/35] autofs-5.1.3 - be silent about sss library not found
Date: Mon, 16 Oct 2017 13:09:11 +0800
Message-ID: <150813055134.25695.13895211657595576617.stgit@pluto.themaw.net>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

When sss is set as an nsswitch source but the sss autofs shared library
isn't found then sssd is probably not installed so it's essentially an
unconfigured source.

So be silent about the library not being found.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG            |    1 +
 modules/lookup_sss.c |    4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 25e5a8c7..704f550a 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -29,6 +29,7 @@ xx/xx/2017 autofs-5.1.4
 - revert fix argc off by one in mount_autofs.c.
 - fix nisplus lookup init not configured check.
 - make open_lookup() error handling more consistent.
+- be silent about sss library not found.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/modules/lookup_sss.c b/modules/lookup_sss.c
index 15a5ca48..88ec1693 100644
--- a/modules/lookup_sss.c
+++ b/modules/lookup_sss.c
@@ -74,10 +74,8 @@ static int open_sss_lib(struct lookup_context *ctxt)
 	}
 
 	dh = dlopen(dlbuf, RTLD_LAZY);
-	if (!dh) {
-		logerr(MODPREFIX "failed to open %s: %s", dlbuf, dlerror());
+	if (!dh)
 		return 1;
-	}
 	ctxt->dlhandle = dh;
 
 	ctxt->setautomntent = (setautomntent_t) dlsym(dh, "_sss_setautomntent");

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
