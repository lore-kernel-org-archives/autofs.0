From: Jeff Moyer <jmoyer@redhat.com>
Subject: [autofs4 patch] touch /var/lock/subsys/autofs at startup
Date: Wed, 08 Nov 2006 22:24:10 -0500
Message-ID: <x49ejsdnvz9.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>, autofs mailing list <autofs@linux.kernel.org>

Hi, Ian, list,

It turns out that a condrestart will fail if there were previously no
maps, and then you populate some.  This is a pretty trivial case to
fix, and it looks right to me.  I tested it, and it now works as expected.

Comments welcome as usual.

-Jeff

diff --git a/samples/rc.autofs.in b/samples/rc.autofs.in
index f6f0444..5b71481 100644
--- a/samples/rc.autofs.in
+++ b/samples/rc.autofs.in
@@ -560,6 +560,7 @@ case "$1" in
 	else
 	    echo -n $"No Mountpoints Defined"
 	    success "$prog startup"
+	    touch /var/lock/subsys/autofs
 	fi
 	rm -f $TMP
 	echo
