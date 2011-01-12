From: Bill Ryder <bill.ryder.nz@gmail.com>
Subject: [bryder_autofs_4.1.4_PATCH 8/8] Fix race which would stop
	a daemon under high mount rates with failures
Date: Thu, 13 Jan 2011 11:25:06 +1300
Message-ID: <934b79623a5580fbab1a257127e5d6152fb58f3f.1294888163.git.bill.ryder.nz@gmail.com>
References: <cover.1294888163.git.bill.ryder.nz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <cover.1294888163.git.bill.ryder.nz@gmail.com>
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
To: 

---
 CHANGELOG          |   13 +++++++++++++
 daemon/automount.c |    4 ++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index b4959ec..e13e0ac 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -1,3 +1,16 @@
+19/07/2010 autofs-4.1.4 - bryder p44
+---------------------------
+  Fix a problem where automount can shut itself down for no good reason.
+  The case I had was  very high rate of failed mounts triggering the
+      if (handle_packet() && errno != EINTR) ; break  
+  piece of code in automount.c:handle_mounts which ended up just shutting down the automounter.
+  The debug statement confirmed it (ap.state was 1 (READY) instead of 6 (SHUTDOWN))
+  The bug is triggered if a child signal is caught when the daemon was not in the middle of a system call - hence errno 
+  was not set to EINTR and handle_packet returned non zero - as in when a mount point didn't exist. 
+  This was  reproducible when using the ignore-stupid-paths option which meant the daemon spent
+  more time in user space handling autofs kernel packets than before.
+
+  
 15/07/2010 autofs-4.1.4 - syslog patch
 --------------------------------------
 
diff --git a/daemon/automount.c b/daemon/automount.c
index 92476b4..0142884 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -1729,9 +1729,9 @@ int handle_mounts(char *path)
 		kill(my_pid, SIGSTOP);
 
 	while (ap.state != ST_SHUTDOWN) {
-		if (handle_packet() && errno != EINTR)
-			break;
+		handle_packet();
 	}
+	debug("Shutting down - ap.state is %d if it's not %d (ST_SHUTDOWN) something bad happened ",ap.state,ST_SHUTDOWN);
 
 	/* Mop up remaining kids */
 	handle_child(1);
-- 
1.7.3.3
