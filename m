From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: stat of /users/no-such-user takes 15 seconds
Date: Wed, 30 Nov 2005 16:22:58 -0500
Message-ID: <17294.6194.571144.480918@segfault.boston.redhat.com>
References: <1132670358.4039.37.camel@brilong-lnx>
	<Pine.LNX.4.63.0511222329100.9982@donald.themaw.net>
	<17283.17854.189791.135878@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0511242311570.2314@donald.themaw.net>
	<17292.42845.186329.808676@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0511300907190.32520@wombat.indigo.net.au>
	<17294.3164.781525.150155@segfault.boston.redhat.com>
	<1133384016.4403.25.camel@brilong-lnx>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1133384016.4403.25.camel@brilong-lnx>
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
Content-Type: text/plain; charset="us-ascii"
To: Brian Long <brilong@cisco.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

==> Regarding Re: [autofs] stat of /users/no-such-user takes 15 seconds; Brian Long <brilong@cisco.com> adds:

brilong> On Wed, 2005-11-30 at 15:32 -0500, Jeff Moyer wrote:
>> ==> Regarding Re: [autofs] stat of /users/no-such-user takes 15 seconds;
>> Ian Kent <raven@themaw.net> adds:
>> 
raven> On Tue, 29 Nov 2005, Jeff Moyer wrote:
>> >> ==> Regarding Re: [autofs] stat of /users/no-such-user takes 15
>> seconds; >> Ian Kent <raven@themaw.net> adds:
>> >> 
raven> On Tue, 22 Nov 2005, Jeff Moyer wrote:
>> >> >> ==> Regarding Re: [autofs] stat of /users/no-such-user takes 15 >>
>> seconds; Ian Kent <raven@themaw.net> adds:
>> >> >> 
>> >> 
raven> Could you review this patch please Jeff.
>> >> After reviewing this further, I did find a problem.  See below.
>> 
raven> All good points and the test is wrong.  I'll update the patch and
raven> post another.
>>
raven> That just leaves the re-read for the other cases which may be
raven> causing a long delay. I'm not sure this slows the lookup unless
raven> sending the signal is causing starvation of cpu cycles some
raven> how. Perhaps the change from cache_add to cache_update will help
raven> more than I think.
>> Ian,
>> 
>> The patch I'm attaching is the one against the RHEL autofs package.
>> This is what I have come up with, and it is WRONG.  =) It causes a
>> regression in the case where there are multiple keys of the same name in
>> a map; the patched automounter will always use the last key instead of
>> the first.  Remember dealing with this back in February?  Fun.
>> 
>> I'll keep poking at it, I just wanted to make you aware of the problem.

brilong> Does this affect the autofs-4.1.3-166 RPMs I'm testing?  :)

Yes.  And here is the patch, which I forgot to attach to my last message.
In case this is at all unclear, the attached patch is bad.  Don't deploy.
;)  To clarify even further, I tested the file maps case.

-Jeff

