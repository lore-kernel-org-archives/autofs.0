From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/3] autofs - make disc device user accessible
Date: Tue, 08 Aug 2017 12:26:59 +0800
Message-ID: <150216641928.11652.7388977863125547969.stgit@pluto.themaw.net>
References: <150216641255.11652.4204561328197919771.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150216641255.11652.4204561328197919771.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Ondrej Holy <oholy@redhat.com>, Colin Walters <walters@redhat.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

The autofs miscellanous device ioctls that shouldn't require
CAP_SYS_ADMIN need to be accessible to user space applications in
order to be able to get information about autofs mounts.

The module checks capabilities so the miscelaneous device should
be fine with broad permissions.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Colin Walters <walters@redhat.com>
Cc: Ondrej Holy <oholy@redhat.com>
---
 fs/autofs4/dev-ioctl.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index dd9f1bebb5a3..218a4ecc75cc 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -733,7 +733,8 @@ static const struct file_operations _dev_ioctl_fops = {
 static struct miscdevice _autofs_dev_ioctl_misc = {
 	.minor		= AUTOFS_MINOR,
 	.name		= AUTOFS_DEVICE_NAME,
-	.fops		= &_dev_ioctl_fops
+	.fops		= &_dev_ioctl_fops,
+	.mode           = 0644,
 };
 
 MODULE_ALIAS_MISCDEV(AUTOFS_MINOR);

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
