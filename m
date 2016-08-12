From: Ian Kent <raven@themaw.net>
Subject: [PATCH 01/18] autofs: Fix typos in
 Documentation/filesystems/autofs4.txt
Date: Fri, 12 Aug 2016 10:47:34 +0800
Message-ID: <20160812024734.12352.17122.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=md+
	dLMpDClfCxD58O48zPH7Thjo=; b=MgVEEj9lv9i28HyDCxt7dsDDJbXYiRvUeIT
	5NQR0ZlzBnT4mnXx4lm/AWaOQMUhQGboUrz5wcjgQZk/hDiZvQZwGPU3eJpY9kEe
	DRGG/T83N5d1RIyihm9L9z/1ek/ze7T4/7A3Mm7A/l+8GHZTsnOkALO1yCnTxmEM
	iUj10k/I=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=md+dLMpDClfCxD58O48zPH7Thjo=; b=Gfisp
	cUrPH8lyF2El3HLrWGDQWNPBfqe8WEs7Ij2YY1XM44GLbHdr81RqrESlix6iOW8G
	E2s1jyhGiKhfy41bYWp1syOZGf0hXE/1arFrNbxaPYyInGCsIu5fxk8V6Q8jqSHZ
	9yMVEZXFAkwySu36AKRieGQGaekIdrni3peQyk=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

plus minor whitespace fixes.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 Documentation/filesystems/autofs4.txt |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/autofs4.txt b/Documentation/filesystems/autofs4.txt
index 39d02e1..8fac3fe 100644
--- a/Documentation/filesystems/autofs4.txt
+++ b/Documentation/filesystems/autofs4.txt
@@ -203,9 +203,9 @@ initiated or is being considered, otherwise it returns 0.
 Mountpoint expiry
 -----------------
 
-The VFS has a mechansim for automatically expiring unused mounts,
+The VFS has a mechanism for automatically expiring unused mounts,
 much as it can expire any unused dentry information from the dcache.
-This is guided by the MNT_SHRINKABLE flag.  This  only applies to
+This is guided by the MNT_SHRINKABLE flag.  This only applies to
 mounts that were created by `d_automount()` returning a filesystem to be
 mounted.  As autofs doesn't return such a filesystem but leaves the
 mounting to the automount daemon, it must involve the automount daemon
@@ -298,7 +298,7 @@ remove directories and symlinks using normal filesystem operations.
 autofs knows whether a process requesting some operation is the daemon
 or not based on its process-group id number (see getpgid(1)).
 
-When an autofs filesystem it mounted the pgid of the mounting
+When an autofs filesystem is mounted the pgid of the mounting
 processes is recorded unless the "pgrp=" option is given, in which
 case that number is recorded instead.  Any request arriving from a
 process in that process group is considered to come from the daemon.
@@ -450,7 +450,7 @@ Commands are:
     numbers for existing filesystems can be found in
     `/proc/self/mountinfo`.
 - **AUTOFS_DEV_IOCTL_CLOSEMOUNT_CMD**: same as `close(ioctlfd)`.
-- **AUTOFS_DEV_IOCTL_SETPIPEFD_CMD**: if the  filesystem is in
+- **AUTOFS_DEV_IOCTL_SETPIPEFD_CMD**: if the filesystem is in
     catatonic mode, this can provide the write end of a new pipe
     in `arg1` to re-establish communication with a daemon.  The
     process group of the calling process is used to identify the

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
