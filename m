From: Ian Kent <raven@themaw.net>
Subject: [PATCH 20/20] autofs-5.1.4 - add an example fedfs master map entry
 to the installed master map
Date: Wed, 14 Feb 2018 14:44:44 +0800
Message-ID: <151859068445.8026.13141630121236897160.stgit@pluto.themaw.net>
References: <151859051902.8026.13693256398323544616.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151859051902.8026.13693256398323544616.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Add an example of using the fedfs program map (to facilitate access
to fedfs domain mounts) to the installed master map.
---
 CHANGELOG           |    1 +
 samples/auto.master |    6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/CHANGELOG b/CHANGELOG
index bbe8019e..f771a433 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -18,6 +18,7 @@ xx/xx/2018 autofs-5.1.5
 - add mount.fedfs.c.
 - add fedfs-map-nfs4.c.
 - add conditional inclusion of fedfs binaries.
+- add an example fedfs master map entry to the installed master map.
 
 19/12/2017 autofs-5.1.4
 - fix spec file url.
diff --git a/samples/auto.master b/samples/auto.master
index 0f2c8ab0..6c95fadf 100644
--- a/samples/auto.master
+++ b/samples/auto.master
@@ -17,6 +17,12 @@
 #
 +dir:/etc/auto.master.d
 #
+# If you have fedfs setup and the realted binaries, either
+# built as part of autofs or installed from another package,
+# uncomment this line to use the fedfs program map to access
+# your fedfs mounts.
+#/nfs4  /usr/sbin/fedfs-map-nfs4 nobind
+#
 # Include central master map if it can be found using
 # nsswitch sources.
 #

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
