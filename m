From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch rfc] address regression in duplicate map entry order
Date: Fri, 19 Nov 2004 19:54:15 -0500
Message-ID: <16798.38327.587983.840248@segfault.boston.redhat.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: autofs@linux.kernel.org

Hi, Ian, list,

In my proposed fix, I meant to say:

We could expire the cache in lookup_ghost, and then go ahead and only
insert new entries (instead of overwriting what was there).

So, I've implemented this, though it isn't tested just yet.  There were
some other bugs.

In lookup_multi, we iterate through each map's lookup_ghost function.  The
problem here is that you will end up doing the following:

static int read_map(const char *root, struct lookup_context *ctxt)
{
	char key[KEY_MAX_LEN + 1];
	char mapent[MAPENT_MAX_LEN + 1];
	char *mapname;
	FILE *f;
	int  entry;
	time_t age = time(NULL);    <=================

	mapname = alloca(strlen(ctxt->mapname) + 6);
	sprintf(mapname, "file:%s", ctxt->mapname);

	f = fopen(ctxt->mapname, "r");
	if (!f) {
		error(MODPREFIX "could not open map file %s", ctxt->mapname);
		return 0;
	}

	while(1) {
		entry = read_one(f, key, mapent);
		if (entry)
			cache_update(root, key, mapent, age); <==========

		if (feof(f))
			break;
	}

	fclose(f);

	/* Clean stale entries from the cache */
	cache_clean(root, age);  <=============

	return 1;
}

Notice the lines I've pointed out.  We decide what the expiration age
should be at the beginning of the function.  We update entries and give
them that "age."  And finally, we expire all entries that were made prior
to that.  The problem arises in that we call the read_map routine for each
map in the list in order.  What will happen is that each map, as it is
processed, will end up with a new value for age.  Thus, we expire all of
the work done by the previous read_maps!  This is bad.  To fix this, I've
passed in the age field from the top-level.

I've changed ldap's lookup_ghost routine (well, a function it calls,
anyway) to use cache_insert_unique instead of cache_add.

Please let me know what you think.  If you only like some parts, let me
know which ones and I'll break them out from the rest of the patch.  BTW,
this patch is applied on top of your map expiration changes.  I can rediff
the thing to any version of the code you want.

-Jeff

