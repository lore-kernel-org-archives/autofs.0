From: Ian Kent <raven@themaw.net>
Subject: Re: [ANNOUNCE] autofs 5.0.0 beta2
Date: Sat, 27 May 2006 16:13:21 +0800
Message-ID: <1148717601.2587.39.camel@raven.themaw.net>
References: <Pine.LNX.4.64.0605091848390.12829@raven.themaw.net>
	<446251C5.5070407@inria.fr> <x49y7x12vml.fsf@redhat.com>
	<x49lksoz974.fsf@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49lksoz974.fsf@segfault.boston.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Fri, 2006-05-26 at 18:56 -0400, Jeff Moyer wrote:
> Guillaume.Rousse> Third, the following patches still apply, but I got no
> Guillaume.Rousse> clue about their usefulness: -
> 
> Guillaume.Rousse> autofs-4.1.0-hesiod-bind.patch
> 
> jmoyer> I'll do some digging on this one tomorrow.
> 
> OK, it took me a while longer than expected to get to this.  Sorry!
> 
> The hesiod resolve patch is wanted.  Actually, I think in v5 we can just
> get rid of the old calls to hes_resolve.
> 
> If you look at the implementation that currently is there in lookup_hesiod.c,
> it has some bugs.  It will free a pointer that the library will
> subsequently try to free, and it also leaks memory.  This is, in part, due to
> the horrible definition of the interface at the time, I believe.
> 
> At any rate, we should move to hesiod_init, hesiod_resolve, etc.  It's
> probably best to check that the hesiod library supports the new interfaces
> at configure time.  If not, just disable the building of the hesiod
> modules.
> 
> Ian, let me know what you think of the attached patch.
> 

I've checked this out and ended up with this, the configure part is
due to the change in configure.in:

diff --git a/CHANGELOG b/CHANGELOG
index 1428424..1ef0f2c 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -6,6 +6,10 @@
 - merge don't strip debug info macro patch (Jeff Moyer).
 - merge patch to add sanity checks on rmdir_path and unlink (Jeff Moyer).
 - merge patch fix e2fsck error code check (Jeff Moyer).
+- update hesiod module (Jeff Moyer).
+  - add mutex to protect against overlapping mount requests.
+  - update return from mount request to give more sensible NSS_*
+    values.
 
 23/5/2006 autofs-5.0.0_beta3
 ----------------------------
diff --git a/configure b/configure
index 613a731..f032bf0 100755
--- a/configure
+++ b/configure
@@ -3168,9 +3168,9 @@ fi;
 if test -z "$HAVE_HESIOD"
 then
 	HAVE_HESIOD=0
-	echo "$as_me:$LINENO: checking for hes_resolve in -lhesiod" >&5
-echo $ECHO_N "checking for hes_resolve in -lhesiod... $ECHO_C" >&6
-if test "${ac_cv_lib_hesiod_hes_resolve+set}" = set; then
+	echo "$as_me:$LINENO: checking for hesiod_resolve in -lhesiod" >&5
+echo $ECHO_N "checking for hesiod_resolve in -lhesiod... $ECHO_C" >&6
+if test "${ac_cv_lib_hesiod_hesiod_resolve+set}" = set; then
   echo $ECHO_N "(cached) $ECHO_C" >&6
 else
   ac_check_lib_save_LIBS=$LIBS
@@ -3188,11 +3188,11 @@ extern "C"
 #endif
 /* We use char because int might match the return type of a gcc2
    builtin and then its argument prototype would still apply.  */
-char hes_resolve ();
+char hesiod_resolve ();
 int
 main ()
 {
-hes_resolve ();
+hesiod_resolve ();
   ;
   return 0;
 }
@@ -3219,20 +3219,20 @@ if { (eval echo "$as_me:$LINENO: \"$ac_l
   ac_status=$?
   echo "$as_me:$LINENO: \$? = $ac_status" >&5
   (exit $ac_status); }; }; then
-  ac_cv_lib_hesiod_hes_resolve=yes
+  ac_cv_lib_hesiod_hesiod_resolve=yes
 else
   echo "$as_me: failed program was:" >&5
 sed 's/^/| /' conftest.$ac_ext >&5
 
-ac_cv_lib_hesiod_hes_resolve=no
+ac_cv_lib_hesiod_hesiod_resolve=no
 fi
 rm -f conftest.err conftest.$ac_objext \
       conftest$ac_exeext conftest.$ac_ext
 LIBS=$ac_check_lib_save_LIBS
 fi
-echo "$as_me:$LINENO: result: $ac_cv_lib_hesiod_hes_resolve" >&5
-echo "${ECHO_T}$ac_cv_lib_hesiod_hes_resolve" >&6
-if test $ac_cv_lib_hesiod_hes_resolve = yes; then
+echo "$as_me:$LINENO: result: $ac_cv_lib_hesiod_hesiod_resolve" >&5
+echo "${ECHO_T}$ac_cv_lib_hesiod_hesiod_resolve" >&6
+if test $ac_cv_lib_hesiod_hesiod_resolve = yes; then
   HAVE_HESIOD=1 LIBHESIOD="$LIBHESIOD -lhesiod"
 fi
 
