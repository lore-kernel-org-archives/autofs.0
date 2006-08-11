From: "Daniel Richard G." <skunk@iskunk.org>
Subject: [PATCH] More autofs cleanup
Date: Thu, 10 Aug 2006 22:37:33 -0400
Message-ID: <20060811023733.GC26249@mail.iSKUNK.ORG>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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
To: autofs@linux.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by hera.kernel.org id k7C56NxL003528

Hello list,

Finally built and semi-figured-out git. A few more wrinkles ironed out in=
=20
this patch.


A walkthrough, in order:

Makefile:

* Invoke autoheader in the configure target, 'cause it sure as heck hasn'=
t=20
  been run in a while :-)

  (You might want to update config.h.in, given that it uses an #ident=20
  directive that gcc complains about in pedantic mode)

Makefile.conf.in:

* Added a dummy @substitution@ for datarootdir, so that config.status=20
  doesn't print a warning at the end of a configure script run.

configure.in:

* Autoconf (or was it autoheader?) really wants you to use the
  three-argument form of AC_DEFINE().

daemon/indirect.c, daemon/lookup.c:

* Removed random redundant variable declarations.

include/automount.h:

* From the way it's used, shouldn't the status field be a time_t? This ge=
ts=20
  rid of some signed-vs-unsigned comparisons, at the very least.

* Don't use a generic local variable name like "status" in a macro=20
  definition. (This was shadowing local "status" variables in numerous=20
  places.)

include/state.h, lib/alarm.c:

* Same deal with "status" local variable inside a macro definition.

lib/parse_subs.c:

* Got a signed-vs-unsigned comparison warning here. Is it kosher to use=20
  __SWORD_TYPE? I don't know if "struct statfs" is officially supposed to=
=20
  use more formal type names for its fields.

modules/lookup_file.c, modules/parse_hesiod.c:

* Signed-vs-unsigned comparison fixes.

modules/lookup_hosts.c:

* The rpcgen-generated mount.h actually typedefs a "name" type. This make=
s=20
  the compiler look askance at subsequent, innocuous uses of variables=20
  named "name", so shove aside the typedef with a temporary #define.

* Fixed more weirdness of using sprintf()'s return value.

modules/parse_sun.c:

* The function already has a local variable "ent", of "const char *" type=
.=20
  I renamed this one to "xent", but you might have a better name for it.


That takes care of pretty much all the warnings that can be addressed=20
without annoyingly invasive modifications (assuming you'd want to address=
=20
them at all). Here is what remains, with commentary:

    294 warning: ISO C does not permit named variadic macros
    174 warning: ISO C99 requires rest arguments to be used

	(Well, what can you do?)

     22 warning: cast discards qualifiers from pointer target type

	(This seems to be done deliberately, so no prob)

     11 warning: ISO C forbids conversion of object pointer to function p=
