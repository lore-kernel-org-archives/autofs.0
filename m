From: Ian Kent <raven@themaw.net>
Subject: [PATCH 02/34] autofs-5.1.2 - dont exit on master map read fail
 timeout
Date: Mon, 24 Apr 2017 09:00:23 +0800
Message-ID: <149299562325.23475.9117284515367448892.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=s9trqZcDMcFUrays1z
        R1lise9T0V827wrWNUBmZ7OGE=; b=gUI81oxmwUT5fOfW4S/f2yUQeNdjgGomcG
        kpd+XompthVZhvtDnYGQVGbn3hH5CPis7fosBo6Dw07dh5VaODdtMOLuUK3zjBzF
        TlBx5JStrAcslu0FxXWR9IM+qvgVv8xKEX8dk4Iqwexp7CrIRLg0wFp4lLGEJrCZ
        sA2KLGI4YcbgJltofUfZy2LOWPzA0PDKW6qhxFgZTp+xhcF4afIQ1sTjvP1MRJi2
        R4SWDS+4CymbgaZ3j2QBIaZrYYEBpdzXR/eKE6SCHdwKLFTq55mRtkeQAwc+4SUe
        nfNGMnevFu2pJfT5grSXX1yDBgpfALYOl3yoswxLxI0/WZr/KpBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=s9trqZcDMcFUrays1zR1lise9T0V827wrWNUBmZ7OGE=; b=lpK/Xm7B
        zuTmKLm6mHV1WPZG67eCfHgbK7dVR9otl7fcgW5udrtbdDAABBl1HR1eQ+IcwENS
        n8Rg2DtTRqYBwl+yrQG88nCLXWVXT2mEIp/mWWdEO0O3fYUqjmoX/PiAFzECxEV9
        eR+ALSA0F6Wk57HoVXw0VFGPVi0vztgI8G10OJ/uBjKXdMwMUOqJUFprOW6yQZsy
        CZsuMnF8t6E2oQBZKyunwwCNhscCPeJoWHoTklWcCkHHcovwwvZpWlpN1U/PE0gC
        WXxGlFUhr5I/iRv8p5KzECtb3LMhBukrM3w9IULhGd8si2m4tW4FZc3e6aNnfcR3
        No6ze0kiW4ZypA==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

If there is a persistent master map read failure autofs should
continue on after the configured retry wait, as it would have
done previously.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG          |    1 +
 daemon/automount.c |   12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 5822aeb..85b1480 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -28,6 +28,7 @@ xx/xx/2016 autofs-5.1.3
 - add sss master map wait config option.
 - fix quoted key handling in sanitize_path().
 - fix included master map not found return.
+- dont exit on master map read fail timeout.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/daemon/automount.c b/daemon/automount.c
index 72c980e..95b8969 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -2533,10 +2533,14 @@ int main(int argc, char *argv[])
 		 * error.
 		 */
 		if (!do_master_read_master(master_list, master_wait)) {
-			logerr("%s: failed to read master map!", program);
-			master_kill(master_list);
-			release_flag_file();
-			exit(3);
+			logmsg("%s: warning: could not read at least one "
+				"map source after waiting, continuing ...",
+				 program);
+			/*
+			 * Failed to read master map, continue with what
+			 * we have anyway.
+			 */
+			master_read_master(master_list, age, 1);
 		}
 	}
 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
