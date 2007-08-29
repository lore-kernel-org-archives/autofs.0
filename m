From: "Ryan Thomas" <Ryan.Thomas@nuance.com>
Subject: autofs 5 and large groups
Date: Wed, 29 Aug 2007 07:48:48 -0400
Message-ID: <2AB5541EB33172459EE430FFB66B1EE90236387D@BN-EXCH01.nuance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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
To: autofs@linux.kernel.org


I've recently run into an issue with autofs 5 when using groups with a large number of members.  The issue is that getgrgid_r doesn't always fit in a _SC_GETGR_R_SIZE_MAX sized buffer.  Here is a patch that solves this problem by attempting larger and larger buffer sizes if the group structure exceeds _SC_GETGR_R_SIZE_MAX.  

This patch is very similar to the one that recently went into the NFS4 libnfsidmap code.  See http://marc.info/?l=linux-nfsv4&m=116311577732733&w=2


--- autofs-5.0.1/daemon/indirect.c.biggroup     2007-08-29 07:26:25.000000000 -0400
+++ autofs-5.0.1/daemon/indirect.c      2007-08-29 07:27:11.000000000 -0400
@@ -844,16 +844,27 @@
                goto cont;
        }
 
-       gr_tmp = malloc(tmplen + 1);
-       if (!gr_tmp) {
-               error(ap->logopt, "failed to malloc buffer for getgrgid_r");
-               free(tsv->user);
-               free(tsv->home);
-               free(tsv);
-               goto cont;
-       }
+       do {
+         status = ENOMEM;
+
+         gr_tmp = malloc(tmplen + 1);
+         if (!gr_tmp) {
+           error(ap->logopt, "failed to malloc buffer for getgrgid_r");
+           free(tsv->user);
+           free(tsv->home);
+           free(tsv);
+           goto cont;
+         }
+         pgr = &gr;
+         status = getgrgid_r(mt->gid, pgr, gr_tmp, tmplen, ppgr);
+         if (ppgr == NULL && !status)
+           status = ENOENT;
+         if (status == ERANGE) {
+           tmplen *= 2;
+           free(gr_tmp);
+         }
+       } while (status == ERANGE);
 
-       status = getgrgid_r(mt->gid, pgr, gr_tmp, tmplen, ppgr);
        if (status) {
                error(ap->logopt, "failed to get group info from getgrgid_r");
                free(tsv->user);
--- autofs-5.0.1/daemon/direct.c.biggroup       2007-08-29 07:26:25.000000000 -0400
+++ autofs-5.0.1/daemon/direct.c        2007-08-29 07:27:01.000000000 -0400
@@ -1364,16 +1364,27 @@
                goto cont;
        }
 
-       gr_tmp = malloc(tmplen + 1);
-       if (!gr_tmp) {
-               error(ap->logopt, "failed to malloc buffer for getgrgid_r");
-               free(tsv->user);
-               free(tsv->home);
-               free(tsv);
-               goto cont;
-       }
+       do {
+         status = ENOMEM;
+
+         gr_tmp = malloc(tmplen + 1);
+         if (!gr_tmp) {
+           error(ap->logopt, "failed to malloc buffer for getgrgid_r");
+           free(tsv->user);
+           free(tsv->home);
+           free(tsv);
+           goto cont;
+         }
+         pgr = &gr;
+         status = getgrgid_r(mt->gid, pgr, gr_tmp, tmplen, ppgr);
+         if (ppgr == NULL && !status)
+           status = ENOENT;
+         if (status == ERANGE) {
+           tmplen *= 2;
+           free(gr_tmp);
+         }
+       } while (status == ERANGE);
 
-       status = getgrgid_r(mt->gid, pgr, gr_tmp, tmplen, ppgr);
        if (status) {
                error(ap->logopt, "failed to get group info from getgrgid_r");
                free(tsv->user);
