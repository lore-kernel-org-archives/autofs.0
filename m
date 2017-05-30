From: Donald Buczek <buczek@molgen.mpg.de>
Subject: [PATCH] Fix usage of uninitialized pointer
Date: Tue, 30 May 2017 15:35:37 +0200
Message-ID: <1496151337-21367-1-git-send-email-buczek@molgen.mpg.de>
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Donald Buczek <buczek@molgen.mpg.de>

In the error path after a getgrgid_r failure (e.g. when a unnamed gid
was used), the pointer tsv->group was left unitialized. Still the tsv
was given to pthread_setspecific(key_thread_stdenv_vars,...) and the
consumers used and freed the uninitialized pointer.

    2017-05-29T18:16:11+02:00 rofl automount[14749]: attempting to mount entry /package/twiki
    2017-05-29T18:16:11+02:00 rofl automount[14749]: set_tsd_user_vars: failed to get group info from getgrgid_r
    2017-05-29T18:16:11+02:00 rofl automount[14749]: mounted /package/twiki
    2017-05-29T18:16:11+02:00 rofl systemd[1]: automount.service: main process exited, code=dumped, status=6
    2017-05-29T18:16:12+02:00 rofl systemd[1]: automount.service holdoff time over, scheduling restart.
    2017-05-29T18:16:12+02:00 rofl systemd[1]: Unit automount.service entered failed state.
    2017-05-29T18:16:12+02:00 rofl automount[17936]: Starting automounter version 5.1.3, master map auto.master

    [May29 18:16] traps: automount[18234] general protection ip:7f8b025c324a sp:7f8b0049a508 error:0 in libc-2.19.so[7f8b02541000+1a2000]

Handle the error by not calling pthread_setspecific. Clean up
and return instead.
---
 lib/mounts.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/lib/mounts.c b/lib/mounts.c
index ce6a60a..fe1a6cd 100644
--- a/lib/mounts.c
+++ b/lib/mounts.c
@@ -1552,28 +1552,31 @@ void set_tsd_user_vars(unsigned int logopt, uid_t uid, gid_t gid)
 	}
 
 no_group:
-	if (status || !pgr)
+	if (status || !pgr) {
 		error(logopt, "failed to get group info from getgrgid_r");
-	else {
+		goto free_gr_tmp;
+	} else {
 		tsv->group = strdup(gr.gr_name);
-		if (!tsv->group)
+		if (!tsv->group) {
 			error(logopt, "failed to malloc buffer for group");
+			goto free_gr_tmp;
+		}
 	}
 
-	if (gr_tmp)
-		free(gr_tmp);
-
 	status = pthread_setspecific(key_thread_stdenv_vars, tsv);
 	if (status) {
 		error(logopt, "failed to set stdenv thread var");
 		goto free_tsv_group;
 	}
-
+	if (gr_tmp)
+		free(gr_tmp);
 	return;
 
 free_tsv_group:
-	if (tsv->group)
-		free(tsv->group);
+	free(tsv->group);
+free_gr_tmp:
+	if (gr_tmp)
+		free(gr_tmp);
 free_tsv_home:
 	free(tsv->home);
 free_tsv_user:
-- 
2.4.1

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
