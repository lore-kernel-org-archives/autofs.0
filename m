From: Jeff Moyer <jmoyer@redhat.com>
Subject: [autofs4 patch] check for a negative return from
	is_local_mount
Date: Wed, 01 Nov 2006 19:14:00 -0500
Message-ID: <x49bqnq66yf.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <ikent@redhat.com>, autofs mailing list <autofs@linux.kernel.org>

Hi, Ian, list,

get_best_mount is documented as returning the following:

return -1 and what = '\0' on error,
        1 and what = local mount path if local bind,
  else  0 and what = remote mount path

However, we get the return values incorrect in one case:

get_best_mount():
		if (is_local_mount(p) > 0) {
			debug(MODPREFIX "host %s: is localhost", p);

			/* Strip off hostname and ':' */
			delim = strchr(p,':');
			while (delim && *delim != '\0') {
				delim++;
				*what = *delim;
				what++;
			}
			return 1;
		}

		return 0;

is_local_mount can return -1 if there is a host name lookup failure.
However, we don't check for the negative return value, and hence return 0
(success) when we shouldn't.  When using /net, this actually results in an
attempt to perform a bind mount of the directory to itself!  Before the
kernel patch went in to prevent infinite recursions of this type, it would
end up panicking the system.

The fix is much simpler than the explanation.  Review/comments appreciated.

Thanks,

Jeff

diff --git a/modules/mount_nfs.c b/modules/mount_nfs.c
index 8bede48..7d46a86 100644
--- a/modules/mount_nfs.c
+++ b/modules/mount_nfs.c
@@ -187,6 +187,8 @@ int get_best_mount(char *what, const cha
 	 *  do anything except strip whitespace from the end of the string.
 	 */
 	if (!strchr(p, ',') && (strchr(p,':') == strrchr(p,':'))) {
+		int ret;
+
 		for (pstrip = p+strlen(p) - 1; pstrip >= p; pstrip--) {
 			if (!isspace(*pstrip))
 				break;
@@ -194,7 +196,8 @@ int get_best_mount(char *what, const cha
 		}
 
 		/* Check if the host is the localhost */
-		if (is_local_mount(p) > 0) {
+		ret = is_local_mount(p);
+		if (ret > 0) {
 			debug(MODPREFIX "host %s: is localhost", p);
 
 			/* Strip off hostname and ':' */
@@ -205,8 +208,10 @@ int get_best_mount(char *what, const cha
 				what++;
 			}
 			return 1;
-		}
-		return 0;
+		} else if (ret < 0)
+			*what = '\0';
+
+		return ret;
 	}
 
 	while (p && *p) {
