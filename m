From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] umount loopback filessystems on autofs stop
Date: Thu, 2 Sep 2004 16:14:42 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16695.32562.350433.822164@segfault.boston.redhat.com>
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
To: raven@themaw.net
Cc: autofs@linux.kernel.org

Hello,

The netfs scripts for Red Hat go through and umount any loopback devices
before attempting to umount the encompassing filesystem.  This seems a sane
thing to do (and I have a bug on said issue), so I've added similar
functionality to the autofs init script.  Attached is a patch.  Comments
encouraged.  Testing by debian folks would be nice, too.

-Jeff

--- autofs-4.1.3/samples/rc.autofs.in.umount-loopback	2004-09-02 15:55:21.722705296 -0400
+++ autofs-4.1.3/samples/rc.autofs.in	2004-09-02 16:16:09.985940440 -0400
@@ -351,6 +351,31 @@ function signal_automounts()
 	return $RETVAL
 }
 
+function umount_loopback()
+{
+    loops=`LC_ALL=C awk '!/^#/ && $1 ~ /^\/dev\/loop/ && $2 != "/" {print $2}' /proc/mounts`
+    automounts=`LC_ALL=C awk '!/^#/ && $1 ~ /^automount/ {print $2}' /proc/mounts`
+
+    for l in $loops
+    do
+	for a in $automounts
+	do
+	    command="echo $l | grep -E '^$a'"
+	    match=`echo $command | sh`
+	    if [ -n "$match" ]; then
+		echo ""
+		echo -n $"Unmounting loopback filesystem $match:  "
+		umount -d $match
+		if [ $? -eq 0 ]; then
+		    echo "done"
+		else
+		    echo "failed ($?)"
+		fi
+	    fi
+	done
+    done
+}
+
 # Redhat start/stop function.
 #
 function redhat()
@@ -386,6 +411,7 @@ case "$1" in
 	if [ -z "`pidofproc $prog`" -a -z "`getmounts`" ]; then
 		RETVAL=0
 	else
+		umount_loopback
 		signal_automounts
 		RETVAL=$?
 	fi
@@ -477,6 +503,7 @@ case "$1" in
 	;;
     stop)
 	echo 'Stopping automounter.'
+	umount_loopback
 	start-stop-daemon --stop --quiet --signal USR2 --exec $DAEMON
 	;;
     reload|restart)
