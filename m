From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [announce] autofsng 0.3.1
Date: Tue, 07 Dec 2004 00:38:56 -0500
Message-ID: <41B541F0.8050800@sun.com>
References: <200412070133.iB71Xf3M006262@cornholio.qualcomm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_/Sa8pQ0N3Lt+4TsOjNjsuw)"
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <200412070133.iB71Xf3M006262@cornholio.qualcomm.com>
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
To: mmarion@qualcomm.com
Cc: autofs@linux.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_/Sa8pQ0N3Lt+4TsOjNjsuw)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

mmarion@qualcomm.com wrote:
> On 22 Nov, Mike Waychison wrote:
> 
> 
>>I'm pleased to announce the release of AutofsNG 0.3.1.
> 
> 
> Has anyone successfully built on an amd64 host?
> 
> On a 64bit, sles9 host, I get:
> 
> make[1]: Entering directory
> `/local/mnt/workspace/builds/autofsng-0.3.1/modules'
> gcc -shared -O3 -fomit-frame-pointer -Wall -I../include -fpic
> -DAUTOFS_LIB_DIR=\"/lib/autofsng\" -o map_hosts.so map_hosts.c -lrpcsvc
> /usr/lib64/gcc-lib/x86_64-suse-linux/3.3.3/../../../../x86_64-suse-linux/bin/ld:
> /usr/lib64/gcc-lib/x86_64-suse-linux/3.3.3/../../../../lib64/librpcsvc.a(xmount.o):
> relocation R_X86_64_32 can not be used when making a shared object; recompile
> with -fPIC
> /usr/lib64/gcc-lib/x86_64-suse-linux/3.3.3/../../../../lib64/librpcsvc.a:
> could not read symbols: Bad value
> collect2: ld returned 1 exit status
> make[1]: *** [map_hosts.so] Error 1
> 
> Tried changing flags in Makefile from -fpic to -fPIC and it didn't help.
> 
> Compile works fine on a i686 Suse 9.2 install.
>  

I've attached a patch I will push if it works for you.  What it does is
generate the xdr routines in the autofsng build instead of trying to
link in librpcsvc.

The problem you are seeing is probably due to that bit of glibc not
being compiled with -fPIC, which means the .a in question can't be
linked into a .so on x86-64.

Another heads up for trying out autofsng on x86-64: I haven't yet added
the system call table entry for sys_mountfd.  If anyone gets to it
before I do, patches are welcome ;)


- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBtUHvdQs4kOxk3/MRAjZRAKCBbQ1SGgv0GYVy+vFQ06+2s79NxACdFgsG
RXrzAv53caHfRHXkI0PQWBM=
=xr9S
-----END PGP SIGNATURE-----

--Boundary_(ID_/Sa8pQ0N3Lt+4TsOjNjsuw)
Content-type: text/x-patch; name=mount_xdr.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=mount_xdr.patch

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/06 21:59:29-08:00 michael.waychison@sun.com 
#   This patch adds mount service xdr generation to the autofsng build.  This is
#   done because we can't pull xdr_exports reliably on some platforms.  For
#   instance, on sles9 x86-64 librpcsvr is built -fpic, which means we can't link it
#   into a .so.
# 
# autofsng/modules/Makefile
#   2004/12/06 21:57:02-08:00 michael.waychison@sun.com +10 -3
#   - Add targets for mount_xdr and use it instead of trying to link in librpcsvr.a
# 
# autofsng/modules/mount.x
#   2004/12/06 21:43:07-08:00 michael.waychison@sun.com +0 -0
#   Rename: autofsng/modules/sunrpc/mount.x -> autofsng/modules/mount.x
# 
# autofsng/modules/sunrpc/mount.x
#   2004/12/06 21:34:56-08:00 michael.waychison@sun.com +0 -0
#   Rename: autofsng/modules/mount.x -> autofsng/modules/sunrpc/mount.x
# 
# autofsng/modules/mount.x
#   2004/12/06 21:32:35-08:00 michael.waychison@sun.com +161 -0
# 
# autofsng/modules/mount.x
#   2004/12/06 21:32:35-08:00 michael.waychison@sun.com +0 -0
#   BitKeeper file /home/autofsng-dev/autofsng/modules/mount.x
# 
diff -Nru a/autofsng/modules/Makefile b/autofsng/modules/Makefile
--- a/autofsng/modules/Makefile	2004-12-06 22:00:35 -08:00
+++ b/autofsng/modules/Makefile	2004-12-06 22:00:35 -08:00
@@ -39,7 +39,7 @@
 all: $(MODS)
 
 clean:
-	rm -f *.o *.s *.so
+	rm -f *.o *.s *.so mount.h mount_xdr.c
 
 map_hesiod.so: map_hesiod.c
 	$(CC) $(SOLDFLAGS) $(CFLAGS) $(HESIOD_FLAGS) -o map_hesiod.so \
@@ -50,8 +50,15 @@
 	$(CC) $(SOLDFLAGS) $(CFLAGS) -o map_ldap.so map_ldap.c -lldap
 	$(STRIP) map_ldap.so
 
-map_hosts.so: map_hosts.c
-	$(CC) $(SOLDFLAGS) $(CFLAGS) -o map_hosts.so map_hosts.c -lrpcsvc
+mount_xdr.o: CFLAGS+=-I.
+mount_xdr.c: mount.x mount.h
+	rm -f mount_xdr.c; rpcgen -c mount.x | grep -v '^	register int32_t \*buf;$$' > mount_xdr.c
+
+mount.h: mount.x
+	rm -f mount.h; rpcgen -o mount.h -h mount.x
+
+map_hosts.so: map_hosts.c mount_xdr.o
+	$(CC) $(SOLDFLAGS) $(CFLAGS) -o map_hosts.so map_hosts.c mount_xdr.o
 	$(STRIP) map_hosts.so
 
 map_files.so: map_files.c
diff -Nru a/autofsng/modules/mount.x b/autofsng/modules/mount.x
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/autofsng/modules/mount.x	2004-12-06 22:00:35 -08:00
@@ -0,0 +1,161 @@
+/* @(#)mount.x	2.1 88/08/01 4.0 RPCSRC */
+/* @(#)mount.x 1.2 87/09/18 Copyr 1987 Sun Micro */
+
+/*
+ * Sun RPC is a product of Sun Microsystems, Inc. and is provided for
+ * unrestricted use provided that this legend is included on all tape
+ * media and as a part of the software program in whole or part.  Users
+ * may copy or modify Sun RPC without charge, but are not authorized
+ * to license or distribute it to anyone else except as part of a product or
+ * program developed by the user.
+ *
+ * SUN RPC IS PROVIDED AS IS WITH NO WARRANTIES OF ANY KIND INCLUDING THE
+ * WARRANTIES OF DESIGN, MERCHANTIBILITY AND FITNESS FOR A PARTICULAR
+ * PURPOSE, OR ARISING FROM A COURSE OF DEALING, USAGE OR TRADE PRACTICE.
+ *
+ * Sun RPC is provided with no support and without any obligation on the
+ * part of Sun Microsystems, Inc. to assist in its use, correction,
+ * modification or enhancement.
+ *
+ * SUN MICROSYSTEMS, INC. SHALL HAVE NO LIABILITY WITH RESPECT TO THE
+ * INFRINGEMENT OF COPYRIGHTS, TRADE SECRETS OR ANY PATENTS BY SUN RPC
+ * OR ANY PART THEREOF.
+ *
+ * In no event will Sun Microsystems, Inc. be liable for any lost revenue
+ * or profits or other special, indirect and consequential damages, even if
+ * Sun has been advised of the possibility of such damages.
+ *
+ * Sun Microsystems, Inc.
+ * 2550 Garcia Avenue
+ * Mountain View, California  94043
+ */
+
+/*
+ * Protocol description for the mount program
+ */
+
+
+const MNTPATHLEN = 1024;	/* maximum bytes in a pathname argument */
+const MNTNAMLEN = 255;		/* maximum bytes in a name argument */
+const FHSIZE = 32;		/* size in bytes of a file handle */
+
+/*
+ * The fhandle is the file handle that the server passes to the client.
+ * All file operations are done using the file handles to refer to a file
+ * or a directory. The file handle can contain whatever information the
+ * server needs to distinguish an individual file.
+ */
+typedef opaque fhandle[FHSIZE];
+
+/*
+ * If a status of zero is returned, the call completed successfully, and
+ * a file handle for the directory follows. A non-zero status indicates
+ * some sort of error. The status corresponds with UNIX error numbers.
+ */
+union fhstatus switch (unsigned fhs_status) {
+case 0:
+	fhandle fhs_fhandle;
+default:
+	void;
+};
+
+/*
+ * The type dirpath is the pathname of a directory
+ */
+typedef string dirpath<MNTPATHLEN>;
+
+/*
+ * The type name is used for arbitrary names (hostnames, groupnames)
+ */
+typedef string name<MNTNAMLEN>;
+
+/*
+ * A list of who has what mounted
+ */
+typedef struct mountbody *mountlist;
+struct mountbody {
+	name ml_hostname;
+	dirpath ml_directory;
+	mountlist ml_next;
+};
+
+/*
+ * A list of netgroups
+ */
+typedef struct groupnode *groups;
+struct groupnode {
+	name gr_name;
+	groups gr_next;
+};
+
+/*
+ * A list of what is exported and to whom
+ */
+typedef struct exportnode *exports;
+struct exportnode {
+	dirpath ex_dir;
+	groups ex_groups;
+	exports ex_next;
+};
+
+program MOUNTPROG {
+	/*
+	 * Version one of the mount protocol communicates with version two
+	 * of the NFS protocol. The only connecting point is the fhandle
+	 * structure, which is the same for both protocols.
+	 */
+	version MOUNTVERS {
+		/*
+		 * Does no work. It is made available in all RPC services
+		 * to allow server response testing and timing
+		 */
+		void
+		MOUNTPROC_NULL(void) = 0;
+
+		/*
+		 * If fhs_status is 0, then fhs_fhandle contains the
+	 	 * file handle for the directory. This file handle may
+		 * be used in the NFS protocol. This procedure also adds
+		 * a new entry to the mount list for this client mounting
+		 * the directory.
+		 * Unix authentication required.
+		 */
+		fhstatus
+		MOUNTPROC_MNT(dirpath) = 1;
+
+		/*
+		 * Returns the list of remotely mounted filesystems. The
+		 * mountlist contains one entry for each hostname and
+		 * directory pair.
+		 */
+		mountlist
+		MOUNTPROC_DUMP(void) = 2;
+
+		/*
+		 * Removes the mount list entry for the directory
+		 * Unix authentication required.
+		 */
+		void
+		MOUNTPROC_UMNT(dirpath) = 3;
+
+		/*
+		 * Removes all of the mount list entries for this client
+		 * Unix authentication required.
+		 */
+		void
+		MOUNTPROC_UMNTALL(void) = 4;
+
+		/*
+		 * Returns a list of all the exported filesystems, and which
+		 * machines are allowed to import it.
+		 */
+		exports
+		MOUNTPROC_EXPORT(void)  = 5;
+
+		/*
+		 * Identical to MOUNTPROC_EXPORT above
+		 */
+		exports
+		MOUNTPROC_EXPORTALL(void) = 6;
+	} = 1;
+} = 100005;

--Boundary_(ID_/Sa8pQ0N3Lt+4TsOjNjsuw)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--Boundary_(ID_/Sa8pQ0N3Lt+4TsOjNjsuw)--

