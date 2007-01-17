From: jmoyer@redhat.com
Subject: [autofs v4 patch] log reloads to the system log
Date: Tue, 16 Jan 2007 20:03:41 -0500
Message-ID: <m3sleaa2he.fsf@redhat.com>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs <autofs@linux.kernel.org>

This is a patch to address a request we had on this list not too long ago.
/etc/init.d/autofs start/stop/restart are all logged to the system log, but
reload is not.  This makes it so that reloads also get logged.

Comments welcome, as usual.

-Jeff

diff --git a/samples/rc.autofs.in b/samples/rc.autofs.in
index 5b71481..56ae82c 100644
--- a/samples/rc.autofs.in
+++ b/samples/rc.autofs.in
@@ -598,6 +598,7 @@ case "$1" in
 	if [ ! -f /var/lock/subsys/autofs ]; then
 		echo $"$prog not running"
 		RETVAL=1
+		failure "$prog reload"
 		return
 	fi
 	echo $"Checking for changes to /etc/auto.master ...."
@@ -625,6 +626,7 @@ case "$1" in
 		fi
         done )
 	rm -f $TMP1 $TMP2
+	success "$prog reload"
 	;;
   status)
 	status
