From: Michael Kerrisk <mtk.manpages@gmail.com>
Subject: fstatat() AT_NO_AUTOMOUNT man page documentation
Date: Mon, 19 Sep 2011 07:56:12 +0200
Message-ID: <CAKgNAkgOvrNtz+JjXTqzOsH6wQBpQ2AAAG2kBGcCVzObYK=btg@mail.gmail.com>
Reply-To: mtk.manpages@gmail.com
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc
         :content-type;
        bh=AJUySavuHOi1JW8NOx6LMyqNNHPbozNWJ2DQtiml3Rc=;
        b=pzPJanEB+f5Mo/ck7zH9rssh2juD2v5OBrGeyCJRziDC+VKEun+i2lMP7OM9L5fXlE
         Tc5K84aqmrw3E4Y4rvMB0ZSC2PJnMNMKKtTIzvMKKgVbZZiBFWX72XsQVplBMMVaUKrI
         8BRY0xJxBudypq7VGRQ/TaOePP6Xe3mc0U4ac=
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: Ian Kent <raven@themaw.net>, npiggin@kernel.dk, linux-man <linux-man@vger.kernel.org>, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

Hi David,

I've written the following patch for AT__NO_AUTOMOUNT, which you added
to the kernel a while back. Could you please review and ACK/NAK?

Thanks,

Michael


diff --git a/man2/fstatat.2 b/man2/fstatat.2
index 2868bfb..c0d97dd 100644
--- a/man2/fstatat.2
+++ b/man2/fstatat.2
@@ -91,7 +89,16 @@ is absolute, then
 is ignored.

 .I flags
-can either be 0, or include the following flag:
+can either be 0, or include one or more of the following flags ORed:
+.TP
+.BR AT_NO_AUTOMOUNT " (since Linux 2.6.38)"
+Don't automount the terminal ("basename") component of
+.I pathname
+if it is a directory that is an automount point.
+This allows the caller to gather attributes of an automount point
+(rather than the location it would mount).
+This flag can be used in tools that scan directories
+to prevent mass-automounting of a directory of automount points.
 .TP
 .B AT_SYMLINK_NOFOLLOW
 If

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Author of "The Linux Programming Interface"; http://man7.org/tlpi/
