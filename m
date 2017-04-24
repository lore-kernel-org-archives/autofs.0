From: Ian Kent <raven@themaw.net>
Subject: [PATCH 25/34] autofs-5.1.2 - log functions to prefix messages with
 attempt_id if available
Date: Mon, 24 Apr 2017 09:02:21 +0800
Message-ID: <149299574164.23475.17911865152534699663.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=pBox8t0PJzDlb8Nh29
        HMOdrxdL2n6RMKpddvl/Zfuwk=; b=czOTt4WeFuwXVHT/2gRVKHs7zK9eS6bMSV
        npNqEBDu9KBW3n0EqWRs9+fHdGT4nd7iFx/7DpWlT74nN/KlTjeMaIpZumlk9Tc5
        cplnD5mtS+Mb/9GUTRKjoirkDSMBIBcusYG7BAGCYxjvYfz7rVuUabARR4AgiYiQ
        c3OMwwTRVf7TLuu5v8ZXni2Cy3H53kPZWPx+uy+9l7Yc2eomwV275ZLBAqjvpX77
        i1dZok6nOhTpvgkVLrB/eqaYjoImOQnzaDF7K5plvsyPqgmBRdHOvhiWBZpjOFT9
        /buGsPt20MrZ86m3MMqVVWC/QjgShQvZYB9orCMeaJrxk1JQgCBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=pBox8t0PJzDlb8Nh29HMOdrxdL2n6RMKpddvl/Zfuwk=; b=dbVDkaAt
        +R264kAG++lhoaQ46GdxOo0W1oqw7o/9GwkPF8KIlvcwhyFU5bAXl+LEnmxzubuo
        6BWy+aaXfHVXEOYcTEz+UzwMhQ1I7bVRCC/zfWQteJ2+xsf584zyn3aPY91FTpFP
        RK/jFBOL9gfzecqI7sPOfzRpFhU6oPcaiTS7g55AOPqAC3qk+1RZ7z+3Mg6qsJCp
        h8EMOoqDuzHbsTazzlNKlK39tAj4FX60JhyFaVH/6DPPbAR1J5D3nmSus/OLWERj
        GIFPhCO1PvloaBYrNvEQTYNVj1KMIwvfWbmIIwQR2EG9f9onsBzcE3VSY8y/0FsA
        Fcwk86HrBnNajQ==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

From: Lars R. Damerow <lars@pixar.com>

Now that there should be a mount attempt id try and include it in log entries.

Signed-off-by: Lars R. Damerow <lars@pixar.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG |    1 
 lib/log.c |  164 +++++++++++++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 137 insertions(+), 28 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 0cd0d45..eed9697 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -51,6 +51,7 @@ xx/xx/2016 autofs-5.1.3
 - delay submount exit for amd submounts.
 - add the mount requestor's pid to pending_args.
 - create thread-local ID for mount attempts.
+- log functions to prefix messages with attempt_id if available.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/lib/log.c b/lib/log.c
index 832add7..1a0bc3f 100644
--- a/lib/log.c
+++ b/lib/log.c
@@ -32,6 +32,26 @@ static unsigned int logging_to_syslog = 0;
 static unsigned int do_verbose = 0;		/* Verbose feedback option */
 static unsigned int do_debug = 0;		/* Full debug output */
 
