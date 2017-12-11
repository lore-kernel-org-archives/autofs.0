From: Ian Kent <raven@themaw.net>
Subject: [PATCH 06/27] autofs-5.1.3 - fix open calls not using open_xxxx()
 calls
Date: Mon, 11 Dec 2017 16:58:09 +0800
Message-ID: <151298268963.19722.17893045260562334961.stgit@pluto.themaw.net>
References: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Fix a couple of remaining open descriptor calls to use the autofs
open_xxxx() calls.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG          |    1 +
 daemon/automount.c |    2 +-
 lib/mounts.c       |    2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index bd9feb2a..09d2f39e 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -39,6 +39,7 @@ xx/xx/2017 autofs-5.1.4
 - fix symlink option passthrough in mount_nfs.c.
 - fix ordering of seteuid/setegid in do_spawn().
 - update configure to check for pipe2(2).
+- fix open calls not using open_xxxx() calls.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/daemon/automount.c b/daemon/automount.c
index 9fee67bb..6720bc23 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -1000,7 +1000,7 @@ static int set_log_priority(const char *path, int priority)
 	 * Specify O_NONBLOCK so that the open will fail if there is no
 	 * daemon reading from the other side of the FIFO.
 	 */
-	fd = open(fifo_name, O_WRONLY|O_NONBLOCK);
+	fd = open_fd(fifo_name, O_WRONLY|O_NONBLOCK);
 	if (fd < 0) {
 		fprintf(stderr, "%s: open of %s failed with %s\n",
 			__FUNCTION__, fifo_name, strerror(errno));
diff --git a/lib/mounts.c b/lib/mounts.c
index 0b38bd86..7fd88471 100644
--- a/lib/mounts.c
+++ b/lib/mounts.c
@@ -222,7 +222,7 @@ int check_nfs_mount_version(struct nfs_mount_vers *vers,
 	char *s_ver;
 	int cancel_state;
 
-	if (pipe(pipefd))
+	if (open_pipe(pipefd))
 		return -1;
 
 	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &cancel_state);

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
