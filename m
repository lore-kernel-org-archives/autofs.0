From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/4] Make hash table scale to thousands
	of	entries
Date: Mon, 12 Jan 2009 13:02:26 +0900
Message-ID: <1231732946.3073.44.camel@zeus.themaw.net>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<1231526823-18595-2-git-send-email-vaurora@redhat.com>
	<x49mye0ffvg.fsf@segfault.boston.devel.redhat.com>
	<20090109195151.GH32333@shell>
	<408431290901091719j58c33f8bj65ce1a47f782bc29@mail.gmail.com>
	<1231692176.10063.10.camel@zeus.themaw.net>
	<408431290901111525y578a5ba4n634ee8b071718790@mail.gmail.com>
	<1231723189.3073.7.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-uG34CRpGmHogw7nah5sW"
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1231723189.3073.7.camel@zeus.themaw.net>
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
To: Paul Wankadia <junyer@google.com>
Cc: autofs@linux.kernel.org


--=-uG34CRpGmHogw7nah5sW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2009-01-12 at 10:19 +0900, Ian Kent wrote:
> 
> Oh .. didn't see this before.
> 
> > How could it be worse? :P
> 
> Hehe, there's an assumption without evidence in there some where.
> 
> > 
> > I'll check our large file map just to satisfy my curiosity.
> > 
> 
> Give me a chance and I'll do a couple of patches to add some statistical
> calculations to cache_dump_cache() so we can see the state of the hash
> table after a map is loaded.

Here are a couple of patches we can use to check what is going on (my
math may be wrong so it would be good if folks could check). They should
apply to the git repo source.

The first patch hash-report-stats.patch modifies cache_dump_cache() to
report some statistics.

The second patch hash-oaat-algo.patch makes the cache use the Vals
proposed oaat algorithm without changing the hash table size for
comparison.

I used an indirect map with 35000 entries as a quick check.

There are a couple of problems with this, first the map keys are a bit
random and so are not representative of actual maps and since we use
multiple caches in v5 the number of entries in a given cache may be
quite different from the total number of entries.

But, if my math is correct, we can get some marginally useful
information from the experiment.

The results:

Current algorithm:
cache: entries 35000 table size 77 ideal chain length 454.55
chain length: empty 0 min 381 max 501 avg 454.55 std 22.78

oaat algorithm:
cache: entries 35000 table size 77 ideal chain length 454.55
chain length: empty 0 min 402 max 532 avg 454.55 std 22.27

This looks a bit odd, my math is probably broken somehow.

I have to conclude that while the oaat algorithm looks worse some how,
if the math is OK, then it is likely that there are more chains closer
to the average length with less outliers (smaller variance in chain
length) than there are with the current algorithm.

It would be good if we could get some real world numbers for both
indirect and direct maps (mainly because direct maps have somewhat
different keys, full path compared to directory component).

I will do some more checks with the proposed large hash table size to
see if the small table size is hiding any bias in the distribution.

Ian


--=-uG34CRpGmHogw7nah5sW
Content-Disposition: attachment; filename=hash-report-stats.patch
Content-Type: text/x-patch; name=hash-report-stats.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Make cache_dump_cache() report some statistical measures instead of

From: Ian Kent <raven@themaw.net>

dumping contents of the cache.

This gets a little more complicated with v5 as we have a cache for
each map entry which itself can have multiple caches. So hash size
for large master maps matters.
---

 Makefile.rules  |    2 +-
 daemon/lookup.c |    3 +++
 lib/cache.c     |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 63 insertions(+), 6 deletions(-)


diff --git a/Makefile.rules b/Makefile.rules
index 30716dc..a59c3dd 100644
--- a/Makefile.rules
+++ b/Makefile.rules
@@ -13,7 +13,7 @@ INCFILES = COPYING COPYRIGHT NEWS README* TODO Makefile Makefile.rules \
 INSTALLROOT = $(DESTDIR)
 
 # autofs utility library
-AUTOFS_LIB = ../lib/autofs.a
+AUTOFS_LIB = ../lib/autofs.a -lm
 
 # Compilers, linkers and flags
 # The STRIP defined here *must not* remove any dynamic-loading symbols
diff --git a/daemon/lookup.c b/daemon/lookup.c
index 741d846..a66e3db 100644
--- a/daemon/lookup.c
+++ b/daemon/lookup.c
@@ -261,6 +261,8 @@ int lookup_nss_read_master(struct master *master, time_t age)
 	return !result;
 }
 
+void cache_dump_cache(struct mapent_cache *mc);
+
 static int do_read_map(struct autofs_point *ap, struct map_source *map, time_t age)
 {
 	struct lookup_mod *lookup;
@@ -296,6 +298,7 @@ static int do_read_map(struct autofs_point *ap, struct map_source *map, time_t a
 	ap->entry->current = map;
 
 	status = lookup->lookup_read_map(ap, age, lookup->context);
+	cache_dump_cache(map->mc);
 
 	map->stale = 0;
 
diff --git a/lib/cache.c b/lib/cache.c
index 4a00367..258afd3 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -36,21 +36,75 @@ void cache_dump_multi(struct list_head *list)
 	}
 }
 
