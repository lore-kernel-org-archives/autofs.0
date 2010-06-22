From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] [PATCH 04/38] autofs4: Save autofs trigger's vfsmount
 in super block info
Date: Tue, 22 Jun 2010 21:11:23 +0800
Message-ID: <1277212283.2829.9.camel@localhost>
References: <1276627208-17242-1-git-send-email-vaurora@redhat.com>
	 <1276627208-17242-5-git-send-email-vaurora@redhat.com>
	 <1276661043.2339.35.camel@localhost> <1277091579.3827.9.camel@localhost>
	 <E1OQghj-0001Bt-RU@pomaz-ex.szeredi.hu> <1277181999.2829.2.camel@localhost>
	 <26799.1277185756@jrobl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding; s=smtpout; bh=Gq0hQPMOi4uWiLS55tCaotdbWEI=; b=BT2EP8qgq9LoYSZmmFtZdWGJtES94nQ0skFdFcfXfn3oG78FnIG1jAw5mr7uwSktTRqwyTUoGQcmZRbzblq7qbugGAbOG5fXqiimO+LnTKW+xjEtxO8NEoxrgQa9MjdPfsXY104pG49NJpF4+pW9iNK3Q4BC8Ccyms9TYDAxq98=
In-Reply-To: <26799.1277185756@jrobl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "J. R. Okajima" <hooanon05@yahoo.co.jp>
Cc: Miklos Szeredi <miklos@szeredi.hu>, viro@zeniv.linux.org.uk, vaurora@redhat.com, autofs@linux.kernel.org, linux-kernel@vger.kernel.org, hch@infradead.org, linux-fsdevel@vger.kernel.org, jblunck@suse.de

On Tue, 2010-06-22 at 14:49 +0900, J. R. Okajima wrote:
> Ian Kent:
> > +static vfsmount *autofs4_find_vfsmount(struct path *parent, struct dentry *root)
> > +{
> > +	struct vfsmount *mnt = NULL;
> > +	struct dentry *child;
> > +
> > +	spin_lock(&dcache_lock);
> > +	list_for_each_entry(child, &dentry->d_subdirs, d_u.d_child) {
> 
> dentry->d_subdirs?
> parent->dentry->...?

Yep, thanks, cut and paste error.

Like I said, I don't want to go though the test process unless I have
something that is, in principal, OK.

If whatever approach we use is acceptable, and will work, then I'll put
the effort into it. I just don' want to spend a heap of time on
something that is basically not the right thing to do. For example,
exporting lookup_mnt?

> 
> Or how about iterate_mounts() instead of loop over dentries?
> For example (just a example),
> 
> struct args {
> 	/* input */
> 	struct dentry *root;
> 
> 	/* output */
> 	struct vfsmount *mnt;
> };
> 
> static int compare_mnt(struct vfsmount *mnt, void *arg)
> {
> 	struct args *a = arg;
> 
> 	if (mnt->mnt_root != a->root)
> 		return 0;
> 	a->mnt = mntget(mnt);
> 	return 1;
> }
> 
> struct vfsmount *autofs4_find_vfsmount(struct dentry *root)
> {
> 	int err;
> 	struct args args = {
> 		.root = root
> 	};
> 
> 	err = iterate_mounts(compare_mnt, &args, current->nsproxy->mnt_ns);
> }

Oh, I'm not up with this, I'll have to check this out, might be useful
for more than just this case, thanks for the comments.

Ian

