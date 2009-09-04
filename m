From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] check the return code from ldap_parse_result
Date: Fri, 04 Sep 2009 14:09:05 -0400
Message-ID: <x49bplqvaym.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: raven@themaw.net
Cc: autofs@linux.kernel.org

Hi, Ian,

Here's another trivialish patch.  If ldap_parse_result returns anything
other than LDAP_SUCCESS, the values of the result pointers are
undefined.

Cheers,
Jeff

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
index d0cbdca..33ca23e 100644
--- a/modules/lookup_ldap.c
+++ b/modules/lookup_ldap.c
@@ -2017,6 +2017,12 @@ do_paged:
 		sp->cookie = NULL;
 	}
 
+	if (rv != LDAP_SUCCESS) {
+		debug(ap->logopt,
+		      MODPREFIX "ldap_parse_result failed with %d", rv);
+		goto out_free;
+	}
+
 	/*
 	 * Parse the page control returned to get the cookie and
 	 * determine whether there are more pages.
@@ -2033,8 +2039,8 @@ do_paged:
 	if (returnedControls)
 		ldap_controls_free(returnedControls);
 
+out_free:
 	ldap_control_free(pageControl);
-
 	return rv;
 }
