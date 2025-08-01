Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEC22561D4
	for <autofs@vger.kernel.org>; Fri,  1 Aug 2025 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754061759; cv=none; b=QJXOUMUPHh9nbXFjbtOdAfmDH6KUMi905XStvv9MsLs/yHHMHO45q1J8GkDM9f+QI5iAkaPaeGecG/ciw0Vs5CvtpT7+XWWGlahu0R3mskqcFrO2hb2IozEOIhL1P5Hy7rZjnqn31WmY1+gd9SrnGokZAj1fICFVhfILgL2CXIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754061759; c=relaxed/simple;
	bh=0EvDcUkqlziI6dH6W5+/KWvQgncmpbXDh3hsA/o4KlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V1tYPPPv5BcqVul4NzxafXFSvh2aoBJJMpZ46y7Q5yjFTAp+JfWmVolunofNqQAtyuWmyLks3+Lt3ABR+6DQFiFTbUiw4fLnfzVNp8IWXT31nklwdLC+xU1tuXS3ncO4xUgrcNLjBa8tkA+cnZdWkJC/EAoulyOVZLSNuXPUfPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=syy9utP5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xcC2rEI1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=syy9utP5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xcC2rEI1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="syy9utP5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xcC2rEI1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="syy9utP5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xcC2rEI1"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D6C081FDBF;
	Fri,  1 Aug 2025 15:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754061754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1eLEb6sHvELBuP60S0ulBdmslMs0A9y6EBOnk8SWJyY=;
	b=syy9utP5VxidFVFUvlwtkmqBuXA3Dgkuxm/FqjEy/QwxyiVLn6SbGC9IPEdInZrHLUx/q4
	6cWuuP47zmFvXx2ekYuYYfjt6K7DMAXySknXNrlkQ+qTpqvwBpDNbpe2r011jhvp5GI/YF
	S4rZaYKLtFtVNoVYnH2bNnssRCNhsb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754061754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1eLEb6sHvELBuP60S0ulBdmslMs0A9y6EBOnk8SWJyY=;
	b=xcC2rEI1RNuZid22E7obIAv4+JDK4P4wvZEzuFBRhe/01gpOMWF5ED2CZPz8BvCm0gyjoe
	PdCLoB3sJgZvFuDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754061754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1eLEb6sHvELBuP60S0ulBdmslMs0A9y6EBOnk8SWJyY=;
	b=syy9utP5VxidFVFUvlwtkmqBuXA3Dgkuxm/FqjEy/QwxyiVLn6SbGC9IPEdInZrHLUx/q4
	6cWuuP47zmFvXx2ekYuYYfjt6K7DMAXySknXNrlkQ+qTpqvwBpDNbpe2r011jhvp5GI/YF
	S4rZaYKLtFtVNoVYnH2bNnssRCNhsb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754061754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1eLEb6sHvELBuP60S0ulBdmslMs0A9y6EBOnk8SWJyY=;
	b=xcC2rEI1RNuZid22E7obIAv4+JDK4P4wvZEzuFBRhe/01gpOMWF5ED2CZPz8BvCm0gyjoe
	PdCLoB3sJgZvFuDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AEA1A13876;
	Fri,  1 Aug 2025 15:22:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BrYjKbrbjGglLwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Fri, 01 Aug 2025 15:22:34 +0000
From: David Disseldorp <ddiss@suse.de>
To: autofs@vger.kernel.org
Cc: David Disseldorp <ddiss@suse.de>
Subject: [PATCH] RFC: autofs-5.1.9 - flag removed entries as stale
Date: Sat,  2 Aug 2025 01:22:11 +1000
Message-ID: <20250801152210.15501-2-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

