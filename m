From: Ian Kent <raven@themaw.net>
Subject: [PATCH 08/20] autofs-5.1.4 - fix error return in do_nfs_mount()
Date: Wed, 14 Feb 2018 14:43:36 +0800
Message-ID: <151859061639.8026.9737362537847348474.stgit@pluto.themaw.net>
References: <151859051902.8026.13693256398323544616.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151859051902.8026.13693256398323544616.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Fix incorrect error return in modules/parse_amd.c:do_nfs_mount().
---
 CHANGELOG           |    1 +
 modules/parse_amd.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index 756ef927..d0cfa19b 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -6,6 +6,7 @@ xx/xx/2018 autofs-5.1.5
 - dont use array for path when not necessary.
 - fix prefix option handling in expand_entry().
 - fix sublink option not set from defaults.
+- fix error return in do_nfs_mount().
 
 19/12/2017 autofs-5.1.4
 - fix spec file url.
diff --git a/modules/parse_amd.c b/modules/parse_amd.c
index 1c962fff..2a5d9a30 100644
--- a/modules/parse_amd.c
+++ b/modules/parse_amd.c
@@ -1099,7 +1099,7 @@ static int do_nfs_mount(struct autofs_point *ap, const char *name,
 	if (strlen(entry->rhost) + strlen(entry->rfs) + 1 > PATH_MAX) {
 		error(ap->logopt, MODPREFIX
 		     "error: rhost + rfs options length is too long");
-		return 0;
+		return 1;
 	}
 
 	strcpy(target, entry->rhost);

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