--- autofs-4.1.3/modules/lookup_file.c.orig	2005-11-29 13:44:12.000000000 -0500
+++ autofs-4.1.3/modules/lookup_file.c	2005-11-29 14:31:10.000000000 -0500
@@ -248,7 +248,7 @@ static int read_map(const char *root, ti
 	while(1) {
 		entry = read_one(f, key, mapent);
 		if (entry)
-			cache_add(root, key, mapent, age);
+			cache_update(root, key, mapent, age);
 
 		if (feof(f))
 			break;
@@ -380,7 +380,7 @@ int lookup_mount(const char *root, const
 	char key[KEY_MAX_LEN + 1];
 	int key_len;
 	char mapent[MAPENT_MAX_LEN + 1];
-	struct mapent_cache *me;
+	struct mapent_cache *me, *exists;
 	time_t now = time(NULL);
 	time_t t_last_read;
 	int ret;
@@ -403,13 +403,15 @@ int lookup_mount(const char *root, const
 
 	/* only if it has been modified */
 	if (st.st_mtime > ctxt->mtime) {
+		exists = cache_lookup(key);
+
 		ret = lookup_one(root, key, key_len, ctxt);
-		if (!ret)
+		if (ret == CHE_FAIL)
 			return 1;
 
 		debug("ret = %d", ret);
 
-		if (ret == CHE_MISSING) {
+		if (ret == CHE_MISSING && exists) {
 			if (!cache_delete(root, key, CHE_RMPATH))
 				rmdir_path(key);
 
--- autofs-4.1.3/modules/lookup_yp.c.orig	2005-11-29 14:31:14.000000000 -0500
+++ autofs-4.1.3/modules/lookup_yp.c	2005-11-29 14:33:41.000000000 -0500
@@ -110,7 +110,7 @@ int yp_all_callback(int status, char *yp
 	strncpy(mapent, val, vallen);
 	*(mapent + vallen) = '\0';
 
-	cache_add(root, key, mapent, age);
+	cache_update(root, key, mapent, age);
 
 	return 0;
 }
@@ -224,7 +224,7 @@ int lookup_mount(const char *root, const
 	int key_len;
 	char *mapent;
 	int mapent_len;
-	struct mapent_cache *me;
+	struct mapent_cache *me, *exists;
 	int ret;
 	time_t now = time(NULL);
 	time_t t_last_read;
@@ -240,11 +240,14 @@ int lookup_mount(const char *root, const
 	if (key_len > KEY_MAX_LEN)
 		return 1;
 
-	/* check map and if change is detected re-read map */
-	ret = lookup_one(root, key, key_len, ctxt);
+	/*
+	 *  check map and if change is detected re-read map
+	 */
 
-	debug("ret = %d", ret);
+	/* First check to see if this entry exists in the cache */
+	exists = cache_lookup(key);
 
+	ret = lookup_one(root, key, key_len, ctxt);
 	if (!ret)
 		return 1;
 
@@ -261,7 +264,7 @@ int lookup_mount(const char *root, const
 		/* Have parent update its map */
 		if (t_last_read > ap.exp_runfreq)
 			kill(getppid(), SIGHUP);
-	} else if (ret == CHE_MISSING) {
+	} else if (ret == CHE_MISSING && exists) {
 		if (!cache_delete(root, key, 0)) {
 			rmdir_if_mount_fails = 1;
 		}
--- autofs-4.1.3/modules/lookup_ldap.c.orig	2005-11-29 14:35:02.000000000 -0500
+++ autofs-4.1.3/modules/lookup_ldap.c	2005-11-29 16:02:56.000000000 -0500
@@ -460,10 +460,8 @@ static int lookup_one(const char *root, 
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
@@ -594,7 +592,7 @@ int lookup_mount(const char *root, const
 	int key_len;
 	char mapent[MAPENT_MAX_LEN + 1];
 	char *mapname;
-	struct mapent_cache *me;
+	struct mapent_cache *me, *exists;
 	time_t now = time(NULL);
 	time_t t_last_read;
 
@@ -606,6 +604,8 @@ int lookup_mount(const char *root, const
 	if (key_len > KEY_MAX_LEN)
 		return 1;
 
+	exists = cache_lookup(key);
+
 	ret = lookup_one(root, key, "nisObject", "cn", "nisMapEntry", ctxt);
 	ret2 = lookup_one(root, key,
 			    "automount", "cn", "automountInformation", ctxt);
@@ -620,7 +620,7 @@ int lookup_mount(const char *root, const
 	me = cache_lookup_first();
 	t_last_read = now - me->age;
 
-	if (ret == CHE_MISSING && ret2 == CHE_MISSING && ret3 == CHE_MISSING) {
+	if (ret == ret2 == ret3 == CHE_MISSING && exists) {
 		if (!cache_delete(root, key, CHE_RMPATH))
 			rmdir_path(key);
