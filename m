From: Marc MERLIN <marc@merlins.org>
Subject: autofs init script doesn't support exclude
Date: Mon, 20 Sep 2004 15:49:49 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040920224949.GL23879@merlins.org>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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

From https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=91559

Could you add a patch of that sort so that we can override an ldap/yp
auto.master and mount one or several of those mountpoints locally in /etc/fstab?

--- autofs.FCS  2003-01-27 20:22:54.000000000 -0800
+++ autofs      2003-05-23 18:38:27.000000000 -0700
@@ -34,6 +34,11 @@
 initdir=/etc/init.d
 
 #
+# Read configuration options
+#
+[ -f /etc/sysconfig/autofs ] && . /etc/sysconfig/autofs
+
+#
 # Determine which kind of configuration we're using
 #
 system=unknown
@@ -196,6 +201,16 @@
                fi
                map=`echo $map | cut -f2- -d:`
 
+               # Process exclude list (to reduce number of automounts)
+               if [ ! -z "$AUTOFS_EXCLUDE" ]; then
+                   for exclude in $AUTOFS_EXCLUDE
+                   do
+                       if [ x"$exclude" = x"$dir" ]; then
+                           continue
+                       fi
+                   done
+               fi
+
                : echo STARTUPOPTIONS $startupoptions
                : echo DIR $dir
                : echo MAPTYPE $maptype


I don't need this anymore as this is only useful if you use nis.
With ldap, you can use the following undocumented trick:
mrhat:~$ cat /etc/auto.master
/home /etc/auto.null
(doesn't work with YP though)

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems & security ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/   |   Finger marc_f@merlins.org for PGP key
