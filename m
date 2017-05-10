From: Ian Kent <raven@themaw.net>
Subject: [PATCH 1/3] autofs - make disc device user accessible
Date: Wed, 10 May 2017 12:18:38 +0800
Message-ID: <149438991819.26550.11290804420751932707.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:message-id
        :mime-version:subject:to:x-me-sender:x-me-sender:x-sasl-enc
        :x-sasl-enc; s=fm1; bh=SxaeToHrRQ3IUdzNG0yqtc+BaiBWrHEQb2HhD17T/
        FA=; b=d7TqmR6RoDxwWo5Zz11jdkNeyIHyGOHz3h2kDGFyYkOBfH3XCDDEeNE7H
        zYKsE/8bfp/75AmdabSrFbNzGrba/uZ0Q9EDcncjAZxRdFZ12ekupwlut7pSE82i
        pb1p0hSRbbpaASS8Cp6NaI0OqOVjzDmzzauApM2IQu4hKR8OFbhnNq9RXKdwzjoP
        /ApqNh3dZ2u3WPZ1jb0jzSmJykiknEqC4yHOL27NrTIJjubBB3De9BYpnXd16WA3
        pPuAkNYM+uDWQe+4LJZkjJ0VxBkx7SEnmnPI/ZgUqjG+aGYH/RdTj6K9zD2EpUxi
        AEP5pQixbCj+nKoDD6smgoDDgnGrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=SxaeToHrRQ3IUdzNG0
        yqtc+BaiBWrHEQb2HhD17T/FA=; b=Ij7g4V2rXxgKIwfeF91Y41xed2uhHD5XML
        SO6kb/5K80HE5bazSRE4hlyLbwc/xk5bs9llAyEhTYRyj4Er702liwkFI1g+TpN8
        RHh61XoqpgaD+0Ta1GAcd0Eo1at4VML7yIRH0VKopdDd2EgwMmhRHpE2teodY3eo
        tT7AymnCg7GJx+fC7QWLg7SSSwPO/JSITNiQ1jlY566eFVxv8HNHpTcozlS8MQA/
        BJtR/jToEs2AsYfPajJNs7fxX7Jf2ZIdHocq8q7G7oZ/WpvQX1owgU92GVDpKmKN
        VVakCPF2RqdgSu97QMB0ymJqKoqFRVo88nevGJHlyBNJthpJjMcw==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Colin Walters <walters@redhat.com>, Ondrej Holy <oholy@redhat.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

The autofs miscellanous device ioctls that shouldn't require
CAP_SYS_ADMIN need to be accessible to user space applications in
order to be able to get information about autofs mounts.

The module checks capabilities so the miscelaneous device should
be fine with broad permissions.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Colin Walters <walters@redhat.com>
Cc: Ondrej Holy <oholy@redhat.com>
Cc: stable@vger.kernel.org
---
 fs/autofs4/dev-ioctl.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index 734cbf8..9b58d6e 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -733,7 +733,8 @@ static const struct file_operations _dev_ioctl_fops = {
 static struct miscdevice _autofs_dev_ioctl_misc = {
 	.minor		= AUTOFS_MINOR,
 	.name		= AUTOFS_DEVICE_NAME,
-	.fops		= &_dev_ioctl_fops
+	.fops		= &_dev_ioctl_fops,
+	.mode           = 0666
 };
 
 MODULE_ALIAS_MISCDEV(AUTOFS_MINOR);

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
