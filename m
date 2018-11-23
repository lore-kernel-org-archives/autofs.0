From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/5] autofs - improve ioctl sbi checks
Date: Fri, 23 Nov 2018 15:29:22 -0800
Message-ID: <20181123152922.de3ed41c5b97ac84eaa22846@linux-foundation.org>
References: <154296962626.9889.644199825100770992.stgit@pluto-themaw-net>
        <154296970987.9889.1597442413573683096.stgit@pluto-themaw-net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154296970987.9889.1597442413573683096.stgit@pluto-themaw-net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, 23 Nov 2018 18:41:50 +0800 Ian Kent <raven@themaw.net> wrote:

> Al Viro made some suggestions to improve the implementation
> of commit 0633da48f0 "fix autofs_sbi() does not check super
> block type".
> 
> The check is unnessesary in all cases except for ioctl usage
> so placing the check in the super block accessor function
> adds a small overhead to the common case where it isn't
> needed.
> 
> So it's sufficient to do this in the ioctl code only.
> 
> Also the check in the ioctl code is needlessly complex.
>
> ...
>
> --- a/fs/autofs/dev-ioctl.c
> +++ b/fs/autofs/dev-ioctl.c
> @@ -14,6 +14,8 @@
>  
>  #include "autofs_i.h"
>  
> +extern struct file_system_type autofs_fs_type;
> +
>  /*
>   * This module implements an interface for routing autofs ioctl control
>   * commands via a miscellaneous device file.

It's naughty to declare externs in C files, for various reasons.  Is
this OK?

--- a/fs/autofs/autofs_i.h~autofs-improve-ioctl-sbi-checks-fix
+++ a/fs/autofs/autofs_i.h
@@ -42,6 +42,8 @@
 #endif
 #define pr_fmt(fmt) KBUILD_MODNAME ":pid:%d:%s: " fmt, current->pid, __func__
 
+extern struct file_system_type autofs_fs_type;
+
 /*
  * Unified info structure.  This is pointed to by both the dentry and
  * inode structures.  Each file in the filesystem has an instance of this
--- a/fs/autofs/dev-ioctl.c~autofs-improve-ioctl-sbi-checks-fix
+++ a/fs/autofs/dev-ioctl.c
@@ -14,8 +14,6 @@
 
 #include "autofs_i.h"
 
-extern struct file_system_type autofs_fs_type;
-
 /*
  * This module implements an interface for routing autofs ioctl control
  * commands via a miscellaneous device file.
_

