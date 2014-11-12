From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/3] autofs - fix log print messages
Date: Wed, 12 Nov 2014 15:07:00 -0800
Message-ID: <20141112150700.bbb0d82dad1b133fccc1a0ec@linux-foundation.org>
References: <20141111012954.25773.4002.stgit@perseus.themaw.net>
	<1415676341.16070.0.camel@perches.com>
	<1415684245.2486.9.camel@perseus.themaw.net>
	<1415684989.16070.2.camel@perches.com>
	<1415685712.2486.17.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1415685712.2486.17.camel@perseus.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: Joe Perches <joe@perches.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, 11 Nov 2014 14:01:52 +0800 Ian Kent <raven@themaw.net> wrote:

> I guess I could make a kernel.org tree but, apart from this recent
> rename autofs4 -> autofs, the number of autofs changes hasn't warranted
> maintaining a separate tree for quite a while.
> 
> It looks like the place holder under /pub/scm/linux/kernel/git/raven is
> no longer present so I expect I'd need to request that be setup.
> 
> That's why I just send my patches to Andrew to include them in -next.
> 
> Andrew, thoughts?

Various options.

a) redo these patches against mainline and I merge them into
   3.19-rc1.  Shortly after that you send me the big rename as plain
   old patches or, preferably, you send Linus a git pull request.  For
   -rc2.

b) You run a git tree for a while.

The tree which these patches were based on seem to have more than a
plain rename.  For example I get

--- fs/autofs4/autofs_i.h
+++ fs/autofs4/autofs_i.h
@@ -37,15 +37,15 @@
 /* #define DEBUG */
 
 #define DPRINTK(fmt, ...)				\
-	pr_debug("pid %d: %s: " fmt "\n",		\
+	pr_debug(KBUILD_MODNAME ":pid:%d:%s: " fmt "\n",\
 		current->pid, __func__, ##__VA_ARGS__)
 
 #define AUTOFS_WARN(fmt, ...)				\
-	pr_warn("pid %d: %s: " fmt "\n",	\
+	pr_warn(KBUILD_MODNAME ":pid:%d:%s: " fmt "\n",	\
 		current->pid, __func__, ##__VA_ARGS__)
 
 #define AUTOFS_ERROR(fmt, ...)				\
-	pr_err("pid %d: %s: " fmt "\n",	\
+	pr_err(KBUILD_MODNAME ":pid:%d:%s: " fmt "\n",	\
 		current->pid, __func__, ##__VA_ARGS__)
 
 /*


But I'm seeing

#define DPRINTK(fmt, ...)				\
	pr_debug("pid %d: %s: " fmt "\n",		\
		current->pid, __func__, ##__VA_ARGS__)

#define AUTOFS_WARN(fmt, ...)				\
	printk(KERN_WARNING "pid %d: %s: " fmt "\n",	\
		current->pid, __func__, ##__VA_ARGS__)

#define AUTOFS_ERROR(fmt, ...)				\
	printk(KERN_ERR "pid %d: %s: " fmt "\n",	\
		current->pid, __func__, ##__VA_ARGS__)

/* Unified info structure.  This is pointed to by both the dentry and

ie: the comment layout was changed.
