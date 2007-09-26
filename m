From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: [PATCH] 5.0.0_beta1: glibc 2.4.0 quirk
Date: Wed, 26 Sep 2007 11:03:19 +0100
Message-ID: <200709261103.19490.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_n5i+Gq5sIEMzgIB"
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

--Boundary-00=_n5i+Gq5sIEMzgIB
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi Ian,

I have glibc 2.4.0 installed, and it expands pthread_cleanup_pop(1) into:

	} while (0); __pthread_unregister_cancel (&__cancel_buf); if (1) __cancel_routine (__cancel_arg); } while (0);

This doesn't compile if you have a label before it.
gcc 4.2.1 says "error: label at end of compound statement".

This patch works around it by adding extra semicolon.
--
vda

--Boundary-00=_n5i+Gq5sIEMzgIB
Content-Type: text/x-diff; charset="us-ascii";
	name="autofs-5.0.0_beta1-quirk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="autofs-5.0.0_beta1-quirk.patch"

diff -d -urpN autofs-5.0.0_beta1-PATH/daemon/direct.c autofs-5.0.0_beta1-quirk/daemon/direct.c
--- autofs-5.0.0_beta1-PATH/daemon/direct.c	2007-09-26 10:29:28.000000000 +0100
+++ autofs-5.0.0_beta1-quirk/daemon/direct.c	2007-09-26 10:38:01.000000000 +0100
@@ -967,7 +967,10 @@ int handle_packet_expire_direct(struct a
 
 	pthread_cleanup_pop(1);
 done:
-	pthread_cleanup_pop(1);
+	/* glibc 2.4.0 expands it into: */
+	/* } while (0); __pthread_unregister_cancel (&__cancel_buf); if (1) __cancel_routine (__cancel_arg); } while (0); */
+	/* ...and gcc 4.2.1 says "error: label at end of compound statement" */
+	; pthread_cleanup_pop(1);
 	return status;
 }
 
@@ -1258,7 +1261,10 @@ int handle_packet_missing_direct(struct 
 
 	pthread_cleanup_pop(1);
 done:
-	pthread_cleanup_pop(1);
+	/* glibc 2.4.0 expands it into: */
+	/* } while (0); __pthread_unregister_cancel (&__cancel_buf); if (1) __cancel_routine (__cancel_arg); } while (0); */
+	/* ...and gcc 4.2.1 says "error: label at end of compound statement" */
+	; pthread_cleanup_pop(1);
 	return status;
 }
 

--Boundary-00=_n5i+Gq5sIEMzgIB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--Boundary-00=_n5i+Gq5sIEMzgIB--

