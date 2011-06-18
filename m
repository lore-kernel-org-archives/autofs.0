From: David Howells <dhowells@redhat.com>
Subject: [PATCH] AUTOFS4: Fix the return from autofs4_d_automount()
 and simplify autofs4_d_manage()
Date: Sat, 18 Jun 2011 01:11:05 +0100
Message-ID: <20110618001104.29347.67602.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: viro@ZenIV.linux.org.uk, raven@themaw.net
Cc: autofs@linux.kernel.org, David Howells <dhowells@redhat.com>

autofs4_d_automount() returns 0 if it detects that the calling process is in Oz
mode (ie. it's the autofs userspace daemon).  This return, however, is meant to
indicate to follow_automount() that the caller should retry the check on the
the current path point.  In the Oz mode case, this is a bad idea because
nothing has changed on the path, and follow_managed() will just repeat until
follow_automount() hits the total_link_count limit and returns -ELOOP.

What it should do is return -EISDIR to indicate to the callers that actually it
wants the daemon to see this directory as an ordinary directory.


Now, given that change outlined above, it is then unnecessary for
autofs4_d_manage() to return -EISDIR if the current path point is not a
mountpoint.  If it returns 0 instead, and the path point isn't a mountpoint,
then follow_managed() will skip the attempt to transit to the mounted
filesystem and proceed to call autofs4_d_automount(), which will return
-EISDIR.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/autofs4/root.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index f55ae23..a6dc11c 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -334,7 +334,7 @@ static struct vfsmount *autofs4_d_automount(struct path *path)
 
 	/* The daemon never triggers a mount. */
 	if (autofs4_oz_mode(sbi))
-		return NULL;
+		return ERR_PTR(-EISDIR);
 
 	/*
 	 * If an expire request is pending everyone must wait.
@@ -435,13 +435,8 @@ int autofs4_d_manage(struct dentry *dentry, bool rcu_walk)
 		dentry, dentry->d_name.len, dentry->d_name.name);
 
 	/* The daemon never waits. */
-	if (autofs4_oz_mode(sbi)) {
-		if (rcu_walk)
-			return 0;
-		if (!d_mountpoint(dentry))
-			return -EISDIR;
+	if (autofs4_oz_mode(sbi))
 		return 0;
-	}
 
 	/* We need to sleep, so we need pathwalk to be in ref-mode */
 	if (rcu_walk)
