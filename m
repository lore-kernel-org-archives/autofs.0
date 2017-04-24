From: Ian Kent <raven@themaw.net>
Subject: [PATCH 21/34] autofs-5.1.2 - fix bogus check in expire_cleanup()
Date: Mon, 24 Apr 2017 09:02:01 +0800
Message-ID: <149299572111.23475.3369745399606156074.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=d6uhuR9sO2QcdQSeAZ
        4a6Z/XRsOtNaYvW8co46BUXio=; b=GzMlHiUgfPGHAEevhY024oCFZvRUMsYoE0
        JxdzHw8UbYnl6vN7Pfl19feEaNOgY05rYOq9wtyOp9kR13YkQZ6XvGQdiEufq9Mh
        ZdFRthzNwWxR3QbfaELX/ayeDIjFawPCyS514DU9z+uHCDI3VhIoK5MeES5ZQYuv
        Jarep98DsFxg6lvU4Y680DLcs1IJH/Fib/FOEpjtFO4+SCMdDFkyQ6wBVZ8Tbart
        l/f9nbyaB0++AR9MV53YeAkIIRLPRE07qNf1/cXGPami24DElqSm1sIZgP/KDP5j
        ah5wL/+3M5smNY/CzT5o3woC5oGDzJ+ZnIGyubc8k7rclCicRwFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=d6uhuR9sO2QcdQSeAZ4a6Z/XRsOtNaYvW8co46BUXio=; b=lFlkX4Xz
        pbc6L5lzO2n5vJO6t5JVUEmj8dLzp/DXoeB4zA/Ukg7f5SEbh7KWkLtSbiTtySRw
        Gx86XAoXYnjDHqIhwDJcugpAXOSeUPiPhRKUMwKdDx6odNiIiGV0N7g/vJAqbIHX
        V3kCqXhSaPwiY/dgYWSObWPeMZ0On5ZkANRpTgqocebw2PDoWbICREohXuQpicch
        gXsNLwbauQQGMQGkbH8sUDX/XEDS7sglEdZmyFS4VaKlYltpGnScRfmpYtE/l6xf
        VFXqxt+hHZYQlug+SlvYTSw0R16Rpmd5/M6NC5y1NrQ3hE2MBAZ1cX1cKg3olOY+
        GOSbwsYpihDpFA==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

ap->submount can never be 0 here.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG      |    1 +
 daemon/state.c |    4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 9248bb9..eaff2de 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -47,6 +47,7 @@ xx/xx/2016 autofs-5.1.3
 - capture cache option and its settings during parsing.
 - handle map_option cache for top level mounts.
 - handle amd cache option all in amd type auto mounts.
+- fix bogus check in expire_cleanup().
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/daemon/state.c b/daemon/state.c
index 5d81438..41a5f6a 100644
--- a/daemon/state.c
+++ b/daemon/state.c
@@ -139,9 +139,7 @@ void expire_cleanup(void *arg)
 					next = ST_SHUTDOWN_PENDING;
 					break;
 				}
-
-				if (ap->submount++ == 0)
-					ap->submount = 2;
+				ap->submount++;
 			}
 
 			if (ap->state == ST_EXPIRE && !ap->submount)

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