Only in autofs-4.1.3-new: Makefile.conf
Only in autofs-4.1.3-new: config.log
Only in autofs-4.1.3-new: config.status
Only in autofs-4.1.3-new/daemon: automount
diff -up --recursive autofs-4.1.3/daemon/automount.c autofs-4.1.3-new/daemon/automount.c
--- autofs-4.1.3/daemon/automount.c	2004-11-19 19:41:42.321126992 -0500
+++ autofs-4.1.3-new/daemon/automount.c	2004-11-19 19:26:02.400016720 -0500
@@ -825,7 +825,8 @@ static int st_readmap(void)
 {
 	int status;
 
-	status = ap.lookup->lookup_ghost(ap.path, ap.ghost, ap.lookup->context);
+	status = ap.lookup->lookup_ghost(ap.path, ap.ghost, ap.lookup->context,
+					 time(NULL));
 
 	debug("st_readmap: status %d\n", status);
 
@@ -1502,7 +1503,8 @@ static void sig_supervisor(int sig)
 		break;
 
 	case SIGHUP:
-		ap.lookup->lookup_ghost(ap.path, ap.ghost, ap.lookup->context);
+		ap.lookup->lookup_ghost(ap.path, ap.ghost, ap.lookup->context,
+					time(NULL));
 
 		/* Pass on the reread event and ignore self signal */
 		kill(0, SIGHUP);
@@ -1520,7 +1522,8 @@ int supervisor(char *path)
 	ap.path = alloca(strlen(path) + 1);
 	strcpy(ap.path, path);
 
-	map = ap.lookup->lookup_ghost(ap.path, ap.ghost, ap.lookup->context);
+	map = ap.lookup->lookup_ghost(ap.path, ap.ghost, ap.lookup->context,
+				      time(NULL));
 	if (map & LKP_FAIL) {
 		error("failed to load map exiting");
 		cleanup_exit(ap.path, 1);
@@ -1588,7 +1591,8 @@ int handle_mounts(char *path)
 			alarm(ap.exp_runfreq + my_pid % ap.exp_runfreq);
 	}
 
-	map = ap.lookup->lookup_ghost(ap.path, ap.ghost, ap.lookup->context);
+	map = ap.lookup->lookup_ghost(ap.path, ap.ghost, ap.lookup->context,
+				      time(NULL));
 	if (map & LKP_FAIL) {
 		if (map & LKP_INDIRECT) {
 			error("bad map format: found indirect, "
Only in autofs-4.1.3-new/daemon: automount.c~
Only in autofs-4.1.3-new/daemon: automount.o
Only in autofs-4.1.3-new/daemon: module.o
Only in autofs-4.1.3-new/daemon: mount.o
Only in autofs-4.1.3-new/daemon: spawn.o
diff -up --recursive autofs-4.1.3/include/automount.h autofs-4.1.3-new/include/automount.h
--- autofs-4.1.3/include/automount.h	2004-11-19 19:41:42.300130184 -0500
+++ autofs-4.1.3-new/include/automount.h	2004-11-19 19:30:32.685927016 -0500
@@ -140,12 +140,12 @@ int is_mounted(const char *path);
 
 #ifdef MODULE_LOOKUP
 int lookup_init(const char *mapfmt, int argc, const char *const *argv, void **context);
-int lookup_ghost(const char *, int, void *);
+int lookup_ghost(const char *, int, void *, time_t);
 int lookup_mount(const char *, const char *, int, void *);
 int lookup_done(void *);
 #endif
 typedef int (*lookup_init_t) (const char *, int, const char *const *, void **);
-typedef int (*lookup_ghost_t) (const char *, int, void *);
+typedef int (*lookup_ghost_t) (const char *, int, void *, time_t);
 typedef int (*lookup_mount_t) (const char *, const char *, int, void *);
 typedef int (*lookup_done_t) (void *);
 
@@ -236,6 +236,7 @@ struct mapent_cache *cache_lookup_first(
 struct mapent_cache *cache_partial_match(const char *prefix);
 int cache_add(const char *root, const char *key, const char *mapent, time_t age);
 int cache_update(const char *root, const char *key, const char *mapent, time_t age);
+int cache_insert_unique(const char *root, const char *key, const char *mapent, time_t age);
 int cache_delete(const char *root, const char *key, int rmpath);
 void cache_clean(const char *root, time_t age);
 void cache_release(void);
Only in autofs-4.1.3-new/include: automount.h~
Only in autofs-4.1.3-new/include: config.h
Only in autofs-4.1.3-new/lib: autofs.a
diff -up --recursive autofs-4.1.3/lib/cache.c autofs-4.1.3-new/lib/cache.c
--- autofs-4.1.3/lib/cache.c	2004-11-19 19:41:42.301130032 -0500
+++ autofs-4.1.3-new/lib/cache.c	2004-11-19 19:17:01.042315600 -0500
@@ -197,6 +197,30 @@ int cache_add(const char *root, const ch
 	return CHE_OK;
 }
 
+int cache_insert_unique(const char *root, const char *key, const char *mapent, time_t age)
+{
+	struct mapent_cache *s, *me = NULL;
+	char *pent;
+	int ret = CHE_OK;
+
+	for (s = mapent_hash[hash(key)]; s != NULL; s = s->next)
+		if (strcmp(key, s->key) == 0) {
+			me = s;
+			break;
+		}
+
+	if (!me) {
+		ret = cache_add(root, key, mapent, age);
+		if (!ret) {
+			debug("cache_add: failed for %s", key);
+			return CHE_FAIL;
+		}
+		ret = CHE_UPDATED;
+	}
+
+	return ret;
+}
+
 int cache_update(const char *root, const char *key, const char *mapent, time_t age)
 {
 	struct mapent_cache *s, *me = NULL;
Only in autofs-4.1.3-new/lib: cache.c~
Only in autofs-4.1.3-new/lib: cache.o
Only in autofs-4.1.3-new/lib: cat_path.o
Only in autofs-4.1.3-new/lib: listmount.o
Only in autofs-4.1.3-new/lib: mount.h
Only in autofs-4.1.3-new/lib: mount_clnt.c
Only in autofs-4.1.3-new/lib: mount_clnt.o
Only in autofs-4.1.3-new/lib: mount_xdr.c
Only in autofs-4.1.3-new/lib: mount_xdr.o
Only in autofs-4.1.3-new/lib: rpc_subs.o
Only in autofs-4.1.3-new/man: autofs.8
diff -up --recursive autofs-4.1.3/modules/lookup_file.c autofs-4.1.3-new/modules/lookup_file.c
--- autofs-4.1.3/modules/lookup_file.c	2004-11-19 19:41:42.336124712 -0500
+++ autofs-4.1.3-new/modules/lookup_file.c	2004-11-19 19:27:14.940988816 -0500
@@ -227,14 +227,13 @@ static int read_one(FILE *f, char *key, 
 	return 0;
 }
 
-static int read_map(const char *root, struct lookup_context *ctxt)
+static int read_map(const char *root, struct lookup_context *ctxt, time_t age)
 {
 	char key[KEY_MAX_LEN + 1];
 	char mapent[MAPENT_MAX_LEN + 1];
 	char *mapname;
 	FILE *f;
 	int  entry;
-	time_t age = time(NULL);
 
 	mapname = alloca(strlen(ctxt->mapname) + 6);
 	sprintf(mapname, "file:%s", ctxt->mapname);
@@ -245,10 +244,12 @@ static int read_map(const char *root, st
 		return 0;
 	}
 
+	/* Clean all entries from the cache */
+	cache_clean(root, age);
 	while(1) {
 		entry = read_one(f, key, mapent);
 		if (entry)
-			cache_update(root, key, mapent, age);
+			cache_insert_unique(root, key, mapent, age);
 
 		if (feof(f))
 			break;
@@ -256,20 +257,17 @@ static int read_map(const char *root, st
 
 	fclose(f);
 
-	/* Clean stale entries from the cache */
-	cache_clean(root, age);
-
 	return 1;
 }
 
-int lookup_ghost(const char *root, int ghost, void *context)
+int lookup_ghost(const char *root, int ghost, void *context, time_t age)
 {
 	struct lookup_context *ctxt = (struct lookup_context *) context;
 	struct mapent_cache *me;
 	struct stat st;
 	int status = 1;
 
-	if (!read_map(root, ctxt))
+	if (!read_map(root, ctxt, age))
 		return LKP_FAIL;
 
 	if (stat(ctxt->mapname, &st)) {
Only in autofs-4.1.3-new/modules: lookup_file.c~
Only in autofs-4.1.3-new/modules: lookup_file.so
diff -up --recursive autofs-4.1.3/modules/lookup_hesiod.c autofs-4.1.3-new/modules/lookup_hesiod.c
--- autofs-4.1.3/modules/lookup_hesiod.c	2004-11-19 19:41:42.247138240 -0500
+++ autofs-4.1.3-new/modules/lookup_hesiod.c	2004-11-19 19:28:43.428536664 -0500
@@ -66,7 +66,7 @@ int lookup_init(const char *mapfmt, int 
 	return !(ctxt->parser = open_parse(mapfmt, MODPREFIX, argc - 1, argv + 1));
 }
 
-int lookup_ghost(const char *root, int ghost, void *context)
+int lookup_ghost(const char *root, int ghost, void *context, time_t age)
 {
 	return LKP_NOTSUP;
 }
Only in autofs-4.1.3-new/modules: lookup_hesiod.c~
Only in autofs-4.1.3-new/modules: lookup_hesiod.so
diff -up --recursive autofs-4.1.3/modules/lookup_ldap.c autofs-4.1.3-new/modules/lookup_ldap.c
--- autofs-4.1.3/modules/lookup_ldap.c	2004-11-19 19:41:42.371119392 -0500
+++ autofs-4.1.3-new/modules/lookup_ldap.c	2004-11-19 19:36:04.462489312 -0500
@@ -262,7 +262,7 @@ static int read_one_map(const char *root
 		for (i = 0; i < count; i++) {
 			if (**keyValue == '/' && strlen(*keyValue) == 1)
 				**keyValue = '*';
-			cache_add(root, *keyValue, values[i], age);
+			cache_insert_unique(root, *keyValue, values[i], age);
 		}
 		ldap_value_free(values);
 
@@ -280,11 +280,14 @@ static int read_one_map(const char *root
 }
 
 static int read_map(const char *root, struct lookup_context *ctxt,
-		    const char *key, int keyvallen, int *result_ldap)
+		    const char *key, int keyvallen, int *result_ldap,
+		    time_t age)
 {
-	time_t age = time(NULL);
 	int rv = LDAP_SUCCESS;
 
+	/* Clean all entries from the cache */
+	cache_clean(root, age);
+
 	/* all else fails read entire map */
 	if (!read_one_map(root, "nisObject", "cn", 
 			  key, keyvallen, "nisMapEntry", ctxt, &rv)) {
@@ -297,13 +300,10 @@ static int read_map(const char *root, st
 		}
 	}
 
-	/* Clean stale entries from the cache */
-	cache_clean(root, age);
-
 	return 1;
 }
 
-int lookup_ghost(const char *root, int ghost, void *context)
+int lookup_ghost(const char *root, int ghost, void *context, time_t age)
 {
 	struct lookup_context *ctxt = (struct lookup_context *) context;
 	struct mapent_cache *me;
@@ -312,7 +312,7 @@ int lookup_ghost(const char *root, int g
 
 	chdir("/");
 
-	if (!read_map(root, ctxt, NULL, 0, &rv))
+	if (!read_map(root, ctxt, NULL, 0, &rv, age))
 		switch (rv) {
 		case LDAP_SIZELIMIT_EXCEEDED:
 		case LDAP_UNWILLING_TO_PERFORM:
Only in autofs-4.1.3-new/modules: lookup_ldap.c~
Only in autofs-4.1.3-new/modules: lookup_ldap.so
diff -up --recursive autofs-4.1.3/modules/lookup_multi.c autofs-4.1.3-new/modules/lookup_multi.c
--- autofs-4.1.3/modules/lookup_multi.c	2004-11-19 19:41:42.381117872 -0500
+++ autofs-4.1.3-new/modules/lookup_multi.c	2004-11-19 19:25:04.979745928 -0500
@@ -111,14 +111,14 @@ int lookup_init(const char *my_mapfmt, i
 	return 1;
 }
 
-int lookup_ghost(const char *root, int ghost, void *context)
+int lookup_ghost(const char *root, int ghost, void *context, time_t age)
 {
 	struct lookup_context *ctxt = (struct lookup_context *) context;
 	int i, ret, at_least_1 = 0;
 
 	for (i = 0; i < ctxt->n; i++) {
 		ret = ctxt->m[i].mod->lookup_ghost(root, ghost,
-						   ctxt->m[i].mod->context);
+						ctxt->m[i].mod->context, age);
 		if (ret & LKP_FAIL)
 			continue;
 
Only in autofs-4.1.3-new/modules: lookup_multi.c~
Only in autofs-4.1.3-new/modules: lookup_multi.so
diff -up --recursive autofs-4.1.3/modules/lookup_nisplus.c autofs-4.1.3-new/modules/lookup_nisplus.c
--- autofs-4.1.3/modules/lookup_nisplus.c	2004-01-29 11:01:22.000000000 -0500
+++ autofs-4.1.3-new/modules/lookup_nisplus.c	2004-11-19 19:33:08.221282048 -0500
@@ -59,7 +59,7 @@ int lookup_init(const char *mapfmt, int 
 	return !(ctxt->parse = open_parse(mapfmt, MODPREFIX, argc - 1, argv + 1));
 }
 
-int lookup_ghost(const char *root, int ghost, void *context)
+int lookup_ghost(const char *root, int ghost, void *context, time_t age)
 {
 	return LKP_NOTSUP;
 }
Only in autofs-4.1.3-new/modules: lookup_nisplus.c~
Only in autofs-4.1.3-new/modules: lookup_nisplus.so
diff -up --recursive autofs-4.1.3/modules/lookup_program.c autofs-4.1.3-new/modules/lookup_program.c
--- autofs-4.1.3/modules/lookup_program.c	2004-11-19 19:41:42.386117112 -0500
+++ autofs-4.1.3-new/modules/lookup_program.c	2004-11-19 19:28:55.472705672 -0500
@@ -76,7 +76,7 @@ int lookup_init(const char *mapfmt, int 
 	return !(ctxt->parse = open_parse(mapfmt, MODPREFIX, argc - 1, argv + 1));
 }
 
-int lookup_ghost(const char *root, int ghost, void *context)
+int lookup_ghost(const char *root, int ghost, void *context, time_t age)
 {
 	return LKP_NOTSUP;
 }
Only in autofs-4.1.3-new/modules: lookup_program.c~
Only in autofs-4.1.3-new/modules: lookup_program.so
diff -up --recursive autofs-4.1.3/modules/lookup_userhome.c autofs-4.1.3-new/modules/lookup_userhome.c
--- autofs-4.1.3/modules/lookup_userhome.c	2004-01-29 11:01:22.000000000 -0500
+++ autofs-4.1.3-new/modules/lookup_userhome.c	2004-11-19 19:32:38.747762704 -0500
@@ -36,7 +36,7 @@ int lookup_init(const char *mapfmt, int 
 	return 0;		/* Nothing to do */
 }
 
-int lookup_ghost(const char *root, int ghost, void *context)
+int lookup_ghost(const char *root, int ghost, void *context, time_t age)
 {
 	return LKP_NOTSUP;
 }
Only in autofs-4.1.3-new/modules: lookup_userhome.c~
Only in autofs-4.1.3-new/modules: lookup_userhome.so
diff -up --recursive autofs-4.1.3/modules/lookup_yp.c autofs-4.1.3-new/modules/lookup_yp.c
--- autofs-4.1.3/modules/lookup_yp.c	2004-11-19 19:41:42.306129272 -0500
+++ autofs-4.1.3-new/modules/lookup_yp.c	2004-11-19 19:29:49.258528984 -0500
@@ -109,18 +109,20 @@ int yp_all_callback(int status, char *yp
 	strncpy(mapent, val, vallen);
 	*(mapent + vallen) = '\0';
 
-	cache_update(root, key, mapent, age);
+	cache_insert_unique(root, key, mapent, age);
 
 	return 0;
 }
 
-static int read_map(const char *root, struct lookup_context *context)
+static int read_map(const char *root, struct lookup_context *context, time_t age)
 {
 	struct lookup_context *ctxt = (struct lookup_context *) context;
 	struct ypall_callback ypcb;
-	time_t age = time(NULL);
 	int err;
 
+	/* Clean all entries from the cache */
+	cache_clean(root, age);
+
 	ypcb.foreach = yp_all_callback;
 	ypcb.data = (char *) root;
 
@@ -132,19 +134,16 @@ static int read_map(const char *root, st
 		return 0;
 	}
 
-	/* Clean stale entries from the cache */
-	cache_clean(root, age);
-
 	return 1;
 }
 
-int lookup_ghost(const char *root, int ghost, void *context)
+int lookup_ghost(const char *root, int ghost, void *context, time_t age)
 {
 	struct lookup_context *ctxt = (struct lookup_context *) context;
 	struct mapent_cache *me;
 	int status = 1;
 
-	if (!read_map(root, ctxt))
+	if (!read_map(root, ctxt, age))
 		return LKP_FAIL;
 
 	status = cache_ghost(root, ghost, ctxt->mapname, "yp", ctxt->parse);
Only in autofs-4.1.3-new/modules: lookup_yp.c~
Only in autofs-4.1.3-new/modules: lookup_yp.so
Only in autofs-4.1.3-new/modules: mount_afs.so
Only in autofs-4.1.3-new/modules: mount_autofs.so
Only in autofs-4.1.3-new/modules: mount_bind.so
Only in autofs-4.1.3-new/modules: mount_changer.so
Only in autofs-4.1.3-new/modules: mount_ext2.so
Only in autofs-4.1.3-new/modules: mount_generic.so
Only in autofs-4.1.3-new/modules: mount_nfs.so
Only in autofs-4.1.3-new/modules: parse_hesiod.so
Only in autofs-4.1.3-new/modules: parse_sun.so
Only in autofs-4.1.3-new/samples: autofs-ldap-auto-master
Only in autofs-4.1.3-new/samples: autofs-ldap-auto-master.o
Only in autofs-4.1.3-new/samples: rc.autofs
