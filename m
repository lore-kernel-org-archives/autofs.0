From: Chris Feist <cfeist@redhat.com>
Subject: [PATCH] Fix, to fix the ordering of +ypmapname entries in
	/etc/auto.master
Date: Thu, 21 Oct 2004 18:15:01 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1098400501.3014.50.camel@gold.msp.redhat.com>
Reply-To: cfeist@redhat.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Eh34Znqw2ZjzLIU8DNhQ"
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
To: raven@themaw.net, autofs@linux.kernel.org


--=-Eh34Znqw2ZjzLIU8DNhQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Ian,

This patch will have automount process map entries that refer to yp maps
(ie. +auto_master) in the same order as they show up in the
/etc/auto.master file.  Previously all entries that didn't refer to
another yp map were processed before entries refering to a yp map.

For example with the following /etc/auto.master:
/home /etc/auto.home
+auto_master
/misc /etc/auto.misc

In 4.1.3, all maps in auto_master would be included after the /home &
/misc line.

With this patch all lines in the auto_master file will be processed
after the /home line, but before the /misc line.

Thanks,
Chris

--=-Eh34Znqw2ZjzLIU8DNhQ
Content-Disposition: attachment; filename=autofs-4.1.3-plus-map-ordering.patch
Content-Type: text/x-patch; name=autofs-4.1.3-plus-map-ordering.patch;
	charset=UTF-8
Content-Transfer-Encoding: 7bit

--- autofs-4.1.3/samples/rc.autofs.in.plus-map-ordering	2004-10-21 18:07:48.873983806 -0500
+++ autofs-4.1.3/samples/rc.autofs.in	2004-10-21 18:07:59.500816215 -0500
@@ -94,10 +94,19 @@
 function getfilemounts()
 {
     if [ -f /etc/auto.master ] ; then
-        cat /etc/auto.master | grep -v '^\+' | sed -e '/^#/d' -e '/^$/d'
-        for nismap in `cat /etc/auto.master | grep '^\+' | sed -e '/^#/d' -e '/^$/d'`; do
-            catnismap `echo "$nismap" | sed -e 's/^\+//'`
+        cat /etc/auto.master | sed -e '/^#/d' -e '/^$/d' | (
+        while read auto_master_in
+        do
+            if [ "`echo $auto_master_in | grep '^+'`" = "" ]; then
+                echo $auto_master_in
+            else
+                for nismap in `cat /etc/auto.master | grep '^\+' |
+                        sed -e '/^#/d' -e '/^$/d'`; do
+                    catnismap `echo "$nismap" | sed -e 's/^\+//'`
+                done
+            fi
         done
+        )
     fi
 }
 function getnismounts()

--=-Eh34Znqw2ZjzLIU8DNhQ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--=-Eh34Znqw2ZjzLIU8DNhQ--

