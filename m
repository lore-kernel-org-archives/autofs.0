From: Jeff Mahoney <jeffm@suse.com>
Subject: [PATCH v2] autofs-5.1.3 - fix ordering of seteuid/setegid in do_spawn
Date: Wed, 18 Oct 2017 17:12:14 -0400
Message-ID: <12498ca2-9aae-54ab-832a-0760ba221261@suse.com>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
 <150813043348.25695.10697953082315362911.stgit@pluto.themaw.net>
 <cf4f19a9-cbf4-2077-a26a-922268c80507@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <cf4f19a9-cbf4-2077-a26a-922268c80507@suse.com>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>, autofs mailing list <autofs@vger.kernel.org>

In do_spawn, We call seteuid() prior to calling setegid() which means
that, when we're using an unprivileged uid, we won't have permissions
to set the effective group anymore.

We also don't touch the group memberships so the permissions used to
open the directory will will include all of root's supplementary groups
and none of the user's.

This patch reverses the ordering and uses initgroups() to reset the
supplementary groups to the unprivileged user's groups.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 daemon/spawn.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/daemon/spawn.c b/daemon/spawn.c
index c640d97..62e9f02 100644
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
@@ -195,8 +196,18 @@ static int do_spawn(unsigned logopt, unsigned int wait,
 			 * program group to trigger mount
 			 */
 			if (euid) {
-				seteuid(euid);
-				setegid(egid);
+				if (initgroups(tsv->user, egid) == -1)
+					fprintf(stderr,
+						"warning: initgroups: %s\n",
+						strerror(errno));
+				if (setegid(egid) == -1)
+					fprintf(stderr,
+						"warning: setegid: %s\n",
+						strerror(errno));
+				if (seteuid(euid) == -1)
+					fprintf(stderr,
+						"warning: seteuid: %s\n",
+						strerror(errno));
 			}
 			setpgrp();
 


--
To unsubscribe from this list: send the line "unsubscribe autofs" in
