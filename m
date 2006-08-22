From: "Gordon Lack" <gml4410@ggr.co.uk>
Subject: Enhancement patch for autofs v4.1.4 init.d script
Date: Tue, 22 Aug 2006 15:18:25 +0100
Message-ID: <44EB1231.7ABAA89B@ggr.co.uk>
References: <44AE7785.74E63D70@ggr.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary=------------98A69FFAB66F3071292E01F7
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
--------------98A69FFAB66F3071292E01F7
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit

   The init.d autofs script runs a check for "maps within maps"
(actually mountpoints within mountpoints) which it does by looping over
all knownmaps and grepping for a start-of-line match in both directions
(ie: 2 greps).

   I was testing some things on a system with 39 maps and was surprised
to find the autofs script took 38 seconds to report on required
reloads.  Testing showed that there were ~3000 runs of grep called by
this piece of code.

   It is possible to do the same test with internal case statements. 
This removes ~3000 calls to grep (I have another system with 49 map, so
it gets nearly 5000...).  With this fix applied the autofs script ran in
one quarter of the time.
--------------98A69FFAB66F3071292E01F7
Content-Type: text/plain;
 charset=us-ascii;
 name=enhance.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=enhance.patch

--- autofs-4.1.4/samples/rc.autofs.in	2006-08-22 14:48:51.000000000 +0100
+++ autofs.enhance	2006-08-22 14:49:51.000000000 +0100
@@ -233,11 +233,21 @@
 	    # another map or another map, maps on top of it.
 	    for knownmap in $knownmaps
 	    do	
-		if [ "`echo $dir/ | grep ^$knownmap`" != "" \
-			-o "`echo $knownmap | grep ^$dir/`" != "" \]
-		then 
-		    continue 2
-		fi
+# This gets run for all maps on all maps, so is O(n^2)
+# This means 3500 external grep calls for 38 map entries,
+# which is slow.  case statements make it much faster.
+#
+#		if [ "`echo $dir/ | grep ^$knownmap`" != "" \
+#			-o "`echo $knownmap | grep ^$dir/`" != "" \]
+#		then 
+#		    continue 2
+#		fi
+                case "$dir/" in
+                $knownmap*)   continue 2 ;;
+                esac
+                case "$knownmap" in
+                $dir/*)   continue 2 ;;
+                esac
 	    done
 
 	    if [ ! -z "$dir" -a ! -z "$map" \

--------------98A69FFAB66F3071292E01F7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------98A69FFAB66F3071292E01F7--

