From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] more precise option parsing in init script
Date: Thu, 6 May 2004 16:36:21 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16538.41413.95001.9256@segfault.boston.redhat.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
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
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Hi Ian, List,

The current parsing out of daemon options in the init script can lead to
collisions with filesystem options.  For instance, if we see a -g, -t, -v,
or -d, we assume this is ghost, timeout, verbose, or debug, respectively.
In fact, this could be a filesystem option beginning with the same letter.
This patch addresses this issue.  I've done unit testing on each of the
expressions to ensure it matches where it should, and doesn't match where
it shouldn't.  If anyone on the list is especially gifted in regexp, please
review.

-Jeff

--- autofs-4.1.2/samples/rc.autofs.in.diffme	2004-05-06 16:07:18.459397224 -0400
+++ autofs-4.1.2/samples/rc.autofs.in	2004-05-06 16:08:46.357034752 -0400
@@ -152,35 +152,47 @@
 		# If the options include a -t or --timeout or a -g or --ghost
 		# parameter, then pull those particular options out.
 		: echo DAEMONOPTIONS OPTIONS $DAEMONOPTIONS $options
+
 		startupoptions=
-		if echo "$DAEMONOPTIONS" | grep -q -- '-t' ; then
-		    startupoptions="--timeout=$(echo $DAEMONOPTIONS $options | \
-		      sed 's/.*--*t\(imeout\)*[ \t=]*\([0-9][0-9]*\).*$/\2/g')"
-		fi
-		# Override timeout in $DAEMONOPTIONS with map $options
-		if echo "$options" | grep -q -- '-t' ; then
-		    startupoptions="--timeout=$(echo $DAEMONOPTIONS $options | \
+		if echo "$options" | grep -qE -- '\B-(t\b|-timeout\b=)' ;
+		then
+		    startupoptions="--timeout=$(echo $options |\
+			sed 's/.*-\(t[^0-9]*\|-timeout\)[ \t=]*\([0-9][0-9]*\).*$/\2/g')"
+		elif echo "$DAEMONOPTIONS" | grep -q -- '-t' ;
+		then
+		    # It's okay to be sloppy with DAEMONOPTIONS as there is no
+		    # possibility of conflicting with mount or map options.
+		    startupoptions="--timeout=$(echo $DAEMONOPTIONS | \
 		      sed 's/.*--*t\(imeout\)*[ \t=]*\([0-9][0-9]*\).*$/\2/g')"
 		fi
-		if echo "$DAEMONOPTIONS $options" | grep -q -- '-g' ; then
+
+		# Check for the ghost option
+		if echo "$options" | grep -qE -- '\B-(g\b|-ghost\b)' ;
+		then
 		    startupoptions="$startupoptions --ghost"
 		fi
-		if echo "$DAEMONOPTIONS $options" | grep -q -- '-v' ; then
+
+		# Check for verbose
+		if echo "$DAEMONOPTIONS $options" | \
+					grep -qE -- '\B-(v\b|-verbose\b)' ;
+		then
 		    startupoptions="$startupoptions --verbose"
 		fi
-		if echo "$DAEMONOPTIONS $options" | grep -q -- '-d' ; then
+
+		# Check for debug
+		if echo "$DAEMONOPTIONS $options" | \
+					grep -qE -- '\B-(d\b|-debug\b)' ;
+		then
 		    startupoptions="$startupoptions --debug"
 		fi
+
 		# Other option flags are intended for maps.
 		mapoptions="$(echo "$DAEMONOPTIONS $options" |\
-		      sed   's/--*t\(imeout\)*[ \t=]*\([0-9][0-9]*\)//g' |
-		      sed   's/--*g\(host\)*//g' |
-		      sed   's/--*v\(verbose\)*//g' |
-		      sed   's/--*d\(ebug\)*//g')"
-		if [ $STRIPDASH -eq 1 ] ; then
-		    mapoptions="$(echo "$mapoptions" |\
-			sed  's/^\([ \t]*-\)//g')"
-		fi
+		      sed   's/-\(t[^0-9]*\|-timeout\)[ \t=]*\([0-9][0-9]*\)//g' |
+		      sed   's/-\(g\b\|-ghost\b\)//g' |
+		      sed   's/-\(v\b\|-verbose\b\)//g' |
+		      sed   's/-\(d\b\|-debug\b\)//g')"
+
 		# Break up the maptype and map, if the map type is specified
 		maptype=`echo $map | cut -f1 -d:`
 		# Handle degenerate map specifiers
