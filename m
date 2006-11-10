From: "Gordon Lack" <gml4410@ggr.co.uk>
Subject: autofsv5 bug.  Non-existent dirs get "mounted"!
Date: Fri, 10 Nov 2006 11:58:36 +0000
Message-ID: <4554696C.5030400@ggr.co.uk>
References: <44AE7785.74E63D70@ggr.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary=------------050206080602060100010104
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <44AE7785.74E63D70@ggr.co.uk>
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
To: autofs@linux.kernel.org

This is a multi-part message in MIME format.
--------------050206080602060100010104
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit

    If you have a wildcard entry in an automount map and refer to an 
entry which does not exist on the NFS server the entry actually appears 
within the autofs tree (but with nothing mounted on it).

    This causes havoc if you are testing for the existence of a 
directory in an automount point.

    It took a while to track it down, since all of the code to remove 
the locally-created dir if the mount failed was in place.  I eventually 
found an incorrect reuse of a status variable, which is overwriting the 
return code from the mount (failed), with that of a mutex unlock (which 
must succeed, or the process dies..).

    This happens in daemon/spawn.c

    Patch (against distro as on 10 Nov 2006) attached.

--------------050206080602060100010104
Content-Type: text/plain;
 name=spawn.c.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=spawn.c.patch

--- daemon/spawn.c.orig	2006-11-10 10:28:47.270474000 +0000
+++ daemon/spawn.c	2006-11-10 10:11:22.917315000 +0000
@@ -202,11 +202,25 @@
 		if (waitpid(f, &status, 0) != f)
 			status = -1;	/* waitpid() failed */
 
-		if (use_lock) {
+/* GML - Bug.
+ *  This code used status, hence wiping out the result of the mount!
+ *  Hence we always return from here with success, even when the
+ *  mount actually fails, meaning we get directories created for
+ *  non-existent entries...
+ */
+#if 0 
+ 		if (use_lock) {
 			status = pthread_mutex_unlock(&spawn_mutex);
 			if (status)
 				fatal(status);
 		}
+#endif
+		if (use_lock) {
+                        int lstatus;
+			lstatus = pthread_mutex_unlock(&spawn_mutex);
+			if (lstatus)
+				fatal(lstatus);
+		}
 		pthread_sigmask(SIG_SETMASK, &oldsig, NULL);
 		pthread_setcancelstate(cancel_state, NULL);
 

--------------050206080602060100010104
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------050206080602060100010104--

