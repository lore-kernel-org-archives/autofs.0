From: "Arthur Korn" <arthur@korn.ch>
Subject: current Debian delta for 4.1.3
Date: Mon, 27 Sep 2004 23:16:15 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040927211615.GA3560@turing>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============13869842362447149=="
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
To: autofs@linux.kernel.org


--===============13869842362447149==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

In the hopes that some of these might be helpful (and I won't
have to merge them for future releases *g*) here the commented
patches I'm applying to the debian package. I think I posted
some of them already, I hope you don't mind if I just post them
again.




sorting was made locale-robust, showmount is located in sbin on
debian, using a PATH would be preferable IMHO


--- bak/samples/auto.net~	2004-09-03 22:11:51.000000000 +0200
+++ bak/samples/auto.net	2004-09-03 22:19:02.000000000 +0200
@@ -9,7 +9,7 @@
=20
 # add "nosymlink" here if you want to suppress symlinking local filesystems
 # add "nonstrict" to make it OK for some filesystems to not mount
-opts=3D"-fstype=3Dnfs,hard,intr,nodev,nosuid"
+opts=3D"-fstype=3Dnfs,hard,intr,nodev,nosuid,nonstrict,rsize=3D8192,wsize=
=3D8192,async"
=20
 # Showmount comes in a number of names and varieties.  "showmount" is
 # typically an older version which accepts the '--no-headers' flag
@@ -19,9 +19,9 @@
 #SHOWMOUNT=3D"showmount -e $key | tail +2"
=20
 # Newer distributions get this right
-SHOWMOUNT=3D"/usr/sbin/showmount --no-headers -e $key"
+SHOWMOUNT=3D"/sbin/showmount --no-headers -e $key"

-$SHOWMOUNT | sort +0 | \
+$SHOWMOUNT | LC_ALL=3DC sort +0 | \
 	awk -v key=3D"$key" -v opts=3D"$opts" -- '
 	BEGIN		{ ORS=3D""; first=3D1 }
 			{ if (first) { print opts; first=3D0 }; print " \\\n\t" $1, key ":" $1 }



Document the +map syntax for file based auto.master (this is old
style analoguous to what can be done in passwd instead of using
nsswitch).

diff -ruN -x Makefile.in -x configure autofs-3.1.7.orig/man/autofs.8.in aut=
ofs-3.1.7/man/autofs.8.in
--- autofs-3.1.7.orig/man/autofs.8.in	Sat Nov  4 01:05:17 2000
+++ autofs-3.1.7/man/autofs.8.in	Thu Jan  4 23:00:21 2001
@@ -31,13 +31,16 @@
 process is started with the appropriate parameters. You can check the
 active mount points for the automounter with the
 .B @@INIT.D@@/autofs status
-command. After the
+command. If the
 .I auto.master
-configuration file is processed the
-.B autofs
-script will check for an NIS map with the same name. If such a map exists
-then that map will be processed in the same way as the auto.master map. The
-NIS map will be processed last.
+configuration file contains a line of the form
+.P
+.I +map
+.B [options]
+.P
+then the script will check for an NIS map with the same name.  If such a
+map exists then that map will be processed in the same way as the
+auto.master map, with any optional arguments.
 .P
 .B @@INIT.D@@/autofs reload
 will check the current auto.master map against running daemons. It will ki=
ll



Document -D options

=20
diff -ruN -x Makefile.in -x configure autofs-4.0.0pre10.orig/man/automount.=
8 autofs-4.0.0pre10/man/automount.8
--- autofs-4.0.0pre10.orig/man/automount.8	Tue Mar 27 23:08:23 2001
+++ autofs-4.0.0pre10/man/automount.8	Tue Oct 16 11:30:33 2001
@@ -22,6 +22,9 @@
 The filesystems are then autounmounted after a period of inactivity.
 .SH OPTIONS
 .TP
+.I "\-Dvariable=3Dvalue"
+Replace \fIvariable\fP with \fIvalue\fP in map substitutions.
+.TP
 .I "\-p, \-\-pid-file"
 Write the pid of the daemon to the specified file.
 .TP



