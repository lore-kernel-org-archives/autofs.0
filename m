From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Slow mounts when using large round robin sets
Date: Fri, 21 Dec 2007 16:46:14 -0500
Message-ID: <x49fxxvzpp5.fsf@segfault.boston.devel.redhat.com>
References: <98E55D6E1B3CFD43BDA59EEB56DD7D72442DF1@sbs01.xiss.private>
	<98E55D6E1B3CFD43BDA59EEB56DD7D724431C0@sbs01.xiss.private>
	<1196921804.3089.28.camel@raven.themaw.net>
	<98E55D6E1B3CFD43BDA59EEB56DD7D724432D5@sbs01.xiss.private>
	<x49zlwm5hf1.fsf@segfault.boston.devel.redhat.com>
	<98E55D6E1B3CFD43BDA59EEB56DD7D7244386E@sbs01.xiss.private>
	<1198241367.3488.26.camel@raven.themaw.net>
	<x49odck175r.fsf@segfault.boston.devel.redhat.com>
	<98E55D6E1B3CFD43BDA59EEB56DD7D724438C2@sbs01.xiss.private>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <98E55D6E1B3CFD43BDA59EEB56DD7D724438C2@sbs01.xiss.private>
	(James Richardson's message of "Fri\,
	21 Dec 2007 15\:04\:30 -0600")
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
To: James Richardson <jrichardson@x-iss.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

"James Richardson" <jrichardson@x-iss.com> writes:

> Jeff,
>
> Using the latest Autofs source code from I received the following
> results:
>
> large-rr.domain.tld contains 49 A records in DNS.
>
> small-rr.domain.tld contains 16 A records (a subset of large-rr).
>
> Test 1:
>
> I configured auto.home with the entry:
>
>       brian -rsize=8192,wsize=8192,proto=tcp,vers=3
> large-rr:/home/brian
>
>
> # time ls /home/brian/.bash_history
>
> /home/brian/.bash_history
>
> real    0m0.734s
>
> user    0m0.000s
>
> sys     0m0.000s
>  
>
> Test 2:
>
> I then rebooted the server to remove any local cached anything and
> updated auto.home to have:
>
>       brian -rsize=8192,wsize=8192,proto=tcp,vers=3
> small-rr:/home/brian
>
>
> # time ls -alht /home/brian/.bash_history
>
> -rw-------  1 brian support 13K Nov 15 10:39 
>
> real    0m0.126s
>
> user    0m0.000s
>
> sys     0m0.004s
>  
>
> During Test 1 there were 1,160 DNS packets (580 UDP packets, 580 TCP
> packets). During Test 2 there were 196 packets (all UDP).

Very strange.  I don't have round-robin DNS configured, but in my
testing, autofs only called into the resolver once, but there were 6-8
queries logged by tcpdump.

You can apply this patch and see what it outputs.  Turn off debug
logging, as it will just clutter the logs.  Results should be printed
in /var/log/messages:

Dec 21 16:37:28 sig11 automount[3763]: add_host_addrs:883: gethostbyname_r

See how many of these print.  If it's not many, then we'll have to
look elsewhere for your problem (or I've missed some resolver queries
from autofs!).

-Jeff


diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c
index 5797639..90bf768 100644
--- a/lib/rpc_subs.c
+++ b/lib/rpc_subs.c
@@ -91,6 +91,7 @@ static CLIENT *create_udp_client(struct conn_info *info)
 
 	memset(&hp, 0, sizeof(struct hostent));
 
+	logerr("gethostbyname_r");
 	ret = gethostbyname_r(info->host, php,
 			buf, HOST_ENT_BUF_SIZE, &result, &ghn_errno);
 	if (ret || !result) {
@@ -300,6 +301,7 @@ static CLIENT *create_tcp_client(struct conn_info *info)
 
 	memset(&hp, 0, sizeof(struct hostent));
 
+	logerr("gethostbyname_r");
 	ret = gethostbyname_r(info->host, php,
 			buf, HOST_ENT_BUF_SIZE, &result, &ghn_errno);
 	if (ret || !result) {
diff --git a/modules/replicated.c b/modules/replicated.c
index 90b2925..5171beb 100644
--- a/modules/replicated.c
+++ b/modules/replicated.c
@@ -880,6 +880,7 @@ static int add_host_addrs(struct host **list, const char *host, unsigned int wei
 	memset(buf, 0, MAX_IFC_BUF);
 	memset(&he, 0, sizeof(struct hostent));
 
+	logerr("gethostbyname_r");
 	ret = gethostbyname_r(host, phe,
 			buf, MAX_IFC_BUF, &result, &ghn_errno);
 	if (ret || !result) {
