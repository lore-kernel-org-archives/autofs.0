From: Ian Kent <raven@themaw.net>
Subject: [PATCH 27/27] autofs-5.1.3 - fix log message in spawn_umount()
Date: Mon, 11 Dec 2017 17:00:32 +0800
Message-ID: <151298283271.19722.1032845511702316903.stgit@pluto.themaw.net>
References: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

A log message in spawn_umount() uses mount when it should be
using umount.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG      |    1 +
 daemon/spawn.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index 30343332..49798a87 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -60,6 +60,7 @@ xx/xx/2017 autofs-5.1.4
 - fix memory leak in umount_amd_ext_mount().
 - fix strerror_r() parameter declaration in do program_mount().
 - fix incorrect check in validate_program_options().
+- fix log message in spawn_umount().
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/daemon/spawn.c b/daemon/spawn.c
index 56133815..fabe577e 100644
--- a/daemon/spawn.c
+++ b/daemon/spawn.c
@@ -844,7 +844,7 @@ int spawn_umount(unsigned logopt, ...)
 			 * the mtab.
 			 */
 			if (!printed) {
-				debug(logopt, "mount failed with error code 16"
+				debug(logopt, "umount failed with error code 16"
 				      ", retrying with the -f option");
 				printed = 1;
 			}

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
