From: "Taylor, ForrestX" <forrestx.taylor@intel.com>
Subject: Re: autofs v4 maintainer request
Date: Mon, 18 Aug 2003 13:26:10 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3F413662.2010209@intel.com>
References: <Pine.LNX.4.44.0308182102250.977-100000@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070508040308040900060107"
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
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>

This is a multi-part message in MIME format.
--------------070508040308040900060107
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ian Kent wrote:
> Ignorant of me to ignore existing 4.0.0 users. I appologise.
> 
> It's been a long time since I have worked with the original 4.0.0 
> distribution so I will need input from people that are using it.
> 
> Could everyone post bug reports and send any patches to me. Please 
> include some indication of priority such as show stopper, nice to have 
> etc. I will attempt to solve the problems and merge any patches.

Here is a patch that I use that contains mostly Red Hat-specific 
changes.  This includes starting autofs after NIS, and stopping autofs 
before NFS, as well as changing the directory to /etc/init.d.

Forrest
-- 


--------------070508040308040900060107
Content-Type: text/plain;
 name="autofs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="autofs.patch"

diff -urN autofs-4.0.0pre10/autofs.spec autofs-4.0.0pre10.new/autofs.spec
--- autofs-4.0.0pre10/autofs.spec	2001-03-27 21:08:23.000000000 -0800
+++ autofs-4.0.0pre10.new/autofs.spec	2003-08-18 12:54:59.000000000 -0700
@@ -4,6 +4,7 @@
 %define version 4.0.0pre10
 Version: %{version}
 Release: 1
+Epoch: 2
 Copyright: GPL
 Group: Networking/Daemons
 Source: ftp://ftp.kernel.org/pub/linux/daemons/autofs/autofs-%{version}.tar.gz
@@ -49,7 +50,7 @@
 
 %install
 rm -rf $RPM_BUILD_ROOT
-mkdir -p $RPM_BUILD_ROOT/etc/rc.d/init.d
+mkdir -p $RPM_BUILD_ROOT/etc/init.d
 mkdir -p $RPM_BUILD_ROOT/usr/sbin
 mkdir -p $RPM_BUILD_ROOT/usr/lib/autofs
 mkdir -p $RPM_BUILD_ROOT/usr/man/man5
@@ -65,16 +66,34 @@
 
 %post
 chkconfig --add autofs
+echo "alias autofs autofs4" >> /etc/modules.conf
+AUTOFSMOD=`/sbin/lsmod | grep 'autofs '`
+if [[ $AUTOFSMOD ]];then
+	# XXX We need to rmmod the old autofs, and stop autofs,
+	# but we can't do it here.
+	#rmmod
+	echo
+	echo "Autofs appears to be running.  Please stop autofs and rmmod the module."
+	echo "(I.e.,  /sbin/service autofs stop"
+	echo "        /sbin/rmmod autofs"
+	echo "        /sbin/service autofs start )"
+	echo
+fi
 
-%postun
-if [ "$1" = 0 ] ; then
-  chkconfig --del autofs
+%preun
+/sbin/service autofs stop
+if [ $1 = 0 ] ; then
+  /sbin/chkconfig --del autofs
+  /sbin/rmmod autofs4
 fi
+cp /etc/modules.conf /etc/modules.conf.autofs
+cat /etc/modules.conf | grep -v "alias autofs autofs4" > /etc/modules.conf.new
+mv /etc/modules.conf.new /etc/modules.conf
 
 %files
 %defattr(-,root,root)
 %doc COPYRIGHT NEWS README TODO
-%config /etc/rc.d/init.d/autofs
+%config /etc/init.d/autofs
 %config(missingok) /etc/auto.master
 %config(missingok) /etc/auto.misc
 %config(missingok) /etc/auto.net
@@ -105,6 +124,14 @@
 
 # RedHat logs:
 
+* Mon Aug 18 2003 Forrest Taylor <forrestx.taylor@intel.com>
+- Added nonstrict to auto.net
+- Changed start and stop sequence.  Autofs needs to start after NIS and stop before NFS.
+- Changed %postun to %preun in the specfile so that /etc/init.d/autofs is still there when trying to chkconfig --del autofs.
+- Changed /etc/rc.d/init.d/ to /etc/init.d/
+- Added Epoch 2 to specfile so that one can upgrade from autofs-3 from Red Hat.
+- Add module alias to /etc/modules.conf
+
 * Tue Oct  6 1998 Bill Nottingham <notting@redhat.com>
 - fix bash2 breakage in init script
 
diff -urN autofs-4.0.0pre10/samples/auto.net autofs-4.0.0pre10.new/samples/auto.net
--- autofs-4.0.0pre10/samples/auto.net	2001-03-27 21:08:23.000000000 -0800
+++ autofs-4.0.0pre10.new/samples/auto.net	2003-08-18 10:01:17.000000000 -0700
@@ -9,7 +9,7 @@
 
 # add "nosymlink" here if you want to suppress symlinking local filesystems
 # add "nonstrict" to make it OK for some filesystems to not mount
