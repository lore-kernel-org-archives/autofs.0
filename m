From: Ian Kent <raven@themaw.net>
Subject: [PATCH 05/37] autofs-5.1.2 - Fix size arg of fgets(3)
Date: Tue, 25 Oct 2016 09:17:51 +0800
Message-ID: <20161025011751.7778.53635.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=cnjOD5Z6+nv9yGTNsJ6zyM5YAQw=; b=ERA/QsqI1/FOrP9Hj3
        Vt8KFYl6XE44bpFpu2HcmsRYJWj1mMXRezdSjtdCzVvBI+3JQr8GrzABmEU9Be53
        g9cHPRLwhhydrw/GT/kN/kBZtkZRqIe/MufoJ5hHVJTz+fZoAVExusAVLTTrepVx
        2LoyjpFqkbBOsX2XR6MRsqXjk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=cnjOD5Z6+nv9yGTNsJ6zyM
        5YAQw=; b=gA+f8lbZ2Vq4RnxXel1rUscuqj3+s0LJ+bzShXOW64yFOxDNqXFwYR
        7DKD/i/DsxRhKlRQZXxd7Cwpox2NNhpMGoUAh5kCPc7DcYH6WmalROmpESCv1PM9
        SZuuMUCnBHlR/+xOg9pTwHl0uhldzGta2ndaOk2tkzEqtHbsBkab4=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

Since fgets(3) reads at most 1 less than size arg, it should
probably pass MAX_LINE_LEN+1 given that the conditional in the
next line tests if strlen() exceeds MAX_LINE_LEN.
(i.e. MAX_LINE_LEN isn't designed to include terminating \0)

buf has MAX_LINE_LEN+2 bytes, so passing MAX_LINE_LEN+1 is ok.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG      |    1 +
 lib/defaults.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index 99dc245..cb895c4 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -4,6 +4,7 @@ xx/xx/2016 autofs-5.1.3
 - build: check for clock_gettime in librt.
 - fix compiler warning in try_remount().
 - drop redundant \n in logerr().
+- Fix size arg of fgets(3).
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/lib/defaults.c b/lib/defaults.c
index 0e48a78..ae76513 100644
--- a/lib/defaults.c
+++ b/lib/defaults.c
@@ -879,7 +879,7 @@ static int read_config(unsigned int to_syslog, FILE *f, const char *name)
 	char *res;
 
 	new_sec = NULL;
-	while ((res = fgets(buf, MAX_LINE_LEN, f))) {
+	while ((res = fgets(buf, MAX_LINE_LEN + 1, f))) {
 		char *sec, *key, *value;
 
 		if (strlen(res) > MAX_LINE_LEN) {

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
