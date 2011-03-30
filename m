From: Ian Kent <raven@themaw.net>
Subject: [PATCH 1/2] autofs-5.0.5 - fix next task list update
Date: Wed, 30 Mar 2011 13:49:30 +0800
Message-ID: <20110330054930.22333.44353.stgit@localhost6.localdomain6>
References: <20110330054620.22333.45008.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20110330054620.22333.45008.stgit@localhost6.localdomain6>
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
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs@linux.kernel.org, "Philip Ong Jr." <pongjr@gmail.com>

When the state queue task manager transfered an automount point pending
task to its task queue for execution the state queue as mistakenly being
seen as empty when the completing task was the only task in the state
queue.
---

 CHANGELOG      |    1 +
 daemon/state.c |    8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 347d7d7..a9687b7 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -62,6 +62,7 @@
 - fix mountd vers retry.
 - fix expire race.
 - replace GPLv3 code.
+- fix next task list update.
 
 03/09/2009 autofs-5.0.5
 -----------------------
diff --git a/daemon/state.c b/daemon/state.c
index 38617c3..85587bd 100644
--- a/daemon/state.c
+++ b/daemon/state.c
@@ -1150,11 +1150,13 @@ remove:
 				next = list_entry((&task->pending)->next,
 							struct state_queue, pending);
 
-				list_del_init(&next->pending);
-				list_add_tail(&next->list, p);
-
 				list_del(&task->list);
 				free(task);
+
+				list_del_init(&next->pending);
+				list_add_tail(&next->list, head);
+				if (p == head)
+					p = head->next;
 			}
 
 			if (list_empty(head))
