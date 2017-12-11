From: Ian Kent <raven@themaw.net>
Subject: [PATCH 03/27] autofs-5.1.3 - fix ordering of seteuid/setegid in
 do_spawn()
Date: Mon, 11 Dec 2017 16:57:36 +0800
Message-ID: <151298265688.19722.10749622212199681047.stgit@pluto.themaw.net>
References: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

From: Jeff Mahoney <jeffm@suse.com>

In do_spawn, We call seteuid() prior to calling setegid() which means
that, when we're using an unprivileged uid, we won't have permissions
to set the effective group anymore.

We also don't touch the group memberships so the permissions used to
open the directory will will include all of root's supplementary groups
and none of the user's.

This patch reverses the ordering and uses initgroups() to reset the
supplementary groups to the unprivileged user's groups.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG      |    1 +
 daemon/spawn.c |   13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 48f0b67c..34b596a6 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -37,6 +37,7 @@ xx/xx/2017 autofs-5.1.4
 - the port option should not behave like nobind option.
 - handle additional nfs versions in mount_nfs.c.
 - fix symlink option passthrough in mount_nfs.c.
+- fix ordering of seteuid/setegid in do_spawn().
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/daemon/spawn.c b/daemon/spawn.c
index 7c56ba7b..6557c066 100644
--- a/daemon/spawn.c
+++ b/daemon/spawn.c
@@ -20,6 +20,7 @@
 #include <string.h>
 #include <sys/types.h>
 #include <dirent.h>
+#include <grp.h>
 #include <time.h>
 #include <poll.h>
 #include <sys/wait.h>
@@ -195,14 +196,22 @@ static int do_spawn(unsigned logopt, unsigned int wait,
 			 * program group to trigger mount
 			 */
 			if (euid) {
-				if (seteuid(euid) == -1)
+				if (!tsv->user)
 					fprintf(stderr,
-						"warning: seteuid: %s\n",
+						"warning: can't init groups\n");
+				else if (initgroups(tsv->user, egid) == -1)
+					fprintf(stderr,
+						"warning: initgroups: %s\n",
 						strerror(errno));
+
 				if (setegid(egid) == -1)
 					fprintf(stderr,
 						"warning: setegid: %s\n",
 						strerror(errno));
+				if (seteuid(euid) == -1)
+					fprintf(stderr,
+						"warning: seteuid: %s\n",
+						strerror(errno));
 			}
 			setpgrp();
 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
