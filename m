Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEA117A300;
	Sun, 17 Aug 2025 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755448575; cv=none; b=LC3PcOav81Ng61cxdiv0hTwvCK4iqe4Or4YLY3dfurJ3GWHjbbPQcVTiqJ3py5NMQQ/5Ur0QeHdv9vMphbisStIM6mTZIW+nixgFtyQL4SwVNY7SfdN3vwVjmOz5rKOQ5OjRwKUDHLfDj8i+obcxFDQQRfrszAKLVGH1Ovw975o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755448575; c=relaxed/simple;
	bh=KWKyh+PWREwfE+iJsNNYM5S/hEnOubik1nCWKGv1aWo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jUauFemdY01A1wFTatw9Cj5jETcErlCjSm6ZXWWvFhVzeHAykB/183Dx6Lg3ZIowfd47JbLAJK4nBbuAkuzgcbV7I6rbNcUshsxCuasuJ6q0Cuf/qlcOWP/dPJsK2ANR6EKHtQ9NfaVn6lhP09enqDSxwbsA/jV0+Vuf2EwHD6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=eufSvQXS; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="eufSvQXS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=NF/IsYoUxdPcfkDWAm1JlMP4KPpxu1RMtXsPpwWb/VE=; b=eufSvQXS0XYkkTEmpol94RAcP4
	qF1b+NWv4OK7crMLqFhJsjXI0S71hwu7Gduv8y26nek3uOtSYPI7J9tWtsfPDcHnShBEznteGVtN/
	a8aO7urUZkHxdvvLSlE1M0mz7blXTVJ6Fvk66UaDR7mlS+OoGpFqsTozuazeDECVqfc9Kx3Qkcs6h
	ot8uORfjTnWYET3BI62n6DmpGOvEDqxUxnpVLJcdEukH5E+c5dbLEycPTK5/DApkWwBQ0gX3Nasz0
	4sPqI1MvfczIekY7pHrR7KftkiFKX8MA+PXlVG5jechcgKkWbl1u+mXrd+Nc6lPJFSxYRV4gGYw0n
	cSXHRb0w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ungMb-0000000Af1i-2Vjs;
	Sun, 17 Aug 2025 16:36:09 +0000
Date: Sun, 17 Aug 2025 17:36:09 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ian Kent <raven@themaw.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, autofs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spin_lock_irqsave() in autofs_write() is bogus
Message-ID: <20250817163609.GV222315@ZenIV>
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	That function should never be (and never is) called with irqs
disabled - we have an explicit mutex_lock() in there, if nothing else.
Which makes spin_lock_irqsave() use in there pointless - we do need to
disable irqs for ->siglock, but that should be spin_lock_irq().

	The history is interesting - it goes all way back to 2.1.68pre1,
and that obviously was a tree-wide work.  Might be interesting to look
for other places with just-in-case spin_lock_irqsave()...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/autofs/waitq.c b/fs/autofs/waitq.c
index 33dd4660d82f..4dc226e86360 100644
--- a/fs/autofs/waitq.c
+++ b/fs/autofs/waitq.c
@@ -46,7 +46,7 @@ void autofs_catatonic_mode(struct autofs_sb_info *sbi)
 static int autofs_write(struct autofs_sb_info *sbi,
 			struct file *file, const void *addr, int bytes)
 {
-	unsigned long sigpipe, flags;
+	unsigned long sigpipe;
 	const char *data = (const char *)addr;
 	ssize_t wr = 0;
 
@@ -66,10 +66,10 @@ static int autofs_write(struct autofs_sb_info *sbi,
 	 * SIGPIPE unless it was already supposed to get one
 	 */
 	if (wr == -EPIPE && !sigpipe) {
-		spin_lock_irqsave(&current->sighand->siglock, flags);
+		spin_lock_irq(&current->sighand->siglock);
 		sigdelset(&current->pending.signal, SIGPIPE);
 		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sighand->siglock, flags);
+		spin_unlock_irq(&current->sighand->siglock);
 	}
 
 	/* if 'wr' returned 0 (impossible) we assume -EIO (safe) */