ointer type

	(You have no choice when you're using dlsym()!)

      5 warning: shadowed declaration is here
      5 warning: declaration of =E2=80=98_buffer=E2=80=99 shadows a previ=
ous local

	(From nested instances of pthread_cleanup_push())

      4 warning: comma at end of enumerator list
      1 warning: negative integer implicitly converted to unsigned type

	(rpcgen wackiness)

      1 warning: comparison between signed and unsigned

	(In Flex-generated code for nss_tok.l)


--Daniel


--=20
NAME   =3D Daniel Richard G.       ##  Remember, skunks       _\|/_  meef=
?
EMAIL1 =3D skunk@iskunk.org        ##  don't smell bad---    (/o|o\) /
EMAIL2 =3D skunk@alum.mit.edu      ##  it's the people who   < (^),>
WWW    =3D http://www.******.org/  ##  annoy them that do!    /   \
--
(****** =3D site not yet online)

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="autofs-cleanup.patch"

diff --git a/.autofs-5.0.1-rc1 b/.autofs-5.0.1-rc1
diff --git a/Makefile b/Makefile
index 68ec1e3..4f7c488 100644
--- a/Makefile
+++ b/Makefile
@@ -52,6 +52,7 @@ backup: mrproper
 
 configure: configure.in aclocal.m4
 	autoconf
+	autoheader
 	rm -rf config.* *.cache
 
 configure.in: .version
diff --git a/Makefile.conf.in b/Makefile.conf.in
index a741a8f..ea5fe1d 100644
--- a/Makefile.conf.in
+++ b/Makefile.conf.in
@@ -80,3 +80,5 @@ mandir = @mandir@
 # Location for init.d files
 initdir = @initdir@
 
+# This is here just to keep config.status quiet
+UNUSED_datarootdir = @datarootdir@
diff --git a/configure.in b/configure.in
index c5e2a1e..9d46d42 100644
--- a/configure.in
+++ b/configure.in
@@ -276,7 +276,7 @@ AC_ARG_ENABLE(mount-locking,
 [  --disable-mount-locking disable use of locking when spawning mount command],,
 	enableval=yes)
 if test x$enable_mount_locking = xyes -o x$enableval = xyes; then
-	AC_DEFINE(ENABLE_MOUNT_LOCKING, 1)
+	AC_DEFINE(ENABLE_MOUNT_LOCKING, 1, [Disable use of locking when spawning mount command])
 fi
 
 #
@@ -287,7 +287,7 @@ AC_ARG_ENABLE(forced-shutdown,
 			  busy mounts during shutdown],,
 	enableval=no)
 if test x$enable_forced_shutdown = xyes -o x$enableval = xyes; then
-	AC_DEFINE(ENABLE_FORCED_SHUTDOWN, 1)
+	AC_DEFINE(ENABLE_FORCED_SHUTDOWN, 1, [Enable forced shutdown on USR1 signal])
 fi
 
 #
@@ -298,7 +298,7 @@ AC_ARG_ENABLE(ignore-busy,
 			  shutdown],,
 	enableval=no)
 if test x$enable_ignore_busy_mounts = xyes -o x$enableval = xyes; then
-	AC_DEFINE(ENABLE_IGNORE_BUSY_MOUNTS, 1)
+	AC_DEFINE(ENABLE_IGNORE_BUSY_MOUNTS, 1, [Enable exit, ignoring busy mounts])
 fi
 
 #