-opts="-fstype=nfs,hard,intr,nodev,nosuid"
+opts="-fstype=nfs,hard,intr,nodev,nosuid,nonstrict"
 
 # Showmount comes in a number of names and varieties.  "showmount" is
 # typically an older version which accepts the '--no-headers' flag
diff -urN autofs-4.0.0pre10/samples/rc.autofs.in autofs-4.0.0pre10.new/samples/rc.autofs.in
--- autofs-4.0.0pre10/samples/rc.autofs.in	2001-03-27 21:08:23.000000000 -0800
+++ autofs-4.0.0pre10.new/samples/rc.autofs.in	2003-08-18 12:36:46.000000000 -0700
@@ -12,7 +12,7 @@
 
 # For Redhat-ish systems
 #
-# chkconfig: 345 15 85
+# chkconfig: 345 61 19
 # description: Automounts filesystems on demand
 
 # This is used in the Debian distribution to determine the proper
@@ -28,7 +28,9 @@
 # Location of the automount daemon and the init directory
 #
 DAEMON=@@sbindir@@/automount
+#DAEMON=/usr/sbin/automount
 initdir=@@initdir@@
+#initdir=/etc/init.d
 
 #
 # Determine which kind of configuration we're using
@@ -61,7 +63,7 @@
 # We can add local options here
 # e.g. localoptions='rsize=8192,wsize=8192'
 #
-localoptions=''
+localoptions='rsize=8192,wsize=8192'
 
 #
 # Daemon options
@@ -138,7 +140,7 @@
 	echo ""
 	echo "Active Mount Points:"
 	echo "--------------------"
-	ps ax|grep "[0-9]:[0-9][0-9] automount " | (
+	ps ax|grep "[0-9]:[0-9][0-9] $DAEMON " | (
 		while read pid tt stat time command; do echo $command; done
 	)
 }
@@ -167,66 +169,80 @@
 #
 # See how we were called.
 #
-case "$1" in
-  start)
+  start() {
 	# Check if the automounter is already running?
 	if [ ! -f /var/lock/subsys/autofs ]; then
 	    echo 'Starting automounter: '
 	    getmounts | sh
 	    touch /var/lock/subsys/autofs
 	fi
-	;;
-  stop)
+  }
+  stop() {
 	pids=$(/sbin/pidof $DAEMON)
 	kill -TERM $pids 2> /dev/null && sleep 1
 	count=1
 	while alive $pids; do
-	    sleep 5
+	    sleep 2
 	    count=$(expr $count + 1)
-	    if [ $count -gt 5 ]; then
+	    if [ $count -gt 10 ]; then
 		echo "Giving up on automounter"
 		break;
 	    fi
 	    echo "Automounter not stopped yet: retrying... (attempt $count)"
 	done
-	if [ $count -gt 1 -a $count -le 10 ]; then
+	if [ $count -ge 1 -a $count -le 10 ]; then
 	    echo "Automounter stopped"
 	fi
 	rm -f /var/lock/subsys/autofs
-	;;
-  reload|restart)
+  }
+  condrestart() {
 	if [ ! -f /var/lock/subsys/autofs ]; then
 		echo "Automounter not running"
 		exit 1
 	fi
 	echo "Checking for changes to /etc/auto.master ...."
+	echo
         TMP1=`mktemp /tmp/autofs.XXXXXX` || { echo "could not make temp file" >& 2; exit 1; }
         TMP2=`mktemp /tmp/autofs.XXXXXX` || { echo "could not make temp file" >& 2; exit 1; }
 	getmounts >$TMP1
-	ps ax|grep "[0-9]:[0-9][0-9] $DAEMON " | (
+	ps ax --sort=-pid|grep "[0-9]:[0-9][0-9] $DAEMON " | (
 	    while read pid tt stat time command; do
 		echo "$command" >>$TMP2
-		if ! grep -q "^$command" $TMP2; then
-			while kill -USR2 $pid; do
-			    sleep 3
-			done
-			echo "Stop $command"
+		if grep -q "^$command" $TMP2; then
+			kill -USR2 $pid
+			    sleep 1
+			echo "Stopping $command"
 		fi
 	    done
+	echo
 	)
 	( while read x; do
 		if ! grep -q "^$x" $TMP2; then
 			$x
-			echo "Start $x"
+			echo "Starting $x"
 		fi
-        done ) < $TMP1
+	  done ) < $TMP1
 	rm -f $TMP1 $TMP2
+  }
+case "$1" in
+  start)
+	start
+	;;
+  stop)
+	stop
+	;;
+  restart)
+	stop
+	start
+	;;
+  condrestart|reload)
+	condrestart
 	;;
   status)
-	status
+	status $DAEMON
 	;;
   *)
-	echo "Usage: $initdir/autofs {start|stop|restart|reload|status}"
+	echo "Usage: $initdir/autofs {start|stop|restart|reload|condrestart|status}"
 	exit 1
 esac
 }
@@ -289,4 +305,4 @@
 	redhat "$@"
 fi
 
-exit 0
+exit $?

--------------070508040308040900060107
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------070508040308040900060107--

