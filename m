From: Ian Kent <raven@themaw.net>
Subject: Re: Wrong network
Date: Mon, 14 Feb 2011 10:06:23 +0800
Message-ID: <1297649183.2822.6.camel@perseus>
References: <alpine.LRH.0.9999.1102120924290.6851@helios.vgersoft.com>
	<alpine.LRH.0.9999.1102121518420.12882@helios.vgersoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=mSJuUcJU8aukrlBMlJJxY9Jv3Gs=;
	b=UnAB992u7yFs0SwzlQBfKy9wQKwbhnRXq/ZNXnr6gZvVPTa1zbNB+PLU6ba43MjTcV4W1RP9qluYSgVBUFxRjbFQNYQwyxQIqtCcBUiigdIRyX6GOq/OXLiw2nsZCXUw8QgvK0SLHmzvWOHVrJrlx2QO8K7Xc2qe/Efi5zz3avs=
In-Reply-To: <alpine.LRH.0.9999.1102121518420.12882@helios.vgersoft.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Steve Thompson <smt@vgersoft.com>
Cc: autofs@linux.kernel.org

On Sat, 2011-02-12 at 15:21 -0500, Steve Thompson wrote:
> On Sat, 12 Feb 2011, Steve Thompson wrote:
> 
> > CentOS 5.5 (32- and 64-bit), autofs-5.0.1-0.rc2.143.el5_5.6.
> >
> > Two subnets, A (192.168.0/22) and B (192.168.4/22). NFS server has an 
> > interface on both A and B. NFS client has an interface on B only. Maps come 
> > via LDAP. On the client:
> >
> > 	# mount
> > 	<server>:/mnt/point on /fs/<blah> type nfs (rw,addr=192.168.0.69)
> >
> > The addr= looks wrong to me; should be 192.168.4.x. On other clients, the 
> > subnet pointed to by addr= is sometimes right, sometimes wrong. What's wrong 
> > here?
> 
> Let me expand a little on this. A DNS lookup of the NFS server name 
> returns two IP addresses, one in subnet A and one in subnet B. I was under 
> the impression that autofs would see that the address on subnet B is in 
> the same segment as the client, using PROXIMITY_SUBNET. It doesn't appear 
> to be working the way I would expect.

That is the way it should work but dns round robin entries like this
aren't handled quite correctly.

I'm not sure this patch will apply (the CHANGELOG hunk certainly won't)
but you could try it:

autofs-5.0.5 - mount using address for rr

From: Ian Kent <raven@themaw.net>

When a host has multiple addresses, mount using individual address so
we can take advantage of the probing and response time calculation that's
already been done.
---

 CHANGELOG            |    1 +
 include/replicated.h |    1 +
 modules/mount_nfs.c  |   31 +++++++++++++++++++++++++------
 modules/replicated.c |   11 ++++++++---
 4 files changed, 35 insertions(+), 9 deletions(-)


--- autofs-5.0.5.orig/CHANGELOG
+++ autofs-5.0.5/CHANGELOG
@@ -42,6 +42,7 @@
 - use weight only for server selection.
 - fix isspace() wild card substition.
 - include ip address in debug logging.
+- mount using address for DNS round robin host names.
 
 03/09/2009 autofs-5.0.5
 -----------------------
--- autofs-5.0.5.orig/include/replicated.h
+++ autofs-5.0.5/include/replicated.h
@@ -54,6 +54,7 @@ struct host {
 	char *name;
 	struct sockaddr *addr;
 	size_t addr_len;
+	unsigned int rr;
 	char *path;
 	unsigned int version;
 	unsigned int options;
--- autofs-5.0.5.orig/modules/mount_nfs.c
+++ autofs-5.0.5/modules/mount_nfs.c
@@ -229,13 +229,32 @@ int mount_mount(struct autofs_point *ap,
 
 		/* Not a local host - do an NFS mount */
 
-		loc = malloc(strlen(this->name) + 1 + strlen(this->path) + 1);
-		if (!loc) {
-			char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
-			error(ap->logopt, "malloc: %s", estr);
-			return 1;
+		if (this->rr && this->addr) {
+			socklen_t len = INET6_ADDRSTRLEN;
+			char buf[len + 1];
+			const char *n_addr;
+			n_addr = get_addr_string(this->addr, buf, len);
+			loc = malloc(strlen(n_addr) + strlen(this->path) + 4);
+			if (!loc) {
+				char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
+				error(ap->logopt, "malloc: %s", estr);
+				return 1;
+			}
+			if (this->addr->sa_family == AF_INET6) {
+				strcpy(loc, "[");
+				strcat(loc, n_addr);
+				strcat(loc, "]");
+			} else
+				strcpy(loc, n_addr);
+		} else {
+			loc = malloc(strlen(this->name) + strlen(this->path) + 2);
+			if (!loc) {
+				char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
+				error(ap->logopt, "malloc: %s", estr);
+				return 1;
+			}
+			strcpy(loc, this->name);
 		}
-		strcpy(loc, this->name);
 		strcat(loc, ":");
 		strcat(loc, this->path);
 
--- autofs-5.0.5.orig/modules/replicated.c
+++ autofs-5.0.5/modules/replicated.c
@@ -1059,7 +1059,8 @@ int prune_host_list(unsigned logopt, str
 
 static int add_new_host(struct host **list,
 			const char *host, unsigned int weight,
-			struct addrinfo *host_addr, unsigned int options)
+			struct addrinfo *host_addr,
+			unsigned int rr, unsigned int options)
 {
 	struct host *new;
 	unsigned int prx;
@@ -1094,6 +1095,7 @@ static int add_new_host(struct host **li
 		free_host(new);
 		return 0;
 	}
+	new->rr = rr;
 
 	return 1;
 }
@@ -1102,6 +1104,7 @@ static int add_host_addrs(struct host **
 			  unsigned int weight, unsigned int options)
 {
 	struct addrinfo hints, *ni, *this;
+	int rr = 0;
 	int ret;
 
 	memset(&hints, 0, sizeof(hints));
@@ -1115,7 +1118,7 @@ static int add_host_addrs(struct host **
 
 	this = ni;
 	while (this) {
-		ret = add_new_host(list, host, weight, this, options);
+		ret = add_new_host(list, host, weight, this, 0, options);
 		if (!ret)
 			break;
 		this = this->ai_next;
@@ -1137,8 +1140,10 @@ try_name:
 	}
 
 	this = ni;
+	if (this->ai_next)
+		rr++;
 	while (this) {
-		ret = add_new_host(list, host, weight, this, options);
+		ret = add_new_host(list, host, weight, this, rr, options);
 		if (!ret)
 			break;
 		this = this->ai_next;
