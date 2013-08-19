From: Ian Kent <raven@themaw.net>
Subject: [PATCH 24/25] autofs-5.0.7 - fix bad mkdir permission on create
Date: Mon, 19 Aug 2013 09:14:36 +0800
Message-ID: <20130819011435.6472.95050.stgit@perseus.fritz.box>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=f818EA4UaoC/NH5DMp1yuAL8kc8=; b=ZpW1V8ecTU80aDR0QADm32U+oMyK
	PYhwY0sQywGgi5vg8/TFuaowO4HXw+scocvcAwJbWiwgzxhEw1fr82RXj/ss7wPF
	6okqRIVyQD60vnWP510VrlRKTgVw+tq322N8l2QBH61dTo3eUQt6cHzFmchQO2DS
	kqY0HBWT22NFNyk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=f818EA4UaoC/NH5DMp1yuA
	L8kc8=; b=oO319Lhsnr9Xg2y/fo/JwOrieO6TXnrUyXuXep9+S3T+dlUGsqJeuc
	5fKIBpN+nbqUu3CtBtT/ZjxXgCy8rHqR5itNo7qDfwLlhr6MXFPG7frlrrZ7aPWl
	vRRaiZ6Zap+yOR1JD0oWBnyL+I+nvFC2cxrCtdLtGXSPkiSLm4rgM=
In-Reply-To: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>
Cc: Gordon Lack <gordon.m.lack@gsk.com>, "Lan Yixun (dlan)" <dennis.yxun@gmail.com>, Leonardo Chiquitto <leonardo.lists@gmail.com>, Dustin Polke <DuPol@gmx.de>

Reported by Gordon Lack (gordon[dot]m[dot]lack[at]gsk[dot]com).

If the automount daemon needs to create a directory (hierarchy) for an
automount and it is started up with a umask of 027 (or similar) then it
creates unusable directories (permission == 550).
---
 CHANGELOG          |    1 +
 daemon/automount.c |    5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index 2499f1c..3a3fec1 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -75,6 +75,7 @@
 - fix fix wildcard multi map regression.
 - improve timeout option description.
 - only probe specific nfs version if requested.
+- fix bad mkdir permission on create.
 
 25/07/2012 autofs-5.0.7
 =======================
diff --git a/daemon/automount.c b/daemon/automount.c
index 97c726a..6b55103 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -122,7 +122,10 @@ static int do_mkdir(const char *parent, const char *path, mode_t mode)
 		status = statfs(parent, &fs);
 	if ((status != -1 && fs.f_type == (__SWORD_TYPE) AUTOFS_SUPER_MAGIC) ||
 	    contained_in_local_fs(path)) {
-		if (mkdir(path, mode) == -1) {
+		int mask = umask(0022);
+		int ret = mkdir(path, mode);
+		void umask(mask);
+		if (ret == -1) {
 			errno = EACCES;
 			return 0;
 		}

