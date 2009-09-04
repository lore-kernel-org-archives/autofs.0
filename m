From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] parse_sun.c: get rid of unused optlen variable
Date: Fri, 04 Sep 2009 14:22:47 -0400
Message-ID: <x493a72vabs.fsf@segfault.boston.devel.redhat.com>
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

I couldn't find a reason to keep this around.  We don't walk this
options string, so it isn't used to make sure we don't walk off the
end.  So, get rid of it.

Cheers,
Jeff

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/modules/parse_sun.c b/modules/parse_sun.c
index db36ae2..921daf4 100644
--- a/modules/parse_sun.c
+++ b/modules/parse_sun.c
@@ -1334,7 +1334,7 @@ int parse_mount(struct autofs_point *ap, const char *name,
 	char *pmapent, *options;
 	const char *p;
 	int mapent_len, rv = 0;
-	int optlen, cur_state;
+	int cur_state;
 	int slashify = ctxt->slashify_colons;
 	unsigned int append_options;
 
@@ -1389,7 +1389,6 @@ int parse_mount(struct autofs_point *ap, const char *name,
 		logerr(MODPREFIX "strdup: %s", estr);
 		return 1;
 	}
-	optlen = strlen(options);
 
 	p = skipspace(pmapent);
