From: "J. R. Okajima" <hooanon05@yahoo.co.jp>
Subject: Re: [autofs] [PATCH 04/38] autofs4: Save autofs trigger's vfsmount in super block info
Date: Tue, 22 Jun 2010 14:49:16 +0900
Message-ID: <26799.1277185756@jrobl>
References: <1276627208-17242-1-git-send-email-vaurora@redhat.com> <1276627208-17242-5-git-send-email-vaurora@redhat.com> <1276661043.2339.35.camel@localhost> <1277091579.3827.9.camel@localhost> <E1OQghj-0001Bt-RU@pomaz-ex.szeredi.hu> <1277181999.2829.2.camel@localhost>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1277181999.2829.2.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Miklos Szeredi <miklos@szeredi.hu>, viro@zeniv.linux.org.uk, vaurora@redhat.com, autofs@linux.kernel.org, linux-kernel@vger.kernel.org, hch@infradead.org, linux-fsdevel@vger.kernel.org, jblunck@suse.de


Ian Kent:
> +static vfsmount *autofs4_find_vfsmount(struct path *parent, struct dentry *root)
> +{
> +	struct vfsmount *mnt = NULL;
> +	struct dentry *child;
> +
> +	spin_lock(&dcache_lock);
> +	list_for_each_entry(child, &dentry->d_subdirs, d_u.d_child) {

dentry->d_subdirs?
parent->dentry->...?

Or how about iterate_mounts() instead of loop over dentries?
For example (just a example),

struct args {
	/* input */
	struct dentry *root;

	/* output */
	struct vfsmount *mnt;
};

static int compare_mnt(struct vfsmount *mnt, void *arg)
{
	struct args *a = arg;

	if (mnt->mnt_root != a->root)
		return 0;
	a->mnt = mntget(mnt);
	return 1;
}

struct vfsmount *autofs4_find_vfsmount(struct dentry *root)
{
	int err;
	struct args args = {
		.root = root
	};

	err = iterate_mounts(compare_mnt, &args, current->nsproxy->mnt_ns);
}


J. R. Okajima
