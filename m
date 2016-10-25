From: Ian Kent <raven@themaw.net>
Subject: [PATCH 07/37] autofs-5.1.2 - Fix a typo in CREDITS
Date: Tue, 25 Oct 2016 09:18:02 +0800
Message-ID: <20161025011802.7778.21120.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=HWD63JCpVfjMKgGslnCtDkexX6w=; b=YHd/r8IJBzJFm5EQbI
        H/7ZfsfrRKCKVORdOE58j3q8q0fSbcZLFx2U6YBg0c4QFSri6cb6UgRZ1unydCox
        dxiiTF9PWFgxMUdONL7g/9Ad5pFuaaZOdrkkG/oQd4tbphXs18U4NK9XxeDaJtFi
        jMizUAGl7X0Sq6vJWnKeWjCxs=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=HWD63JCpVfjMKgGslnCtDk
        exX6w=; b=M4ncNWOjo/w1eEQp/13ny17IpPEkRHDbeK4A/Xou7GAGPO7nn/hMFY
        RhOPNI9d7wZm91t1E/EGdeRwFQgdvOFhUwmW3E16jSp+/UBwKClgVcfEB9J0KK5A
        /yV/WK0wAidly0M4RjlOltq6HHCDAIKi+vI2zQ8eoW5fGqvpUfnjo=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

Fix a typo in a contributor's name.
Two other parts of this file says "Aaron".

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Signed-off-by: Ian Kent <ikent@redhat.com>
---
 CHANGELOG |    1 +
 CREDITS   |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index 9291c20..96260b7 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -6,6 +6,7 @@ xx/xx/2016 autofs-5.1.3
 - drop redundant \n in logerr().
 - Fix size arg of fgets(3).
 - fix libtirpc detection with -Wl,--as-needed.
+- Fix a typo in CREDITS.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/CREDITS b/CREDITS
index 8d5057a..a931de1 100644
--- a/CREDITS
+++ b/CREDITS
@@ -2,7 +2,7 @@
 CREDITS
 =======
 
-Arron Ogden
+Aaron Ogden
 -----------
 
 While other people have contributed to autofs in various ways

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
