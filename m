From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs4: reinstate negatitive timeout of mount fails
Date: Wed, 22 Aug 2007 17:55:03 +0800
Message-ID: <1187776503.3899.16.camel@raven.themaw.net>
References: <1187688369.3318.12.camel@raven.themaw.net>
	 <46CAF484.80501@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758580AbXHVJz0@vger.kernel.org>
In-Reply-To: <46CAF484.80501@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ndrew Morton <akpm@linux-foundation.org>, Peter Staubach <staubach@redhat.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>

On Tue, 2007-08-21 at 10:19 -0400, Peter Staubach wrote:
> Ian Kent wrote:
> > Hi,
> >
> > Due to a change to fs/dcache.c:d_lookup() in the 2.6 kernel whereby only
> > hashed dentrys are returned the negative caching of mount failures
> > stopped working in the autofs4 module for nobrowse mount (ie. directory
> > created at mount time and removed at umount or following a mount
> > failure).
> >
> > This patch keeps track of the dentrys from mount fails in order to be
> > able check the timeout since the last fail and return the appropriate
> > status. In addition the timeout value is settable at load time as a
> > module option and via sysfs using the module
> > parameter /sys/module/autofs4/parameters/negative_timeout.
> >
> > Signed-off-by: Ian Kent <raven@themaw.net>
> >
> > ---
> > --- linux-2.6.23-rc2-mm2/fs/autofs4/init.c.negative-timeout	2007-07-09 07:32:17.000000000 +0800
> > +++ linux-2.6.23-rc2-mm2/fs/autofs4/init.c	2007-08-21 15:44:34.000000000 +0800
> > @@ -14,6 +14,10 @@
> >  #include <linux/init.h>
> >  #include "autofs_i.h"
> >  
> > +unsigned int negative_timeout = AUTOFS_NEGATIVE_TIMEOUT;
> > +module_param(negative_timeout, uint, S_IRUGO | S_IWUSR);
> > +MODULE_PARM_DESC(negative_timeout, "Cache mount fails negatively for this many seconds");
> > +
> >  static int autofs_get_sb(struct file_system_type *fs_type,
> >  	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
> >  {
> > --- linux-2.6.23-rc2-mm2/fs/autofs4/inode.c.negative-timeout	2007-08-17 11:52:33.000000000 +0800
> > +++ linux-2.6.23-rc2-mm2/fs/autofs4/inode.c	2007-08-21 15:44:34.000000000 +0800
> > @@ -46,6 +46,7 @@ struct autofs_info *autofs4_init_ino(str
> >  	ino->inode = NULL;
> >  	ino->dentry = NULL;
> >  	ino->size = 0;
> > +	ino->negative_timeout = negative_timeout;
> >  
> >  	INIT_LIST_HEAD(&ino->rehash);
> >  
> > @@ -98,11 +99,24 @@ void autofs4_free_ino(struct autofs_info
> >  static void autofs4_force_release(struct autofs_sb_info *sbi)
> >  {
> >  	struct dentry *this_parent = sbi->sb->s_root;
> > -	struct list_head *next;
> > +	struct list_head *p, *next;
> >  
> >  	if (!sbi->sb->s_root)
> >  		return;
> >  
> > +	/* Cleanup the negative dentry cache */
> > +	spin_lock(&sbi->rehash_lock);
> > +	list_for_each_safe(p, next, &sbi->rehash_list) {
> > +		struct autofs_info *ino;
> > +		struct dentry *dentry;
> > +		ino = list_entry(p, struct autofs_info, rehash);
> > +		dentry = ino->dentry;
> > +		spin_unlock(&sbi->rehash_lock);
> > +		dput(ino->dentry);
> >   
> 
> Should this be dput(dentry);?

Addressed in this simple (first) cleanup patch.

Thanks
Ian

---
--- linux-2.6.23-rc2-mm2/fs/autofs4/inode.c.negative-timeout-cleanup	2007-08-22 17:46:33.000000000 +0800
+++ linux-2.6.23-rc2-mm2/fs/autofs4/inode.c	2007-08-22 17:47:02.000000000 +0800
@@ -110,7 +110,6 @@ static void autofs4_force_release(struct
 		struct autofs_info *ino;
 		struct dentry *dentry;
 		ino = list_entry(p, struct autofs_info, rehash);
-		dentry = ino->dentry;
 		spin_unlock(&sbi->rehash_lock);
 		dput(ino->dentry);
 		spin_lock(&sbi->rehash_lock);