+#include <math.h>
+
+#define min(x, y)	(x <= y ? x : y)
+#define max(x, y)	(x >= y ? x : y)
+
 void cache_dump_cache(struct mapent_cache *mc)
 {
 	struct mapent *me;
+	unsigned long hc_len_min, hc_len_max, hc_empty, h_entries;
+	float hc_len_tot, hc_len_avg, hc_len_var, hc_len_std;
 	unsigned int i;
 
+	/* Calculate average, minimum and maximum chain length */
+
+	hc_len_min = 30000;
+	hc_len_max = 0;
+	hc_len_tot = 0;
+	hc_empty = 0;
+	h_entries = 0;
+
 	for (i = 0; i < mc->size; i++) {
+		unsigned long hc_len = 0;
+
 		me = mc->hash[i];
+
 		if (me == NULL)
-			continue;
-		while (me) {
-			logmsg("me->key=%s me->multi=%p dev=%ld ino=%ld",
-				me->key, me->multi, me->dev, me->ino);
-			me = me->next;
+			hc_empty++;
+		else {
+			while (me) {
+				h_entries++;
+				hc_len++;
+				me = me->next;
+			}
 		}
+		hc_len_min = min(hc_len_min, hc_len);
+		hc_len_max = max(hc_len_max, hc_len);
+		hc_len_tot = hc_len_tot + hc_len;
 	}
+
+	hc_len_avg = hc_len_tot / mc->size;
+
+	/* Calculate chain length variance */
+
+	hc_len_var = 0;
+
+	for (i = 0; i < mc->size; i++) {
+		int hc_len = 0;
+		float hc_dev;
+
+		me = mc->hash[i];
+
+		if (me != NULL) {
+			while (me) {
+				hc_len++;
+				me = me->next;
+			}
+		}
+		hc_dev = ((float) hc_len) - hc_len_avg;
+		hc_dev = hc_dev * hc_dev;
+		hc_len_var = hc_len_var + hc_dev;
+	}
+
+	hc_len_var = hc_len_var / mc->size;
+	hc_len_std = sqrtf(hc_len_var);
+
+	logmsg("cache: entries %u table size %u ideal chain length %.2f",
+		h_entries, mc->size, (float) h_entries/mc->size);
+	logmsg("chain length: empty %u min %u max %u avg %.2f std %.2f",
+		hc_empty, hc_len_min, hc_len_max, hc_len_avg, hc_len_std);
 }
 
 void cache_readlock(struct mapent_cache *mc)

--=-uG34CRpGmHogw7nah5sW
Content-Disposition: attachment; filename=hash-oaat-algo.patch
Content-Type: text/x-patch; name=hash-oaat-algo.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Use proposed oaat algorithm for hash calculation without

From: Ian Kent <raven@themaw.net>

increasing hash table size for comparison against additive
algorithm.
---

 lib/cache.c |   29 ++++++++++++++++++-----------
 1 files changed, 18 insertions(+), 11 deletions(-)


diff --git a/lib/cache.c b/lib/cache.c
index 258afd3..5f64359 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -333,20 +333,27 @@ struct mapent_cache *cache_init_null_cache(struct master *master)
 	return mc;
 }
 
-static unsigned int hash(const char *key)
+static u_int32_t hash(const char *key)
 {
-	unsigned long hashval;
+	u_int32_t hashval;
 	char *s = (char *) key;
 
-	for (hashval = 0; *s != '\0';)
-		hashval += *s++;
+	for (hashval = 0; *s != '\0';) {
+		hashval += (unsigned char) *s++;
+		hashval += (hashval << 10);
+		hashval ^= (hashval >> 6);
+	}
+
+	hashval += (hashval << 3);
+	hashval ^= (hashval >> 11);
+	hashval += (hashval << 15);
 
 	return hashval % HASHSIZE;
 }
 
-static unsigned int ino_hash(dev_t dev, ino_t ino)
+static u_int32_t ino_hash(dev_t dev, ino_t ino)
 {
-	unsigned long hashval;
+	u_int32_t hashval;
 
 	hashval = dev + ino;
 
@@ -355,7 +362,7 @@ static unsigned int ino_hash(dev_t dev, ino_t ino)
 
 int cache_set_ino_index(struct mapent_cache *mc, const char *key, dev_t dev, ino_t ino)
 {
-	unsigned int ino_index = ino_hash(dev, ino);
+	u_int32_t ino_index = ino_hash(dev, ino);
 	struct mapent *me;
 
 	me = cache_lookup_distinct(mc, key);
@@ -377,7 +384,7 @@ struct mapent *cache_lookup_ino(struct mapent_cache *mc, dev_t dev, ino_t ino)
 {
 	struct mapent *me = NULL;
 	struct list_head *head, *p;
-	unsigned int ino_index;
+	u_int32_t ino_index;
 
 	ino_index_lock(mc);
 	ino_index = ino_hash(dev, ino);
@@ -423,7 +430,7 @@ struct mapent *cache_lookup_first(struct mapent_cache *mc)
 struct mapent *cache_lookup_next(struct mapent_cache *mc, struct mapent *me)
 {
 	struct mapent *this;
-	unsigned long hashval;
+	u_int32_t hashval;
 	unsigned int i;
 
 	if (!me)
@@ -584,7 +591,7 @@ int cache_add(struct mapent_cache *mc, struct map_source *ms, const char *key, c
 {
 	struct mapent *me, *existing = NULL;
 	char *pkey, *pent;
-	unsigned int hashval = hash(key);
+	u_int32_t hashval = hash(key);
 	int status;
 
 	me = (struct mapent *) malloc(sizeof(struct mapent));
@@ -804,7 +811,7 @@ int cache_update(struct mapent_cache *mc, struct map_source *ms, const char *key
 int cache_delete(struct mapent_cache *mc, const char *key)
 {
 	struct mapent *me = NULL, *pred;
-	unsigned int hashval = hash(key);
+	u_int32_t hashval = hash(key);
 	int status, ret = CHE_OK;
 	char *this;
 

--=-uG34CRpGmHogw7nah5sW
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--=-uG34CRpGmHogw7nah5sW--

