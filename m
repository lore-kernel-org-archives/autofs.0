From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: BUG: autofs4 + cd /net/<Netapp>/vol/vol[0-3] = port usage
	problems
Date: Wed, 12 Jan 2005 11:55:36 -0500
Message-ID: <41E55688.9070107@sun.com>
References: <200501112122.j0BLMmET002446@jetcar.spd.analog.com>
	<Pine.LNX.4.58.0501121334440.1641@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_WmzMgoWsroTYBCGr/U9JFg)"
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <Pine.LNX.4.58.0501121334440.1641@wombat.indigo.net.au>
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
To: David Meleedy <david.meleedy@analog.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

This is a multi-part message in MIME format.

--Boundary_(ID_WmzMgoWsroTYBCGr/U9JFg)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ian Kent wrote:
> Just a quick note before we get deep into this.
> 
> Can you check something for me.
> Get the source rpm for util-linux.
> Check if there is a patch applied to it to probe for services during 
> mount (it was a patch in FC). If it is rebuild the rpm without it and test 
> again.
> 
> On Tue, 11 Jan 2005, David Meleedy wrote:
> 
> 
>>Hi Ian & Jeff,
>>	I am trying to track down an autofs issue that has been
>>plaguing us.  It seems to be caused by the interaction of autofs version
>>4 with a Network Appliance server, and cd'ing to /net directories
>>on the Netapp server.
>>
>>A similar issue was seen in Analog Devices in Redhat 8, and apparently
>>the problem was worked around by Dwight Marzolf working with Ian Kent's
>>help.  So following what Dwight did I have been trying to recreate the fix
>>for Redhat Enterprise 3 update 3, and so far have not met with success.
>>
>>THE PROBLEM DESCRIPTION:
>>
>>Autofs hangs and refuses to mount any directories for a period of time
>>after cd'ing to /net/<Netapp>/vol/vol[0-3] and waiting a while.
>>The only way to clear this is to reboot the client.
>>
>>Initially we started using the following software (Redhat Enterprise 3 update 
>>3)
>>autofs 4.1.3-12
>>kernel 2.4.21-20
>>nfs-utils 1.0.6-31EL
>>
>>WHAT HAS BEEN TRIED SO FAR:
>>
>>Mike Waychison, after seeing the messages from our log file said,
>>
>>"These messages are due to starvation for reserved ports (< 1024).
>>Specifically, the kernel will only use ports < 800.  Currently, the
>>kernel uses one port per nfs filesystem.  If you mount filesystems very
>>fast, then you can also run out of reserved ports as the local (mountd
>>iirc?) will close tcp sessions and each must wait 2 minutes before being
>>released.
>>
>>One solution is to try out the patch I posted last week that allows nfs
>>mounts to share tcp/udp connections:
>>
>>http://marc.theaimsgroup.com/?l=linux-nfs&m=110261671705396&w=2
>>"
>>
>>The problem is we are using a different version of the kernel 2.4,
>>and his patch was for the 2.6 kernel.  Also, although his patch
>>might make the number of ports available increase, I think it does
>>not really solve the problem, it just gives more breathing room.

Well, it will pretty much guarantee only one port is used for any given
filer for talking to the nfs program.  Other ports are still used
temporarily to talk to mountd and the portmapper.

I've attached patch that applies cleanly to 2.4.21-20.EL, though I
haven't had the chance to test it other than by compiling it.

>>
>>After talking with Jeff Moyer about the issue, I updated autofs to 
>>autofs-4.1.3-67.  This was supposed to incorporate a patch that fixes
>>the port leak problem.
>>
>>This did not solve the problem, but it did seem to improve things a bit.
>>
>>After looking at Dwight Marzolf's document on his workaround I found
>>the following information (this is exactly the same sort of thing we
>>are seeing too):
>>
>>"
>>we quickly found that if you did a cd via /net to one of our Network
>>Appliance filers (all our other netapp filers worked correctly when
>>unmounting /net mounts), the port release issue still existed.  In
>>fact, the mountpoints actively took more ports.  This meant that if you
>>mounted this filer with /net, your workstation could be rendered
>>useless in less than 24 hours.  It also became evident that this active
>>taking of ports by this filer was not limited to just autofs-4.1.3-28
>>but also earlier versions of autofs  ...  Further
>>research revealed the ports were being taken at the point of automount
>>timeout.  When the automounter had declared these mountpoints to be
>>timed out and ready to be unmounted and attempted to umount them, in
>>fact, it ended up remounting them, using new ports for the remount ...
>>"
>>

