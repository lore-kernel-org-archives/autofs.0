From: raven@themaw.net
Subject: Re: csh/cd not getting the right cwd at the mount point
Date: Mon, 12 Jul 2004 23:58:48 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0407122243020.14924@donald.themaw.net>
References: <BA0E4392AD99D040885C414D992C24BE08264B56@us-bv-m11.bv.tek.com>
 <Pine.LNX.4.58.0407101248510.1378@donald.themaw.net>
 <16626.34195.267988.648284@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16626.34195.267988.648284@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Mon, 12 Jul 2004, Jeff Moyer wrote:

> =3D=3D> Regarding Re: [autofs] csh/cd not getting the right cwd at the =
mount point; raven@themaw.net adds:
>=20
> raven> On Fri, 9 Jul 2004 peter.a.harris@exgate.tek.com wrote: I'm havi=
ng
> raven> difficulty understanding the problem you describe.
>=20
> >> We have a problem.  Here are the conditions:
> >>=20
> >> 1. Shell is (t)csh (does not happen under (ba)sh) 2. cd to an autofs
> >> fa=E7ade (e.g. /tools in our case) 3. cd relatively to the subdirect=
ory
> >> that is the mount point.
> NOTE> The mount must not yet be made. (e.g. perl5.8.3)
> >> 4. cd relatively to a subdirectory in the mounted files system (e.g.=
 bin
> >> or lib)
>=20
> [snip]
>=20
> raven> I recommend you try autofs4 release 20040508. Unfortuneately thi=
s
> raven> release requires a kernel rebuild as there is a small mandatory
> raven> change outside of the autofs4 module needed for correct
> raven> operation. This release is the one that should be used as it
> raven> addresses all known problems and works best with the latest auto=
fs
> raven> release.
>=20
> raven> You should be using autofs-4.1.3. There is an additional patch t=
hat
> raven> I have recommened a couple of times now, without adverse feedbac=
k,
> raven> that my fix your problem. I've uploaded it to kernel.org and it =
can
> raven> be found at:
>=20
> [snip]
>=20
> NOTE: I was not able to reproduce the problem in my environment, which
> included our next update kernel that is fully patched with Ian's latest
> kernel patch kit.  I'm using autofs-4.1.3-10, which will appear on my
> people page soon.

I had some trouble understanding the problem dscription but thought it=20
sounded like below.

The easiest way to demonstrate the problem that this fixes is to cd to=20
an autofs directory and attempt to touch a file. It failed, a cd away and=
=20
back sees the touch work OK. I was able to made this badness happen fairl=
y=20
easily.

>=20
> raven> As a RHEL user visiting Jeff Moyers autofs page is a must as the=
re
> raven> are patches included their that have not yet been included in an
> raven> autofs release
>=20
>=20
> raven> http://people.redhat.com/~jmoyer
>=20
> raven> Jeff, would it be possible to include the two patches mentioned
> raven> above in your rpms please.
>=20
> Sure thing.  I'm doing builds for this now.  I'm currently tracking the
> following patches that I _think_ are queued for the next release.  Plea=
se
> correct me if I'm wrong, or if you want me to resend anything.

Thanks for that.

Since we're talking 4.1.4 let me go the whole hog!
And a bit of a roadmap for the nearish future.

>=20
>=20
> Patch12: autofs-4.1.2-option-parsing.patch
> - Make regular expressiosn for options parsing a bit more strict.  Fixe=
s
>   bugs I have filed on the package for false matches of either mount po=
ints
>   or other fs options.

Have looked at the patch before the additional work with rpc came up.

Will merge and test as part of next release.

>=20
> Patch14: autofs-4.1.3-underlinei18n.patch
> - This is a patch which makes translation prettier (AFAIUI).  Note, I
>   didn't write this, and didn't send it to you.  I've attached it to th=
is
>   mail.

Saw this yesterday. Looks straight forward. Will merge also.

>=20
> Patch15: autofs-4.1.3-rpc-ping.patch
> - Ian, you know very well what this is.  ;)

Yep.

I have been working on the first cut of the map update changes. I'm=20
testing atm. It's going a little slowly as I've been way busy this last=20
few weeks, but you know about that.

