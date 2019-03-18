From: Ian Kent <raven@themaw.net>
Subject: [PATCH 3/5] autofs - update AUTOFS_EXP_LEAVES description
Date: Mon, 18 Mar 2019 09:00:35 +0800
Message-ID: <155287083538.12593.18163159677020718048.stgit@pluto.themaw.net>
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

Update the description of AUTOFS_EXP_LEAVES to cover its possible
future use with amd format mount maps.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 Documentation/filesystems/autofs.txt |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/autofs.txt b/Documentation/filesystems/autofs.txt
index ac50b47f02bd..8fe43c97cb96 100644
--- a/Documentation/filesystems/autofs.txt
+++ b/Documentation/filesystems/autofs.txt
@@ -262,8 +262,12 @@ up.
 
 There is an option with indirect mounts to consider each of the leaves
 that has been mounted on instead of considering the top-level names.
-This is intended for compatibility with version 4 of autofs and should
-be considered as deprecated.
+This was originally intended for compatibility with version 4 of autofs
+and should be considered as deprecated for Sun Format automount maps.
+However, it may be used again for amd format mount maps (which are
+generally indirect maps) because the amd automounter allows for the
+setting of an expire timeout for individual mounts. But there are
+some difficulties in making the needed changes for this.
 
 When autofs considers a directory it checks the `last_used` time and
 compares it with the "timeout" value set when the filesystem was

