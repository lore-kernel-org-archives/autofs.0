From: Jeff Moyer <jmoyer@redhat.com>
Subject: patch, new test rpm: only source one master map
Date: Thu, 12 Aug 2004 13:25:03 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16667.42991.938617.416626@segfault.boston.redhat.com>
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
To: autofs@linux.kernel.org
Cc: raven@themaw.net

Hello,

I've rolled another test rpm with a patch to only parse one master map.
Previously, we concatenated all master maps we found, which caused problems
in some environments.  Attached is the patch which addresses this, and you
can find a new test version of the autofs rpm on my people page:

    http://people.redhat.com/~jmoyer/

I've only created rpms for fc3.  If you would like to run this on other
distributions, feel free to recompile the SRPM.

I am very interested in getting some testing of this.  I'm mainly
interested in seeing if this causes regressions for anyone (presumably
because you were depending on this arguably broken behaviour).  Please also
note that this rpm includes Ian's experimental map expiry patches, so this
is not expected to be super stable.  Use at your own risk.

Thanks!

Jeff

--- autofs-4.1.3/samples/rc.autofs.in.one-auto-master	2004-08-09 15:57:18.985431288 -0400
+++ autofs-4.1.3/samples/rc.autofs.in	2004-08-09 17:08:24.842922376 -0400
@@ -110,21 +110,33 @@
         case "$scheme" in
             files)
                 if [ -z "$filescheme" ] ; then
-                    getfilemounts
-                    filescheme=1
+                    MOUNTS=`getfilemounts`
+                    if [ -n "$MOUNTS" ] ; then
+                        getfilemounts
+                        return
+		    fi
+		    filescheme=1
                     export filescheme
                 fi
                 ;;
             nis)
                 if [ -z "$nisscheme" ] ; then
-                    getnismounts
+                    MOUNTS=`getnismounts`
+                    if [ -n "$MOUNTS" ] ; then
+                        getnismounts
+                        return
+		    fi
                     nisscheme=1
                     export nisscheme
                 fi
                 ;;
             ldap*)
                 if [ -z "$ldapscheme" ] ; then
-                    getldapmounts
+                    MOUNTS=`getldapmounts`
+                    if [ -n "$MOUNTS" ] ; then
+                        getldapmounts
+                        return
+                    fi
                     ldapscheme=1
                     export ldapscheme
                 fi