diff --git a/daemon/indirect.c b/daemon/indirect.c
index 8748413..9415fc5 100644
--- a/daemon/indirect.c
+++ b/daemon/indirect.c
@@ -436,7 +436,6 @@ void *expire_proc_indirect(void *arg)
 	mnts = get_mnt_list(_PROC_MOUNTS, ap->path, 0);
 	for (next = mnts; next; next = next->next) {
 		char *ind_key;
-		int ret;
 
 		if (!strcmp(next->fs_type, "autofs"))
 			continue;
diff --git a/daemon/lookup.c b/daemon/lookup.c
index aeda909..b45cdb8 100644
--- a/daemon/lookup.c
+++ b/daemon/lookup.c
@@ -786,8 +786,6 @@ int lookup_nss_mount(struct autofs_point
 
 		head = &nsslist;
 		list_for_each(p, head) {
-			enum nsswitch_status status;
-
 			this = list_entry(p, struct nss_source, list);
 
 			result = lookup_map_name(this, ap, map, name, name_len);
diff --git a/include/automount.h b/include/automount.h
index 90a9c7a..cf8c043 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -148,7 +148,7 @@ struct mapent {
 	char *mapent;
 	time_t age;
 	/* Time of last mount fail */
-	unsigned int status;
+	time_t status;
 	/* For direct mounts per entry context is kept here */
 	int dir_created;
 	/* File descriptor for ioctls */
@@ -479,30 +479,30 @@ int count_mounts(struct autofs_point *ap
 
 #define state_mutex_lock(ap) \
 do { \
-	int status = pthread_mutex_lock(&ap->state_mutex); \
-	if (status) \
-		fatal(status); \
+	int _mtx_status = pthread_mutex_lock(&ap->state_mutex); \
+	if (_mtx_status) \
+		fatal(_mtx_status); \
 } while(0)
 
 #define state_mutex_unlock(ap) \
 do{ \
-	int status = pthread_mutex_unlock(&ap->state_mutex); \
-	if (status) \
-		fatal(status); \
+	int _mtx_status = pthread_mutex_unlock(&ap->state_mutex); \
+	if (_mtx_status) \
+		fatal(_mtx_status); \
 } while (0)
 
 #define mounts_mutex_lock(ap) \
 do { \
-	int status = pthread_mutex_lock(&ap->mounts_mutex); \
-	if (status) \
-		fatal(status); \
+	int _mtx_status = pthread_mutex_lock(&ap->mounts_mutex); \
+	if (_mtx_status) \
+		fatal(_mtx_status); \
 } while (0)
 
 #define mounts_mutex_unlock(ap) \
 do { \
-	int status = pthread_mutex_unlock(&ap->mounts_mutex); \
-	if (status) \
-		fatal(status); \
+	int _mtx_status = pthread_mutex_unlock(&ap->mounts_mutex); \
+	if (_mtx_status) \
+		fatal(_mtx_status); \
 } while(0)
 
 /* Expire alarm handling routines */
diff --git a/include/state.h b/include/state.h
index ea4c62a..783810c 100644
--- a/include/state.h
+++ b/include/state.h
@@ -91,16 +91,16 @@ int st_start_handler(void);
 
 #define st_mutex_lock() \
 do { \
-	int status = pthread_mutex_lock(&mutex); \
-	if (status) \
-		fatal(status); \
+	int _mtx_status = pthread_mutex_lock(&mutex); \
+	if (_mtx_status) \
+		fatal(_mtx_status); \
 } while (0)
 
 #define st_mutex_unlock() \
 do { \
-	int status = pthread_mutex_unlock(&mutex); \
-	if (status) \
-		fatal(status); \
+	int _mtx_status = pthread_mutex_unlock(&mutex); \
+	if (_mtx_status) \
+		fatal(_mtx_status); \
 } while (0)
 
 #endif
diff --git a/lib/alarm.c b/lib/alarm.c
index 8124796..3f08729 100755
--- a/lib/alarm.c
+++ b/lib/alarm.c
@@ -28,16 +28,16 @@ static LIST_HEAD(alarms);
 
 #define alarm_lock() \
 do { \
-	int status = pthread_mutex_lock(&mutex); \
-	if (status) \
-		fatal(status); \
+	int _mtx_status = pthread_mutex_lock(&mutex); \
+	if (_mtx_status) \
+		fatal(_mtx_status); \
 } while (0)
 
 #define alarm_unlock() \
 do { \
-	int status = pthread_mutex_unlock(&mutex); \
-	if (status) \
-		fatal(status); \
+	int _mtx_status = pthread_mutex_unlock(&mutex); \
+	if (_mtx_status) \
+		fatal(_mtx_status); \
 } while (0)
 
 void dump_alarms(void)
diff --git a/lib/parse_subs.c b/lib/parse_subs.c
index 68bdf8d..1d2e34b 100644
--- a/lib/parse_subs.c
+++ b/lib/parse_subs.c
@@ -284,8 +284,8 @@ int umount_ent(struct autofs_point *ap, 
 		warn(ap->logopt, "could not stat fs of %s", path);
 		is_smbfs = 0;
 	} else {
-		int cifsfs = fs.f_type == CIFS_MAGIC_NUMBER;
-		int smbfs = fs.f_type == SMB_SUPER_MAGIC;
+		int cifsfs = fs.f_type == (__SWORD_TYPE) CIFS_MAGIC_NUMBER;
+		int smbfs = fs.f_type == (__SWORD_TYPE) SMB_SUPER_MAGIC;
 		is_smbfs = (cifsfs | smbfs) ? 1 : 0;
 	}
 
diff --git a/modules/lookup_file.c b/modules/lookup_file.c
index 9a9f498..e818242 100644
--- a/modules/lookup_file.c
+++ b/modules/lookup_file.c
@@ -781,7 +781,7 @@ static int lookup_one(struct autofs_poin
 				if (!s_key)
 					continue;
 
-				if (key_len != strlen(s_key)) {
+				if (key_len != (int) strlen(s_key)) {
 					free(s_key);
 					continue;
 				}
diff --git a/modules/lookup_hosts.c b/modules/lookup_hosts.c
index 3b8c4ae..eb3fa01 100644
--- a/modules/lookup_hosts.c
+++ b/modules/lookup_hosts.c
@@ -21,7 +21,9 @@ #include <sys/types.h>
 #include <sys/stat.h>
 #include <netdb.h>
 
+#define name __xdr_name
 #include "mount.h"
+#undef name
 
 #define MODULE_LOOKUP
 #include "automount.h"
@@ -170,10 +172,10 @@ int lookup_mount(struct autofs_point *ap
 	 */
 	if (*name == '/') {
 		pthread_cleanup_push(cache_lock_cleanup, mc);
-		mapent = alloca(strlen(me->mapent) + 1);
-		mapent_len = sprintf(mapent, me->mapent);
+		mapent_len = strlen(me->mapent);
+		mapent = alloca(mapent_len + 1);
+		strcpy(mapent, me->mapent);
 		pthread_cleanup_pop(0);
-		mapent[mapent_len] = '\0';
 	}
 done:
 	cache_unlock(mc);
diff --git a/modules/parse_hesiod.c b/modules/parse_hesiod.c
index 7f125eb..ff1f0a5 100644
--- a/modules/parse_hesiod.c
+++ b/modules/parse_hesiod.c
@@ -106,7 +106,7 @@ static int parse_nfs(struct autofs_point
 		p++;
 
 	/* Isolate the remote mountpoint for this NFS fs. */
-	for (i = 0; (!isspace(p[i]) && i < sizeof(mount)); i++) {
+	for (i = 0; (!isspace(p[i]) && i < (int) sizeof(mount)); i++) {
 		mount[i] = p[i];
 	}
 
diff --git a/modules/parse_sun.c b/modules/parse_sun.c
index 3f489ed..1841268 100644
--- a/modules/parse_sun.c
+++ b/modules/parse_sun.c
@@ -755,7 +755,7 @@ static int parse_mapent(const char *ent,
 	p = skipspace(p);
 
 	while (*p && *p != '/') {
-		char *ent;
+		char *xent;
 
 		/* Location can't begin with a '/' */
 		if (*p == '/') {
@@ -767,38 +767,38 @@ static int parse_mapent(const char *ent,
 		}
 
 		l = chunklen(p, check_colon(p));
-		ent = dequote(p, l, logopt);
-		if (!ent) {
+		xent = dequote(p, l, logopt);
+		if (!xent) {
 			warn(logopt, MODPREFIX "null location or out of memory");
 			free(myoptions);
 			free(loc);
 			return 0;
 		}
 
-		if (!validate_location(ent)) {
+		if (!validate_location(xent)) {
 			warn(logopt,
-			      MODPREFIX "invalid location %s", ent);
-			free(ent);
+			      MODPREFIX "invalid location %s", xent);
+			free(xent);
 			free(myoptions);
 			free(loc);
 			return 0;
 		}
 
-		debug(logopt, MODPREFIX "dequote(\"%.*s\") -> %s", l, p, ent);
+		debug(logopt, MODPREFIX "dequote(\"%.*s\") -> %s", l, p, xent);
 
 		loc = realloc(loc, strlen(loc) + l + 2);
 		if (!loc) {
 			error(logopt, MODPREFIX "out of memory");
-			free(ent);
+			free(xent);
 			free(myoptions);
 			free(loc);
 			return 0;
 		}
 
 		strcat(loc, " ");
-		strcat(loc, ent);
+		strcat(loc, xent);
 
-		free(ent);
+		free(xent);
 
 		p += l;
 		p = skipspace(p);

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--MGYHOYXEY6WxJCY8--

