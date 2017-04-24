From: Ian Kent <raven@themaw.net>
Subject: [PATCH 29/34] autofs-5.1.2 - fix possible NULL derefernce
Date: Mon, 24 Apr 2017 09:02:42 +0800
Message-ID: <149299576223.23475.77594111267721064.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=lei0Q8b8Vu9/Bn3DtQ
        jfMHQveT+TNOCsrFICu02vxIM=; b=KQZhBSWtbdR8mqRHlsO8kmzRpHj4SRe3Vq
        GNBT0QW7MTDPfuFi/bavatDAdi3AZ19lBeMcaZHLv+HoBZ9++cWXPDERvWOYOhWR
        YMmgwL7KI700Xy343dCYNBCPS9gx3kGUYuQs66oZFr4hm4B/hO7MGYEzEe1jHj3c
        lNUVnURUL7iw8mHLotSC2m4AV/aoH8CG6z8+2MM4NH6YGBj1iSLIOlatPBm3T6oY
        64aFDfVe/E6O2mXrUOX6VysYE0EHsi5RFnkO0qEdDB8fKvS1ukX7AWXvkIUZ/hXD
        +IZRUKiA29ONpJ8XJFey/6K+TuVLpyj2ijIOZ9ndptEGaIfwDqvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=lei0Q8b8Vu9/Bn3DtQjfMHQveT+TNOCsrFICu02vxIM=; b=Lf/y7JIZ
        KsAdJ2BlD9eOZyYAX9IumU7Aqulb3cE2or0ITRuhUJx14NtusTJeT919gw7QohxA
        X8JM/qWyeLTSKr9b/M0BfmL1x4QR0XfZehy2CBIbNGwgpHxyU2398TSElYFSkirF
        0207JBJD3rNWQiz8GyV+Iv8aiHmDNwMKBhUcUfWE7htMR0hLFXe3UJyNnZ3uhrkH
        Rr4aTmMIpfsAXsKSH1VX/TabBfNAGnnQ86L5SZ7lrakZYU3r9Xe9DbJmkPAA2eOy
        vyNz2ZxM/5EEyK9W+cGl3wG8tiOsZkH8O9BJBE37XQqCNXzl8SkddFLrvZm55sKo
        ucglYqaztnB8ig==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

In modules/mount_autofs.c:mount_mount() a NULL pointer dereference is
(unlikley but) possible.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG              |    1 +
 modules/mount_autofs.c |   15 +++++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 1a4a8d9..2dceb69 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -55,6 +55,7 @@ xx/xx/2016 autofs-5.1.3
 - factor out set_thread_mount_request_log_id().
 - add config option to use mount request log id.
 - use autofs_point to store expire timeout where possibe.
+- fix possible NULL derefernce.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/modules/mount_autofs.c b/modules/mount_autofs.c
index be9d51d..076ab85 100644
--- a/modules/mount_autofs.c
+++ b/modules/mount_autofs.c
@@ -281,13 +281,16 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name,
 
 	if (source->flags & MAP_FLAG_FORMAT_AMD) {
 		struct amd_entry *am_entry = __master_find_amdmount(ap, entry->path);
-		if (am_entry && am_entry->pref) {
-			nap->pref = am_entry->pref;
-			am_entry->pref = NULL;
-		}
 
-		if (am_entry->cache_opts & AMD_CACHE_OPTION_ALL)
-			nap->flags |= MOUNT_FLAG_AMD_CACHE_ALL;
+		if (am_entry) {
+			if (am_entry->pref) {
+				nap->pref = am_entry->pref;
+				am_entry->pref = NULL;
+			}
+
+			if (am_entry->cache_opts & AMD_CACHE_OPTION_ALL)
+				nap->flags |= MOUNT_FLAG_AMD_CACHE_ALL;
+		}
 	}
 
 	if (handle_mounts_startup_cond_init(&suc)) {

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
