From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [RFC] rpc_ping and looong timeouts
Date: Fri, 4 Jun 2004 17:41:02 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16576.60526.394177.533027@segfault.boston.redhat.com>
References: <16575.35426.918728.134817@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0406040909310.8991@wombat.indigo.net.au>
	<16576.51269.311121.121046@segfault.boston.redhat.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wZGJ2U7ySl"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16576.51269.311121.121046@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>, autofs@linux.kernel.org


--wZGJ2U7ySl
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit

==> Regarding Re: [autofs] [RFC] rpc_ping and looong timeouts; Jeff Moyer <jmoyer@redhat.com> adds:

==> Regarding Re: [autofs] [RFC] rpc_ping and looong timeouts; Ian Kent <raven@themaw.net> adds:
raven> On Thu, 3 Jun 2004, Jeff Moyer wrote:
>>> Hello, Ian, list,
>>> 
>>> You may recall my asking for the rpc_ping function to take TCP only
>>> servers into account.  Well, be careful what you ask for!  Now, if a
>>> server is down in a replicated server configuration, it takes quite a
>>> while to timeout due to the TCP connect.  The mount will eventually
>>> succeed, but I've seen this take up to 10 minutes.

raven> I'm not sure that I see that same behaviour in my test environment.

raven> I'll check and get back.  It's probably best if we understand this a
raven> little better before jumping in.

jmoyer> I've strace'd the automount process, and a lot of time is spent in
jmoyer> the clnt_create, for both UDP and the TCP.  I implemented a
jmoyer> non-blocking connect, and it took my ls time down from 8m21s to
jmoyer> 2m4s.  I'm still looking into why the UDP stuff isn't timing out
jmoyer> sooner.

The clnt_create call does not take a timeout.  One of the things it does is
to contact the remote portmapper to get the port for the specified program
number.  There is a hard-coded default timeout in that code of 60 seconds,
which explains my 2 minutes.

This patch simply implements an icmp ping (code shamelessly stolen from
clumanager), and does this before even attempting to do the rpc pings.  If
the icmp ping works, then we continue as usual.  This takes care of the
host down case quite nicely:

# time ls /multi/multi1
foo

real    0m0.208s
user    0m0.010s
sys     0m0.010s

Ian, I can also post the nonblocking connect patch, but I'm unsure of its
usefulness vs. complexity ratio.  I say we only cross that bridge if we
need to.

One nit: icmp_ping_host takes a char * for the hostname, whereas rpc_ping
passes a const char *.  As such, we get a 'discards qualifier' warning.  I
didn't think it warrented converting the whole call chain to consts, but if
you're especially concerned about that, Ian, I'd be happy to resubmit.


Comments?

-Jeff


--wZGJ2U7ySl
Content-Type: text/plain
Content-Disposition: inline;
	filename="autofs-4.1.3-icmp-ping.patch"
Content-Transfer-Encoding: 7bit

--- autofs-4.1.3/include/ping.h.orig	2004-06-04 17:35:44.000000000 -0400
+++ autofs-4.1.3/include/ping.h	2004-06-04 17:26:08.000000000 -0400
@@ -0,0 +1,60 @@
+/*
+  Copyright Red Hat, Inc. 2003
+
+  This program is free software; you can redistribute it and/or modify it
+  under the terms of the GNU General Public License as published by the
+  Free Software Foundation; either version 2, or (at your option) any
+  later version.
+
+  This program is distributed in the hope that it will be useful, but
+  WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+  General Public License for more details.
+
+  You should have received a copy of the GNU General Public License
+  along with this program; see the file COPYING.  If not, write to the
+  Free Software Foundation, Inc.,  675 Mass Ave, Cambridge,
+  MA 02139, USA.
+ */
+/** @file
+ * Header for ping.c.
+ */
+#ifndef _PING_H
+#define _PING_H
+
+#include <netinet/ip_icmp.h>
+#include <sys/socket.h>
+#include <netdb.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdint.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+#define PING_ERRNO		-1
+#define PING_SUCCESS		0
+#define PING_ALIVE		PING_SUCCESS
+#define PING_TIMEOUT		1
+#define PING_HOST_UNREACH	2
+#define PING_HOST_NOT_FOUND	3
+#define PING_INVALID_CHECKSUM	4
+#define PING_INVALID_RESPONSE	5
+#define PING_INVALID_SIZE	6
+#define PING_INVALID_ID		7
+
+int32_t icmp_socket(void);
+int32_t icmp_ping_hostfd(int32_t sock, char *hostname, uint32_t seq,
+			 long seconds, long micros);
+int32_t icmp_ping_host(char *hostname, uint32_t seq, long seconds,long micros);
+
+int32_t icmp_ping_addrfd(int32_t sock, struct sockaddr_in *sin_send, 
+			 uint32_t seq, long seconds, long micros);
+int32_t icmp_ping_addr(struct sockaddr_in *sin_send, uint32_t seq,
+		       long seconds, long micros);
+
+
+#define net_icmp_close(sock) close(sock)
+
+#endif /* _PING_H */
--- autofs-4.1.3/lib/rpc_subs.c.orig	2004-06-04 17:35:32.000000000 -0400
+++ autofs-4.1.3/lib/rpc_subs.c	2004-06-04 17:36:05.000000000 -0400
@@ -5,6 +5,7 @@
 #include <rpc/xdr.h>
  
 #include "automount.h"
