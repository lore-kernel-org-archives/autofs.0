Received: from cvsmtppost11.nm.naver.com (cvsmtppost11.nm.naver.com [114.111.35.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5611D37204C
	for <autofs@vger.kernel.org>; Wed,  7 Oct 2026 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394566; cv=none; b=B0cbEeED+cVVMl8vuQi+xQaj9vd5JcGgXKHmMTefPfIsFzHZieiEEHuVcr2E0m8rE2S0iT5V4rCJ6L+9Sjl5HdVBQUyOJeW7ETrzpLg1P6VeoljIOG1QukXIbIcV5jTEo9JyB+ajZZUb1O0aUHXI7AjjGzmtiktjy7lxBNfoxbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394566; c=relaxed/simple;
	bh=4+C/KLqDV5ggRytdDQiZ3+Jbw8+B/QrGryh6gXzUJ1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IL7Fu/vGH7enDyfgAD9e5cNEHLAASmfDptfI9OH5m44K7FH6LspnBXRbqvjsRghBQq+TYyF6qLPfLeWtFa7dywkueOjZKPAXCERw0ggc++x/koqBfkH0GO/27u+hnqyvqguwxexRgmcdbg3u7oonYK0TbQtaKZ1v3YiypGMKm8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=h3fY0NjU; arc=none smtp.client-ip=114.111.35.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="h3fY0NjU"
Received: from cvsendbo009.nm ([10.112.18.55])
  by cvsmtppost11.nm.naver.com with ESMTP id v65gJxeaRSOuK3BKAJTT3Q
  for <autofs@vger.kernel.org>;
  Wed, 07 Oct 2026 17:35:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1791394555; bh=4+C/KLqDV5ggRytdDQiZ3+Jbw8+B/QrGryh6gXzUJ1E=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=h3fY0NjU40aRnlHRReiKbx8QunPcSaKGA6mvpYdZ7OGcFhSazUc0U7LweVu3nYwxT
	 qwlaDqaV1hbW0XGx/o4cMscSKBG7iaAN0wo1bReDtQ/UTc36w7hB0cz8tuDUPNkk/6
	 QEDxvm5zNeVXcWJsdYkCRfyp8mzy0tPASOh0VvYQaP9t9j6kQzW8IgsYnkCeJPBLb7
	 UxagqY5WJC4IhFPgzjrV0dfpwCeyV3oSJwU8WTCQ4kg/5z/FewcjZFfml35H79l8fS
	 Hv8igdOgxA5P0QHG16dHz9FtiX8j7+473iiZlvvVnVXrd5sVFLyOWtspSvm1ahOmCe
	 l3QWIU4V08v0Q==
X-Session-ID: SjQ+maq1TFKTd5rpfm145Q
X-Works-Send-Opt: OPFwpzGdjHmdKHFOMr39Ko3YKBmqjAudFqM9KqMqFxIYkEljxBmwjAg=
X-Works-Smtp-Source: sZbrKqulFqJZ+Hm9FxuZ+6E=
Received: from localhost.localdomain ([115.136.205.4])
  by cvnsmtp011.nm.naver.com with ESMTP id SjQ+maq1TFKTd5rpfm145Q
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Wed, 07 Oct 2026 17:35:55 -0000
From: tjdqudcks0424@naver.com
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sung Byeongchan <tjdqudcks0424@naver.com>
Subject: [PATCH] autofs: ignore notification errors from a replaced pipe
Date: Thu,  8 Oct 2026 02:35:42 +0900
Message-ID: <20261007173542.593624-1-tjdqudcks0424@naver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sung Byeongchan <tjdqudcks0424@naver.com>

autofs_notify_daemon() takes a reference to the current notification
pipe under wq_mutex, then drops the mutex before writing the request. The
write can block while the daemon enters catatonic mode and installs a
replacement pipe.

If the old pipe's reader is then closed, the delayed write returns -EPIPE
and the generic error path enters catatonic mode again. That transition
acts on the current superblock state, closes the replacement pipe, and
releases the new daemon generation's wait queues.

Only enter catatonic mode when the pipe which failed is still the current
pipe. Factor the already-locked transition so the identity check and state
change are atomic with respect to another replacement.

This was reproduced on v7.3-rc5-337-gff47652a4b66c in a local QEMU guest.
An unprivileged UID 65534 lookup filled the old packet pipe before a
normal CATATONIC/SETPIPEFD restart. On the unmodified kernel, the new pipe
received HUP and both a pending victim lookup and a later lookup failed
with ENOENT in two out of two fresh-mount runs.

With this change, the new pipe remained active, received an intact
304-byte request, and both victim lookups completed in two out of two
runs. Normal lookup and restart-without-a-blocked-writer controls passed.
No KASAN, oops, refcount, or lock diagnostic was observed. A source
reproducer and complete local logs are available privately on request.

The demonstrated impact is limited to denial of a shared autofs service
during a legitimate daemon restart. No memory corruption, information leak,
privilege escalation, or code execution primitive was observed.

Fixes: 8d7b48e0bc5fa ("autofs4: add miscellaneous device for ioctls")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Sung Byeongchan <tjdqudcks0424@naver.com>
---
 fs/autofs/waitq.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/autofs/waitq.c b/fs/autofs/waitq.c
index d46241342dfc9..fd78d96e105d 100644
--- a/fs/autofs/waitq.c
+++ b/fs/autofs/waitq.c
@@ -12,15 +12,13 @@
  */
 static autofs_wqt_t autofs_next_wait_queue = 1;
 
-void autofs_catatonic_mode(struct autofs_sb_info *sbi)
+static void autofs_catatonic_mode_locked(struct autofs_sb_info *sbi)
 {
 	struct autofs_wait_queue *wq, *nwq;
 
-	mutex_lock(&sbi->wq_mutex);
-	if (sbi->flags & AUTOFS_SBI_CATATONIC) {
-		mutex_unlock(&sbi->wq_mutex);
+	lockdep_assert_held(&sbi->wq_mutex);
+	if (sbi->flags & AUTOFS_SBI_CATATONIC)
 		return;
-	}
 
 	pr_debug("entering catatonic mode\n");
 
@@ -40,6 +38,21 @@ void autofs_catatonic_mode(struct autofs_sb_info *sbi)
 	fput(sbi->pipe);	/* Close the pipe */
 	sbi->pipe = NULL;
 	sbi->pipefd = -1;
+}
+
+void autofs_catatonic_mode(struct autofs_sb_info *sbi)
+{
+	mutex_lock(&sbi->wq_mutex);
+	autofs_catatonic_mode_locked(sbi);
+	mutex_unlock(&sbi->wq_mutex);
+}
+
+static void autofs_catatonic_mode_for_pipe(struct autofs_sb_info *sbi,
+					   struct file *pipe)
+{
+	mutex_lock(&sbi->wq_mutex);
+	if (sbi->pipe == pipe)
+		autofs_catatonic_mode_locked(sbi);
 	mutex_unlock(&sbi->wq_mutex);
 }
 
@@ -170,7 +183,7 @@ static void autofs_notify_daemon(struct autofs_sb_info *sbi,
 		autofs_wait_release(sbi, wq->wait_queue_token, ret);
 		break;
 	default:
-		autofs_catatonic_mode(sbi);
+		autofs_catatonic_mode_for_pipe(sbi, pipe);
 		break;
 	}
 	fput(pipe);
-- 
2.43.0
