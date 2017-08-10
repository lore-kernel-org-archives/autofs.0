From: Oscar Salvador <osalvador@suse.com>
Subject: [PATCH] Test for ldap connectivity during lookup_ldap initialization
Date: Thu, 10 Aug 2017 23:15:21 +0200
Message-ID: <1502399721-2491-1-git-send-email-osalvador@suse.com>
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org
Cc: Oscar Salvador <osalvador@suse.com>, Jeff Mahoney <jeffm@suse.com>

Right now we are just checking and parsing the ldap's configuration
in lookup_init() function, and if everything goes well we return a zero
value indicating that everything worked fine.

This has a problem, because in the case we set ldap method in
/etc/nsswitch.conf, configuration parsing goes fine but ldap is not working,
we will return a zero value in lookup_init() function, so autofs will move on,
but then we will return NSS_STATUS_UNAVAIL in lookup_read_master() function
once do_reconnect() fails, and because of this autofs will not be able to
reread the maps.

NIS already handles this by testing for server connectivity during initialization.
This patch does the same thing for LDAP.

Signed-off-by: Oscar Salvador <osalvador@suse.com>
Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 modules/lookup_ldap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
index 98701e5..29a67a5 100644
--- a/modules/lookup_ldap.c
+++ b/modules/lookup_ldap.c
@@ -1681,6 +1681,7 @@ static int do_init(const char *mapfmt,
 		   int argc, const char *const *argv,
 		   struct lookup_context *ctxt, unsigned int reinit)
 {
+	struct ldap_conn conn;
 	unsigned int is_amd_format;
 	int ret;
 
@@ -1810,6 +1811,12 @@ static int do_init(const char *mapfmt,
 		}
 	}
 
+	memset(&conn, 0, sizeof(struct ldap_conn));
+	ret = do_reconnect (LOGOPT_ANY, &conn, ctxt);
+	if (ret != NSS_STATUS_SUCCESS)
+		return 1;
+
+	unbind_ldap_connection(LOGOPT_ANY, &conn, ctxt);
 	return ret;
 }
 
-- 
2.12.3

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
