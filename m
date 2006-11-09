From: Jeff Moyer <jmoyer@redhat.com>
Subject: [autofs4 patch] fix stderr redirect in the init script
Date: Wed, 08 Nov 2006 22:06:54 -0500
Message-ID: <x49velpnws1.fsf@segfault.boston.devel.redhat.com>
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

Someone put a space where it doesn't belong, inbetween the '2' and the
'>' in 2>.  This isn't interpreted as a stderr redirect.  Fixie, fixie.

-Jeff

diff --git a/samples/rc.autofs.in b/samples/rc.autofs.in
index 27ef6bb..f6f0444 100644
--- a/samples/rc.autofs.in
+++ b/samples/rc.autofs.in
@@ -446,7 +446,7 @@ function signal_automounts()
 	pgrp_pids=`get_pgrp_pids`
 	for pid in $pgrp_pids
 	do
-		kill -USR2 $pid 2 > /dev/null
+		kill -USR2 $pid 2> /dev/null
 		count=0
 		while ps ax|grep -v grep|grep $pid >/dev/null
 		do
