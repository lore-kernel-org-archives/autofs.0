From: raven@themaw.net
Subject: [PATCH] init script bug present since 4.1.1
Date: Tue, 13 Apr 2004 20:42:35 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0404132037290.1333@donald.themaw.net>
Mime-Version: 1.0
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs mailing list <autofs@linux.kernel.org>
Cc: Raymond Prach <rprach@us.ibm.com>


--- autofs-4.1.2.orig/samples/rc.autofs.in	2004-04-13 20:35:14.000000000 +0800
+++ autofs-4.1.2/samples/rc.autofs.in	2004-04-13 20:35:53.000000000 +0800
@@ -190,7 +190,7 @@
 		mapoptions="$(echo "$daemonoptions $options" |\
 		      sed   's/--*t\(imeout\)*[ \t=]*\([0-9][0-9]*\)//g' |
 		      sed   's/--*g\(host\)*//g' |
-		      sed   's/--*v\(verbose\)*//g' |
+		      sed   's/--*v\(erbose\)*//g' |
 		      sed   's/--*d\(ebug\)*//g')"
 		# Break up the maptype and map, if the map type is specified
 		maptype=`echo $map | cut -f1 -d:`
