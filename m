From: Ian Kent <raven@themaw.net>
Subject: [PATCH 34/34] autofs-5.1.2 - increase worker thread per-thread
 stack size
Date: Mon, 24 Apr 2017 09:03:07 +0800
Message-ID: <149299578790.23475.6749618979232753510.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=PWJDHQumZGCC2yG24G
        ZoLQjTedlfVP2lMCojrOST6z0=; b=mHbWuhjuEeU97jebbktNQbxtpl+cmCpM62
        RLAxNiz8AEFOOycQwnS4yB4Gfn4hNf9clXb/jb6ie9uXpp0Inp60kfuBEuHgI/Mu
        xT2RDEXWlXL3c9HRAxmARlEyzVBX1xA3le14GWVCKISCfCiWAkUGTk8tWbs1s9Rr
        xXC5E2QljOpfGGWuVfVoEPhS30yeuBR86DZzZZRZ3MZqj0lD4KEmwdDH84WUPUsg
        HpoW6ZW5F4jKJstiLGx1eh9PET3RQxJ+MKzrpUxfsiYGKCFqkXdH/rfc6EF4SRsr
        /UmRdoQrUy6KyMcimJdhkDvUvMXkBAhQ3xolNG0iyZJ00vQTwibw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=PWJDHQumZGCC2yG24GZoLQjTedlfVP2lMCojrOST6z0=; b=CdckNgya
        4Qw0a2wYaVSYXth4RolHNya3L13PuhhywV+33oL3bGS4E/qPd8UvzI2zMhJHzJD0
        kRK6TkcGPdQD016nYGwRr5qOUpg78b/0BhH2ZtnGGnz7S7t0dC0UHMmYgwEjVsGZ
        2tohtJYq7u7jHUrONhVvAV7MOzmnAeObooHn3MLy2KH+vnmwYgEYpOw/j3IlFc7P
        5zvHt+uRWCinQkmT0pHf/hgcyffE8NwGL2Mqj++1xgCtxc0mPOf2WOroIJ0vP9Sr
        rzpPflK5D8r5Y5A6b2DohiVdCLvcsI4F0ZlHwXRUf+fL3+5vcbumdZRd9G/xeTjy
        jvBdFmuNMqs7Tg==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

automount(8) uses a worker thread per-thread stack size of 1M which is
sufficient for its needs.

But some glibc functions (such as nscd_getgr_r()) use alloca() to allocate
working storage that can have an arbitary size. Since alloca() never fails
there is no way to check for stack overflow so I think this usage is wrong
and needs to be fixed.

All that can be done by automount to avoid this is to increase the stack size.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG          |    1 +
 daemon/automount.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index 46487f1..a2a22ce 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -60,6 +60,7 @@ xx/xx/2016 autofs-5.1.3
 - fix invalid reference in remount_active_mount().
 - use malloc for expanded map location.
 - fix offset mount location multiple expansion.
+- increase worker thread per-thread stack size.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/daemon/automount.c b/daemon/automount.c
index d27804d..109f8f9 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -2476,7 +2476,7 @@ int main(int argc, char *argv[])
 
 #ifdef _POSIX_THREAD_ATTR_STACKSIZE
 	if (pthread_attr_setstacksize(
-			&th_attr_detached, PTHREAD_STACK_MIN*64)) {
+			&th_attr_detached, PTHREAD_STACK_MIN*128)) {
 		logerr("%s: failed to set stack size thread attribute!",
 		       program);
 		res = write(start_pipefd[1], pst_stat, sizeof(*pst_stat));

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
