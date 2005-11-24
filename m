From: Ian Kent <raven@themaw.net>
Subject: Re: stat of /users/no-such-user takes 15 seconds
Date: Thu, 24 Nov 2005 23:14:43 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0511242311570.2314@donald.themaw.net>
References: <1132670358.4039.37.camel@brilong-lnx>
	<Pine.LNX.4.63.0511222329100.9982@donald.themaw.net>
	<17283.17854.189791.135878@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17283.17854.189791.135878@segfault.boston.redhat.com>
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

On Tue, 22 Nov 2005, Jeff Moyer wrote:

> ==> Regarding Re: [autofs] stat of /users/no-such-user takes 15 seconds; Ian Kent <raven@themaw.net> adds:
> 
> raven> On Tue, 22 Nov 2005, Brian Long wrote:
> >> I have an auto.master deployed to thousands of hosts and it looks like
> >> this:
> >> 
> >> /misc /etc/auto.misc --timeout=60 /auto /etc/auto.indirect
> >> rsize=32768,wsize=32768,tcp /users auto_home
> >> rw,hard,intr,rsize=32768,wsize=32768,tcp
> >> 
> >> As you can see, /users comes from NIS auto.home map.  In our case,
> >> auto.home contains over 34,000 entries.  I've noticed in RHEL 3 U5 and
> >> beyond (autofs-4.1.3-130), trying to stat (ls) /users/no-such-user takes
> >> roughly 12-15 seconds.  In RHEL 3 U3 (autofs-4.1.3-12), it returns
> >> immediately.  This is a regression in my opinion.
> 
> raven> Bummer. I thought that update code was OK.
> 
> >> After looking at tcpdump data, it appears automounter is downloading the
> >> entire auto.home map when it fails to lookup "no-such-user".  This
> >> results in a > 700KB transfer from the NIS server :(
> 
> raven> This is exactly the sort of problem I was concerned about when
> raven> people asked for periodic reload of maps. I didn't do that and
> raven> clearly I was right.
> 
> raven> Having said that it possibly shouldn't be doing this either. I'll
> raven> have to check the lookup code to see what I'm doing.
> 
> raven> Probably I'm signaling a re-load because, since the entry is now
> raven> missing, the map may need to be updated.
> 
> raven> I hasten to point out there was quite a bit of demand for having "up
> raven> to date maps"! Having a HUP signal to force a re-load wasn't enough.
> 
> raven> Given your situation and the fact that we need to know about
> raven> changes, what do you think the semantics of handling map updates
> raven> should be?
> 
> raven> Seems to me there are only two options when an out of date map entry
> raven> is encountered. Update, remove or add the given entry and accept
> raven> there may be more you don't know about or re-read the whole map. Now
> raven> even the simple addition and removal is not simple as the lookup is
> raven> done in a subprocess so somehow the process leader needs to be told
> raven> what to get!
> 
> Ian, the point here is that the map key isn't out of date.  We don't detect
> that the entry didn't exist in the first place.  See my other post to this
> thread, where I've attached a patch.  Comments on that are, of course,
> encouraged.

Could you review this patch please Jeff.

I will try to find some time to setup and test it on the weekend.

==============

This patch addresses two problems.

Change cache_add to cache_update in lookup modules.
Perform an update rather than an add so that only stale
entries are actually removed instead of adding an additional
entry then removing the old one. This add/remove causes a
directory removal of almost every entry in the map when it
should'nt.

Prevent re-read of map and return fail from the lookup module
when a key is not present in the cache and is not present in
the map source. 

Requires autofs-4.1.4-misc-mixes.patch to have already been applied.

--- autofs-4.1.4/lib/cache.c.update-fix	2005-11-24 22:40:58.000000000 +0800
+++ autofs-4.1.4/lib/cache.c	2005-11-24 22:41:36.000000000 +0800
@@ -312,11 +312,6 @@ void cache_clean(const char *root, time_
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
@@ -337,11 +332,6 @@ void cache_clean(const char *root, time_
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
+++ autofs-4.1.4/modules/lookup_file.c	2005-11-24 22:52:56.000000000 +0800
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
@@ -407,12 +407,12 @@ int lookup_mount(const char *root, const
 
 	/* only if it has been modified */
 	if (st.st_mtime > ctxt->mtime) {
+		exists = cache_lookup(key);
+
 		ret = lookup_one(root, key, key_len, ctxt);
-		if (!ret)
+		if (!exists && !ret)
 			return 1;
 
-		debug("ret = %d", ret);
-
 		if (t_last_read > ap.exp_runfreq)
 			if (ret & (CHE_UPDATED | CHE_MISSING))
 				need_hup = 1;
--- autofs-4.1.4/modules/lookup_yp.c.update-fix	2005-11-24 22:02:00.000000000 +0800
+++ autofs-4.1.4/modules/lookup_yp.c	2005-11-24 22:53:09.000000000 +0800
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
@@ -237,12 +237,17 @@ int lookup_mount(const char *root, const
 		return 1;
 
 	/* check map and if change is detected re-read map */
+	/*
+	 * check map and if change is detected re-read map
+	 */
+
+	/* First check to see if this entry exists in the cache */
+	exists = cache_lookup(key);
+
 	ret = lookup_one(root, key, key_len, ctxt);
-	if (!ret)
+	if (!exists && !ret)
 		return 1;
 
-	debug("ret = %d", ret);
-
 	if (ret < 0) {
 		warn(MODPREFIX 
 		     "lookup for %s failed: %s", name, yperr_string(-ret));
--- autofs-4.1.4/modules/lookup_ldap.c.update-fix	2005-11-24 22:35:22.000000000 +0800
+++ autofs-4.1.4/modules/lookup_ldap.c	2005-11-24 22:53:43.000000000 +0800
@@ -463,10 +463,8 @@ static int lookup_one(const char *root, 
 	}
 
 	if (!me) {
-		cache_delete(root, qKey, 0);
-
 		for (i = 0; values[i]; i++) {	
-			rv = cache_add(root, qKey, values[i], age);
+			rv = cache_update(root, qKey, values[i], age);
 			if (!rv)
 				return 0;
 		}
@@ -571,10 +569,8 @@ static int lookup_wild(const char *root,
 	}
 
 	if (!me) {
-		cache_delete(root, "*", 0);
-
 		for (i = 0; values[i]; i++) {	
-			rv = cache_add(root, "*", values[i], age);
+			rv = cache_update(root, "*", values[i], age);
 			if (!rv)
 				return 0;
 		}
@@ -598,7 +594,7 @@ int lookup_mount(const char *root, const
 	int key_len;
 	char mapent[MAPENT_MAX_LEN + 1];
 	char *mapname;
-	struct mapent_cache *me;
+	struct mapent_cache *me *exists;
 	time_t now = time(NULL);
 	time_t t_last_read;
 	int need_hup = 0;
@@ -611,13 +607,13 @@ int lookup_mount(const char *root, const
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
+	if (!exists && !ret && !ret2)
 		return 1;
 
 	me = cache_lookup_first();
