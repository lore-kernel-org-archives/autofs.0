From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] Fix non-IPv6 host name lookups (5.0.6)
Date: Thu, 30 Jun 2011 15:18:56 +0800
Message-ID: <1309418336.3183.6.camel@perseus.themaw.net>
References: <20110629143911.GA11914@libre.l.ngdn.org>
	<1309415879.3183.3.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=RXWXkzAca+16R+dFpUYPA4HBD08=;
	b=hNmYOulm2kVEVWmitI6kFqLzaBMO68thspmvHs2AoFcU3CA9A4cOEuw22zYJuHdjPzIvi2uzN65NW1zqnZl8ctgPSyI56DCoFcJUVK1qBeq9d55khSHnURxzeP8R445L4Fk/uamO5z7BIit7V9rganNi6HnGrHS6AF7ac0ghgJ8=
In-Reply-To: <1309415879.3183.3.camel@perseus.themaw.net>
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
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs@linux.kernel.org

On Thu, 2011-06-30 at 14:37 +0800, Ian Kent wrote:
> On Wed, 2011-06-29 at 11:39 -0300, Leonardo Chiquitto wrote:
> > Fix non-IPv6 host name lookups
> > 
> > Commit 5b083026 ("fix ipv6 name for lookup") causes a regression
> > in regular (non-IPv6) host name lookups: it trims the first host
> > name character even when it's not a "[". This patch fixes the issue.
> 
> Gaah .... yep.
> 
> > 
> > ---
> >  modules/replicated.c |    8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > Index: autofs/modules/replicated.c
> > ===================================================================
> > --- autofs.orig/modules/replicated.c
> > +++ autofs/modules/replicated.c
> > @@ -1125,15 +1125,17 @@ static int add_host_addrs(struct host **
> >  	}
> >  	len = strlen(name);
> >  
> > -	if (name[0] == '[' && name[--len] == ']')
> > +	if (name[0] == '[' && name[--len] == ']') {
> >  		name[len] = '\0';
> > +		memmove(name, name + 1, len);
> > +	}
> >  
> >  	memset(&hints, 0, sizeof(hints));
> >  	hints.ai_flags = AI_NUMERICHOST;
> >  	hints.ai_family = AF_UNSPEC;
> >  	hints.ai_socktype = SOCK_DGRAM;
> >  
> > -	ret = getaddrinfo(name + 1, NULL, &hints, &ni);
> > +	ret = getaddrinfo(name, NULL, &hints, &ni);
> >  	if (ret)
> >  		goto try_name;
> >  
> > @@ -1153,7 +1155,7 @@ try_name:
> >  	hints.ai_family = AF_UNSPEC;
> >  	hints.ai_socktype = SOCK_DGRAM;
> >  
> > -	ret = getaddrinfo(name + 1, NULL, &hints, &ni);
> > +	ret = getaddrinfo(name, NULL, &hints, &ni);
> >  	if (ret) {
> >  		error(LOGOPT_ANY, "hostname lookup failed: %s",
> >  		      gai_strerror(ret));
> > 

I'd prefer to avoid the use of memmove(3) though so I think this will
also fix it.

autofs-5.0.6 - fix ipv6 name for lookup fix

From: Ian Kent <ikent@redhat.com>

Fix an error in the recent ipv6 name for lookup patch.
---

 modules/replicated.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)


diff --git a/modules/replicated.c b/modules/replicated.c
index 7f2b892..a10a817 100644
--- a/modules/replicated.c
+++ b/modules/replicated.c
@@ -1111,7 +1111,8 @@ static int add_host_addrs(struct host **list, const char *host,
 			  unsigned int weight, unsigned int options)
 {
 	struct addrinfo hints, *ni, *this;
-	char *name = strdup(host);
+	char *n_ptr;
+	char *name = n_ptr = strdup(host);
 	int len;
 	char buf[MAX_ERR_BUF];
 	int rr = 0;
@@ -1125,15 +1126,17 @@ static int add_host_addrs(struct host **list, const char *host,
 	}
 	len = strlen(name);
 
-	if (name[0] == '[' && name[--len] == ']')
+	if (name[0] == '[' && name[--len] == ']') {
 		name[len] = '\0';
+		name++;
+	}
 
 	memset(&hints, 0, sizeof(hints));
 	hints.ai_flags = AI_NUMERICHOST;
 	hints.ai_family = AF_UNSPEC;
 	hints.ai_socktype = SOCK_DGRAM;
 
-	ret = getaddrinfo(name + 1, NULL, &hints, &ni);
+	ret = getaddrinfo(name, NULL, &hints, &ni);
 	if (ret)
 		goto try_name;
 
@@ -1153,7 +1156,7 @@ try_name:
 	hints.ai_family = AF_UNSPEC;
 	hints.ai_socktype = SOCK_DGRAM;
 
-	ret = getaddrinfo(name + 1, NULL, &hints, &ni);
+	ret = getaddrinfo(name, NULL, &hints, &ni);
 	if (ret) {
 		error(LOGOPT_ANY, "hostname lookup failed: %s",
 		      gai_strerror(ret));
@@ -1172,7 +1175,7 @@ try_name:
 	}
 	freeaddrinfo(ni);
 done:
-	free(name);
+	free(n_ptr);
 	return ret;
 }
