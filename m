From: Ian Kent <raven@themaw.net>
Subject: [PATCH v5 3/8] autofs-5.1.1 - define pending condition init helper
 function
Date: Fri, 18 Sep 2015 17:34:41 +0800
Message-ID: <20150918093440.29311.1759.stgit@pluto.fritz.box>
References: <20150918092704.29311.84246.stgit@pluto.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=3m68WSKu8pUR4v6Lrx+gnXYtBSM=; b=tDPBXx
	CRHgVecohwmbqpS7pwPc8Tc5U8/5Wwi6un65aB4qiSYfC4K2dDUDtH8KPkgtjFpU
	877yH5Qrxx3UhUJwFS8i01cIw302LOMOUYqYHlVSndQjQ0dnMOOLV0D6heVxdrO0
	0tEyCOJXjnq2iLDDrzV8O6H82G7S43VLr4tQY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=3m68WSKu8pUR4v6
	Lrx+gnXYtBSM=; b=fWVGFQwOuh+pqWj5e3aISI78rRe8fyXW4PTiZ1+6jiB83kx
	glsY/1DQM84IatOU5oGNgTm6QoKG1Xeq7+w6Yupfka9KF/d8NfkLaL51obfkXneW
	TwrqPfZVQ5fdRc89p0EtYCAeNeWeGdX/C9gCWqpXik9jIg/0JVYQ3S2460KY=
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

We also want to use a monotonic clock source for the condition wait
of both the direct and indirect mount thread creation as well the
expire thread creation of each. So create a common helper function
to initialize a condition variable to use a monotonic clock source.

Signed-off-by: Yu Ning <ning.yu@ubuntu.com>
---
 CHANGELOG           |    1 +
 include/automount.h |   21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/CHANGELOG b/CHANGELOG
index c7cbc0f..fd0f7cd 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -20,6 +20,7 @@
 - Add a mode option for master map entries.
 - define monotonic clock helper functions.
 - use monotonic clock for alarm thread condition wait.
+- define pending condition init helper function.
 
 21/04/2015 autofs-5.1.1
 =======================
diff --git a/include/automount.h b/include/automount.h
index 34fe91d..fe4e7d1 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -413,6 +413,27 @@ struct pending_args {
 };
 
 #ifdef INCLUDE_PENDING_FUNCTIONS
+static void pending_cond_init(void *arg)
+{
+	struct pending_args *mt = (struct pending_args *) arg;
+	pthread_condattr_t condattrs;
+	int status;
+
+	status = pthread_condattr_init(&condattrs);
+	if (status)
+		fatal(status);
+
+	status = pthread_condattr_setclock(&condattrs, CLOCK_MONOTONIC);
+	if (status)
+		fatal(status);
+
+	status = pthread_cond_init(&mt->cond, &condattrs);
+	if (status)
+		fatal(status);
+
+	pthread_condattr_destroy(&condattrs);
+}
+
 static void pending_cond_destroy(void *arg)
 {
 	struct pending_args *mt = (struct pending_args *) arg;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
