From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Bug#682266: [PATCH] Allow nsswitch.conf to not contain automount
	lines
Date: Sat, 22 Sep 2012 12:39:51 +0400
Message-ID: <1348303191-7980-1-git-send-email-mjt@msgid.tls.msk.ru>
Reply-To: Michael Tokarev <mjt@tls.msk.ru>, 682266@bugs.debian.org
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.682266.B682266.134830320310796@bugs.debian.org>
List-Id: <autofs.vger.kernel.org>
List-URL: <http://lists.debian.org/debian-bugs-dist/>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, Michael Tokarev <mjt@tls.msk.ru>, 682266@bugs.debian.org

Current code does not allow a case when nsswitch.conf
does not mention automount map at all, like all new
installations.  It logs a rather unpleasant error
message instead:

 syntax error in nsswitch config near [ syntax error ]

this patch has a minimal fix, to allo "file" to be empty.

Whole parser in C is about 25 lines of code, the "grammar"
is trivial, and it is better to ditch all this yacc/lex
stuff, but that will be much more intrusive change.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Cc: 682266@bugs.debian.org
---
 lib/nss_parse.y |    1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/nss_parse.y b/lib/nss_parse.y
index a39fda4..055e9d7 100644
--- a/lib/nss_parse.y
+++ b/lib/nss_parse.y
@@ -72,6 +72,7 @@ file: {
 		nss_debug = YYDEBUG;
 #endif
 	} sources NL
+	| /* empty */
 	;
 
 sources: nss_source
-- 
1.7.10.4