Out of curiosity, can we see the output of showmount -e against your filer?

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB5VaHdQs4kOxk3/MRAvvhAJ4uOaMXMTE4rjZ6ivLrbyeowcZkuACfdshX
yBzl0PSwvsMaQZgKelhmrd4=
=vjuL
-----END PGP SIGNATURE-----

--Boundary_(ID_WmzMgoWsroTYBCGr/U9JFg)
Content-type: text/x-patch; name=xprt_sharing-2.4.21-20.EL.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=xprt_sharing-2.4.21-20.EL.patch

This patch allows for sharing of xprts.  This is done by keeping a list of
current xprts and passing them back to the caller of xprt_create_proto if they
match the specifications required (IP X port X protocol X timeout).

We do this multiplexing at the xprt layer as it handles transport creation and
destruction.

This patch has been tested in a test-only environment but has been able to
handle a couple hundreds distinct nfs mounts from the same server over a single
tcp stream.

This effectively gets rid of the 800 nfs mounts max problem, as long as you
aren't mounting from many (800) nfs servers.

Signed-off-by: Mike Waychison <michael.waychison@sun.com>

Index: linux-2.4.20/include/linux/sunrpc/xprt.h
===================================================================
--- linux-2.4.20.orig/include/linux/sunrpc/xprt.h	2004-06-24 22:00:25.000000000 -0700
+++ linux-2.4.20/include/linux/sunrpc/xprt.h	2005-01-12 08:23:33.000000000 -0800
@@ -15,6 +15,8 @@
 #include <linux/sunrpc/sched.h>
 #include <linux/sunrpc/xdr.h>
 
+#include <asm/atomic.h>
+
 /*
  * The transport code maintains an estimate on the maximum number of out-
  * standing RPC requests, using a smoothed version of the congestion
@@ -161,6 +163,9 @@ struct rpc_xprt {
 	void			(*old_write_space)(struct sock *);
 
 	wait_queue_head_t	cong_wait;
+
+	atomic_t		count;		/* shared xprt refcount */
+	struct list_head	shared;		/* link to shared list */
 };
 
 #ifdef __KERNEL__
Index: linux-2.4.20/net/sunrpc/xprt.c
===================================================================
--- linux-2.4.20.orig/net/sunrpc/xprt.c	2004-06-21 16:19:58.000000000 -0700
+++ linux-2.4.20/net/sunrpc/xprt.c	2005-01-12 08:20:29.000000000 -0800
@@ -79,6 +79,12 @@
 #define XPRT_MAX_BACKOFF	(8)
 
 /*
+ * List of shared xprt
+ */
+static DECLARE_MUTEX(shared_xprt_sem);
+static LIST_HEAD(shared_xprt_list);
+
+/*
  * Local functions
  */
 static void	xprt_request_init(struct rpc_task *, struct rpc_xprt *);
@@ -1292,6 +1298,33 @@ xprt_release(struct rpc_task *task)
 }
 
 /*
+ * Compare two rpc_timeout to see if they are the same.
+ */
+static int
+xprt_is_same_timeout(struct rpc_timeout *left, struct rpc_timeout *right)
+{
+	/* to_increment isn't used if to_exponential is true */
+	return left->to_initval     == right->to_initval
+            && left->to_maxval      == right->to_maxval
+            && left->to_retries     == right->to_retries
+            && left->to_exponential == right->to_exponential
+            && (left->to_exponential
+                || (left->to_increment  == right->to_increment));
+}
+
+/*
+ * Check to see if the timeout is the default timeout.
+ */
+static int
+xprt_is_default_timeout(struct rpc_timeout *to, int proto)
+{
+	struct rpc_timeout defaultto;
+
+	xprt_default_timeout(&defaultto, proto);
+	return xprt_is_same_timeout(&defaultto, to);
+}
+
+/*
  * Set default timeout parameters
  */
 void
