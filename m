From: Ian Kent <raven@themaw.net>
Subject: [PATCH 25/27] autofs-5.1.3 - fix strerror_r() parameter declaration
 in do program_mount()
Date: Mon, 11 Dec 2017 17:00:15 +0800
Message-ID: <151298281590.19722.3807466808232336059.stgit@pluto.themaw.net>
References: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Fix an incorrect declaration for an error message buffer on function
program_mount().

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |    1 +
 modules/parse_amd.c |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 8a9fdb1f..9b5801fb 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -58,6 +58,7 @@ xx/xx/2017 autofs-5.1.4
 - add function construct_argv().
 - add amd mount type program mount support.
 - fix memory leak in umount_amd_ext_mount().
+- fix strerror_r() parameter declaration in do program_mount().
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/modules/parse_amd.c b/modules/parse_amd.c
index 0b2440ea..4a59ed49 100644
--- a/modules/parse_amd.c
+++ b/modules/parse_amd.c
@@ -1290,8 +1290,8 @@ static int do_program_mount(struct autofs_point *ap,
 	} else {
 		rv = mkdir_path(entry->fs, 0555);
 		if (rv && errno != EEXIST) {
-			char *buf[MAX_ERR_BUF];
-			char * estr;
+			char buf[MAX_ERR_BUF];
+			char *estr;
 
 			estr = strerror_r(errno, buf, MAX_ERR_BUF);
 			error(ap->logopt,

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
