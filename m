From: Chris Feist <cfeist@redhat.com>
Subject: [patch] Updated autofs-4.1.3-signal-race-fix.patch
Date: Mon, 18 Oct 2004 10:50:14 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1098114614.6300.11.camel@dhcp187.msp.redhat.com>
Reply-To: cfeist@redhat.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-qN6rm3CHFLvjzAA28VE3"
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


--=-qN6rm3CHFLvjzAA28VE3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Ian,

I've attached an updated patch from Jeff Moyer's earlier signal race
patch which allows the SIGCHLD signal to be received in the middle of
st_expire() before ap.state can be set to ST_EXPIRE.  This causes the
signal handling function for SIG_CHLD to never run the alarm() function
which causes the SIGALRM signal to never be sent (or received) by
automount, which causes directories w/ a timeout to never be unmounted.

Thanks,
Chris

--=-qN6rm3CHFLvjzAA28VE3
Content-Disposition: attachment; filename=autofs-4.1.3-signal-race-fix.patch
Content-Type: text/x-patch; name=autofs-4.1.3-signal-race-fix.patch;
	charset=UTF-8
Content-Transfer-Encoding: 7bit

--- autofs-4.1.3/daemon/automount.c.signal-race-fix	2004-10-15 18:57:23.000000000 -0500
+++ autofs-4.1.3/daemon/automount.c	2004-10-15 18:57:59.000000000 -0500
@@ -833,10 +833,10 @@
 	alarm(0);
 
 	/* Prevent any new mounts */
-	ap.state = ST_SHUTDOWN_PENDING;
-
 	sigprocmask(SIG_SETMASK, &lock_sigs, NULL);
 
+	ap.state = ST_SHUTDOWN_PENDING;
+
 	/* Unmount everything */
 	exp = expire_proc(1);
 
@@ -904,6 +904,7 @@
 		return 1;
 
 	case EXP_STARTED:
+		sigprocmask(SIG_SETMASK, &lock_sigs, NULL);
 		ap.state = ST_EXPIRE;
 		sigprocmask(SIG_SETMASK, &ready_sigs, NULL);
 		return 0;

--=-qN6rm3CHFLvjzAA28VE3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--=-qN6rm3CHFLvjzAA28VE3--

