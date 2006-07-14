From: "Daniel Richard G." <skunk@iskunk.org>
Subject: Code cleanup
Date: Thu, 13 Jul 2006 23:58:58 -0400
Message-ID: <20060714035857.GM29064@mail.iSKUNK.ORG>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="d9ADC0YsG2v16Js0"
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


--d9ADC0YsG2v16Js0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello hello,

First off, is there a public CVS/SVN repository for autofs?

I grabbed the -rc1 tarball, figured I'd try building it with my usual devel 
CFLAGS, and... wow. This code's got _issues_, maaan....

See the attached omnibus patch. Commentary follows, in patch order (more or 
less). Of course, not all these changes need to go in as-is, but they 
should at least bring attention to some spots that could really use it.


(various files):

* Don't use "#if WITH_FOO", as this produces a warning if WITH_FOO is 
  undefined. Use "#ifdef".

daemon/automount.c:

* 'mc' is used many times as a local variable in this file; rename the 
  global instance to 'mrc' to avoid gratuitous shadowing

* 'mrc' (nee 'mc') is not needed outside of this file; declare as static

* Two fields in struct master_readmap_cond were not specified in the 
  initializer for 'mrc' (nee 'mc')

* 'sc' is used many times as a local variable in this file; rename the 
  global instance to 'suc' to avoid gratuitous shadowing

include/automount.h:

* Disable the OpenBSD syslog.h #include with a cpp conditional, not a 
  comment. This is a bit safer.

* The "extern struct master_readmap_cond mc" declaration is not used

include/lookup_ldap.h:

* Added appropriate WITH_KERBEROS and WITH_SASL cpp conditionals, to avoid 
  breakage when the respective libraries are not used.

  (Note: WITH_KERBEROS is a new conditional; support for it needs to be 
  added to the configure script)

* Comment the #endifs if the opening #ifdef is far away

include/state.h:

* Removed a superfluous comma

lib/cache.c:

* Eliminated "implicit cast to unsigned type" warnings

lib/cat_path.c:

* Tweaked the _strlen() function: Eliminated the unnecessary de-consting 
  cast, and rewrote the logic w.r.t. 'max' (this is unsigned, therefore the 
  max<0 check is pointless; it's not nice to modify your arguments; pointer 
  arithmetic sucks)
  
  P.S.: _strlen() should really have a return type of size_t, but I didn't 
  care enough to change this.

lib/master.c:

* Eliminated a stray semicolon

* Straightened out some unnecessary variable const-ness

lib/master_parse.y:

* #define YYENABLE_NLS and YYLTYPE_IS_TRIVIAL to zero; #ifdefs with these 
  appear in the generated code, and you get warnings if they are not 
  defined

lib/mounts.c:

* m_dev and m_ino are 'long unsigned int' values, so cast them to avoid 
  sscanf() format warnings

lib/nss_parse.y:

* Same deal with YYENABLE_NLS and YYLTYPE_IS_TRIVIAL

* Aaaarg! C++ comments in C code! Kill 'em! Kill 'em!

lib/rpc_subs.c:

