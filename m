From: Ian Kent <raven@themaw.net>
Subject: [PATCH 22/35] autofs-5.1.3 - allow dot in OPTIONSTR value lexer
 pattern
Date: Mon, 16 Oct 2017 13:08:13 +0800
Message-ID: <150813049304.25695.7525220663527139831.stgit@pluto.themaw.net>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

The options string in master map entries doesn't allow dot in the
string value side of an option assignment. This prevents using an
option like vers=4.1 to apply to all entries of the map.

Add . to the options value portion of the regular expression used
for this field.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG        |    1 +
 lib/master_tok.l |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index 9815da29..1b61bb32 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -20,6 +20,7 @@ xx/xx/2017 autofs-5.1.4
 - also check flag file exe name.
 - fix possible map instance memory leak.
 - check map instances for staleness on map update.
+- allow dot in OPTIONSTR value lexer pattern.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/lib/master_tok.l b/lib/master_tok.l
index 63dab50d..41ac4995 100644
--- a/lib/master_tok.l
+++ b/lib/master_tok.l
@@ -91,7 +91,7 @@ OPTWS		[[:blank:]]*
 NL		\r?\n
 CONT		\\\n{OPTWS}
 
-OPTIONSTR	([\-]?([[:alpha:]_]([[:alnum:]_\-])*(=(\"?([[:alnum:]_\-\:])+\"?))?)+)
+OPTIONSTR	([\-]?([[:alpha:]_]([[:alnum:]_\-])*(=(\"?([[:alnum:]_\-\:\.])+\"?))?)+)
 MACROSTR	(-D{OPTWS}([[:alpha:]_]([[:alnum:]_\-\.])*)=([[:alnum:]_\-\.])+)
 SLASHIFYSTR	(--(no-)?slashify-colons)
 NUMBER		[0-9]+

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
