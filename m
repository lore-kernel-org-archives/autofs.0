From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Re: Intermittant problems mounting with automounter
Date: Wed, 15 Dec 2004 10:02:31 -0500
Message-ID: <16832.20999.767837.598049@segfault.boston.redhat.com>
References: <200411302007.iAUK7GjH020588@jetcar.spd.analog.com>
	<41BF81C5.5040205@sun.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <41BF81C5.5040205@sun.com>
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
Content-Type: text/plain; charset="us-ascii"
To: Mike Waychison <Michael.Waychison@sun.com>
Cc: autofs@linux.kernel.org, David Meleedy <david.meleedy@analog.com>

==> Regarding Re: [autofs] Re: Intermittant problems mounting with automounter; Mike Waychison <Michael.Waychison@sun.com> adds:

Michael.Waychison> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1

Michael.Waychison> David Meleedy wrote:
>> Well, in order to troubleshoot this issue further, autofs on Redhat
>> Enterprise 3, update 3
>> 
>> I removed all options from the /etc/auto.master file:
>> 
>> from:
>> 
>> /cpd /etc/auto.cpd hard,intr,rsize=8192,wsize=8192
>> 
>> to:
>> 
>> /cpd /etc/auto.cpd
>> 
>> 
>> After this change, the following errors seemed to go away:
>> 
>> ==== Nov 19 11:27:38 codered kernel: RPC: Can't bind to reserved port
>> (98).  Nov 19 11:27:38 codered kernel: nfs_get_root: getattr error = 5
>> Nov 19 11:27:38 codered kernel: RPC: Can't bind to reserved port (98).
>> Nov 19 11:27:38 codered kernel: nfs_get_root: getattr error = 5 Nov 19
>> 11:27:38 codered kernel: nfs_read_super: get root inode failed Nov 19
>> 11:27:38 codered kernel: nfs warning: mount version older than kernel
>> Nov 19 11:27:38 codered kernel: RPC: Can't bind to reserved port (98).
>> Nov 19 11:27:38 codered kernel: nfs_get_root: getattr error = 5 Nov 19
>> 11:27:38 codered kernel: nfs_read_super: get root inode failed Nov 19
>> 11:27:38 codered automount[3623]: >> mount: wrong fs type, bad option,
>> bad superblock on aflac:/vol/vol1/cpd/nwd_usr, Nov 19 11:27:38 codered
>> automount[3623]: >> or too many mounted file systems Nov 19 11:27:38
>> codered automount[3623]: mount(nfs): nfs: mount failure
>> aflac:/vol/vol1/cpd/nwd_usr on /cpd/usr Nov 19 11:27:38 codered
>> automount[3623]: failed to mount /cpd/usr =====
>> 
>> So whatever it is might be caused by the options?
>> 

Michael.Waychison> These messages are due to starvation for reserved ports
Michael.Waychison> (< 1024).  Specifically, the kernel will only use ports
Michael.Waychison> < 800.  Currently, the kernel uses one port per nfs
Michael.Waychison> filesystem.  If you mount filesystems very fast, then
Michael.Waychison> you can also run out of reserved ports as the local
Michael.Waychison> (mountd iirc?) will close tcp sessions and each must
Michael.Waychison> wait 2 minutes before being released.

Michael.Waychison> One solution is to try out the patch I posted last week
Michael.Waychison> that allows nfs mounts to share tcp/udp connections:

Michael.Waychison> http://marc.theaimsgroup.com/?l=linux-nfs&m=110261671705396&w=2

Michael.Waychison> (against 2.6.9, although should apply to other kernels
Michael.Waychison> w/o too much difficulty)

Also note that we had a socket descriptor leak that could cause this
problem.  I also added code to pass a socket into clntudp_bufcreate so that
we don't use up additional reserved ports.  The individual patches have
been posted to the list before, but I've included them below for
convenience.

-Jeff

--- autofs-4.1.3/lib/rpc_subs.c~	2004-09-14 10:32:30.000000000 -0400
+++ autofs-4.1.3/lib/rpc_subs.c	2004-09-14 10:36:29.766803120 -0400
@@ -48,7 +48,7 @@ struct conn_info {
  */
 static CLIENT* create_udp_client(struct conn_info *info)
 {
-	int fd = -1;
+	int fd = RPC_ANYSOCK;
 	CLIENT *client;
 	struct sockaddr_in addr;
 	struct hostent *hp;
@@ -169,6 +169,7 @@ static CLIENT* create_tcp_client(struct 
 	if (!client)
 		goto out_close;
 
+	clnt_control(client, CLSET_FD_CLOSE, NULL);
 	return client;
 
 out_close:

--- autofs-4.1.3/lib/rpc_subs.c.orig	2004-11-19 13:05:39.063691232 -0500
+++ autofs-4.1.3/lib/rpc_subs.c	2004-11-19 13:05:41.973248912 -0500
@@ -48,28 +48,50 @@ struct conn_info {
  */
 static CLIENT* create_udp_client(struct conn_info *info)
 {
-	int fd = RPC_ANYSOCK;
+	int fd;
 	CLIENT *client;
-	struct sockaddr_in addr;
+	struct sockaddr_in laddr, raddr;
 	struct hostent *hp;
 
 	if (info->proto->p_proto != IPPROTO_UDP)
 		return NULL;
 
-	memset(&addr, 0, sizeof(addr));
+	memset(&laddr, 0, sizeof(laddr));
+	memset(&raddr, 0, sizeof(raddr));
 
 	hp = gethostbyname(info->host);
 	if (!hp)
 		return NULL;
 
-	addr.sin_family = AF_INET;
-	addr.sin_port = htons(info->port);
-	memcpy(&addr.sin_addr.s_addr, hp->h_addr, hp->h_length);
+	raddr.sin_family = AF_INET;
+	raddr.sin_port = htons(info->port);
+	memcpy(&raddr.sin_addr.s_addr, hp->h_addr, hp->h_length);
+
+	/*
+	 * bind to any unused port.  If we left this up to the rpc
+	 * layer, it would bind to a reserved port, which has been shown
+	 * to exhaust the reserved port range in some situations.
+	 */
+	fd = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP);
+	if (fd < 0)
+		return NULL;
+	laddr.sin_family = AF_INET;
+	laddr.sin_port = 0;
+	laddr.sin_addr.s_addr = htonl(INADDR_ANY);
+
+	if (bind(fd, (struct sockaddr *)&laddr, 
+		 sizeof(struct sockaddr_in)) < 0) {
+		close(fd);
+		fd = RPC_ANYSOCK;
+		/* FALLTHROUGH */
+	}
 
-	client = clntudp_bufcreate(&addr,
+	client = clntudp_bufcreate(&raddr,
 				   info->program, info->version,
 				   info->timeout, &fd,
 				   info->send_sz, info->recv_sz);
+	if (client)
+		clnt_control(client, CLSET_FD_CLOSE, NULL);
 
 	return client;
 }
