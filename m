From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH] automount: Fix size arg of fgets(3)
Date: Mon,  4 Jul 2016 23:31:25 +0900
Message-ID: <1467642685-2117-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=l9dsmngLRSDRHVlmvocTGeDbWiPz6bGaRAQiq+/sxZY=;
        b=iPs5hAN0Dp66v6PsZRfYnKDB6J8hqOAmmtF3goWhptnl9OdfNWaasNh6PF9iaaaC8y
         m0tzNmeYt/o8RNVBas3VPhvUyJN4Ki7BT3Hn7AXTg0QuexEzfpD5Ch3XipTuF5skdiWw
         MM+sWKQtLZdezwvLemfci2sC9s2L/UZ0RBxM5DUZeP9nGZijIkP0FYT7eHHU/0CHElBi
         z/NDyzkOvbsbgFI9sU30swfQvR6cer0hUNRDirdpOzaij+Jeyc2FIGx1UOxPANFVR7VO
         pdi3BebThdO/AsW80xWPx8C9HYP3FJg6h08nYYyTtM3+CSKbhxDDI13hrzC6hemfqQLn
         mdrQ==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs@vger.kernel.org, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

Since fgets(3) reads at most 1 less than size arg, it should
probably pass MAX_LINE_LEN+1 given that the conditional in the
next line tests if strlen() exceeds MAX_LINE_LEN.
(i.e. MAX_LINE_LEN isn't designed to include terminating \0)

buf has MAX_LINE_LEN+2 bytes, so passing MAX_LINE_LEN+1 is ok.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 lib/defaults.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/defaults.c b/lib/defaults.c
index 0e48a78..ae76513 100644
--- a/lib/defaults.c
+++ b/lib/defaults.c
@@ -879,7 +879,7 @@ static int read_config(unsigned int to_syslog, FILE *f, const char *name)
 	char *res;
 
 	new_sec = NULL;
-	while ((res = fgets(buf, MAX_LINE_LEN, f))) {
+	while ((res = fgets(buf, MAX_LINE_LEN + 1, f))) {
 		char *sec, *key, *value;
 
 		if (strlen(res) > MAX_LINE_LEN) {
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
