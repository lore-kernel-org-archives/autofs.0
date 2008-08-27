From: David Howells <dhowells@redhat.com>
Subject: [PATCH 16/59] CRED: Wrap task credential accesses in the
	autofs	filesystem
Date: Wed, 27 Aug 2008 14:47:04 +0100
Message-ID: <20080827134704.19980.37401.stgit@warthog.procyon.org.uk>
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
Cc: David Howells <dhowells@redhat.com>, Serge Hallyn <serue@us.ibm.com>, linux-security-module@vger.kernel.org, autofs@linux.kernel.org, "H. Peter Anvin" <hpa@zytor.com>

Wrap access to task credentials so that they can be separated more easily from
the task_struct during the introduction of COW creds.

Change most current->(|e|s|fs)[ug]id to current_(|e|s|fs)[ug]id().

Change some task->e?[ug]id to task_e?[ug]id().  In some places it makes more
sense to use RCU directly rather than a convenient wrapper; these will be
addressed by later patches.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: James Morris <jmorris@namei.org>
Acked-by: Serge Hallyn <serue@us.ibm.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: autofs@linux.kernel.org
---

 fs/autofs/inode.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index dda510d..61429c5 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -76,8 +76,8 @@ static int parse_options(char *options, int *pipefd, uid_t *uid, gid_t *gid,
 	substring_t args[MAX_OPT_ARGS];
 	int option;
 
-	*uid = current->uid;
-	*gid = current->gid;
+	*uid = current_uid();
+	*gid = current_gid();
 	*pgrp = task_pgrp_nr(current);
 
 	*minproto = *maxproto = AUTOFS_PROTO_VERSION;
