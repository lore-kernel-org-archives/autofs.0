From: Ian Kent <raven@themaw.net>
Subject: [PATCH 17/37] autofs-5.1.2 - fix typo in MOUNT_FLAG_GHOST comment
Date: Tue, 25 Oct 2016 09:18:55 +0800
Message-ID: <20161025011855.7778.61904.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=lm+cj/Jscl00yITHKIhv6O4qrP0=; b=faqkarJMM9I0kr2Moh
        yoMp+dhNaorEfULhnrUPRThNima3a65bNpFAzLZPVnnkRgY2DoZYMx5Su0c/i1BD
        brzChccYuUTYQJgZygftRoH1GgWO6kLE8PF90eM0ifOILfw8VuO0e40BUHoQvHyl
        XBJQKVDYpATd+mDYkTs56BT80=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=lm+cj/Jscl00yITHKIhv6O
        4qrP0=; b=U3tfKJyCNMZtSFwtYrEhfelZEmm4R5NYew+kOydF5YL3/BsOV0YeWq
        jPfJTedprg1uzHwzFsyN1DNAHGa5Uj7ZPFNQwNhbYTICjJZ1EemD+nX0ovessxkQ
        OROS1/vJwFjSBts5czCm9h/TXlY6hU343ij+PuPGGh0my50xulcHo=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Signed-off-by: Ian Kent <raven@themaw.net>
---
 include/automount.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/automount.h b/include/automount.h
index 2029e3d..f643f84 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -507,7 +507,7 @@ struct kernel_mod_version {
 	unsigned int minor;
 };
 
-/* Enable/disable gohsted directories */
+/* Enable/disable ghosted directories */
 #define MOUNT_FLAG_GHOST		0x0001
 
 /* Directory created for this mount? */

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
