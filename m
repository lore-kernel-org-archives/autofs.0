From: Ian Kent <raven@themaw.net>
Subject: Re: 2.6 patches broken with 2.6.4
Date: Fri, 12 Mar 2004 11:13:53 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403121113001.10273@wombat.indigo.net.au>
References: <Pine.LNX.4.44.0312022129550.2970-100000@raven.themaw.net>
	<Pine.LNX.4.58.0403120910270.7863@wombat.indigo.net.au>
	<405120F3.3060305@yahoo.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <405120F3.3060305@yahoo.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Macdonald <alexandermacdonald@yahoo.com>
Cc: autofs@linux.kernel.org

On Fri, 12 Mar 2004, Alexander Macdonald wrote:

> Ian Kent wrote:
> > Thanks for the feedback. How long and in what environment have you been 
> > using them.
> 
> 
> Well admittedly my testing has been with only a few pc's each with about 4-5 
> shares, none of them SMP boxes. So not at all thorough or stressful compared to 
> what some people on the list are using it for.
> 

Better than nothing.

Try this patch for 2.6.4

--- linux-2.6.4.orig/fs/autofs4/inode.c	Thu Mar 11 10:55:37 2004
+++ linux-2.6.4/fs/autofs4/inode.c	Fri Mar 12 10:54:23 2004
@@ -187,6 +187,7 @@
 	struct file * pipe;
 	int pipefd;
 	struct autofs_sb_info *sbi;
+	struct autofs_info *ino;
 	int minproto, maxproto;
 
 	sbi = (struct autofs_sb_info *) kmalloc(sizeof(*sbi), GFP_KERNEL);
@@ -212,7 +213,11 @@
 	/*
 	 * Get the root inode and dentry, but defer checking for errors.
 	 */
-	root_inode = autofs4_get_inode(s, autofs4_mkroot(sbi));
+	ino = autofs4_mkroot(sbi);
+	if (!ino)
+		goto fail_free;
+	root_inode = autofs4_get_inode(s, ino);
+	kfree(ino);
 	if (!root_inode)
 		goto fail_free;
