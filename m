From: Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] mount: Add automounter program map for FedFS
Date: Thu, 26 May 2011 12:39:12 -0400
Message-ID: <20110526163912.3676.84959.stgit@dali.1015granger.net>
References: <20110526163545.3676.52586.stgit@dali.1015granger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:sender:from:subject:to:date:message-id
	:in-reply-to:references:user-agent:mime-version:content-type
	:content-transfer-encoding;
	bh=kK+ZSKTlGjJGBUK2/dg/j3SHrTB8FIZvvLJVYrn7Mpg=;
	b=p/ICY6qLFT1uzQq4bE/2cBH0AdWYUjJWTcPV6uU4hbh8AQlHun7HEkj68uiJmS3Dr/
	hyiShR7Wu103Q6Yly4VMyeTO8FmFJ35Y7nhQOiYxDn27vCYRzxYlAfZgh6zaesrUEzRB
	W57WsEbt9P5+W5BtsdQupieGCm3iOuygtrUqY=
In-Reply-To: <20110526163545.3676.52586.stgit@dali.1015granger.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: fedfs-utils-devel@oss.oracle.com, autofs@linux.kernel.org

This new utility interprets the passed-in key as a FedFS domain,
performs a DNS SRV lookup, and generates the mount.nfs parameters
needed to mount the domain.  It can handle multiple read-only and
read-write domain root replicas using support already built into the
automounter.

The FedFS entry in the master map might look like this:

  /nfs4		/usr/sbin/fedfs-map-nfs4

To support other file system protocols, additional lines in the master
map and another program map utility (or options for this one) would be
needed.

Benefits:

  o  Simple to configure

  o  The TLD can be placed anywhere on the client

  o  No additional build or package dependencies on nfs-utils or
     autofs

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---

 .gitignore                 |    1 
 INSTALL                    |   10 +-
 README                     |   14 ++-
 doc/man/Makefile.am        |    2 
 doc/man/fedfs-map-nfs4.8   |  154 ++++++++++++++++++++++++++++
 doc/man/fedfs.7            |    4 +
 src/mount/Makefile.am      |    5 +
 src/mount/fedfs-map-nfs4.c |  242 ++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 422 insertions(+), 10 deletions(-)
 create mode 100644 doc/man/fedfs-map-nfs4.8
 create mode 100644 src/mount/fedfs-map-nfs4.c

diff --git a/.gitignore b/.gitignore
index ce06ff1..41daf0f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -9,6 +9,7 @@ src/fedfsd/fedfsd
 src/resolve-junction/resolve-junction
 src/nsdbparams/nsdbparams
 src/mount/mount.fedfs
+src/mount/fedfs-map-nfs4
 libadmin.a
 libjunction.a
 libnsdb.a
diff --git a/INSTALL b/INSTALL
index 8cb8e9e..548381b 100644
--- a/INSTALL
+++ b/INSTALL
@@ -143,12 +143,14 @@ FedFS file server
 
 FedFS client
 
-  o Install mount.fedfs
+  o Install /usr/sbin/fedfs-map-nfs4
 
-  o Create a local /nfs4 directory, and subdirectories for the FedFS
-    domains you want to mount
+  o Create a local /nfs4 directory
 
-  o Add lines to /etc/fstab to mount the domains
+  o Install and configure autofs
+
+  o Add an entry to the master map (usually /etc/auto.master) for
+    the /nfs4 directory and restart autofs
 
 
 FedFS admin client
diff --git a/README b/README
index 0067ac2..78b9647 100644
--- a/README
+++ b/README
@@ -59,7 +59,10 @@ changed over time.
 
 Installable components include:
 
-   o  A mount command to mount the top of a FedFS domain namespace
+   o  An automounter program map to manage the FedFS domain namespace
+      on FedFS-enabled clients
+
+   o  A mount command to mount parts of a FedFS domain namespace
 
    o  An ONC RPC service daemon that runs on file servers enabling the
       management by remote FedFS ADMIN clients of FedFS junctions
@@ -81,9 +84,14 @@ Installable components include:
    o  HTML Doxygen style documentation with built-in source browser
 
 