It will be another patch for testing and possible inclusion (if it is=20
ready in time) in 4.1.4. There were some fairly significant changes for=20
this but not really much added functionality and I'm having some=20
difficulty with it atm. So we'll have to see how it goes.

>=20
> And, the two you just had me put in:
>=20
> Patch16: autofs-4.1.3-bad_chdir.patch
> Patch17: autofs-4.1.3-mtab_lock.patch

Yep. These will also be in 4.1.4.

There are three other patches I have been working on that I want to=20
include in 4.1.4. Two other patches will be posponed, one contributed by=20
Ian McCleod. It had a hard coded path in it so I need to do some more wor=
k=20
on it before merging it (if at all, see below). Second a patch by Andrew=20
Stribblehill that merges the function of the file and yp maps into one.=20
The patch is a bit old and has some flaws so it needs a fair amount of=20
work. It also covers some of the functionality of Ians' patch which makes=
=20
it quite a difficult job.

WARNING: I'm not sure that all three patches will apply cleanly as I have=
=20
been choping and changing as issues have come up. Since the work for=20
4.1.4 is not complete I haven't returned to check and test these since=20
there initial creation and test. So these are very much fyi so you know=20
what to expect. I'd be interested in feedback if you have time to check=20
them out.

First a patch to cull white space from map entries which resulted from a=20
problem logged some time ago. This patch should be OK to include if you=20
wish, it seems to work OK.

Call it.

autofs-4.1.3-white_space.patch

diff -Nur autofs-4.1.3.orig/modules/mount_nfs.c autofs-4.1.3/modules/moun=
t_nfs.c
--- autofs-4.1.3.orig/modules/mount_nfs.c	2004-06-05 13:49:33.000000000 +=
0800
+++ autofs-4.1.3/modules/mount_nfs.c	2004-06-05 14:17:59.000000000 +0800
@@ -347,7 +347,7 @@
 	int local, err;
 	int nosymlink =3D 0;
=20
-	debug(MODPREFIX " root=3D%s name=3D%s what=3D%s, fstype=3D%s, options=3D=
%s",
+	debug(MODPREFIX "root=3D%s name=3D%s what=3D%s, fstype=3D%s, options=3D=
%s",
 	      root, name, what, fstype, options);
=20
 	whatstr =3D alloca(strlen(what) + 1);
diff -Nur autofs-4.1.3.orig/modules/parse_sun.c autofs-4.1.3/modules/pars=
e_sun.c
--- autofs-4.1.3.orig/modules/parse_sun.c	2004-06-05 13:49:33.000000000 +=
0800
+++ autofs-4.1.3/modules/parse_sun.c	2004-06-05 14:17:59.000000000 +0800
@@ -618,7 +618,7 @@
 {
 	struct parse_context *ctxt =3D (struct parse_context *) context;
 	char *pmapent, *options;
-	const char *p, *q;
+	const char *p;
 	int mapent_len, rv;
 	int optlen;
=20
@@ -688,6 +688,12 @@
 			}
=20
 			path =3D dequote(p, l =3D chunklen(p, 0));
+			if (!path) {
+				error(MODPREFIX "out of memory");
+				free(myoptions);
+				free(options);
+				return 1;
+			}
 			pathlen =3D strlen(path);
=20
 			p +=3D l;
@@ -712,21 +718,11 @@
 				} while (*p =3D=3D '-');
 			}
