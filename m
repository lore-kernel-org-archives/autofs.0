From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] prevent autofs to try the wrong IP protocol
Date: Mon, 18 Jan 2016 10:36:58 +0800
Message-ID: <1453084618.3005.14.camel@themaw.net>
References: <1453065279.8867.21.camel@domdv.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=grRCRjQfASN/zzJA0SuVU4wxRcU=; b=vRSrPQ
	QIA9/7oWiauUUj4gVkjtwKCnMRKfSuRLN8ajoTH59vDrSatasV1u7lxKO0cAzHex
	P8Irzmyrx0GOtrvnqTjfrUspeKZAWkdQ0H2zewpev4QunhsXAYtw6Tmqiel5FBXy
	+rVlieXot6wYF1cDSxKfFnMsNV/C4649tDQKI=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=grRCRjQfASN/zzJ
	A0SuVU4wxRcU=; b=V+Jf1lJIDnU94yNZ3THwjBn26A29G+L5Wrym5cO7TaceVi1
	ziX0dE2LIEZwoS+WvfHl6yKXDhku/nZITZ631OfjajeLITz+yqb11lp9SSomWKp/
	T+FS7flkQD2LY4mZCYmCRhrXuUchA2ZYEUEEsOiN0Bdfc94mu/7eR/uGnICo=
In-Reply-To: <1453065279.8867.21.camel@domdv.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andreas Steinmetz <ast@domdv.de>, autofs@vger.kernel.org

On Sun, 2016-01-17 at 22:14 +0100, Andreas Steinmetz wrote:
> [please CC me on replies, I'm not subscribed]
> 
> If the user configures an IPv6 protocol for nfs, autofs tries IPv4
> too,
> and vice versa. The attached patch against autofs-5.1.1 prevents
> this.
> 
> The additional tries for the wrong IP protocol can be quite costly if
> e.g. an IPSec tunnel must be brought up.

Is this close to what your asking for (not even compile tested)?

I'm not certain this won't have any undesired side effects AFAICS it
looks ok.

autofs-5.1.1 - fix ipv6 proto option handling

From: Ian Kent <raven@themaw.net>

If the option proto=(tcp6|udp6) is given on the NFS mount command line
autofs does not properly recognise it needs to probe only the given
protocol for matching address type.

Signed-off-by: Ian Kent <raven@themaw.net>
Reported-by: Andreas Steinmetz <ast@domdv.de>
---
 include/replicated.h |    2 ++
 modules/mount_nfs.c  |   15 ++++++++++++++-
 modules/replicated.c |   29 +++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/include/replicated.h b/include/replicated.h
index 728f131..76f25cc 100644
--- a/include/replicated.h
+++ b/include/replicated.h
@@ -37,6 +37,8 @@
 #define UDP_SUPPORTED		0x0002
 #define TCP_REQUESTED		TCP_SUPPORTED
 #define UDP_REQUESTED		UDP_SUPPORTED
+#define TCP6_REQUESTED		0x0100
+#define UDP6_REQUESTED		0x0200
 #define NFS_PROTO_MASK		(TCP_SUPPORTED|UDP_SUPPORTED)
 
 #define NFS2_TCP_SUPPORTED	NFS2_SUPPORTED
diff --git a/modules/mount_nfs.c b/modules/mount_nfs.c
index aa786f3..db4f7cb 100644
--- a/modules/mount_nfs.c
+++ b/modules/mount_nfs.c
@@ -172,9 +172,17 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 				} else if (_strncmp("proto=udp", cp, o_len) == 0 ||
 					   _strncmp("udp", cp, o_len) == 0) {
 					vers &= ~TCP_SUPPORTED;
+				} else if (_strncmp("proto=udp6", cp, o_len) == 0 ||
+					   _strncmp("udp6", cp, o_len) == 0) {
+					vers &= ~TCP_SUPPORTED;
+					vers |= UDP6_REQUESTED;
 				} else if (_strncmp("proto=tcp", cp, o_len) == 0 ||
 					   _strncmp("tcp", cp, o_len) == 0) {
 					vers &= ~UDP_SUPPORTED;
+				} else if (_strncmp("proto=tcp6", cp, o_len) == 0 ||
+					   _strncmp("tcp6", cp, o_len) == 0) {
+					vers &= ~UDP_SUPPORTED;
+					vers |= TCP6_REQUESTED;
 				}
 				/* Check for options that also make sense
 				   with bind mounts */
@@ -212,11 +220,16 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 	 * configuration only probe NFSv4 and let mount.nfs(8) do fallback
 	 * to NFSv3 (if it can). If the NFSv4 probe fails then probe as
 	 * normal.
+	 *
+	 * Note: some NFS servers consider it a protocol violation to use
+	 * NFSv4 over UDP so if it has been requested in the mount options
+	 * we can't use this at all.
 	 */
 	if ((hosts && !hosts->next) &&
 	    mount_default_proto == 4 &&
 	    (vers & NFS_VERS_MASK) != 0 &&
-	    (vers & NFS4_VERS_MASK) != 0) {
+	    (vers & NFS4_VERS_MASK) != 0 &&
+	    !(vers & UDP6_REQUESTED)) {
 		unsigned int v4_probe_ok = 0;
 		struct host *tmp = new_host(hosts->name,
 					    hosts->addr, hosts->addr_len,
diff --git a/modules/replicated.c b/modules/replicated.c
index aa95cf7..27c73a7 100644
--- a/modules/replicated.c
+++ b/modules/replicated.c
@@ -458,6 +458,29 @@ done_ver:
 	return supported;
 }
 
+static int check_address_proto(unsigned logopt,
+			       struct host *host, unsigned int version)
+{
+	int ipv6_requested = version & (TCP6_REQUESTED | UDP6_REQUESTED);
+	int ret = 1;
+
+	/* If a protocol has been explicitly requested then don't
+	 * consider addresses that don't match the requested protocol.
+	 */
+	if (version & ipv6_requested) {
+		if (host->addr_len == INET_ADDRSTRLEN)
+			ret = 0;
+	} else {
+		if (host->addr_len == INET6_ADDRSTRLEN)
+			ret = 0;
+	}
+
+	if (!ret)
+		debug(logopt, "requested protocol does not match address");
+
+	return ret;
+}
+
 static int get_vers_and_cost(unsigned logopt, struct host *host,
 			     unsigned int version, int port)
 {
@@ -466,6 +489,9 @@ static int get_vers_and_cost(unsigned logopt, struct host *host,
 	unsigned int supported, vers = (NFS_VERS_MASK | NFS4_VERS_MASK);
 	int ret = 0;
 
+	if (check_address_proto(logopt, host, version))
+		return 0;
+
 	memset(&pm_info, 0, sizeof(struct conn_info));
 	memset(&rpc_info, 0, sizeof(struct conn_info));
 
@@ -535,6 +561,9 @@ static int get_supported_ver_and_cost(unsigned logopt, struct host *host,
 		debug(logopt, "called with host %s version 0x%x",
 			host->name, version);
 
+	if (check_address_proto(logopt, host, version))
+		return 0;
+
 	memset(&pm_info, 0, sizeof(struct conn_info));
 	memset(&rpc_info, 0, sizeof(struct conn_info));
  
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
