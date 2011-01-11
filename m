From: David Howells <dhowells@redhat.com>
Subject: [PATCH 15/18] autofs4: Fix wait validation
Date: Tue, 11 Jan 2011 17:49:29 +0000
Message-ID: <20110111174929.2291.56345.stgit@warthog.procyon.org.uk>
References: <20110111174809.2291.52242.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20110111174809.2291.52242.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: npiggin@kernel.dk, viro@zeniv.linux.org.uk, raven@themaw.net
Cc: dhowells@redhat.com, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

From: Ian Kent <raven@themaw.net>

It is possible for the check in wait.c:validate_request() to return
an incorrect result if the dentry that was mounted upon has changed
during the callback.

Signed-off-by: Ian Kent <raven@themaw.net>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/autofs4/waitq.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index c5f8459..5601005 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -309,6 +309,9 @@ static int validate_request(struct autofs_wait_queue **wait,
 	 * completed while we waited on the mutex ...
 	 */
 	if (notify == NFY_MOUNT) {
+		struct dentry *new = NULL;
+		int valid = 1;
+
 		/*
 		 * If the dentry was successfully mounted while we slept
 		 * on the wait queue mutex we can return success. If it
@@ -316,8 +319,20 @@ static int validate_request(struct autofs_wait_queue **wait,
 		 * a multi-mount with no mount at it's base) we can
 		 * continue on and create a new request.
 		 */
+		if (!IS_ROOT(dentry)) {
+			if (dentry->d_inode && d_unhashed(dentry)) {
+				struct dentry *parent = dentry->d_parent;
+				new = d_lookup(parent, &dentry->d_name);
+				if (new)
+					dentry = new;
+			}
+		}
 		if (have_submounts(dentry))
-			return 0;
+			valid = 0;
+
+		if (new)
+			dput(new);
+		return valid;
 	}
 
 	return 1;

