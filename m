From: Chris Feist <cfeist@redhat.com>
Subject: [PATCH] Maps may be accidentally used from local directory
Date: Wed, 03 Nov 2004 15:36:02 -0600
Message-ID: <1099517762.3396.314.camel@gold.msp.redhat.com>
Reply-To: cfeist@redhat.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-0stjsjQbZT2VSURjqcHN"
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


--=-0stjsjQbZT2VSURjqcHN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

If you have a file/program in your current directory with the name of a
map listed in auto.master, the init script may use that file/program
instead of the one in /etc.

For example:
cat auto.master
/home auto.home

if you have the file auto.home in your current directory, the init
script will use that instead of the one in /etc/ or yp.  This patch
makes sure that a map is an absolute pathname (begins with a /) before
checking anywhere but /etc.

Thanks,
Chris

--=-0stjsjQbZT2VSURjqcHN
Content-Disposition: attachment; filename=autofs-4.1.3-init-cwd-map.patch
Content-Type: text/x-patch; name=autofs-4.1.3-init-cwd-map.patch;
	charset=UTF-8
Content-Transfer-Encoding: 7bit

--- autofs-4.1.3/samples/rc.autofs.in.orig	2004-05-10 08:57:14.000000000 -0500
+++ autofs-4.1.3/samples/rc.autofs.in	2004-11-03 15:30:34.060290822 -0600
@@ -199,12 +199,12 @@ function getmounts()
 		maptype=`echo $map | cut -f1 -d:`
 		# Handle degenerate map specifiers
 		if [ "$maptype" = "$map" ] ; then
-		    if [ -x "$map" ]; then
+		    if `echo $map | grep -q "^/"` && [ -x "$map" ]; then
 			maptype=program
 		    elif [ -x "/etc/$map" ]; then
 			maptype=program
 			map=`echo /etc/$map | sed 's^//^/^g'`
-		    elif [ -f "$map" ]; then
+		    elif `echo $map | grep -q "^/"` && [ -f "$map" ]; then
 			maptype=file
 		    elif [ "$map" = "hesiod" -o "$map" = "userhome" ] ; then
 			maptype=$map

--=-0stjsjQbZT2VSURjqcHN
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--=-0stjsjQbZT2VSURjqcHN--

