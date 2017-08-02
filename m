From: Ian Kent <raven@themaw.net>
Subject: [PATCH 06/19] autofs-5.1.3 - dont probe NFSv2 by default
Date: Wed, 02 Aug 2017 10:17:37 +0800
Message-ID: <150164025732.6106.13863019015876246646.stgit@pluto.themaw.net>
References: <150164013844.6106.10264212633586462386.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150164013844.6106.10264212633586462386.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

NFS v2 hasn't been recommended for use for a long time now so don't
include it in the avialability probe unless it is specified as an
NFS mount option.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG            |    1 +
 include/replicated.h |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index 1aa1dbb5..a56b2894 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -4,6 +4,7 @@ xx/xx/2017 autofs-5.1.4
 - Add -c option when calling /bin/umount - if supported.
 - remove some redundant rpc library code.
 - add port parameter to rpc_ping().
+- dont probe NFSv2 by default.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/include/replicated.h b/include/replicated.h
index 728f1311..5e142f4f 100644
--- a/include/replicated.h
+++ b/include/replicated.h
@@ -26,7 +26,7 @@
 #define NFS2_SUPPORTED		0x0010
 #define NFS3_SUPPORTED		0x0020
 #define NFS4_SUPPORTED		0x0040
-#define NFS_VERS_MASK		(NFS2_SUPPORTED|NFS3_SUPPORTED)
+#define NFS_VERS_MASK		(NFS3_SUPPORTED)
 #define NFS4_VERS_MASK		(NFS4_SUPPORTED)
 
 #define NFS2_REQUESTED		NFS2_SUPPORTED

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
