From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs-4.1.3 - fix mischief caused by changed
	default nonstrict -> sctrict
Date: Sun, 30 May 2004 21:17:15 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405302106510.13691@donald.themaw.net>
Mime-Version: 1.0
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs mailing list <autofs@linux.kernel.org>
Cc: Axel Thimm <Axel.Thimm@atrpms.net>, Michael Blandford <michael@kmaclub.com>


Problem: infinite error loop occurs when trying to access non-exitent
         directory.

This patch, for 4.1.3, fixes the problem caused when the default for
multi-mounts was changed from strict to non-strict. This change tickled
a bug in the old autofs4 kernel module found in 2.4 kernels and 2.6
kernels to date (ie. < 2.6.7).

This change in default caused a small change in mount logic which went
unnoticed and lead to this problem. So the kernel interaction problem
remains but is much less likely to occur. If this problem persists
after applying this patch then update your kernel autofs4.

The patch restores the previous logic but leaves the new default.

diff -Nur autofs-4.1.3.orig/modules/parse_sun.c autofs-4.1.3/modules/parse_sun.c
--- autofs-4.1.3.orig/modules/parse_sun.c	2004-05-18 20:22:40.000000000 +0800
+++ autofs-4.1.3/modules/parse_sun.c	2004-05-29 15:38:42.000000000 +0800
@@ -602,10 +602,8 @@
 			      options);
 	}

-	if (nonstrict && rv) {
-		debug("ignoring failure of non-strict mount");
-		return 0;
-	}
+	if (nonstrict && rv)
+		return -rv;

 	return rv;
 }
@@ -746,7 +744,11 @@
 			free(loc);
 			free(myoptions);

-			if (rv)
+			/* Convert non-strict failure into success */
+			if (rv < 0) {
+				rv = 0;
+				debug("parse_mount: ignoring failure of non-strict mount");
+			} else if (rv > 0)
 				break;

 		} while (*p == '/');
@@ -789,6 +791,10 @@
 		      options, loclen, loc);

 		rv = sun_mount(root, name, name_len, loc, loclen, options);
+		/* non-strict failure to normal failure for ordinary mount */
+		if (rv < 0)
+			rv = -rv;
+
 		free(loc);
 		free(options);
 	}
