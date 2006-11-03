From: Jeff Moyer <jmoyer@redhat.com>
Subject: [autofs4 patch] allow one to specify multiple direct maps
Date: Fri, 03 Nov 2006 18:51:21 -0500
Message-ID: <x497iyc143q.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: Ian Kent <raven@themaw.net>, autofs mailing list <autofs@linux.kernel.org>

Hi, Ian, list,

Currently, the autofs init script filters out all duplicate map names.
This patch turns off that filtering for direct maps, allowing multiple "/-"
keys in the master map.

This was tested successfully on my systems here.  Comments welcome.

-Jeff

diff --git a/samples/rc.autofs.in b/samples/rc.autofs.in
index 8cd3eb1..d00f2ab 100644
--- a/samples/rc.autofs.in
+++ b/samples/rc.autofs.in
@@ -253,15 +253,18 @@ function getmounts()
 	    fi
 
 	    # Do not include a map if it is a duplicate, maps on top of
-	    # another map or another map, maps on top of it.
-	    for knownmap in $knownmaps
-	    do	
-		if [ "`echo $dir/ | grep ^$knownmap`" != "" \
-			-o "`echo $knownmap | grep ^$dir/`" != "" \]
-		then 
-		    continue 2
-		fi	
-	    done
+	    # another map or another map maps on top of it, unless it's
+	    # a direct map.
+	    if [ x`echo $dir | grep -E "^/-"` == 'x' ]; then
+		for knownmap in $knownmaps
+		do
+		    if [ "`echo $dir/ | grep ^$knownmap`" != "" \
+			    -o "`echo $knownmap | grep ^$dir/`" != "" \]
+		    then
+			continue 2
+		    fi
+		done
+	    fi
 
 	    if [ ! -z "$dir" -a ! -z "$map" \
 			-a x`echo "$map" | cut -c1` != 'x-' ]
