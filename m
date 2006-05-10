From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: [ANNOUNCE] autofs 5.0.0 beta2
Date: Wed, 10 May 2006 22:49:09 +0200
Message-ID: <446251C5.5070407@inria.fr>
References: <Pine.LNX.4.64.0605091848390.12829@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060803010508070208020802"
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605091848390.12829@raven.themaw.net>
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
To: autofs@linux.kernel.org

This is a multi-part message in MIME format.
--------------060803010508070208020802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ian Kent wrote:
> Hi all,
> 
> It's time for an updated beta.
> 
> autofs
> ======
> 
> The package can be found at:
> 
> ftp://ftp.kernel.org/pub/linux/daemons/autofs/v5
> 
> It is autofs-5.0.0_beta2.tar.[gz|bz2]
> 
> No source rpm is there as it can be produced by using:
> 
> rpmbuild -ts autofs-5.0.0_beta2.tar.gz
> 
> and the binary rpm by using:
> 
> rpmbuild -tb autofs-5.0.0_beta2.tar.gz
> 
> See the INSTALL file for information about configure options and
> kernel requirements.
I couldn't test it really yet, as mandriva development kernel is still
2.6.14, however here are a few remarks:

First, stripping binaries by default, especially during compilation, is
opposite behaviour of standard autotools-based procedure, where it only
occurs if you install with "make stripinstall". I need to have debug
symbols present when building a package, as they are automatically for
extracting them in a separate debug package. I've found that "make
DEBUG=1" would prevent stripping, but it also defines an additional
CFLAG with unknown result :/

Second, the two attached patches don't apply anymore:
- autofs-4.1.4-signal-race-fix.patch seems to refer to parts of
automount.c not existing anymore
- autofs-4.1.1-get-best-mount.patch refer to a 4 args get_best_mount()
function that only has 3 args nowadays

Third, the following patches still apply, but I got no clue about their
usefulness:
- autofs-4.1.0-hesiod-bind.patch
- autofs-4.1.0-loop.patch

I'd prefer to see those patches merged, rather than maintaining a
patched package.

--------------060803010508070208020802
Content-Type: text/plain;
 name="autofs-4.1.0-hesiod-bind.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="autofs-4.1.0-hesiod-bind.patch"

--- autofs-4.1.0/modules/lookup_hesiod.c.orig	2003-09-29 04:22:35.000000000 -0400
+++ autofs-4.1.0/modules/lookup_hesiod.c	2004-02-18 11:56:01.000000000 -0500
@@ -34,6 +34,9 @@
 
 struct lookup_context {
 	struct parse_mod *parser;
+#ifdef HESIOD_BIND
+	void *hesiod_context;
+#endif
 };
 
 int lookup_version = AUTOFS_LOOKUP_VERSION;	/* Required by protocol */
@@ -54,6 +57,13 @@ int lookup_init(const char *mapfmt, int 
 	/* Initialize the resolver. */
 	res_init();
 
+#ifdef HESIOD_BIND
+	/* Initialize the hesiod context. */
+	if (hesiod_init(&(ctxt->hesiod_context)) != 0) {
+		syslog(LOG_CRIT, MODPREFIX "hesiod_init(): %m");
+		return 1;
+	}
+#endif
 	/* If a map type isn't explicitly given, parse it as hesiod entries. */
 	if (!mapfmt)
 		mapfmt = MAPFMT_DEFAULT;
@@ -83,7 +93,11 @@ int lookup_mount(const char *root, const
 	chdir("/");		/* If this is not here the filesystem stays
 				   busy, for some reason... */
 
+#ifdef HESIOD_BIND
+	hes_result = hesiod_resolve(ctxt->hesiod_context, name, "filsys");
+#else
 	hes_result = hes_resolve(name, "filsys");
+#endif
 
 	if (!hes_result) {
 		syslog(LOG_NOTICE, MODPREFIX "entry \"%s\" not found in map\n", name);
@@ -94,7 +108,11 @@ int lookup_mount(const char *root, const
 		  name, hes_result[0]));
 	rv = ctxt->parser->parse_mount(root, name, name_len, hes_result[0],
 				       ctxt->parser->context);
+#ifdef HESIOD_BIND
+	hesiod_free_list(ctxt->hesiod_context, hes_result);
+#else
 	free(hes_result);
+#endif
 	return rv;
 }
 
@@ -104,6 +122,9 @@ int lookup_done(void *context)
 {
 	struct lookup_context *ctxt = (struct lookup_context *) context;
 	int rv = close_parse(ctxt->parser);
+#ifdef HESIOD_BIND
+	hesiod_end(ctxt->hesiod_context);
+#endif
 	free(ctxt);
 	return rv;
 }

--------------060803010508070208020802
Content-Type: text/plain;
 name="autofs-4.1.0-loop.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="autofs-4.1.0-loop.patch"

--- autofs-4.1.0/modules/mount_autofs.c.org	2004-02-18 12:04:40.000000000 -0500
+++ autofs-4.1.0/modules/mount_autofs.c	2004-02-18 12:05:37.000000000 -0500
@@ -95,12 +95,12 @@ int mount_mount(const char *root, const 
 	}
 
 	if (options) {
-		char *p = options;
+		char *p = options - 1;
 		do {
 			argc++;
 			if (*p == ',')
 				p++;
-		} while ((p = strchr(p, ',')) != NULL);
+		} while ((p = strchr(p + 1, ',')) != NULL);
 	}
 	argv = (char **) alloca((argc + 1) * sizeof(char *));
 

--------------060803010508070208020802
Content-Type: text/plain;
 name="autofs-4.1.1-get-best-mount.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="autofs-4.1.1-get-best-mount.patch"

--- autofs-4.1.2/modules/mount_nfs.c.orig	2004-04-14 12:02:29.917549312 -0400
+++ autofs-4.1.2/modules/mount_nfs.c	2004-04-14 12:02:40.815892512 -0400
@@ -378,7 +378,7 @@ int mount_mount(const char *root, const 
 		/* No colon, take this as a bind (local) entry */
 		local = 1;
 	} else if (!nosymlink) {
-		local = get_best_mount(whatstr, what, 0, 0);
+		local = get_best_mount(whatstr, what, 1, 0);
 		if (!*whatstr) {
 			warn(MODPREFIX "no host elected");
 			return 1;

--------------060803010508070208020802
Content-Type: text/plain;
 name="autofs-4.1.4-signal-race-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="autofs-4.1.4-signal-race-fix.patch"

--- autofs-4.1.3/daemon/automount.c.orig	2004-08-18 11:23:49.430470256 -0400
+++ autofs-4.1.3/daemon/automount.c	2004-08-18 11:24:45.047015256 -0400
@@ -919,8 +919,8 @@ static int st_expire(void)
 		return 1;
 
 	case EXP_STARTED:
-		ap.state = ST_EXPIRE;
 		sigprocmask(SIG_SETMASK, &ready_sigs, NULL);
+		ap.state = ST_EXPIRE;
 		return 0;
 	}
 	return 1;

--------------060803010508070208020802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------060803010508070208020802--

