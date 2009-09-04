From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] Get rid of a bogus assignment in
	defaults_free_searchdns
Date: Fri, 04 Sep 2009 14:15:14 -0400
Message-ID: <x497hwevaod.fsf@segfault.boston.devel.redhat.com>
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

tssia.

Cheers,
Jeff

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/lib/defaults.c b/lib/defaults.c
index 17164bd..0aafa8b 100644
--- a/lib/defaults.c
+++ b/lib/defaults.c
@@ -532,7 +532,6 @@ void defaults_free_searchdns(struct ldap_searchdn *sdn)
 	struct ldap_searchdn *this = sdn;
 	struct ldap_searchdn *next;
 
-	next = this;
 	while (this) {
 		next = this->next;
 		free(this->basedn);
