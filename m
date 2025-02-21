Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB031876
	for <autofs@vger.kernel.org>; Fri, 21 Feb 2025 01:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101970; cv=none; b=bYWKjGY2ce0COmwNQDz0M9H16SukLn/f4Hki7TCC/9Ya+mKe9VgDD3TjhVjXtZ3YwKWNNc6VcNXG8N5VjoP1M9UN43wAt1syxxizrBoY3X33qFj4WbAfH9JLfiKTmlWiYHiuCfLICQuZPKLll/07uubrs81uP0cFjDkv2kp/0RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101970; c=relaxed/simple;
	bh=1JK4j55jckYJ4tPwATAptxTneNd1c3tjPdgE4zxKZWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o9ZdpqySTIgFryrELHASE+dpe3Iz7Xc7rKpP3wzggGyFDejNsBTLKer8ZBJPvzrB4yhVJxrrE3V4sMgCdHnaQWWXeLNxIDN3W6qloLq8TIdc4ERxOmii5bgjSmBjkMsFgHqTXEWXIcA89AwlUDD7Diioex2mlE46KfmogfsZVNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=benbuhse.email; spf=pass smtp.mailfrom=benbuhse.email; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=benbuhse.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benbuhse.email
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YzXqJ3199z9sqC;
	Fri, 21 Feb 2025 02:39:24 +0100 (CET)
From: Ben Buhse <me@benbuhse.email>
To: autofs@vger.kernel.org
Cc: Ben Buhse <me@benbuhse.email>
Subject: [PATCH] fix building on musl
Date: Thu, 20 Feb 2025 19:39:10 -0600
Message-ID: <20250221013910.13794-1-me@benbuhse.email>
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4YzXqJ3199z9sqC

musl 1.2.5 removed basename from string.h and only kept it in libgen.h: https://git.musl-libc.org/cgit/musl/commit/?id=725e17ed6dff4d0cd22487bb64470881e86a92e7
---
 daemon/automount.c    | 20 +++++++++++++++-----
 daemon/master.c       |  1 +
 modules/lookup_file.c |  1 +
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/daemon/automount.c b/daemon/automount.c
index 474b29a..5256426 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -21,6 +21,7 @@
 
 #include <dirent.h>
 #include <getopt.h>
+#include <libgen.h>
 #include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -2538,12 +2539,21 @@ int main(int argc, char *argv[])
 
 		lookup_nss_read_master(master_list, 0);
 		if (type) {
-			const char *map = basename(name);
-			if (!map)
-				printf("%s: invalid map name %s\n",
+			const char *map = NULL;
+			char *name_dup = strdup(name);
+			if (!name_dup) {
+				printf("%s: failed to copy name %s for parsing\n",
 					program, name);
-			else
-				dump_map(master_list, type, map);
+			} else {
+				map = basename(name_dup);
+				if (!map)
+					printf("%s: invalid map name %s\n",
+						program, name);
+				else
+					dump_map(master_list, type, map);
+				free(name_dup);
+				name_dup = NULL;
+			}
 		} else
 			master_show_mounts(master_list);
 
diff --git a/daemon/master.c b/daemon/master.c
index f2c11e9..1455e40 100644
--- a/daemon/master.c
+++ b/daemon/master.c
@@ -21,6 +21,7 @@
 #include <string.h>
 #include <memory.h>
 #include <limits.h>
+#include <libgen.h>
 #include <signal.h>
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/modules/lookup_file.c b/modules/lookup_file.c
index 99f2e21..4914395 100644
--- a/modules/lookup_file.c
+++ b/modules/lookup_file.c
@@ -15,6 +15,7 @@
 
 #include <stdio.h>
 #include <malloc.h>
+#include <libgen.h>
 #include <stdlib.h>
 #include <string.h>
 #include <time.h>
-- 
2.45.3

