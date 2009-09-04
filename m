From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] don't pass a null pointer to pthread_attr_destroy
Date: Fri, 04 Sep 2009 12:25:22 -0400
Message-ID: <x49ws4evfrh.fsf@segfault.boston.devel.redhat.com>
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
To: ikent@redhat.com
Cc: autofs@linux.kernel.org

Hi, Ian,

pthread_attr_destroy will dereference the pointer that is passed in.
Since we can get here with a NULL pattrs, we better check for that.

Cheers,
Jeff

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/daemon/state.c b/daemon/state.c
index 71af46a..2eeb4bf 100644
--- a/daemon/state.c
+++ b/daemon/state.c
@@ -1198,7 +1198,8 @@ int st_start_handler(void)
 
 	status = pthread_create(&thid, pattrs, st_queue_handler, NULL);
 
-	pthread_attr_destroy(pattrs);
+	if (pattrs)
+		pthread_attr_destroy(pattrs);
 
 	return !status;
 }
