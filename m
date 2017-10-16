From: Ian Kent <raven@themaw.net>
Subject: [PATCH 24/35] autofs-5.1.3 - fix amd parser error buffer size
Date: Mon, 16 Oct 2017 13:08:30 +0800
Message-ID: <150813051018.25695.5260169967641980525.stgit@pluto.themaw.net>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

There is an inconsistency between the error message buffer length
of the amd parser and the possible string length the bison generated
parser can pass to it.

Just increase the error buffer size to cover it.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |    1 +
 modules/amd_parse.y |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index 25dc7301..90d06d59 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -22,6 +22,7 @@ xx/xx/2017 autofs-5.1.4
 - check map instances for staleness on map update.
 - allow dot in OPTIONSTR value lexer pattern.
 - fix autofs_use_lofs description.
+- fix amd parser error buffer size.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/modules/amd_parse.y b/modules/amd_parse.y
index e99820b9..9694515d 100644
--- a/modules/amd_parse.y
+++ b/modules/amd_parse.y
@@ -31,7 +31,7 @@
 #include "log.h"
 
 #define MAX_OPTS_LEN	1024
-#define MAX_ERR_LEN	512
+#define MAX_ERR_LEN	3096
 
 static pthread_mutex_t parse_mutex = PTHREAD_MUTEX_INITIALIZER;
 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
