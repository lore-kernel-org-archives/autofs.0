From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] auto.master duplicate entry checking broken in init script
Date: Tue, 30 Mar 2004 13:21:35 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16489.47791.964698.563392@segfault.boston.redhat.com>
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

Hello,

If you have entries in your auto.master such as:

/home/u
/u

then the second will be perceived as a dup of the first, due to an in-exact
regexp.  Attached is a fix which checks for a proper word boundary.

Cheers,

Jeff


--- autofs-4.1.1/samples/rc.autofs.in.init-redhat-only	2004-01-29 11:01:22.000000000 -0500
+++ autofs-4.1.1/samples/rc.autofs.in	2004-03-19 17:41:35.000000000 -0500
@@ -162,7 +162,7 @@
 	    fi
 	    if [ ! -z "$dir" -a ! -z "$map" \
 			-a x`echo "$map" | cut -c1` != 'x-' \
-			-a "`echo "$knownmaps" | grep $dir/`" = "" ]
+			-a "`echo "$knownmaps" | grep '\<'$dir/`" = "" ]
 	    then
 		# If the options include a -t or --timeout or a -g or --ghost
 		# parameter, then pull those particular options out.
