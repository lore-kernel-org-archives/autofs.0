From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 1/3] autofs4 - fix device ioctl mount lookup
Date: Wed, 4 Sep 2013 02:03:02 +0100
Message-ID: <20130904010301.GE13318@ZenIV.linux.org.uk>
References: <20130904005456.5025.94309.stgit@perseus.fritz.box>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130904005456.5025.94309.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, rui.xiang@huawei.com, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Sep 04, 2013 at 08:54:57AM +0800, Ian Kent wrote:
> +static int kern_path_top(const char *pathname,
> +			 unsigned int flags, struct path *path)
> +{
> +	struct dentry *dentry;
> +	struct qstr name;
> +	const char *tmp;
> +	unsigned int len;
> +	int err;
> +
> +	len = strlen(pathname);
> +	if (len <= 1)
> +		return -EINVAL;
> +
> +	tmp = pathname + len - 1;
> +	len = 0;
> +	if (*tmp == '/')
> +		tmp--;
> +	do {
> +		if (*tmp == '/')
> +			break;
> +		len++;
> +	} while (--tmp >= pathname);
> +	tmp++;
> +
> +	err = kern_path(pathname, flags | LOOKUP_PARENT, path);
> +	if (err)
> +		return err;
> +
> +	name.name = tmp;
> +	name.len = len;
> +	name.hash = full_name_hash(tmp, len);
> +
> +	dentry = d_lookup(path->dentry, &name);
> +	if (!dentry) {
> +		path_put(path);
> +		return -ENOENT;
> +	}
> +	dput(path->dentry);
> +	path->dentry = dentry;
> +
> +	while (follow_down_one(path))
> +		;
> +
> +	return 0;
> +}

Ewwww...   NAK in that form.  Just what will happen if the last component
given to that sucker will be . or .., for starters?  Or a symlink, with
'/' added to it to force following the damn thing?
