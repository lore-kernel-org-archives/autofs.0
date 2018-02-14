From: Ian Kent <raven@themaw.net>
Subject: [PATCH 06/20] autofs-5.1.4 - fix prefix option handling in
 expand_entry()
Date: Wed, 14 Feb 2018 14:43:25 +0800
Message-ID: <151859060538.8026.6393319689523285634.stgit@pluto.themaw.net>
References: <151859051902.8026.13693256398323544616.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151859051902.8026.13693256398323544616.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

The changes to fix the defaults handling in the amd map parser caused
the prefix option to not be expanded and also to not be propagated to
submounts in some cases.

But the prefix should be expanded in modules/parse_amd.c:expand_entry()
along with the reset of the amd map entry fields.

Just adding this to modules/parse_amd.c:expand_entry() (where it should
be) fixes the amd map entry expansion and also fixes the propagation
of the prefix to submounts.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |    1 +
 modules/parse_amd.c |   11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/CHANGELOG b/CHANGELOG
index 13f01397..19aec2ae 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -4,6 +4,7 @@ xx/xx/2018 autofs-5.1.5
 - fix use after free in do_master_list_reset().
 - fix deadlock in dumpmaps.
 - dont use array for path when not necessary.
+- fix prefix option handling in expand_entry().
 
 19/12/2017 autofs-5.1.4
 - fix spec file url.
diff --git a/modules/parse_amd.c b/modules/parse_amd.c
index 2cce5417..1a5a2960 100644
--- a/modules/parse_amd.c
+++ b/modules/parse_amd.c
@@ -725,6 +725,17 @@ static struct substvar *expand_entry(struct autofs_point *ap,
 		entry->rhost = host;
 	}
 next:
+	if (entry->pref) {
+		if (expand_selectors(ap, entry->pref, &expand, sv)) {
+			debug(logopt, MODPREFIX
+			      "pref expand(\"%s\") -> %s",
+			      entry->pref, expand);
+			free(entry->pref);
+			entry->pref = expand;
+		}
+		sv = macro_addvar(sv, "pref", 4, entry->pref);
+	}
+
 	if (entry->sublink) {
 		if (expand_selectors(ap, entry->sublink, &expand, sv)) {
 			debug(logopt, MODPREFIX

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
