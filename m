From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] expire_cleanup: check the return code form
	ops->askumount
Date: Fri, 04 Sep 2009 14:53:01 -0400
Message-ID: <x49ljkutucy.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: raven@themaw.net
Cc: autofs@linux.kernel.org

Hi, Ian,

This looks like a minor oversight.

Cheers,
Jeff

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/daemon/state.c b/daemon/state.c
index 2eeb4bf..27bc6de 100644
--- a/daemon/state.c
+++ b/daemon/state.c
@@ -160,7 +160,7 @@ void expire_cleanup(void *arg)
 			 * been signaled to shutdown.
 			 */
 			rv = ops->askumount(ap->logopt, ap->ioctlfd, &idle);
-			if (!idle && !ap->shutdown) {
+			if (!rv && !idle && !ap->shutdown) {
 				next = ST_READY;
 				if (!ap->submount)
 					alarm_add(ap, ap->exp_runfreq);
