From: Ian Kent <raven@themaw.net>
Subject: [PATCH 26/27] autofs-5.1.3 - fix incorrect check in
 validate_program_options()
Date: Mon, 11 Dec 2017 17:00:26 +0800
Message-ID: <151298282601.19722.10465816465708674514.stgit@pluto.themaw.net>
References: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Fix incorrectly checking *entry->fs when entry->fs is NULL in
validate_program_options().

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |    1 +
 modules/parse_amd.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index 9b5801fb..30343332 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -59,6 +59,7 @@ xx/xx/2017 autofs-5.1.4
 - add amd mount type program mount support.
 - fix memory leak in umount_amd_ext_mount().
 - fix strerror_r() parameter declaration in do program_mount().
+- fix incorrect check in validate_program_options().
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/modules/parse_amd.c b/modules/parse_amd.c
index 4a59ed49..5d8c648a 100644
--- a/modules/parse_amd.c
+++ b/modules/parse_amd.c
@@ -1475,7 +1475,7 @@ static unsigned int validate_program_options(unsigned int logopt,
 		return 0;
 	}
 
-	if (!entry->fs && !*entry->fs) {
+	if (!entry->fs || !*entry->fs) {
 		error(logopt, MODPREFIX
 		    "%s: ${fs} must be used as the mount point but is not set",
 		    entry->type);

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
