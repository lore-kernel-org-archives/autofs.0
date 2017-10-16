From: Ian Kent <raven@themaw.net>
Subject: [PATCH 27/35] autofs-5.1.3 - only take master map mutex for master
 map update
Date: Mon, 16 Oct 2017 13:08:47 +0800
Message-ID: <150813052783.25695.2451102421641576888.stgit@pluto.themaw.net>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

When a map read is done it's neccessary to re-initialize the lookup
context which requires a write lock to be taken on the master map
entry source. Currently a map re-read also takes the master map lock
which will block new lookups.

If the lookup module thinks the map has been modified it will queue
a map read which will take these locks.

Now, when a bind mount (or symlink) is triggered by a lookup it's
necessary to trigger automounts that are included in the target path
for the dependent path to be valid.

When the target path triggers automounts in this way and refers to the
same master map entry, and a map re-read is scheduled and started and
manages to take the master map lock before the dependent lookup gets
past the master map lock check, the dependent path lookup will deadlock.

But the master map lock is meant to gaurd against master map entries
going away during lookups so isn't really needed for map reads as long
as the master map lock is held during the update of the mounted
automounts.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG      |    1 +
 daemon/state.c |    3 ---
 lib/master.c   |   45 +++++++++++++++++++++++++++++++++++++--------
 3 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 7457e620..1ab2e966 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -25,6 +25,7 @@ xx/xx/2017 autofs-5.1.4
 - fix amd parser error buffer size.
 - make spawn_bind_mount() use mount_wait as well.
 - document ghost option in auto.master man page.
+- only take master map mutex for master map update.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/daemon/state.c b/daemon/state.c
index 72bba6af..cf835e05 100644
--- a/daemon/state.c
+++ b/daemon/state.c
@@ -484,12 +484,9 @@ static void *do_readmap(void *arg)
 
 	info(ap->logopt, "re-reading map for %s", ap->path);
 
-	pthread_cleanup_push(master_mutex_lock_cleanup, NULL);
-	master_mutex_lock();
 	status = lookup_nss_read_map(ap, NULL, now);
 	if (!status)
 		pthread_exit(NULL);
-	pthread_cleanup_pop(1);
 
 	if (ap->type == LKP_INDIRECT) {
 		struct ioctl_ops *ops = get_ioctl_ops();
diff --git a/lib/master.c b/lib/master.c
index 22b1522a..a144a39d 100644
--- a/lib/master.c
+++ b/lib/master.c
@@ -1090,6 +1090,39 @@ next:
 	free(paths);
 }
 
+static void wait_for_lookups_and_lock(struct master *master)
+{
+	struct list_head *p, *head;
+	int status;
+
+again:
+	master_mutex_lock();
+
+	head = &master->mounts;
+	p = head->next;
+	while (p != head) {
+		struct master_mapent *this;
+
+		this = list_entry(p, struct master_mapent, list);
+
+		status = pthread_rwlock_trywrlock(&this->source_lock);
+		if (status) {
+			struct timespec t = { 0, 200000000 };
+			struct timespec r;
+
+			master_mutex_unlock();
+
+			while (nanosleep(&t, &r) == -1 && errno == EINTR)
+				memcpy(&t, &r, sizeof(struct timespec));
+
+			goto again;
+		}
+		master_source_unlock(this);
+
+		p = p->next;
+	}
+}
+
 int master_read_master(struct master *master, time_t age, int readall)
 {
 	unsigned int logopt = master->logopt;
@@ -1099,7 +1132,7 @@ int master_read_master(struct master *master, time_t age, int readall)
 	 * We need to clear and re-populate the null map entry cache
 	 * before alowing anyone else to use it.
 	 */
-	master_mutex_lock();
+	wait_for_lookups_and_lock(master);
 	if (master->nc) {
 		cache_writelock(master->nc);
 		nc = master->nc;
@@ -1119,21 +1152,19 @@ int master_read_master(struct master *master, time_t age, int readall)
 	lookup_nss_read_master(master, age);
 	cache_unlock(nc);
 	master_add_amd_mount_section_mounts(master, age);
-	master_mutex_unlock();
 
 	if (!master->read_fail)
 		master_mount_mounts(master, age, readall);
 	else {
 		master->read_fail = 0;
 		/* HUP signal sets readall == 1 only */
-		if (!readall)
+		if (!readall) {
+			master_mutex_unlock();
 			return 0;
-		else
+		} else
 			master_mount_mounts(master, age, readall);
 	}
 
-	master_mutex_lock();
-
 	if (list_empty(&master->mounts))
 		warn(logopt, "no mounts in table");
 
@@ -1423,7 +1454,6 @@ int master_mount_mounts(struct master *master, time_t age, int readall)
 	int cur_state;
 
 	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &cur_state);
-	master_mutex_lock();
 
 	head = &master->mounts;
 	p = head->next;
@@ -1511,7 +1541,6 @@ cont:
 		}
 	}
 
-	master_mutex_unlock();
 	pthread_setcancelstate(cur_state, NULL);
 
 	return 1;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
