From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] alarm.c: don't pass a null pointer to
	pthread_attr_destroy
Date: Fri, 04 Sep 2009 12:30:00 -0400
Message-ID: <x49skf2vfjr.fsf@segfault.boston.devel.redhat.com>
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

Here's another variant of the null pointer passed to attr_destroy.

Cheers,
Jeff

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/lib/alarm.c b/lib/alarm.c
index 46df38a..f403d8f 100755
--- a/lib/alarm.c
+++ b/lib/alarm.c
@@ -239,7 +239,8 @@ int alarm_start_handler(void)
 
 	status = pthread_create(&thid, pattrs, alarm_handler, NULL);
 
-	pthread_attr_destroy(pattrs);
+	if (pattrs)
+		pthread_attr_destroy(pattrs);
 
 	return !status;
 }
