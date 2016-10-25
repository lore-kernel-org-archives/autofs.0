From: Ian Kent <raven@themaw.net>
Subject: [PATCH 25/37] autofs-5.1.2 - work around sss startup delay
Date: Tue, 25 Oct 2016 09:19:38 +0800
Message-ID: <20161025011938.7778.57720.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=xFHg7l3uDW9Ykjg6MNQGakHuiDU=; b=qk+79ZtA7WjofrQ3S3
        M3PKfvlZvkkfVAySCtwASZ2fe6g1QjL+ICo10I2MuVDDFn+8vb9EdIaTND51ISGk
        v0130EqUSntzfjnV1vbIi0E2LdcTjXihC0Hw67bWcpkDRJnAB5xUDz/TRIwAMCVf
        10H17q1YUVh19N/BlGTQ+v7W0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=xFHg7l3uDW9Ykjg6MNQGak
        HuiDU=; b=tnoyc0/A7CoZkUuiCJ4r3jEFIORWdQv7+y6Jnf5Y9vaZTo+iPQGpJI
        8rez/hFLeHmg7ZdB/EGtiJ40gPGSCxinEZolYBj8QaS3Lw7GgOrbr9oF6OZ5c9aR
        z8/XlFhd0M1ZwWOd2Z8F+oEDErQLXW0l6q1Lt3ijFLSY6sZkCa7bw=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

When sssd is starting up there can be a delay before the map
information is read. During that time an ENOENT can be returned
when there actually is a map and autofs must respect the ENOENT
return and continue becuase no map present is a valid response.

To work around that make the master map read wait and retry for
for a time to give sssd a chance to read the map before returning
either an ENOENT or, if the retry limit is exceeded, ETIMEDOUT.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG            |    1 +
 modules/lookup_sss.c |   61 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/CHANGELOG b/CHANGELOG
index 576f52a..90688e6 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -22,6 +22,7 @@ xx/xx/2016 autofs-5.1.3
 - update and add README for old autofs schema.
 - wait for master map available at start.
 - add master read wait option.
+- work around sss startup delay.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/modules/lookup_sss.c b/modules/lookup_sss.c
index e01dd28..702e7b5 100644
--- a/modules/lookup_sss.c
+++ b/modules/lookup_sss.c
@@ -30,6 +30,11 @@
 
 #define MAPFMT_DEFAULT "sun"
 
+/* Half a second between retries */
+#define SETAUTOMOUNTENT_MASTER_INTERVAL	500000000
+/* Try for 10 seconds */
+#define SETAUTOMOUNTENT_MASTER_RETRIES	10 * 2
+
 #define MODPREFIX "lookup(sss): "
 
 #define SSS_SO_NAME "libsss_autofs"
@@ -219,6 +224,53 @@ static int setautomntent(unsigned int logopt,
 	return ret;
 }
 
+static int setautomntent_wait(unsigned int logopt,
+			      struct lookup_context *ctxt,
+			      const char *mapname,
+			      void **sss_ctxt, unsigned int retries)
+{
+	unsigned int retry = 0;
+	int ret = 0;
+
+	*sss_ctxt = NULL;
+
+	while (++retry < retries) {
+		struct timespec t = { 0, SETAUTOMOUNTENT_MASTER_INTERVAL };
+		struct timespec r;
+
+		ret = ctxt->setautomntent(mapname, sss_ctxt);
+		if (ret != ENOENT)
+			break;
+
+		if (*sss_ctxt) {
+			free(*sss_ctxt);
+			*sss_ctxt = NULL;
+		}
+
+		while (nanosleep(&t, &r) == -1 && errno == EINTR)
+			memcpy(&t, &r, sizeof(struct timespec));
+	}
+
+
+	if (ret) {
+		char buf[MAX_ERR_BUF];
+		char *estr;
+
+		if (*sss_ctxt) {
+			free(*sss_ctxt);
+			*sss_ctxt = NULL;
+		}
+
+		if (retry == retries)
+			ret = ETIMEDOUT;
+
+		estr = strerror_r(ret, buf, MAX_ERR_BUF);
+		error(logopt, MODPREFIX "setautomntent: %s", estr);
+	}
+
+	return ret;
+}
+
 static int endautomntent(unsigned int logopt,
 			 struct lookup_context *ctxt, void **sss_ctxt)
 {
@@ -247,6 +299,15 @@ int lookup_read_master(struct master *master, time_t age, void *context)
 
 	ret = setautomntent(logopt, ctxt, ctxt->mapname, &sss_ctxt);
 	if (ret) {
+		unsigned int retries;
+
+		if (ret != ENOENT)
+			return NSS_STATUS_UNAVAIL;
+
+		retries = SETAUTOMOUNTENT_MASTER_RETRIES;
+		ret = setautomntent_wait(logopt,
+					 ctxt, ctxt->mapname, &sss_ctxt,
+					 retries);
 		if (ret == ENOENT)
 			return NSS_STATUS_NOTFOUND;
 		return NSS_STATUS_UNAVAIL;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
