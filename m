From: Ian Kent <raven@themaw.net>
Subject: Re: [ANNOUNCE] autofs 5.0.0 beta1
Date: Thu, 4 May 2006 01:56:47 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0605040156090.2085@raven.themaw.net>
References: <Pine.LNX.4.64.0605022329020.10568@raven.themaw.net>
	<20060503131637.GA30523@kaminsky>
	<Pine.LNX.4.64.0605032354490.31402@raven.themaw.net>
	<20060503170005.GD1982@kaminsky>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20060503170005.GD1982@kaminsky>
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

> * Ian Kent <raven@themaw.net> [03/05/06 19:15]:
> > On Wed, 3 May 2006, Moshe Kaminsky wrote:
> > 
> > > 
> > > I modified the ebuild for autofs4 and tried to compile. I get:
> > > 
> > > gcc -g -Os -march=athlon-tbird -pipe -fomit-frame-pointer -D_REENTRANT -D_REENTRANT -rdynamic -fPIE -D_GNU_SOURCE -I../include -DAUTOFS_LIB_DIR=\"/usr/lib/autofs\"  -DAUTOFS_MAP_DIR=\"/etc/autofs\" -DAUTOFS_CONF_DIR=\"/etc/sysconfig\" -DVERSION_STRING=\"5.0.0_beta1\" -c direct.c
> > > direct.c: In function `handle_packet_expire_direct':
> > > direct.c:969: error: label at end of compound statement
> > > direct.c: In function `handle_packet_missing_direct':
> > > direct.c:1260: error: label at end of compound statement
> > > make[1]: *** [direct.o] Error 1
> > > make[1]: Leaving directory `/usr/tmp/portage/autofs-5.0.0_beta1/work/autofs-5.0.0_beta1/daemon'
> > 
> > I'm not sure this will make a difference but could you give it a try.
> 
> This didn't help.
> 

This fixes it.

diff --git a/daemon/direct.c b/daemon/direct.c
index 96f934f..66d2efa 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -953,6 +953,7 @@ int handle_packet_expire_direct(struct a
 		free(mt);
 		send_fail(mt->ioctlfd, pkt->wait_queue_token);
 		status = 1;
+		goto done;
 	}
 
 	pthread_cleanup_push(pending_cleanup, mt);
@@ -965,9 +966,12 @@ int handle_packet_expire_direct(struct a
 	}
 
 	pthread_cleanup_pop(1);
-done:
 	pthread_cleanup_pop(1);
 	return status;
+
+done:
+	cache_lock_cleanup(mc);
+	return status;
 }
 
 static void *do_mount_direct(void *arg)
@@ -1256,8 +1260,11 @@ int handle_packet_missing_direct(struct 
 	}
 
 	pthread_cleanup_pop(1);
-done:
 	pthread_cleanup_pop(1);
 	return status;
+
+done:
+	cache_lock_cleanup(mc);
+	return status;
 }
