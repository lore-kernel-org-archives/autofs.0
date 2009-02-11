From: Ian Kent <raven@themaw.net>
Subject: [PATCH 02/13] autofs-5.0.4 - fix hosts map use after free
Date: Thu, 12 Feb 2009 01:00:19 +0900
Message-ID: <20090211160019.12578.73871.stgit@zeus.themaw.net>
References: <20090211154853.12578.50525.stgit@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20090211154853.12578.50525.stgit@zeus.themaw.net>
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
To: autofs mailing list <autofs@linux.kernel.org>

From: Paul Wankadia <junyer@google.com>

This patch fixed use a map entry after it has been freed in the
hosts map lookup module.
---

 CHANGELOG              |    1 +
 modules/lookup_hosts.c |    8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index eb4a189..3199e4d 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -9,6 +9,7 @@
   Valerie Aurora Henson).
 - clear the quoted flag after each character from program map input.
 - use CLOEXEC flag for setmntent also.
+- fix hosts map use after free (Paul Wankadia).
 
 4/11/2008 autofs-5.0.4
 -----------------------
diff --git a/modules/lookup_hosts.c b/modules/lookup_hosts.c
index 93b975a..d3ae0e2 100644
--- a/modules/lookup_hosts.c
+++ b/modules/lookup_hosts.c
@@ -138,17 +138,19 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 	/* Check if we recorded a mount fail for this key anywhere */
 	me = lookup_source_mapent(ap, name, LKP_DISTINCT);
 	if (me) {
+		struct mapent_cache *fmc = me->mc;
+
 		if (me->status >= time(NULL)) {
-			cache_unlock(me->mc);
+			cache_unlock(fmc);
 			return NSS_STATUS_NOTFOUND;
 		}
 
 		if (!me->mapent) {
-			cache_delete(me->mc, name);
+			cache_delete(fmc, name);
 			me = NULL;
 		}
 
-		cache_unlock(me->mc);
+		cache_unlock(fmc);
 	}
 
 	cache_readlock(mc);
