From: thorild@Update.UU.SE (Thorild Selen)
Subject: Debian: Init script confused by options
Date: Sun, 9 May 2004 03:07:18 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16541.33862.63334.177007@Psilocybe.Update.UU.SE>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
Content-Type: text/plain; charset="iso-8859-1"
To: autofs@linux.kernel.org

Starting the automounter in Debian:

> [Psilocybe] update # /etc/init.d/autofs start
> Starting automounter: --ghost.

This doesn't look very pretty. Function "debian" in the start script
reads the output from getmounts assuming that the first thing after
the command is the mount point. However, it might be an option. It
wouldn't do to skip everything after the daemon name up to the first
thing that does not start with a dash and then assume that the next
thing is the mount point, since some options take arguments. These
arguments may start with dashes or slashes.

The fix below assumes that the mount point will be the first thing
that starts with a slash and is followed by something that starts with
a letter (the map type). A bit ugly, but it will still work with
option arguments that starts with dashes or slashes; also, it doesn't
need to know a thing about which options there are and whether they
take any arguments or not. As long as the mount point starts with a
slash and the map type starts with a letter, we're fine.

(Does anyone have a better idea?)

With patch:
> [Psilocybe] update # /etc/init.d/autofs start=20
> Starting automounter: /slask.


Another thing; the /var/run/autofs.*.pid files that the debian
function tries to use when reloading are actually never
created. Adding --make-pidfile to start-stop-deamon would probably do
the trick, but then it'd be nice to also delete old pid files so we
don't keep them around and try to reload the settings of their
deceased daemons forever. I haven't addressed this.


Thorild Sel=E9n
Datorf=F6reningen Update / Update Computer Club, Uppsala, SE



diff -Naur autofs-4.1.2.old/samples/rc.autofs.in autofs-4.1.2/samples/rc.=
autofs.in
--- autofs-4.1.2.old/samples/rc.autofs.in	2004-05-09 01:00:42.000000000 +=
0200
+++ autofs-4.1.2/samples/rc.autofs.in	2004-05-09 01:51:25.000000000 +0200
@@ -441,12 +441,13 @@
 case "$1" in
     start)
 	echo -n 'Starting automounter:'
-	getmounts | while read cmd mnt rest
+	getmounts | while read cmd rest
 	do
+		mnt=3D`echo $rest | sed 's/^.* \(\/[^ ]*\) [A-Za-z].*$/\1/'`
 		echo -n " $mnt"
 		pidfile=3D/var/run/autofs`echo $mnt | sed 's/\//./'`.pid
 		start-stop-daemon --start --pidfile $pidfile --quiet \
-			--exec $DAEMON $daemonoptions -- $mnt $rest
+			--exec $DAEMON $daemonoptions -- $rest
 	done
 	echo "."
 	;;
