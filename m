From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] factor out more duplicated code
Date: Tue, 01 Apr 2008 16:55:45 -0400
Message-ID: <x49k5jhe1m6.fsf@segfault.boston.devel.redhat.com>
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

Every time we open a file, we set the close on exec bit.  This will
hopefully make sure we don't forget to do that in the future.

Ian, this may or may not look good to you.  Feel free to ignore this
if you hate it.  ;)

Cheers,
Jeff

 modules/lookup_file.c |   70 +++++++++++++++++++------------------------------
 1 files changed, 27 insertions(+), 43 deletions(-)


diff --git a/modules/lookup_file.c b/modules/lookup_file.c
index 331f543..5c400dd 100644
--- a/modules/lookup_file.c
+++ b/modules/lookup_file.c
@@ -112,6 +112,23 @@ int lookup_init(const char *mapfmt, int argc, const char *const *argv, void **co
 	return 0;
 }
 
+static FILE *fopen_map(const char *mapname, const char *mode, unsigned logopt)
+{
+	FILE *f;
+	int fd;
+
+	f = fopen(mapname, "r");
+	if (!f) {
+		error(logopt,
+		      MODPREFIX "could not open map file %s", mapname);
+		return NULL;
+	}
+	fd = fileno(f);
+	set_cloexec(fd);
+
+	return f;
+}
+
 static int read_one(unsigned logopt, FILE *f, char *key, unsigned int *k_len, char *mapent, unsigned int *m_len)
 {
 	char *kptr, *p;
@@ -395,7 +412,6 @@ int lookup_read_master(struct master *master, time_t age, void *context)
 	char *ent;
 	struct stat st;
 	FILE *f;
-	int fd;
 	unsigned int path_len, ent_len;
 	int entry, cur_state;
 
@@ -422,17 +438,9 @@ int lookup_read_master(struct master *master, time_t age, void *context)
 		return NSS_STATUS_UNAVAIL;
 	}
 
-	f = fopen(ctxt->mapname, "r");
-	if (!f) {
-		error(logopt,
-		      MODPREFIX "could not open master map file %s",
-		      ctxt->mapname);
+	f = fopen_map(ctxt->mapname, "r", logopt);
+	if (!f)
 		return NSS_STATUS_UNAVAIL;
-	}
-
-	fd = fileno(f);
-
-	set_cloexec(fd);
 
 	while(1) {
 		entry = read_one(logopt, f, path, &path_len, ent, &ent_len);
@@ -503,7 +511,7 @@ int lookup_read_master(struct master *master, time_t age, void *context)
 			break;
 	}
 
-	if (fstat(fd, &st)) {
+	if (fstat(fileno(f), &st)) {
 		crit(logopt, MODPREFIX "file map %s, could not stat",
 		       ctxt->mapname);
 		return NSS_STATUS_UNAVAIL;
@@ -637,7 +645,6 @@ int lookup_read_map(struct autofs_point *ap, time_t age, void *context)
 	char *mapent;
 	struct stat st;
 	FILE *f;
-	int fd;
 	unsigned int k_len, m_len;
 	int entry;
 
@@ -670,16 +677,9 @@ int lookup_read_map(struct autofs_point *ap, time_t age, void *context)
 		return NSS_STATUS_UNAVAIL;
 	}
 
-	f = fopen(ctxt->mapname, "r");
-	if (!f) {
-		error(ap->logopt,
-		      MODPREFIX "could not open map file %s", ctxt->mapname);
+	f = fopen_map(ctxt->mapname, "r", ap->logopt);
+	if (!f)
 		return NSS_STATUS_UNAVAIL;
-	}
-
-	fd = fileno(f);
-
-	set_cloexec(fd);
 
 	while(1) {
 		entry = read_one(ap->logopt, f, key, &k_len, mapent, &m_len);
@@ -743,7 +743,7 @@ int lookup_read_map(struct autofs_point *ap, time_t age, void *context)
 			break;
 	}
 
-	if (fstat(fd, &st)) {
+	if (fstat(fileno(f), &st)) {
 		crit(ap->logopt,
 		     MODPREFIX "file map %s, could not stat",
 		     ctxt->mapname);
@@ -767,7 +767,6 @@ static int lookup_one(struct autofs_point *ap,
 	char mapent[MAPENT_MAX_LEN + 1];
 	time_t age = time(NULL);
 	FILE *f;
-	int fd;
 	unsigned int k_len, m_len;
 	int entry, ret;
 
@@ -777,16 +776,9 @@ static int lookup_one(struct autofs_point *ap,
 
 	mc = source->mc;
 
-	f = fopen(ctxt->mapname, "r");
-	if (!f) {
-		error(ap->logopt,
-		      MODPREFIX "could not open map file %s", ctxt->mapname);
+	f = fopen_map(ctxt->mapname, "r", ap->logopt);
+	if (!f)
 		return CHE_FAIL;
-	}
-
-	fd = fileno(f);
-
-	set_cloexec(fd);
 
 	while(1) {
 		entry = read_one(ap->logopt, f, mkey, &k_len, mapent, &m_len);
@@ -877,7 +869,6 @@ static int lookup_wild(struct autofs_point *ap, struct lookup_context *ctxt)
 	char mapent[MAPENT_MAX_LEN + 1];
 	time_t age = time(NULL);
 	FILE *f;
-	int fd;
 	unsigned int k_len, m_len;
 	int entry, ret;
 
@@ -887,16 +878,9 @@ static int lookup_wild(struct autofs_point *ap, struct lookup_context *ctxt)
 
 	mc = source->mc;
 
-	f = fopen(ctxt->mapname, "r");
-	if (!f) {
-		error(ap->logopt,
-		      MODPREFIX "could not open map file %s", ctxt->mapname);
+	f = fopen_map(ctxt->mapname, "r", ap->logopt);
+	if (!f)
 		return CHE_FAIL;
-	}
-
-	fd = fileno(f);
-
-	set_cloexec(fd);
 
 	while(1) {
 		entry = read_one(ap->logopt, f, mkey, &k_len, mapent, &m_len);
