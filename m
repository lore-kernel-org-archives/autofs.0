From: Ian Kent <raven@themaw.net>
Subject: [PATCH 03/34] autofs-5.1.2 - set sane default master read wait
 timeout
Date: Mon, 24 Apr 2017 09:00:28 +0800
Message-ID: <149299562852.23475.8419202329550494609.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=Ql8eMDFg1wgFcTuOVn
        V7EoKIFkcg+97xEl/cT3CJm48=; b=XPSNqAa0UrPOpJI63GwKntHNQIkTqIQq0/
        Un9T7x4a+svalHPdvNVQFcu+Y47FHTzxnfb2SKHZZ7rc0EjEP7cJ0mI0CnyggPkL
        fegMHhyehlb/3P3qcJu32aoLVnHv1taQU+0bQjfoBH1apjjdMcIQk1gGGOhRVxQx
        vj19XGYdWT/qKyMZmJe81EPqIwb6Hr+0fKX61sIurZedh6Q2JNon4A+UkxdtFnJ6
        AmO8rOm8MEcoX9aulvgAIeQ9ueOGk0MdAWl8LMy3dgqMEynYcSjUFRn1DQ1mcsmj
        MQgUMeh4Cg9zm7Ci27g4hKsTfZSjGNGb4j8jD7qQOXn9esfVEOyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=Ql8eMDFg1wgFcTuOVnV7EoKIFkcg+97xEl/cT3CJm48=; b=nxlHdFkR
        1iiTAQMsE0tOwEqS30K16TEWhHmPnObTLnVysZWVRivJA3vULh7nxV1uX0rGE7XS
        hv2eCWuwIKDTBp1i+ICrIE51SvdJtM9qqk4nmS9quir4GnTmNz5pagfeIt80IRxI
        CNoeALzXLnFU0JSoCrEVcn2O/I/4sRYHl8sCppq2L7XTN5uqp6898TdgfYhG8er6
        nmcZJnfnimBUKiO7dUrwHy9Eb2ccXeF7J8kEmws+Qmh4D91OhRrXYAtLCRndIqpG
        +HlmfJpBkQtCNffvJqdnXHWkTodHD9CiBiDNruG79NJEE4QNhdBUR7Mx3XYkYCDg
        ydWeOhCMPAK77A==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

If an unused map source is configured in nss, with the default
of waiting indefinitely, autofs will not start.

To restore the previous behaviour of this case set a sensible
default timeout for the configuration option master_wait.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG                      |    1 +
 include/defaults.h             |    2 +-
 man/autofs.conf.5.in           |    4 ++--
 redhat/autofs.conf.default.in  |    6 +++---
 samples/autofs.conf.default.in |    6 +++---
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 85b1480..92a6ea9 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -29,6 +29,7 @@ xx/xx/2016 autofs-5.1.3
 - fix quoted key handling in sanitize_path().
 - fix included master map not found return.
 - dont exit on master map read fail timeout.
+- set sane default master read wait timeout.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/include/defaults.h b/include/defaults.h
index 1dea48c..b93fda3 100644
--- a/include/defaults.h
+++ b/include/defaults.h
@@ -25,7 +25,7 @@
 #define DEFAULT_MASTER_MAP_NAME	"auto.master"
 
 #define DEFAULT_TIMEOUT			"600"
-#define DEFAULT_MASTER_WAIT		"-1"
+#define DEFAULT_MASTER_WAIT		"10"
 #define DEFAULT_NEGATIVE_TIMEOUT	"60"
 #define DEFAULT_MOUNT_WAIT		"-1"
 #define DEFAULT_UMOUNT_WAIT		"12"
diff --git a/man/autofs.conf.5.in b/man/autofs.conf.5.in
index 93ff7af..a9a08f9 100644
--- a/man/autofs.conf.5.in
+++ b/man/autofs.conf.5.in
@@ -32,8 +32,8 @@ with earlier autofs releases.
 .TP
 .B master_wait
 sets the default maximum time to wait for the master map to become
-available if it cannot be read at program start (program default -1,
-wait forever).
+available if it cannot be read at program start (program default 10,
+wait for 10 seconds then continue).
 .TP
 .B negative_timeout
 .br
diff --git a/redhat/autofs.conf.default.in b/redhat/autofs.conf.default.in
index 9bceab3..c7e4d97 100644
--- a/redhat/autofs.conf.default.in
+++ b/redhat/autofs.conf.default.in
@@ -16,10 +16,10 @@ timeout = 300
 #
 # master_wait - set the default maximum time to wait for the
 # 		master map to become available if it cannot
-# 		be read at program start (default -1, wait
-# 		forever).
+# 		be read at program start (default 10, wait
+# 		for 10 seconds then continue).
 #
-#master_wait = -1
+#master_wait = 10
 #
 # negative_timeout - set the default negative timeout for
 # 		     failed mount attempts (default 60).
diff --git a/samples/autofs.conf.default.in b/samples/autofs.conf.default.in
index a275e08..d52ad85 100644
--- a/samples/autofs.conf.default.in
+++ b/samples/autofs.conf.default.in
@@ -16,10 +16,10 @@ timeout = 300
 #
 # master_wait - set the default maximum time to wait for the
 # 		master map to become available if it cannot
-# 		be read at program start (default -1, wait
-# 		forever).
+# 		be read at program start (default 10, wait
+# 		for 10 seconds then continue).
 #
-# master_wait = -1
+# master_wait = 10
 #
 # negative_timeout - set the default negative timeout for
 # 		     failed mount attempts (default 60).

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