+The automounter program map is a subcommand invoked by the automounter
+to locate FedFS domains and construct appropriate mount options for
+mounting domain roots.  It is used in conjunction with the Linux
+autofs facility.
+
 The mount command is a subcommand invoked by mount(8) to handle the
-housekeeping needed to find and mount FedFS domains at the top of the
-client's FedFS namespace (usually /nfs4 for NFSv4 servers).
+housekeeping needed to find and mount part or all of FedFS domain
+name spaces.
 
 The fedfsd program is an RPC server that allows remote administrators to
 create FedFS junctions in local file systems.  FedFS ADMIN requests that
diff --git a/doc/man/Makefile.am b/doc/man/Makefile.am
index 7f92ebf..83c6d03 100644
--- a/doc/man/Makefile.am
+++ b/doc/man/Makefile.am
@@ -24,6 +24,6 @@
 ##
 
 dist_man7_MANS		= fedfs.7
-dist_man8_MANS		= rpc.fedfsd.8 mount.fedfs.8
+dist_man8_MANS		= rpc.fedfsd.8 mount.fedfs.8 fedfs-map-nfs4.8
 CLEANFILES		= cscope.in.out cscope.out cscope.po.out
 DISTCLEANFILES		= Makefile.in
diff --git a/doc/man/fedfs-map-nfs4.8 b/doc/man/fedfs-map-nfs4.8
new file mode 100644
index 0000000..ffc5b6a
--- /dev/null
+++ b/doc/man/fedfs-map-nfs4.8
@@ -0,0 +1,154 @@
+.\"@(#)fedfs-map-nfs4.8"
+.\"
+.\" @file doc/man/fedfs-map-nfs4.8
+.\" @brief man page for fedfs-map-nfs4 command
+.\"
+
+.\"
+.\" Copyright 2011 Oracle.  All rights reserved.
+.\"
+.\" This file is part of fedfs-utils.
+.\"
+.\" fedfs-utils is free software; you can redistribute it and/or modify
+.\" it under the terms of the GNU General Public License version 2.0 as
+.\" published by the Free Software Foundation.
+.\"
+.\" fedfs-utils is distributed in the hope that it will be useful, but
+.\" WITHOUT ANY WARRANTY; without even the implied warranty of
+.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+.\" GNU General Public License version 2.0 for more details.
+.\"
+.\" You should have received a copy of the GNU General Public License
+.\" version 2.0 along with fedfs-utils.  If not, see:
+.\"
+.\"	http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt
+.\"
+.TH FEDFS-MAP-NFS4 8 "30 Apr 2011"
+.SH NAME
+fedfs-map-nfs4 \- generate automounter program map entries for FedFS
+.SH SYNOPSIS
+.B fedfs-map-nfs4
+.I domainname
+.SH INTRODUCTION
+RFC 5716 introduces the Federated File System (FedFS, for short).
+FedFS is an extensible standardized mechanism
+by which system administrators construct
+a coherent namespace across multiple file servers using
+.IR "file system referrals" .
+For further details, see
+.BR fedfs (7).
+.SH DESCRIPTION
+The
+.BR fedfs-map-nfs4 (8)
+command provides a FedFS program map for the local system's automounter.
+Although it is typically intended to be invoked by the automounter,
+it is also safe to invoke directly for scripting or debugging purposes.
+See
+.BR autofs (5)
+for information about how program maps work.
+.SS Operation
+The
+.BR fedfs-map-nfs4 (8)
+command locates FedFS domains by looking for DNS SRV records
+that advertise file servers exporting domain root replicas.
+The
+.I domainname
+argument determines what FedFS domain is to be mounted.
+.P
+It retrieves and sorts the domain root replica records
+according to SRV record sorting rules outlined in RFC 2782.
+It then generates a sun format map entry on
+.I stdout
+representing the set of servers contained in the SRV record,
+a standard export path to the domain root,
+and appropriate NFS mount options.
+Error messages are output on
+.IR stderr .
+.SS Globally useful names
+Across all FedFS-enabled file system clients,
+a unique file object in a FedFS domain is always accessed
+via the same pathname.
+Such pathnames are referred to as
+.IR "globally useful names" .
+See
+.BR fedfs (7)
+for a full discussion.
+.P
+The top-level directory of a globally useful name is always
+the networked file system type (NFS version 4, CIFS, and so on).
+A
+.BR fedfs-map-nfs4 (8)
+program map entry is used with the NFS version 4 top-level directory
+to provide globally useful names via the NFS version 4 protocol.
+.SH EXAMPLES
+Typically, a
+.BR fedfs-map-nfs4 (8)
+entry in
+.I /etc/auto.master
+looks like this:
+.P
+.NF
+.TA 2.5i +0.7i +0.7i
+	/nfs4	/usr/sbin/fedfs-map-nfs4
+.FI
+.P
+Under the /nfs4 directory on the local system, the automounter uses
+.BR fedfs-map-nfs4 (8)
+to convert a FedFS domain name to a set of servers and an export path,
+which are then passed to
+.BR mount.nfs (8).
+.P
+The automounter mounts this FedFS domain on the directory
+.IR /nfs4/domainname .
+Note that this also works for dot-prefixed domain names, in order to
+support mounting read-write domain root replicas.
+.P
+After configuring and restarting
+.BR autofs ,
+to access files in the
+.I example.net
+FedFS domain, for instance, you can start with:
+.RS
+.sp
+cd /nfs4/example.net
+.sp
+.RE
+The automounter uses the
+.BR fedfs-map-nfs4 (8)
+command to look up the file servers that provide the domain root for the
+.I example.net
+domain.  It then mounts one of these servers on
+.IR /nfs4/example.net .
+.P
+If the
+.BR fedfs-map-nfs4 (8)
+command cannot find the requested domain, no local directory is created
+and no mount operation is performed.  Applications receive an ENOENT
+error in this case.
+.P
+While these mounted domains remain active on the local system,
+the mounted-on directories remain visible.
+After a period of inactivity, the automounter automatically unmounts
+a FedFS domain.
+Local applications browsing the top-level directory
+do not see all available FedFS domains.  They see only the ones that
+are mounted and active.
+.SH FILES
+.TP 18n
+.I /etc/auto.master
+master automounter map
+.SH "SEE ALSO"
+.BR fedfs (7),
+.BR nfs (5),
+.BR autofs (5),
+.sp
+RFC 2782 for a discussion of DNS SRV records
+.sp
+RFC 5716 for FedFS requirements and overview
+.SH COLOPHON
+This page is part of the fedfs-utils package.
+A description of the project and information about reporting bugs
+can be found at
+.IR http://oss.oracle.com/projects/fedfs-utils .
+.SH "AUTHOR"
+Chuck Lever <chuck.lever@oracle.com>
diff --git a/doc/man/fedfs.7 b/doc/man/fedfs.7
index a2d2759..83eb215 100644
--- a/doc/man/fedfs.7
+++ b/doc/man/fedfs.7
@@ -164,7 +164,8 @@ file system below them,
 are visible at a different point in a client's name space
 than are read-only replicas.
 .SS Globally Useful Names
