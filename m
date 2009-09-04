From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] daemon/direct.c: check the return code from stat(2)
Date: Fri, 04 Sep 2009 14:29:06 -0400
Message-ID: <x49y6outvgt.fsf@segfault.boston.devel.redhat.com>
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

Another trivial patch.

Cheers,
Jeff

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/daemon/direct.c b/daemon/direct.c
index 0c78627..9b4e57b 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -1245,7 +1245,7 @@ static void *do_mount_direct(void *arg)
 	}
 
 	status = stat(mt.name, &st);
-	if (!S_ISDIR(st.st_mode) || st.st_dev != mt.dev) {
+	if (status != 0 || !S_ISDIR(st.st_mode) || st.st_dev != mt.dev) {
 		error(ap->logopt,
 		     "direct trigger not valid or already mounted %s",
 		     mt.name);
