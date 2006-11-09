From: Jeff Moyer <jmoyer@redhat.com>
Subject: [autofs4 patch] Handle ldap entries with multiple cn's for
	a single key
Date: Wed, 08 Nov 2006 22:10:45 -0500
Message-ID: <x49r6wdnwlm.fsf@segfault.boston.devel.redhat.com>
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
To: raven@themaw.net, autofs@linux.kernel.org

Hi, Ian, list,  (sorry if this is a dup, mailer issues...)

This small patch fixes a rather odd problem noticed in the wild.
Basically, a customer had multiple cn's for the wildcard key.  The key
would show up in searches for "/" or "*".  So, when enumerating the
result set from ldap, we would try to mount the entry for each one of
those!  This, of course, would lead to an "already mounted" error, and
we would tear everything down due to the failure.

The fix is to stop once we find an entry that successfully mounts.
Comments welcome.

-Jeff

diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
index 3d0cba0..08a1c56 100644
--- a/modules/lookup_ldap.c
+++ b/modules/lookup_ldap.c
@@ -687,6 +687,10 @@ int lookup_mount(const char *root, const
 			debug(MODPREFIX "%s -> %s", key, mapent);
 			ret = ctxt->parse->parse_mount(root, name, name_len,
 						  mapent, ctxt->parse->context);
+			/* stop after the first successful mount */
+			if (ret == 0)
+				break;
+
 			me = cache_lookup_next(me);
 		}
 	} else {
