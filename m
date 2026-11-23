Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795474360;
	b=5pEoOyOFbEvZpAzpNnEuhsxTv7zfZkilVqfFhnKTpazaYoIWx4Yb7oAoae/9q0PUbs3i
	 V9coROWJBcjH4yMfal5yVUtUtWiBMxM5UJAdyIFC2xpSOojYbHwo1wp+GV+OuY7DWjbex
	 wXxiPml2dmEq3wztk2Uvut5s47K2WcYlFDrFyR9NKrLa+tQB/8EL7yGDahMmEqwVZgruL
	 iE3sPubgO6ZXbxro0BJeacVIhgb2oedKdpfZKEZoHRSPib234Lry1CzX98VXlTehTbPAW
	 nWg2o/uP73IYOnKTXBObUXGOCN/R+OUCksd672HPdVuwWbKloA/aVyzivd9w/m+RgpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795474360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=RI0AtgIIgYmtt4Ma9wBNFrtD04UI1YpHvkXQ3fFrXjE=;
	b=krIyraSQzIB0SrQrPECVaJMfyrK0PJtLIl7lYrtLEEFiFiRK/3vZpjevRqjqUsI2VKL2
	 M4GV5NB76yZFG5p6iOX0MAVA0VWJWXjBJ/dgkIRg7RjqgdD0qjHalZM6hJO8xgNAOpPq9
	 l5P8bJvAzrTiyAa5sa+zMrc554dkf/KaknvzTShgWdzLrNCJZflp0mUzvY8Y/D0Y6eL5+
	 5yENnUx224OuhAAmXhihxEvoUAkJCty4QXmIz5h0OsQ+ElA2T8GklKAh8O+AWsd/Mk7yX
	 /pHvX3dEfmdBGzDZlcABrFBCqRtbx5nJE/b2nKu77ig+uoZiViS2Q2DJnLXMZ6G+vTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--zhenwenliang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QJbnfzdo;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5477606A32C
	for <autofs@vger.kernel.org>; Mon, 23 Nov 2026 22:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5477606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhenwenliang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QJbnfzdo
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4dab94dc3e7so8892906b6e.0
        for <autofs@vger.kernel.org>; Mon, 23 Nov 2026 14:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795474359; x=1796079159; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RI0AtgIIgYmtt4Ma9wBNFrtD04UI1YpHvkXQ3fFrXjE=;
        b=QJbnfzdo+dOVtDHdBjdRE/bxi+HuVKnhQQGaCRKLLYNUMoz8qskc81xHC4xFq7A/n/
         88VwdEky07fQhkl88C/iBNQj2srO+LtM1YgWCbujyxguGPATn0JV9viUfgpfPILBICMk
         nZbN14+BMcLzuYfc+S2NeTyyzlvI19c8bVAj7r1+Kj5C/YqP0OJAQpp/mvbOkqzvghGa
         2NSLeLoJM1/wt8pWhXgdj5V7o7KSFbf15P8H+2CuyCPaEZXZfVAMPiC1iAfoX5JFeshF
         ee50HgopWUKAPkViI6kmn+qEJP8A8NB8tFYWWPvMGzeiEFbW81BmQn1nPHIwemxYSLUc
         Bmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795474359; x=1796079159;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RI0AtgIIgYmtt4Ma9wBNFrtD04UI1YpHvkXQ3fFrXjE=;
        b=uTzZ3fIlrAVCds75IEMJWHrWdHQF4R5QUP5s3wHfx59hWLx0xik7OQmeu9DGy6Arp5
         Rn2823/tzivA34QFXXRut4eKps7bIishLTbdczyY9BzmCEGASYf2VqC9gPV2Ea7oydBy
         Mhe/nRftwQjlB2duoy+en8HSznl7JrtzbkSY5voMAht12c9qlZ/hMf5uJ3gZV0Zp7Jpa
         smmT57JMGpJz6Sbo14GlM82MDSmzybooWd0QF9c8uND7j/0K65qJ8VHKBnegvNvUwUaH
         2Jh1NMjslbps6KTfxpkrmLR9tYnyD6jSO6mfXvRNC9YShuoJeGnCyOa8PlK4Pcz5pdnY
         EQMQ==
X-Gm-Message-State: APuU4Z9L2D65bUmVHSbez9YsbhLNROkFCy0VIgIT+TaZ0nYY7ozj3rUY
	mER2WT9mINuIV+43zi31zXudZlCyy8oELEc+t6CFqhMqqmMrEzKKK4ZX4U96QUBL8NyUw3wVlhm
	xaGSQS42tBghZt9CxvMR5koqKmQIINg==
