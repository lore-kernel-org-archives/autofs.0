From: Ian Kent <raven@themaw.net>
Subject: [PATCH 30/34] autofs-5.1.2 - fix work around sss startup delay
Date: Mon, 24 Apr 2017 09:02:47 +0800
Message-ID: <149299576737.23475.133203923808612870.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=ltAri+7geLGA57PcKO
        Yz8dZDeao+z+1wSXwSiuPrmtQ=; b=RC7NioPk+PDdNnJXAImsRl3aASmYcR6AY8
        4VyuompejIR9wmPQmR5fc8lqZVz4qaqxAy1qpfcGubKBmjxODcFJBmP+9u9f55gj
        eMQMZ7Zx759wWWh5mNoAZuD/DyOErBqyNcmpny2ghTa7+crN3CFUoUa9EE2OU+mv
        Q1P4zqVt7hvp6zqJ7EUprC2hCoYZj1Bchi79TBOzENF1XJrveM2pu3Y/ncOuK1H/
        U1SbYvyJVc/lqPa8jHb1rxHuOcs0IwHfsBFQLAVMumNLM6KNt7zVC7libIP0FGGO
        ZX2sMrpNiuGPSXH0/9tPlCHdjTniLfqb3+SM15ahhLEvSJc7maBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=ltAri+7geLGA57PcKOYz8dZDeao+z+1wSXwSiuPrmtQ=; b=F2/FFPSg
        k/zrJE91CBRmctafzD7YP5e6YbBFtgsF/2itrAWnLPzWV4n8TRPY0sXi28BgfNoY
        b3rfSRXDwXZCqJRXPcDAY7wTXxdM94oC4UrVBIUdo9mL1xW7YbSCK74zLqFCNzO5
        1zrpQ/T0Ye21ekHZugZ+0e/6sBiyrevcSNKNqRNMb9p4+P+t9oNlwVtrVb4U3/b5
        DOzirFLXi9mezB8ceffTVvVlsNWQffsYU6GZTfDlDjT5pCB0KWIGSj4dbRysaYMb
        LvK5RIa9uuzi8K40npXdUDejnS5EaWPCHhTFQnDowqW1qpLmfK3u+WLxNVbIYzi+
        yGwzWETi632Pqw==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

If a sss startup delay has been configured to non-zero autofs will
wait up to the configured time and return NSS_STATUS_UNAVAIL or
NSS_STATUS_NOTFOUND even if setautomntent_wait() returns success.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG            |    1 +
 modules/lookup_sss.c |    8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 2dceb69..7700a20 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -56,6 +56,7 @@ xx/xx/2016 autofs-5.1.3
 - add config option to use mount request log id.
 - use autofs_point to store expire timeout where possibe.
 - fix possible NULL derefernce.
+- fix work around sss startup delay.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/modules/lookup_sss.c b/modules/lookup_sss.c
index 6d924cf..15a5ca4 100644
--- a/modules/lookup_sss.c
+++ b/modules/lookup_sss.c
@@ -309,9 +309,11 @@ int lookup_read_master(struct master *master, time_t age, void *context)
 		ret = setautomntent_wait(logopt,
 					 ctxt, ctxt->mapname, &sss_ctxt,
 					 retries);
-		if (ret == ENOENT)
-			return NSS_STATUS_NOTFOUND;
-		return NSS_STATUS_UNAVAIL;
+		if (ret) {
+			if (ret == ENOENT)
+				return NSS_STATUS_NOTFOUND;
+			return NSS_STATUS_UNAVAIL;
+		}
 	}
 
 	count = 0;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
