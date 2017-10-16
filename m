From: Ian Kent <raven@themaw.net>
Subject: [PATCH 08/35] autofs-5.1.3 - fix typo in autofs config file comments
Date: Mon, 16 Oct 2017 13:06:41 +0800
Message-ID: <150813040175.25695.12069358496563963768.stgit@pluto.themaw.net>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Fix a typo in the comments section of the installed autofs configuration
file comments.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG                      |    1 +
 redhat/autofs.conf.default.in  |    2 +-
 samples/autofs.conf.default.in |    2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index cc61f59e..10ef5c47 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -6,6 +6,7 @@ xx/xx/2017 autofs-5.1.4
 - add port parameter to rpc_ping().
 - dont probe NFSv2 by default.
 - add version parameter to rpc_ping().
+- fix typo in autofs config file comments.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/redhat/autofs.conf.default.in b/redhat/autofs.conf.default.in
index 3c6a3165..86821de1 100644
--- a/redhat/autofs.conf.default.in
+++ b/redhat/autofs.conf.default.in
@@ -183,7 +183,7 @@ mount_nfs_default_protocol = 4
 #
 #sss_master_map_wait = 0
 #
-# Otions for the amd parser within autofs.
+# Options for the amd parser within autofs.
 #
 # amd configuration options that are aren't used, haven't been
 # implemented or have different behaviour within autofs.
diff --git a/samples/autofs.conf.default.in b/samples/autofs.conf.default.in
index 3ea3dd10..411afe14 100644
--- a/samples/autofs.conf.default.in
+++ b/samples/autofs.conf.default.in
@@ -182,7 +182,7 @@ browse_mode = no
 #
 #sss_master_map_wait = 0
 #
-# Otions for the amd parser within autofs.
+# Options for the amd parser within autofs.
 #
 # amd configuration options that are aren't used, haven't been
 # implemented or have different behaviour within autofs.

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
