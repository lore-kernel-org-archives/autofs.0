From: HOSAKA Eiichi <ei@foc.jp>
Subject: Patch for autofs-4.1.0
Date: Tue, 27 Jan 2004 00:36:17 +0900
Sender: autofs-bounces@linux.kernel.org
Message-ID: <040127003617.M0119515@bureau.foc.jp>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Patch for autofs-4.1.0
to port the file samples/rc.autofs for the Slackware Linux.

diff -ru autofs-4.1.0/samples/Makefile autofs-4.1.0slack1.4/samples/Makefile
--- autofs-4.1.0/samples/Makefile	2003-09-29 17:22:35.000000000 +0900
+++ autofs-4.1.0slack1.4/samples/Makefile
@@ -10,7 +10,11 @@
 CFLAGS += -I../include
 LIBS = -lldap -llber
 
+ifeq ($(LDAP),1)
 all: autofs-ldap-auto-master rc.autofs
+else
+all: rc.autofs
+endif
 
 autofs-ldap-auto-master: $(OBJS)
 	$(CC) $(LDFLAGS) -o autofs-ldap-auto-master $(OBJS) $(LIBS)
@@ -28,10 +32,18 @@
 	-mv -f $(INSTALLROOT)/etc/auto.misc $(INSTALLROOT)/etc/auto.misc.old
 	install -c auto.misc   -m 644 $(INSTALLROOT)/etc
 	install -c auto.net    -m 755 $(INSTALLROOT)/etc
+ifneq ($(initdir),)
 	install -d -m 755 $(INSTALLROOT)/$(initdir)
 	install -c rc.autofs   -m 755 $(INSTALLROOT)$(initdir)/autofs
+else
+	if test -d $(INSTALLROOT)/etc/rc.d ; then \
+	  install -c rc.autofs -m 755 $(INSTALLROOT)/etc/rc.d ; \
+	fi
+endif
+ifeq ($(LDAP),1)
 	install -d -m 755 $(INSTALLROOT)$(autofslibdir)
 	install -c autofs-ldap-auto-master -m 755 $(INSTALLROOT)$(autofslibdir)
+endif
 
 clean:
 	rm -f *.o *.s autofs-ldap-auto-master rc.autofs
diff -ru autofs-4.1.0/samples/rc.autofs.in autofs-4.1.0slack1.4/samples/rc.autofs.in
--- autofs-4.1.0/samples/rc.autofs.in	2003-11-24 23:36:51.000000000 +0900
+++ autofs-4.1.0slack1.4/samples/rc.autofs.in
@@ -7,7 +7,7 @@
 # map with that name
 #
 # On most distributions, this file should be called:
-# /etc/rc.d/init.d/autofs or /etc/init.d/autofs
+# /etc/rc.d/init.d/autofs, /etc/init.d/autofs or /etc/rc.d/rc.autofs
 #
 
 # For Redhat-ish systems
@@ -41,6 +41,8 @@
     system=debian
 elif [ -f /etc/redhat-release ]; then
     system=redhat
+elif [ -f /etc/slackware-version ]; then
+    system=slackware
 else
     echo "$0: Unknown system, please port and contact autofs@linux.kernel.org" 1>&2
     exit 1
@@ -169,12 +171,12 @@
 		: echo DAEMONOPTIONS OPTIONS $daemonoptions $options
 		startupoptions=
 		if echo "$daemonoptions" | grep -q -- '-t' ; then
-		    startupoptions="--timeout=$(echo $daemonoptions $options | \
+		    startupoptions="--timeout=$(echo $daemonoptions | \
 		      sed 's/.*--*t\(imeout\)*[ \t=]*\([0-9][0-9]*\).*$/\2/g')"
 		fi
 		# Override timeout in $daemonoptions with map $options
 		if echo "$options" | grep -q -- '-t' ; then
-		    startupoptions="--timeout=$(echo $daemonoptions $options | \
+		    startupoptions="--timeout=$(echo $options | \
 		      sed 's/.*--*t\(imeout\)*[ \t=]*\([0-9][0-9]*\).*$/\2/g')"
 		fi
 		if echo "$daemonoptions $options" | grep -q -- '-g' ; then
@@ -402,11 +404,74 @@
 esac
 }
 
+#
+# Slackware start/stop function.
+#
+function slackware()
+{
+    local lock=/var/lock/$prog
+    case "$1" in
+    (start)
+        if ! ln -s /dev/null $lock 2>/dev/null ; then
+            echo "$prog is now running or already killed abnormally" >&2
+            exit 1
+        fi
+        echo "Starting $prog:"
+        getmounts | while read line ; do echo "  $line" ; $line ; sleep 1 ; done
+        ;;
+    (stop)
+        echo -n "Stopping $prog "
+        local count
+        (( count = 0 ))
+        while [ -n "$( ps axw | grep "[0-9]:[0-9][0-9] $DAEMON " )" ] ; do
+            (( count++ >= 10 )) &&
+                { echo -n ' give up' ; killall -TERM $DAEMON ; break ; }
+            echo -n .
+            killall -USR2 $DAEMON
+            sleep 3
+        done
+        echo
+        umount -a -f -t autofs
+        rm -f $lock
+        ;;
+    (reload|restart)
+        test -e $lock || { echo "Maybe $prog is not running" >&2 ; exit 1 ; }
+        echo "Checking for changes to /etc/auto.master:"
+        local nline new[] pid tt stat time oline old[]
+        while read nline ; do new[${#new[@]}]="$nline" ; done <<__EOF__ 
+$( getmounts )
+__EOF__
+        while read pid tt stat time oline ; do
+            old[${#old[@]}]="$oline"
+            for nline in "${new[@]}" ; do
+                test "$oline" = "$nline" && { oline= ; break ; }
+            done
+            test -n "$oline" &&
+                { echo "   stop: $oline" ; kill -USR2 $pid ; sleep 1 ; }
+        done <<__EOF__
+$( ps axw | grep "[0-9]:[0-9][0-9] $DAEMON " )
+__EOF__
+        for nline in "${new[@]}" ; do
+            for oline in "${old[@]}" ; do
+                test "$nline" = "$oline" && { nline= ; break ; }
+            done
+            test -n "$nline" &&
+                { echo "  start: $nline" ; $nline ; sleep 1 ; }
+        done
+        killall -HUP $DAEMON
+        sleep 1
+        ;;
+    (status)
+        status
+        ;;
+    (*)
+        echo "Usage: $0 {start|stop|reload|restart|status}" >&2
+        exit 1
+        ;;
+    esac
+}
+
 RETVAL=0
-if [ $system = debian ]; then
-	debian "$@"
-elif [ $system = redhat ]; then
-	redhat "$@"
-fi
+$system "$@"
 
 exit $RETVAL
