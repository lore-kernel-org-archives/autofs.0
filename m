From: Ian Kent <raven@themaw.net>
Subject: [PATCH 31/34] autofs-5.1.2 - fix invalid reference in
 remount_active_mount()
Date: Mon, 24 Apr 2017 09:02:52 +0800
Message-ID: <149299577250.23475.8944816081977802256.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=3hBma1OQRhqtvYqb0p
        4bGG6WcPDk77cFoVc+rOCCME4=; b=eQuqvxJAA86y7sRdFO4Hr9j3Lq/hPEFJA0
        L9PKVWRYy5TXj2d8PMEaAK9gWgFtxnvb8lfkmSDL5ItSUo9JTk/pkalu/XaTQMoi
        IpFpdK0MqQRyvlVNm420JL0/E68rPJgCfKev17G1zTAgZMMlsg2PjH7nd46IxEVf
        GFWva21ER1c9XPzxPDArPgep0h6FPMIfQZm8sUnnljDTJjQ8ONrGI6Dz+THc/FQP
        2i4FPYDi3RZdd+i7USWu1TSxJ/cIUTJmE4vZYAIZVNlzV9LCGoUo5vcC7Yh425jA
        7IvLfvjoVqmjRADClZdaZNStE5V/8BHvFk9aZKtoFswvH/PM3j6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=3hBma1OQRhqtvYqb0p4bGG6WcPDk77cFoVc+rOCCME4=; b=CdommZ/4
        XM5U+uWuH8N31OiNOp3uj8ohd8J0MCvNmCKoPKLJiLTq2km5QsGrs5tDJrqAtuQD
        jZnt7RFH4heK+YkSKPvIWzHlCYwSQaKAxJRV5Ql/uZPT1rSYRJ0UsobunY0Rz5R9
        rX6cDuCAAy3KQeFRzwVje3U02RfPDaxm4l64r9PjfEhEbS4qH37my4fw3i2V38iC
        dAPZYyKrbuHeMDRiH8l1MXR3STHG9dNd2ZcpSnBC6Jl9DETtRT225FoGaJcbxS2V
        PBIPSLhA4p4PSt22H33VT8DW6GpVnIafxAHc8pZxF8ZTb5fmYYOXiviIMoIgpDg+
        QgmAXETic4mBOQ==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

remount_active_mount() can be called with the map entry pointer NULL
so it must be checked before use when getting the automount timeout.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG    |    1 +
 lib/mounts.c |    6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 7700a20..b7c5a62 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -57,6 +57,7 @@ xx/xx/2016 autofs-5.1.3
 - use autofs_point to store expire timeout where possibe.
 - fix possible NULL derefernce.
 - fix work around sss startup delay.
+- fix invalid reference in remount_active_mount().
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/lib/mounts.c b/lib/mounts.c
index 22d653e..76ff006 100644
--- a/lib/mounts.c
+++ b/lib/mounts.c
@@ -1728,8 +1728,10 @@ static int remount_active_mount(struct autofs_point *ap,
 	if (fd == -1)
 		return REMOUNT_OPEN_FAIL;
 
-	error(ap->logopt, "ap->type %d type %u", ap->type, type);
-	timeout = get_exp_timeout(ap, me->source);
+	if (!me)
+		timeout = get_exp_timeout(ap, NULL);
+	else
+		timeout = get_exp_timeout(ap, me->source);
 
 	/* Re-reading the map, set timeout and return */
 	if (ap->state == ST_READMAP) {

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
