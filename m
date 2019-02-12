From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs: clear O_NONBLOCK on the pipe.
Date: Tue, 12 Feb 2019 09:38:29 +0800
Message-ID: <154993550902.3321.1183632970046073478.stgit@pluto-themaw-net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, NeilBrown <neilb@suse.com>

From: NeilBrown <neilb@suse.com>

autofs does not expect the pipe it is given
to have O_NONBLOCK set - specifically if __kernel_write()
in autofs_write() returns -EAGAIN, this is treated
as a fatal error and the pipe is closed.

For safety autofs should, therefore, clear the O_NONBLOCK flag.

Releases of systemd prior to 8th February 2019 used
  pipe2(p, O_NONBLOCK|O_CLOEXEC)
and thus (inadvertently) set this flag.

Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/autofs_i.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index b735f2b1e462..70c132acdab1 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -216,6 +216,8 @@ static inline int autofs_prepare_pipe(struct file *pipe)
 		return -EINVAL;
 	/* We want a packet pipe */
 	pipe->f_flags |= O_DIRECT;
+	/* We don't expect -EAGAIN */
+	pipe->f_flags &= ~O_NONBLOCK;
 	return 0;
 }
 

