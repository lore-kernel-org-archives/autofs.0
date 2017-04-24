From: Ian Kent <raven@themaw.net>
Subject: [PATCH 22/34] autofs-5.1.2 - delay submount exit for amd submounts
Date: Mon, 24 Apr 2017 09:02:06 +0800
Message-ID: <149299572623.23475.7975712326142525885.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=SFZ/t65dK+B7Kzf5A8
        XDJSCuDkzfnVmqio3bpCkYtIo=; b=g3tZ/WGPnNzavqVLGN5ejmRxUOnPT/UAvN
        /X7cqNA08lEfVlOFburJqNCccACWQ466rz5D7Pfe+aD3O5g+y82SaWjc//2jw6dL
        PRU3MZFD/249dfThn2zdtJ9h1EOmkB0ANo7DiN9oHOk31fyGd95AahEoOQVw1sgj
        7PlfiVISGEGPUSBil1XroYu/tFul1ukU9+PawFXTzI5NfTH674uIw8SnuuiB/riO
        e9CCS9RXVgSe3HZX++vyEJq+tEbm3h7+KERfJjc4Drsi9IKkl90A6yIqk1gkpmtk
        Wkcq0YAHvqhP98iiCfuY9Dgx/31nckQYGfIF7e3pWMIyqijXwBaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=SFZ/t65dK+B7Kzf5A8XDJSCuDkzfnVmqio3bpCkYtIo=; b=PrpABrWc
        Bau9AeXbgWeEHBWqFa2k3+LqXhhLhENS6WJ5bREYSIFhdoZQx6pNVZnyA2Eh8rI7
        BwLxffMCIpqjsJUMeuaZdmkFT1c7S0ktwCmCS55eEeVVv1l56NpvCoNu/Q/xm825
        BZiKvsmWQu5hxWpgpCFwPewluoDCHGf+T/DSM/mDLkE3z90KhFECFNCGDoGkzIhI
        OJulVlutUn+hcmqNVNbKElumTQYaUtPY5y1ZF8OCvXQbFI64qq7Fg3Csl5nMbWh1
        iyt/02EI/jHRWGI7tiUPuFecINvGqdiyDoZPT4MWBa1SI83k9kXoL5LLsUSi/TmG
        YhQAP3Zwu5zXiQ==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

For amd format maps it's better to not expire away submounts (amd
type "auto" mounts) straight way.

This is because of the common heavy reuse of maps in amd maps and
we want to try and avoid constantly re-reading large maps.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG      |    1 +
 daemon/state.c |   18 +++++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index eaff2de..a456146 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -48,6 +48,7 @@ xx/xx/2016 autofs-5.1.3
 - handle map_option cache for top level mounts.
 - handle amd cache option all in amd type auto mounts.
 - fix bogus check in expire_cleanup().
+- delay submount exit for amd submounts.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/daemon/state.c b/daemon/state.c
index 41a5f6a..be5a834 100644
--- a/daemon/state.c
+++ b/daemon/state.c
@@ -132,15 +132,27 @@ void expire_cleanup(void *arg)
 			 * mount expires in a reasonable time. Just skip
 			 * one expire check after it's no longer busy before
 			 * allowing it to shutdown.
+			 *
+			 * But if this mount point is an amd format map it
+			 * is better to keep the mount around longer. This
+			 * is because of the common heavy reuse of maps in
+			 * amd maps and we want to try and avoid constantly
+			 * re-reading large maps.
 			 */
 			if (ap->submount && !success) {
 				rv = ops->askumount(ap->logopt, ap->ioctlfd, &idle);
 				if (!rv && idle && ap->submount > 1) {
-					next = ST_SHUTDOWN_PENDING;
-					break;
+					struct map_source *map = ap->entry->maps;
+
+					if (ap->submount > 4 ||
+					   !(map->flags & MAP_FLAG_FORMAT_AMD)) {
+						next = ST_SHUTDOWN_PENDING;
+						break;
+					}
 				}
 				ap->submount++;
-			}
+			} else if (ap->submount > 1)
+				ap->submount = 1;
 
 			if (ap->state == ST_EXPIRE && !ap->submount)
 				alarm_add(ap, ap->exp_runfreq);

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
