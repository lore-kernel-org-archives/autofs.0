From: Ian Kent <raven@themaw.net>
Subject: [PATCH 04/27] autofs-5.1.3 - Fix two typos
Date: Mon, 11 Dec 2017 16:57:49 +0800
Message-ID: <151298266929.19722.1244360532517904887.stgit@pluto.themaw.net>
References: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

From: Thiago Rafael Becker <thiago.becker@gmail.com>

In two manpages random is misspelled as 'ramdom'

Signed-off-by: Thiago Rafael Becker <thiago.becker@gmail.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 man/auto.master.5.in |    2 +-
 man/automount.8      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/man/auto.master.5.in b/man/auto.master.5.in
index f6705039..55a6acd0 100644
--- a/man/auto.master.5.in
+++ b/man/auto.master.5.in
@@ -192,7 +192,7 @@ or with individual map entries. The option is ignored for direct mounts
 and non-root offest mount entries.
 .TP
 .I "\-r, \-\-random-multimount-selection"
-Enables the use of ramdom selection when choosing a host from a
+Enables the use of random selection when choosing a host from a
 list of replicated servers. This option is applied to this mount
 only, overriding the global setting that may be specified on the
 command line.
diff --git a/man/automount.8 b/man/automount.8
index 8e0551e9..1e15ecd2 100644
--- a/man/automount.8
+++ b/man/automount.8
@@ -61,7 +61,7 @@ mount entries.
 Run the daemon in the foreground and log to stderr instead of syslog."
 .TP
 .I "\-r, \-\-random-multimount-selection"
-Enables the use of ramdom selection when choosing a host from a
+Enables the use of random selection when choosing a host from a
 list of replicated servers.
 .TP
 .I "\-m, \-\-dumpmaps [<map type> <map name>]"

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