X-Received: from ila11-n1.prod.google.com ([2002:a05:6e02:520b:10b0:51b:fd41:6806])
 (user=zhenwenliang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:4f4b:b0:571:9bab:e8b7 with SMTP id 5614622812f47-57a025e82f4mr15535524b6e.0.1795474358503;
 Mon, 23 Nov 2026 14:52:38 -0800 (PST)
Date: Mon, 23 Nov 2026 22:52:28 +0000
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Post: <mailto:autofs@vger.kernel.org>
List-Help: <mailto:autofs+help@vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:autofs+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123225228.1652446-1-zhenwenliang@google.com>
Subject: [PATCH] autofs: set wait queue status before releasing waiters
From: Zhenwen Liang <zhenwenliang@google.com>
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

autofs_wait() waits without a lock for wq->name.name to become NULL and
then reads wq->status:

	wait_event_killable(wq->queue, wq->name.name == NULL);
	status = wq->status;

autofs_wait_release() clears wq->name.name before it stores the status:

	wq->name.name = NULL;	/* Do not wait on this queue */
	wq->status = status;
	wake_up(&wq->queue);

wait_event_killable() tests the condition before it sleeps. A waiter
that gets there after wq->name.name was cleared but before wq->status
was stored does not sleep, and returns the initial status -EINTR even
though the daemon reported success. The lookup then fails with EINTR.
On weakly ordered CPUs nothing orders the two stores for the lockless
reader either.

Store the status first, publish wq->name.name = NULL with
smp_store_release(), and read it with smp_load_acquire() in
autofs_wait(). autofs_catatonic_mode_locked() already stores the status
first; use smp_store_release() there too.

Reproduced on v7.4-rc4 in QEMU with a debug-only patch, not part of
this change, that delays the waiter before its first check and delays
autofs_wait_release() between the two stores. A stat() that triggers a
mount failed with EINTR in 5 of 5 runs, although the daemon
answered AUTOFS_IOC_READY with status 0. With this patch stat()
succeeded in 5 of 5 runs. Without the delays (one control run)
we did not see the failure.

The problem was found with a Lean-based formal model of the code and
AI-assisted analysis. The patch and this description were written with
AI assistance; a human checked them against the source.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Zhenwen Liang <zhenwenliang@google.com>
---
autofs_wait_release() clears wq->name.name before it stores
wq->status (fs/autofs/waitq.c:518-519 in v7.4-rc4), while autofs_wait()
tests wq->name.name without a lock and then reads wq->status
(453-454). A waiter that checks in between does not sleep and returns
the initial -EINTR (line 413), although the daemon reported success.
The same order is in next-20261123 and the stable branches we checked
(5.10.y, 5.15.y, 6.1.y, 6.6.y, 6.12.y, 6.18.y, 7.3.y); it dates back
to fs/autofs4.

Effect: a path walk that triggers a mount fails with EINTR. Any
process can hit it by timing; no privilege boundary is involved.

Reproduced on v7.4-rc4 in QEMU (x86_64 TCG, 4 vCPUs) with a debug-only
patch that adds mdelay() before the waiter's first check and between
the two stores. A test program acts as the daemon (mounts a tmpfs,
answers AUTOFS_IOC_READY with status 0) while a child stat()s the
trigger path:

  v7.4-rc4 + delays:          stat() -> EINTR in 5 of 5 runs
  + this patch:               stat() OK in 5 of 5 runs
  no delays (1 control run):  stat() OK

Without the delays we did not see it, and we did not test a weakly
ordered architecture. The debug patch, test program and logs are
available on request.

syzbot's open "KCSAN: data-race in autofs_wait / autofs_wait"
(extid c6d286fd51860df64d9a) concerns the global token counter, not
these fields, as far as we can tell.

Found by a formal code verification tool under development (Lean-based),
with AI-assisted analysis; verified by the reproduction above and human
review. The patch and this text were written with AI assistance and
reviewed by a human. Point of contact: Zhenwen Liang
<zhenwenliang@google.com>.

A search of public list archives, git history and syzbot found no
earlier report. Related, different race: the pending patch "autofs:
serialize allocation of global wait queue tokens" (Zhu Jun,
2026-11-11).

 fs/autofs/waitq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/autofs/waitq.c b/fs/autofs/waitq.c
index 92c0bbbf452b..2496786a463e 100644
--- a/fs/autofs/waitq.c
+++ b/fs/autofs/waitq.c
@@ -29,7 +29,8 @@ static void autofs_catatonic_mode_locked(struct autofs_sb_info *sbi)
 		nwq = wq->next;
 		wq->status = -ENOENT; /* Magic is gone - report failure */
 		kfree(wq->name.name - wq->offset);
-		wq->name.name = NULL;
+		/* Pairs with smp_load_acquire() in autofs_wait() */
+		smp_store_release(&wq->name.name, NULL);
 		wake_up(&wq->queue);
 		if (!--wq->wait_ctr)
 			kfree(wq);
@@ -450,7 +451,8 @@ int autofs_wait(struct autofs_sb_info *sbi,
 	 * wq->name.name is NULL iff the lock is already released
 	 * or the mount has been made catatonic.
 	 */
-	wait_event_killable(wq->queue, wq->name.name == NULL);
+	/* Pairs with smp_store_release() in autofs_wait_release() */
+	wait_event_killable(wq->queue, !smp_load_acquire(&wq->name.name));
 	status = wq->status;
 
 	/*
@@ -515,8 +517,9 @@ int autofs_wait_release(struct autofs_sb_info *sbi,
 
 	*wql = wq->next;	/* Unlink from chain */
 	kfree(wq->name.name - wq->offset);
-	wq->name.name = NULL;	/* Do not wait on this queue */
 	wq->status = status;
+	/* Do not wait on this queue; pairs with autofs_wait() */
+	smp_store_release(&wq->name.name, NULL);
 	wake_up(&wq->queue);
 	if (!--wq->wait_ctr)
 		kfree(wq);
-- 
2.56.1.809.ga0b61035b5-goog

