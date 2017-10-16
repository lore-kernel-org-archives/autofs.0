From: Ian Kent <raven@themaw.net>
Subject: [PATCH 34/35] autofs-5.1.3 - improve description of
 mount_nfs_default_protocol
Date: Mon, 16 Oct 2017 13:09:35 +0800
Message-ID: <150813057523.25695.3001080814749098407.stgit@pluto.themaw.net>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

The description of the mount_nfs_default_protocol protocol is not
clear so try and improve it.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG                      |    1 +
 man/autofs.conf.5.in           |    7 +++++--
 redhat/autofs.conf.default.in  |    9 ++++++---
 samples/autofs.conf.default.in |    9 ++++++---
 4 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 37816bce..c0af0ff6 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -32,6 +32,7 @@ xx/xx/2017 autofs-5.1.4
 - be silent about sss library not found.
 - be silent about nis domain not set.
 - make map source reference message debug only.
+- improve description of mount_nfs_default_protocol.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/man/autofs.conf.5.in b/man/autofs.conf.5.in
index 39e84fdb..76ee27a5 100644
--- a/man/autofs.conf.5.in
+++ b/man/autofs.conf.5.in
@@ -64,8 +64,11 @@ Maps are browsable by default (program default "yes").
 .br
 Specify the default protocol used by
 .BR mount.nfs (8)
-(program default 3). Since we can't identify this default automatically
-we need to set it in the autofs configuration.
+(program default 3). Autofs needs to know the default NFS protocol that
+.BR mount.nfs(8)
+will use so it can do special case handling for different NFS protocols.
+Since we can't identify this default automatically we need to set it in
+the autofs configuration.
 .TP
 .B append_options
 .br
diff --git a/redhat/autofs.conf.default.in b/redhat/autofs.conf.default.in
index 8de58f25..56148436 100644
--- a/redhat/autofs.conf.default.in
+++ b/redhat/autofs.conf.default.in
@@ -45,9 +45,12 @@ timeout = 300
 browse_mode = no
 #
 # mount_nfs_default_protocol - specify the default protocol used by
-# 			       mount.nfs(8). Since we can't identify
-# 			       the default automatically we need to
-# 			       set it in our configuration.
+# 			       mount.nfs(8). Autofs needs to know the
+# 			       default NFS protocol that mount.nfs(8)
+# 			       will use so it can do special case handling
+# 			       for different NFS protocols .Since we can't
+# 			       identify the default automatically we need
+# 			       to set it in our configuration.
 #
 #mount_nfs_default_protocol = 3
 mount_nfs_default_protocol = 4
diff --git a/samples/autofs.conf.default.in b/samples/autofs.conf.default.in
index a04b56f9..4bbecc64 100644
--- a/samples/autofs.conf.default.in
+++ b/samples/autofs.conf.default.in
@@ -45,9 +45,12 @@ timeout = 300
 browse_mode = no
 #
 # mount_nfs_default_protocol - specify the default protocol used by
-# 			       mount.nfs(8). Since we can't identify
-# 			       the default automatically we need to
-# 			       set it in our configuration.
+# 			       mount.nfs(8). Autofs needs to know the
+# 			       default NFS protocol that mount.nfs(8)
+# 			       will use so it can do special case handling
+# 			       for different NFS protocols .Since we can't
+# 			       identify the default automatically we need
+# 			       to set it in our configuration.
 #
 #mount_nfs_default_protocol = 3
 #

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
