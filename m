From: Ian Kent <raven@themaw.net>
Subject: [PATCH 13/37] autofs-5.1.2 - fix short memory allocation in
 lookup_amd_instance()
Date: Tue, 25 Oct 2016 09:18:34 +0800
Message-ID: <20161025011834.7778.70500.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=mNKfMPXXE7/zSv4zlcyoxxD5npc=; b=e85a2bYbACWbo3wzyk
        sSgGZsTvc9HbFzjHhOaT1fmKtF+UnjE85LqwfhtiQaw8l2iO9ZMEM5W9fk7j+1wf
        SMMejkZnpkpaZPWKHfCm4NYncwiKylroeq66Hmsp0Syq2EYZ5CrKVLXTJyTMjii3
        8enBcnlzA+3Xiu0Y7XeTgke0A=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=mNKfMPXXE7/zSv4zlcyoxx
        D5npc=; b=jEVPDWjiE/srPfVz7Ot07MDclAi6dH/SvXlj4qndfaVAkHPq2kIV4W
        dwHZmjYBTEn85RG2fI6Ro2+32nd0AqKm2yR4GAIyQvSPehWOuv+sYFSFx1pj2jsu
        e5HXOdNfoy1eh5jYQC/I16IgKAp8a+GOrNRz2UYS+hXxi7sU2b7as=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Fix off by one memory allocation size in lookup_amd_instance().

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG       |    1 +
 daemon/lookup.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index 28e857f..551443a 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -12,6 +12,7 @@ xx/xx/2016 autofs-5.1.3
 - Remove unused local 2KB buffer.
 - Fix typos in error messages.
 - Fix fgets(3) size argument (another one).
+- fix short memory allocation in lookup_amd_instance().
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/daemon/lookup.c b/daemon/lookup.c
index 201ccbb..582b5c9 100644
--- a/daemon/lookup.c
+++ b/daemon/lookup.c
@@ -786,7 +786,7 @@ static int lookup_amd_instance(struct autofs_point *ap,
 		return NSS_STATUS_UNKNOWN;
 	}
 
-	m_key = malloc(strlen(ap->path) + strlen(me->multi->key) + 1);
+	m_key = malloc(strlen(ap->path) + strlen(me->multi->key) + 2);
 	if (!m_key) {
 		error(ap->logopt,
 		     "failed to allocate storage for search key");

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