-On FedFS-enabled Linux clients, the
+On FedFS-enabled Linux clients,
+either the automounter, with a special program map, or the
 .BR mount.fedfs (8)
 command finds and mounts the root of a FedFS domain.
 .P
@@ -258,6 +259,7 @@ when administering junctions and filesets,
 junctions are created on file servers and
 registered with the domain's NSDB in two separate steps.
 .SH SEE ALSO
+.BR fedfs-map-nfs4 (8),
 .BR mount.fedfs (8),
 .BR rpc.fedfsd (8),
 .BR rpc.mountd (8),
diff --git a/src/mount/Makefile.am b/src/mount/Makefile.am
index 9338d47..93c6b72 100644
--- a/src/mount/Makefile.am
+++ b/src/mount/Makefile.am
@@ -24,7 +24,10 @@
 ##
 
 noinst_HEADERS		= nls.h
-sbin_PROGRAMS		= mount.fedfs
+sbin_PROGRAMS		= mount.fedfs fedfs-map-nfs4
+fedfs_map_nfs4_SOURCES	= fedfs-map-nfs4.c
+fedfs_map_nfs4_LDADD	= -lresolv \
+			  $(top_builddir)/src/libsi/libsi.a
 mount_fedfs_SOURCES	= main.c
 mount_fedfs_LDADD	= -lresolv \
 			  $(top_builddir)/src/libsi/libsi.a
