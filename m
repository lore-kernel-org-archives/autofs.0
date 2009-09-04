From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] lib/master.c: get rid of unused name variable
Date: Fri, 04 Sep 2009 14:47:27 -0400
Message-ID: <x49pra6tum8.fsf@segfault.boston.devel.redhat.com>
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

Yet another trivial patch.

Cheers,
Jeff

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/lib/master.c b/lib/master.c
index e43f835..8455f40 100644
--- a/lib/master.c
+++ b/lib/master.c
@@ -152,7 +152,7 @@ master_add_map_source(struct master_mapent *entry,
 {
 	struct map_source *source;
 	char *ntype, *nformat;
-	const char **tmpargv, *name = NULL;
+	const char **tmpargv;
 
 	source = malloc(sizeof(struct map_source));
 	if (!source)
@@ -188,10 +188,6 @@ master_add_map_source(struct master_mapent *entry,
 	source->argc = argc;
 	source->argv = tmpargv;
 
-	/* Can be NULL for "hosts" map */
-	if (argv)
-		name = argv[0];
-
 	master_source_writelock(entry);
 
 	if (!entry->maps)
