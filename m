Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com [64.215.233.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B403A302CC3
	for <autofs@vger.kernel.org>; Mon, 15 Sep 2025 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.215.233.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757939202; cv=none; b=rDlIR1Pu3xQOYCbCRV21BHXEke3fJ2TVirr5HSPvBAXr1nyW53EGNHU6IqQ1mUUHfd3Mgfw83GqvpTS1y9zQk53ToX8Br8wPIkvCv0oKYT8N6ty3pzutBA0ouui0yv4CHhpAVwttiN8rzX3QB7ibv9MZITPRSg0F/Y5evc8Qse0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757939202; c=relaxed/simple;
	bh=4UaEmf+1w7NfRR9U+nOwiHdOxF6fpgi3c3ydhnL959U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5ZgUVvJk0UxXd94iSRjxvN/s97z6Qt6ReCkErZr8u27CAFssArdfLn2F+p9Z6xjVQMt+Pw/WQcKyNUMC4469v6O61derEr/z9gjEHQXh8RbdrGb+nDhWRtSnzkbr7j2VMS21TLeu3iQ+tJ/yuoVX/4rolWOe39T7c+ll211DoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=zi8rEgDk; arc=none smtp.client-ip=64.215.233.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="zi8rEgDk"
From: Jun Eeo <jeeo@janestreet.com>
To: raven@themaw.net
Cc: autofs@vger.kernel.org,
 	jeeo@janestreet.com
Subject: [PATCH] autofs-5.1.9 - don't call unsetenv in sd_notify
Date: Mon, 15 Sep 2025 13:26:05 +0100
Message-ID: <20250915122605.3089654-1-jeeo@janestreet.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <922abdb7-659a-4663-af65-15e8415b87c8@themaw.net>
References: <922abdb7-659a-4663-af65-15e8415b87c8@themaw.net>
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1757939194;
  bh=hNrJ8h8b35V0smCIO5S+04XAFBkxh0ufm+RCgmG1AQo=;
  h=From:To:Cc:Subject:Date:In-Reply-To:References;
  b=zi8rEgDkiy4lz8WwgQANQeS5vQe5i3huoIwvWsvbc7uTczgRCCAMAtCFs0yQW+Ylj
  Xwd09Mwx+9yWWs4yxHLkjmqYibLVu9M9Pjc22kja/zg0AF5BD9KohG8XlK6mQnCH/X
  sMnApFGL9qhhz8G7mhaAbj8rAsjV7EwGvRV4Kamtx+RrGKGxDn8NISJt6mK2tFb7ut
  9kHGOrxx8lj9BlUD2XD1GvoeyaKTaBZfp4QNLTTV9vsj3ORqhH6AbaOD1U6VdEYIlj
  hGOFnlv5qWdpibXdyu8nE0x4VQYYOBNOX5+132g/co9yi2vKXLysbPorrIKXwLrLLR
  Yw1mdW4GVuqKg==

Avoid a stray unsetenv after the main thread starts servicing automounts.
One potential issue this may cause is:

  main thread
  main()
  -> sd_notify(1, ...)
     -> unsetenv()

  worker thread:
  lookup_program.c:lookup_one()
  -> fork()  # if the fork happened just before unsetenv in sd_notify,
             # the envlock in glibc's setenv.c will be in a locked state.
     -> macro_setenv() # in the child
        -> setenv()
---
 daemon/automount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/daemon/automount.c b/daemon/automount.c
index 474b29a..51551f3 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -2739,7 +2739,7 @@ int main(int argc, char *argv[])
 
 #ifdef WITH_SYSTEMD
 		if (flags & DAEMON_FLAGS_SYSTEMD_SERVICE)
-			sd_notify(1, "READY=1");
+			sd_notify(0, "READY=1");
 #endif
 
 		signal_handler_thid = pthread_self();
-- 
2.43.7

