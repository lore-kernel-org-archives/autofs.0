From: Jeff Moyer <jmoyer@redhat.com>
Subject: [autofs4 patch] fall back to yp_master if yp_order fails
Date: Wed, 08 Nov 2006 22:13:32 -0500
Message-ID: <x49mz71nwgz.fsf@segfault.boston.devel.redhat.com>
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
To: Ian Kent <raven@themaw.net>, autofs mailing list <autofs@linux.kernel.org>

Hi, Ian, list,

Some nisplus servers, when running in nis compatibility mode, will not
support yp_order.  So, we check for the existence of the map with the
yp_master call, instead.

I don't have a nisplus server with which to test this patch, so it's
only compile tested (and verified by the one person who ran into this,
but that was on the RHEL code base).

-Jeff

diff --git a/lib/nsswitch.c b/lib/nsswitch.c
index 6ff097f..c884cc7 100644
--- a/lib/nsswitch.c
+++ b/lib/nsswitch.c
@@ -16,6 +16,7 @@ #include <ldap.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <rpcsvc/ypclnt.h>
+#include <rpc/types.h>
 #include "automount.h"
 
 #define MODPREFIX "nsswitch: "
@@ -208,16 +209,27 @@ int isypmap(const char *loc)
 {
 	int err;
 	char *domainname;
+	char *hostname;
 	unsigned int order;
 
 	if ((err = yp_get_default_domain(&domainname)) != YPERR_SUCCESS) {
 		error(MODPREFIX "unable to get default yp domain");
 		return 0;
 	}
+
 	if ((err = yp_order(domainname, loc, &order)) != YPERR_SUCCESS) {
-		debug(MODPREFIX "unable to find map, %s in domain, %s",
-		      loc, domainname);
-		return 0;
+		/*
+		 * Some nisplus servers, when running in nis compatibility
+		 * mode, will not support yp_order.  So, we check for the
+		 * existence of the map with the yp_master call.
+		 */
+		err = yp_master(domainname, loc, &hostname);
+		if (err != YPERR_SUCCESS) {
+			debug(MODPREFIX "unable to find map, %s in domain, %s",
+			      loc, domainname);
+			return 0;
+		}
+		free(hostname);
 	}
 
 	return 1;
