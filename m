From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: some questions about the configuration
Date: Thu, 09 Feb 2006 16:30:42 +0100
Message-ID: <43EB6022.7030608@inria.fr>
References: <43D4F1E0.2060201@inria.fr>	<Pine.LNX.4.64.0601242036050.3037@eagle.themaw.net>	<43D8F3DE.5080003@inria.fr>	<17369.661.597510.89926@segfault.boston.redhat.com>	<43DA3077.7090008@inria.fr>
	<17370.16787.475552.297972@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000406020309040106080909"
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17370.16787.475552.297972@segfault.boston.redhat.com>
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
--------------000406020309040106080909
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jeff Moyer wrote:
> ==> Regarding Re: [autofs] some questions about the configuration; Guillaume Rousse <Guillaume.Rousse@inria.fr> adds:
> 
> Guillaume.Rousse> Jeff Moyer wrote: OK, I understand they have different
> Guillaume.Rousse> nature, so they can't have the exact same naming
> Guillaume.Rousse> scheme. But if auto.smb and auto.smb are exemple, they
> Guillaume.Rousse> should not get installed, and especially not among
> Guillaume.Rousse> configuration files whereas they are executables
> Guillaume.Rousse> programs.
> Guillaume.Rousse> I'd rather have called ldap.master.map, smb.user.map and
> Guillaume.Rousse> net.user.map, or something similar, and have them
> Guillaume.Rousse> installed in the same place.
>>> You can modify auto.net or auto.smb to suit your needs.  In that sense,
>>> they are user-configurable automounter maps, and belong with the other
>>> maps.  I understand that autofs configuration is a bit overwhelming, and
>>> the documentation is lacking.  Perhaps we should focus on improving the
>>> documentation.
> Guillaume.Rousse> This does still look like a poor hack: if they are
> Guillaume.Rousse> supposed to be adaptable to specific user needs, they
> Guillaume.Rousse> should use a configuration file. And if the not flexible
> Guillaume.Rousse> enough, be kept as exemples in congifuration, not
> Guillaume.Rousse> installed by default (especially if not automatically
> Guillaume.Rousse> used).
> 
> This is an opinion that I do not share.  /net is configured by default, and
> so the auto.net map is used by default.  Additionally, supporting program
> maps makes the automounter quite a bit more flexible that it would
> otherwise be.
I never pretended the opposite. My point is that you can't label
executable scripts as 'configuration' and put them under /etc, just
because users could eventually modify them to suit their needs. This is
not FHS compliant.

Either they work as they are (which seems the case from waht you say and
from my own tests with auto.net), and they should get installed under
program directory (/usr/lib/autofs), with eventually some aditional
configuration file under /etc.

Either they are unfinished scripts, provided as exemples, that are meant
to be customised by users, and finally installed as programs manually
under local script directory (/usr/local/sbin).
[..]
> Guillaume.Rousse> BTW, the default init script is quite ugly, it calls
> Guillaume.Rousse> catnismap with each additional NIS master map each time a
> Guillaume.Rousse> line is found beginning with '+'.
> 
> Patches are welcome.  Please use the -up options to diff.
Here are two distinct patches, with a clearer syntax, less external
process call, and correcting multiple call to catnismap from getfilemounts.


--------------000406020309040106080909
Content-Type: text/plain;
 name="autofs.init.getfilemounts.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="autofs.init.getfilemounts.patch"

--- samples/rc.autofs.in	2005-04-11 13:30:54.000000000 +0200
+++ samples/rc.autofs.in.new	2006-02-03 17:05:41.000000000 +0100
@@ -135,16 +135,13 @@ function catnismap()
 function getfilemounts()
 {
     if [ -f /etc/auto.master ] ; then
-        cat /etc/auto.master | awk '{print $0}' | sed -e '/^#/d' -e '/^$/d' | (
-        while read auto_master_in
+        awk '/^[^#]/{print $0}' /etc/auto.master | (
+        while read line
         do
-            if [ "`echo $auto_master_in | grep '^+'`" = "" ]; then
-                echo $auto_master_in
+	    if [[ "$line" == +* ]]; then
+		catnismap ${line:1}
             else
-                for nismap in `cat /etc/auto.master | grep '^\+' |
-                        sed -e '/^#/d' -e '/^$/d'`; do
-                    catnismap `echo "$nismap" | sed -e 's/^\+//'`
-                done
+                echo $line
             fi
         done
         )

--------------000406020309040106080909
Content-Type: text/plain;
 name="autofs.init.getscheme.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="autofs.init.getscheme.patch"

--- samples/rc.autofs.in	2005-04-11 13:30:54.000000000 +0200
+++ samples/rc.autofs.in.new	2006-02-03 17:08:03.000000000 +0100
@@ -111,15 +111,13 @@ fi
 #
 function getschemes()
 {
-	SOURCES=`grep ^automount: /etc/nsswitch.conf | \
-		 sed -e 's/^.*://' -e 's/\[.*\]/ /g'`
+    SOURCES=`awk -F: '/^automount/{print $2}' /etc/nsswitch.conf`
 
-	if [ `echo $SOURCES | awk '{print NF}'` -gt 0 ]
-	then
-		echo ${SOURCES}
-	else
-		echo files
-	fi
+    if [ -n "${SOURCES// /}" ]; then
+	echo ${SOURCES}
+    else
+	echo files
+    fi
 }
 
 function catnismap()

--------------000406020309040106080909
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------000406020309040106080909--

