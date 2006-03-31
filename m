From: Jeff Bastian <jmbastia@ti.com>
Subject: LDAPAUTOMASTER patch
Date: Fri, 31 Mar 2006 12:23:19 -0600
Message-ID: <442D7397.6030909@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010805080309000408090600"
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

This is a multi-part message in MIME format.
--------------010805080309000408090600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The /usr/lib/autofs/autofs-ldap-auto-master provides a number of command 
line options to help the program find your auto.master map if it's not 
in the default location on your LDAP servers, however, the 
/etc/rc.d/init.d/autofs script does not have any mechanism to pass in 
these command line options.

Attached is a patch (derived from Fedora Core 5's autofs-4.1.4-16.2.2 
package) that adds an $LDAPAUTOMASTER variable to the 
/etc/sysconfig/autofs file and the same variable to the 
autofs-ldap-auto-master command in the init script.

Jeff Bastian


--------------010805080309000408090600
Content-Type: text/plain;
 name="autofs-fc5-ldap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="autofs-fc5-ldap.patch"

diff -urN autofs-4.1.4-16.2.2/etc/rc.d/init.d/autofs autofs-4.1.4-16.2.2.patch/etc/rc.d/init.d/autofs
--- autofs-4.1.4-16.2.2/etc/rc.d/init.d/autofs	2006-03-31 11:10:51.000000000 -0600
+++ autofs-4.1.4-16.2.2.patch/etc/rc.d/init.d/autofs	2006-03-31 11:15:33.000000000 -0600
@@ -85,6 +85,7 @@
 	DISABLE_DIRECT=1
 	DAEMON_EXIT_WAIT=20
 	ONE_AUTO_MASTER=0
+	LDAPAUTOMASTER=""
 
 	[ -f /etc/sysconfig/autofs ] && . /etc/sysconfig/autofs
 
@@ -165,7 +166,7 @@
 function getldapmounts()
 {
     if [ -x /usr/lib/autofs/autofs-ldap-auto-master ]; then
-        /usr/lib/autofs/autofs-ldap-auto-master 2> /dev/null
+        /usr/lib/autofs/autofs-ldap-auto-master $LDAPAUTOMASTER 2> /dev/null
     fi
 }
 
diff -urN autofs-4.1.4-16.2.2/etc/sysconfig/autofs autofs-4.1.4-16.2.2.patch/etc/sysconfig/autofs
--- autofs-4.1.4-16.2.2/etc/sysconfig/autofs	2006-03-31 11:10:51.000000000 -0600
+++ autofs-4.1.4-16.2.2.patch/etc/sysconfig/autofs	2006-03-31 11:13:29.000000000 -0600
@@ -19,3 +19,7 @@
 # this value.
 DAEMON_EXIT_WAIT=10
 
+# LDAPAUTOMASTER contains command line arguments for the 
+# /usr/lib/autofs/autofs-ldap-auto-master program
+# Run the program with --help to see available options
+LDAPAUTOMASTER=""

--------------010805080309000408090600
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------010805080309000408090600--

