From: Ian Kent <raven@themaw.net>
Subject: Re: [ANNOUNCE] autofs 5.0.0 beta1
Date: Wed, 3 May 2006 23:58:58 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0605032354490.31402@raven.themaw.net>
References: <Pine.LNX.4.64.0605022329020.10568@raven.themaw.net>
	<20060503131637.GA30523@kaminsky>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20060503131637.GA30523@kaminsky>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Moshe Kaminsky <kaminsky@math.huji.ac.il>
Cc: autofs@linux.kernel.org

On Wed, 3 May 2006, Moshe Kaminsky wrote:

> 
> I modified the ebuild for autofs4 and tried to compile. I get:
> 
> gcc -g -Os -march=athlon-tbird -pipe -fomit-frame-pointer -D_REENTRANT -D_REENTRANT -rdynamic -fPIE -D_GNU_SOURCE -I../include -DAUTOFS_LIB_DIR=\"/usr/lib/autofs\"  -DAUTOFS_MAP_DIR=\"/etc/autofs\" -DAUTOFS_CONF_DIR=\"/etc/sysconfig\" -DVERSION_STRING=\"5.0.0_beta1\" -c direct.c
> direct.c: In function `handle_packet_expire_direct':
> direct.c:969: error: label at end of compound statement
> direct.c: In function `handle_packet_missing_direct':
> direct.c:1260: error: label at end of compound statement
> make[1]: *** [direct.o] Error 1
> make[1]: Leaving directory `/usr/tmp/portage/autofs-5.0.0_beta1/work/autofs-5.0.0_beta1/daemon'

I'm not sure this will make a difference but could you give it a try.

diff --git a/daemon/direct.c b/daemon/direct.c
index 96f934f..f9b6dda 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -877,7 +877,7 @@ int handle_packet_expire_direct(struct a
 	struct pending_args *mt;
 	char buf[MAX_ERR_BUF];
 	pthread_t thid;
-	int status = 0;
+	int status = 0, cancel_state;
 
 	/*
 	 * This is a bit of a big deal.
@@ -953,9 +953,10 @@ int handle_packet_expire_direct(struct a
 		free(mt);
 		send_fail(mt->ioctlfd, pkt->wait_queue_token);
 		status = 1;
+		goto done;
 	}
 
-	pthread_cleanup_push(pending_cleanup, mt);
+	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &cancel_state);
 
 	mt->signaled = 0;
 	while (!mt->signaled) {
@@ -964,7 +965,8 @@ int handle_packet_expire_direct(struct a
 			fatal(status);
 	}
 
-	pthread_cleanup_pop(1);
+	pending_cleanup(mt);
+	pthread_setcancelstate(cancel_state, &cancel_state);
 done:
 	pthread_cleanup_pop(1);
 	return status;
@@ -1151,7 +1153,7 @@ int handle_packet_missing_direct(struct 
 	pthread_t thid;
 	struct pending_args *mt;
 	char buf[MAX_ERR_BUF];
-	int status = 0;
+	int status = 0, cancel_state;
 	int ioctlfd;
 
 	master_source_readlock(ap->entry);
@@ -1246,7 +1248,7 @@ int handle_packet_missing_direct(struct 
 		goto done;
 	}
 
-	pthread_cleanup_push(pending_cleanup, mt);
+	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &cancel_state);
 
 	mt->signaled = 0;
 	while (!mt->signaled) {
@@ -1255,7 +1257,8 @@ int handle_packet_missing_direct(struct 
 			fatal(status);
 	}
 
-	pthread_cleanup_pop(1);
+	pending_cleanup(mt);
+	pthread_setcancelstate(cancel_state, &cancel_state);
 done:
 	pthread_cleanup_pop(1);
 	return status;

> 
> Note that I removed all the patches that were used for autofs4. I'm 
> using gcc 3.4.6.

You'll have to review the Gentoo init script also.
A starting point is the one in the tarball. It should be fairly close but 
you'll need to review it.

> 
> Another question I have: I once asked if it's possible to run the actual 
> mount command as the user trying to read the directory, instead of root. 
> I was told that this is impossible in version 4. Will it be possible 
> now?
> 
> Thanks,
> Moshe
> 
