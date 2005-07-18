From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] clear whatstr in get_best_mount when host name
	lookup fails
Date: Mon, 18 Jul 2005 17:54:16 -0400
Message-ID: <17116.9480.197620.834203@segfault.boston.redhat.com>
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

Hi, Ian,

A "bug" was introduced into the get_best_mount function at some point.
Basically, if is_local_mount returns failure, we should be setting *what to
NULL, since this is what the caller checks:

        colon = strchr(whatstr, ':');
        if (!colon) {
                /* No colon, take this as a bind (local) entry */
                local = 1;
        } else if (!nosymlink) {
                local = get_best_mount(whatstr, what, 0);
                if (!*whatstr) {                <---------------
                        warn(MODPREFIX "no host elected");
                        return 1;
                }
                debug(MODPREFIX "from %s elected %s", what, whatstr);
        }

Prior to the patches in this area of code, we did indeed set *what to NULL
before returning in this specific case (the host name resolution failed,
and this was the only entry).

The way the code stands, you will end up failing the mount (for the very
same reason, the host name lookup will fail).  So, this patch is relatively
low on the priority scale.  However, it seems like a correctness issue to
me.  Otherwise, we should get rid of the check for *whatstr.

Let me know what you think.

Thanks,

Jeff

--- autofs/modules/mount_nfs.c.orig	2005-07-18 17:51:01.457544173 -0400
+++ autofs/modules/mount_nfs.c	2005-07-18 17:52:06.028840762 -0400
@@ -197,12 +197,13 @@ int get_best_mount(char *what, const cha
 	 *  do anything except strip whitespace from the end of the string.
 	 */
 	if (!is_replicated_entry(p)) {
+		int ret;
 		for (pstrip = p+strlen(p) - 1; pstrip >= p; pstrip--) 
 			if (isspace(*pstrip))
 				*pstrip = '\0';
 
 		/* Check if the host is the localhost */
-		if (is_local_mount(p) > 0) {
+		if ((ret = is_local_mount(p)) > 0) {
 			debug(MODPREFIX "host %s: is localhost", p);
 
 			/* Strip off hostname and ':' */
@@ -213,7 +214,9 @@ int get_best_mount(char *what, const cha
 				what++;
 			}
 			return 1;
-		}
+		} else if (ret < 0)
+			*what = '\0';
+
 		return 0;
 	}
