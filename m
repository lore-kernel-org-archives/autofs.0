From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [ANNOUNCE] autofs 5.0.0 beta2
Date: Fri, 26 May 2006 18:56:47 -0400
Message-ID: <x49lksoz974.fsf@segfault.boston.redhat.com>
References: <Pine.LNX.4.64.0605091848390.12829@raven.themaw.net>
	<446251C5.5070407@inria.fr> <x49y7x12vml.fsf@redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49y7x12vml.fsf@redhat.com> (Jeff Moyer's message of "Tue, 16
	May 2006 23:11:30 -0400")
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
Content-Transfer-Encoding: 7bit
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs@linux.kernel.org, raven@themaw.net


Guillaume.Rousse> Third, the following patches still apply, but I got no
Guillaume.Rousse> clue about their usefulness: -

Guillaume.Rousse> autofs-4.1.0-hesiod-bind.patch

jmoyer> I'll do some digging on this one tomorrow.

OK, it took me a while longer than expected to get to this.  Sorry!

The hesiod resolve patch is wanted.  Actually, I think in v5 we can just
get rid of the old calls to hes_resolve.

If you look at the implementation that currently is there in lookup_hesiod.c,
it has some bugs.  It will free a pointer that the library will
subsequently try to free, and it also leaks memory.  This is, in part, due to
the horrible definition of the interface at the time, I believe.

At any rate, we should move to hesiod_init, hesiod_resolve, etc.  It's
probably best to check that the hesiod library supports the new interfaces
at configure time.  If not, just disable the building of the hesiod
modules.

Ian, let me know what you think of the attached patch.

Thanks!

Jeff

--- autofs-5.0.0_beta3/modules/lookup_hesiod.c.orig	2006-05-22 23:28:48.000000000 -0400
+++ autofs-5.0.0_beta3/modules/lookup_hesiod.c	2006-05-26 18:47:04.000000000 -0400
@@ -29,6 +29,7 @@
 
 struct lookup_context {
 	struct parse_mod *parser;
+	void *hesiod_context;
 };
 
 int lookup_version = AUTOFS_LOOKUP_VERSION;	/* Required by protocol */
@@ -51,6 +52,11 @@ int lookup_init(const char *mapfmt, int 
 	/* Initialize the resolver. */
 	res_init();
 
+	/* Initialize the hesiod context. */
+	if (hesiod_init(&(ctxt->hesiod_context)) != 0) {
+		crit(MODPREFIX "hesiod_init(): %m");
+		return 1;
+	}
 	/* If a map type isn't explicitly given, parse it as hesiod entries. */
 	if (!mapfmt)
 		mapfmt = MAPFMT_DEFAULT;
@@ -73,6 +79,11 @@ int lookup_read_map(struct autofs_point 
    record in hesiod.  If it's an AFS or NFS filesyste, parse it out.  If
    it's an ERR filesystem, it's an error message we should log.  Otherwise,
    assume it's something we know how to deal with already (generic). */
+/*
+ *  Note that the hesiod library functions are not thread-safe.  If there
+ *  is a chance of multiple simultaneous calls to lookup_mount, these
+ *  need to be serialized.  --JM
+ */
 int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *context)
 {
 	char **hes_result;
@@ -86,9 +97,10 @@ int lookup_mount(struct autofs_point *ap
 	chdir("/");		/* If this is not here the filesystem stays
 				   busy, for some reason... */
 
-	hes_result = hes_resolve(name, "filsys");
-
+	hes_result = hesiod_resolve(ctxt->hesiod_context, name, "filsys");
 	if (!hes_result || !hes_result[0]) {
+		/* Note: it is not clear to me how to distinguish between
+		 * the "no search results" case and other failures.  --JM */
 		warn(MODPREFIX "entry \"%s\" not found in map", name);
 		return NSS_STATUS_UNAVAIL;
 	}
@@ -111,9 +123,13 @@ int lookup_mount(struct autofs_point *ap
 
 	debug(MODPREFIX "lookup for \"%s\" gave \"%s\"", name, best_record);
 
+	/* The error code needs to be converted to an NSS_ code There are
+	 * several places we can get a failure returned.  0 is always
+	 * success, -1 or 1 could be failure.  */
 	rv = ctxt->parser->parse_mount(ap, name, name_len, best_record,
 				       ctxt->parser->context);
-	free(hes_result);
+	hesiod_free_list(ctxt->hesiod_context, hes_result);
+
 	return rv;
 }
 
@@ -123,6 +139,8 @@ int lookup_done(void *context)
 {
 	struct lookup_context *ctxt = (struct lookup_context *) context;
 	int rv = close_parse(ctxt->parser);
+
+	hesiod_end(ctxt->hesiod_context);
 	free(ctxt);
 	return rv;
 }
--- autofs-5.0.0_beta3/configure.in.orig	2006-05-26 16:54:52.000000000 -0400
+++ autofs-5.0.0_beta3/configure.in	2006-05-26 17:35:16.000000000 -0400
@@ -143,7 +143,7 @@ AC_ARG_WITH(hesiod,
 if test -z "$HAVE_HESIOD"
 then
 	HAVE_HESIOD=0
-	AC_CHECK_LIB(hesiod, hes_resolve, HAVE_HESIOD=1 LIBHESIOD="$LIBHESIOD -lhesiod", ,
+	AC_CHECK_LIB(hesiod, hesiod_resolve, HAVE_HESIOD=1 LIBHESIOD="$LIBHESIOD -lhesiod", ,
 		     $LIBRESOLV)
 	if test "$HAVE_HESIOD" == "1"; then
 		AC_DEFINE(WITH_HESIOD,1,
