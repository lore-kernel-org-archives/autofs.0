From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/5] autofs - update autofs.txt for strictexpire mount option
Date: Mon, 18 Mar 2019 09:00:30 +0800
Message-ID: <155287083000.12593.2722713092537666885.stgit@pluto.themaw.net>
References: <155287082394.12593.6506084453911662450.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <155287082394.12593.6506084453911662450.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

A "strictexpire" mount option has been added to the autofs file
system.

It is meant to be used in cases where a GUI continually accesses
or an application frquently scans an automount directory tree
causing an accumulation of otherwise unused mounts.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 Documentation/filesystems/autofs.txt |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/autofs.txt b/Documentation/filesystems/autofs.txt
index 05da806b1e88..ac50b47f02bd 100644
--- a/Documentation/filesystems/autofs.txt
+++ b/Documentation/filesystems/autofs.txt
@@ -240,11 +240,18 @@ Normally the daemon only wants to remove entries which haven't been
 used for a while.  For this purpose autofs maintains a "`last_used`"
 time stamp on each directory or symlink.  For symlinks it genuinely
 does record the last time the symlink was "used" or followed to find
-out where it points to.  For directories the field is a slight
-misnomer.  It actually records the last time that autofs checked if
-the directory or one of its descendants was busy and found that it
-was.  This is just as useful and doesn't require updating the field so
-often.
+out where it points to.  For directories the field is used slightly
+differently.  The field is updated at mount time and during expire
+checks if it is found to be in use (ie. open file descriptor or
+process working directory) and during path walks. The update done
+during path walks prevents frequent expire and immediate mount of
+frequently accessed automounts. But in the case where a GUI continually
+access or an application frequently scans an autofs directory tree
+there can be an accumulation of mounts that aren't actually being
+used. To cater for this case the "`strictexpire`" autofs mount option
+can be used to avoid the "`last_used`" update on path walk thereby
+preventing this apparent inability to expire mounts that aren't
+really in use.
 
 The daemon is able to ask autofs if anything is due to be expired,
 using an `ioctl` as discussed later.  For a *direct* mount, autofs