* You don't want to use a local variable named 'h_errno'.

	fusion:/tmp$ grep h_errno /usr/include/netdb.h
	   We use a macro to access always the thread-specific `h_errno' variable. */
	#define h_errno (*__h_errno_location ())
	...

  (There were some places that used h_errno without declaring it locally. 
  I'm assuming that nowhere was this meant to refer to the global netdb.h 
  h_errno variable.)

modules/lookup_file.c:
modules/lookup_hosts.c

* What first caught my attention here was a warning that me->mapent is 
  being passed in as a format string to sprintf() without further arguments 
  (lots of fun if there's a "%s" in there somewhere), but that line and the 
  one before seemed a bit bizarrely written to me. (You call strlen() on a 
  string, then use sprintf() as an unsafe strcpy() replacement, and grab 
  the return value to get the length of that same string??) Replaced with 
  something more straightforward.

lookup_ldap.c:

* What the heck is '?:' supposed to return if the expression is true? (Not 
  valid C90, at any rate)

* My OpenLDAP 2.1.30 header does not define LDAP_SCOPE_ONE. It does,
  however, define LDAP_SCOPE_ONELEVEL.

* 'struct mapent me' is unused

* More mapent/mapent_len silliness

modules/mount_nfs.c:

* This looks like a bug to me. Does it look like a bug to you?

modules/replicated.c:

* You don't want to use a local variable named h_addr, either.

	fusion:/tmp$ grep h_addr /usr/include/netdb.h
	  int h_addrtype;               /* Host address type.  */
	  char **h_addr_list;           /* List of addresses from name server. */
	#define h_addr  h_addr_list[0]  /* Address, for backward compatibility. */


There's still a ton of warnings, mostly of variables shadowing other 
variables, but those affect code clarity more so than correctness.


--Daniel


-- 
NAME   = Daniel Richard G.       ##  Remember, skunks       _\|/_  meef?
EMAIL1 = skunk@iskunk.org        ##  don't smell bad---    (/o|o\) /
EMAIL2 = skunk@alum.mit.edu      ##  it's the people who   < (^),>
WWW    = http://www.******.org/  ##  annoy them that do!    /   \
--
(****** = site not yet online)

--d9ADC0YsG2v16Js0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="autofs5-fixups.patch"

diff -ru autofs-5.0.1/daemon/automount.c autofs-5.0.1-patched/daemon/automount.c
--- autofs-5.0.1/daemon/automount.c	2006-07-13 04:11:38.000000000 -0400
+++ autofs-5.0.1-patched/daemon/automount.c	2006-07-13 15:10:28.000000000 -0400
@@ -54,10 +54,10 @@
 /* Attribute to create detached thread */
 pthread_attr_t thread_attr;
 
-struct master_readmap_cond mc = {
-	PTHREAD_MUTEX_INITIALIZER, PTHREAD_COND_INITIALIZER, 0, NULL, 0, 0};
+static struct master_readmap_cond mrc = {
+	PTHREAD_MUTEX_INITIALIZER, PTHREAD_COND_INITIALIZER, 0, NULL, 0, 0, 0, 0};
 
-struct startup_cond sc = {
+struct startup_cond suc = {
 	PTHREAD_MUTEX_INITIALIZER, PTHREAD_COND_INITIALIZER, 0, 0};
 
 pthread_key_t key_thread_stdenv_vars;
@@ -929,7 +929,7 @@
 {
 	int status;
 
-	status = pthread_mutex_unlock(&mc.mutex);
+	status = pthread_mutex_unlock(&mrc.mutex);
 	if (status)
 		fatal(status);
 
@@ -944,26 +944,26 @@
 
 	sig = *(int *) arg;
 
-	status = pthread_mutex_lock(&mc.mutex);
+	status = pthread_mutex_lock(&mrc.mutex);
 	if (status)
 		fatal(status);
 
-	master = mc.master;
+	master = mrc.master;
 
 	debug(master->default_logging, "signal %d", sig);
 
-	mc.signaled = 1;
-	status = pthread_cond_signal(&mc.cond);
+	mrc.signaled = 1;
+	status = pthread_cond_signal(&mrc.cond);
 	if (status) {
 		error(master->default_logging,
 		      "failed to signal state notify condition");
-		status = pthread_mutex_unlock(&mc.mutex);
+		status = pthread_mutex_unlock(&mrc.mutex);
 		if (status)
 			fatal(status);
 		pthread_exit(NULL);
 	}
 
-	status = pthread_mutex_unlock(&mc.mutex);
+	status = pthread_mutex_unlock(&mrc.mutex);
 	if (status)
 		fatal(status);
 
@@ -978,7 +978,7 @@
 	int sig = signal;
 	int status;
 
-	status = pthread_mutex_lock(&mc.mutex);
+	status = pthread_mutex_lock(&mrc.mutex);
 	if (status)
 		fatal(status);
 
@@ -986,20 +986,20 @@
 	if (status) {
 		error(master->default_logging,
 		      "mount state notify thread create failed");
-		status = pthread_mutex_unlock(&mc.mutex);
+		status = pthread_mutex_unlock(&mrc.mutex);
 		if (status)
 			fatal(status);
 		return 0;
 	}
 
-	mc.thid = thid;
-	mc.master = master;
+	mrc.thid = thid;
+	mrc.master = master;
 
 	pthread_cleanup_push(do_master_cleanup_unlock, NULL);
 
-	mc.signaled = 0;
-	while (!mc.signaled) {
-		status = pthread_cond_wait(&mc.cond, &mc.mutex);
+	mrc.signaled = 0;
+	while (!mrc.signaled) {
+		status = pthread_cond_wait(&mrc.cond, &mrc.mutex);
 		if (status)
 			fatal(status);
 	}
@@ -1016,25 +1016,25 @@
 	int readall = 1;
 	int status;
 
-	status = pthread_mutex_lock(&mc.mutex);
+	status = pthread_mutex_lock(&mrc.mutex);
 	if (status)
 		fatal(status);
 
-	master = mc.master;
-	age = mc.age;
+	master = mrc.master;
+	age = mrc.age;
 
-	mc.signaled = 1;
-	status = pthread_cond_signal(&mc.cond);
+	mrc.signaled = 1;
+	status = pthread_cond_signal(&mrc.cond);
 	if (status) {
 		error(master->default_logging,
 		      "failed to signal master read map condition");
-		status = pthread_mutex_unlock(&mc.mutex);
+		status = pthread_mutex_unlock(&mrc.mutex);
 		if (status)
 			fatal(status);
 		pthread_exit(NULL);
 	}
 
-	status = pthread_mutex_unlock(&mc.mutex);
+	status = pthread_mutex_unlock(&mrc.mutex);
 	if (status)
 		fatal(status);
 
@@ -1048,7 +1048,7 @@
 	pthread_t thid;
 	int status;
 
-	status = pthread_mutex_lock(&mc.mutex);
+	status = pthread_mutex_lock(&mrc.mutex);
 	if (status)
 		fatal(status);
 
@@ -1056,21 +1056,21 @@
 	if (status) {
 		error(master->default_logging,
 		      "master read map thread create failed");
-		status = pthread_mutex_unlock(&mc.mutex);
+		status = pthread_mutex_unlock(&mrc.mutex);
 		if (status)
 			fatal(status);
 		return 0;
 	}
 
-	mc.thid = thid;
-	mc.master = master;
-	mc.age = age;
+	mrc.thid = thid;
+	mrc.master = master;
+	mrc.age = age;
 
 	pthread_cleanup_push(do_master_cleanup_unlock, NULL);
 
-	mc.signaled = 0;
-	while (!mc.signaled) {
-		status = pthread_cond_wait(&mc.cond, &mc.mutex);
+	mrc.signaled = 0;
+	while (!mrc.signaled) {
+		status = pthread_cond_wait(&mrc.cond, &mrc.mutex);
 		if (status)
 			fatal(status);
 	}
@@ -1236,14 +1236,14 @@
 
 	ap = (struct autofs_point *) arg;
 
-	pthread_cleanup_push(return_start_status, &sc);
+	pthread_cleanup_push(return_start_status, &suc);
 	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &cancel_state);
 
 	status = pthread_mutex_lock(&ap->state_mutex);
 	if (status)
 		fatal(status);
 
-	status = pthread_mutex_lock(&sc.mutex);
+	status = pthread_mutex_lock(&suc.mutex);
 	if (status) {
 		crit(ap->logopt, "failed to lock startup condition mutex!");
 		fatal(status);
@@ -1251,7 +1251,7 @@
 
 	if (mount_autofs(ap) < 0) {
 		crit(ap->logopt, "mount of %s failed!", ap->path);
-		sc.status = 1;
+		suc.status = 1;
 		status = pthread_mutex_unlock(&ap->state_mutex);
 		if (status)
 			fatal(status);
@@ -1262,7 +1262,7 @@
 	if (ap->ghost && ap->type != LKP_DIRECT)
 		msg("ghosting enabled");
 
-	sc.status = 0;
+	suc.status = 0;
 	pthread_cleanup_pop(1);
 
 	/* We often start several automounters at the same time.  Add some
diff -ru autofs-5.0.1/include/automount.h autofs-5.0.1-patched/include/automount.h
--- autofs-5.0.1/include/automount.h	2006-07-13 04:11:38.000000000 -0400
+++ autofs-5.0.1-patched/include/automount.h	2006-07-13 15:31:34.000000000 -0400
@@ -30,13 +30,14 @@
 #include "log.h"
 #include "rpc_subs.h"
 
-#if WITH_DMALLOC
+#ifdef WITH_DMALLOC
 #include <dmalloc.h>
 #endif
 
-/* OpenBSD re-entrant syslog
+/* OpenBSD re-entrant syslog */
+#if 0
 #include "syslog.h"
-*/
+#endif
 
 #define ENABLE_CORES	1
 
@@ -379,8 +380,6 @@
 	unsigned int busy;	 /* Map read in progress. */
 };
 
-extern struct master_readmap_cond mc;
-
 struct pending_args {
 	pthread_mutex_t mutex;
 	pthread_cond_t  cond;
diff -ru autofs-5.0.1/include/lookup_ldap.h autofs-5.0.1-patched/include/lookup_ldap.h
--- autofs-5.0.1/include/lookup_ldap.h	2006-07-13 04:11:38.000000000 -0400
+++ autofs-5.0.1-patched/include/lookup_ldap.h	2006-07-13 12:50:30.000000000 -0400
@@ -1,7 +1,7 @@
 #ifndef LOOKUP_LDAP_H
 #define LOOKUP_LDAP_H
 
-#if WITH_SASL
+#ifdef WITH_SASL
 #include <openssl/ssl.h>
 #include <openssl/evp.h>
 #include <openssl/err.h>
@@ -37,17 +37,21 @@
 	char        *client_princ;
 	int          kinit_done;
 	int          kinit_successful;
+#ifdef WITH_KERBEROS
 	krb5_principal  krb5_client_princ;
 	krb5_context krb5ctxt;
 	krb5_ccache  krb5_ccache;
+#endif
+#ifdef WITH_SASL
 	sasl_conn_t  *sasl_conn;
+#endif
 	/* keytab file name needs to be added */
 
 	struct parse_mod *parse;
 };
 
 
-#if WITH_SASL
+#ifdef WITH_SASL
 #define LDAP_AUTH_CONF_FILE "test"
 
 #define LDAP_TLS_DONT_USE	0
@@ -68,6 +72,6 @@
 int autofs_sasl_init(LDAP *ldap, struct lookup_context *ctxt);
 int autofs_sasl_bind(LDAP *ldap, struct lookup_context *ctxt);
 void autofs_sasl_unbind(struct lookup_context *ctxt);
-#endif
+#endif /* WITH_SASL */
 
 #endif /* _lookup_ldap_h */
diff -ru autofs-5.0.1/include/state.h autofs-5.0.1-patched/include/state.h
--- autofs-5.0.1/include/state.h	2006-07-13 04:11:38.000000000 -0400
+++ autofs-5.0.1-patched/include/state.h	2006-07-13 13:24:30.000000000 -0400
@@ -47,7 +47,7 @@
 	ST_READMAP,
 	ST_SHUTDOWN_PENDING,
 	ST_SHUTDOWN_FORCE,
-	ST_SHUTDOWN,
+	ST_SHUTDOWN
 };
 
 struct expire_args {
diff -ru autofs-5.0.1/lib/cache.c autofs-5.0.1-patched/lib/cache.c
--- autofs-5.0.1/lib/cache.c	2006-07-13 04:11:38.000000000 -0400
+++ autofs-5.0.1-patched/lib/cache.c	2006-07-13 14:25:17.000000000 -0400
@@ -414,8 +414,8 @@
 	INIT_LIST_HEAD(&me->multi_list);
 	me->multi = NULL;
 	me->ioctlfd = -1;
-	me->dev = -1;
-	me->ino = -1;
+	me->dev = (dev_t)-1;
+	me->ino = (ino_t)-1;
 
 	/* 
 	 * We need to add to the end if values exist in order to
diff -ru autofs-5.0.1/lib/cat_path.c autofs-5.0.1-patched/lib/cat_path.c
--- autofs-5.0.1/lib/cat_path.c	2006-07-13 04:11:38.000000000 -0400
+++ autofs-5.0.1-patched/lib/cat_path.c	2006-07-13 15:15:14.000000000 -0400
@@ -60,14 +60,13 @@
 
 int _strlen(const char *str, size_t max)
 {
-	char *s = (char *) str;
+	const char *s = str;
+	size_t len = 0;
 
-	while (*s++ && max--) ;
+	while (*s++ && len < max)
+		len++;
 
-	if (max < 0)
-		return 0;
-	
-	return s - str - 1;
+	return (int) len;
 }
 
 /* 
diff -ru autofs-5.0.1/lib/master.c autofs-5.0.1-patched/lib/master.c
--- autofs-5.0.1/lib/master.c	2006-07-13 04:11:39.000000000 -0400
+++ autofs-5.0.1-patched/lib/master.c	2006-07-13 15:16:45.000000000 -0400
@@ -34,7 +34,7 @@
 /* Attribute to create detached thread */
 extern pthread_attr_t thread_attr;
 
-extern struct startup_cond sc;
+extern struct startup_cond suc;
 
 static struct map_source *
 __master_find_map_source(struct master_mapent *,
@@ -361,7 +361,7 @@
 struct map_source *master_find_source_instance(struct map_source *source, const char *type, const char *format, int argc, const char **argv)
 {
 	struct map_source *map;
-	struct map_source *instance = NULL;;
+	struct map_source *instance = NULL;
 	int status, res;
 
 	status = pthread_mutex_lock(&instance_mutex);
@@ -657,14 +657,14 @@
 struct master *master_new(const char *name, unsigned int timeout, unsigned int ghost)
 {
 	struct master *master;
-	const char *tmp;
+	char *tmp;
 
 	master = malloc(sizeof(struct master));
 	if (!master)
 		return NULL;
 
 	if (!name)
-		tmp = defaults_get_master_map();
+		tmp = (char *) defaults_get_master_map();
 	else
 		tmp = strdup(name);
 
@@ -838,12 +838,12 @@
 	pthread_t thid;
 	int status;
 
-	status = pthread_mutex_lock(&sc.mutex);
+	status = pthread_mutex_lock(&suc.mutex);
 	if (status)
 		fatal(status);
 
-	sc.done = 0;
-	sc.status = 0;
+	suc.done = 0;
+	suc.status = 0;
 
 	ap = entry->ap;
 
@@ -853,28 +853,28 @@
 		crit(ap->logopt,
 		     "failed to create mount handler thread for %s",
 		     entry->path);
-		status = pthread_mutex_unlock(&sc.mutex);
+		status = pthread_mutex_unlock(&suc.mutex);
 		if (status)
 			fatal(status);
 		return 0;
 	}
 	entry->thid = thid;
 
-	while (!sc.done) {
-		status = pthread_cond_wait(&sc.cond, &sc.mutex);
+	while (!suc.done) {
+		status = pthread_cond_wait(&suc.cond, &suc.mutex);
 		if (status)
 			fatal(status);
 	}
 
-	if (sc.status) {
+	if (suc.status) {
 		error(ap->logopt, "failed to startup mount");
-		status = pthread_mutex_unlock(&sc.mutex);
+		status = pthread_mutex_unlock(&suc.mutex);
 		if (status)
 			fatal(status);
 		return 0;
 	}
 
-	status = pthread_mutex_unlock(&sc.mutex);
+	status = pthread_mutex_unlock(&suc.mutex);
 	if (status)
 		fatal(status);
 
diff -ru autofs-5.0.1/lib/master_parse.y autofs-5.0.1-patched/lib/master_parse.y
--- autofs-5.0.1/lib/master_parse.y	2006-07-13 04:11:39.000000000 -0400
+++ autofs-5.0.1-patched/lib/master_parse.y	2006-07-13 12:57:45.000000000 -0400
@@ -62,6 +62,8 @@
 static int lineno;
 
 #define YYDEBUG 0
+#define YYENABLE_NLS 0
+#define YYLTYPE_IS_TRIVIAL 0
 
 #if YYDEBUG
 static int master_fprintf(FILE *, char *, ...);
diff -ru autofs-5.0.1/lib/mounts.c autofs-5.0.1-patched/lib/mounts.c
--- autofs-5.0.1/lib/mounts.c	2006-07-13 04:11:39.000000000 -0400
+++ autofs-5.0.1-patched/lib/mounts.c	2006-07-13 14:42:26.000000000 -0400
@@ -357,14 +357,14 @@
 		p_dev = strstr(mnt->mnt_opts, "dev=");
 		if (!p_dev)
 			continue;
-		sscanf(p_dev, "dev=%ld", &m_dev);
+		sscanf(p_dev, "dev=%ld", (long int *) &m_dev);
 		if (m_dev != l_dev)
 			continue;
 
 		p_ino = strstr(mnt->mnt_opts, "ino=");
 		if (!p_ino)
 			continue;
-		sscanf(p_ino, "ino=%ld", &m_ino);
+		sscanf(p_ino, "ino=%ld", (long int *) &m_ino);
 		if (m_ino == l_ino) {
 			path = strdup(mnt->mnt_dir);
 			break;
diff -ru autofs-5.0.1/lib/nss_parse.y autofs-5.0.1-patched/lib/nss_parse.y
--- autofs-5.0.1/lib/nss_parse.y	2006-07-13 04:11:39.000000000 -0400
+++ autofs-5.0.1-patched/lib/nss_parse.y	2006-07-13 15:19:46.000000000 -0400
@@ -36,6 +36,8 @@
 struct nss_action act[NSS_STATUS_MAX];
 
 #define YYDEBUG 0
+#define YYENABLE_NLS 0
+#define YYLTYPE_IS_TRIVIAL 0
 
 extern int nss_lineno;
 extern int nss_lex(void);
@@ -72,13 +74,13 @@
 
 nss_source: SOURCE
 {
-//	printf("source: %s\n", $1);
+/*	printf("source: %s\n", $1); */
 	src = add_source(nss_list, $1);
 } | SOURCE LBRACKET status_exp_list RBRACKET
 {
 	enum nsswitch_status a;
 
-//	printf("source: %s\n", $1);
+/*	printf("source: %s\n", $1); */
 	src = add_source(nss_list, $1);
 	for (a = 0; a < NSS_STATUS_MAX; a++) {
 		if (act[a].action != NSS_ACTION_UNKNOWN) {
@@ -98,11 +100,11 @@
 
 status_exp: STATUS EQUAL ACTION
 {
-//	printf("action: [ %s=%s ]\n", $1, $3);
+/*	printf("action: [ %s=%s ]\n", $1, $3); */
 	set_action(act, $1, $3, 0);
 } | BANG STATUS EQUAL ACTION
 {
-//	printf("action: [ ! %s=%s ]\n", $2, $4);
+/*	printf("action: [ ! %s=%s ]\n", $2, $4); */
 	set_action(act, $2, $4, 1);
 } | STATUS EQUAL OTHER {nss_error($3); YYABORT; }
   | STATUS OTHER {nss_error($2); YYABORT; }
diff -ru autofs-5.0.1/lib/rpc_subs.c autofs-5.0.1-patched/lib/rpc_subs.c
--- autofs-5.0.1/lib/rpc_subs.c	2006-07-13 04:11:39.000000000 -0400
+++ autofs-5.0.1-patched/lib/rpc_subs.c	2006-07-13 14:48:49.000000000 -0400
@@ -46,7 +46,7 @@
  */
 static CLIENT *create_udp_client(struct conn_info *info)
 {
-	int fd, ret, h_errno;
+	int fd, ret, h_err;
 	CLIENT *client;
 	struct sockaddr_in laddr, raddr;
 	struct hostent hp;
@@ -78,9 +78,9 @@
 	memset(&hp, 0, sizeof(struct hostent));
 
 	ret = gethostbyname_r(info->host, php,
-			buf, HOST_ENT_BUF_SIZE, &result, &h_errno);
+			buf, HOST_ENT_BUF_SIZE, &result, &h_err);
 	if (ret || !result) {
-		int err = h_errno == -1 ? errno : h_errno;
+		int err = h_err == -1 ? errno : h_err;
 		char *estr = strerror_r(err, buf, HOST_ENT_BUF_SIZE);
 		error(LOGOPT_ANY, "hostname lookup failed: %s", estr);
 		return NULL;
@@ -241,7 +241,7 @@
 	struct hostent *php = &hp;
 	struct hostent *result;
 	char buf[HOST_ENT_BUF_SIZE];
-	int ret;
+	int h_err, ret;
 
 	if (info->proto->p_proto != IPPROTO_TCP)
 		return NULL;
@@ -266,9 +266,9 @@
 	memset(&hp, 0, sizeof(struct hostent));
 
 	ret = gethostbyname_r(info->host, php,
-			buf, HOST_ENT_BUF_SIZE, &result, &h_errno);
+			buf, HOST_ENT_BUF_SIZE, &result, &h_err);
 	if (ret || !result) {
-		int err = h_errno == -1 ? errno : h_errno;
+		int err = h_err == -1 ? errno : h_err;
 		char *estr =  strerror_r(err, buf, HOST_ENT_BUF_SIZE);
 		error(LOGOPT_ANY, "hostname lookup failed: %s", estr);
 		return NULL;
@@ -720,13 +720,13 @@
 	struct hostent *result;
 	char buf[HOST_ENT_BUF_SIZE], **haddr;
 	struct sockaddr_in saddr, maddr;
-	int h_errno, ret;
+	int h_err, ret;
 
 	memset(buf, 0, HOST_ENT_BUF_SIZE);
 	memset(&he, 0, sizeof(struct hostent));
 
 	ret = gethostbyname_r(myname, phe,
-			buf, HOST_ENT_BUF_SIZE, &result, &h_errno);
+			buf, HOST_ENT_BUF_SIZE, &result, &h_err);
 	if (ret || !result)
 		return 0;
 
@@ -739,7 +739,7 @@
 		if (!ret)
 			return 0;
 	} else {
-		uint32_t m = -1;
+		uint32_t m = (uint32_t)-1;
 		int msize = atoi(mask);
 
 		m = m << (32 - msize);
@@ -836,13 +836,13 @@
 	struct hostent *phe = &he;
 	struct hostent *result;
 	char buf[HOST_ENT_BUF_SIZE];
-	int ret;
+	int h_err, ret;
 
 	memset(buf, 0, HOST_ENT_BUF_SIZE);
 	memset(&he, 0, sizeof(struct hostent));
 
 	ret = gethostbyname_r(myname, phe,
-			buf, HOST_ENT_BUF_SIZE, &result, &h_errno);
+			buf, HOST_ENT_BUF_SIZE, &result, &h_err);
 	if (ret || !result)
 		return 0;
 
diff -ru autofs-5.0.1/modules/lookup_file.c autofs-5.0.1-patched/modules/lookup_file.c
--- autofs-5.0.1/modules/lookup_file.c	2006-07-13 04:11:39.000000000 -0400
+++ autofs-5.0.1-patched/modules/lookup_file.c	2006-07-13 14:36:41.000000000 -0400
@@ -942,8 +942,9 @@
 	me = cache_lookup(mc, key);
 	if (me) {
 		pthread_cleanup_push(cache_lock_cleanup, mc);
-		mapent = alloca(strlen(me->mapent) + 1);
-		mapent_len = sprintf(mapent, me->mapent);
+		mapent_len = strlen(me->mapent);
+		mapent = alloca(mapent_len + 1);
+		strcpy(mapent, me->mapent);
 		pthread_cleanup_pop(0);
 		mapent[mapent_len] = '\0';
 	}
diff -ru autofs-5.0.1/modules/lookup_hosts.c autofs-5.0.1-patched/modules/lookup_hosts.c
--- autofs-5.0.1/modules/lookup_hosts.c	2006-07-13 04:11:39.000000000 -0400
+++ autofs-5.0.1-patched/modules/lookup_hosts.c	2006-07-13 14:37:31.000000000 -0400
@@ -157,8 +157,9 @@
 	 */
 	if (*name == '/') {
 		pthread_cleanup_push(cache_lock_cleanup, mc);
-		mapent = alloca(strlen(me->mapent) + 1);
-		mapent_len = sprintf(mapent, me->mapent);
+		mapent_len = strlen(me->mapent);
+		mapent = alloca(mapent_len + 1);
+		strcpy(mapent, me->mapent);
 		pthread_cleanup_pop(0);
 		mapent[mapent_len] = '\0';
 	}
diff -ru autofs-5.0.1/modules/lookup_ldap.c autofs-5.0.1-patched/modules/lookup_ldap.c
--- autofs-5.0.1/modules/lookup_ldap.c	2006-07-13 04:11:39.000000000 -0400
+++ autofs-5.0.1-patched/modules/lookup_ldap.c	2006-07-13 15:18:52.000000000 -0400
@@ -55,7 +55,7 @@
 	if (rv != LDAP_SUCCESS) {
 		crit(LOGOPT_ANY,
 		     MODPREFIX "Unable to bind to the LDAP server: "
-		     "%s, error %s", ctxt->server ?: "(default)",
+		     "%s, error %s", ctxt->server ? "" : "(default)",
 		     ldap_err2string(rv));
 		return -1;
 	}
@@ -67,7 +67,7 @@
 {
 	int rv;
 
-#if WITH_SASL
+#ifdef WITH_SASL
 	debug(LOGOPT_NONE, "use_tls: %d", ctxt->use_tls);
 	/*
 	 * The OpenSSL library can't handle having its message and error
@@ -82,7 +82,7 @@
 		ctxt->use_tls = LDAP_TLS_INIT;
 	}
 	autofs_sasl_unbind(ctxt);
-#endif
+#endif /* WITH_SASL */
 
 	rv = ldap_unbind_ext(ldap, NULL, NULL);
 	if (rv != LDAP_SUCCESS)
@@ -135,7 +135,7 @@
 		     MODPREFIX "failed to set connection timeout to %d",
 		     timeout);
 
-#if WITH_SASL
+#ifdef WITH_SASL
 	if (ctxt->use_tls) {
 		if (ctxt->version == 2) {
 			if (ctxt->tls_required) {
@@ -166,7 +166,7 @@
 		}
 		ctxt->use_tls = LDAP_TLS_RELEASE;
 	}
-#endif
+#endif /* WITH_SASL */
 
 	return ldap;
 }
@@ -180,7 +180,7 @@
 	if (!ldap)
 		return NULL;
 
-#if WITH_SASL
+#ifdef WITH_SASL
 	debug(LOGOPT_NONE, "auth_required: %d, sasl_mech %s",
 	      ctxt->auth_required, ctxt->sasl_mech);
 
@@ -194,10 +194,10 @@
 		debug(LOGOPT_NONE,
 		      MODPREFIX "ldap anonymous bind returned %d", rv);
 	}
-#else
+#else /* not WITH_SASL */
 	rv = bind_ldap_anonymous(ldap, ctxt);
 	debug(LOGOPT_NONE, MODPREFIX "ldap anonymous bind returned %d", rv);
-#endif
+#endif /* not WITH_SASL */
 
 	if (rv != 0) {
 		unbind_ldap_connection(ldap, ctxt);
@@ -207,7 +207,7 @@
 	return ldap;
 }
 
-#if WITH_SASL
+#ifdef WITH_SASL
 int get_property(xmlNodePtr node, const char *prop, char **value)
 {
 	xmlChar *ret;
@@ -544,7 +544,7 @@
 
 	return 0;
 }
-#endif
+#endif /* WITH_SASL */
 
 /*
  *  Take an input string as specified in the master map, and break it
@@ -802,7 +802,7 @@
 			      MODPREFIX "error forming query string");
 			return 0;
 		}
-		scope = LDAP_SCOPE_ONE;
+		scope = LDAP_SCOPE_ONELEVEL;
 	} else {
 		if (sprintf(query, "(objectclass=%s)", class) >= l) {
 			debug(LOGOPT_NONE,
@@ -883,7 +883,7 @@
 		return 1;
 	}
 
-#if WITH_SASL
+#ifdef WITH_SASL
 	/*
 	 * Determine which authentication mechanism to use.  We sanity-
 	 * check by binding to the server temporarily.
@@ -895,7 +895,7 @@
 		free_context(ctxt);
 		return 1;
 	}
-#endif
+#endif /* WITH_SASL */
 
 	ldap = do_connect(ctxt);
 	if (!ldap) {
@@ -1281,7 +1281,6 @@
 {
 	struct map_source *source = ap->entry->current;
 	struct mapent_cache *mc = source->mc;
-	struct mapent me;
 	int rv, i, l, ql, count;
 	char buf[MAX_ERR_BUF];
 	time_t age = time(NULL);
@@ -1590,9 +1589,9 @@
 	me = cache_lookup(mc, key);
 	if (me) {
 		pthread_cleanup_push(cache_lock_cleanup, mc);
-		mapent = alloca(strlen(me->mapent) + 1);
-		mapent_len = sprintf(mapent, me->mapent);
-		mapent[mapent_len] = '\0';
+		mapent_len = strlen(me->mapent);
+		mapent = alloca(mapent_len + 1);
+		strcpy(mapent, me->mapent);
 		pthread_cleanup_pop(0);
 	}
 	cache_unlock(mc);
@@ -1633,7 +1632,7 @@
 {
 	struct lookup_context *ctxt = (struct lookup_context *) context;
 	int rv = close_parse(ctxt->parse);
-#if WITH_SASL
+#ifdef WITH_SASL
 	EVP_cleanup();
 	ERR_free_strings();
 
diff -ru autofs-5.0.1/modules/mount_nfs.c autofs-5.0.1-patched/modules/mount_nfs.c
--- autofs-5.0.1/modules/mount_nfs.c	2006-07-13 04:11:39.000000000 -0400
+++ autofs-5.0.1-patched/modules/mount_nfs.c	2006-07-13 15:11:11.000000000 -0400
@@ -47,7 +47,7 @@
 {
 	/* Make sure we have the local mount method available */
 	if (!mount_bind) {
-		if ((mount_bind = open_mount("bind", MODPREFIX)));
+		if ((mount_bind = open_mount("bind", MODPREFIX)))
 			init_ctr++;
 	} else
 		init_ctr++;
diff -ru autofs-5.0.1/modules/replicated.c autofs-5.0.1-patched/modules/replicated.c
--- autofs-5.0.1/modules/replicated.c	2006-07-13 04:11:39.000000000 -0400
+++ autofs-5.0.1-patched/modules/replicated.c	2006-07-13 15:27:05.000000000 -0400
@@ -75,7 +75,7 @@
 static unsigned int get_proximity(const char *host_addr, int addr_len)
 {
 	struct sockaddr_in *msk_addr, *if_addr;
-	struct in_addr *h_addr;
+	struct in_addr *hx_addr;
 	char tmp[20], buf[MAX_ERR_BUF], *estr, *ptr;
 	struct ifconf ifc;
 	struct ifreq *ifr, nmptr;
@@ -83,9 +83,9 @@
 	uint32_t mask, ha, ia;
 
 	memcpy(tmp, host_addr, addr_len);
-	h_addr = (struct in_addr *) tmp;
+	hx_addr = (struct in_addr *) tmp;
 
-	ha = ntohl((uint32_t) h_addr->s_addr);
+	ha = ntohl((uint32_t) hx_addr->s_addr);
 
 	sock = socket(AF_INET, SOCK_DGRAM, 0);
 	if (sock < 0) {
@@ -116,7 +116,7 @@
 		switch (ifr->ifr_addr.sa_family) {
 		case AF_INET:
 			if_addr = (struct sockaddr_in *) &ifr->ifr_addr;
-			ret = memcmp(&if_addr->sin_addr, h_addr, addr_len);
+			ret = memcmp(&if_addr->sin_addr, hx_addr, addr_len);
 			if (!ret) {
 				close(sock);
 				return PROXIMITY_LOCAL;
@@ -696,7 +696,7 @@
 	struct hostent *result;
 	struct sockaddr_in saddr;
 	char buf[MAX_IFC_BUF], **haddr;
-	int h_errno, ret;
+	int h_err, ret;
 	struct host *new;
 	unsigned int prx;
 
@@ -721,14 +721,14 @@
 	memset(&he, 0, sizeof(struct hostent));
 
 	ret = gethostbyname_r(host, phe,
-			buf, MAX_IFC_BUF, &result, &h_errno);
+			buf, MAX_IFC_BUF, &result, &h_err);
 	if (ret || !result) {
-		if (h_errno == -1)
+		if (h_err == -1)
 			error(LOGOPT_ANY,
 			      "host %s: lookup failure %d", host, errno);
 		else
 			error(LOGOPT_ANY,
-			      "host %s: lookup failure %d", host, h_errno);
+			      "host %s: lookup failure %d", host, h_err);
 		return 0;
 	}
 

--d9ADC0YsG2v16Js0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--d9ADC0YsG2v16Js0--