remove trailing slash (http://bugs.debian.org/141775) in AFS
mounts

=20
--- bak/modules/mount_afs.c.orig	2004-01-29 17:01:22.000000000 +0100
+++ bak/modules/mount_afs.c	2004-09-03 23:03:04.000000000 +0200
@@ -39,6 +39,10 @@
 	strncat(dest, "/", sizeof(dest));
 	strncat(dest, name, sizeof(dest));
=20
+	/* remove trailing slash (http://bugs.debian.org/141775) */
+	if (dest[strlen(dest)-1] =3D=3D '/')
+	    dest[strlen(dest)-1] =3D '\0';
+
 	debug(MODPREFIX "mounting AFS %s -> %s", dest, what);
=20
 	return symlink(what, dest);	/* Try it.  If it fails, return the error. */



Crude support for hesiod priorities.


--- autofs-4.1.3/modules/lookup_hesiod.c.orig	2004-09-03 23:18:31.000000000=
 +0200
+++ autofs-4.1.3/modules/lookup_hesiod.c	2004-09-03 23:18:35.000000000 +0200
@@ -9,6 +9,7 @@
=20
 #include <sys/types.h>
 #include <ctype.h>
+#include <limits.h>
 #include <string.h>
 #include <syslog.h>
 #include <unistd.h>
@@ -70,6 +71,8 @@ int lookup_mount(const char *root, const
 	char **hes_result;
 	struct lookup_context *ctxt =3D (struct lookup_context *) context;
 	int rv;
+	char **record, *best_record =3D NULL, *p;
+	int priority, lowest_priority =3D INT_MAX;=09
=20
 	debug(MODPREFIX "looking up root=3D\"%s\", name=3D\"%s\"", root, name);
=20
@@ -78,14 +81,30 @@ int lookup_mount(const char *root, const
=20
 	hes_result =3D hes_resolve(name, "filsys");
=20
-	if (!hes_result) {
+	if (!hes_result || !hes_result[0]) {
 		warn(MODPREFIX "entry \"%s\" not found in map\n", name);
 		return 1;
 	}
=20
-	debug(MODPREFIX "lookup for \"%s\" gave \"%s\"", name, hes_result[0]);
+	/* autofs doesn't support falling back to alternate records, so just
+	   find the record with the lowest priority and hope it works.
+	   -- Aaron Ucko <amu@alum.mit.edu> 2002-03-11 */
+	for (record =3D hes_result; *record; ++record) {
+	    p =3D strrchr(*record, ' ');
+	    if ( p && isdigit(p[1]) ) {
+		priority =3D atoi(p+1);
+	    } else {
+		priority =3D INT_MAX - 1;
+	    }
+	    if (priority < lowest_priority) {
+		lowest_priority =3D priority;
+		best_record =3D *record;
+	    }
+	}
=20
-	rv =3D ctxt->parser->parse_mount(root, name, name_len, hes_result[0],
+	debug(MODPREFIX "lookup for \"%s\" gave \"%s\"", name, best_record);
+
+	rv =3D ctxt->parser->parse_mount(root, name, name_len, best_record,
 				       ctxt->parser->context);
 	free(hes_result);
 	return rv;



Fix calls to mount without options.


--- autofs-4.1.3/modules/mount_changer.c.orig	2004-05-10 14:44:30.000000000=
 +0200
+++ autofs-4.1.3/modules/mount_changer.c	2004-09-03 23:49:18.000000000 +0200
@@ -94,7 +94,7 @@
 	}
=20
 	wait_for_lock();
-	if (options) {
+	if (options && options[0]) {
 		debug(MODPREFIX "calling mount -t %s " SLOPPY "-o %s %s %s",
 		    fstype, options, what, fullpath);
=20
--- autofs-4.1.3/modules/mount_ext2.c.orig	2004-05-10 14:44:30.000000000 +0=
200
+++ autofs-4.1.3/modules/mount_ext2.c	2004-09-03 23:49:47.000000000 +0200
@@ -73,7 +73,7 @@
 		return 0;
 	}
=20
-	if (options) {
+	if (options && options[0]) {
 		for (p =3D options; (p1 =3D strchr(p, ',')); p =3D p1)
 			if (!strncmp(p, "ro", p1 - p) && ++p1 - p =3D=3D sizeof("ro"))
 				ro =3D 1;
--- autofs-4.1.3/modules/mount_generic.c.orig	2004-05-10 14:44:30.000000000=
 +0200
+++ autofs-4.1.3/modules/mount_generic.c	2004-09-03 23:50:19.000000000 +0200
@@ -72,7 +72,7 @@
 	}
=20
 	wait_for_lock();
-	if (options) {
+	if (options && options[0]) {
 		debug(MODPREFIX "calling mount -t %s " SLOPPY "-o %s %s %s",
 		      fstype, options, what, fullpath);



Program mounts repeated last character of map output.


diff -ruN autofs-4.1.3.orig/modules/lookup_program.c autofs-4.1.3/modules/l=
ookup_program.c
--- autofs-4.1.3.orig/modules/lookup_program.c	2004-01-29 17:01:22.00000000=
0 +0100
+++ autofs-4.1.3/modules/lookup_program.c	2004-09-03 23:58:42.000000000 +02=
00
@@ -159,6 +159,7 @@
 			if (read(pipefd[0], &ch, 1) < 1) {
 				FD_CLR(pipefd[0], &ourfds);
 				files_left--;
+				state =3D st_done;
 			}
=20
 			if (!quoted && ch =3D=3D '\\') {



Make should fail if a child of it fails.


diff -ruN autofs-4.1.3.orig/Makefile autofs-4.1.3/Makefile
--- autofs-4.1.3.orig/Makefile	2003-09-29 10:22:35.000000000 +0200
+++ autofs-4.1.3/Makefile	2004-09-04 20:23:42.000000000 +0200
@@ -13,26 +13,26 @@
 all:	daemon samples
=20
 daemon:
-	for i in $(SUBDIRS); do $(MAKE) -C $$i all; done=20
+	set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i all; done=20
=20
 kernel:
-	if [ -d kernel ]; then $(MAKE) -C kernel all; fi
+	set -e; if [ -d kernel ]; then $(MAKE) -C kernel all; fi
=20
 samples:
-	if [ -d samples ]; then $(MAKE) -C samples all; fi
+	set -e; if [ -d samples ]; then $(MAKE) -C samples all; fi
=20
 clean:
 	for i in $(SUBDIRS) samples kernel; do \
 		if [ -d $$i ]; then $(MAKE) -C $$i clean; fi; done =09
=20
 install:
-	for i in $(SUBDIRS); do $(MAKE) -C $$i install; done =09
+	set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i install; done =09
=20
 install_kernel:
-	if [ -d kernel ]; then $(MAKE) -C kernel install; fi
+	set -e; if [ -d kernel ]; then $(MAKE) -C kernel install; fi
=20
 install_samples:
-	if [ -d samples ]; then $(MAKE) -C samples install; fi
+	set -e; if [ -d samples ]; then $(MAKE) -C samples install; fi
=20
 mrproper distclean: clean
 	find . -noleaf \( -name '*~' -o -name '#*' -o -name '*.orig' -o -name '*.=
rej' -o -name '*.old' \) -print0 | xargs -0 rm -f




This is a bit large now.
- load /etc/default/autofs on debian, allow it to override
  localoptions and daemonoptions (ie source it after setting
  them to default values). TIMEOUT is supported for
  compatibility with debian stable (it doesn't hurt to do it, so
  it's done).
- getschemes(): fall back on files if no automount entry is
  found in nsswitch.conf (backwards compatibility too).
- getmounts(): reorder handling of short-form map specifiers,
  check for file maps in /etc/ if no path specified, allow
  !program syntax. (backwards compatibility).
- make stop, restart and reload actions work again as they
  should. CRITICAL

As I proposed in other mail, I'd be interested in reducing
rc.autofs to a script library with the generic stuff and leaving
the actual init scripts to distributions and individuals. I will
come up with something when the release is over and I got time.


diff -u autofs-4.1.3/samples/rc.autofs.in autofs-4.1.3/samples/rc.autofs.in
--- autofs-4.1.3/samples/rc.autofs.in	2004-09-27 19:34:47.000000000 +0200
+++ autofs-4.1.3/samples/rc.autofs.in	2004-09-27 20:15:01.000000000 +0200
@@ -76,11 +76,27 @@
 daemonoptions=3D''
=20
 #
+# load settings for above variables
+#
+if [ "$system" =3D "debian" ]; then
+    TIMEOUT=3D300
+
+    [ -f /etc/default/autofs ] && . /etc/default/autofs
+
+    daemonoptions=3D"$daemonoptions --timeout=3D$TIMEOUT"
+fi
+
+#
 # Check for all maps that are to be loaded
 #
 function getschemes()
 {
-    grep ^automount: /etc/nsswitch.conf | sed -e 's/^.*://' -e 's/\[.*\]/ =
/g'
+    if grep -q '^automount: ' /etc/nsswitch.conf; then
+        grep ^automount: /etc/nsswitch.conf | \
+                sed -e 's/^.*://' -e 's/\[.*\]/ /g'
+    else
+        echo files
+    fi
 }
 function catnismap()
 {
@@ -196,19 +212,25 @@
 		maptype=3D`echo $map | cut -f1 -d:`
 		# Handle degenerate map specifiers
 		if [ "$maptype" =3D "$map" ] ; then
-		    if [ -x "$map" ]; then
-			maptype=3Dprogram
-		    elif [ -x "/etc/$map" ]; then
-			maptype=3Dprogram
-			map=3D`echo /etc/$map | sed 's^//^/^g'`
-		    elif [ -f "$map" ]; then
-			maptype=3Dfile
-		    elif [ "$map" =3D "hesiod" -o "$map" =3D "userhome" ] ; then
+		    if [ "$map" =3D "hesiod" -o "$map" =3D "userhome" ] ; then
 			maptype=3D$map
 			map=3D
 		    elif [ "$map" =3D "multi" ] ; then
 			maptype=3D$map
 			map=3D
+		    elif echo "$map" | grep -q '^!'; then
+			map=3D`echo "$map"| sed -e 's/^!//g'`
+		    elif [ -x "$map" ]; then
+			maptype=3Dprogram
+		    elif [ -x "/etc/$map" ]; then
+			maptype=3Dprogram
+			map=3D`echo "/etc/$map" | sed 's^//^/^g'`
+		    elif [ -f "$map" ]; then
+			maptype=3Dfile
+		    elif [ -f "/etc/$map" ]; then
+			# compatibility with behaviour of autofs 3.* debian init
+			maptype=3Dfile
+			map=3D`echo "/etc/$map" | sed 's^//^/^g'`
 		    else
 			maptype=3Dyp
 			# If the master map says the maps have '_' why change it?
@@ -250,6 +272,20 @@
 	)
 }
=20
+function get_command_from_pid()
+{
+    ps ax | grep "[0-9]:[0-9][0-9] $DAEMON " | (
+        while read pid tt stat time command; do
+            if [ "$pid" =3D "$1" ] ; then
+                echo `echo "$command" | sed 's/--pid-file.*\.pid/ /'`
+                return 0
+            fi
+        done
+    )
+
+    return 0
+}
+
 # return true if at least one pid is alive
 function alive()
 {
@@ -443,44 +479,88 @@
 	echo -n 'Starting automounter:'
 	getmounts | while read cmd rest
 	do
-		mnt=3D`echo $rest | sed 's/^.* \(\/[^ ]*\) [A-Za-z].*$/\1/'`
-		echo -n " $mnt"
-		pidfile=3D/var/run/autofs`echo $mnt | sed 's/\//./'`.pid
-		start-stop-daemon --start --pidfile $pidfile --quiet \
-			--exec $DAEMON $daemonoptions -- $rest
+                mnt=3D`echo $rest | sed 's/^.* \(\/[^ ]*\) [A-Za-z].*$/\1/=
'`
+                pidfile=3D/var/run/autofs/`echo $mnt | sed 's,/,_,g'`.pid
+                echo -n " $mnt"
+                if [ ! -d /var/run/autofs ]; then
+                        mkdir /var/run/autofs
+                fi
+                start-stop-daemon --start --pidfile $pidfile --quiet \
+                    --exec $DAEMON -- --pid-file=3D$pidfile $rest
 	done
 	echo "."
 	;;
     stop)
-	echo 'Stopping automounter.'
-	start-stop-daemon --stop --quiet --signal USR2 --exec $DAEMON
+	echo 'Stopping automounter: '
+        any=3D0
+        for file in /var/run/autofs/*.pid
+        do
+            if [ -e "$file" ]
+            then
+                any=3D1
+		pid=3D`head -1 $file`
+		set +e
+                start-stop-daemon --stop --quiet --retry USR2/5 \
+			--pidfile $file --exec $DAEMON
+		case $? in
+		0)
+                   echo -n -e "\n  Stopped $pid"
+		    rm -f $file
+		    ;;
+		1)
+		    echo -n -e "\n No process for $pid"
+		    rm -f $file
+		    ;;
+                2)
+		    echo -n -e "\n  Couldn't stop $pid"
+		    ;;
+		*)
+		    echo -n -e "\n Strange start-stop-daemon exit status: $?"
+		    ;;
+                esac
+            fi
+        done
+        if [ $any -eq 1 ]; then
+                echo
+        fi
+        echo "done."
 	;;
-    reload|restart)
+    reload)
 	echo "Reloading automounter: checking for changes ... "
-	TMP=3D/var/run/autofs.tmp
+	TMP=3D`mktemp -t autofs.XXXXXX`
 	getmounts >$TMP
-	for i in /var/run/autofs.*.pid
+	for i in /var/run/autofs/*.pid
 	do
 		pid=3D`head -n 1 $i 2>/dev/null`
 		[ "$pid" =3D "" ] && continue
-		command=3D`tail +2 $i`
-		if ! grep -q "^$command" $TMP
+		command=3D`ps -wwo 'cmd=3D' $pid| sed -e 's,.* --pid-file=3D/var/run/aut=
ofs/\([^ ]*\)\.pid.*,\1,; s,_,/,g'`
+		if ! grep -q " $command " $TMP
 		then
-			echo "Stopping automounter: $command"
+			echo "Stopping automounter: $pid"
 			kill -USR2 $pid 2> /dev/null
 		else
-			echo "Reloading automounter map: $command"
+			echo "Reloading automounter map: $pid"
 			kill -HUP $pid 2> /dev/null
 		fi
 	done
 	rm -f $TMP
 	$thisscript start
 	;;
+    force-reload|restart)
+	$0 stop
+	$0 start
+	;;
     status)
 	status
 	;;
+    getmounts)
+	getmounts
+	;;
+    active)
+	active
+	;;
     *)
-	echo "Usage: $initdir/autofs {start|stop|restart|reload|status}" >&2
+	echo "Usage: $initdir/autofs {start|stop|restart|reload|status|getmounts|=
active}" >&2
 	exit 1
 	;;
 esac




Fix handling of --timeout: map options form master maps override
$daemonoptions.


--- autofs-4.1.3.orig/samples/rc.autofs.in	2004-09-27 18:17:32.000000000 +0=
200
+++ autofs-4.1.3/samples/rc.autofs.in	2004-09-27 18:39:27.000000000 +0200
@@ -187,14 +187,11 @@
 		# those particular options out.
 		: echo DAEMONOPTIONS OPTIONS $daemonoptions $options
 		startupoptions=3D
-		if echo "$daemonoptions" | grep -q -- '-t' ; then
-		    startupoptions=3D"--timeout=3D$(echo $daemonoptions $options | \
-		      sed 's/.*--*t\(imeout\)*[ \t=3D]*\([0-9][0-9]*\).*$/\2/g')"
-		fi
-		# Override timeout in $daemonoptions with map $options
-		if echo "$options" | grep -q -- '-t' ; then
-		    startupoptions=3D"--timeout=3D$(echo $daemonoptions $options | \
-		      sed 's/.*--*t\(imeout\)*[ \t=3D]*\([0-9][0-9]*\).*$/\2/g')"
+		if echo "$options $daemonoptions" | grep -q -- '-t' ; then
+		    # the first timout value in "$options $daemonoptions" is
+		    # the one that is taken.
+		    startupoptions=3D"--timeout=3D$(echo $options $daemonoptions | \
+		      sed 's/^.?*--*t\(imeout\)*[ \t=3D]*\([0-9][0-9]*\).*$/\2/')"
 		fi
 		if echo "$daemonoptions $options" | grep -q -- '-g' ; then
 		    startupoptions=3D"$startupoptions --ghost"



Fix reference to this mailinglist in manpage.


diff -ruN autofs-4.1.3.orig/man/automount.8 autofs-4.1.3/man/automount.8
--- autofs-4.1.3.orig/man/automount.8	2004-09-27 21:57:04.000000000 +0200
+++ autofs-4.1.3/man/automount.8	2004-09-27 21:47:26.000000000 +0200
@@ -146,7 +146,7 @@
 The documentation leaves a lot to be desired.
=20
 Please report other bugs along with a detailed description to
-<autofs@linux.kernel.org>.  To join this mailing list, send a message
-with the line "subscribe autofs" to <majordomo@linux.kernel.org>.
+<autofs@linux.kernel.org>. For instructions on how to join the list
+and for archives visit http://linux.kernel.org/mailman/listinfo/autofs
 .SH AUTHOR
 H. Peter Anvin <hpa@transmeta.com>


HTH, 2ri
--=20
Secure email, spread GPG, clearsign all mail. http://www.gnupg.org
=2E
Nearly all men can stand adversity, but if you want to test a man's=20
character, give him power.
 -- Abraham Lincoln

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBWIMeNgpsykSg/LgRAuuqAKDLaPGc2mQbJL22lXIqrqPasupK0QCgy6NM
MwEStLQG+qc7UTi+xDZoo5o=
=Mxwv
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--


--===============13869842362447149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============13869842362447149==--

