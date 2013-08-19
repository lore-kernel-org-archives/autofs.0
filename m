From: Ian Kent <raven@themaw.net>
Subject: [PATCH 20/25] autofs-5.0.7 - fix syncronize handle_mounts() shutdown
Date: Mon, 19 Aug 2013 09:14:09 +0800
Message-ID: <20130819011408.6472.58715.stgit@perseus.fritz.box>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=ntMUfdPV42KyL1bbSEJu2WvfD9c=; b=s3G74qj/E/WW8t8kwktzmyrEg0PI
	dCYGafq8LM9eo3ECacyNLwZvna7K0zmNz/XBwoTPPoqlMuhLCKq7dAKmQF6hGBuv
	cAqJW2cOfxjfki5I4aYfqFUP+7BrtJApf5OyuLI3S4opSSiw2leUuIYdPO5KbGM3
	WrpKFj01C46Q0C4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=ntMUfdPV42KyL1bbSEJu2W
	vfD9c=; b=uOcPfa2+/6ISRdYDpmihh799dvXpTDziLxxiu1BPaXzpQZWgn+PzsM
	Sr5BoaoUskF7bkKen5X44dzZ6TiRgAvjVE8/TVGcWh8wSkDB3OnXiBzaeueeXP76
	sOPoqDCNg2cfXltTmjO35XTo2AMwf6qXjEZhQiDlP2bGQDyTntV38=
In-Reply-To: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>
Cc: Gordon Lack <gordon.m.lack@gsk.com>, "Lan Yixun (dlan)" <dennis.yxun@gmail.com>, Leonardo Chiquitto <leonardo.lists@gmail.com>, Dustin Polke <DuPol@gmx.de>

A recent change to fix a problem where automount would exit when re-reading
the master map if more than on entry had been removed causes automount to
ignore HUP signals if the mount list is empty.

Removing that check and testing shows that the remainder of the change still
fixes the original problem.
---
 CHANGELOG          |    1 +
 daemon/automount.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index 07f9d6d..618ac20 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -71,6 +71,7 @@
 - fix dumpmaps multi output.
 - try and cleanup after dumpmaps.
 - teach dumpmaps to output simple key value pairs.
+- fix syncronize handle_mounts() shutdown.
 
 25/07/2012 autofs-5.0.7
 =======================
diff --git a/daemon/automount.c b/daemon/automount.c
index 2ce49bf..97c726a 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -1286,7 +1286,7 @@ static int do_hup_signal(struct master *master, time_t age)
 
 	master_mutex_lock();
 	/* Already doing a map read or shutdown or no mounts */
-	if (master->reading || list_empty(&master->mounts)) {
+	if (master->reading) {
 		status = pthread_mutex_unlock(&mrc.mutex);
 		if (status)
 			fatal(status);

