From: Ian Kent <raven@themaw.net>
Subject: Re: latest autofs from centos 4
Date: Wed, 17 Sep 2008 11:25:37 +0800
Message-ID: <1221621937.3001.3.camel@raven.themaw.net>
References: <alpine.LRH.2.00.0809161716010.13560@q7.q7.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <alpine.LRH.2.00.0809161716010.13560@q7.q7.com>
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
To: Joe Pruett <joey@clean.q7.com>
Cc: autofs@linux.kernel.org

On Tue, 2008-09-16 at 17:22 -0700, Joe Pruett wrote:
> it looks like some recent changes to both autofs v4 and v5 has caused the 
> siogcifconf buffer to be only 128 bytes.  this means that on our servers, 
> it can't correctly match a local address since that is only enough room 
> for 3 addresses and we're in the middle of a renumbering so we have 5-10 
> addresses per machine.  this was working fine until i just updated to 
> centos 4.7.  from looking at the code, it looks like someone created a 
> MAX_IF_BUF #define at 2048, but didn't use it for the ioctl call.  is that 
> a mistake?
> 
> i'll try a patched rpm locally and make sure this is the source of my 
> woes.

Yeah, known issue.
It's resolved in RHEL-5.3.

Not sure if this will apply to your package source but give it a try.

---
autofs-5.0.3 - fix interface config buffer size

From: Ian Kent <raven@themaw.net>

When getting the interface configuration information autofs uses a
fixed size buffer for the interface information. If there are many
interfaces this causes the check to fail.
---

 modules/replicated.c |   51 ++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 43 insertions(+), 8 deletions(-)


diff --git a/modules/replicated.c b/modules/replicated.c
index 362ab1b..ad1ede2 100644
--- a/modules/replicated.c
+++ b/modules/replicated.c
@@ -95,6 +95,41 @@ void seed_random(void)
 	return;
 }
 
+static int alloc_ifreq(struct ifconf *ifc, int sock)
+{
+	int ret, lastlen = 0, len = MAX_IFC_BUF;
+	char err_buf[MAX_ERR_BUF], *buf;
+
+	while (1) {
+		buf = malloc(len);
+		if (!buf) {
+			char *estr = strerror_r(errno, err_buf, MAX_ERR_BUF);
+			logerr("malloc: %s", estr);
+			return 0;
+		}
+
+		ifc->ifc_len = len;
+		ifc->ifc_req = (struct ifreq *) buf;
+
+		ret = ioctl(sock, SIOCGIFCONF, ifc);
+		if (ret == -1) {
+			char *estr = strerror_r(errno, err_buf, MAX_ERR_BUF);
+			logerr("ioctl: %s", estr);
+			free(buf);
+			return 0;
+		}
+
+		if (ifc->ifc_len == lastlen)
+			break;
+
+		lastlen = ifc->ifc_len;
+		len += MAX_IFC_BUF;
+		free(buf);
+	}
+
+	return 1;
+}
+
 static unsigned int get_proximity(const char *host_addr, int addr_len)
 {
 	struct sockaddr_in *msk_addr, *if_addr;
@@ -122,12 +157,7 @@ static unsigned int get_proximity(const char *host_addr, int addr_len)
 		fcntl(sock, F_SETFD, cl_flags);
 	}
 
-	ifc.ifc_len = sizeof(buf);
-	ifc.ifc_req = (struct ifreq *) buf;
-	ret = ioctl(sock, SIOCGIFCONF, &ifc);
-	if (ret == -1) {
-		char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
-		logerr("ioctl: %s", estr);
+	if (!alloc_ifreq(&ifc, sock)) {
 		close(sock);
 		return PROXIMITY_ERROR;
 	}
@@ -138,7 +168,7 @@ static unsigned int get_proximity(const char *host_addr, int addr_len)
 	i = 0;
 	ptr = (char *) &ifc.ifc_buf[0];
 
-	while (ptr < buf + ifc.ifc_len) {
+	while (ptr < (char *) ifc.ifc_req + ifc.ifc_len) {
 		ifr = (struct ifreq *) ptr;
 
 		switch (ifr->ifr_addr.sa_family) {
@@ -147,6 +177,7 @@ static unsigned int get_proximity(const char *host_addr, int addr_len)
 			ret = memcmp(&if_addr->sin_addr, hst_addr, addr_len);
 			if (!ret) {
 				close(sock);
+				free(ifc.ifc_req);
 				return PROXIMITY_LOCAL;
 			}
 			break;
@@ -162,7 +193,7 @@ static unsigned int get_proximity(const char *host_addr, int addr_len)
 	i = 0;
 	ptr = (char *) &ifc.ifc_buf[0];
 
-	while (ptr < buf + ifc.ifc_len) {
+	while (ptr < (char *) ifc.ifc_req + ifc.ifc_len) {
 		ifr = (struct ifreq *) ptr;
 
 		switch (ifr->ifr_addr.sa_family) {
@@ -178,6 +209,7 @@ static unsigned int get_proximity(const char *host_addr, int addr_len)
 				char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
 				logerr("ioctl: %s", estr);
 				close(sock);
+				free(ifc.ifc_req);
 				return PROXIMITY_ERROR;
 			}
 
@@ -186,6 +218,7 @@ static unsigned int get_proximity(const char *host_addr, int addr_len)
 
 			if ((ia & mask) == (ha & mask)) {
 				close(sock);
+				free(ifc.ifc_req);
 				return PROXIMITY_SUBNET;
 			}
 
@@ -208,6 +241,7 @@ static unsigned int get_proximity(const char *host_addr, int addr_len)
 
 			if ((ia & mask) == (ha & mask)) {
 				close(sock);
+				free(ifc.ifc_req);
 				return PROXIMITY_NET;
 			}
 			break;
@@ -221,6 +255,7 @@ static unsigned int get_proximity(const char *host_addr, int addr_len)
 	}
 
 	close(sock);
+	free(ifc.ifc_req);
 
 	return PROXIMITY_OTHER;
 }
