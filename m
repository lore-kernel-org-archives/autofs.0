From: thorild@Update.UU.SE (Thorild Selen)
Subject: [PATCH] Read-only bind mounts
Date: Sat, 13 Nov 2004 23:58:59 +0100
Message-ID: <16790.37299.746309.182431@Psilocybe.Update.UU.SE>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
Content-Type: text/plain; charset="iso-8859-1"
To: autofs@linux.kernel.org

Read-only bind mounts are currently not supported by standard kernels,
but it appears that they eventually will be.

The included patch converts local read-only NFS mounts to read-only
bind mounts. Comments are welcome. It compiles and even appears to
work -- well, at least 'mount' shows the resulting bind mounts as
'ro', so the rest is up to the kernel.

(Are there other options that one might want to honour for bind
mounts?)


Thorild Sel=E9n
Datorf=F6reningen Update / Update Computer Club, Uppsala, SE


diff -Naur autofs-4.1.3/modules/mount_bind.c autofs-4.1.3-bindro/modules/=
mount_bind.c
--- autofs-4.1.3/modules/mount_bind.c	2004-05-10 14:44:30.000000000 +0200
+++ autofs-4.1.3-bindro/modules/mount_bind.c	2004-11-13 21:51:22.00000000=
0 +0100
@@ -106,6 +106,9 @@
 	while (--i > 0 && fullpath[i] =3D=3D '/')
 		fullpath[i] =3D '\0';
=20
+	if (options =3D=3D NULL || *options =3D=3D '\0')
+		options =3D "defaults";
+
 	if (bind_works) {
 		int status;
=20
@@ -121,11 +124,14 @@
 			return 0;
 		}
=20
-		debug(MODPREFIX "calling mount --bind %s %s", what, fullpath);
+		debug(MODPREFIX
+		      "calling mount --bind " SLOPPY " -o %s %s %s",
+		      options, what, fullpath);
=20
 		wait_for_lock();
 		err =3D spawnl(LOG_NOTICE, MOUNTED_LOCK,
 			     PATH_MOUNT, PATH_MOUNT, "--bind",
+			     SLOPPYOPT "-o", options,
 			     what, fullpath, NULL);
 		unlink(AUTOFS_LOCK);
=20
diff -Naur autofs-4.1.3/modules/mount_nfs.c autofs-4.1.3-bindro/modules/m=
ount_nfs.c
--- autofs-4.1.3/modules/mount_nfs.c	2004-05-18 14:20:08.000000000 +0200
+++ autofs-4.1.3-bindro/modules/mount_nfs.c	2004-11-13 23:23:27.000000000=
 +0100
@@ -333,6 +333,7 @@
 	char *nfsoptions =3D NULL;
 	int local, err;
 	int nosymlink =3D 0;
+	int ro =3D 0;            /* Set if mount bind should be read-only */
=20
 	debug(MODPREFIX " root=3D%s name=3D%s what=3D%s, fstype=3D%s, options=3D=
%s",
 	      root, name, what, fstype, options);
@@ -387,14 +388,18 @@
 			if (strncmp("nosymlink", cp, end - cp + 1) =3D=3D 0)
 				nosymlink =3D 1;
 			else {
+				/* Check for options that also make sense
+				   with bind mounts */
+				if (strncmp("ro", cp, end - cp + 1) =3D=3D 0)
+					ro =3D 1;
 				/* and jump over trailing white space */
 				memcpy(nfsp, cp, comma - cp + 1);
 				nfsp +=3D comma - cp + 1;
 			}
 		}
=20
-		debug(MODPREFIX "nfs options=3D\"%s\", nosymlink=3D%d",
-		      nfsoptions, nosymlink);
+		debug(MODPREFIX "nfs options=3D\"%s\", nosymlink=3D%d, ro=3D%d",
+		      nfsoptions, nosymlink, ro);
 	}
=20
 	local =3D 0;
@@ -426,10 +431,13 @@
 	if (local) {
 		/* Local host -- do a "bind" */
=20
+		const char *bind_options =3D ro ? "ro" : "";
+
 		debug(MODPREFIX "%s is local, doing bind", name);
=20
 		return mount_bind->mount_mount(root, name, name_len,
-			       whatstr, "bind", NULL, mount_bind->context);
+					       whatstr, "bind", bind_options,
+					       mount_bind->context);
 	} else {
 		/* Not a local host - do an NFS mount */
 		int status;