+static char *prepare_attempt_prefix(const char *msg)
+{
+	unsigned long *attempt_id;
+	char buffer[ATTEMPT_ID_SIZE + 1];
+	char *prefixed_msg = NULL;
+
+	attempt_id = pthread_getspecific(key_thread_attempt_id);
+	if (attempt_id) {
+		int len = sizeof(buffer) + 1 + strlen(msg) + 1;
+
+		snprintf(buffer, ATTEMPT_ID_SIZE, "%02lx", *attempt_id);
+		prefixed_msg = (char *) calloc(len, sizeof(char));
+		strcpy(prefixed_msg, buffer);
+		strcat(prefixed_msg, "|");
+		strcat(prefixed_msg, msg);
+	}
+
+	return prefixed_msg;
+}
+
 void set_log_norm(void)
 {
 	do_verbose = 0;
@@ -72,124 +92,212 @@ void set_log_debug_ap(struct autofs_point *ap)
 void log_info(unsigned int logopt, const char *msg, ...)
 {
 	unsigned int opt_log = logopt & (LOGOPT_DEBUG | LOGOPT_VERBOSE);
+	char *prefixed_msg;
 	va_list ap;
 
 	if (!do_debug && !do_verbose && !opt_log)
 		return;
 
+	prefixed_msg = prepare_attempt_prefix(msg);
+
 	va_start(ap, msg);
-	if (logging_to_syslog)
-		vsyslog(LOG_INFO, msg, ap);
-	else {
-		vfprintf(stderr, msg, ap);
+	if (logging_to_syslog) {
+		if (prefixed_msg)
+			vsyslog(LOG_INFO, prefixed_msg, ap);
+		else
+			vsyslog(LOG_INFO, msg, ap);
+	} else {
+		if (prefixed_msg)
+			vfprintf(stderr, prefixed_msg, ap);
+		else
+			vfprintf(stderr, msg, ap);
 		fputc('\n', stderr);
 	}
 	va_end(ap);
 
+	if (prefixed_msg)
+		free(prefixed_msg);
+
 	return;
 }
 
 void log_notice(unsigned int logopt, const char *msg, ...)
 {
 	unsigned int opt_log = logopt & (LOGOPT_DEBUG | LOGOPT_VERBOSE);
+	char *prefixed_msg;
 	va_list ap;
 
 	if (!do_debug && !do_verbose && !opt_log)
 		return;
 
+	prefixed_msg = prepare_attempt_prefix(msg);
+
 	va_start(ap, msg);
-	if (logging_to_syslog)
-		vsyslog(LOG_NOTICE, msg, ap);
-	else {
-		vfprintf(stderr, msg, ap);
+	if (logging_to_syslog) {
+		if (prefixed_msg)
+			vsyslog(LOG_NOTICE, prefixed_msg, ap);
+		else
+			vsyslog(LOG_INFO, msg, ap);
+	} else {
+		if (prefixed_msg)
+			vfprintf(stderr, prefixed_msg, ap);
+		else
+			vfprintf(stderr, msg, ap);
 		fputc('\n', stderr);
 	}
 	va_end(ap);
 
+	if (prefixed_msg)
+		free(prefixed_msg);
+
 	return;
 }
 
 void log_warn(unsigned int logopt, const char *msg, ...)
 {
 	unsigned int opt_log = logopt & (LOGOPT_DEBUG | LOGOPT_VERBOSE);
+	char *prefixed_msg;
 	va_list ap;
 
 	if (!do_debug && !do_verbose && !opt_log)
 		return;
 
+	prefixed_msg = prepare_attempt_prefix(msg);
+
 	va_start(ap, msg);
-	if (logging_to_syslog)
-		vsyslog(LOG_WARNING, msg, ap);
-	else {
-		vfprintf(stderr, msg, ap);
+	if (logging_to_syslog) {
+		if (prefixed_msg)
+			vsyslog(LOG_WARNING, prefixed_msg, ap);
+		else
+			vsyslog(LOG_INFO, msg, ap);
+	} else {
+		if (prefixed_msg)
+			vfprintf(stderr, prefixed_msg, ap);
+		else
+			vfprintf(stderr, msg, ap);
 		fputc('\n', stderr);
 	}
 	va_end(ap);
 
+	if (prefixed_msg)
+		free(prefixed_msg);
+
 	return;
 }
 
 void log_error(unsigned logopt, const char *msg, ...)
 {
+	char *prefixed_msg;
 	va_list ap;
 
+	prefixed_msg = prepare_attempt_prefix(msg);
+
 	va_start(ap, msg);
-	if (logging_to_syslog)
-		vsyslog(LOG_ERR, msg, ap);
-	else {
-		vfprintf(stderr, msg, ap);
+	if (logging_to_syslog) {
+		if (prefixed_msg)
+			vsyslog(LOG_ERR, prefixed_msg, ap);
+		else
+			vsyslog(LOG_INFO, msg, ap);
+	} else {
+		if (prefixed_msg)
+			vfprintf(stderr, prefixed_msg, ap);
+		else
+			vfprintf(stderr, msg, ap);
 		fputc('\n', stderr);
 	}
 	va_end(ap);
+
+	if (prefixed_msg)
+		free(prefixed_msg);
+
 	return;
 }
 
 void log_crit(unsigned logopt, const char *msg, ...)
 {
+	char *prefixed_msg;
 	va_list ap;
 
+	prefixed_msg = prepare_attempt_prefix(msg);
+
 	va_start(ap, msg);
-	if (logging_to_syslog)
-		vsyslog(LOG_CRIT, msg, ap);
-	else {
-		vfprintf(stderr, msg, ap);
+	if (logging_to_syslog) {
+		if (prefixed_msg)
+			vsyslog(LOG_CRIT, prefixed_msg, ap);
+		else
+			vsyslog(LOG_INFO, msg, ap);
+	} else {
+		if (prefixed_msg)
+			vfprintf(stderr, prefixed_msg, ap);
+		else
+			vfprintf(stderr, msg, ap);
 		fputc('\n', stderr);
 	}
 	va_end(ap);
+
+	if (prefixed_msg)
+		free(prefixed_msg);
+
 	return;
 }
 
 void log_debug(unsigned int logopt, const char *msg, ...)
 {
 	unsigned int opt_log = logopt & LOGOPT_DEBUG;
+	char *prefixed_msg;
 	va_list ap;
 
 	if (!do_debug && !opt_log)
 		return;
 
+	prefixed_msg = prepare_attempt_prefix(msg);
+
 	va_start(ap, msg);
-	if (logging_to_syslog)
-		vsyslog(LOG_WARNING, msg, ap);
-	else {
-		vfprintf(stderr, msg, ap);
+	if (logging_to_syslog) {
+		if (prefixed_msg)
+			vsyslog(LOG_WARNING, prefixed_msg, ap);
+		else
+			vsyslog(LOG_INFO, msg, ap);
+	} else {
+		if (prefixed_msg)
+			vfprintf(stderr, prefixed_msg, ap);
+		else
+			vfprintf(stderr, msg, ap);
 		fputc('\n', stderr);
 	}
 	va_end(ap);
 
+	if (prefixed_msg)
+		free(prefixed_msg);
+
 	return;
 }
 
 void logmsg(const char *msg, ...)
 {
+	char *prefixed_msg;
 	va_list ap;
+
+	prefixed_msg = prepare_attempt_prefix(msg);
+
 	va_start(ap, msg);
-	if (logging_to_syslog)
-		vsyslog(LOG_CRIT, msg, ap);
-	else {
-		vfprintf(stderr, msg, ap);
+	if (logging_to_syslog) {
+		if (prefixed_msg)
+			vsyslog(LOG_CRIT, prefixed_msg, ap);
+		else
+			vsyslog(LOG_INFO, msg, ap);
+	} else {
+		if (prefixed_msg)
+			vfprintf(stderr, prefixed_msg, ap);
+		else
+			vfprintf(stderr, msg, ap);
 		fputc('\n', stderr);
 	}
 	va_end(ap);
+
+	if (prefixed_msg)
+		free(prefixed_msg);
+
 	return;
 }
 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
