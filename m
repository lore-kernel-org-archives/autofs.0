From: "Arthur Korn" <arthur@korn.ch>
Subject: Debian diff remaining in autofs 4.1.3
Date: Sat, 4 Sep 2004 22:06:54 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040904200654.GA26488@turing>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============12526041208551497=="
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org


--===============12526041208551497==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

I'm the new Debian autofs Maintainer. As such, I had the
privilege to merge 1092 lines of many small patches when
updating to 4.1.3 ...

Here the updated patches that address issues that I couldn't see
fixed otherwise.




Mount is called like this "mount -t fstype -o what fullpath"
because options is allocated but empty.

--- autofs-4.1.3/modules/mount_changer.c.orig	2004-05-10 14:44:30.000000000=
 +0200
+++ autofs-4.1.3/modules/mount_changer.c	2004-09-03 23:49:18.000000000 +0200
@@ -94,7 +94,7 @@
 	}
=20
 	wait_for_lock();
-	if (options) {
+	if (options && options[0]) {
 		debug(MODPREFIX "calling mount -t %s " SLOPPY "-o %s %s %s",
 		    fstype, options, what, fullpath);
=20
--- autofs-4.1.3/modules/mount_ext2.c.orig	2004-05-10 14:44:30.000000000 +0=
200
+++ autofs-4.1.3/modules/mount_ext2.c	2004-09-03 23:49:47.000000000 +0200
@@ -73,7 +73,7 @@
 		return 0;
 	}
=20
-	if (options) {
+	if (options && options[0]) {
 		for (p =3D options; (p1 =3D strchr(p, ',')); p =3D p1)
 			if (!strncmp(p, "ro", p1 - p) && ++p1 - p =3D=3D sizeof("ro"))
 				ro =3D 1;
--- autofs-4.1.3/modules/mount_generic.c.orig	2004-05-10 14:44:30.000000000=
 +0200
+++ autofs-4.1.3/modules/mount_generic.c	2004-09-03 23:50:19.000000000 +0200
@@ -72,7 +72,7 @@
 	}
=20
 	wait_for_lock();
-	if (options) {
+	if (options && options[0]) {
 		debug(MODPREFIX "calling mount -t %s " SLOPPY "-o %s %s %s",
 		      fstype, options, what, fullpath);
=20






For program-maps, last character read from STDIN was being
doubled (pretty strange experience).


diff -ruN autofs-4.1.3.orig/modules/lookup_program.c autofs-4.1.3/modules/l=
ookup_program.c
--- autofs-4.1.3.orig/modules/lookup_program.c	2004-01-29 17:01:22.00000000=
0 +0100
+++ autofs-4.1.3/modules/lookup_program.c	2004-09-03 23:58:42.000000000 +02=
00
@@ -159,6 +159,7 @@
 			if (read(pipefd[0], &ch, 1) < 1) {
 				FD_CLR(pipefd[0], &ourfds);
 				files_left--;
+				state =3D st_done;
 			}
=20
 			if (!quoted && ch =3D=3D '\\') {







Add crude support for hesiod priorities.

--- autofs-4.1.3/modules/lookup_hesiod.c.orig	2004-09-03 23:18:31.000000000=
 +0200
+++ autofs-4.1.3/modules/lookup_hesiod.c	2004-09-03 23:18:35.000000000 +0200
@@ -9,6 +9,7 @@
=20
 #include <sys/types.h>
 #include <ctype.h>
+#include <limits.h>
 #include <string.h>
 #include <syslog.h>
 #include <unistd.h>
@@ -70,6 +71,8 @@ int lookup_mount(const char *root, const
 	char **hes_result;
 	struct lookup_context *ctxt =3D (struct lookup_context *) context;
 	int rv;
+	char **record, *best_record =3D NULL, *p;
+	int priority, lowest_priority =3D INT_MAX;=09
=20
 	debug(MODPREFIX "looking up root=3D\"%s\", name=3D\"%s\"", root, name);
=20
@@ -78,14 +81,30 @@ int lookup_mount(const char *root, const
=20
 	hes_result =3D hes_resolve(name, "filsys");
=20
-	if (!hes_result) {
+	if (!hes_result || !hes_result[0]) {
 		warn(MODPREFIX "entry \"%s\" not found in map\n", name);
 		return 1;
 	}
=20
-	debug(MODPREFIX "lookup for \"%s\" gave \"%s\"", name, hes_result[0]);
+	/* autofs doesn't support falling back to alternate records, so just
+	   find the record with the lowest priority and hope it works.
+	   -- Aaron Ucko <amu@alum.mit.edu> 2002-03-11 */
+	for (record =3D hes_result; *record; ++record) {
+	    p =3D strrchr(*record, ' ');
+	    if ( p && isdigit(p[1]) ) {
+		priority =3D atoi(p+1);
+	    } else {
+		priority =3D INT_MAX - 1;
+	    }
+	    if (priority < lowest_priority) {
+		lowest_priority =3D priority;
+		best_record =3D *record;
+	    }
+	}
=20
-	rv =3D ctxt->parser->parse_mount(root, name, name_len, hes_result[0],
+	debug(MODPREFIX "lookup for \"%s\" gave \"%s\"", name, best_record);
+
+	rv =3D ctxt->parser->parse_mount(root, name, name_len, best_record,
 				       ctxt->parser->context);
 	free(hes_result);
 	return rv;




The comment says it.

--- bak/modules/mount_afs.c.orig	2004-01-29 17:01:22.000000000 +0100
+++ bak/modules/mount_afs.c	2004-09-03 23:03:04.000000000 +0200
@@ -39,6 +39,10 @@
 	strncat(dest, "/", sizeof(dest));
 	strncat(dest, name, sizeof(dest));
=20
+	/* remove trailing slash (http://bugs.debian.org/141775) */
+	if (dest[strlen(dest)-1] =3D=3D '/')
+	    dest[strlen(dest)-1] =3D '\0';
+
 	debug(MODPREFIX "mounting AFS %s -> %s", dest, what);
=20
 	return symlink(what, dest);	/* Try it.  If it fails, return the error. */






Rather cosmetic: When there are errors in subdirectories on
build, make will continue. I need this so build-daemons can't
upload incomplete binary packages:

diff -ruN autofs-4.1.3.orig/Makefile autofs-4.1.3/Makefile
--- autofs-4.1.3.orig/Makefile	2003-09-29 10:22:35.000000000 +0200
+++ autofs-4.1.3/Makefile	2004-09-04 20:23:42.000000000 +0200
@@ -13,26 +13,26 @@
 all:	daemon samples
=20
 daemon:
-	for i in $(SUBDIRS); do $(MAKE) -C $$i all; done=20
+	set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i all; done=20
=20
 kernel:
-	if [ -d kernel ]; then $(MAKE) -C kernel all; fi
+	set -e; if [ -d kernel ]; then $(MAKE) -C kernel all; fi
=20
 samples:
-	if [ -d samples ]; then $(MAKE) -C samples all; fi
+	set -e; if [ -d samples ]; then $(MAKE) -C samples all; fi
=20
 clean:
 	for i in $(SUBDIRS) samples kernel; do \
 		if [ -d $$i ]; then $(MAKE) -C $$i clean; fi; done =09
=20
 install:
-	for i in $(SUBDIRS); do $(MAKE) -C $$i install; done =09
+	set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i install; done =09
=20
 install_kernel:
-	if [ -d kernel ]; then $(MAKE) -C kernel install; fi
+	set -e; if [ -d kernel ]; then $(MAKE) -C kernel install; fi
=20
 install_samples:
-	if [ -d samples ]; then $(MAKE) -C samples install; fi
+	set -e; if [ -d samples ]; then $(MAKE) -C samples install; fi
=20
 mrproper distclean: clean
 	find . -noleaf \( -name '*~' -o -name '#*' -o -name '*.orig' -o -name '*.=
rej' -o -name '*.old' \) -print0 | xargs -0 rm -f



HTH, 2ri
--=20
Help securing email, spread GPG, clearsign all mail. http://www.gnupg.org
=2E
					/\ .__|_|_    ._ |/ _ ._._ =20
				       /--\|  |_| ||_||  |\(_)| | |

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBOiBeNgpsykSg/LgRAvRsAJ42Aq6meF+JC/BFMqV4qq1iR/eAEgCfaGIA
hP6vIuDOstp62ySkV9Tz8K4=
=3W+Q
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--


--===============12526041208551497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============12526041208551497==--

