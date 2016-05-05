From: jeffm@suse.com
Subject: [PATCH 2/2] autofs: properly handle errors in lookup_nss_mount
Date: Wed,  4 May 2016 20:03:32 -0400
Message-ID: <1462406612-2354-3-git-send-email-jeffm@suse.com>
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

The 'result' variable is initialized to 0 and inconsistently
set in the main while loop.  If the map is expired, the strdup("ldap")
fails, or we end up bailing on an sss source with an amd map, and we're
processing the only map in the list or check_nss_result indicates that
we should continue even when we have NSS_STATUS_SUCCESS, we'll return
success when a failure has occured.

Without this change, the end result is still a failure for the user.
The caller attempting to traverse the map will eventually receive
ELOOP once the kernel has reached its internal automount/link follow
limit.  We will have just wasted a bunch of time in the interim.  This
behavior was observed on a system that was affected by the missing
map->age update fixed in the previous patch.
---
 daemon/lookup.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/daemon/lookup.c b/daemon/lookup.c
index 0129f75..173f53e 100644
--- a/daemon/lookup.c
+++ b/daemon/lookup.c
@@ -1073,7 +1073,7 @@ int lookup_nss_mount(struct autofs_point *ap, struct map_source *source, const c
 	struct nss_source *this;
 	struct map_source *map;
 	enum nsswitch_status status;
-	int result = 0;
+	int result = NSS_STATUS_UNKNOWN;
 
 	/*
 	 * For each map source (ie. each entry for the mount
@@ -1092,6 +1092,7 @@ int lookup_nss_mount(struct autofs_point *ap, struct map_source *source, const c
 		 * the map entry was last updated.
 		 */
 		if (entry->age > map->age) {
+			status = NSS_STATUS_UNAVAIL;
 			map = map->next;
 			continue;
 		}
@@ -1113,6 +1114,7 @@ int lookup_nss_mount(struct autofs_point *ap, struct map_source *source, const c
 				char *tmp = strdup("ldap");
 				if (!tmp) {
 					map = map->next;
+					status = NSS_STATUS_TRYAGAIN;
 					continue;
 				}
 				map->type = tmp;
@@ -1145,6 +1147,7 @@ int lookup_nss_mount(struct autofs_point *ap, struct map_source *source, const c
 			    !strcmp(this->source, "sss")) {
 				warn(ap->logopt,
 				     "source sss is not available for amd maps.");
+				result = NSS_STATUS_UNAVAIL;
 				continue;
 			}
 
-- 
2.7.1

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
