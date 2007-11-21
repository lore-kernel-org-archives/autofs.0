From: Matthias Koenig <mkoenig@suse.de>
Subject: [PATCH] fix buffer overflow
Date: Wed, 21 Nov 2007 12:17:30 +0100
Message-ID: <20071121111730.22911.53791.stgit@sor.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org

A overflow problem due to wrong size specification in read/write
calls is fixed.

Signed-off-by: Matthias Koenig <mkoenig@suse.de>
---

 daemon/automount.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/daemon/automount.c b/daemon/automount.c
index 7becad5..f31ec11 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -1125,7 +1125,7 @@ static void become_daemon(unsigned foreground)
 		if (pid > 0) {
 			int r;
 			close(start_pipefd[1]);
-			r = read(start_pipefd[0], pst_stat, sizeof(pst_stat));
+			r = read(start_pipefd[0], pst_stat, sizeof(*pst_stat));
 			if (r < 0)
 				exit(1);
 			exit(*pst_stat);
@@ -2061,12 +2061,12 @@ int main(int argc, char *argv[])
 	if (!master_read_master(master_list, age, 0)) {
 		master_kill(master_list);
 		*pst_stat = 3;
-		res = write(start_pipefd[1], pst_stat, sizeof(pst_stat));
+		res = write(start_pipefd[1], pst_stat, sizeof(*pst_stat));
 		close(start_pipefd[1]);
 		exit(3);
 	}
 
-	res = write(start_pipefd[1], pst_stat, sizeof(pst_stat));
+	res = write(start_pipefd[1], pst_stat, sizeof(*pst_stat));
 	close(start_pipefd[1]);
 
 	state_mach_thid = pthread_self();
