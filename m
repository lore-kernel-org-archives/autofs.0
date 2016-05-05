From: jeffm@suse.com
Subject: [PATCH 1/2] autofs: fix yp map age not updated in s/_/./g case
Date: Wed,  4 May 2016 20:03:31 -0400
Message-ID: <1462406612-2354-2-git-send-email-jeffm@suse.com>
References: <1462406612-2354-1-git-send-email-jeffm@suse.com>
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1462406612-2354-1-git-send-email-jeffm@suse.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org
Cc: Jeff Mahoney <jeffm@suse.com>

From: Jeff Mahoney <jeffm@suse.com>

The map source age field should be updated when we retry
the yp map lookup using dots instead of underscores.

Rather than just open code the exit path, just reverse the logic for
returning success so we only have one success path for both cases.
---
 modules/lookup_yp.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/modules/lookup_yp.c b/modules/lookup_yp.c
index eda2aba..502d850 100644
--- a/modules/lookup_yp.c
+++ b/modules/lookup_yp.c
@@ -431,17 +431,16 @@ int lookup_read_map(struct autofs_point *ap, time_t age, void *context)
 			err = yp_all((char *) ctxt->domainname, mapname, &ypcb);
 		}
 
-		if (err == YPERR_SUCCESS)
-			return NSS_STATUS_SUCCESS;
+		if (err != YPERR_SUCCESS) {
+			warn(ap->logopt,
+			     MODPREFIX "read of map %s failed: %s",
+			     ap->path, yperr_string(err));
 
-		warn(ap->logopt,
-		     MODPREFIX "read of map %s failed: %s",
-		     ap->path, yperr_string(err));
+			if (err == YPERR_PMAP || err == YPERR_YPSERV)
+				return NSS_STATUS_UNAVAIL;
 
-		if (err == YPERR_PMAP || err == YPERR_YPSERV)
-			return NSS_STATUS_UNAVAIL;
-
-		return NSS_STATUS_NOTFOUND;
+			return NSS_STATUS_NOTFOUND;
+		}
 	}
 
 	source->age = age;
-- 
2.7.1

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
