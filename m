From: Chris Feist <cfeist@redhat.com>
Subject: [PATCH] fixes problems w/ duplicate maps in auto.master
Date: Thu, 21 Oct 2004 16:46:16 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1098395176.3014.42.camel@gold.msp.redhat.com>
Reply-To: cfeist@redhat.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-3K4P2RKldQKUgSzTmFGy"
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
To: raven@themaw.net, autofs@linux.kernel.org


--=-3K4P2RKldQKUgSzTmFGy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Ian,

This patch should replace the previous init-duplicate-map.patch I
submitted last week.

The following patch contains fixes to prevent duplicate directories from
being mapped on top of each other.

For example, if my auto.master looks like this.
/misc auto.misc
/misc/misc2 auto.misc2

The automounter will attempt to mount /misc/misc2 on top of the already
mounted /misc and fail.  There were also problems where the automounter
thought that '/misc' was different than /misc/ which is also fixed.

Lastly, knownmaps is only added to if the map is not a duplicate.  It
wasn't being used anywhere else in the code and I don't think there is
any reason to check new maps against maps that we know aren't valid.

Let me know if you don't agree or you thing something needs to be
changed.

Thanks,
Chris


--=-3K4P2RKldQKUgSzTmFGy
Content-Disposition: attachment; filename=init-duplicate-map2.patch
Content-Type: text/x-patch; name=init-duplicate-map2.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- autofs-4.1.3/samples/rc.autofs.in.init-duplicate-map2	2004-10-21 16:20:08.251734287 -0500
+++ autofs-4.1.3/samples/rc.autofs.in	2004-10-21 16:45:19.630945579 -0500
@@ -159,12 +159,28 @@
 	    # These checks screen out duplicates and skip over directories
 	    # where the map is '-'.
 	    # We can't do empty or direct host maps, so don't bother trying.
+
+	    # Strip trailing slashes from the dir line if it exists to aid
+	    # in checking for duplicate maps
+	    dir=`echo "$dir" | sed -e "s/\/*$//"`
+
 	    if [ ! -z "$map" -a "$map" = "-hosts" ] ; then
 		continue
 	    fi
+
+	    # Do not include a map if it is a duplicate, maps on top of
+	    # another map or another map, maps on top of it.
+	    for knownmap in $knownmaps
+	    do
+                if [ "`echo $dir/ | grep ^$knownmap`" != "" \
+			-o "`echo $knownmap | grep ^$dir/`" != "" \]
+		then
+		    continue 2
+		fi
+	    done
+
 	    if [ ! -z "$dir" -a ! -z "$map" \
 			-a x`echo "$map" | cut -c1` != 'x-' \
-			-a "`echo "$knownmaps" | grep '\<'$dir/`" = "" ]
 	    then
 		# If the options include a -t or --timeout, a -g or --ghost,
 		# a -v or --verbose or a -d or --debug paramter, then pull
@@ -231,8 +247,8 @@
 		echo "$DAEMON $startupoptions $dir $maptype $map $mapoptions $localoptions" | sed -e 's/	/ /g' -e 's/  */ /g'
 
 		: echo ------------------------
-	    fi
 	    knownmaps=" $dir/ $knownmaps"
+	    fi
 	done
     )
 }

--=-3K4P2RKldQKUgSzTmFGy
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--=-3K4P2RKldQKUgSzTmFGy--

