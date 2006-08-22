From: "Gordon Lack" <gml4410@ggr.co.uk>
Subject: Bug (and patch) in autofs init.d script (v4.1.4)
Date: Tue, 22 Aug 2006 15:03:11 +0100
Message-ID: <44EB0E9E.1B101F71@ggr.co.uk>
References: <44AE7785.74E63D70@ggr.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary=------------435169F4C51961480968893D
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
--------------435169F4C51961480968893D
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit

    When comparing the running vs. expected commands for "autofs reload"
the autofs init.d script dosn't correctly handle changes to options. 
eg: If the LOCALOPTIONS have been extended it will not issue a Stop for
a running automount point, but will issue a Start for the new command
(which will fial, as the current process hasn't been stopped).  This is
because it is just doing a start-of-line anchored grep for a command.

    The attached patch fixes this by obtaining the full runnning command
for the particular mountpoint of interest and comparing this (verbatim)
against what it is expecting to see.  This allows for changes to the
options.

    It does assume that the automount point will be the second token
starting with a '/' in a full automount command line (the automount
command being the first such token).  I believe this will always be the
case.
--------------435169F4C51961480968893D
Content-Type: text/plain;
 charset=us-ascii;
 name=bug.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=bug.patch

--- autofs-4.1.4/samples/rc.autofs.in	2006-08-22 14:48:51.000000000 +0100
+++ autofs.bug	2006-08-22 14:52:02.000000000 +0100
@@ -562,7 +562,14 @@
 	ps axwww|grep "[0-9]:[0-9][0-9] $DAEMON " | (
 	    while read pid tt stat time command; do
 		echo "$command" >>$TMP2
-		if ! grep -q "^$command" $TMP1; then
+#   In order to check for changes we need to find the line, if any,
+# corresponding to this mountpoint with *any* options and see whether
+# it is what we want...this allows for changing options.
+# 
+#		if ! grep -q "^$command" $TMP1; then
+                mpoint=`get_fpath2 $command`
+                mpoint_com=`grep " $mpoint " $TMP1`
+                if [ "$command" !=  "$mpoint_com" ]; then
 		    if ! echo "$command" | grep -q -e --submount; then
 			kill -USR2 $pid 2> /dev/null
 			echo $"Stop $command"
@@ -574,7 +581,14 @@
 	    done
 	)
 	cat $TMP1 | ( while read x; do
-		if ! grep -q "^$x" $TMP2; then
+#   Again - we can't rely on the options being unchanged, so get the
+# command for this mountpoint and check it is there verbatim
+#
+#		if ! grep -q "^$x" $TMP2; then
+#
+                mpoint=`get_fpath2 $x`
+                mpoint_com=`grep " $mpoint " $TMP2`
+                if [ "$x" !=  "$mpoint_com" ]; then
 			$x
 			echo $"Start $x"
 		fi

--------------435169F4C51961480968893D
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------435169F4C51961480968893D--

