From: "Gordon Lack" <gml4410@ggr.co.uk>
Subject: -hosts and -null enabling for autofs v4.1.x
Date: Fri, 07 Jul 2006 16:02:29 +0100
Message-ID: <44AE7785.74E63D70@ggr.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary=------------FA069077B19ED5AECCBDEF80
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
--------------FA069077B19ED5AECCBDEF80
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit

   Here is a simple patch to the system autofs startup script so that
-hosts and -null is enabled in autofs 4.1.x.  This patch is actually
against a RedHat autofs, but the same code is present in
samples/rc.autofs.in.

   For -hosts, it just translates the map name to /etc/auto.net if that
is present and executable.

   For -null, it just adds the mountpoint location to the list of
knownmaps, but doesn't do anything else.


PS:  I see that v5 handles these anyway.  However, this note in
README.v5.release looks ominous...

==========
- a "hosts" map module has been added
  - an entry like "/net -hosts" is now understood and uses the new
    multi-mount semantics for lazy mount/umount of exports from the
host.
  - the implementation is quite simple minded at this stage and will
need
    refinment. It just iterates through the host table and addes any
host
    names it finds to the internal map.
==========

Some of us have thousands of hosts in a host map, eg:

systemx*[1] ypcat -k hosts | wc -l
   30899
--------------FA069077B19ED5AECCBDEF80
Content-Type: text/plain;
 charset=us-ascii;
 name=autofs.diffs
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=autofs.diffs

*** autofs.orig	2006-07-07 08:56:05.000000000 -0400
--- autofs	2006-07-07 09:25:57.000000000 -0400
***************
*** 191,197 ****
  	    dir=`echo "$dir" | sed -e "s/\/*$//"`
  
  	    if [ ! -z "$map" -a "$map" = "-hosts" ] ; then
! 		continue
  	    fi
  	    if [ $DISABLE_DIRECT -eq 1 \
  			-a x`echo $dir | grep -E "^/-"` != 'x' ]
--- 191,201 ----
  	    dir=`echo "$dir" | sed -e "s/\/*$//"`
  
  	    if [ ! -z "$map" -a "$map" = "-hosts" ] ; then
!                 if [ -x '/etc/auto.net' ]; then
!                     map='/etc/auto.net'
!                 else
!                     continue
!                 fi
  	    fi
  	    if [ $DISABLE_DIRECT -eq 1 \
  			-a x`echo $dir | grep -E "^/-"` != 'x' ]
***************
*** 210,215 ****
--- 214,224 ----
  		fi	
  	    done
  
+             if [ "$map" = '-null' ]; then
+ # Just add dir to list of those with a known map, but do nothing else
+                 knownmaps=" $dir/ $knownmaps"
+                 continue
+             fi
  	    if [ ! -z "$dir" -a ! -z "$map" \
  			-a x`echo "$map" | cut -c1` != 'x-' ]
  	    then

--------------FA069077B19ED5AECCBDEF80
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------FA069077B19ED5AECCBDEF80--

