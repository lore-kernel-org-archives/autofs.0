From: Ian Kent <raven@themaw.net>
Subject: [PATCH 23/35] autofs-5.1.3 - fix autofs_use_lofs description
Date: Mon, 16 Oct 2017 13:08:24 +0800
Message-ID: <150813050436.25695.10102628797980124153.stgit@pluto.themaw.net>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

The autofs.conf man page and configuration comments claim the
autofs_use_lofs configuration option applies to amd "type:=auto"
map entries.

That's incorrect, this flag applies to "type:=link" mounts.

Also fix a typo in the dismount_interval man page description
above the autofs_use_lofs description.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG                      |    1 +
 man/autofs.conf.5.in           |    4 ++--
 redhat/autofs.conf.default.in  |    2 +-
 samples/autofs.conf.default.in |    2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 1b61bb32..25dc7301 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -21,6 +21,7 @@ xx/xx/2017 autofs-5.1.4
 - fix possible map instance memory leak.
 - check map instances for staleness on map update.
 - allow dot in OPTIONSTR value lexer pattern.
+- fix autofs_use_lofs description.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/man/autofs.conf.5.in b/man/autofs.conf.5.in
index ec2d4bb3..39e84fdb 100644
--- a/man/autofs.conf.5.in
+++ b/man/autofs.conf.5.in
@@ -429,12 +429,12 @@ as a full path.
 Is equivalent to the autofs timeout option. It is only possible
 to use this with type "auto" mounts due to the way the autofs
 kernel module performs expiry. It takes its default value from
-the autofs internal defaulti of 600 seconds.
+the autofs internal default of 600 seconds.
 .TP
 .B autofs_use_lofs
 .br
 If set to "yes" autofs will attempt to use bind mounts for type
-"auto" when possible.
+"link" entries when possible (default is "yes").
 .TP
 .B nis_domain
 .br
diff --git a/redhat/autofs.conf.default.in b/redhat/autofs.conf.default.in
index 86821de1..8de58f25 100644
--- a/redhat/autofs.conf.default.in
+++ b/redhat/autofs.conf.default.in
@@ -329,7 +329,7 @@ mount_nfs_default_protocol = 4
 #	implementation.
 #
 # autofs_use_lofs - if set to "yes" autofs will attempt to use bind
-#	mounts for type "auto" when possible.
+#	mounts for type "link" entries when possible.
 #
 # nis_domain - allows setting of a domain name other than the system
 #	default.
diff --git a/samples/autofs.conf.default.in b/samples/autofs.conf.default.in
index 411afe14..a04b56f9 100644
--- a/samples/autofs.conf.default.in
+++ b/samples/autofs.conf.default.in
@@ -328,7 +328,7 @@ browse_mode = no
 #	implementation.
 #
 # autofs_use_lofs - if set to "yes" autofs will attempt to use bind
-#	mounts for type "auto" when possible.
+#	mounts for type "link" entries when possible.
 #
 # nis_domain - allows setting of a domain name other than the system
 #	default.

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
