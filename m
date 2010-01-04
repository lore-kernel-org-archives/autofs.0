From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: [PATCH] add try-restart init script action
Date: Mon, 4 Jan 2010 16:21:59 -0200
Message-ID: <20100104182159.GA28607@libre.l.ngdn.org>
References: <20100104164436.GA27875@libre.l.ngdn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:date:from:to:subject
	:message-id:references:mime-version:content-type:content-disposition
	:in-reply-to:user-agent;
	bh=oJpP/Ysf/eEQeLgIixYB45p5MEODMe3D0PE0fpCj07k=;
	b=nYx+UDMDWGZAyP4GVCxzbDv0io7kqI9KDIE9KQQXMV2uST8hXqhuSYjhpaFUWbVYou
	pEv1CNvAn3PyB6k2a3IVPfdMPehwfhF8Xxz3j9cYt40i4mknl2wiktRJCvjBt/by9J+v
	/GCtg9qig5J9lWYCXnEoMWCAz+fDw2ZGMiySE=
Content-Disposition: inline
In-Reply-To: <20100104164436.GA27875@libre.l.ngdn.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

> --- autofs.orig/redhat/autofs.init.in
> +++ autofs/redhat/autofs.init.in

I apologize. This change was untested and obviously wrong:

>  	condrestart)
> +	try-restart)

Here's the fixed version. 

    autofs-5.0.5 - add try-restart init script action

    Implement try-restart init script action to restart the service
    only if the service is already running. This action is part of
    LSB since version 1.9.

    While there, fix some typos and adjust coding style for consistency.

    Signed-off-by: Leonardo Chiquitto <lchiquitto@suse.de>

Index: autofs/redhat/autofs.init.in
===================================================================
--- autofs.orig/redhat/autofs.init.in
+++ autofs/redhat/autofs.init.in
@@ -26,7 +26,7 @@ DEVICE="autofs"
 initdir=@@initdir@@
 confdir=@@autofsconfdir@@
 
-test -e $DAEMON || exit 0
+test -x $DAEMON || exit 1
 
 if [ -r $initdir/functions ]; then
 	. $initdir/functions
@@ -36,7 +36,7 @@ PATH=/sbin:/usr/sbin:/bin:/usr/bin
 export PATH
 
 #
-# load customized configuation settings
+# load customized configuration settings
 #
 if [ -r $confdir/autofs ]; then
 	. $confdir/autofs
@@ -44,14 +44,12 @@ fi
 
 function start() {
 	# Make sure autofs4 module is loaded
-	if ! grep -q autofs /proc/filesystems
-	then
+	if ! grep -q autofs /proc/filesystems; then
 		echo -n "Loading $MODULE: "
-		# Try load the autofs4 module fail if we can't
-		modprobe $MODULE >/dev/null 2>&1
+		# Try to load the autofs4 module and fail if we can't
+		modprobe -q $MODULE >/dev/null 2>&1
 		RETVAL=$?
-		if [ $RETVAL -eq 1 ]
-		then
+		if [ $RETVAL -eq 1 ]; then
 			failure "Load $MODULE"
 			echo
 			return $RETVAL
@@ -59,8 +57,7 @@ function start() {
 			success "Load $MODULE"
 			echo
 		fi
-	elif ([ -f /proc/modules ] && lsmod) | grep -q autofs[^4]
-	then
+	elif ([ -f /proc/modules ] && lsmod) | grep -q autofs[^4]; then
 		RETVAL=1
 		failure "Load $MODULE"
 		echo
@@ -129,7 +126,7 @@ function reload() {
 		return $RETVAL
 	fi
 	pid=`pidof $prog`
-	if [ -z $pid ]; then
+	if [ -z "$pid" ]; then
 		echo $"$prog not running"
 		RETVAL=1
 	else
@@ -166,13 +163,13 @@ case "$1" in
 	reload)
 		reload
 		;;
-	condrestart)
+	condrestart|try-restart)
 		if [ -f /var/lock/subsys/autofs ]; then
 			restart
 		fi
 		;;
 	*)
-		echo $"Usage: $0 {start|forcestart|stop|status|restart|forcerestart|reload|condrestart}"
+		echo $"Usage: $0 {start|forcestart|stop|status|restart|forcerestart|reload|condrestart|try-restart}"
 		exit 1;
 		;;
 esac
Index: autofs/samples/rc.autofs.in
===================================================================
--- autofs.orig/samples/rc.autofs.in
+++ autofs/samples/rc.autofs.in
@@ -24,13 +24,13 @@ MODULE="autofs4"
 DEVICE="autofs"
 confdir=@@autofsconfdir@@
 
-test -e $DAEMON || exit 0
+test -x $DAEMON || exit 1
 
 PATH=/sbin:/usr/sbin:/bin:/usr/bin
 export PATH
 
 #
-# load customized configuation settings
+# load customized configuration settings
 #
 if [ -r $confdir/autofs ]; then
 	. $confdir/autofs
@@ -40,20 +40,17 @@ function start() {
 	echo -n "Starting $prog: "
 
 	# Make sure autofs4 module is loaded
-	if ! grep -q autofs /proc/filesystems
-	then
-		# Try load the autofs4 module fail if we can't
-		modprobe $MODULE >/dev/null 2>&1
-		if [ $? -eq 1 ]
-		then
-			echo "Error: failed to load autofs4 module."
+	if ! grep -q autofs /proc/filesystems; then
+		# Try to load the autofs4 module and fail if we can't
+		modprobe -q $MODULE >/dev/null 2>&1
+		if [ $? -eq 1 ]; then
+			echo "Error: failed to load $MODULE module."
 			return 1
 		fi
-	elif ([ -f /proc/modules ] && lsmod) | grep -q autofs[^4]
-	then
-		# wrong autofs filesystem module loaded
+	elif ([ -f /proc/modules ] && lsmod) | grep -q autofs[^4]; then
+		# Wrong (old) autofs filesystem module loaded
 		echo
-		echo "Error: autofs kernel module is loaded, autofs4 required"
+		echo "Error: autofs kernel module is loaded, $MODULE required."
 		return 1
 	fi
 
@@ -109,7 +106,7 @@ function restart() {
 
 function reload() {
 	pid=`pidof $prog`
-	if [ -z $pid ]; then
+	if [ -z "$pid" ]; then
 		echo $"$prog not running"
 		RETVAL=1
 	else
@@ -136,6 +133,11 @@ case "$1" in
 	restart)
 		restart
 		;;
+	try-restart)
+		if [ -n "`pidof $prog`" ]; then
+			restart
+		fi
+		;;
 	forcerestart)
 		OPTIONS="$OPTIONS --force"
 		restart
@@ -144,7 +146,7 @@ case "$1" in
 		reload
 		;;
 	*)
-		echo $"Usage: $0 {start|forcestart|stop|restart|forcerestart|reload}"
+		echo $"Usage: $0 {start|forcestart|stop|restart|try-restart|forcerestart|reload}"
 		exit 1;
 		;;
 esac
