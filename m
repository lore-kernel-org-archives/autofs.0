From: Ian Kent <raven@themaw.net>
Subject: [PATCH 10/27] autofs-5.1.3 - fix typo in amd_parse.c
Date: Mon, 11 Dec 2017 16:58:38 +0800
Message-ID: <151298271848.19722.3743545963111985744.stgit@pluto.themaw.net>
References: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Fix a typo in the "cachefs" fs type value syntax error message.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |    1 +
 modules/amd_parse.y |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index bbeaa406..a7903875 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -43,6 +43,7 @@ xx/xx/2017 autofs-5.1.4
 - move open_xxxx() functions to spawn.c.
 - serialize calls to open_xxxx() functions.
 - improve debug logging of lookup key.
+- fix typo in amd_parse.c.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/modules/amd_parse.y b/modules/amd_parse.y
index 9694515d..2a92d4a1 100644
--- a/modules/amd_parse.y
+++ b/modules/amd_parse.y
@@ -299,7 +299,7 @@ option_assignment: MAP_OPTION OPTION_ASSIGN FS_TYPE
 			amd_msg(msg_buf);
 			YYABORT;
 		} else if (!strcmp($3, "cachefs")) {
-			sprintf(msg_buf, "file syatem %s is not "
+			sprintf(msg_buf, "file system %s is not "
 					 "supported by autofs, ignored", $3);
 			amd_msg(msg_buf);
 		} else {

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
