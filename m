From: Ian Kent <raven@themaw.net>
Subject: [PATCH 1/5] autofs-5.0.3 - Another fix for don't fail on
	empty master	map.
Date: Thu, 12 Jun 2008 13:04:29 +0800
Message-ID: <20080612050429.27161.28412.stgit@raven.themaw.net>
References: <20080612045519.27161.92549.stgit@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080612045519.27161.92549.stgit@raven.themaw.net>
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
To: Jim Carter <jimc@math.ucla.edu>, autofs mailing list <autofs@linux.kernel.org>

autofs-5.0.3-dont-fail-on-empty-master-fix-2.patch

---

 lib/master.c          |   12 ++----------
 modules/lookup_file.c |    1 +
 2 files changed, 3 insertions(+), 10 deletions(-)


diff --git a/lib/master.c b/lib/master.c
index ed82131..4a34dd4 100644
--- a/lib/master.c
+++ b/lib/master.c
@@ -799,21 +799,13 @@ int master_read_master(struct master *master, time_t age, int readall)
 
 	master_init_scan();
 
-	if (!lookup_nss_read_master(master, age)) {
-		error(logopt,
-		      "can't read master map %s", master->name);
-		return 0;
-	}
-
+	lookup_nss_read_master(master, age);
 	master_mount_mounts(master, age, readall);
 
 	master_mutex_lock();
 
-	if (list_empty(&master->mounts)) {
-		master_mutex_unlock();
+	if (list_empty(&master->mounts))
 		warn(logopt, "no mounts in table");
-		return 1;
-	}
 
 	master_mutex_unlock();
 
diff --git a/modules/lookup_file.c b/modules/lookup_file.c
index b01eea6..466690a 100644
--- a/modules/lookup_file.c
+++ b/modules/lookup_file.c
@@ -475,6 +475,7 @@ int lookup_read_master(struct master *master, time_t age, void *context)
 				     "failed to read included master map %s",
 				     master->name);
 				if (!master->recurse) {
+					master->name = save_name;
 					master->depth--;
 					master->recurse = 0;
 					fclose(f);
