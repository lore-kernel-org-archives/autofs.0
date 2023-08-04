From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/2] autofs: use wake_up() instead of wake_up_interruptible(()
Date: Fri, 04 Aug 2023 13:33:18 +0800
Message-ID: <169112719813.7590.4971499386839952992.stgit@donald.themaw.net>
References: <169112719161.7590.6700123246297365841.stgit@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <169112719161.7590.6700123246297365841.stgit@donald.themaw.net>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Al Viro <viro@ZenIV.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Fedor Pchelkin <pchelkin@ispras.ru>, Takeshi Misawa <jeliantsurux@gmail.com>, Alexey Khoroshilov <khoroshilov@ispras.ru>, Matthew Wilcox <willy@infradead.org>, Andrey Vagin <avagin@openvz.org>

In autofs_wait_release() wake_up() is used to wake up processes waiting
on a mount callback to complete which matches the wait_event_killable()
in autofs_wait().

But in autofs_catatonic_mode() the wake_up_interruptible() was not also
changed at the time autofs_wait_release() was changed.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/waitq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs/waitq.c b/fs/autofs/waitq.c
index efdc76732fae..33dd4660d82f 100644
--- a/fs/autofs/waitq.c
+++ b/fs/autofs/waitq.c
@@ -32,7 +32,7 @@ void autofs_catatonic_mode(struct autofs_sb_info *sbi)
 		wq->status = -ENOENT; /* Magic is gone - report failure */
 		kfree(wq->name.name - wq->offset);
 		wq->name.name = NULL;
-		wake_up_interruptible(&wq->queue);
+		wake_up(&wq->queue);
 		if (!--wq->wait_ctr)
 			kfree(wq);
 		wq = nwq;


