From: Ian Kent <raven@themaw.net>
Subject: [PATCH 4/8] autofs: reformat 0pt enum declaration
Date: Thu, 21 Sep 2023 15:03:51 +0800
Message-ID: <169527983132.27328.10535655381168506781.stgit@donald.themaw.net>
References: <169527971702.27328.16272807830250040704.stgit@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <169527971702.27328.16272807830250040704.stgit@donald.themaw.net>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Al Viro <viro@ZenIV.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Bill O'Donnell <billodo@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, David Howells <dhowells@redhat.com>

The enum of options is only reformated in the patch to convert autofs
to use the mount API so do that now to simplify the conversion patch.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/inode.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 992d6cb29707..d2b333c0682a 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -110,9 +110,20 @@ static const struct super_operations autofs_sops = {
 	.evict_inode	= autofs_evict_inode,
 };
 
-enum {Opt_err, Opt_fd, Opt_uid, Opt_gid, Opt_pgrp, Opt_minproto, Opt_maxproto,
-	Opt_indirect, Opt_direct, Opt_offset, Opt_strictexpire,
-	Opt_ignore};
+enum {
+	Opt_err,
+	Opt_direct,
+	Opt_fd,
+	Opt_gid,
+	Opt_ignore,
+	Opt_indirect,
+	Opt_maxproto,
+	Opt_minproto,
+	Opt_offset,
+	Opt_pgrp,
+	Opt_strictexpire,
+	Opt_uid,
+};
 
 static const match_table_t tokens = {
 	{Opt_fd, "fd=%u"},


