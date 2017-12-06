From: Thiago Rafael Becker <thiago.becker@gmail.com>
Subject: [PATCH] Fix two typos
Date: Wed,  6 Dec 2017 13:17:58 -0200
Message-ID: <20171206151758.13854-1-thiago.becker@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=E+FQXTnz5dEhx3lFXevFlcSbV4y2oJ9kvc7ROA4f188=;
        b=qWwuPcoyJgycpNAvvY0AV449BspTl6J8U+MK7oC2QAVSyDfxW7HjQcif51KW9eUT2A
         hywaA+Y5ZCO0a8sQ7zpo/dsC5dNra52tDWRUa7Sf7m4gjZ3jW4gb6shSSjhfMemNZcrd
         yHXrFASrMEHdXdn1LuhLXpq8Xtm9eeRpWUNBrr1v15hC/hiWt3H67SWKtDDdFBAlw61d
         57hBmZHC0S7d+n6Wr8F2o7kYB3DvE/2u5ObTYqAMPgLZUavZWglGY8C9dSvMQT5baCo2
         KRk8V2Ygm7tvpLid+sRhPjTjDTjirKUie/0ILWv7w1OKtC1xqJMtWVs3DXEDQhYL1DU4
         6EeQ==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Thiago Rafael Becker <thiago.becker@gmail.com>

In two manpages random is misspelled as 'ramdom'

Signed-off-by: Thiago Rafael Becker <thiago.becker@gmail.com>
---
 man/auto.master.5.in | 2 +-
 man/automount.8      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/man/auto.master.5.in b/man/auto.master.5.in
index ba28494..6555e64 100644
--- a/man/auto.master.5.in
+++ b/man/auto.master.5.in
@@ -191,7 +191,7 @@ or with individual map entries. The option is ignored for direct mounts
 and non-root offest mount entries.
 .TP
 .I "\-r, \-\-random-multimount-selection"
-Enables the use of ramdom selection when choosing a host from a
+Enables the use of random selection when choosing a host from a
 list of replicated servers. This option is applied to this mount
 only, overriding the global setting that may be specified on the
 command line.
diff --git a/man/automount.8 b/man/automount.8
index 601c18c..78ae503 100644
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
2.9.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
