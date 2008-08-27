From: David Howells <dhowells@redhat.com>
Subject: [PATCH 17/59] CRED: Wrap task credential accesses in the
	autofs4	filesystem
Date: Wed, 27 Aug 2008 14:47:09 +0100
Message-ID: <20080827134709.19980.94497.stgit@warthog.procyon.org.uk>
References: <20080827134541.19980.61042.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080827134541.19980.61042.stgit@warthog.procyon.org.uk>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: linux-kernel@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, Serge Hallyn <serue@us.ibm.com>, linux-security-module@vger.kernel.org, autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

Wrap access to task credentials so that they can be separated more easily from
the task_struct during the introduction of COW creds.

Change most current->(|e|s|fs)[ug]id to current_(|e|s|fs)[ug]id().

Change some task->e?[ug]id to task_e?[ug]id().  In some places it makes more
sense to use RCU directly rather than a convenient wrapper; these will be
addressed by later patches.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: James Morris <jmorris@namei.org>
Acked-by: Serge Hallyn <serue@us.ibm.com>
Cc: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org
---

 fs/autofs4/inode.c |    4 ++--
 fs/autofs4/waitq.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)


diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index 7bb3e5b..8c9cf24 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -233,8 +233,8 @@ static int parse_options(char *options, int *pipefd, uid_t *uid, gid_t *gid,
 	substring_t args[MAX_OPT_ARGS];
 	int option;
 
-	*uid = current->uid;
-	*gid = current->gid;
+	*uid = current_uid();
+	*gid = current_gid();
 	*pgrp = task_pgrp_nr(current);
 
 	*minproto = AUTOFS_MIN_PROTO_VERSION;
diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index 35216d1..dc1fa39 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -391,8 +391,8 @@ int autofs4_wait(struct autofs_sb_info *sbi, struct dentry *dentry,
 		memcpy(&wq->name, &qstr, sizeof(struct qstr));
 		wq->dev = autofs4_get_dev(sbi);
 		wq->ino = autofs4_get_ino(sbi);
-		wq->uid = current->uid;
-		wq->gid = current->gid;
+		wq->uid = current_uid();
+		wq->gid = current_gid();
 		wq->pid = current->pid;
 		wq->tgid = current->tgid;
 		wq->status = -EINTR; /* Status return if interrupted */