@@ -1349,6 +1382,8 @@ xprt_setup(struct socket *sock, int prot
 	init_waitqueue_head(&xprt->cong_wait);
 
 	INIT_LIST_HEAD(&xprt->recv);
+	INIT_LIST_HEAD(&xprt->shared);
+	atomic_set(&xprt->count, 1);
 
 	/* Set timeout parameters */
 	if (to) {
@@ -1490,8 +1525,8 @@ failed:
 /*
  * Create an RPC client transport given the protocol and peer address.
  */
-struct rpc_xprt *
-xprt_create_proto(int proto, struct sockaddr_in *sap, struct rpc_timeout *to)
+static struct rpc_xprt *
+__xprt_create_proto(int proto, struct sockaddr_in *sap, struct rpc_timeout *to)
 {
 	struct socket	*sock;
 	struct rpc_xprt	*xprt;
@@ -1508,6 +1543,43 @@ xprt_create_proto(int proto, struct sock
 }
 
 /*
+ * Create an RPC client transport that is shared given the protocol and peer
+ * address.
+ */
+struct rpc_xprt *
+xprt_create_proto(int proto, struct sockaddr_in *sap, struct rpc_timeout *to)
+{
+	struct rpc_xprt *xprt;
+
+	down(&shared_xprt_sem);
+	/* walk the list and find an existing mathing xprt */
+	list_for_each_entry(xprt, &shared_xprt_list, shared) {
+		/* Filter out mismatches */
+		if (sap->sin_addr.s_addr != xprt->addr.sin_addr.s_addr)
+			continue;
+		if (sap->sin_port != xprt->addr.sin_port)
+			continue;
+		if (xprt->prot != proto)
+			continue;
+		if (to == NULL && !xprt_is_default_timeout(&xprt->timeout, proto))
+			continue;
+		if (to && !xprt_is_same_timeout(&xprt->timeout, to))
+			continue;
+
+		atomic_inc(&xprt->count);
+		goto out;
+	}
+
+	/* make a new one */
+	xprt = __xprt_create_proto(proto, sap, to);
+	if (!IS_ERR(xprt))
+		list_add(&xprt->shared, &shared_xprt_list);
+out:
+	up(&shared_xprt_sem);
+	return xprt;
+}
+
+/*
  * Prepare for transport shutdown.
  */
 void
@@ -1536,8 +1608,8 @@ xprt_clear_backlog(struct rpc_xprt *xprt
 /*
  * Destroy an RPC transport, killing off all requests.
  */
-int
-xprt_destroy(struct rpc_xprt *xprt)
+static int
+__xprt_destroy(struct rpc_xprt *xprt)
 {
 	dprintk("RPC:      destroying transport %p\n", xprt);
 	xprt_shutdown(xprt);
@@ -1546,3 +1618,20 @@ xprt_destroy(struct rpc_xprt *xprt)
 
 	return 0;
 }
+
+/*
+ * Destroy a shared RPC transport.
+ * (XXX: what about the remaining live requests?)
+ */
+int
+xprt_destroy(struct rpc_xprt *xprt)
+{
+	int ret = 0;
+	down(&shared_xprt_sem);
+	if (atomic_dec_and_test(&xprt->count)) {
+		list_del_init(&xprt->shared);
+		ret = __xprt_destroy(xprt);
+	}
+	up(&shared_xprt_sem);
+	return ret;
+}

--Boundary_(ID_WmzMgoWsroTYBCGr/U9JFg)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--Boundary_(ID_WmzMgoWsroTYBCGr/U9JFg)--

