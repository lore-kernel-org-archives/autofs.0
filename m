From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] fix SIGSEGV when yp domain not bound
Date: Tue, 4 May 2004 13:24:29 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16535.53709.132008.904350@segfault.boston.redhat.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
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
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Hi Ian, list,

If you happen to find your systems unable to communicate with the yp
server, the subprocess launched to automount a share will receive a
SIGSEGV, because we only check for err == YPERR_KEY in the lookup_yp
module.  We get a different error, of course, and then go on to do a
cache_update with NULL values.  Here is a patch which addresses this
issue.  Comments more than welcome.  Oh, and I took the liberty of doing
minor reformatting; I hope you don't mind, Ian.

-Jeff

--- autofs-4.1.2/modules/lookup_yp.c~	2004-01-29 11:01:22.000000000 -0500
+++ autofs-4.1.2/modules/lookup_yp.c	2004-05-04 13:13:05.000000000 -0400
@@ -195,19 +195,26 @@
 	}
 
 	if (!me) {
-		/* For reasons unknown, the standard YP definitions doesn't define input
-		   strings as const char *.  However, my understanding is that they will
-		   not be modified by the library. */
+		/* For reasons unknown, the standard YP definitions doesn't
+		   define input strings as const char *.  However, my
+		   understanding is that they will not be modified by the
+		   library. */
 		err = yp_match((char *) ctxt->domainname, (char *) ctxt->mapname,
 			       (char *) name, name_len, &mapent, &mapent_len);
 
-		if (err == YPERR_KEY) {
+		if (err != YPERR_SUCCESS) {
+			if (err != YPERR_KEY)
+				goto out_err;
+
 			/* See if there is an entry "root/name" */
 			key_len = sprintf(key, "%s/%s", root, name);
-			err = yp_match((char *) ctxt->domainname, (char *) ctxt->mapname,
+			err = yp_match((char *) ctxt->domainname, 
+				       (char *) ctxt->mapname,
 				       key, key_len, &mapent, &mapent_len);
 
-			if (err == YPERR_KEY) {
+			if (err != YPERR_SUCCESS) {
+				if (err != YPERR_KEY)
+					goto out_err;
 				/* 
 				 * Try to get the "*" entry if there is one i
 				 * - note that we *don't* modify "name" so
@@ -215,18 +222,13 @@
 				 */
 				err =
 				    yp_match((char *) ctxt->domainname,
-					     (char *) ctxt->mapname, "*", 1, &mapent,
-					     &mapent_len);
+					     (char *) ctxt->mapname, "*", 1, 
+					     &mapent, &mapent_len);
 			} else
 				cache_update(key, mapent, age);
 
-			if (err) {
-				warn(MODPREFIX "lookup for %s failed: %s", name,
-				     yperr_string(err));
-				if (mapent)
-					free(mapent);
-				return 1;
-			}
+			if (err)
+				goto out_err;
 		} else
 			cache_update(name, mapent, age);
 	}
@@ -238,6 +240,12 @@
 	rv = ctxt->parse->parse_mount(root, name, name_len, mapent, ctxt->parse->context);
 	free(mapent);
 	return rv;
+
+out_err:
+	warn(MODPREFIX "lookup for %s failed: %s", name, yperr_string(err));
+	if (mapent)
+		free(mapent);
+	return 1;
 }
 
 int lookup_done(void *context)
