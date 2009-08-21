From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch,
	trivial] fix a typo in the redhat/autofs.init.in usage text
Date: Fri, 21 Aug 2009 11:24:14 -0400
Message-ID: <x498whdur4x.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/redhat/autofs.init.in b/redhat/autofs.init.in
index fded1d8..806302b 100644
--- a/redhat/autofs.init.in
+++ b/redhat/autofs.init.in
@@ -172,7 +172,7 @@ case "$1" in
 		fi
 		;;
 	*)
-		echo $"Usage: $0 {start|forcestart|stop|status|restart|orcerestart|reload|condrestart}"
+		echo $"Usage: $0 {start|forcestart|stop|status|restart|forcerestart|reload|condrestart}"
 		exit 1;
 		;;
 esac
