From: Ian Kent <raven@themaw.net>
Subject: [PATCH v5 1/8] autofs-5.1.1 - define monotonic clock helper
 functions
Date: Fri, 18 Sep 2015 17:34:27 +0800
Message-ID: <20150918093426.29311.149.stgit@pluto.fritz.box>
References: <20150918092704.29311.84246.stgit@pluto.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=7isrRi/1hSqDyQB0kfD4apsEH5M=; b=fmC1Fd
	wvqRxGYB+XNFPa7/oL3A6ZFezWCQilerwemXakYJmQ3cndSwmZh5VbnZyHFEfJmp
	oJskfYB2OGDOEp4tvrMppFN1LHi0Y/ArMg/xD3NLN4uthycGkhAOqfkO3sevyDLH
	DUbeXjjipMdB6/A2B3DrTQ55CGhXZjXq9VsWg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=7isrRi/1hSqDyQB
	0kfD4apsEH5M=; b=APKKgFo8V5qSn3lpiO5u+HrJe4FrJflEx1tNsjEjgowFZjM
	Rbio1lDRu5/RSJMsesFmMLU5Q48ThXbbLWvpgI8V0CKY7sSyUTsI7ielub+EAVdS
	ZAQ86zcAu6cCoUnVctqLB0lAcE+joIW3CLpnZKvfwosHTTdWE5K2Jy+tEKm8=
In-Reply-To: <20150918092704.29311.84246.stgit@pluto.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Yu Ning <ning.yu@ubuntu.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

From: Yu Ning <ning.yu@ubuntu.com>

The time returned by gettimeofday() is affected by discontinuous jumps
in the system time, so it causes an issue that autofs may not auto
unmount a mount point if system time is manually changed by the system
administrator.

To fix the issue we need to convert to using a monotonic clock source
instead of the clock source used by gettimeofday().

Start by defining two helper functions that will be used by later
patches.

Signed-off-by: Yu Ning <ning.yu@ubuntu.com>
---
 CHANGELOG           |    1 +
 include/automount.h |   10 ++++++++++
 include/rpc_subs.h  |    1 +
 lib/rpc_subs.c      |   11 +++++++++++
 4 files changed, 23 insertions(+)

diff --git a/CHANGELOG b/CHANGELOG
index f072bd4..6eb4daf 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -18,6 +18,7 @@
 - fix handling of ldap bind/unbind operations.
 - fix error handling of is_mounted().
 - Add a mode option for master map entries.
+- define monotonic clock helper functions.
 
 21/04/2015 autofs-5.1.1
 =======================
diff --git a/include/automount.h b/include/automount.h
index 15cd436..34fe91d 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -566,6 +566,16 @@ do { \
 		fatal(_m_unlock); \
 } while(0)
 
+static inline time_t monotonic_time(time_t *t)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	if (t)
+		*t = (time_t) ts.tv_sec;
+	return (time_t) ts.tv_sec;
+}
+
 /* Expire alarm handling routines */
 int alarm_start_handler(void);
 int alarm_add(struct autofs_point *ap, time_t seconds);
diff --git a/include/rpc_subs.h b/include/rpc_subs.h
index b6d59f9..e329224 100644
--- a/include/rpc_subs.h
+++ b/include/rpc_subs.h
@@ -71,6 +71,7 @@ int rpc_portmap_getport(struct conn_info *, struct pmap *, unsigned short *);
 int rpc_ping_proto(struct conn_info *);
 int rpc_ping(const char *, long, long, unsigned int);
 double elapsed(struct timeval, struct timeval);
+double monotonic_elapsed(struct timespec, struct timespec);
 int rpc_time(const char *, unsigned int, unsigned int, long, long, unsigned int, double *);
 const char *get_addr_string(struct sockaddr *, char *, socklen_t);
 
diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c
index 846c40e..14e5f94 100644
--- a/lib/rpc_subs.c
+++ b/lib/rpc_subs.c
@@ -1086,6 +1086,17 @@ double elapsed(struct timeval start, struct timeval end)
 	return t2-t1;
 }
 
+double monotonic_elapsed(struct timespec start, struct timespec end)
+{
+	double t1, t2;
+
+	t1 =  (double) start.tv_sec +
+		(double) (start.tv_nsec/(1000*1000*1000));
+	t2 =  (double) end.tv_sec +
+		(double) (end.tv_nsec/(1000*1000*1000));
+	return t2 - t1;
+}
+
 int rpc_time(const char *host,
 	     unsigned int ping_vers, unsigned int ping_proto,
 	     long seconds, long micros, unsigned int option, double *result)

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