=20
-			q =3D p;
-			while (*q && *q !=3D '/') {
-				l =3D chunklen(q, 1);
-				q +=3D l;
-				q =3D skipspace(q);
-			}
-			l =3D q - p;
-
-			loc =3D dequote(p, l);
-			loclen =3D strlen(loc);
-
-			if (loc =3D=3D NULL || path =3D=3D NULL) {
+			loc =3D dequote(p, l =3D chunklen(p, 1));
+			if (!loc) {
 				error(MODPREFIX "out of memory");
-				free(loc);
 				free(path);
+				free(myoptions);
 				free(options);
 				return 1;
 			}
@@ -734,6 +730,39 @@
 			p +=3D l;
 			p =3D skipspace(p);
=20
+			while (*p && *p !=3D '/') {
+				char *ent;
+
+				ent =3D dequote(p, l =3D chunklen(p, 1));
+				if (!ent) {
+					error(MODPREFIX "out of memory");
+					free(path);
+					free(myoptions);
+					free(options);
+					return 1;
+				}
+
+				loc =3D realloc(loc, strlen(loc) + l + 2);
+				if (!loc) {
+					error(MODPREFIX "out of memory");
+					free(ent);
+					free(path);
+					free(myoptions);
+					free(options);
+					return 1;
+				}
+
+				strcat(loc, " ");
+				strcat(loc, ent);
+
+				free(ent);
+
+				p +=3D l;
+				p =3D skipspace(p);
+			}
+
+			loclen =3D strlen(loc);
+
 			debug(MODPREFIX
 			      "multimount: %.*s on %.*s with options %s",
 			      loclen, loc, pathlen, path, myoptions);
@@ -763,15 +792,7 @@
 		if (*p =3D=3D ':')
 			p++;	/* Sun escape for entries starting with / */
=20
-		q =3D p;
-		while (*q) {
-			l =3D chunklen(q, 1);
-			q +=3D l;
-			q =3D skipspace(q);
-		}
-		l =3D q - p;
-
-		loc =3D dequote(p, l);
+		loc =3D dequote(p, chunklen(p, 1));
 		loclen =3D strlen(loc);
=20
 		if (loc =3D=3D NULL) {

and after complains about fsck not working properly I made this patch=20
also. It is very much untested at this stage so handle with care.

Call it autofs-4.1.3-fsck_check.patch:

diff -Nur autofs-4.1.3.orig/modules/mount_ext2.c autofs-4.1.3/modules/mou=
nt_ext2.c
--- autofs-4.1.3.orig/modules/mount_ext2.c	2004-05-10 20:44:30.000000000 =
+0800
+++ autofs-4.1.3/modules/mount_ext2.c	2004-05-30 11:52:51.000000000 +0800
@@ -96,12 +96,22 @@
 		debug(MODPREFIX "calling %s -p %s", fsck_prog, what);
 		err =3D spawnl(LOG_DEBUG, MOUNTED_LOCK, fsck_prog, fsck_prog, "-p", wh=
at, NULL);
 	}
-
-	if (err & ~6) {
-		error(MODPREFIX "%s: filesystem needs repair, won't mount",
+=20
+	if (err & 8) {
+		warn(MODPREFIX "%s: filesystem is mounted or operational error",
+		     what);
+	} else if (err & 4) {
+		warn(MODPREFIX "%s: filesystem errors left uncorrected",
 		      what);
 		return 1;
-	}
+	} else if (err & 2) {
+		error(MODPREFIX "%s: filesystem errors left uncorrected, "
+		      "system should be rebooted",
+		      what);
+		return 1;
+	} else if (err & ~15)
+		warn(MODPREFIX "%s: undetermined fsck error.",
+		     what);
=20
 	wait_for_lock();
 	if (options) {

Finally, I lifted this from some initial (now abandoned) work on 4.2.0. I=
t=20
is a module to manage lists of mounts. I'm using it clean up some of the=20
mount handling. I think (???) it's not quite complete yet so it may chang=
e=20
a little before 4.1.4. The functions will remain but a couple more may be=
=20
added and testing it would be good anyway.

And for those who have read this far and are wondering about my reluctanc=
e=20
to implement automatic map updates. 4.2.0 will eliminate the the=20
non-standard direct mount map handling and allow lazy mounting of=20
multi-mounts maps. LIKE IT OR NOT the method I have finally decided upon=20
will not lend itself to doing dynamic map updates for direct mount maps,=20
save for a periodic map re-read. So it's a cron job for those that need=20
it. This work has waited way to long and MUST be done as a priority.

Call it autofs-4.1.3-mounts.patch

diff -Nur autofs-4.1.3.orig/daemon/automount.c autofs-4.1.3.mounts/daemon=
/automount.c
--- autofs-4.1.3.orig/daemon/automount.c	2004-04-05 21:14:10.000000000 +0=
800
+++ autofs-4.1.3.mounts/daemon/automount.c	2004-05-23 14:11:02.000000000 =
+0800
@@ -243,59 +243,19 @@
 	int left;
 	struct mntent *mnt;
 	FILE *mtab;
-	struct mntlist {
-		const char *path;
-		const char *fs_type;
-		struct mntlist *next;
-	} *mntlist =3D NULL, *mptr;
+	struct mnt_list *mntlist =3D NULL;
+	struct mnt_list *mptr;
 	size_t pathlen =3D strlen(path);
=20
 	debug("umount_multi: path=3D%s incl=3D%d\n", path, incl);
=20
-	wait_for_lock();
-	mtab =3D setmntent(_PATH_MOUNTED, "r");
-	if (!mtab) {
-		unlink(AUTOFS_LOCK);
-		error("umount_multi: setmntent: %m");
-		return -1;
-	}
-
-	/* Construct a list of eligible dirs ordered longest->shortest
-	   so that umount will work */
-	while ((mnt =3D getmntent(mtab)) !=3D NULL) {
-		size_t len =3D strlen(mnt->mnt_dir);
-		struct mntlist *m, **prev;
-		char *p;
-
-		if ((!incl && len <=3D pathlen) ||
-		    strncmp(mnt->mnt_dir, path, pathlen) !=3D 0)
-			continue;
-
-		if (len > pathlen && mnt->mnt_dir[pathlen] !=3D '/')
-			continue;
-
-		prev =3D &mntlist;
-		for (mptr =3D mntlist; mptr !=3D NULL; prev =3D &mptr->next, mptr =3D =
mptr->next)
-			if (len > strlen(mptr->path))
-				break;
-
-		m =3D alloca(sizeof(*m));
+	mntlist =3D get_mnt_list(path, incl);
=20
-		p =3D alloca(len + 1);
-		strcpy(p, mnt->mnt_dir);
-		m->path =3D p;
-
-		p =3D alloca(strlen(mnt->mnt_type) + 1);
-		strcpy(p, mnt->mnt_type);
-		m->fs_type =3D p;
-	=09
-		m->next =3D *prev;
-		*prev =3D m;
+	if (!mntlist) {
+		error("umount_multi: failed to get list of mounts");
+		return -1;
 	}
=20
-	endmntent(mtab);
-	unlink(AUTOFS_LOCK);
-
 	left =3D 0;
 	for (mptr =3D mntlist; mptr !=3D NULL; mptr =3D mptr->next) {
 		debug("umount_multi: unmounting dir=3D%s\n", mptr->path);
@@ -406,7 +366,7 @@
 	struct stat st;
 	int len;
=20
-	if ((ap.state !=3D ST_INIT) || is_mounted(path)) {
+	if ((ap.state !=3D ST_INIT) || is_mounted(MOUNTED, path)) {
 		/* This can happen if an autofs process is already running*/
 		error("mount_autofs: already mounted");
 		return -1;
diff -Nur autofs-4.1.3.orig/include/automount.h autofs-4.1.3.mounts/inclu=
de/automount.h
--- autofs-4.1.3.orig/include/automount.h	2004-05-18 20:20:08.000000000 +=
0800
+++ autofs-4.1.3.mounts/include/automount.h	2004-05-23 13:50:22.000000000=
 +0800
@@ -36,7 +36,7 @@
=20
 #define DEFAULT_TIMEOUT (5*60)			/* 5 minutes */
 #define AUTOFS_LOCK	"/var/lock/autofs"	/* To serialize access to mount *=
/
-#define MOUNTED_LOCK	"_PATH_MOUNTED~"	/* mounts' lock file */
+#define MOUNTED_LOCK	"MOUNTED~"		/* mounts' lock file */
 #define MTAB_NOTUPDATED 0x1000			/* mtab succeded but not updated */
 #define NOT_MOUNTED     0x0100			/* path notmounted */
=20
@@ -125,7 +125,6 @@
 	     const char *what, const char *fstype, const char *options);
 int mkdir_path(const char *path, mode_t mode);
 int rmdir_path(const char *path);
-int is_mounted(const char *path);
=20
 /* Prototype for module functions */
=20
@@ -252,6 +251,22 @@
 	     unsigned int ping_vers, unsigned int ping_proto,
 	     long seconds, long micros, double *result);
=20
+/* mount table utilities */
+struct mnt_list {
+	char *path;
+	char *fs_type;
+	time_t last_access;
+	struct mnt_list *next;
+};
+
+struct mnt_list *get_mnt_list(const char *path, int include);
+struct mnt_list *reverse_mnt_list(struct mnt_list *list);
+struct mnt_list *get_base_mnt_list(struct mnt_list *list);
+void free_mnt_list(struct mnt_list *list);
+int is_mounted(const char *table, const char *path);
+int has_fstab_option(const char *path, const char *opt);
+int allow_owner_mount(const char *);
+
 /* log notification */
 extern int do_verbose;
 extern int do_debug;
@@ -273,3 +288,4 @@
 	syslog(LOG_DEBUG, msg, ##args);
=20
 #endif
+
diff -Nur autofs-4.1.3.orig/lib/Makefile autofs-4.1.3.mounts/lib/Makefile
--- autofs-4.1.3.orig/lib/Makefile	2004-03-07 20:17:54.000000000 +0800
+++ autofs-4.1.3.mounts/lib/Makefile	2004-05-23 13:19:09.000000000 +0800
@@ -9,13 +9,14 @@
 RPCGEN =3D /usr/bin/rpcgen
 RANLIB =3D /usr/bin/ranlib
=20
-SRCS =3D cache.c listmount.c cat_path.c rpc_subs.c
+SRCS =3D cache.c listmount.c cat_path.c rpc_subs.c mounts.c
 RPCS =3D mount.h mount_clnt.c mount_xdr.c
-OBJS =3D cache.o mount_clnt.o mount_xdr.o listmount.o cat_path.o rpc_sub=
s.o
+OBJS =3D cache.o mount_clnt.o mount_xdr.o listmount.o \
+	cat_path.o rpc_subs.o mounts.o
=20
 LIB =3D autofs.a
=20
-CFLAGS +=3D -I../include -fpic -D_GNU_SOURCE -DHAVE_TCP_WRAPPER -DNFS3_S=
UPPORTED
+CFLAGS +=3D -I../include -fPIC -D_GNU_SOURCE -DHAVE_TCP_WRAPPER -DNFS3_S=
UPPORTED
=20
 .PHONY: all install clean
=20
diff -Nur autofs-4.1.3.orig/lib/cache.c autofs-4.1.3.mounts/lib/cache.c
--- autofs-4.1.3.orig/lib/cache.c	2004-03-07 20:17:54.000000000 +0800
+++ autofs-4.1.3.mounts/lib/cache.c	2004-05-23 13:45:45.000000000 +0800
@@ -206,7 +206,7 @@
 		return 0;
=20
 	if (strcmp(key, me->key) =3D=3D 0) {
-		if (is_mounted(path))
+		if (is_mounted(MOUNTED, path))
 			return 0;
 		mapent_hash[hashval] =3D me->next;
 		goto found;
@@ -216,7 +216,7 @@
 		pred =3D me;
 		me =3D me->next;
 		if (strcmp(key, me->key) =3D=3D 0) {
-			if (is_mounted(path))
+			if (is_mounted(MOUNTED, path))
 				return 0;
=20
 			pred->next =3D me->next;
@@ -253,7 +253,7 @@
 				sprintf(path, "%s/%s", root, me->key);
 			}
=20
-			if (is_mounted(path))
+			if (is_mounted(MOUNTED, path))
 				continue;
=20
 			if (me->age < age) {
@@ -273,7 +273,7 @@
 			sprintf(path, "%s/%s", root, me->key);
 		}
=20
-		if (is_mounted(path))
+		if (is_mounted(MOUNTED, path))
 			continue;
=20
 		if (me->age < age) {
@@ -376,7 +376,7 @@
 				break;
=20
 			case LKP_MOUNT:
-				if (!is_mounted(gc.direct_base)) {
+				if (!is_mounted(MOUNTED, gc.direct_base)) {
 					debug("cache_ghost: attempting to mount map, "
 					      "key %s",
 					      gc.direct_base);
@@ -398,39 +398,6 @@
 	return map;
 }
=20
-int is_mounted(const char *path)
-{
-	struct mntent *mnt;
-	FILE *mtab;
-	int pathlen =3D strlen(path);
-	int ret =3D 0;
-
-	if (!path || !pathlen)
-		return ret;
-
-	wait_for_lock();
-	mtab =3D setmntent(_PATH_MOUNTED, "r");
-	if (!mtab) {
-		unlink(AUTOFS_LOCK);
-		error("is_mounted: setmntent: %m");
-		return -1;
-	}
-
-	while ((mnt =3D getmntent(mtab)) !=3D NULL) {
-		int len =3D strlen(mnt->mnt_dir);
-
-		if (pathlen =3D=3D len && !strncmp(path, mnt->mnt_dir, pathlen)) {
-			ret =3D 1;
-			break;
-		}
-	}
-
-	endmntent(mtab);
-	unlink(AUTOFS_LOCK);
-
-	return ret;
-}
-
 static unsigned long ent_check(struct ghost_context *gc, char **pkey, in=
t ghosted)
 {
 	char *proot =3D (char *) gc->root;
diff -Nur autofs-4.1.3.orig/lib/mounts.c autofs-4.1.3.mounts/lib/mounts.c
--- autofs-4.1.3.orig/lib/mounts.c	1970-01-01 08:00:00.000000000 +0800
+++ autofs-4.1.3.mounts/lib/mounts.c	2004-05-23 13:14:04.000000000 +0800
@@ -0,0 +1,323 @@
+#ident "$Id"
+/* ---------------------------------------------------------------------=
-- *
+ *  =20
+ *  mounts.c - module for Linux automount mount table lookup functions
+ *
+ *   Copyright 2002-2004 Ian Kent <raven@themaw.net> - All Rights Reserv=
ed
+ *
+ *   This program is free software; you can redistribute it and/or modif=
y
+ *   it under the terms of the GNU General Public License as published b=
y
+ *   the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 0213=
9,
+ *   USA; either version 2 of the License, or (at your option) any later
+ *   version; incorporated herein by reference.
+ *
+ * ---------------------------------------------------------------------=
-- */
+
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <syslog.h>
+#include <mntent.h>
+#include <limits.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+
+#include "automount.h"
+
+/*
+ * Get list of mounts under path in longest->shortest order
+ */
+struct mnt_list *get_mnt_list(const char *path, int include)
+{
+	FILE *tab;
+	int pathlen =3D strlen(path);
+	struct mntent *mnt;
+	struct mnt_list *ent, *mptr;
+	struct mnt_list *list =3D NULL;
+	struct stat st;
+	int len;
+
+	if (!path || !pathlen || pathlen > PATH_MAX)
+		return NULL;
+
+	tab =3D setmntent(MOUNTED, "r");
+	if (!tab) {
+		error("get_mntlist: setmntent: %m");
+		return NULL;
+	}
+
+	while ((mnt =3D getmntent(tab)) !=3D NULL) {
+		len =3D strlen(mnt->mnt_dir);
+
+		if ((!include && len <=3D pathlen) ||
+	  	     strncmp(mnt->mnt_dir, path, pathlen) !=3D 0)
+			continue;
+
+		/* Not a subdirectory of requested path ? */
+		if (len > pathlen && mnt->mnt_dir[pathlen] !=3D '/')
+			continue;
+
+		mptr =3D list;
+		while (mptr) {
+			if (len > strlen(mptr->path))
+				break;
+			mptr =3D mptr->next;
+		}
+
+		ent =3D malloc(sizeof(*ent));
+		if (!ent) {
+			endmntent(tab);
+			free_mnt_list(list);
+			return NULL;
+		}
+
+		ent->path =3D malloc(len + 1);
+		if (!ent->path) {
+			endmntent(tab);
+			free_mnt_list(list);
+			return NULL;
+		}
+		strcpy(ent->path, mnt->mnt_dir);
+
+		ent->fs_type =3D malloc(strlen(mnt->mnt_type) + 1);
+		if (!ent->fs_type) {
+			endmntent(tab);
+			free_mnt_list(list);
+			return NULL;
+		}
+		strcpy(ent->fs_type, mnt->mnt_type);
+
+		if (mptr =3D=3D list)
+			list =3D ent;
+
+		ent->next =3D mptr;
+	}
+	endmntent(tab);
+
+	mptr =3D list;
+	while (mptr) {
+		mptr->last_access =3D time(NULL);
+
+		if (stat(mptr->path, &st) !=3D -1)
+			mptr->last_access =3D st.st_atime;
+
+		mptr =3D mptr->next;
+	}
+
+	return list;
+}
+
+/*
+ * Reverse a list of mounts
+ */
+struct mnt_list *reverse_mnt_list(struct mnt_list *list)
+{
+	struct mnt_list *next, *last;
+
+	if (!list)
+		return NULL;
+
+	next =3D list;
+	last =3D NULL;
+	while (next) {
+		struct mnt_list *this =3D next;
+
+		next =3D this->next;
+		this->next =3D last;
+		last =3D this;
+	}
+
+	return last;
+}
+
+static struct mnt_list *copy_mnt_list_ent(struct mnt_list *ent)
+{
+	struct mnt_list *new;
+	int len;
+
+	if (!ent)
+		return NULL;
+	=09
+	new =3D malloc(sizeof(*new));
+	if (!new) {
+		return NULL;
+	}
+
+	if (!ent->path || !ent->fs_type)
+		return NULL;
+
+	new->path =3D malloc(strlen(ent->path) + 1);
+	if (!new->path) {
+		free(new);
+		return NULL;
+	}
+	strcpy(new->path, ent->path);
+
+	new->fs_type =3D malloc(strlen(ent->fs_type) + 1);
+	if (!new->fs_type) {
+		free(new->path);
+		free(new);
+		return NULL;
+	}
+	strcpy(new->fs_type, ent->fs_type);
+
+	new->next =3D NULL;
+
+	return new;
+}
+
+/*
+ * Get list of mount points that are the base of a mount
+ * tree (ie. get highest point at which we cross file
+ * system boundary). Assumes mount list with
+ * shortest -> longest paths.
+ */
+struct mnt_list *get_base_mnt_list(struct mnt_list *list)
+{
+	struct mnt_list *next, *ret =3D NULL;
+	char *base;
+
+	if (!list)
+		return NULL;
+
+	next =3D list;
+	base =3D next->path;
+	ret =3D copy_mnt_list_ent(next);
+	while (next) {
+		struct mnt_list *this =3D next;
+		struct mnt_list *new;
+		int blen =3D strlen(base);
+		int nlen, eq;
+
+		next =3D this->next;
+		if (!next)
+			break;
+		nlen =3D strlen(next->path);
+
+
+		eq =3D strncmp(this->path, base, blen);
+		if (!eq)
+			continue;
+
+		if (strncmp(this->path, base, blen)) {
+			if (nlen > blen && next->path[blen + 1] =3D=3D '/')
+				continue;
+		}
+
+		base =3D this->path;
+
+		new =3D copy_mnt_list_ent(this);
+		new->next =3D ret;
+		ret =3D new;
+	}
+
+	return ret;
+}
+
+void free_mnt_list(struct mnt_list *list)
+{
+	struct mnt_list *next;
+
+	if (!list)
+		return;
+
+	next =3D list;
+	while (next) {
+		struct mnt_list *this =3D next;
+
+		next =3D this->next;
+
+		if (this->path)
+			free(this->path);
+
+		if (this->fs_type)
+			free(this->fs_type);
+
+		free(this);
+	}
+}
+
+static int find_mntent(const char *table, const char *path, struct mnten=
t *ent)
+{
+	struct mntent *mnt;
+	FILE *tab;
+	int pathlen =3D strlen(path);
+	int ret =3D 0;
+
+	if (!path || !pathlen || pathlen > PATH_MAX)
+		return 0;
+
+	tab =3D setmntent(table, "r");
+	if (!tab) {
+		error("find_mntent: setmntent: %m");
+		return 0;
+	}
+
+	while ((mnt =3D getmntent(tab)) !=3D NULL) {
+		int len =3D strlen(mnt->mnt_dir);
+
+		if (pathlen =3D=3D len && !strncmp(path, mnt->mnt_dir, pathlen)) {
+			int szent =3D sizeof(struct mntent);
+
+			if (ent)
+				memcpy(ent, mnt, szent);
+			ret =3D 1;
+
+			break;
+		}
+	}
+	endmntent(tab);
+
+	return ret;
+}
+=09
+int is_mounted(const char *table, const char *path)
+{
+	int ret =3D 0;
+
+	if (find_mntent(table, path, NULL))
+		ret =3D 1;
+
+	return ret;
+}
+
+int has_fstab_option(const char *path, const char *opt)
+{
+	struct mntent ent;
+	char *res =3D NULL;
+
+	if (find_mntent(MNTTAB, path, &ent)) {
+		if ((res =3D hasmntopt(&ent, opt)))
+			return 1;
+	}
+
+	return 0;
+}
+
+/*
+ * Check id owner option is present in fstab of requested
+ * mount. If it is return iowner uid of requested dev.
+ */
+int allow_owner_mount(const char *path)
+{
+	struct mntent ent;
+	int ret =3D 0;
+
+	if (getuid() || is_mounted(MOUNTED, path))
+		return 0;
+
+	if (find_mntent(MNTTAB, path, &ent)) {
+		struct stat st;
+
+		if (!hasmntopt(&ent, "owner"))
+			return 0;
+
+		if (stat(ent.mnt_fsname, &st) =3D=3D -1)
+			return 0;
+
+		ret =3D st.st_uid;
+	}
+
+	return ret;
+}
+
diff -Nur autofs-4.1.3.orig/modules/mount_autofs.c autofs-4.1.3.mounts/mo=
dules/mount_autofs.c
--- autofs-4.1.3.orig/modules/mount_autofs.c	2004-03-07 20:17:54.00000000=
0 +0800
+++ autofs-4.1.3.mounts/modules/mount_autofs.c	2004-05-23 13:46:47.000000=
000 +0800
@@ -73,7 +73,7 @@
 	debug(MODPREFIX "fullpath=3D%s what=3D%s options=3D%s",
 		  fullpath, what, options);
=20
-	if (is_mounted(fullpath)) {
+	if (is_mounted(MOUNTED, fullpath)) {
 		warn("BUG: about to mount over %s, continuing", fullpath);
 		return 0;
 	}
diff -Nur autofs-4.1.3.orig/modules/mount_bind.c autofs-4.1.3.mounts/modu=
les/mount_bind.c
--- autofs-4.1.3.orig/modules/mount_bind.c	2004-05-10 20:44:30.000000000 =
+0800
+++ autofs-4.1.3.mounts/modules/mount_bind.c	2004-05-23 13:47:11.00000000=
0 +0800
@@ -116,7 +116,7 @@
 			return 1;
 		}
=20
-		if (is_mounted(fullpath)) {
+		if (is_mounted(MOUNTED, fullpath)) {
 			warn("BUG: %s already mounted", fullpath);
 			return 0;
 		}
diff -Nur autofs-4.1.3.orig/modules/mount_ext2.c autofs-4.1.3.mounts/modu=
les/mount_ext2.c
--- autofs-4.1.3.orig/modules/mount_ext2.c	2004-05-10 20:44:30.000000000 =
+0800
+++ autofs-4.1.3.mounts/modules/mount_ext2.c	2004-05-23 13:48:04.00000000=
0 +0800
@@ -68,7 +68,7 @@
 		return 1;
 	}
=20
-	if (is_mounted(fullpath)) {
+	if (is_mounted(MOUNTED, fullpath)) {
 		error("BUG: %s already mounted", fullpath);
 		return 0;
 	}
diff -Nur autofs-4.1.3.orig/modules/mount_generic.c autofs-4.1.3.mounts/m=
odules/mount_generic.c
--- autofs-4.1.3.orig/modules/mount_generic.c	2004-05-10 20:44:30.0000000=
00 +0800
+++ autofs-4.1.3.mounts/modules/mount_generic.c	2004-05-23 13:48:28.00000=
0000 +0800
@@ -66,7 +66,7 @@
 		return 1;
 	}
=20
-	if (is_mounted(fullpath)) {
+	if (is_mounted(MOUNTED, fullpath)) {
 		error("BUG: %s already mounted", fullpath);
 		return 0;
 	}
diff -Nur autofs-4.1.3.orig/modules/mount_nfs.c autofs-4.1.3.mounts/modul=
es/mount_nfs.c
--- autofs-4.1.3.orig/modules/mount_nfs.c	2004-05-18 20:20:08.000000000 +=
0800
+++ autofs-4.1.3.mounts/modules/mount_nfs.c	2004-05-23 13:48:48.000000000=
 +0800
@@ -440,7 +440,7 @@
 			return 1;
 		}
=20
-		if (is_mounted(fullpath)) {
+		if (is_mounted(MOUNTED, fullpath)) {
 			error("BUG: %s already mounted", fullpath);
 			return 0;
 		}