+#include "ping.h"
 
 static int rpc_ping_proto(const char *host,
 			  unsigned long nfs_version, const char *proto,
@@ -71,6 +72,10 @@
 {
 	unsigned int status;
 
+	status = icmp_ping_host(host, 0, seconds, micros);
+	if (status)
+		return 0;
+
 	status = rpc_ping_v2(host, seconds, micros);
 	if (status)
 		return status;
@@ -114,4 +119,3 @@
 
 	return status;
 }
-
--- autofs-4.1.3/lib/ping.c.orig	2004-06-04 17:35:38.000000000 -0400
+++ autofs-4.1.3/lib/ping.c	2004-06-04 17:26:08.000000000 -0400
@@ -0,0 +1,384 @@
+/*
+  Copyright Red Hat, Inc. 2003
+
+  This program is free software; you can redistribute it and/or modify it
+  under the terms of the GNU General Public License as published by the
+  Free Software Foundation; either version 2, or (at your option) any
+  later version.
+
+  This program is distributed in the hope that it will be useful, but
+  WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+  General Public License for more details.
+
+  You should have received a copy of the GNU General Public License
+  along with this program; see the file COPYING.  If not, write to the
+  Free Software Foundation, Inc.,  675 Mass Ave, Cambridge,
+  MA 02139, USA.
+*/
+/** @file
+ * Ping functions for Red Hat Cluster Manager (RFC777)
+ *
+ * These functions provide internal ping functionality.  These functions are
+ * used to help determine quorum when a two or four node cluster has an
+ * even split.
+ */
+ 
+#include <ping.h>
+
+/**
+ * From RFC 777:
+ *
+ * [ICMP] Header Checksum
+ * The 16 bit one's complement of the one's complement sum of all 16
+ * bit words in the header.  For computing the checksum, the checksum
+ * field should be zero.  This checksum may be replaced in the
+ * future.
+ *
+ * @param buf		16-but word array
+ * @param buflen	Length (in 8-bit bytes!) of buf
+ * @return		ICMP header checksum of buf.
+ */
+uint16_t
+icmp_checksum(uint16_t *buf, uint32_t buflen)
+{
+	uint32_t remain = buflen, sum = 0;
+	char *data = (char *)buf;
+
+	while (remain > 1) {
+		sum += *((uint16_t *)data);
+		data += 2;
+		remain -= 2;
+	}
+
+	/*
+	 * Clean up the last byte (if there is one)
+	 */
+	if (remain)
+		sum += *data;
+
+	sum = (sum>>16)+(sum&0xffff);
+	sum += (sum>>16);
+	
+	return (uint16_t)((~sum)&0xffff);
+}
+
+
+/**
+ * Set up an ICMP socket (basically, a raw socket).  This requires root 
+ * privileges.
+ *
+ * @return See socket(2).
+ */
+int32_t
+icmp_socket(void)
+{
+	return socket(AF_INET, SOCK_RAW, IPPROTO_ICMP);
+}
+
+
+/**
+ * Call gethostbyname and return an appropriate PING return value based on
+ * the response we get.  Fill in sin_send.
+ *
+ * @param hostname	Hostname to look up.
+ * @param sin_send	IP address structure (pre-allocated).
+ * @return		PING_HOST_NOT_FOUND if the host is not found, 0
+ *			on success, -1 on other error.
+ * @see gethostbyname
+ */
+int32_t
+icmp_ping_getaddr(char *hostname, struct sockaddr_in *sin_send)
+{
+	struct hostent *hp;
+
+	/*
+	 * Grab the hostname
+	 */
+	while ((hp = gethostbyname(hostname)) == NULL) {
+		switch(h_errno) {
+		case TRY_AGAIN:
+			continue;
+		case HOST_NOT_FOUND:
+		case NO_ADDRESS:
+		case NO_RECOVERY:
+			return PING_HOST_NOT_FOUND;
+		}
+		return -1;
+	}
+
+	/*
+	 * Set up send address
+	 */
+	memset(sin_send, 0, sizeof(*sin_send));
+	sin_send->sin_family = AF_INET;
+	sin_send->sin_port = 0;
+	memcpy(&sin_send->sin_addr, hp->h_addr, sizeof(sin_send->sin_addr));
+
+	return 0;
+}
+
+
+/**
+ * Send a ping (ICMP_ECHO) to a given IP address and file descriptor.
+ * This is set up so that a daemon can drop privileges after binding to a raw
+ * socket (perhaps preserving a static ping socket), but still be able to use
+ * ping.  This is a pretty long function.
+ *
+ * @param sock		Socket to send on.
+ * @param sin_send	Address to send to.
+ * @param seq		Sequence number.
+ * @param timeout	Timeout (in seconds)
+ * @return		-1 on syscall error, 0 on success.
+ *			See ping.h for list of return values >0.
+ * @see	icmp_ping_host icmp_ping_hostfd icmp_ping_addr
+ */
+int32_t
+icmp_ping_addrfd(int32_t sock, struct sockaddr_in *sin_send, uint32_t seq,
+		 long seconds, long micros)
+{
+	char buffer[256]; /* XXX */
+	struct icmp *packetp;
+	struct ip *ipp;
+	struct sockaddr_in sin_recv;
+	struct timeval tv;
+	fd_set rfds;
+	uint16_t checksum;
+	uint32_t x, sin_recv_len = sizeof(sin_recv);
+	int timeout = (seconds || micros);
+
+	/*
+	 * Set up ICMP echo packet
+	 */
+	packetp = (struct icmp *)buffer;
+
+	memset(packetp, 0, ICMP_MINLEN);
+	packetp->icmp_type = ICMP_ECHO;
+	packetp->icmp_seq = seq;
+	packetp->icmp_id = getpid();
+	packetp->icmp_cksum = icmp_checksum((uint16_t *)packetp,
+						ICMP_MINLEN);
+
+	/*
+	 * Send the packet
+	 */
+	while ((x = sendto(sock, packetp, ICMP_MINLEN, 0,
+	    		   (struct sockaddr *)sin_send,
+			   sizeof(*sin_send))) < ICMP_MINLEN)
+		if (x < 0)
+			return -1;
+
+	if (timeout) {
+		tv.tv_sec = seconds;
+		tv.tv_usec = micros;
+	}
+
+	/*
+	 * Wait for response
+	 */
+	while (1) {
+		
+		/*
+		 * Set up select call...
+		 */
+		FD_ZERO(&rfds);
+		FD_SET(sock,&rfds);
+		while ((x = select(sock+1, &rfds, NULL, NULL,
+		   		   timeout ? &tv : NULL)) <= 0) {
+			if (!x)
+				return PING_TIMEOUT;
+			return -1;
+		}
+		
+		/*
+		 * Receive response
+		 */
+		if ((x = recvfrom(sock, buffer, sizeof(buffer), 0,
+				  (struct sockaddr *)&sin_recv,
+				  &sin_recv_len)) < 0) {
+			return -1;
+		}
+
+		/*
+		 * Ensure it's the proper size...
+		 * - (ipp->ip_hl << 2) is because IP header length is in
+		 * 32-bit words instead of bytes.
+		 * - ICMP_MINLEN is defined in netinet/ip_icmp.h.
+		 */
+		ipp = (struct ip *)buffer;
+		if (x < ((ipp->ip_hl << 2) + ICMP_MINLEN)) {
+			if (timeout)
+				continue;
+			return PING_INVALID_SIZE;
+		}
+		
+		/*
+		 * Validate the checksum.  The checksum needs to be set to
+		 * 0 for validation purposes.
+		 */
+		packetp = (struct icmp *)((buffer + (ipp->ip_hl << 2)));
+		checksum = packetp->icmp_cksum;
+		packetp->icmp_cksum = 0;
+		if (checksum != icmp_checksum((uint16_t*)packetp,
+					      ICMP_MINLEN)) {
+			if (timeout)
+				continue;
+			return PING_INVALID_CHECKSUM;
+		}
+
+		/*
+		 * Ensure it's the proper id...
+		 */
+		switch (packetp->icmp_type) {
+		case ICMP_ECHOREPLY:
+			if (packetp->icmp_id != getpid()) {
+				if (timeout)
+					continue;
+				return PING_INVALID_ID;
+			}
+			return PING_SUCCESS;
+		case ICMP_DEST_UNREACH:
+			return PING_HOST_UNREACH;
+		}
+
+		/* XXX */
+		return PING_INVALID_RESPONSE;
+	}
+}
+
+
+/**
+ * Send a ping (ICMP_ECHO) to a given IP address.  This is set up so that a
+ * daemon can drop privileges after binding to a raw socket (perhaps
+ * preserving a static ping socket), but still be able to use ping calls.
+ *
+ * @param sock		Socket to send on
+ * @param hostname	Host name to ping
+ * @param seq		Sequence number.
+ * @param timeout	Timeout (in seconds)
+ * @return		-1 on syscall error, 0 on success.
+ *			See ping.h for list of return values >0.
+ * @see	icmp_ping_getaddr icmp_ping_addrfd icmp_ping 
+ */
+int32_t
+icmp_ping_hostfd(int32_t sock, char *hostname, uint32_t seq, 
+		 long seconds, long micros)
+{
+	struct sockaddr_in sin_send;
+	int rv;
+
+	rv = icmp_ping_getaddr(hostname, &sin_send);
+	if (rv)
+		return rv;
+
+	return icmp_ping_addrfd(sock, &sin_send, seq, seconds, micros);
+}
+
+
+/**
+ * Send a ping (ICMP_ECHO) to a given IP address. 
+ *
+ * @param sin_send	Address we want to send to.
+ * @param seq		Sequence number (user defined)
+ * @param timeout	Timeout (in seconds)
+ * @return		-1 on syscall error, 0 on success.
+ *			See ping.h for list of return values >0.
+ * @see	icmp_ping_addrfd icmp_socket icmp_ping_host icmp_ping_hostfd
+ */
+int32_t
+icmp_ping_addr(struct sockaddr_in *sin_send, uint32_t seq, 
+	       long seconds, long micros)
+{
+	int sock, rv, esv;
+
+	sock = icmp_socket();
+	if (sock < 0)
+		return -1;
+
+	rv = icmp_ping_addrfd(sock, sin_send, seq, seconds, micros);
+
+	esv = errno;
+	close(sock);
+	errno = esv;
+
+	return rv;
+}
+
+
+/**
+ * Send a ping (ICMP_ECHO) to a given hostname.
+ *
+ * @param hostname	Target host
+ * @param seq		Sequence number (user defined)
+ * @param timeout	Timeout (in seconds)
+ * @return		-1 on syscall error, 0 on success.
+ *			See ping.h for list of return values >0.
+ * @see	icmp_socket icmp_ping_hostfd icmp_ping_addr icmp_ping_addrfd
+ */
+int32_t
+icmp_ping_host(char *hostname, uint32_t seq, long seconds, long micros)
+{
+	uint32_t rv, sock, esv;
+
+	sock = icmp_socket();
+	if (sock == -1)
+		return -1;
+
+	rv = icmp_ping_hostfd(sock, hostname, seq, seconds, micros);
+
+	esv = errno;
+	close(sock);
+	errno = esv;
+
+	return rv;
+}
+
+
+#ifdef STANDALONE
+int
+main(int argc, char **argv)
+{
+	int timeout = 0, rv;
+
+	if (argc < 2) {
+		printf("usage: %s <host> [timeout]\n", argv[0]);
+		return 2;
+	}
+
+	if (argc == 3)
+		timeout = atoi(argv[2]);
+
+	rv = icmp_ping_host(argv[1], 1, timeout);
+
+	switch(rv) {
+	case PING_ERRNO:
+		perror("icmp_ping_host");
+		break;
+	case PING_SUCCESS:
+		printf("%s is alive\n", argv[1]);
+		break;
+	case PING_TIMEOUT:
+		printf("%s timed out\n", argv[1]);
+		break;
+	case PING_HOST_UNREACH:
+		printf("%s is unreachable\n", argv[1]);
+		break;
+	case PING_HOST_NOT_FOUND:
+		printf("Host %s not found!\n", argv[1]);
+		break;
+	case PING_INVALID_CHECKSUM:
+		printf("Invalid checksum in reply.\n");
+		break;
+	case PING_INVALID_SIZE:
+		printf("Invalid size of reply packet.\n");
+		break;
+	case PING_INVALID_RESPONSE:
+		printf("Invalid response.\n");
+		break;
+	case PING_INVALID_ID:
+		printf("Invalid ID in response.\n");
+		break;
+	}
+	return rv;
+}
+#endif

--wZGJ2U7ySl
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--wZGJ2U7ySl--

