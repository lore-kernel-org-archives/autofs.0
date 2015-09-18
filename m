From: Ian Kent <raven@themaw.net>
Subject: [PATCH v5 8/8] autofs-5.1.1 - remove unused function elapsed()
Date: Fri, 18 Sep 2015 17:35:17 +0800
Message-ID: <20150918093516.29311.58158.stgit@pluto.fritz.box>
References: <20150918092704.29311.84246.stgit@pluto.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=aLvnNhBXB3qf0Dl0XSUegfCc6Tg=; b=pEjK6b
	TNMsihowo/l91x4nYfNXyEVOyqdikG8JltE5n23NK3EFdhgfqxZ1POPUsXyNEyzu
	J8xvG0OywdKQT51+7jOykeJJ0iW8NDkNQihDZFX+ox8xdBXvO7efsa431h+XX3nG
	Cd26LtfcSqehl/8dKMU5BWbjqpsNYLyeCHArc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=aLvnNhBXB3qf0Dl
	0XSUegfCc6Tg=; b=ONDAC8hwrJ6mxrCFoBRhKve0UupDZODvnmfQg6CnvPDKFz9
	k2qsvZJGYz0gFodnOH58JAtDpxXD0Ly11676mu5u7QkCNnE7uQgmOUDP0iie3cKx
	AcI5QeMMhFfKsrelIpWMrbu3V4aHHWR7vTt25vHryv2gqf4+WeNfcihUU358=
In-Reply-To: <20150918092704.29311.84246.stgit@pluto.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Yu Ning <ning.yu@ubuntu.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

Now that the monotonic clock source is used the elapsed() function
is no longer used, remove it.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 lib/rpc_subs.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c
index 2364744..3d99f56 100644
--- a/lib/rpc_subs.c
+++ b/lib/rpc_subs.c
@@ -1078,14 +1078,6 @@ int rpc_ping(const char *host, long seconds, long micros, unsigned int option)
 	return status;
 }
 
-double elapsed(struct timeval start, struct timeval end)
-{
-	double t1, t2;
-	t1 =  (double)start.tv_sec + (double)start.tv_usec/(1000*1000);
-	t2 =  (double)end.tv_sec + (double)end.tv_usec/(1000*1000);
-	return t2-t1;
-}
-
 double monotonic_elapsed(struct timespec start, struct timespec end)
 {
 	double t1, t2;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