diff --git a/src/mount/fedfs-map-nfs4.c b/src/mount/fedfs-map-nfs4.c
new file mode 100644
index 0000000..8376b6b
--- /dev/null
+++ b/src/mount/fedfs-map-nfs4.c
@@ -0,0 +1,242 @@
+/**
+ * @file src/mount/fedfs-map-nfs4.c
+ * @brief Convert FedFS domain name key to automounter map entry
+ */
+
+/*
+ * Copyright 2011 Oracle.  All rights reserved.
+ *
+ * This file is part of fedfs-utils.
+ *
+ * fedfs-utils is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2.0 as
+ * published by the Free Software Foundation.
+ *
+ * fedfs-utils is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License version 2.0 for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * version 2.0 along with fedfs-utils.  If not, see:
+ *
+ *	http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/socket.h>
+#include <sys/mount.h>
+#include <sys/wait.h>
+
+#include <stdbool.h>
+#include <string.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <libgen.h>
+#include <errno.h>
+#include <getopt.h>
+#include <locale.h>
+#include <netdb.h>
+#include <langinfo.h>
+
+#include "nls.h"
+#include "getsrvinfo.h"
+#include "token.h"
+#include "gpl-boiler.h"
+
+/**
+ * Name of SRV record containing NFSv4 r/o FedFS root
+ */
+#define FEDFS_NFS4_DOMAINROOT_RO	"_nfs4._domainroot._tcp"
+
+/**
+ * Name of SRV record containing NFSv4 r/w FedFS root
+ */
+#define FEDFS_NFS4_DOMAINROOT_RW	"_nfs4._write._domainroot._tcp"
+
+/**
+ * Export path of NFSv4 r/o FedFS root
+ */
+#define FEDFS_NFS4_EXPORTPATH_RO	"/.domainroot"
+
+/**
+ * Export path of NFSv4 r/w FedFS root
+ */
+#define FEDFS_NFS4_EXPORTPATH_RW	"/.domainroot-write"
+
+char *progname;
+
+/**
+ * Display usage message
+ */
+static void
+fedfs_map_usage(void)
+{
+	printf(_("\nUsage: %s [domain]\n\n"), progname);
+
+	printf("%s", fedfs_gpl_boilerplate);
+}
+
+/**
+ * Construct an NFSv4 map entry for "domainname" with one server
+ *
+ * @param si single-entry list of SRV records
+ * @param rw_replica true if a R/W domain root replica was requested
+ * @param domainname NUL-terminated UTF-8 string containing name of FedFS domain
+ * @return command exit status
+ */
+static int fedfs_map_nfs4_oneserver(struct srvinfo *si, _Bool rw_replica,
+		const char *domainname)
+{
+	printf("-fstype=nfs,vers=4,fg");
+	if (si->si_port != 2049)
+		printf(",port=%u", si->si_port);
+	printf(" %s:%s-%s\n", si->si_target,
+		rw_replica ? FEDFS_NFS4_EXPORTPATH_RW :
+			     FEDFS_NFS4_EXPORTPATH_RO, domainname);
+	return 0;
+}
+
+/**
+ * Construct an NFSv4 map entry for "domainname" with multiple servers
+ *
+ * @param si list of SRV records for requested FedFS domain
+ * @param rw_replica true if a R/W domain root replica was requested
+ * @param domainname NUL-terminated UTF-8 string containing name of FedFS domain
+ * @return command exit status
+ */
+static int fedfs_map_nfs4_replicas(struct srvinfo *si, _Bool rw_replica,
+		const char *domainname)
+{
+	struct srvinfo *cur;
+	unsigned short port;
+	_Bool comma;
+
+	/*
+	 * Unfortunately our automounter can't handle a list of
+	 * replicas where the various servers live on different
+	 * ports from one another.
+	 */
+	port = si->si_port;
+	for (cur = si; cur != NULL; cur = cur->si_next)
+		if (cur->si_port != port) {
+			fprintf(stderr, _("%s: Replicas on different ports not supported\n"),
+				progname);
+			return 1;
+		}
+
+	if (port != 2049)
+		printf("-fstype=nfs,vers=4,fg,port=%u ", port);
+	else
+		printf("-fstype=nfs,vers=4,fg ");
+
+	/*
+	 * Note that the export path is required to be indentical
+	 * for all domain root servers for this domain.
+	 */
+	for (comma = false, cur = si; cur != NULL; cur = cur->si_next) {
+		if (comma)
+			printf(",");
+		printf("%s(%u)", cur->si_target, cur->si_weight);
+		comma = true;
+	}
+	printf(":%s-%s\n", rw_replica ? FEDFS_NFS4_EXPORTPATH_RW :
+		     FEDFS_NFS4_EXPORTPATH_RO, domainname);
+
+	return 0;
+}
+
+/**
+ * Construct an NFSv4 map entry for "domainname"
+ *
+ * @param domainname NUL-terminated UTF-8 string containing name of FedFS domain
+ * @return command exit status
+ */
+static int fedfs_map_nfs4(const char *domainname)
+{
+	struct srvinfo *cur, *si = NULL;
+	unsigned int count;
+	int error, result;
+	_Bool rw_replica;
+	char *rr;
+
+	rw_replica = false;
+	if (domainname[0] == '.') {
+		rw_replica = true;
+		domainname++;
+	}
+
+	result = 1;
+	rr = rw_replica ? FEDFS_NFS4_DOMAINROOT_RW : FEDFS_NFS4_DOMAINROOT_RO;
+	error = getsrvinfo(rr, domainname, &si);
+	switch (error) {
+	case ESI_SUCCESS:
+		break;
+	case ESI_NONAME:
+		fprintf(stderr, _("%s: Domain name %s not found\n"),
+			progname, domainname);
+		goto out;
+	case ESI_SERVICE:
+		fprintf(stderr, _("%s: No FedFS domain root available for %s\n"),
+			progname, domainname);
+		goto out;
+	default:
+		fprintf(stderr, _("%s: Failed to resolve %s: %s\n"),
+			progname, domainname, gsi_strerror(error));
+		goto out;
+	}
+
+	for (count = 0, cur = si; cur != NULL; cur = cur->si_next)
+		count++;
+	if (count == 1)
+		result = fedfs_map_nfs4_oneserver(si, rw_replica,
+								domainname);
+	else
+		result = fedfs_map_nfs4_replicas(si, rw_replica,
+								domainname);
+
+out:
+	freesrvinfo(si);
+	return result;
+}
+
+/**
+ * Program entry point
+ *
+ * @param argc count of command line arguments
+ * @param argv array of NUL-terminated C strings containing command line arguments
+ * @return program exit status
+ */
+int main(int argc, char *argv[])
+{
+	/* Ensure UTF-8 strings can be handled transparently */
+	if (setlocale(LC_CTYPE, "") == NULL ||
+	    strcmp(nl_langinfo(CODESET), "UTF-8") != 0) {
+		fprintf(stderr, _("Failed to set locale and langinfo\n"));
+		return 1;
+	}
+
+	progname = basename(argv[0]);
+
+	if (argc != 2) {
+		fedfs_map_usage();
+		return 1;
+	}
+
+	if (strcmp(progname, "fedfs-map-nfs4") == 0)
+		return fedfs_map_nfs4(argv[1]);
+#ifdef EXAMPLE
+	/* CIFS support might plug in here */
+	else if (strcmp(progname, "fedfs-map-cifs") == 0)
+		return fedfs_map_cifs(argv[1]);
+#endif
+
+	fprintf(stderr, _("%s: Unsupported file system type\n"), progname);
+	return 1;
+}
