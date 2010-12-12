From: Jesper Juhl <jj@chaosbits.net>
Subject: [PATCH][RFC] autofs4: Do not potentially dereference null pointer
 returned by fget() in autofs_dev_ioctl_setpipefd()
Date: Mon, 13 Dec 2010 00:02:55 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1012122357570.9206@swampdragon.chaosbits.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org
Cc: linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>

Hi,

In fs/autofs4/dev-ioctl.c::autofs_dev_ioctl_setpipefd() we call fget(), 
which may return NULL, but we do not explicitly test for that NULL return 
so we may end up dereferencing a NULL pointer - bad.

A comment in fget() says "File object ref couldn't be taken" when that 
function returns NULL, so I guess EBUSY is the proper error to return from 
autofs_dev_ioctl_setpipefd() when this happens, but I'm far from sure 
about this, so I'd like some feedback before this patch is merged.


Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 dev-ioctl.c |    4 ++++
 1 file changed, 4 insertions(+)

 compile tested only.

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index eff9a41..ab551ee 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -372,6 +372,10 @@ static int autofs_dev_ioctl_setpipefd(struct file *fp,
 		return -EBUSY;
 	} else {
 		struct file *pipe = fget(pipefd);
+		if (!pipe) {
+			err = -EBUSY;
+			goto out;
+		}
 		if (!pipe->f_op || !pipe->f_op->write) {
 			err = -EPIPE;
 			fput(pipe);



-- 
Jesper Juhl <jj@chaosbits.net>            http://www.chaosbits.net/
Don't top-post http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please.
