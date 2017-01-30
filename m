From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/7] autofs: fix typo in Documentation
Date: Mon, 30 Jan 2017 18:20:46 +0800
Message-ID: <148577164606.9801.12571810310561599401.stgit@pluto.themaw.net>
References: <148577164094.9801.4775075118014742496.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=VAHaVJd2fB2kbo1
        utrzX3f319vA=; b=S4YndjPQFxvyoZmLr5BGumqDhhUIFThRzwcJ3Y+26Jrveow
        IA2Aay4aACgdqQ/Uwp4dzUjiHba80fHxLMot5QdVlElq8bs8LpE2uCm3HnIftthL
        QN8CusBNbYR3c6UiqUbk8aRZtKMKf38yS8rWW8G2U5fwFAQvV0RaZTjuGyeg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        smtpout; bh=VAHaVJd2fB2kbo1utrzX3f319vA=; b=PifTCt7KhRJvMzwJSnQ3
        iidsxeMZF4Oi0CrWDrHvv+rJuHpp83J5B5IJTSBYYbrCQRW/7QKG1XpujO+GnsKu
        IEX3LSQD1/4q360mh6Q5yUmV10zlFJAjZ/vhO94x/2cwx3Y0VdXjlgYUSPO3v6lr
        XM1E/jl2dQY6MlFTYT3S+5A=
In-Reply-To: <148577164094.9801.4775075118014742496.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Tomohiro Kusumi <tkusumi@tuxera.com>

Signed-off-by: Tomohiro Kusumi <tkusumi@tuxera.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 Documentation/filesystems/autofs4.txt |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/autofs4.txt b/Documentation/filesystems/autofs4.txt
index 8fac3fe..a5dc56f 100644
--- a/Documentation/filesystems/autofs4.txt
+++ b/Documentation/filesystems/autofs4.txt
@@ -65,7 +65,7 @@ directory is a mount trap only if the filesystem is mounted *direct*
 and the root is empty.
 
 Directories created in the root directory are mount traps only if the
-filesystem is mounted  *indirect* and they are empty.
+filesystem is mounted *indirect* and they are empty.
 
 Directories further down the tree depend on the *maxproto* mount
 option and particularly whether it is less than five or not.
@@ -352,7 +352,7 @@ Communicating with autofs: root directory ioctls
 ------------------------------------------------
 
 The root directory of an autofs filesystem will respond to a number of
-ioctls.   The process issuing the ioctl must have the CAP_SYS_ADMIN
+ioctls.  The process issuing the ioctl must have the CAP_SYS_ADMIN
 capability, or must be the automount daemon.
 
 The available ioctl commands are:
@@ -512,7 +512,7 @@ always be mounted "shared". e.g.
 
 > `mount --make-shared /autofs/mount/point`
 
-The automount daemon is only able to mange a single mount location for
+The automount daemon is only able to manage a single mount location for
 an autofs filesystem and if mounts on that are not 'shared', other
 locations will not behave as expected.  In particular access to those
 other locations will likely result in the `ELOOP` error

