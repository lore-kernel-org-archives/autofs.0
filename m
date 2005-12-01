From: Ian Kent <raven@themaw.net>
Subject: Re: stat of /users/no-such-user takes 15 seconds
Date: Thu, 1 Dec 2005 22:58:28 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0512012252410.3272@donald.themaw.net>
References: <1132670358.4039.37.camel@brilong-lnx>
	<Pine.LNX.4.63.0511222329100.9982@donald.themaw.net>
	<17283.17854.189791.135878@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0511242311570.2314@donald.themaw.net>
	<17292.42845.186329.808676@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0511300907190.32520@wombat.indigo.net.au>
	<17294.3164.781525.150155@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17294.3164.781525.150155@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Wed, 30 Nov 2005, Jeff Moyer wrote:

> ==> Regarding Re: [autofs] stat of /users/no-such-user takes 15 seconds; Ian Kent <raven@themaw.net> adds:
> 
> raven> On Tue, 29 Nov 2005, Jeff Moyer wrote:
> >> ==> Regarding Re: [autofs] stat of /users/no-such-user takes 15 seconds;
> >> Ian Kent <raven@themaw.net> adds:
> >> 
> raven> On Tue, 22 Nov 2005, Jeff Moyer wrote:
> >> >> ==> Regarding Re: [autofs] stat of /users/no-such-user takes 15
> >> seconds; Ian Kent <raven@themaw.net> adds:
> >> >> 
> >> 
> raven> Could you review this patch please Jeff.
> >> After reviewing this further, I did find a problem.  See below.
> 
> raven> All good points and the test is wrong.  I'll update the patch and
> raven> post another.
> 
> raven> That just leaves the re-read for the other cases which may be
> raven> causing a long delay. I'm not sure this slows the lookup unless
> raven> sending the signal is causing starvation of cpu cycles some
> raven> how. Perhaps the change from cache_add to cache_update will help
> raven> more than I think.
> 
> Ian,
> 
> The patch I'm attaching is the one against the RHEL autofs package.  This
> is what I have come up with, and it is WRONG.  =)  It causes a regression
> in the case where there are multiple keys of the same name in a map;  the
> patched automounter will always use the last key instead of the first.
> Remember dealing with this back in February?  Fun.
> 

Maybe this one is a little better.
I've removed the LDAP update changes as I think their not needed.

Please check it out Jeff.


=================

This patch addresses three problems.

Change cache_update to only update the first occurance of
a duplicate map entry on a map read.

Change cache_add to cache_update in lookup modules.
Perform an update rather than an add so that only stale
entries are actually removed instead of adding an additional
entry then removing the old one. This add/remove causes a
directory removal of almost every entry in the map when it
should'nt.

Prevent re-read of map and return fail from the lookup module
when a key is not present in the cache and is not present in
the map source.