This effectively reverts commit 21ce28d ("autofs-5.1.4 - mark removed
cache entry negative"), which causes the kernel to stall in autofs_wait
for the following workload:

  cat > /etc/auto.direct <<EOF
  echo "/nfs/share  $mount_args ${NFS_SERVER}:/${NFS_SHARE}"
  EOF

  setsid --fork automount --debug --foreground &> /automount.log
  sleep 1

  touch /test.run
  setsid --fork /bin/bash -c \
    "while [[ -f /test.run ]]; do df -ia >> /test.log; sleep 1; done"
  echo "df loop logging to /test.log"

  sleep 2
  echo "changing and reloading auto.direct"
  echo > /etc/auto.direct
  killall -HUP automount

  sleep 2
  echo "unmounting..."
  umount /nfs/share || echo "umount failed"

The current behaviour sees us hit:
  handle_packet_missing_direct:1352: can't find map entry for ()
...which doesn't respond to the kernel, triggering the stall.

This approach adds a new MOUNT_FLAG_STALE flag to track removed map
entries. While keeping enough state around to respond for the
handle_packet_missing_direct case.

RFC:
- needs further testing (e.g. indirect maps)
- I'm not familiar with the codebase so this may be the wrong approach
- we may need a background job to purge MOUNT_FLAG_STALE entries?

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 daemon/direct.c     |  8 ++++++--
 daemon/indirect.c   |  8 ++++++--
 daemon/lookup.c     | 11 ++++-------
 include/automount.h |  3 +++
 4 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/daemon/direct.c b/daemon/direct.c
index 42baac8..5e78c40 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -1389,8 +1389,12 @@ int handle_packet_missing_direct(struct autofs_point *ap, autofs_packet_missing_
 		return 0;
 	}
 
-	/* Check if we recorded a mount fail for this key */
-	if (me->status >= monotonic_time(NULL)) {
+	/*
+	 * Check if we recorded a mount fail for this key, or the entry has
+	 * been removed.
+	 */
+	if (me->status >= monotonic_time(NULL) ||
+	    me->flags & MOUNT_FLAG_STALE) {
 		ops->send_fail(ap->logopt,
 			       ioctlfd, pkt->wait_queue_token, -ENOENT);
 		ops->close(ap->logopt, ioctlfd);
diff --git a/daemon/indirect.c b/daemon/indirect.c
index 7d4aad7..934bb74 100644
--- a/daemon/indirect.c
+++ b/daemon/indirect.c
@@ -798,8 +798,12 @@ int handle_packet_missing_indirect(struct autofs_point *ap, autofs_packet_missin
 
 	me = lookup_source_mapent(ap, pkt->name, LKP_DISTINCT);
 	if (me) {
-		/* Check if we recorded a mount fail for this key */
-		if (me->status >= monotonic_time(NULL)) {
+		/*
+		 * Check if we recorded a mount fail for this key, or the entry
+		 * has been removed.
+		 */
+		if (me->status >= monotonic_time(NULL) ||
+		    me->flags & MOUNT_FLAG_STALE) {
 			ops->send_fail(ap->logopt, ap->ioctlfd,
 				       pkt->wait_queue_token, -ENOENT);
 			cache_unlock(me->mc);
diff --git a/daemon/lookup.c b/daemon/lookup.c
index dc77948..ad0b460 100644
--- a/daemon/lookup.c
+++ b/daemon/lookup.c
@@ -1416,15 +1416,12 @@ void lookup_prune_one_cache(struct autofs_point *ap, struct mapent_cache *mc, ti
 		if (valid && valid->mc == mc) {
 			 /*
 			  * We've found a map entry that has been removed from
-			  * the current cache so it isn't really valid. Set the
-			  * mapent negative to prevent further mount requests
+			  * the current cache so it isn't really valid. Flag the
+			  * mapent stale to prevent further mount requests
 			  * using the cache entry.
 			  */
-			debug(ap->logopt, "removed map entry detected, mark negative");
-			if (valid->mapent) {
-				free(valid->mapent);
-				valid->mapent = NULL;
-			}
+			debug(ap->logopt, "removed map entry detected, mark stale");
+			valid->flags |= MOUNT_FLAG_STALE;
 			cache_unlock(valid->mc);
 			valid = NULL;
 		}
diff --git a/include/automount.h b/include/automount.h
index 9548db8..007d020 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -548,6 +548,9 @@ struct kernel_mod_version {
 /* Indicator for applications to ignore the mount entry */
 #define MOUNT_FLAG_IGNORE		0x1000
 
+/* map has been removed, but we can't clean up yet */
+#define MOUNT_FLAG_STALE		0x2000
+
 struct autofs_point {
 	pthread_t thid;
 	char *path;			/* Mount point name */
-- 
2.43.0

