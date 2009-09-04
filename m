From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] mount_autofs.c:mount_mount no need to increment val
Date: Fri, 04 Sep 2009 15:02:49 -0400
Message-ID: <x49hbvittwm.fsf@segfault.boston.devel.redhat.com>
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

No sense incrementing val since we never look at it again.

Cheers,
Jeff

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/modules/mount_autofs.c b/modules/mount_autofs.c
index afb1859..2a5d860 100644
--- a/modules/mount_autofs.c
+++ b/modules/mount_autofs.c
@@ -119,7 +119,7 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name,
 			else if (strncmp(cp, "timeout=", 8) == 0) {
 				char *val = strchr(cp, '=');
 				unsigned tout;
-				if (val++) {
+				if (val) {
 					int ret = sscanf(cp, "timeout=%u", &tout);
 					if (ret)
 						timeout = tout;
