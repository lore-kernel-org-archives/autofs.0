From: Jeff Moyer <jmoyer@redhat.com>
Subject: build warnings (and fixes)
Date: Mon, 18 Feb 2008 13:54:38 -0500
Message-ID: <x49skzq6qoh.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: raven@themaw.net
Cc: autofs@linux.kernel.org

Hi, Ian,

When building autofs with -D_FORTIFY_SOURCE=2, as is done in Fedora, the
following warnings appear:

lookup_hesiod.c:121: warning: ignoring return value of 'chdir', declared with attribute warn_unused_result

parse_hesiod.c:130: warning: call to __builtin___strncat_chk might overflow destination buffer

The former is pretty harmless, I think, but I made a patch to check the
return value anyway.  The latter may be worse, I'm not sure.  We always
pass in a buffer of size HESIOD_LEN+1.  HESIOD_LEN is defined to be 512
bytes, and I'm not sure whether or not that's a hard limit.  At any
rate, it's unlikely that a path over 512 bytes is configured, so I guess
that's why this bug hasn't been seen in the wild (that, or the fact that
hesiod is most often used with AFS file systems...).  Nevertheless, here's
a patch which addresses these issues.

I didn't do my usual diligence here;  I only build-tested these
changes.  Sorry for being lazy.

Cheers,

Jeff

p.s.  It seems I posted a patch which also adds -D_FORTIFY_SOURCE to the
modules/Makefile.  I'm going to leave that in there.  You can keep it or
not, it's up to you.  ;)

diff --git a/modules/Makefile b/modules/Makefile
index 0d12f01..299207c 100644
--- a/modules/Makefile
+++ b/modules/Makefile
@@ -47,7 +47,7 @@ ifeq ($(LDAP), 1)
   endif
 endif
 
-CFLAGS += -I../include -I../lib -fPIC -D_GNU_SOURCE
+CFLAGS += -I../include -I../lib -fPIC -D_GNU_SOURCE -D_FORTIFY_SOURCE=2
 CFLAGS += -DAUTOFS_LIB_DIR=\"$(autofslibdir)\"
 CFLAGS += -DAUTOFS_MAP_DIR=\"$(autofsmapdir)\"
 
diff --git a/modules/lookup_hesiod.c b/modules/lookup_hesiod.c
index 737a47e..5f48791 100644
--- a/modules/lookup_hesiod.c
+++ b/modules/lookup_hesiod.c
@@ -118,8 +118,13 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 	      MODPREFIX "looking up root=\"%s\", name=\"%s\"",
 	      ap->path, name);
 
-	chdir("/");		/* If this is not here the filesystem stays
+	rv = chdir("/");	/* If this is not here the filesystem stays
 				   busy, for some reason... */
+	if (rv != 0)
+		warn(ap->logopt,
+		     MODPREFIX
+		     "unable to change working directory to '/';  mount point "
+		     "%s may not expire as a result.", name);
 
 	status = pthread_mutex_lock(&hesiod_mutex);
 	if (status)
diff --git a/modules/parse_hesiod.c b/modules/parse_hesiod.c
index ff1f0a5..e07ab38 100644
--- a/modules/parse_hesiod.c
+++ b/modules/parse_hesiod.c
@@ -89,7 +89,7 @@ static int parse_nfs(struct autofs_point *ap,
 {
 	const char *p;
 	char mount[HESIOD_LEN + 1];
-	int i;
+	int i, ret;
 
 	p = filsysline;
 
@@ -126,8 +126,11 @@ static int parse_nfs(struct autofs_point *ap,
 	p += i;
 
 	/* Append ":mountpoint" to the source to get "host:mountpoint". */
-	strncat(source, ":", source_len);
-	strncat(source, mount, source_len);
+	ret = snprintf(&source[i], source_len, ":%s", mount);
+	if (ret >= source_len)
+		warn(ap->logopt,
+		     MODPREFIX
+		     "location string too long, truncated to: \"%s\"", source);
 
 	/* Skip whitespace. */
 	while ((*p) && (isspace(*p)))
