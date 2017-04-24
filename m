From: Ian Kent <raven@themaw.net>
Subject: [PATCH 23/34] autofs-5.1.2 - add the mount requestor's pid to
 pending_args
Date: Mon, 24 Apr 2017 09:02:11 +0800
Message-ID: <149299573134.23475.16771040787883202567.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=uY9hGD771ULkG0l5KM
        5UJHlbgRFtvnqfTJ5ewV46JEM=; b=PWbwhf5LjCvKB+SPW4fAO85Q0KBXf/ddr9
        s9uOLF03v0jFuVys5f38p8k54IKV7SnWX9jnZ1FXcUsRliq/A0sDbIGvYgNhXWe6
        /n0b43bZ4pA5gQn9vkXI8iAYWns2HAj4sXlchgMCKH0Qk8G6i3BxJkGAzMMBX5YX
        Lsno2vGzfgzjNSl/uxL5Fd+JGGXYLCTx0aMMDEeqM8qnbarVTDB2I5uKc6jh9eRL
        MQYZPUN1e9Q2Y/gAy5t4b0R+S3HJ7AJDNPAAcMQ4BLyZ61knehMExyolPKaNLtmV
        ihaduqwkHY+OuNlggL6Y6TxDy7PBGrtoacOS35T1Z3zujuUSREPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=uY9hGD771ULkG0l5KM5UJHlbgRFtvnqfTJ5ewV46JEM=; b=R9Ak1L56
        9MJVq0IqBe2qOyp9143iCwuY2WfshE44Ueq0VfK5me2KRROZZKhrrqEvXklzzwm5
        PxGJpreyaPYQ5AoPI4z4qREbxFxqDbuUFgSsA+BQnVbRp69YbrOpmcZD8qBw2Z0K
        BdsETYvaH52n8lGJlVnolv46ZRTDGlLihHrMuEEUswoTUJEqW7eOyFKypUUvTNCb
        HkZqMr4ri+F4i8RfVuAhIVtFhyQg5+NEc39SJRWUbtgqbB/tyhscrow8fv9w0aFd
        ObVhc3aptVD2Q30NSKzQ4071Xv582e+IOtpgueog4ix3Y5rsCHy6MLWX/BVvU6m0
        BZ5/wT6omwyuog==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

From: Lars R. Damerow <lars@pixar.com>

This will make it easier to log more information about the requesting
process as the mount request proceeds.

Signed-off-by: Lars R. Damerow <lars@pixar.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |    1 +
 daemon/direct.c     |    1 +
 daemon/indirect.c   |    1 +
 include/automount.h |    1 +
 4 files changed, 4 insertions(+)

diff --git a/CHANGELOG b/CHANGELOG
index a456146..cf9b62c 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -49,6 +49,7 @@ xx/xx/2016 autofs-5.1.3
 - handle amd cache option all in amd type auto mounts.
 - fix bogus check in expire_cleanup().
 - delay submount exit for amd submounts.
+- add the mount requestor's pid to pending_args.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/daemon/direct.c b/daemon/direct.c
index 7a8d309..33faaea 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -1462,6 +1462,7 @@ int handle_packet_missing_direct(struct autofs_point *ap, autofs_packet_missing_
 	mt->type = NFY_MOUNT;
 	mt->uid = pkt->uid;
 	mt->gid = pkt->gid;
+	mt->pid = pkt->pid;
 	mt->wait_queue_token = pkt->wait_queue_token;
 
 	status = pthread_create(&thid, &th_attr_detached, do_mount_direct, mt);
diff --git a/daemon/indirect.c b/daemon/indirect.c
index 72a23c3..0db2749 100644
--- a/daemon/indirect.c
+++ b/daemon/indirect.c
@@ -857,6 +857,7 @@ int handle_packet_missing_indirect(struct autofs_point *ap, autofs_packet_missin
 	mt->dev = pkt->dev;
 	mt->uid = pkt->uid;
 	mt->gid = pkt->gid;
+	mt->pid = pkt->pid;
 	mt->wait_queue_token = pkt->wait_queue_token;
 
 	status = pthread_create(&thid, &th_attr_detached, do_mount_indirect, mt);
diff --git a/include/automount.h b/include/automount.h
index 1d378c2..58c45a9 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -427,6 +427,7 @@ struct pending_args {
 	unsigned int len;		/* Name field len */
 	uid_t uid;			/* uid of requester */
 	gid_t gid;			/* gid of requester */
+	pid_t pid;			/* pid of requestor */
 	unsigned long wait_queue_token;	/* Associated kernel wait token */
 };
 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