diff --git a/configure.in b/configure.in
index 1e01795..0e875f8 100644
--- a/configure.in
+++ b/configure.in
@@ -143,7 +143,7 @@ AC_ARG_WITH(hesiod,
 if test -z "$HAVE_HESIOD"
 then
 	HAVE_HESIOD=0
-	AC_CHECK_LIB(hesiod, hes_resolve, HAVE_HESIOD=1 LIBHESIOD="$LIBHESIOD -lhesiod", ,
+	AC_CHECK_LIB(hesiod, hesiod_resolve, HAVE_HESIOD=1 LIBHESIOD="$LIBHESIOD -lhesiod", ,
 		     $LIBRESOLV)
 	if test "$HAVE_HESIOD" == "1"; then
 		AC_DEFINE(WITH_HESIOD,1,
diff --git a/modules/lookup_hesiod.c b/modules/lookup_hesiod.c
index 391b646..cf9331c 100644
--- a/modules/lookup_hesiod.c
+++ b/modules/lookup_hesiod.c
@@ -29,8 +29,11 @@ #define HESIOD_LEN 512
 
 struct lookup_context {
 	struct parse_mod *parser;
+	void *hesiod_context;
 };
 
+static pthread_mutex_t hesiod_mutex = PTHREAD_MUTEX_INITIALIZER;
+
 int lookup_version = AUTOFS_LOOKUP_VERSION;	/* Required by protocol */
 
 /* This initializes a context (persistent non-global data) for queries to
@@ -51,6 +54,13 @@ int lookup_init(const char *mapfmt, int 
 	/* Initialize the resolver. */
 	res_init();
 
+	/* Initialize the hesiod context. */
+	if (hesiod_init(&(ctxt->hesiod_context)) != 0) {
+		char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
+		crit(MODPREFIX "hesiod_init(): %s", estr);
+		return 1;
+	}
+
 	/* If a map type isn't explicitly given, parse it as hesiod entries. */
 	if (!mapfmt)
 		mapfmt = MAPFMT_DEFAULT;
@@ -69,15 +79,17 @@ int lookup_read_map(struct autofs_point 
 	return NSS_STATUS_UNKNOWN;
 }
 
-/* Lookup and act on a filesystem name.  In this case, lookup the "filsys"
-   record in hesiod.  If it's an AFS or NFS filesyste, parse it out.  If
-   it's an ERR filesystem, it's an error message we should log.  Otherwise,
-   assume it's something we know how to deal with already (generic). */
+/*
+ * Lookup and act on a filesystem name.  In this case, lookup the "filsys"
+ * record in hesiod.  If it's an AFS or NFS filesystem, parse it out.  If
+ * it's an ERR filesystem, it's an error message we should log.  Otherwise,
+ * assume it's something we know how to deal with already (generic).
+ */
 int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *context)
 {
 	char **hes_result;
 	struct lookup_context *ctxt = (struct lookup_context *) context;
-	int rv;
+	int status, rv;
 	char **record, *best_record = NULL, *p;
 	int priority, lowest_priority = INT_MAX;	
 
@@ -86,11 +98,16 @@ int lookup_mount(struct autofs_point *ap
 	chdir("/");		/* If this is not here the filesystem stays
 				   busy, for some reason... */
 
-	hes_result = hes_resolve(name, "filsys");
+	status = pthread_mutex_lock(&hesiod_mutex);
+	if (status)
+		fatal(status);
 
+	hes_result = hesiod_resolve(ctxt->hesiod_context, name, "filsys");
 	if (!hes_result || !hes_result[0]) {
+		/* Note: it is not clear to me how to distinguish between
+		 * the "no search results" case and other failures.  --JM */
 		warn(MODPREFIX "entry \"%s\" not found in map", name);
-		return NSS_STATUS_UNAVAIL;
+		return NSS_STATUS_NOTFOUND;
 	}
 
 	/* autofs doesn't support falling back to alternate records, so just
@@ -113,8 +130,21 @@ int lookup_mount(struct autofs_point *ap
 
 	rv = ctxt->parser->parse_mount(ap, name, name_len, best_record,
 				       ctxt->parser->context);
-	free(hes_result);
-	return rv;
+
+	hesiod_free_list(ctxt->hesiod_context, hes_result);
+
+	status = pthread_mutex_unlock(&hesiod_mutex);
+	if (status)
+		fatal(status);
+
+	/*
+	 * Unavailable due to error such as module load fail 
+	 * or out of memory, etc.
+	 */
+	if (rv == 1 || rv == -1)
+		return NSS_STATUS_UNAVAIL;
+
+	return NSS_STATUS_SUCCESS;
 }
 
 /* This destroys a context for queries to this module.  It releases the parser
@@ -123,6 +153,8 @@ int lookup_done(void *context)
 {
 	struct lookup_context *ctxt = (struct lookup_context *) context;
 	int rv = close_parse(ctxt->parser);
+
+	hesiod_end(ctxt->hesiod_context);
 	free(ctxt);
 	return rv;
 }
