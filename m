From: Chris Feist <cfeist@redhat.com>
Subject: [patch] Maintain backwards compatibility w/ local file maps w/o
	etc.
Date: Wed, 20 Oct 2004 11:56:50 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1098291410.3527.18.camel@localhost.localdomain>
Reply-To: cfeist@redhat.com
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
To: raven@themaw.net, autofs@linux.kernel.org

This patch maintains the same behavior as in previous versions of
rc.autofs.in.  In the past you could have the following in your
auto.master file and it would test to see if there was a local
/etc/auto.misc file, and if there was it would use it.

/misc auto.misc

Now, it doesn't check.  I've attached a patch that fixes this behavior
(I think debian does the same thing with their autofs patches as well).

Thanks,
Chris

--- autofs-4.1.3/samples/rc.autofs.in.filemap-etc-append       
2004-10-20 11:47:05.227372963 -0500
+++ autofs-4.1.3/samples/rc.autofs.in   2004-10-20 11:47:06.947345831
-0500
@@ -206,6 +206,9 @@
                        map=`echo /etc/$map | sed 's^//^/^g'`
                    elif [ -f "$map" ]; then
                        maptype=file
+                   elif [ -f "/etc/$map" ]; then
+                       maptype=program
+                       map=`echo /etc/$map | sed 's^//^/^g'`
                    elif [ "$map" = "hesiod" -o "$map" = "userhome" ] ;
then
                        maptype=$map
                        map=
