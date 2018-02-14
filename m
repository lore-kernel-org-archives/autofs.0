From: Ian Kent <raven@themaw.net>
Subject: [PATCH 07/20] autofs-5.1.4 - fix sublink option not set from
 defaults
Date: Wed, 14 Feb 2018 14:43:30 +0800
Message-ID: <151859061087.8026.11202638462703599281.stgit@pluto.themaw.net>
References: <151859051902.8026.13693256398323544616.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151859051902.8026.13693256398323544616.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

If the amd entry sublink option is given in a defaults entry
it isn't merged into the current entry during parsing.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |    1 +
 modules/parse_amd.c |   12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/CHANGELOG b/CHANGELOG
index 19aec2ae..756ef927 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -5,6 +5,7 @@ xx/xx/2018 autofs-5.1.5
 - fix deadlock in dumpmaps.
 - dont use array for path when not necessary.
 - fix prefix option handling in expand_entry().
+- fix sublink option not set from defaults.
 
 19/12/2017 autofs-5.1.4
 - fix spec file url.
diff --git a/modules/parse_amd.c b/modules/parse_amd.c
index 1a5a2960..1c962fff 100644
--- a/modules/parse_amd.c
+++ b/modules/parse_amd.c
@@ -645,6 +645,18 @@ static void update_with_defaults(struct amd_entry *defaults,
 		}
 	}
 
+	if (!entry->sublink) {
+		if (defaults->sublink) {
+			tmp = strdup(defaults->sublink);
+			if (tmp)
+				entry->sublink = tmp;
+		} else {
+			v = macro_findvar(sv, "sublink", 2);
+			if (v)
+				entry->sublink = strdup(v->val);
+		}
+	}
+
 	return;
 }
 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
