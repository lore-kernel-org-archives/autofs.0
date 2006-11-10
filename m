From: "Gordon Lack" <gml4410@ggr.co.uk>
Subject: autofsv5 enhancement - map names in /proc/mounts
Date: Fri, 10 Nov 2006 12:05:51 +0000
Message-ID: <45546B1F.5030306@ggr.co.uk>
References: <44AE7785.74E63D70@ggr.co.uk> <4554696C.5030400@ggr.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary=------------020903040602060502090808
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4554696C.5030400@ggr.co.uk>
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

This is a multi-part message in MIME format.
--------------020903040602060502090808
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit

    The current entry which ends up in /proc/mounts for autofs entries 
looks like:

  automount /home autofs rw,fd=170,......

Other autofs implementations (Solaris, Irix, OSF1, ...) have the 
map-name which is being used as the first token.

The attached patch to daemon/indirect.c adds this (for indirect maps - I 
don't have any other kind...).

The result is lines like:

  auto.home /home autofs rw,fd=170,......


This does means that kernel mount entries (eg: those added under 
SElinux?) need to ignore the device name passed in, but they should be 
doing that for autofs file systems anyway.

NOTE: The ap->entry->first->argv[0] seems a contrived way to get a map 
name, but is all I could see looking through the code.

--------------020903040602060502090808
Content-Type: text/plain;
 name=indirect.c.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=indirect.c.patch

--- daemon/indirect.c.orig	2006-11-10 10:29:18.716266000 +0000
+++ daemon/indirect.c	2006-11-10 10:06:21.726654000 +0000
@@ -183,7 +183,11 @@
 		ap->dir_created = 1;
 	}
 
+/* GML - Enhancement
+ *   Put map name into /proc/mounts, as Solaris, Irix, OSF1, do
 	ret = mount("automount", ap->path, "autofs", MS_MGC_VAL, options);
+ */
+	ret = mount(ap->entry->first->argv[0], ap->path, "autofs", MS_MGC_VAL, options);
 	if (ret) {
 		crit(ap->logopt, "failed to mount autofs path %s", ap->path);
 		goto out_rmdir;

--------------020903040602060502090808
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------020903040602060502090808--

