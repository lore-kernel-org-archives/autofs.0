From: Chris Feist <cfeist@redhat.com>
Subject: Re: [patch] Maintain backwards compatibility w/ local file maps
	w/o etc.
Date: Fri, 22 Oct 2004 10:13:26 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1098458006.3014.58.camel@gold.msp.redhat.com>
References: <1098291410.3527.18.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0410211040430.4454@wombat.indigo.net.au>
	 <1098372523.9364.17.camel@gold.msp.redhat.com>
	 <Pine.LNX.4.58.0410221329100.7438@wombat.indigo.net.au>
Reply-To: cfeist@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0410221329100.7438@wombat.indigo.net.au>
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
To: Ian Kent <raven@themaw.net>, autofs@linux.kernel.org


> But the patch doesn't appear to fix that problem.
> Can you explain?
> 
> Ian
> 

Oops, sorry about that.  I didn't send you the correct version of the
patch.  The problem is in the added lines, it says 'maptype=program' it
should say 'maptype=file'...  Here's the corrected patch...

Thanks,
Chris

s-4.1.3/samples/rc.autofs.in.filemap-etc-append       
2004-10-20 11:47:05.227372963 -0500
+++ autofs-4.1.3/samples/rc.autofs.in   2004-10-20 11:47:06.947345831
-0500
@@ -206,6 +206,9 @@
                        map=`echo /etc/$map | sed 's^//^/^g'`
                    elif [ -f "$map" ]; then
                        maptype=file
+                   elif [ -f "/etc/$map" ]; then
+                       maptype=file
+                       map=`echo /etc/$map | sed 's^//^/^g'`
                    elif [ "$map" = "hesiod" -o "$map" = "userhome" ] ;
then
                        maptype=$map
                        map=