--- autofs-4.1.4/lib/cache.c.update-fix	2005-11-24 22:40:58.000000000 +0800
+++ autofs-4.1.4/lib/cache.c	2005-12-01 22:16:42.000000000 +0800
@@ -233,6 +233,10 @@ int cache_update(const char *root, const
 		}
 		ret = CHE_UPDATED;
 	} else {
+		/* Already seen one of these */
+		if (me->age == age)
+			return CHE_OK;
+
 		if (strcmp(me->mapent, mapent) != 0) {
 			pent = malloc(strlen(mapent) + 1);
 			if (pent == NULL) {
@@ -312,11 +316,6 @@ void cache_clean(const char *root, time_
 			if (!path)
 				return;
 
-			if (is_mounted(_PATH_MOUNTED, path)) {
-				free(path);
-				continue;
-			}
-
 			if (me->age < age) {
 				pred->next = me->next;
 				free(me->key);
@@ -337,11 +336,6 @@ void cache_clean(const char *root, time_
 		if (!path)
 			return;
 
-		if (is_mounted(_PATH_MOUNTED, path)) {
-			free(path);
-			continue;
-		}
-
 		if (me->age < age) {
 			mapent_hash[i] = me->next;
 			rmdir_path(path);
--- autofs-4.1.4/modules/lookup_file.c.update-fix	2005-11-24 22:00:30.000000000 +0800
+++ autofs-4.1.4/modules/lookup_file.c	2005-12-01 22:36:21.000000000 +0800
@@ -252,7 +252,7 @@ static int read_map(const char *root, ti
 	while(1) {
 		entry = read_one(f, key, mapent);
 		if (entry)
-			cache_add(root, key, mapent, age);
+			cache_update(root, key, mapent, age);
 
 		if (feof(f))
 			break;
@@ -383,7 +383,7 @@ int lookup_mount(const char *root, const
 	char key[KEY_MAX_LEN + 1];
 	int key_len;
 	char mapent[MAPENT_MAX_LEN + 1];
-	struct mapent_cache *me;
+	struct mapent_cache *me, *exists;
 	time_t now = time(NULL);
 	time_t t_last_read;
 	int need_hup = 0;
@@ -407,16 +407,19 @@ int lookup_mount(const char *root, const
 
 	/* only if it has been modified */
 	if (st.st_mtime > ctxt->mtime) {
+		exists = cache_lookup(key);
+
 		ret = lookup_one(root, key, key_len, ctxt);
-		if (!ret)
+		if (ret == CHE_FAIL)
 			return 1;
 
-		debug("ret = %d", ret);
-
+		/* Check if we need to update the map */
 		if (t_last_read > ap.exp_runfreq)
-			if (ret & (CHE_UPDATED | CHE_MISSING))
+			if ((ret & CHE_UPDATED) ||
+			    (exists && (ret & CHE_MISSING)))
 				need_hup = 1;
 
+		/* Update our map for the lookup */
 		if (ret == CHE_MISSING) {
 			int wild = CHE_MISSING;
 
--- autofs-4.1.4/modules/lookup_yp.c.update-fix	2005-11-24 22:02:00.000000000 +0800
+++ autofs-4.1.4/modules/lookup_yp.c	2005-12-01 22:35:44.000000000 +0800
@@ -102,7 +102,7 @@ int yp_all_callback(int status, char *yp
 	strncpy(mapent, val, vallen);
 	*(mapent + vallen) = '\0';
 
-	cache_add(root, key, mapent, age);
+	cache_update(root, key, mapent, age);
 
 	return 0;
 }
@@ -220,7 +220,7 @@ int lookup_mount(const char *root, const
 	int key_len;
 	char *mapent;
 	int mapent_len;
-	struct mapent_cache *me;
+	struct mapent_cache *me, *exists;
 	time_t now = time(NULL);
 	time_t t_last_read;
 	int need_hup = 0;
@@ -236,13 +236,17 @@ int lookup_mount(const char *root, const
 	if (key_len > KEY_MAX_LEN)
 		return 1;
 
-	/* check map and if change is detected re-read map */
+	/*
+	 * check map and if change is detected re-read map
+	 */
+
+	/* First check to see if this entry exists in the cache */
+	exists = cache_lookup(key);
+
 	ret = lookup_one(root, key, key_len, ctxt);
-	if (!ret)
+	if (ret == CHE_FAIL)
 		return 1;
 
-	debug("ret = %d", ret);
-
 	if (ret < 0) {
 		warn(MODPREFIX 
 		     "lookup for %s failed: %s", name, yperr_string(-ret));
@@ -253,7 +257,8 @@ int lookup_mount(const char *root, const
 	t_last_read = me ? now - me->age : ap.exp_runfreq + 1;
 
 	if (t_last_read > ap.exp_runfreq)
-		if (ret & (CHE_UPDATED | CHE_MISSING))
+		if ((ret & CHE_UPDATED) ||
+		    (exists && (ret & CHE_MISSING)))
 			need_hup = 1;
 
 	if (ret == CHE_MISSING) {
--- autofs-4.1.4/modules/lookup_ldap.c.update-fix	2005-11-24 22:35:22.000000000 +0800
+++ autofs-4.1.4/modules/lookup_ldap.c	2005-12-01 22:36:44.000000000 +0800
@@ -598,7 +598,7 @@ int lookup_mount(const char *root, const
 	int key_len;
 	char mapent[MAPENT_MAX_LEN + 1];
 	char *mapname;
-	struct mapent_cache *me;
+	struct mapent_cache *me, *exists;
 	time_t now = time(NULL);
 	time_t t_last_read;
 	int need_hup = 0;
@@ -611,22 +611,26 @@ int lookup_mount(const char *root, const
 	if (key_len > KEY_MAX_LEN)
 		return 1;
 
+	exists = cache_lookup(key);
+
 	ret = lookup_one(root, key, "nisObject", "cn", "nisMapEntry", ctxt);
 	ret2 = lookup_one(root, key,
 			    "automount", "cn", "automountInformation", ctxt);
 	
-   	debug("ret = %d, ret2 = %d", ret, ret2);
-
-	if (!ret && !ret2)
+	if (ret == CHE_FAIL && ret2 == CHE_FAIL)
 		return 1;
 
 	me = cache_lookup_first();
 	t_last_read = me ? now - me->age : ap.exp_runfreq + 1;
 
-	if (t_last_read > ap.exp_runfreq) 
-		if ((ret & (CHE_MISSING | CHE_UPDATED)) && 
-		    (ret2 & (CHE_MISSING | CHE_UPDATED)))
+	if (t_last_read > ap.exp_runfreq) {
+		if ((ret & CHE_UPDATED) ||
+		     (exists && (ret & CHE_MISSING)))
 			need_hup = 1;
+		else if ((ret2 & CHE_UPDATED) ||
+		     (exists && (ret2 & CHE_MISSING)))
+			need_hup = 1;
+	}
 
 	if (ret == CHE_MISSING && ret2 == CHE_MISSING) {
 		int wild = CHE_MISSING;
