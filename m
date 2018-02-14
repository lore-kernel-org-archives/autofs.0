From: Ian Kent <raven@themaw.net>
Subject: [PATCH 05/20] autofs-5.1.4 - dont use array for path when not
 necessary
Date: Wed, 14 Feb 2018 14:43:19 +0800
Message-ID: <151859059979.8026.13802585904227722368.stgit@pluto.themaw.net>
References: <151859051902.8026.13693256398323544616.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151859051902.8026.13693256398323544616.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

In parse_amd.c:do_link_mount() a character array is used to construct
a path when a pointer to the relevant amd entry field is sufficient.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |    1 +
 modules/parse_amd.c |    6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 0f30596f..13f01397 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -3,6 +3,7 @@ xx/xx/2018 autofs-5.1.5
 - fix directory create permission.
 - fix use after free in do_master_list_reset().
 - fix deadlock in dumpmaps.
+- dont use array for path when not necessary.
 
 19/12/2017 autofs-5.1.4
 - fix spec file url.
diff --git a/modules/parse_amd.c b/modules/parse_amd.c
index c4b3ef0b..2cce5417 100644
--- a/modules/parse_amd.c
+++ b/modules/parse_amd.c
@@ -967,8 +967,8 @@ static int do_auto_mount(struct autofs_point *ap, const char *name,
 static int do_link_mount(struct autofs_point *ap, const char *name,
 			 struct amd_entry *entry, unsigned int flags)
 {
-	char target[PATH_MAX + 1];
 	const char *opts = (entry->opts && *entry->opts) ? entry->opts : NULL;
+	char *target;
 	int ret;
 
 	if (entry->sublink) {
@@ -977,14 +977,14 @@ static int do_link_mount(struct autofs_point *ap, const char *name,
 			     "error: sublink option length is too long");
 			return 0;
 		}
-		strcpy(target, entry->sublink);
+		target = entry->sublink;
 	} else {
 		if (strlen(entry->fs) > PATH_MAX) {
 			error(ap->logopt, MODPREFIX
 			     "error: fs option length is too long");
 			return 0;
 		}
-		strcpy(target, entry->fs);
+		target = entry->fs;
 	}
 
 	if (!(flags & CONF_AUTOFS_USE_LOFS))

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
