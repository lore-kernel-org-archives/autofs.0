From: George Hansper <georgeh@anstat.com.au>
Subject: autofs 4.1.2 cannot use option: username=mydomain\\myuserid
Date: Wed, 14 Jul 2004 12:50:56 +1000
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40F49F90.6040707@anstat.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050503000505030107080507"
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

This is a multi-part message in MIME format.
--------------050503000505030107080507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I've just upgraded to Fedora Core 2, and the autofs has changed from 3.1.7 to 4.1.2.
Previously, I would automount Windows shares using an auto.smb file with an entry:

myshare  -fstype=smbfs,username=mydomain\\myuserid,password=insecure,uid=500,gid=500,fmask=775 ://winsvr/myshare

In the new autofs 4.1.2 package, the above entry provokes a bug which was not present before.
Windows requires the username to be of the form:

	mydomain\myuserid

The problem is that the new autofs strips ALL backslashes from the options, and supplies
mount.smb with:

	username=mydomainmyuserid

The attached patch fixes this, but I would suggest someone more familiar with the package
review it, since I have not analysed the source to any great depth.

Regards,
	George Hansper

--------------050503000505030107080507
Content-Type: text/x-patch;
 name="autofs-4.1.2-backslash.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="autofs-4.1.2-backslash.patch"

--- autofs-4.1.2/modules/parse_sun.c.orig	2004-02-04 02:23:21.000000000 +1100
+++ autofs-4.1.2/modules/parse_sun.c	2004-07-14 12:15:30.311818691 +1000
@@ -261,9 +261,12 @@
 	for (; *whence; whence++, n++) {
 		switch (*whence) {
 		case '\\':
-			quote = 1;
-			continue;
-
+			if( quote ) {
+				break;
+			} else {
+				quote = 1;
+				continue;
+			}
 		case ':':
 			if (expect_colon)
 				expect_colon = 0;
@@ -451,13 +454,17 @@
 	char *cp = ret;
 	const char *scp;
 	int origlen = strlen;
+	int quote = 0;
 
 	if (ret == NULL)
 		return NULL;
 
 	for (scp = str; strlen > 0 && *scp; scp++, strlen--) {
-		if (*scp == '\\')
+		if (*scp == '\\' && !quote ) {
+			quote = 1;
 			continue;
+		}
+		quote = 0;
 		*cp++ = *scp;
 	}
 	*cp = '\0';

--------------050503000505030107080507
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------050503000505030107080507--

