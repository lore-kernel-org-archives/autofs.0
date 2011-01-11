From: David Howells <dhowells@redhat.com>
Subject: [PATCH 17/18] autofs4: Bump version
Date: Tue, 11 Jan 2011 17:49:40 +0000
Message-ID: <20110111174940.2291.87406.stgit@warthog.procyon.org.uk>
References: <20110111174809.2291.52242.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20110111174809.2291.52242.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: npiggin@kernel.dk, viro@zeniv.linux.org.uk, raven@themaw.net
Cc: dhowells@redhat.com, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

From: Ian Kent <raven@themaw.net>

Increase the autofs module sub-version so we can tell what kernel
implementation is being used from user space debug logging.

Signed-off-by: Ian Kent <raven@themaw.net>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/auto_fs4.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/auto_fs4.h b/include/linux/auto_fs4.h
index 8b49ac4..e02982f 100644
--- a/include/linux/auto_fs4.h
+++ b/include/linux/auto_fs4.h
@@ -24,7 +24,7 @@
 #define AUTOFS_MIN_PROTO_VERSION	3
 #define AUTOFS_MAX_PROTO_VERSION	5
 
-#define AUTOFS_PROTO_SUBVERSION		1
+#define AUTOFS_PROTO_SUBVERSION		2
 
 /* Mask for expire behaviour */
 #define AUTOFS_EXP_IMMEDIATE		1

