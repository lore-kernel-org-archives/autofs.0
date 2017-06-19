From: Roland Hopferwieser <rhopfer@ica.jku.at>
Subject: [PATCH] Typo in man pages
Date: Mon, 19 Jun 2017 16:50:48 +0200
Message-ID: <ea0127fc-496d-56cf-71e8-4602c7570b23@ica.jku.at>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------B5714071DAB25F92608B9A46"
Return-path: <autofs-owner@vger.kernel.org>
Content-Language: de-AT
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: autofs@vger.kernel.org

This is a multi-part message in MIME format.
--------------B5714071DAB25F92608B9A46
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I found two typos in the man pages of autofs.5 and autofs.conf.5.in.

Best regards,
Roland

--------------B5714071DAB25F92608B9A46
Content-Type: text/x-patch;
 name="0001-Fix-man-typos.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Fix-man-typos.patch"

From 8b9f5eeee50a2c453b25fc8ab21c0d694be9783b Mon Sep 17 00:00:00 2001
From: Roland Hopferwieser <rhopfer@ica.jku.at>
Date: Mon, 19 Jun 2017 16:24:35 +0200
Subject: [PATCH] Fix man typos

---
 man/autofs.5         | 2 +-
 man/autofs.conf.5.in | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/man/autofs.5 b/man/autofs.5
index efde77a..0063fbe 100644
--- a/man/autofs.5
+++ b/man/autofs.5
@@ -447,7 +447,7 @@ This is the mount filesystem \fBtype\fP.
 It can have a value of
 .BR auto ", " link ", " linkx ", " host ", " lofs ", " ext2-4 ", "
 .BR xfs ", " nfs ", " nfsl " or " cdfs "."
-Other types that are not yet implemented or are not available iin autofs are
+Other types that are not yet implemented or are not available in autofs are
 .BR nfsx ", " lustre ", " jfs ", " program ", " cachefs " and " direct "."
 .TP
 .B maptype
diff --git a/man/autofs.conf.5.in b/man/autofs.conf.5.in
index a777c58..0efe0d4 100644
--- a/man/autofs.conf.5.in
+++ b/man/autofs.conf.5.in
@@ -1,5 +1,5 @@
 .\" t
-.TH AUTOFS.CONF "23 Jan 2014"
+.TH AUTOFS.CONF 5 "23 Jan 2014"
 .SH NAME
 autofs.conf \- autofs configuration
 .SH "DESCRIPTION"
-- 
2.13.1


--------------B5714071DAB25F92608B9A46--
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
