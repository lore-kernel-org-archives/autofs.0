From: Christian Vogel <vogelchr@vogel.cx>
Subject: PATCH: autofs initscript: SuSE
Date: Tue, 30 Dec 2003 12:16:31 +0100
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20031230121631.3cb0d8f4.vogelchr@vogel.cx>
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

Hi,

I changed the autofs init script supplied with 4.1.0 to work with SuSE
(V7.2 tested). SuSE has /sbin/startproc and /sbin/killproc to start and
stop daemons. I could not use startproc because startproc tries to avoid
having duplicate processes running (/usr/sbin/automount), and if you
have several automounters running, this is not what you want. killproc
behaves correctly as long as we provide the correct pidfile (does not
work with startproc, I tried). 

	Chris

--- autofs      2003/12/29 14:08:46     1.1
+++ autofs      2003/12/30 11:11:08
@@ -41,6 +41,8 @@
     system=debian
 elif [ -f /etc/redhat-release ]; then
     system=redhat
+elif [ -f /etc/SuSE-release ] ; then
+    system=SuSE
 else
     echo "$0: Unknown system, please port and contact autofs@linux.kernel.org" 1>&2
     exit 1
@@ -402,11 +404,46 @@
 esac
 }
 
+function SuSE()
+{
+       case "$1" in
+               start)
+                       echo -n "Starting automounter: "
+                       getmounts | while read cmd mnt rest
+                       do
+                               echo -n " $mnt"
+                               pidfile=/var/run/autofs${mnt//\//.}.pid
+
+                               $DAEMON -p $pidfile \
+                                       $daemonoptions -- $mnt $rest
+
+                       done
+                       echo " ."
+               ;;
+               stop)
+                       echo -n "Stopping automounter:"
+                       getmounts | while read cmd mnt rest
+                       do
+                               echo -n " $mnt"
+                               pidfile=/var/run/autofs${mnt//\//.}.pid
+                               killproc -p $pidfile $DAEMON
+                       done
+                       echo " ."
+               ;;
+               *)
+                       echo "Usage: $0 start|stop" >&2
+                       exit 1
+               ;;
+       esac
+}
+
 RETVAL=0
 if [ $system = debian ]; then
        debian "$@"
 elif [ $system = redhat ]; then
        redhat "$@"
+elif [ $system = SuSE ] ; then
+       SuSE "$@"
 fi
 
 exit $RETVAL
