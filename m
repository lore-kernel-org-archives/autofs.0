From: raven@themaw.net
Subject: Race in expire code
Date: Sat, 29 Jan 2005 21:36:31 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0501292129280.14112@donald.themaw.net>
Mime-Version: 1.0
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: autofs mailing list <autofs@linux.kernel.org>


Hi all,

I've had three reports now, of mounts not expiring. This appears to be 
caused by a race in the function st_expire in automount.c.

Can everyone who is maintaining downstream packages please chaeck that 
the code in their package ends up looking like what the patch below 
acheives.

And for those that have reported the problem, please try this patch.

Ian

--- autofs-4.1.3-michael/daemon/automount.c.sig-fix	2005-01-19 20:11:09.000000000 +0800
+++ autofs-4.1.3-michael/daemon/automount.c	2005-01-19 20:12:02.000000000 +0800
@@ -920,8 +920,8 @@
  		return 1;

  	case EXP_STARTED:
-		sigprocmask(SIG_SETMASK, &ready_sigs, NULL);
  		ap.state = ST_EXPIRE;
+		sigprocmask(SIG_SETMASK, &ready_sigs, NULL);
  		return 0;
  	}
  	return 1;
