From: Anders Blomdell <anders.blomdell@control.lth.se>
Subject: Automount segfaults in do_mount_indirect
Date: Tue, 20 Feb 2007 16:05:15 +0100
Message-ID: <45DB0E2B.5030302@control.lth.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050208070806040108000406"
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
To: autofs@linux.kernel.org

This is a multi-part message in MIME format.
--------------050208070806040108000406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On Fedora Core 6 (autofs-5.0.1-0.rc3.21) I get occasional segfaults in 
do_mount_indirect, the issue seems to remain in 5.0.1 version. The attached 
patch seems to take care of the issue.

See also: http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=229344


-- 
Anders Blomdell                  Email: anders.blomdell@control.lth.se
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

--------------050208070806040108000406
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
	name="autofs-5.0.1-rc3-getXXXid_r.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="autofs-5.0.1-rc3-getXXXid_r.patch"

--- a/daemon/indirect.c	2007-02-20 14:51:08.000000000 +0100
+++ b/daemon/indirect.c	2007-02-20 14:53:32.000000000 +0100
@@ -806,8 +806,8 @@
 		goto cont;
 	}
 
-	status = getpwuid_r(mt->uid, ppw, pw_tmp, tmplen, pppw);
-	if (status) {
+	status = getpwuid_r(mt->uid, &pw, pw_tmp, tmplen, pppw);
+	if (status || !ppw) {
 		error(ap->logopt, "failed to get passwd info from getpwuid_r");
 		free(tsv);
 		free(pw_tmp);
@@ -853,8 +853,8 @@
 		goto cont;
 	}
 
-	status = getgrgid_r(mt->gid, pgr, gr_tmp, tmplen, ppgr);
-	if (status) {
+	status = getgrgid_r(mt->gid, &gr, gr_tmp, tmplen, ppgr);
+	if (status || !pgr) {
 		error(ap->logopt, "failed to get group info from getgrgid_r");
 		free(tsv->user);
 		free(tsv->home);

--------------050208070806040108000406
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------050208070806040108000406--

