From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] fix multi maps that have an implied '/' entry
Date: Fri, 29 Apr 2005 15:53:03 -0400
Message-ID: <17010.37023.613781.405203@segfault.boston.redhat.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

This is apparently a legal format for a multi-mount map:

g3b     segfault.boston.redhat.com:/export/automount/export5/testing/test \
        /s1     segfault.boston.redhat.com:/export/automount/export2 \
        /s2     segfault.boston.redhat.com:/export/automount/export3

The first entry is an implied root level entry, or '/'.  Solaris handles
this case just fine, and the automounter test sweet uses this as one of its
tests.  The attached patch causes this map format to be recognized.  I
think the patch could probably re-use the memory allocatd for "path" by the
dequote function.  That's up to you, Ian, if you want to change that to be
a little prettier.

-Jeff

--- autofs-4.1.4/modules/parse_sun.c.orig	2005-04-29 15:39:39.604564968 -0400
+++ autofs-4.1.4/modules/parse_sun.c	2005-04-29 15:47:00.661514120 -0400
@@ -886,7 +886,18 @@ int parse_mount(const char *root, const 
 				return 1;
 			}
 
-			p += l;
+			if (*path != '/') {
+				free(path);
+				path = strdup("/");
+				if (!path) {
+					error(MODPREFIX "out of memory");
+					free(myoptions);
+					free(options);
+					multi_free_list(head);
+					return 1;
+				}
+			} else
+				p += l;
 			p = skipspace(p);
 
 			/* Local options are appended to per-map options */
